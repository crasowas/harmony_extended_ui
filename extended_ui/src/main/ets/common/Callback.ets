// Copyright (c) 2025, crasowas.
//
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import { FrameCallback } from '@kit.ArkUI'

/**
 * 没有参数且不返回数据的回调
 *
 */
export type VoidCallback = () => void

/**
 * 单次帧回调
 *
 */
export class OnceFrameCallback extends FrameCallback {
  private callback: VoidCallback

  constructor(callback: VoidCallback) {
    super()
    this.callback = callback
  }

  onFrame(_frameTimeNanos: number) {
    this.callback()
  }
}

/**
 * 下一帧运行
 *
 */
export function runAfterFrame(callback: VoidCallback, ctx?: UIContext) {
  if (ctx != undefined) {
    ctx.postFrameCallback(new OnceFrameCallback(callback))
  } else {
    setTimeout(callback, 0)
  }
}
