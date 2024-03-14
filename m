Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E60C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmUv-0006IH-Ig; Thu, 14 Mar 2024 10:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkmUt-0006Hl-VB
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkmUs-0006hi-38
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710428151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSMLfDG4VeMZCthGc79Fntkf0/HoTmUlrk/uagO1Z1E=;
 b=Xqs0MJVoL3d/m37Hw/wwOGbUuZhnuM/cDKfhKYt21VNhxVIla01t+QTOUUtTlAeYxYaoRe
 DxQwUu5ClHhmCkl12ydxXs4PCX1cYjAtGznauh5MX2nRpi7qCo5RLBpxstyDSzfU+/aBeP
 mb3xhRZeOhOUBK+trPeO5prWC8QWWAA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-ciKTej8ZMYeyKkug051zwg-1; Thu, 14 Mar 2024 10:55:50 -0400
X-MC-Unique: ciKTej8ZMYeyKkug051zwg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-60a0815e3f9so16694677b3.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 07:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710428150; x=1711032950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSMLfDG4VeMZCthGc79Fntkf0/HoTmUlrk/uagO1Z1E=;
 b=RQilFAWq09qaMw7xT1H5eY5pZAD8Tn7zDmqtQZu6g2VkD96fl0r5oPkCt0/Kf6ko+w
 eQxiOJxhUX0EHW0NCyRaPZYxt/Vk/JNJ6H4ZakUTJMz+Xxsj9FpVvhTZfVScNnNVvAkl
 W/BIDE/LOdvtfUEC4LApwj/NUJGmrV9sVykvmLSuFJH8atgIM4C7pdMW6X2wEGnZVa5c
 wKkZDNRmTDIrfcsI6XOxTaEZkL6QKFVXKpQkhTpD+amnmzoOJdp4uIarH0FnAGlLzmUN
 4S5Fpm+fPBeObK8B6k5bzTvk9VwhD0JVykafSrvo1OQsVqb2yDlB06Y3JGq3JT5dvygI
 S6bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpIyHGZLuzFZ+ttpBv/0a0usTusOpe++jXxkhO2MqdB2WTdFCBkk3YU6TDnwvHxAxWNVuHJaGlsqBr5VHST5frT82QC+8=
X-Gm-Message-State: AOJu0YwPUG5JQQ0c8Y0+838Cu+5DD2m6rbU6/Cje+7GSed1vtmRX8ktA
 oshOY8WSSEqL21CswVeel7NVp1hiq48sAZUk6OIqraPfcYc4JA2LGbtSSXnXefpRDhJylNkk6PD
 x6JNv1IOuyfmen4Plq1yLH6Z0zuyiwCfixySS+keNDaI955TFoLY2qJh1NkqA7+letoak4mr32u
 gEr+R2PJT4sSjXVYpmVKyzlFsUSnA=
X-Received: by 2002:a25:ef49:0:b0:dcf:2cfe:c82e with SMTP id
 w9-20020a25ef49000000b00dcf2cfec82emr2088873ybm.55.1710428150013; 
 Thu, 14 Mar 2024 07:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO+C19NHczw78koKdxn35FiZkSA/rnbsEfcPiyp904M912CAJ8aQXqGGuNjPhxlUByyKIeZb18nvXumRu/e6c=
X-Received: by 2002:a25:ef49:0:b0:dcf:2cfe:c82e with SMTP id
 w9-20020a25ef49000000b00dcf2cfec82emr2088852ybm.55.1710428149733; Thu, 14 Mar
 2024 07:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
 <20240313115412.3334962-2-jonah.palmer@oracle.com>
 <CACGkMEv6bRgrV_nvZK5Tb89CvTP5Kpyj4+na4Q9F=xBOJ6=8sw@mail.gmail.com>
 <b0e4a124-cced-4cbc-9f89-b8967f5a0b2c@oracle.com>
