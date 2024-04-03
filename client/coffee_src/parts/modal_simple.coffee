import h from 'react-hyperscript'
import React, {useState, useEffect} from 'react'

example =
  theme: 'primary'
  size: 'lg' # xl sm
  title: 'title'

ExModalContent = ({setModalOpen, title, ModalOpener, body, footer, header_style, theme='primary'})->
  header_property = do->
    if header_style
      style: header_style
    else
      className: do->
        if theme
          "bg-#{theme}"
        else
          'bg-light'
  [
    h ".modal-header", header_property , [
      h 'h4.modal-title', title
      if typeof setModalOpen is "function"
        h 'label.close',
          onClick: ()-> setModalOpen false
        , [h 'span', 'x']
    ]
    h '.modal-body', body
    if footer
      h '.modal-footer', footer

  ]
SimpleContent = ({setModalOpen, title, ModalOpener, body})->
  [
    h ".modal-header", [
      h 'h4.modal-title', title
      if typeof setModalOpen is "function"
        h 'label.close',
          onClick: ()-> setModalOpen false
        , [h 'span', 'x']
    ]
    h '.modal-body', body
  ]

export Modal = ({contents, size='lg'})->
  h 'div',
    style: zIndex: 100
  , [
    h '.modal.fade.show',
      style:
        overflow: 'scroll'
        display: 'block'
    , [
        h ".modal-dialog.fade-in.slide-in-top",
          className: do->
            if size
              "modal-#{size}"
            else
              ''
        , [
            h '.modal-content', contents
          ]
      ]
    h '.modal-backdrop.fade.show'
  ]

