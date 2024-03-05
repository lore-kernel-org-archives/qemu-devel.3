Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB52CC54E55
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPoY-0007n1-DV; Tue, 05 Mar 2024 03:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPns-0007h7-2V
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPnp-0002yl-MU
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kD497RezhP4vTgtcu4VeuKKr+RMuIVXyas22WS8OZL0=;
 b=UadlO4szCwYQ5nL36JvZDdyt9KlhsncaM/5lOiGfax024pdnXGNVkbBQhDesjEcZyDfweF
 +jXCgNiQdWA/KNxs1uvKitweK1Df0BXo2/UYU2RxpjcoKQn8w6BVycp2iZjW+47YAlSO/H
 agCRJkc75lsMdpSh/EJusbeEOW3gbD4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-sJC4FdYdOamzQ9SsJFZ3ig-1; Tue, 05 Mar 2024 03:05:31 -0500
X-MC-Unique: sJC4FdYdOamzQ9SsJFZ3ig-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc6b26ce0bbso877793276.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625927; x=1710230727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kD497RezhP4vTgtcu4VeuKKr+RMuIVXyas22WS8OZL0=;
 b=fCxQCU2CHwegEIM8jMgOza2ea+nd/T+tiMJNz8UTMOAf8HZcbC/X6SBkmmc4XKuRJB
 sYFsMaRZxtlcfXqEqIU5+YMc41aXkkj69jI/KUyKvKmNP5j6oCGlxA/1DODQE7VMNNky
 mKuSao+Gd+TzOpmp+Bxh/MffV07N+8X2xDjV4OD6h4eMpp/BowIohrAfHQiV6M8Fd5D7
 VookKFIW4Otg0WQtJuFLb8eVVxehON9xWTgskCvM+gsLyYz0IK0WscJBImXVB3XFfbEL
 m9jz9BU7xC8QCOnakAnoZ1zJgjlnA5TdhHTztZ7vS8luv8zTTI4Oex5QlTu5NfBzg2Qx
 +iyA==
X-Gm-Message-State: AOJu0Yzy+ogIlFcYgCMSztC5H5e+LMmSNm3pSUV1CYIuosf8rYkT80Ox
 VOiFQLHMIIMO/UIVrWVXEuDmdnE03nqw8da/YN2xvBz7VqyxV2Opm0RvMcZgBd998ddIfPX2d+I
 FIpYHFtwh/Q7pUeLIvHE7dzIFBn4vSup+B7SXxD1FF+i6f1AF0HkEx6StYNncKjoVzCG57/Ka/r
 OCAHBy49O3QqVvrqJGouaEGWizce0=
X-Received: by 2002:a25:950:0:b0:dd0:bb7c:3f40 with SMTP id
 u16-20020a250950000000b00dd0bb7c3f40mr338048ybm.39.1709625927439; 
 Tue, 05 Mar 2024 00:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsPIHfm8Aklf2IkhUfnQFfP+m0vX60rwQba2+NGaq0VoCW3ftftWbe66UIRvg8mVsszix75owzRUQDEeU7Cjo=
X-Received: by 2002:a25:950:0:b0:dd0:bb7c:3f40 with SMTP id
 u16-20020a250950000000b00dd0bb7c3f40mr338041ybm.39.1709625927204; Tue, 05 Mar
 2024 00:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-2-jonah.palmer@oracle.com>
In-Reply-To: <20240304194612.611660-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 5 Mar 2024 09:04:51 +0100
Message-ID: <CAJaqyWe8WZEvWkS90gR=FrENV4eBYkOfZKpMrCCc_7BnpnzUZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] virtio/virtio-pci: Handle extra notification data
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 4, 2024 at 8:46=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Add support to virtio-pci devices for handling the extra data sent
> from the driver to the device when the VIRTIO_F_NOTIFICATION_DATA
> transport feature has been negotiated.
>
> The extra data that's passed to the virtio-pci device when this
> feature is enabled varies depending on the device's virtqueue
> layout.
>
> In a split virtqueue layout, this data includes:
>  - upper 16 bits: shadow_avail_idx
>  - lower 16 bits: virtqueue index
>
> In a packed virtqueue layout, this data includes:
>  - upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
>  - lower 16 bits: virtqueue index
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio-pci.c     | 10 +++++++---
>  hw/virtio/virtio.c         | 18 ++++++++++++++++++
>  include/hw/virtio/virtio.h |  1 +
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..d12edc567f 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -384,7 +384,7 @@ static void virtio_ioport_write(void *opaque, uint32_=
t addr, uint32_t val)
>  {
>      VirtIOPCIProxy *proxy =3D opaque;
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> -    uint16_t vector;
> +    uint16_t vector, vq_idx;
>      hwaddr pa;
>
>      switch (addr) {
> @@ -408,8 +408,12 @@ static void virtio_ioport_write(void *opaque, uint32=
_t addr, uint32_t val)
>              vdev->queue_sel =3D val;
>          break;
>      case VIRTIO_PCI_QUEUE_NOTIFY:
> -        if (val < VIRTIO_QUEUE_MAX) {
> -            virtio_queue_notify(vdev, val);
> +        vq_idx =3D val;
> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA=
)) {
> +                virtio_queue_set_shadow_avail_data(vdev, val);
> +            }
> +            virtio_queue_notify(vdev, vq_idx);
>          }
>          break;
>      case VIRTIO_PCI_STATUS:
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d229755eae..bcb9e09df0 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2255,6 +2255,24 @@ void virtio_queue_set_align(VirtIODevice *vdev, in=
t n, int align)
>      }
>  }
>
> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_t dat=
a)
> +{
> +    /* Lower 16 bits is the virtqueue index */
> +    uint16_t i =3D data;
> +    VirtQueue *vq =3D &vdev->vq[i];
> +
> +    if (!vq->vring.desc) {
> +        return;
> +    }
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        vq->shadow_avail_wrap_counter =3D (data >> 31) & 0x1;
> +        vq->shadow_avail_idx =3D (data >> 16) & 0x7FFF;
> +    } else {
> +        vq->shadow_avail_idx =3D (data >> 16);
> +    }
> +}
> +
>  static void virtio_queue_notify_vq(VirtQueue *vq)
>  {
>      if (vq->vring.desc && vq->handle_output) {
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c8f72850bc..53915947a7 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -335,6 +335,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, in=
t n);
>  void virtio_init_region_cache(VirtIODevice *vdev, int n);
>  void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
>  void virtio_queue_notify(VirtIODevice *vdev, int n);
> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_t dat=
a);
>  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
>  void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector)=
;
>  int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
> --
> 2.39.3
>


