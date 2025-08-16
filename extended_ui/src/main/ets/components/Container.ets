// Copyright (c) 2025, crasowas.
//
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import { emptyBuilder } from '../common/Builder'

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