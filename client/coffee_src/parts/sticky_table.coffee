import _ from 'lodash'
import { useState } from 'react'
import h from 'react-hyperscript'
import '../../css/sticky_table.css'

TestTable = ({caption, header, data})->
  h '.sticky-table', [
    h 'table.zebra-table.round-table', [
      h 'caption', caption
      h 'thead', [
        h 'tr', header.map (head)->
          h 'th', head
      ]
      h 'tbody', data.map (row, row_i)->
        h 'tr', row.map (col, col_i)->
          h 'td', col
    ]
  ]

App = ()->
  caption = 'Test Table'
  row_len = 100
  col_len = 25
  data = _.range(row_len).map (row_i)-> _.range(col_len).map (col_i)-> "r#{row_i}_c#{col_i}"
  header = _.range(data[0].length).map (head)-> "h#{head}"
  h 'div', [
    h TestTable, {caption, data, header}
  ]

export default App
