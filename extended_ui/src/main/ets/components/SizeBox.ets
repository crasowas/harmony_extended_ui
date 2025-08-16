// Copyright (c) 2025, crasowas.
//
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import { Container } from '../../../../Index'

/**
 * 自定义矩形组件
 */
@ComponentV2
export struct SizedBox {
  /**
   * 宽度（可选），默认撑满父组件
   */
  @Param w: Length = '100%'
  /**
   * 高度（可选），默认撑满父组件
   */
  @Param h: Length = '100%'

  build() {
    Container()
      .width(this.w)
      .height(this.h)
  }
}