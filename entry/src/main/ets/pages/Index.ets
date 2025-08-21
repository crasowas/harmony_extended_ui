import { Container, SizedBox, LayoutBuilder, BoxConstraints } from 'extended_ui'

@Entry
@ComponentV2
struct Index {
  private layoutBuilderMinWidth: number = 150
  private layoutBuilderMaxWidth: number = 300
  private layoutBuilderMinHeight: number = 150
  private layoutBuilderMaxHeight: number = 200
  @Local layoutBuilderWidth: number = 150
  @Local layoutBuilderHeight: number = 150

  build() {
    Column() {
      this.buildContainer()
      SizedBox({ hei: 10 })
      this.buildSizedBox()
      SizedBox({ hei: 10 })
      this.buildLayoutBuilder()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(20)
  }

  @Builder
  buildContainer() {
    Stack() {
      Container({
        childLayout: () => {
          this.buildContainerChild()
        }
      })
        .width(150)
        .height(150)
        .backgroundColor(Color.Orange)
      Text('Container')
        .fontColor(Color.White)
    }
    .alignContent(Alignment.TopStart)
  }

  @Builder
  buildContainerChild() {
    Row() {
      Text('Child')
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .width(50)
        .height(50)
        .backgroundColor(Color.Red)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildSizedBox() {
    Stack() {
      SizedBox({ hei: 100 })
        .backgroundColor(Color.Gray)
      Text('SizedBox')
        .fontColor(Color.White)
    }
    .alignContent(Alignment.TopStart)
  }

  @Builder
  buildLayoutBuilder() {
    Stack() {
      LayoutBuilder({
        childLayout: (constraints) => {
          this.buildLayoutBuilderChild(constraints)
        }
      })
        .constraintSize({
          minWidth: 0,
          maxWidth: this.layoutBuilderWidth,
          minHeight: 0,
          maxHeight: this.layoutBuilderHeight
        })
        .backgroundColor(Color.Orange)
      Text('LayoutBuilder')
        .fontColor(Color.White)
    }
    .alignContent(Alignment.TopStart)

    Row() {
      Text('layoutBuilderWidth: ')
      Slider({
        value: this.layoutBuilderWidth,
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal,
        min: this.layoutBuilderMinWidth,
        max: this.layoutBuilderMaxWidth
      })
        .blockColor('#ff7171d7')
        .trackColor('#ff9fbcc3')
        .selectedColor('#ff5062a5')
        .showTips(true)
        .layoutWeight(1)
        .onChange((value: number, _mode: SliderChangeMode) => {
          this.layoutBuilderWidth = value
        })
    }

    Row() {
      Text('layoutBuilderHeight: ')
      Slider({
        value: this.layoutBuilderHeight,
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal,
        min: this.layoutBuilderMinHeight,
        max: this.layoutBuilderMaxHeight
      })
        .blockColor('#ff7171d7')
        .trackColor('#ff9fbcc3')
        .selectedColor('#ff5062a5')
        .showTips(true)
        .layoutWeight(1)
        .onChange((value: number, _mode: SliderChangeMode) => {
          this.layoutBuilderHeight = value
        })
    }
  }

  @Builder
  buildLayoutBuilderChild(constraints: BoxConstraints) {
    Row() {
      Text(`minWidth: ${constraints.minWidth} maxWidth: ${constraints.maxWidth}\n minHeight: ${constraints.minHeight} maxHeight: ${constraints.maxHeight}`)
        .fontSize(14)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .padding(10)
        .backgroundColor(Color.Red)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}