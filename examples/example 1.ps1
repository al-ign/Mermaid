# example 1 plot descendants of some node
$filename = 'example 1.md'

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
$str += 'graph'

$str += 'subgraph plotchild from the root node'
plotchild $a -Recurse | % {$str += $_}
$str += 'end'

$str += 'subgraph plotparent from node f'
plotparent $f -Recurse | % {$str += $_}
$str += 'end'


$str += '```'
$str | set-content $filename

$str