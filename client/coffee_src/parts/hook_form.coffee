import h from 'react-hyperscript'
import React, {useState, useEffect} from 'react'
import {useForm} from 'react-hook-form'

form_items_example = [
  name: 'name'
  label: 'Name'
  type: 'text'
  condition:
    required:
      value: true
      message: 'this is required'
,
  name: 'description'
  label: 'Description'
  type: 'text'
  condition:
    value: true
    message: 'this is required'
  readonly: true
]

export InputFormControl = ({item, register, formState})->
  {
    name
    type
    condition
  } = item
  reg_obj = register(name, condition)
  property = {
    className: if formState.errors[name] then 'is-invalid' else ''
    type
    reg_obj...
  }
  if item.readonly
    property.readOnly = true
  h 'div', [
    h 'input.form-control', property
    if formState.errors[name]
      h '.invalid-feedback', formState.errors[name].message
  ]

export InputFormGroup = ({item, register, formState})->
  {
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
    h InputFormControl, {
      item
      register
      formState
    }
  ]

export HfInput = ({item, register, formState})->
  if item
    {
      name
      label
    } = item
    h '.form-group',
      key: name
    , [
        h 'label', label
        h InputFormControl, {
          item
          register
          formState
        }
      ]
  else
    h 'div'

export HfInputInline = ({item, register, formState})->
  if item
    {
      name
      label
    } = item
    h '.form-inline',
      key: name
    , [
        h '.input-group.mb-1', [
          h '.input-group-prepend', [
            h 'span.input-group-text', label
          ]
          h InputFormControl, {
            item
            register
            formState
          }
        ]
      ]
  else
    h 'div'

export TextAreaFormControl = ({item, register, formState})->
  {
    name
    rows
    condition
  } = item
  reg_obj = register(name, condition)
  rows = rows or 4

  property = {
    className: if formState.errors[name] then 'is-invalid' else ''
    rows
    reg_obj...
  }
  if item.readonly
    property.readOnly = true
  h 'div', [
    h 'textarea.form-control', property
    if formState.errors[name]
      h '.invalid-feedback', formState.errors[name].message
  ]

export HfTextArea = ({item, register, formState})->
  if item
    {
      name
      label
    } = item
    h '.form-group',
      key: name
    , [
        h 'label', label
        h TextAreaFormControl, {
          item
          register
          formState
        }
      ]
  else
    h 'div'

export RadioButton = ({item, register})->
  {
    name
    value
    label
  } = item
  reg_obj = register(name)
  property = {
    type: 'radio'
    value
    reg_obj...
  }
  h '.form-check.form-check-inline', [
    h 'input.form-check-input', property
    h 'label.form-check-label', label
  ]

export CheckBox = ({item, register})->
  {
    name
    value
    label
  } = item
  reg_obj = register(name)
  property = {
    type: 'checkbox'
    value
    reg_obj...
  }
  if item.readonly
    property.readOnly = true
  h '.form-check', [
    h 'input.form-check-input', property
    h 'label', label
  ]


export SelectFormControl = ({item, register, formState})->
  {
    name
    options
    condition
  } = item
  reg_obj = register(name, condition)
  property = {
    className: if formState.errors[name] then 'is-invalid' else ''
    reg_obj...
  }
  if item.readonly
    property.readOnly = true
  h 'div', [
      h 'select.form-control', property, options?.map? (op)->
        if op?.value? and op.text
          h 'option', value: op.value, op.text
        else
          h 'option', op
      if formState.errors[name]
        h '.invalid-feedback', formState.errors[name].message
    ]

export HfSelector = ({item, register, formState})->
  if item
    {
      name
      label
      options
      condition
    } = item
    reg_obj = register(name, condition)
    property = {
      className: if formState.errors[name] then 'is-invalid' else ''
      reg_obj...
    }
    if item.readonly
      property.readOnly = true
    h '.form-group',
      key: name
    , [
        h 'label', label
        h 'select.form-control', property, options?.map? (op)->
          if op?.value?
            h 'option', value: op.value, op.text
          else
            h 'option', op

        if formState.errors[name]
          h '.invalid-feedback', formState.errors[name].message
      ]
  else
    h 'div'

export HfSelectorInline = ({item, register, formState})->
  if item
    {
      name
      label
      options
      condition
    } = item
    reg_obj = register(name, condition)
    property = {
      className: if formState.errors[name] then 'is-invalid' else ''
      reg_obj...
    }
    if item.readonly
      property.readOnly = true
    h '.form-inline',
      key: name
    , [
      h '.input-group.mb-1', [
        h '.input-group-prepend', [
          h 'span.input-group-text', label
        ]
        h 'select.custom-select', property, options?.map? (op)->
          if op?.value?
            h 'option', value: op.value, op.text
          else
            h 'option', op
        if formState.errors[name]
          h '.invalid-feedback', formState.errors[name].message
      ]
    ]
  else
    h 'div'

export HfCheckBox = ({item, register, formState})->
  if item
    {
      name
      label
      condition
    } = item
    reg_obj = register(name, condition)
    property = {
      className: if formState.errors[name] then 'is-invalid' else ''
      type: 'checkbox'
      reg_obj...
    }
    if item.readonly
      property.readOnly = true
    h '.form-group',
      key: name
    , [
        h '.form-check', [
          h 'input.form-check-input', property
          h 'label', label
          if formState.errors[name]
            h '.invalid-feedback', formState.errors[name].message
        ]
      ]
  else
    h 'div'

