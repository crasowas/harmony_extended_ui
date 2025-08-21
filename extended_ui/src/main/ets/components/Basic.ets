// Copyright (c) 2025, crasowas.
//
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import { emptyBuilder } from '../common/Builder'
import { runAfterFrame } from '../common/Callback'

/**
 * 简单的容器组件
 *
 * 单独使用该组件没有任何效果，需要和通用属性设置配合使用
 */
@ComponentV2
export struct Container {
  /**
   * 子组件（可选）
   *
   * 不建议使用尾随闭包方式设置子组件，会导致无法设置通用属性
   * 参考：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-builderparam#%E5%B0%BE%E9%9A%8F%E9%97%AD%E5%8C%85%E5%88%9D%E5%A7%8B%E5%8C%96%E7%BB%84%E4%BB%B6
   */
  @BuilderParam childLayout: () => void = emptyBuilder

  build() {
    this.childLayout()
  }
}

/**
 * 自定义矩形组件
 */
@ComponentV2
export struct SizedBox {
  /**
   * 宽度（可选），默认撑满父组件
   */
  @Param wid: Length = '100%'
  /**
   * 高度（可选），默认撑满父组件
   */
  @Param hei: Length = '100%'

  build() {
    Container()
      .width(this.wid)
      .height(this.hei)
  }
}

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

  onMeasureSize(_selfLayoutInfo: GeometryInfo, children: Measurable[], constraint: ConstraintSizeOptions): SizeResult {
    children.forEach((child) => {
      child.measure(constraint)
    })
    const minWidth = constraint.minWidth as number
    const maxWidth = constraint.maxWidth as number
    const minHeight = constraint.minHeight as number
    const maxHeight = constraint.maxHeight as number
    runAfterFrame(() => {
      this.constraints.minWidth = minWidth
      this.constraints.maxWidth = maxWidth
      this.constraints.minHeight = minHeight
      this.constraints.maxHeight = maxHeight
    }, this.getUIContext())
    return { width: maxWidth, height: maxHeight }
  }

  build() {
    this.childLayout(this.constraints)
  }
}
