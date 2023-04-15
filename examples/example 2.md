```mermaid
graph TD
subgraph plotchild all nodes
Root --> Child1
Root --> Child3
Root --> Child2
Child1 --> GrandChild1
Child1 --> Child3
GrandChild1 --> GreatGrandChild2
SeparateNode --> Child2
SeparateNode --> GreatGrandChild2
end
```
