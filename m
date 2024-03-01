Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342CAC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8zM-0005Zt-Ru; Fri, 01 Mar 2024 14:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg8zL-0005ZS-AT
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg8zI-0006b7-QJ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709322967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZgEUSl+vA32O0vfl5TXIfza33OQsWq0SSwjuxnNZMc=;
 b=iJnRvmpK+38+MfvjXcegvTdZqWFjx4fpXuwQuvU/TbQHk+9xseKnuSEXF7n6j3yj470G2U
 OyWcy7mxIPl0DkBNQ9TieL4TS9Vnpt0FPmXHet4aLr7Hva3RZigIPbpqgrf8TFHDA7pu9p
 Yh3edxSUav1L6fIMwFV6dlW4E+N6wTo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Br-b9KGBMQeRrwKUNnzK-w-1; Fri, 01 Mar 2024 14:56:03 -0500
X-MC-Unique: Br-b9KGBMQeRrwKUNnzK-w-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-608ad239f8fso40553557b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709322962; x=1709927762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZgEUSl+vA32O0vfl5TXIfza33OQsWq0SSwjuxnNZMc=;
 b=RXmUxetMnQxo6v8aiWt+hngHcF+wr0CkjAwe5JIz+o8w33h3OaaqSJsZjksX90wa21
 ndXjYhwRujhWbwlSv2rr3swzM7S4uDzy5XFiQw5JagKKAKdHhqOWT5D0TcWHKjefNcZI
 gmlKjo007gmZzcUj0mdVgbbrTsfYxeDQvNneVHYYH3mOnEEe5p0qBPFau32RTPZYnWX0
 fMq48Oj5Jys2CnL3zP5xIR8fqW+RAHpQ5KJulzNWZsBc5ip2Nvtr+qRyrFCjHkR+9El5
 PbwGG4HMMft+5JebW2Wp8h2WeJyBTirfgV4dSu7nicAPTWEEX3DQCU/YVjfQBUI1oGum
 IvdA==
X-Gm-Message-State: AOJu0YzLgaW/PoaKMgHzuvQJnv8vz2UDKXbwfykk2moBUnYncZ33iIFo
 G862cfoqaVhDmVb9pXcnirKTW/KWrus7rdEVi2aDeJr/Gg5mq9kNd6rzTTnCUgeupHmbMJrTeVk
 bXyrsY8wIknmfhpeB2BkkFkgPjQeReUrfqWJXtnJOOYYTOHmGvWlL57mNFn8pOMe5upCgLATb8V
 UZKEUw822weWByFMWBAFW8VfF0fvQ=
X-Received: by 2002:a05:6902:160d:b0:dcf:56c3:336e with SMTP id
 bw13-20020a056902160d00b00dcf56c3336emr2623777ybb.35.1709322962336; 
 Fri, 01 Mar 2024 11:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR33GP+FLVobe0wk9rdfKD7F5RMkkGGg9c5hUkaINJh7qFO9yASe9sQ0+ij3PPzIDgpTfmDL6CZ81mnvt2lF8=
X-Received: by 2002:a05:6902:160d:b0:dcf:56c3:336e with SMTP id
 bw13-20020a056902160d00b00dcf56c3336emr2623751ybb.35.1709322962009; Fri, 01
 Mar 2024 11:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-2-jonah.palmer@oracle.com>
In-Reply-To: <20240301134330.4191007-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 20:55:25 +0100
Message-ID: <CAJaqyWd8WXtWyexk-oHxmAkgcG4pEawonqGHDhWwq1hb6+-_Og@mail.gmail.com>
Subject: Re: [RFC 1/8] virtio/virtio-pci: Handle extra notification data
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
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Fri, Mar 1, 2024 at 2:44=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
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
>  - upper 16 bits: last_avail_idx
>  - lower 16 bits: virtqueue index
>
> In a packed virtqueue layout, this data includes:
>  - upper 16 bits: 1-bit wrap counter & 15-bit last_avail_idx
>  - lower 16 bits: virtqueue index
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio-pci.c     | 13 ++++++++++---
>  hw/virtio/virtio.c         | 13 +++++++++++++
>  include/hw/virtio/virtio.h |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c..c7c577b177 100644
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
> @@ -408,8 +408,15 @@ static void virtio_ioport_write(void *opaque, uint32=
_t addr, uint32_t val)
>              vdev->queue_sel =3D val;
>          break;
>      case VIRTIO_PCI_QUEUE_NOTIFY:
> -        if (val < VIRTIO_QUEUE_MAX) {
> -            virtio_queue_notify(vdev, val);
> +        if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> +            vq_idx =3D val & 0xFFFF;
> +            virtio_set_notification_data(vdev, vq_idx, val);
> +        } else {
> +            vq_idx =3D val;
> +        }
> +
> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
> +            virtio_queue_notify(vdev, vq_idx);
>          }
>          break;
>      case VIRTIO_PCI_STATUS:
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d229755eae..a61f69b7fd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2052,6 +2052,19 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t =
val)
>      return 0;
>  }
>
> +void virtio_set_notification_data(VirtIODevice *vdev, uint16_t i, uint32=
_t data)
> +{
> +    VirtQueue *vq =3D &vdev->vq[i];

Sorry I sent the previous mail too fast :).

i should also be checked against VIRTIO_QUEUE_MAX and vq->vring.desc
before continuing this function. Otherwise is an out of bound access.

> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        vq->last_avail_wrap_counter =3D (data >> 31) & 0x1;
> +        vq->last_avail_idx =3D (data >> 16) & 0x7FFF;
> +    } else {
> +        vq->last_avail_idx =3D (data >> 16) & 0xFFFF;
> +    }
> +    vq->shadow_avail_idx =3D vq->last_avail_idx;
> +}
> +
>  static enum virtio_device_endian virtio_default_endian(void)
>  {
>      if (target_words_bigendian()) {
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c8f72850bc..c92d8afc42 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -345,6 +345,7 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t =
queue_index);
>  void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
>  void virtio_update_irq(VirtIODevice *vdev);
>  int virtio_set_features(VirtIODevice *vdev, uint64_t val);
> +void virtio_set_notification_data(VirtIODevice *vdev, uint16_t i, uint32=
_t data);
>
>  /* Base devices.  */
>  typedef struct VirtIOBlkConf VirtIOBlkConf;
> --
> 2.39.3
>


