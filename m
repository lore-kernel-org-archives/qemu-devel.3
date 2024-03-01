Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4842C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8c2-00074l-VV; Fri, 01 Mar 2024 14:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg8c0-00073v-O1
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg8by-0002IF-Nl
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709321521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2AmXII77jNqUvmjWyATnisJCLHyvN5Kwvzt1RUVOHg=;
 b=OywPNA3eRtyvxPTji5OYs3T3D9GCapgWb0PWGNuTGbe15Vf1v7owhECWNaVPkxWSjqpevq
 fc50nJIKMYqYxpXbd07l1y/ee53065WidU2llQX2cjORcEcUlTETJ1Cuepned9rjW0zBcS
 QbX+heD0c4evNuI0m7TcTlWyBTniPEc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-lSZ5R23xPvammdA8yCcD6g-1; Fri, 01 Mar 2024 14:32:00 -0500
X-MC-Unique: lSZ5R23xPvammdA8yCcD6g-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc6b2682870so4136262276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709321519; x=1709926319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2AmXII77jNqUvmjWyATnisJCLHyvN5Kwvzt1RUVOHg=;
 b=Tc4WTrwCx+6mxQbo6Lu3vg9XnV8YxbEOdgsRuWpWRuY+6oxvt5OW83XZ0kQ57duV/E
 xdrNnb6TFyisd7Y/qbnVzocPVweQvejpsl1heglx6syu+SIBYIjUTh3T52RFBabKWiVf
 L8ukbECv7PVkQLNfwO2d/Bcv4rsrbLQzVcy4uHszu5m5Z7hbttsmOT6wbBpjLAzxlXu7
 vGCZelEdMibFKBXPNFB9jXhupFoTRsEZMdQ3lQ1SiUK//ydgXVBoP8Zy02ycdvhH7Zdl
 g096iDgejUv62y41xQcVkPO6FF2qczE8oanPeOYi+BT6EPAeYRiXSz22g5QTOnZmEcjp
 b9jQ==
X-Gm-Message-State: AOJu0YwdB0XP2ey+/Ic2hzrNFxAecW+cLgum2CJAWMtGoNFSMIfW8I+y
 SzwLaHpc+LktPJALzrxAevkeCkocfZVT50LOe7qw3QO+YuPexnjR8NQJKCFtiDK1ZcFCxPei9te
 B2zNtT3oS6h1kthg4+moJ7qtg6QHxqn17UPcOUquf+4e8+W+xWUi0hcaI5vIvWuBNxqzMDHPbuH
 vRqLm4Cfo3oS2Mw1OR6HuWtRSaldo=
X-Received: by 2002:a25:abc4:0:b0:dc7:45c6:f8bc with SMTP id
 v62-20020a25abc4000000b00dc745c6f8bcmr2571487ybi.4.1709321519507; 
 Fri, 01 Mar 2024 11:31:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5F+BZNJSiDCBsIjhAtf1esGIqLuxYnCLfS5a70lozFfHDjjLiLmcIVXBOx0BShPYyeoli6wVJyUR/CMVLI34=
X-Received: by 2002:a25:abc4:0:b0:dc7:45c6:f8bc with SMTP id
 v62-20020a25abc4000000b00dc745c6f8bcmr2571467ybi.4.1709321519234; Fri, 01 Mar
 2024 11:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-2-jonah.palmer@oracle.com>
In-Reply-To: <20240301134330.4191007-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 20:31:23 +0100
Message-ID: <CAJaqyWdokP3yqbP8wPfgttFyFWfy1O3ST4jUQmiJ+n-xkrp_Zg@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

Nitpick, but since vq_idx is already a uint16_t the & 0xFFFF is not
needed. I think it's cleaner just to call virtio_set_notification data
in the has_feature(...) condition, but I'm happy with this too.

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
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        vq->last_avail_wrap_counter =3D (data >> 31) & 0x1;
> +        vq->last_avail_idx =3D (data >> 16) & 0x7FFF;
> +    } else {
> +        vq->last_avail_idx =3D (data >> 16) & 0xFFFF;
> +    }

It should not set last_avail_idx, only shadow_avail_idx. Otherwise,
QEMU can only see the descriptors placed after the notification.

Or am I missing something?

In that regard, I would call this function
"virtqueue_set_shadow_avail_idx". But I'm very bad at naming :).

The rest looks good to me.

Thanks!

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


