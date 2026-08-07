# drawioをinlineでmarkdown上で表示させる（Drawio Integration）

ポイントは以下です。
- フェンスの言語指定が drawio。開始行に drawio width=644 のように横幅を書けます（エディター上で編集領域をドラッグすると自動的に記録され、「+ Diagram」で挿入した図には初期値 drawio width=800 が付きます）。 
- 中身は draw.io のネイティブXML（.drawio ファイルの中身そのもの）。GUIで図を作って「Extras → Edit Diagram」からコピーしてくるのが手っ取り早いです。
- 一から手書きするより、まず「+ Diagram」で空の図を挿入してGUIで描く方が現実的です。編集内容はこのフェンス内のXMLに書き戻されます。

```drawio width=400
<mxfile>
  <diagram name="ページ1" id="flow1">
    <mxGraphModel dx="800" dy="600" grid="1" gridSize="10" guides="1" tooltips="0" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="850" pageHeight="1100" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="n1" parent="1" style="ellipse;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" value="開始" vertex="1">
          <mxGeometry height="40" width="120" x="140" y="40" as="geometry" />
        </mxCell>
        <mxCell id="n2" parent="1" style="rounded=1;whiteSpace=wrap;html=1;" value="データ取得" vertex="1">
          <mxGeometry height="50" width="120" x="356" y="121" as="geometry" />
        </mxCell>
        <mxCell id="n3" parent="1" style="ellipse;whiteSpace=wrap;html=1;fillColor=#f8cecc;strokeColor=#b85450;" value="終了" vertex="1">
          <mxGeometry height="40" width="120" x="140" y="230" as="geometry" />
        </mxCell>
        <mxCell id="e1" edge="1" parent="1" source="n1" style="edgeStyle=orthogonalEdgeStyle;html=1;" target="n2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e2" edge="1" parent="1" source="n2" style="edgeStyle=orthogonalEdgeStyle;html=1;" target="n3">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="418.5" y="250" />
            </Array>
            <mxPoint x="407.5" y="200.72" as="sourcePoint" />
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

```
図のとおり、取得後は即座に終了します。