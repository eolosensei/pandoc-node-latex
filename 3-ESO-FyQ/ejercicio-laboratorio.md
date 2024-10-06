---
encabezado:
  titulo: Viajeros al tren
  subtitulo: Unidad 6. Corre, corre que te pillo
  nivel: 3º ESO
---

Se acerca el verano, y con ello el buen tiempo. Una mañana de julio, ahora que ya no tienes clases, has decidido ir con tus amigos a la playa de Gijón. Habéis quedado todos en la estación a las 12:15 para coger el primer tren que pase con destino Gijón. Tu madre te recuerda que te asegures de coger el que va a Gijón, y que mires bien los horarios. Sin embargo, al buscar la información en el andén, en vez del típico horario, observas el siguiente gráfico:

\begin{tikzpicture}[
  station/.style={circle,fill=red,scale=0.6},
  every label/.style={rotate=45,anchor=south west,font=\footnotesize},
  node distance=1cm and 1cm,
]
  \node[station] (Llamaquique) [label=above:Llamaquique] {};
  \node[station] (Oviedo)      [right=of Llamaquique, label=above:Oviedo] {};
  \node[station] (Corredoria)  [right=of Oviedo,      label=above:La Corredoria] {};
  \node[station] (Lugones)     [right=of Corredoria,  label=above:Lugones] {};
  \node[station] (Llanera)     [right=of Lugones,     label=above:Lugo de Llanera] {};
  \node[station] (Villabona)   [right=of Llanera,     label=above:Villabona] {};
  \node[station] (Tabladiello) [right=of Villabona,   label=above:Tabladiello] {};
  \node[station] (Serín)       [right=of Tabladiello, label=above:Serín] {};
  \node[station] (Monteana)    [right=of Serín,       label=above:Monteana] {};
  \node[station] (Veriña)      [right=of Monteana,    label=above:Veriña] {};
  \node[station] (Calzada)     [right=of Veriña,      label=above:La Calzada] {};
  \node[station] (Gijón)       [right=of Calzada,     label=above:Gijón] {};

  \draw[red,thick,-Straight Barb] (Llamaquique) -- (Lugones) -- (Llanera) -- (Gijón);
\end{tikzpicture}

\begin{tikzpicture}
  \begin{axis}[,
      xlabel={Tiempo [min]},
      ylabel={Posición [km]},
      xmin=0, % xmax=45,
      ymin=0, ymax=35,
      axis lines=left,
%        axis x line=middle,
%        axis equal=true,
      axis line style={thick},
      %xtick={0,20,40,60,80,100},
      %ytick={0,20,40,60,80,100,120},
      xtick distance=5,
      ytick distance=10,
      minor x tick num=4,
      minor y tick num=4,
      grid=both,
      grid style={solid,darkgray},
      minor grid style={solid,thin,gray},
      width={14cm},
      height={8cm},
      ]

      \addplot[
          color=red,
          style=ultra thick,
          mark=*,
          mark size=1pt,
      ]
      coordinates {
              (0,0)
              (2,1)
              (3,1)
              (5,4)
              (6,4)
              (8,6)
              (9,6)
              (12,11)
              (13,11)
              (16,12)
              (17,12)
              (19,17)
              (20,17)
              (21,21)
              (22,21)
              (24,25)
              (25,25)
              (27,28)
              (28,28)
              (30,30)
              (31,30)
              (33,32)
          };
  \end{axis}
\end{tikzpicture}

Viendo esto, te concentras e intentas recordar lo que te explicó en el último mes de clase tu profesor de física y química, para responder en esta hoja a las siguientes preguntas:

1.  Si el tren para Gijón sale de Llamaquique a las 12:22, ¿a qué hora pasará por Lugones?
2.  Una amiga está pasando unos días con unos tíos en Lugo de Llanera, y te pidió que la avisaras cuando subieras al tren, para subirse en el mismo. ¿Cuánto tiempo tendrá para llegar a la estación, si la avisas justo cuando sale tu tren de Lugones?
3.  ¿A qué hora llegarás a Gijón, y cuánta distancia habrás recorrido en total?
4.  ¿En qué tramo del recorrido el tren va más rápido, y en cuál va más despacio? Compruébalo numéricamente.
5.  ¿Cuál es la velocidad media de tu recorrido? ¿Es diferente de la velocidad media de alguien que se haya subido en Veriña?
6.  Para volver a casa por la tarde, decides coger un tren semidirecto, que saliendo de Gijón únicamente para en La Calzada y Lugo de Llanera. ¿Cuánto tiempo ahorrarás, suponiendo que la velocidad de cada tramo se mantiene igual?


<!-- Llamaquique   0
Oviedo        0.7
La Corredoria 4,1
Lugones       6.3
Lugo de llanera 10.8
Villabona     13,5
Tabladiello   16.9
Serín         21.4
Monteana      24.7
Veriña        27.9
Calzada       30.4
Gijón         32.3 -->