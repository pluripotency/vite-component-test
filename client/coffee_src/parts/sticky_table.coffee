import _ from 'lodash'
import { useState } from 'react'
import h from 'react-hyperscript'
import '../../css/sticky_table.css'
import { NavBar, NavList } from './navbar'

TestTable = ({header, data})->
  h '.sticky-table', [
    h 'table.zebra-table.round-table', [
      h 'thead', [
        h 'tr', header.map (head)->
          h 'th', head
      ]
      h 'tbody', data.map (row, row_i)->
        h 'tr', row.map (col, col_i)->
          h 'td', col
    ]
  ]
  
NavApp = ()->
  h NavBar, {
    title: 'Sticky-Table'
    collapse_items: [
      h NavList, {
        nav_list: [
          {name: 'Menu', component: ''}
        ]
        default_index: 0
        select_nav: ()->
      }
    ]
  }

get_table_data = ()->
  row_len = 100
  col_len = 25
  data = _.range(row_len).map (row_i)-> _.range(col_len).map (col_i)-> "r#{row_i}_c#{col_i}"
  header = _.range(data[0].length).map (head)-> "h#{head}"
  {
    header
    data
  }

App = ()->
  {
    header
    data
  } = get_table_data()
  h '.container-fluid',
    style:
      padding: 0
  , [
    h NavApp
    h TestTable, {data, header}
  ]

export default App
