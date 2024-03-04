Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2DCC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC4T-0006Yl-3j; Mon, 04 Mar 2024 12:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhC3z-00068o-HR
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhC3v-0007hy-D7
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709573113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaweyTroA2VnJXi7StgwRI1QNvEzqGs11NoMDW9yOr8=;
 b=HUf2Nwzu6dyY+iKubjuUYYVpu+trwoMHwbwYxKXsjWEu+Du5WkM8sJN181iGITYhk3NdEd
 GydREu24TTYLKe/8Fykqqu23swxecGzmgmeAplHQNzWOw8wf+hCos7luvkRbHk7t/lZQB4
 Poc5YsqYmzSYW46+tN6/gXt3I1zCha8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Ejbq6JkNNgW_wr4jJcpNKA-1; Mon, 04 Mar 2024 12:25:12 -0500
X-MC-Unique: Ejbq6JkNNgW_wr4jJcpNKA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dc6b5d1899eso7934412276.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573112; x=1710177912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LaweyTroA2VnJXi7StgwRI1QNvEzqGs11NoMDW9yOr8=;
 b=hXwIkfy8mNYm4TgkZvsre+jvvok1FjELaqzWmYLtsaVCN9Sg3VwgD9hUcGaBNRxfAQ
 csenCK0vLLS/0g1jH3ynITg61PVM4LDFuGkvbab2jQVaJgV0YmXe5GxcVzAK9BcnfVrO
 HtfEijzhEbzH4D5jPmJggO7fCzvfxK07TBTF5qDhUM72M1IXVkhk8YiSM/XFR6zp89xB
 jTkkh60CdKphZJlc2WkrQdipizEIxdiodyuvm63ddyZp6vJRrCCtsfhD/lYVPFYO994c
 wC591KI+HGQFBZHZUJU9GyYz/GpFu5KWQ38ShUxqEdYx4RSj3UdWVlEy3QY63OkKGmBW
 z0dw==
X-Gm-Message-State: AOJu0YwGWdFPvIv6QeiTIOgMOqciYQts2V+RXWTnshGwVbNFKqWEIpau
 lg278I24CBhfb+Pblj8tIMElzYZTLit3hRNYXF2UPPZCooGvmWCp8enHEKD14NdBOPg+oqEI6sR
 LINS1W05M8vfZoMa8ipCPT2ECFwDQqUMXXfql04pFEKcUc42Ze3nXnF/MBCruGvqvO/DKNkAHyz
 fJN86mLBqRWKWHLvNkjzmjYMSZhzQ=
X-Received: by 2002:a25:903:0:b0:dc2:3a05:489 with SMTP id
 3-20020a250903000000b00dc23a050489mr129847ybj.14.1709573111717; 
 Mon, 04 Mar 2024 09:25:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfociF5Qvz73m+6ENb5dn65k6dyE5og73b1/Zs8ESjiBs9FcHO39zlmih2LYsKafT9+MMb/HNyZ39dTUqy5E8=
X-Received: by 2002:a25:903:0:b0:dc2:3a05:489 with SMTP id
 3-20020a250903000000b00dc23a050489mr129805ybj.14.1709573111408; 
 Mon, 04 Mar 2024 09:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-2-jonah.palmer@oracle.com>
 <CAJaqyWdokP3yqbP8wPfgttFyFWfy1O3ST4jUQmiJ+n-xkrp_Zg@mail.gmail.com>
 <964078ad-35de-4687-86e4-e3bc059481b0@oracle.com>
In-Reply-To: <964078ad-35de-4687-86e4-e3bc059481b0@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 4 Mar 2024 18:24:35 +0100
Message-ID: <CAJaqyWcnfhRA=xXHxdgF-u8gxJEAt7FQFryCrwj52N+4aLPbUQ@mail.gmail.com>
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
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 4, 2024 at 6:09=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
>
>
> On 3/1/24 2:31 PM, Eugenio Perez Martin wrote:
> > On Fri, Mar 1, 2024 at 2:44=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >>
> >> Add support to virtio-pci devices for handling the extra data sent
> >> from the driver to the device when the VIRTIO_F_NOTIFICATION_DATA
> >> transport feature has been negotiated.
> >>
> >> The extra data that's passed to the virtio-pci device when this
> >> feature is enabled varies depending on the device's virtqueue
> >> layout.
> >>
> >> In a split virtqueue layout, this data includes:
> >>   - upper 16 bits: last_avail_idx
> >>   - lower 16 bits: virtqueue index
> >>
> >> In a packed virtqueue layout, this data includes:
> >>   - upper 16 bits: 1-bit wrap counter & 15-bit last_avail_idx
> >>   - lower 16 bits: virtqueue index
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/virtio/virtio-pci.c     | 13 ++++++++++---
> >>   hw/virtio/virtio.c         | 13 +++++++++++++
> >>   include/hw/virtio/virtio.h |  1 +
> >>   3 files changed, 24 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> index 1a7039fb0c..c7c577b177 100644
> >> --- a/hw/virtio/virtio-pci.c
> >> +++ b/hw/virtio/virtio-pci.c
> >> @@ -384,7 +384,7 @@ static void virtio_ioport_write(void *opaque, uint=
32_t addr, uint32_t val)
> >>   {
> >>       VirtIOPCIProxy *proxy =3D opaque;
> >>       VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >> -    uint16_t vector;
> >> +    uint16_t vector, vq_idx;
> >>       hwaddr pa;
> >>
> >>       switch (addr) {
> >> @@ -408,8 +408,15 @@ static void virtio_ioport_write(void *opaque, uin=
t32_t addr, uint32_t val)
> >>               vdev->queue_sel =3D val;
> >>           break;
> >>       case VIRTIO_PCI_QUEUE_NOTIFY:
> >> -        if (val < VIRTIO_QUEUE_MAX) {
> >> -            virtio_queue_notify(vdev, val);
> >> +        if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)=
) {
> >> +            vq_idx =3D val & 0xFFFF;
> >
> > Nitpick, but since vq_idx is already a uint16_t the & 0xFFFF is not
> > needed.
>
> Ah okay. I wasn't sure if it was worthwhile to keep the '& 0xFFFF' in or
> not for the sake of clarity and good practice. In that case I could just
> do away with vq_idx here and use explicit casting on 'val'.
>
> > I think it's cleaner just to call virtio_set_notification data
> > in the has_feature(...) condition, but I'm happy with this too.
>
> Do you mean something like:
>
> if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) &&
>      virtio_set_notification_data(vdev, vq_idx, val)) {
>      ...
> }
>

