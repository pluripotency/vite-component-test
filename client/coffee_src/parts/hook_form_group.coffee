import h from 'react-hyperscript'
import React, {useState, useEffect} from 'react'
import {useForm} from 'react-hook-form'
import {
  InputFormControl
  TextAreaFormControl
  RadioButton
  CheckBox
} from './hook_form'
import {Modal} from './modal_simple'
import {bind} from "lodash/function"

export EditFormNoSubmit = ({form_items, defaultValues, onSubmit, submit_rows})->
  { register, handleSubmit, formState } = useForm {
    mode: 'onSubmit'
    reValidateMode: 'onChange'
    defaultValues
  }
  onError = (errors)->
    console.log "onErrors:", errors

  h 'form',
    onSubmit: handleSubmit(onSubmit, onError)
  , [
      (form_items.map (item)->
        {
          type
          label
          condition
        } = item
        if condition?.required?.value == true
          style = style: color: 'red'
        else
          style = style: visibility: 'hidden'
        h '.form-group', [
          h 'label', [
            h 'span.mr-2', style, '*'
            label
          ]
          if type in ['text', 'password']
            h InputFormControl, {
              item
              register
              formState
            }
          else if type in ['textarea']
            h TextAreaFormControl, {
              item
              register
              formState
            }
          else if type in ['bool', 'radiogroup']
            h '.card', [
              h '.card-body', [
                item.options.map (op)->
                  h RadioButton, {
                    key: op.value
                    item: {
                      name: item.name
                      value: op.value
                      label: op.text
                    }
                    register
                  }
              ]
            ]
          else if type in ['checkgroup']
            h '.card', [
              h '.card-body', [
                item.values.map (val)->
                  h CheckBox, {
                    key: val
                    item: {
                      name: item.name
                      value: val
                      label: val
                    }
                    register
                  }
              ]
            ]
          else
            h 'div'
        ]
      )...
      submit_rows...
    ]

export EditForm = ({form_items, defaultValues, onSubmit, close_func})->
  h EditFormNoSubmit, {
    form_items
    defaultValues
    onSubmit
    submit_rows: [
      h '.d-flex.justify-content-between', [
        h 'span', style: color: 'red', '* required'
        h 'label.btn.btn-outline-dark',
          onClick: close_func
        , 'Cancel'
        h 'button.btn.btn-info',
          type: 'submit'
        , 'Submit'
      ]
    ]
  }

export EditFormGetData = ({form_items, get_data, onSubmit, submit_rows})->
  [data, setData] = useState()

  bind_data = ()->
    body = await get_data()
    setData body
  useEffect ()->
    bind_data()
    return
  , []

  # defaultValues must be bound after data
  if data
    h EditFormNoSubmit, {
      defaultValues: data
      form_items
      onSubmit
      submit_rows
    }
  else
    h 'div'

export ModalEditGetData = ({form_items, get_data, post_data, delete_data, afterSubmit, title, btn_elem='label.btn.btn-sm.btn-info', btn_label='Edit'})->
  [editing, setEdit] = useState()
  [err_feedback, setErr] = useState()
  onModalSubmit = (values)->
    body = await post_data values
    if body
      if body.err
        setErr body.err
      else
        setEdit false
        afterSubmit()

  onModalDelete = ()->
    if window.confirm('Do you want to delete?')
      await delete_data()
      setEdit false
      afterSubmit()

  h 'div', [
    if editing
      h Modal, {
        contents: [
          h ".modal-header", [
            h 'h4.modal-title', title
            h 'label.close',
              onClick: ()-> setEdit false
            , [h 'span', 'x']
          ]
          h '.modal-body', [
            h EditFormGetData, {
              get_data
              form_items
              onSubmit: onModalSubmit
              submit_rows: [
                if err_feedback
                  h '.alert.alert-danger', err_feedback
                h '.d-flex.justify-content-between', [
                  h 'span', style: color: 'red', '* required'
                  h 'label.btn.btn-outline-dark',
                    onClick: ()-> setEdit false
                  , 'Cancel'
                  if delete_data
                    h 'label.btn.btn-danger',
                      onClick: onModalDelete
                    , 'Delete'
                  h 'button.btn.btn-info',
                    type: 'submit'
                  , 'Submit'
                ]
              ]
            }
          ]
        ]
      }
    else
      h btn_elem,
        onClick: ()-> setEdit true
      , btn_label
  ]

