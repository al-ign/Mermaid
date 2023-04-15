# example 2 plot all nodes
$filename = 'example 2.md'

# cleanup
$global:nodelist = $null

$a = node Root
$b = node Child1 Root
$c = node GrandChild1 $b
$d = node Child3 $b,'Root'

$e = node SeparateNode
$f = node Child2 $e
$(node Root).AddChild($f)

node GrandChild1 GreatGrandChild2
$e.AddChild((node GreatGrandChild2))

$str = @()

$str += '```mermaid'
$str += 'graph TD'

$str += 'subgraph plotchild all nodes'
$nodelist |% { plotchild  $_ } | % {$str += $_}
$str += 'end'

$str += '```'
$str | set-content $filename

$str