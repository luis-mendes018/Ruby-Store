import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
connect() {
this.editor = this.element.querySelector("trix-editor")


if (!this.editor) {
  return
}

this.editor.addEventListener("click", this.handleClick)

this.selectedFigure = null
this.selectedImage = null
this.resizeHandle = null
this.resizeState = null


}

disconnect() {
this.editor?.removeEventListener("click", this.handleClick)


this.removeResizeHandle()
this.removeDocumentListeners()


}

handleClick = (event) => {
const image = event.target.closest(
"[data-trix-attachment] img, figure.attachment img"
)


if (!image || !this.editor.contains(image)) {
  this.removeResizeHandle()
  return
}

const figure = image.closest("figure.attachment")

if (!figure) {
  this.removeResizeHandle()
  return
}

this.selectImage(figure, image)


}

selectImage(figure, image) {
this.removeResizeHandle()


this.selectedFigure = figure
this.selectedImage = image

figure.classList.add("image-resize-active")

const handle = document.createElement("button")

handle.type = "button"
handle.className = "image-resize-handle"
handle.setAttribute(
  "aria-label",
  "Redimensionar imagem"
)

handle.addEventListener(
  "mousedown",
  this.startResize
)

figure.appendChild(handle)

this.resizeHandle = handle


}

startResize = (event) => {
event.preventDefault()
event.stopPropagation()


if (!this.selectedImage) {
  return
}

const image = this.selectedImage
const rect = image.getBoundingClientRect()

this.resizeState = {
  startX: event.clientX,
  startWidth: rect.width,
  startHeight: rect.height,
  aspectRatio: rect.height / rect.width
}

document.addEventListener(
  "mousemove",
  this.resize
)

document.addEventListener(
  "mouseup",
  this.finishResize
)


}

resize = (event) => {
if (!this.resizeState || !this.selectedImage) {
return
}

const {
  startX,
  startWidth,
  aspectRatio
} = this.resizeState

const deltaX =
  event.clientX - startX

let width =
  startWidth + deltaX

const minimumWidth = 100
const maximumWidth = Math.min(
  1200,
  this.editor.clientWidth
)

width = Math.max(
  minimumWidth,
  Math.min(maximumWidth, width)
)

this.selectedImage.style.width =
  `${width}px`

this.selectedImage.style.height =
  "auto"


}

finishResize = () => {
if (!this.resizeState || !this.selectedImage) {
this.removeDocumentListeners()
return
}


const image = this.selectedImage

const width = Math.round(
  image.getBoundingClientRect().width
)

const height = Math.round(
  image.getBoundingClientRect().height
)

this.persistImageSize(
  image,
  width,
  height
)

this.resizeState = null

this.removeDocumentListeners()


}

persistImageSize(image, width, height) {
const attachmentElement =
image.closest("[data-trix-id]")


if (!attachmentElement) {
  console.error(
    "Não foi encontrado o elemento do attachment com data-trix-id.",
    image
  )

  return
}

const trixId =
  attachmentElement.dataset.trixId

if (!trixId) {
  console.error(
    "O attachment do Trix não possui data-trix-id."
  )

  return
}

const document =
  this.editor.editor.getDocument()

const attachment =
  document.getAttachmentById(trixId)

if (!attachment) {
  console.error(
    "Attachment do Trix não encontrado:",
    trixId
  )

  return
}

this.editor.editor.recordUndoEntry(
  "Redimensionar imagem"
)

attachment.setAttributes({
  width,
  height
})

this.removeResizeHandle()
```

}

removeResizeHandle() {
if (this.resizeHandle) {
this.resizeHandle.remove()
this.resizeHandle = null
}

```
if (this.selectedFigure) {
  this.selectedFigure.classList.remove(
    "image-resize-active"
  )
}

this.selectedFigure = null
this.selectedImage = null


}

removeDocumentListeners() {
document.removeEventListener(
"mousemove",
this.resize
)


document.removeEventListener(
  "mouseup",
  this.finishResize
)


}
}
