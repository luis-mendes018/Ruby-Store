import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "deleteLink"]

  open(event) {
    const deleteUrl = event.currentTarget.dataset.deleteUrl

    this.deleteLinkTarget.href = deleteUrl
    this.dialogTarget.showModal()
  }

  close() {
    this.dialogTarget.close()
  }
}