export ModalEditFeedBack = ({form_items, item_data, post_data, onSubmitSuccess, title, btn_elem='label.btn.btn-sm.btn-info', btn_label='Edit'})->
  [editing, setEdit] = useState()
  [err_feedback, setErr] = useState()
  onModalSubmit = (values)->
    body = await post_data values
    if body
      if body.err
        setErr body.err
      else
        setEdit false
        onSubmitSuccess body
  h 'div', [
    if editing
      h Modal, {
        contents: [
          h ".modal-header", [
            h 'h4.modal-title', title
            h 'label.close',
              onClick: ()-> setEdit false
            , [h 'span', 'x']
          ]
          h '.modal-body', [
            h EditFormNoSubmit, {
              defaultValues: item_data
              form_items
              onSubmit: onModalSubmit
              submit_rows: [
                if err_feedback
                  h '.alert.alert-danger', err_feedback
                h '.d-flex.justify-content-between', [
                  h 'span', style: color: 'red', '* required'
                  h 'label.btn.btn-outline-dark',
                    onClick: ()-> setEdit false
                  , 'Cancel'
                  h 'button.btn.btn-info',
                    type: 'submit'
                  , 'Submit'
                ]
              ]
            }
          ]
        ]
      }
    else
      h btn_elem,
        onClick: ()-> setEdit true
      , btn_label
  ]
export ModalEdit = ({form_items, item_data, onSubmit, title, btn_elem='label.btn.btn-sm.btn-info', btn_attr={}, btn_label='Edit'})->
  [editing, setEdit] = useState()
  h 'div', [
    if editing
      h Modal, {
        contents: [
          h ".modal-header", [
            h 'h4.modal-title', title
            h 'label.close',
              onClick: ()-> setEdit false
            , [h 'span', 'x']
          ]
          h '.modal-body', [
            h EditForm, {
              defaultValues: item_data
              form_items
              onSubmit: (values)->
                onSubmit values
                setEdit false
              close_func: ()-> setEdit false
            }
          ]
        ]
      }
    else
      h btn_elem,
        {
          btn_attr...
          onClick: ()-> setEdit true
        }
      , btn_label
  ]

export ReadFormGroupRow = ({item, value, kw, vw})->
  {
    label
    type
    readonly
    condition
    options
  } = item
  required = condition?.required?.value == true
  h '.form-group.row', {
    style:
      marginBottom: '5px'
  }
  , [
      h "label.col-sm-#{kw}.col-form-label.col-form-label-sm", [
        if required
          h 'span.mr-1', style: color: 'red', '*'
        else
          h 'span.mr-1', style: visibility: 'hidden', '*'
        label
      ]
      if type == 'text'
        if readonly
          h ".col-sm-#{vw}", [
            h 'input.form-control.form-control-sm',
              readOnly: true
              value: value or ''
          ]
        else
          h ".col-sm-#{vw}", [
            h 'label.form-control.form-control-sm.mb-0', value
          ]
      else if type == 'textarea'
        if readonly
          h ".col-sm-#{vw}", [
            h 'textarea.form-control.form-control-sm',
              readOnly: true
              value: value or ''
          ]
        else
          h ".col-sm-#{vw}", [
            h 'textarea.form-control.form-control-sm',
              style: backgroundColor: 'white'
              readOnly: true
              value: value or ''
          ]
      else if type in ['bool', 'radiogroup'] and Array.isArray(options)
        h ".col-sm-#{vw}", options.map (op)->
          h '.form-check.form-check-inline', [
            h 'input.form-check-input',
              type: 'radio'
              readOnly: true
              checked: value == op.value
              value: op.value
            h 'label.form-check-label', op.text
          ]
      else if type in ['checkgroup'] and Array.isArray(item.values) and Array.isArray(value)
        values = []
        item.values.map (val)->
          if value.indexOf(val) > -1
            values.push val
        if readonly
          h ".col-sm-#{vw}", [
            h 'textarea.form-control.form-control-sm',
              readOnly: true
              value: values.join('\n')
          ]
        else
          h ".col-sm-#{vw}", [
            h 'textarea.form-control.form-control-sm',
              style: backgroundColor: 'white'
              readOnly: true
              value: values.join('\n')
            ]
    ]

export ReadFormRows = ({form_items, item_data, btn='', key_w=4, value_w=8})->
  h 'div', [
    (form_items.map (item, index)->
      h ReadFormGroupRow, {
        item
        value: item_data[item.name]
        kw: key_w
        vw: value_w
      })...
    h '.d-flex.justify-content-between', [
      h 'span', style: color: 'red', '* required'
      btn
    ]
  ]

export ReadEditForm = ({form_items, item_data, post_data, onSubmitSuccess, edit_title, key_w=4, value_w=8})->
  h 'div', [
    (form_items.map (item, index)->
      h ReadFormGroupRow, {
        item
        value: item_data[item.name]
        kw: key_w
        vw: value_w
      })...
    h '.d-flex.justify-content-between', [
      h 'span', style: color: 'red', '* required'
      h ModalEditFeedBack, {
        title: edit_title
        form_items
        item_data
        post_data
        onSubmitSuccess
      }
    ]
  ]

