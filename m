Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C16CC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 03:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkbLg-0007Hi-U2; Wed, 13 Mar 2024 23:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkbLf-0007Gp-HJ
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkbLd-0002D9-Lq
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710385296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SOKo7gSNU602nFk1+k9VeTLNQiU9gHlsuWUyDr9MMI=;
 b=IGPHbRHi2TGIo6ktg0MUPgR8lfCTWhLLR4kDuWsls7fl13VPH41oSk3fdhj+kqpJfIuiKC
 6fLfJjvye4e2Aawx1176cGyhlo2ob/oYm3vzxmY4ow3TrAp2LVL8izD7cpU959d27f2q1U
 rvR8trW9+Iu1WHDltT0HqIuClw2c5Ew=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-0Lo1m87GMzyieoi4gKxIZw-1; Wed, 13 Mar 2024 23:01:34 -0400
X-MC-Unique: 0Lo1m87GMzyieoi4gKxIZw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e44fd078bdso442702b3a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 20:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710385293; x=1710990093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SOKo7gSNU602nFk1+k9VeTLNQiU9gHlsuWUyDr9MMI=;
 b=jrhxlI9vkjP1ehLmXFWkL7kNj+BePOnzFEMA8hQTxGszc6bk7RkDWxCvHixDoobZGb
 bFPDWc0TBoC6YC4L4wRMulp6PLpOPdvX7OKBC5QoQveDI9urhh4d4arf4b0AlbETn3WX
 rNGHv8PoNQX/vlNWHJFeUyHpF4LEsYoWKzTZW4D1YXVs8B0ezU1aA0VwRQI8DuRt/2s3
 4/JUrTAopbKDayrsy3+VYtMwIcUa5G7ZnJcWEaNCPiOxx9lPvVJgT0VlhAPH6OWH7wGl
 hC0s/QfUOV2F/eFoak0sg5ORaVBQiY7zYodmJ8GOsW1Ci8ZeSuzE9yb7hUiUFpIL3wGo
 4SRA==
X-Gm-Message-State: AOJu0Yy+sbC0RrPJJLC/ou4DIPRUlDxJM3mF9WuSDtW2YVh1xLaS/WiH
 GWSTIGNlO1kFV9cqWoMaXEEHE/Tg8lao088AaLsRRIDxHj5ZuJDIdlgJDNQHB2waKMgav+gV4YO
 QyuAh950wtq2Jmyy5O3vK2oFVoAxlA8QDBu1C8eVR6c8t+gAtwPnmnqZ5SXs38WvvDxmq2imd9W
 k0iPfOMmi+hg5S6cfoeZgnLvpoeuQ=
X-Received: by 2002:a05:6a20:12c6:b0:1a2:b33b:d6e0 with SMTP id
 v6-20020a056a2012c600b001a2b33bd6e0mr859814pzg.59.1710385292990; 
 Wed, 13 Mar 2024 20:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1/7yW6FNWoH6DWORiitPMckMj5Sn+Ax3K5+xgpg8KJ1iyz/qiC1MXMJFFxloe95qQBU8Aae8QWixuknvh8lI=
X-Received: by 2002:a05:6a20:12c6:b0:1a2:b33b:d6e0 with SMTP id
 v6-20020a056a2012c600b001a2b33bd6e0mr859777pzg.59.1710385292653; Wed, 13 Mar
 2024 20:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
 <20240313115412.3334962-2-jonah.palmer@oracle.com>
In-Reply-To: <20240313115412.3334962-2-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Mar 2024 11:01:21 +0800
Message-ID: <CACGkMEv6bRgrV_nvZK5Tb89CvTP5Kpyj4+na4Q9F=xBOJ6=8sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] virtio/virtio-pci: Handle extra notification data
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Mar 13, 2024 at 7:55=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
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
> Tested-by: Lei Yang <leiyang@redhat.com>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio-pci.c     | 10 +++++++---
>  hw/virtio/virtio.c         | 18 ++++++++++++++++++
>  include/hw/virtio/virtio.h |  1 +
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb6940fc0e..0f5c3c3b2f 100644
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

Do we need to do a sanity check for this value?

Thanks

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