Sorry I was not clear, I meant just to take out the common code of the
conditionals:
vq_idx =3D val;
if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) {
    virtio_set_notification_data(vdev, val);
}

> Though I'm not sure what would then go in the body of this conditional,
> especially if I did something like:
>
> case VIRTIO_PCI_QUEUE_NOTIFY:
>      if ((uint16_t)val < VIRTIO_QUEUE_MAX) {
>          if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) &&
>              virtio_set_notification_data(vdev, val)) {
>              // Not sure what to put here other than a no-op
>          }
>
>          virtio_queue_notify(vdev, (uint16_t)val);
>      }
>      break;
>
> But I'm not sure if you'd prefer this explicit casting of 'val' over
> implicit casting like:
>
> uint16_t vq_idx =3D val;
>
> >
> >> +            virtio_set_notification_data(vdev, vq_idx, val);
> >> +        } else {
> >> +            vq_idx =3D val;
> >> +        }
> >> +
> >> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
> >> +            virtio_queue_notify(vdev, vq_idx);
> >>           }
> >>           break;
> >>       case VIRTIO_PCI_STATUS:
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index d229755eae..a61f69b7fd 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -2052,6 +2052,19 @@ int virtio_set_status(VirtIODevice *vdev, uint8=
_t val)
> >>       return 0;
> >>   }
> >>
> >> +void virtio_set_notification_data(VirtIODevice *vdev, uint16_t i, uin=
t32_t data)
> >> +{
> >> +    VirtQueue *vq =3D &vdev->vq[i];
> >> +
> >> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >> +        vq->last_avail_wrap_counter =3D (data >> 31) & 0x1;
> >> +        vq->last_avail_idx =3D (data >> 16) & 0x7FFF;
> >> +    } else {
> >> +        vq->last_avail_idx =3D (data >> 16) & 0xFFFF;
> >> +    }
> >
> > It should not set last_avail_idx, only shadow_avail_idx. Otherwise,
> > QEMU can only see the descriptors placed after the notification.
> >
> > Or am I missing something?
> >
> > In that regard, I would call this function
> > "virtqueue_set_shadow_avail_idx". But I'm very bad at naming :).
>
> Ah that's right. This would make Qemu skip processing descriptors that
> might've been made available before the notification but after the
> host's last check of last_avail_idx. In other words, ignoring available
> descriptors that were placed before the notification but not yet
> processed. Good catch, thank you!
>
> So, for the packed VQ layout, we'll still want to save the wrap counter
> but for the shadow_avail_idx, right? E.g.
>
> if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>      vq->shadow_avail_wrap_counter =3D (data >> 31) & 0x1;
>      vq->shadow_avail_idx =3D (data >> 16) & 0x7FFF;
> } else {
>      vq->shadow_avail_idx =3D (data >> 16);
> }
>

Right, I was not clear enough again :). You probably have guessed
already but not modifying avail_wrap_counter would make QEMu to read
the wrong index too.

Thanks!

> >
> > The rest looks good to me.
> >
> > Thanks!
> >
> >> +    vq->shadow_avail_idx =3D vq->last_avail_idx;
> >> +}
> >> +
> >>   static enum virtio_device_endian virtio_default_endian(void)
> >>   {
> >>       if (target_words_bigendian()) {
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index c8f72850bc..c92d8afc42 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -345,6 +345,7 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32=
_t queue_index);
> >>   void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
> >>   void virtio_update_irq(VirtIODevice *vdev);
> >>   int virtio_set_features(VirtIODevice *vdev, uint64_t val);
> >> +void virtio_set_notification_data(VirtIODevice *vdev, uint16_t i, uin=
t32_t data);
> >>
> >>   /* Base devices.  */
> >>   typedef struct VirtIOBlkConf VirtIOBlkConf;
> >> --
> >> 2.39.3
> >>
> >
>


