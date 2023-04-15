# Just some fun with PowerShell to output Mermaid graphs

# Usage
```PowerShell
# reset nodelist between runs
$global:nodelist = $null

$RootNode = node RootNode 
node ChildNode RootNode
node AnotherNode $RootNode
node AnotherNode -child GrandChildNode
node GrandChildNode $RootNode
node OtherBranch -child GrandChildNode

$nodelist | ft

name           rel                     id                                   Child                                    Parent                              
----           ---                     --                                   -----                                    ------                              
RootNode       {parentList, childList} abbdd589-5466-4edc-ac6e-a2edbf67cfdf {ChildNode, AnotherNode, GrandChildNode}                                     
ChildNode      {parentList, childList} c49a40a1-8dd3-4eff-8653-c14889b8e900                                          RootNode                            
AnotherNode    {parentList, childList} 18fae758-8f87-403a-a5f7-96e1f0316fc4 GrandChildNode                           RootNode                            
GrandChildNode {parentList, childList} 28c239d3-18a8-43be-8e65-bc626eb98411                                          {AnotherNode, RootNode, OtherBranch}
OtherBranch    {parentList, childList} a0bc8bf1-1849-4236-8368-a3aec15159d9 GrandChildNode                                                               

```
# Output
Plot all children of the node
```
plotchild $RootNode -Recurse
```
Plot all parent nodes of the $node
```
plotparent (node GrandChildNode) -Recurse
```
Plot all children of the $node but use id as the node name, eg if the node names have spaces and/or non \W chars
```
plotchild_byid (node RootNode) -Recurse
```
Plot everything but beware of duplicates
```
$nodelist | % { plotchild $_}
```