In-Reply-To: <b0e4a124-cced-4cbc-9f89-b8967f5a0b2c@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Mar 2024 15:55:13 +0100
Message-ID: <CAJaqyWcmzuY5R8hC-zwp_mEK40sYgwHU0vhewKziQLsY2EnpLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] virtio/virtio-pci: Handle extra notification data
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, 
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
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Thu, Mar 14, 2024 at 1:16=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/13/24 11:01 PM, Jason Wang wrote:
> > On Wed, Mar 13, 2024 at 7:55=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
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
> >>   - upper 16 bits: shadow_avail_idx
> >>   - lower 16 bits: virtqueue index
> >>
> >> In a packed virtqueue layout, this data includes:
> >>   - upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
> >>   - lower 16 bits: virtqueue index
> >>
> >> Tested-by: Lei Yang <leiyang@redhat.com>
> >> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/virtio/virtio-pci.c     | 10 +++++++---
> >>   hw/virtio/virtio.c         | 18 ++++++++++++++++++
> >>   include/hw/virtio/virtio.h |  1 +
> >>   3 files changed, 26 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> index cb6940fc0e..0f5c3c3b2f 100644
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
> >> @@ -408,8 +408,12 @@ static void virtio_ioport_write(void *opaque, uin=
t32_t addr, uint32_t val)
> >>               vdev->queue_sel =3D val;
> >>           break;
> >>       case VIRTIO_PCI_QUEUE_NOTIFY:
> >> -        if (val < VIRTIO_QUEUE_MAX) {
> >> -            virtio_queue_notify(vdev, val);
> >> +        vq_idx =3D val;
> >> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
> >> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_D=
ATA)) {
> >> +                virtio_queue_set_shadow_avail_data(vdev, val);
> >> +            }
> >> +            virtio_queue_notify(vdev, vq_idx);
> >>           }
> >>           break;
> >>       case VIRTIO_PCI_STATUS:
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index d229755eae..bcb9e09df0 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -2255,6 +2255,24 @@ void virtio_queue_set_align(VirtIODevice *vdev,=
 int n, int align)
> >>       }
> >>   }
> >>
> >> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_t =
data)

Maybe I didn't explain well, but I think it is better to pass directly
idx to a VirtQueue *. That way only the caller needs to check for a
valid vq idx, and (my understanding is) the virtio.c interface is
migrating to VirtQueue * use anyway.

> >> +{
> >> +    /* Lower 16 bits is the virtqueue index */
> >> +    uint16_t i =3D data;
> >> +    VirtQueue *vq =3D &vdev->vq[i];
> >> +
> >> +    if (!vq->vring.desc) {
> >> +        return;
> >> +    }
> >> +
> >> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >> +        vq->shadow_avail_wrap_counter =3D (data >> 31) & 0x1;
> >> +        vq->shadow_avail_idx =3D (data >> 16) & 0x7FFF;
> >> +    } else {
> >> +        vq->shadow_avail_idx =3D (data >> 16);
> >
> > Do we need to do a sanity check for this value?
> >
> > Thanks
> >
>
> It can't hurt, right? What kind of check did you have in mind?
>
> if (vq->shadow_avail_idx >=3D vq->vring.num)
>

I'm a little bit lost too. shadow_avail_idx can take all uint16_t
values. Maybe you meant checking for a valid vq index, Jason?

Thanks!

> Or something else?
>
> >> +    }
> >> +}
> >> +
> >>   static void virtio_queue_notify_vq(VirtQueue *vq)
> >>   {
> >>       if (vq->vring.desc && vq->handle_output) {
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index c8f72850bc..53915947a7 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -335,6 +335,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev,=
 int n);
> >>   void virtio_init_region_cache(VirtIODevice *vdev, int n);
> >>   void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
> >>   void virtio_queue_notify(VirtIODevice *vdev, int n);
> >> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_t =
data);
> >>   uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
> >>   void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vec=
tor);
> >>   int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
> >> --
> >> 2.39.3
> >>
> >
>


