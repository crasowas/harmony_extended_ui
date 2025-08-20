import { Container, SizedBox } from 'extended_ui'

@Entry
@Component
struct Index {
  build() {
    Column() {
      this.buildContainer()
      SizedBox({ hei: 10 })
      this.buildSizedBox()
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
}