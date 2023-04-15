# reset node list
# $global:nodelist = [System.Collections.Generic.List[PSObject]]::new()

function node {
    param(
    $name,
    $parent,
    $child
    )

# hax with a global variable 

if ($global:nodelist) {
    # already exists
    }
    else {
    # create otherwise
    $global:nodelist = [System.Collections.Generic.List[PSObject]]::new()
    }


#newobject or existsing one

if ($object = $nodelist.Where({$_.Name -eq $name})){
    Write-Verbose "Found node with name $name"
    # nothing to do
    }
else {

$object = [pscustomobject]@{
    name = $name

    rel = @{
        parentList = [System.Collections.Generic.List[PSObject]]::new()
        childList = [System.Collections.Generic.List[PSObject]]::new()
        }
    #id = '{0}{1}' -f (get-date -UFormat %s),(Get-random)
    id = new-guid
    }

    $scriptPropertySplat = @{
        InputObject = $object
        MemberType  = 'ScriptProperty'
        Force       = $true
    }

    $scriptMethodSplat = @{
        InputObject = $object
        MemberType  = 'ScriptMethod'
        Force       = $true
    }

    $notePropertySplat = @{
        InputObject = $object
        MemberType  = 'NoteProperty'
        Force       = $true
    }

    Add-Member @scriptMethodSplat -Name ChildM  -Value {
        $this.rel.childlist.name
        } 

    Add-Member @scriptPropertySplat  -Name Child            -Value {
        $this.ChildM()
        }

    Add-Member @scriptMethodSplat -Name ParentM  -Value {
        $this.rel.Parentlist.name
        } 

    Add-Member @scriptPropertySplat  -Name Parent            -Value {
        $this.ParentM()
        }

    Add-Member @scriptMethodSplat -Name AddChild  -Value {
    param (
        $hereChild
        )
        $this.rel.Childlist.Add($hereChild)
        $hereChild.rel.parentlist.add($this)
        } 
    
    $nodelist.Add($object)
} # newobject
    
if ($parent) {
    Write-Verbose "? node $name searching for parents: $($parent.count)"
    foreach ($d in $parent) {

        # seach node list
        if ($d.gettype().Name -eq 'string') {
            Write-Verbose " ? node $name, searching for parent node with string $parent"
            $d = $nodelist.Where({$_.Name -eq $d})
            }

        # node exists
        if ($d.rel) {
            Write-Verbose " !  node $name, got rel with name $($d.name)"
            $object.rel.parentlist.add($d)
            $d.rel.childlist.add($object)
            }
        # or not exists
        else {
            Write-Verbose " N create node $parent with parent $name"
            node -name $parent -parent $name

            }
    }
}

if ($child) {
    Write-Verbose "? node $name searching for child: $($child.count)"
    foreach ($d in $child) {

        # seach node list
        if ($d.gettype().Name -eq 'string') {
            Write-Verbose " ? node $name, searching for child node with string $parent"
            $d = $nodelist.Where({$_.Name -eq $d})
            }

        # node exists
        if ($d.rel) {
            Write-Verbose " !  node $name, got rel with name $($d.name)"
            $object.rel.childlist.add($d)
            $d.rel.parentlist.add($object)
            }
        # or not exists
        else {
            Write-Verbose " N create node $child with parent $name"
            node -name $child -parent $name

            }
    }
}

$object

}


function plotchild {
    param(
        $obj,
        [switch]$Recurse
        )
    foreach ($child in $obj.rel.childlist) {
        '{0} --> {1}' -f $obj.name, $child.name
        if ($Recurse) {
            plotchild $child -Recurse
            }
        }
}

function plotchild_byid {
    param(
        $obj,
        [switch]$Recurse
        )
    foreach ($child in $obj.rel.childlist) {
        '{2}[{0}] --> {3}[{1}]' -f $obj.name, $child.name, $obj.id, $child.id
        if ($Recurse) {
            plotchild_byid $child -Recurse
            }
        }
}

function plotparent {
    param(
        $obj,
        [switch]$Recurse
        )
    foreach ($parent in $obj.rel.parentlist) {
        '{0} -.-> {1}' -f $obj.name, $parent.name
        if ($Recurse) {
            plotparent $parent -Recurse
            }
        }
}
