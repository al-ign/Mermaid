```mermaid
graph
subgraph bottle
WhyNot --> Cap
WhyNot --> Bottom
WhyNot --> PoSh
Cap --> Some
Cap --> Bottom
Some --> Fun
With --> PoSh
With --> Fun
Cap -.-> WhyNot
Some -.-> Cap
Bottom -.-> Cap
Bottom -.-> WhyNot
PoSh -.-> With
PoSh -.-> WhyNot
Fun -.-> Some
Fun -.-> With
end
```
