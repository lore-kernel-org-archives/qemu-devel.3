Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D21C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 18:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlCLP-0007zC-77; Fri, 15 Mar 2024 14:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rlCLK-0007yh-7o
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rlCLI-0000S2-IX
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710527502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjx4Rrg70XBuLeYQ4AUmFuQiPZnIhoQh27ELHtxKxS0=;
 b=dZXxkR4WPMbRTvQYver+DVHPpdSLvb9VTNWkS+0WGSbANzuFj22LudHPNTeasHDK8McaCj
 yK+29CZoMpwGy8Mjl3OZOrppvgQJkhszo3Bfp7/mTkZRf3cJ0Bk/jBVwDsjLks3qO5c6eM
 ajv2cX1r+a2pXK7K70cmY50n3FSGRg4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-erj_NCL-N3iJaAGSZM8f7A-1; Fri, 15 Mar 2024 14:31:40 -0400
X-MC-Unique: erj_NCL-N3iJaAGSZM8f7A-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-60a629e2121so42975947b3.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 11:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710527500; x=1711132300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjx4Rrg70XBuLeYQ4AUmFuQiPZnIhoQh27ELHtxKxS0=;
 b=Cmna6Os5D/9+YLghBzI1nvXT9vVRqgtUCa88OvrOvuT1cZ+4NhteNNxx/lqyueYnpv
 qfOEsq+97AbQk2cxoD1NQLd8wCwLxJrvKB+BzpZeGWeL+sVRTAXKTTZQSvfWDBGkjv4p
 RKJLS+s5neZ3pfPDY0z0bzIlxLvUlHmfLaiEbNjc4VrwCEzFpLWYNnrLEUCqdrteHjRs
 nuYj1whqDkj71iBNhtjQBxb3AW2UFQ3xArrOo7XrpYADbB1TIaOXSrYBaPI7bA8YMkr6
 xrvIXNwX+9o5d/81SM2U+r2TBgPeKAht2UFmbXXPWtEQXkxTnfbJtAdbdLZI9VwNTnE+
 FswQ==
X-Gm-Message-State: AOJu0YwQ3n6dtX8DwphaTUySG3AWWhFf/utOPsvLtJF6PAU8+Yipncf2
 agv7BSRd2T1snsDyW6WAJd2yjtTLerKyYZnCL7UY+sQ4jyJWFO6dZylLFhT6+iTY/5fj+5X5xyB
 GO9SAjsr3gqY8li+HCd2hpo2gKbnznFh6ndPMlBHGgL+DaiwXtt0/54mEPkc76PwgtlcWV9W1gi
 kmEjiUQlZv05+1pHCcEt8fb6Ieraw=
X-Received: by 2002:a05:6902:50a:b0:dcc:7b05:4cbb with SMTP id
 x10-20020a056902050a00b00dcc7b054cbbmr5524030ybs.31.1710527500038; 
 Fri, 15 Mar 2024 11:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZBXOjxYoNfGn+FnC5zJ8C3qwLXw5PYWx8+dV/4CMQ+HCEG7xCjKyGwRyHc2QN3L9ez/67GP5HOtSJe8ZeFi4=
X-Received: by 2002:a05:6902:50a:b0:dcc:7b05:4cbb with SMTP id
 x10-20020a056902050a00b00dcc7b054cbbmr5523984ybs.31.1710527499666; Fri, 15
 Mar 2024 11:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240315165557.26942-1-jonah.palmer@oracle.com>
 <20240315165557.26942-2-jonah.palmer@oracle.com>
In-Reply-To: <20240315165557.26942-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 15 Mar 2024 19:31:03 +0100
Message-ID: <CAJaqyWdB-GV95sWqPbqxveg4DMS4Onyoe-n64ijNBUy1P2JAow@mail.gmail.com>
Subject: Re: [PATCH v3 for 9.1 1/6] virtio/virtio-pci: Handle extra
 notification data
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, leiyang@redhat.com, 
 schalla@marvell.com, vattunuru@marvell.com, jerinj@marvell.com, 
 dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 5:57=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
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
>  hw/virtio/virtio-pci.c     | 11 ++++++++---
>  hw/virtio/virtio.c         | 18 ++++++++++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  3 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb6940fc0e..f3e0a08f53 100644
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
> @@ -408,8 +408,13 @@ static void virtio_ioport_write(void *opaque, uint32=
_t addr, uint32_t val)
>              vdev->queue_sel =3D val;
>          break;
>      case VIRTIO_PCI_QUEUE_NOTIFY:
> -        if (val < VIRTIO_QUEUE_MAX) {
> -            virtio_queue_notify(vdev, val);
> +        vq_idx =3D val;
> +        if (vq_idx < VIRTIO_QUEUE_MAX && virtio_queue_get_num(vdev, vq_i=
dx)) {
> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA=
)) {
> +                virtio_queue_set_shadow_avail_idx(virtio_get_queue(vdev,=
 vq_idx),
> +                                                  val >> 16);
> +            }
> +            virtio_queue_notify(vdev, vq_idx);
>          }
>          break;
>      case VIRTIO_PCI_STATUS:
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d229755eae..463426ca92 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2255,6 +2255,24 @@ void virtio_queue_set_align(VirtIODevice *vdev, in=
t n, int align)
>      }
>  }
>
> +void virtio_queue_set_shadow_avail_idx(VirtQueue *vq, uint16_t shadow_av=
ail_idx)
> +{
> +    if (!vq->vring.desc) {
> +        return;
> +    }
> +
> +    /*
> +     * 16-bit data for packed VQs include 1-bit wrap counter and
> +     * 15-bit shadow_avail_idx.
> +     */
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        vq->shadow_avail_wrap_counter =3D (shadow_avail_idx >> 15) & 0x1=
;
> +        vq->shadow_avail_idx =3D shadow_avail_idx & 0x7FFF;
> +    } else {
> +        vq->shadow_avail_idx =3D shadow_avail_idx;
> +    }
> +}
> +
>  static void virtio_queue_notify_vq(VirtQueue *vq)
>  {
>      if (vq->vring.desc && vq->handle_output) {
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c8f72850bc..cdd4f86b61 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -306,6 +306,8 @@ int virtio_queue_ready(VirtQueue *vq);
>
>  int virtio_queue_empty(VirtQueue *vq);
>
> +void virtio_queue_set_shadow_avail_idx(VirtQueue *vq, uint16_t idx);
> +
>  /* Host binding interface.  */
>
>  uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr);
> --
> 2.39.3
>


