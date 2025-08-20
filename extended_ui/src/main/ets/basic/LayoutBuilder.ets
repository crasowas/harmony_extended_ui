// Copyright (c) 2025, crasowas.
//
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import { emptyBuilder } from '../common/Builder'

/**
 * 组件约束信息
 *
 */
@ObservedV2
export class BoxConstraints {
  @Trace minWidth?: Length
  @Trace maxWidth?: Length
  @Trace minHeight?: Length
  @Trace maxHeight?: Length

  constructor(minWidth?: Length, maxWidth?: Length, minHeight?: Length, maxHeight?: Length) {
    this.minWidth = minWidth
    this.maxWidth = maxWidth
    this.minHeight = minHeight
    this.maxHeight = maxHeight
  }
}

/**
 * 布局辅助组件
 *
 * 用于在构建阶段获取父组件的约束信息
 */
@ComponentV2
export struct LayoutBuilder {
  /**
   * 布局约束信息
   *
   */
  @Local constraints: BoxConstraints = new BoxConstraints()
  /**
   * 子组件（可选）
   *
   */
  @BuilderParam childLayout: (constraints: BoxConstraints) => void = emptyBuilder

  onMeasureSize(selfLayoutInfo: GeometryInfo, children: Measurable[], constraint: ConstraintSizeOptions): SizeResult {
    children.forEach((child) => {
      child.measure(constraint)
    })
    const minWidth = constraint.minWidth as number
    const maxWidth = constraint.maxWidth as number
    const minHeight = constraint.minHeight as number
    const maxHeight = constraint.maxHeight as number
    setTimeout(() => {
      this.constraints = new BoxConstraints(minWidth, maxWidth, minHeight, maxHeight)
    }, 0)
    return { width: maxWidth, height: maxHeight }
  }

  build() {
    this.childLayout(this.constraints)
  }
}