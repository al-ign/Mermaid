# example 3 plot something
$filename = 'example 3 bottle.md'

# cleanup
$global:nodelist = $null

$a = node WhyNot
$b = node Cap WhyNot
$c = node Some $b
$d = node Bottom $b,'WhyNot'

$e = node With
$f = node PoSh $e
$(node WhyNot).AddChild($f)

node Some Fun
$e.AddChild((node Fun))

$str = @()

$str += '```mermaid'
$str += 'graph TD'

$str += 'subgraph bottle'

$nodelist | %{ plotchild $_}| % {$str += $_}
$nodelist | %{ plotparent $_}| % {$str += $_}

$str += 'end'

$str += '```'
$str | set-content $filename

$str