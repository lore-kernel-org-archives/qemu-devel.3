Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151E7C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 12:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgkJt-0003aS-2V; Wed, 21 Aug 2024 08:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sgkJq-0003ZI-Kn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:20:07 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sgkJn-0006pI-RP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:20:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20230059241so28473715ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724242800; x=1724847600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioyKvyZFvOIDOmEo4sxiuRbkZ44LGlflb7KP/Z1UayA=;
 b=kCwtnKIUR2755Ph4tpXVvSaiyl9HeSQZLqejCxpKTMSqH66IZZ9+D9ote6EzTMZc5H
 EvEHvKZKI8dDUrFV1fAj4n5/A0fRkOX1z4GYrxXgOAaUjPAv9KhHrdii0iifOqYcYNAH
 z45zvXD2nrnFGx4JP2aOEQiU4y+emF/jSmy5RxqPhYMhWziwh7MhJb9GTdzQsEFP4flK
 NftX1wtvgNahIaXClVu25ox5nuYiRpyvq6D5H4gRrnnQjWpkegONAyJzUuaIisMREMcA
 nWgndmv+4XuhNI9OmiHeRIcn6JCCJ5nl3aQl4MJF5T9EnY/EXRNUgR+w7hRJJmYP+6Wk
 +2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724242800; x=1724847600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioyKvyZFvOIDOmEo4sxiuRbkZ44LGlflb7KP/Z1UayA=;
 b=BZjPv7KXboEad6SLt+DXic8Qa8al3qKxwYI8QxtRzJYG++/Rz9ciSQQRjyOQ7TJMBs
 47Ut/O+8tQzEiTxnchM0ka5w2ok+FyKBrwBmOlaHnjKd3jfXIfpXvA20gWiHceARcru2
 uxt2Y+UECSi8mRARTuCXr/4mgZ/ABiny4Xn4M/Ixf4h/5JYK3hEeGH0eUJdP5iWFRX0D
 p4jR7jtCpXBkYIe+cMZ2xtH95fr3j5ayX/FKKTFvyvqPKQLrGGX2NSGSPo+p+38Eidhh
 atM2muEWROaTgh1u9StUnRiNHdeDdA7jLSXwYQSYWKqbny95ndaiZERETffo+uZxnDnA
 hDEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvbTT0MKq/TLF4X3k7z+W/dPOl4qBUTSKee/4JJPnCniXTpM02weiPJDnyLW/x1/WGEqFYs0/TLYXS@nongnu.org
X-Gm-Message-State: AOJu0Yw3pRAdtD6bev/q5bF4kSwZgDbed8YbIUB9ETRxzIfbXZwgUs0o
 VFhrGxO7Dm1aHY0JwZ/ROSkK5P1OTkBV+q7fbGSLr6tfVsvccZfU
X-Google-Smtp-Source: AGHT+IHcH7dr+fW792vjdlOhku31egi4BaphXiHHZpmplxMEqd4wtCCDrMlniSaaHlw1G00UgbfI4w==
X-Received: by 2002:a17:902:db11:b0:1fb:93d6:9fef with SMTP id
 d9443c01a7336-20367d57d43mr25941805ad.38.1724242799866; 
 Wed, 21 Aug 2024 05:19:59 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.81.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03197fasm93141085ad.85.2024.08.21.05.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 05:19:59 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Wed, 21 Aug 2024 17:49:55 +0530
Message-ID: <1901750.tdWV9SEqCh@valdaarhun>
In-Reply-To: <CAJaqyWf3Vv6LvCHvRtpdZFQrhVHMOUTdzhJGj7PkbVDYeKox_w@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <8454459.NyiUUSuA9g@valdaarhun>
 <CAJaqyWf3Vv6LvCHvRtpdZFQrhVHMOUTdzhJGj7PkbVDYeKox_w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

Sorry for the late reply.

On Tuesday, August 13, 2024 12:23:55=E2=80=AFPM GMT+5:30 Eugenio Perez Mart=
in wrote:
> [...]
> > I think I have understood what's going on in "vhost_vdpa_svq_map_rings",
> > "vhost_vdpa_svq_map_ring" and "vhost_vdpa_dma_map". But based on
> > what I have understood it looks like the driver area is getting mapped =
to
> > an iova which is read-only for vhost_vdpa. Please let me know where I am
> > going wrong.
>=20
> You're not going wrong there. The device does not need to write into
> this area, so we map it read only.
>=20
> > Consider the following implementation in hw/virtio/vhost_vdpa.c:
> > > size_t device_size =3D vhost_svq_device_area_size(svq);
> > > size_t driver_size =3D vhost_svq_driver_area_size(svq);
> >=20
> > The driver size includes the descriptor area and the driver area. For
> > packed vq, the driver area is the "driver event suppression" structure
> > which should be read-only for the device according to the virtio spec
> > (section 2.8.10) [1].
> >=20
> > > size_t avail_offset;
> > > bool ok;
> > >=20
> > > vhost_svq_get_vring_addr(svq, &svq_addr);
> >=20
> > Over here "svq_addr.desc_user_addr" will point to the descriptor area
> > while "svq_addr.avail_user_addr" will point to the driver area/driver
> > event suppression structure.
> >=20
> > > driver_region =3D (DMAMap) {
> > >=20
> > >     .translated_addr =3D svq_addr.desc_user_addr,
> > >     .size =3D driver_size - 1,
> > >     .perm =3D IOMMU_RO,
> > >=20
> > > };
> >=20
> > This region points to the descriptor area and its size encompasses the
> > driver area as well with RO permission.
> >=20
> > > ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);
> >=20
> > The above function checks the value of needle->perm and sees that it is
> > RO.
> >=20
> > It then calls "vhost_vdpa_dma_map" with the following arguments:
> > > r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
> > >=20
> > >                                                needle->size + 1,
> > >                                                (void
> > >                                                *)(uintptr_t)needle->t=
ra
> > >                                                nslated_addr,
> > >                                                needle->perm =3D=3D
> > >                                                IOMMU_RO);
> >=20
> > Since needle->size includes the driver area as well, the driver area wi=
ll
> > be mapped to a RO page in the device's address space, right?
>=20
> Yes, the device does not need to write into the descriptor area in the
> supported split virtqueue case. So the descriptor area is also mapped
> RO at this moment.
>=20
> This change in the packed virtqueue case, so we need to map it RW.

I understand this now. I'll see how the implementation can be modified to t=
ake
this into account. I'll see if making the driver area and descriptor ring h=
elps.

> > > if (unlikely(!ok)) {
> > >=20
> > >     error_prepend(errp, "Cannot create vq driver region: ");
> > >     return false;
> > >=20
> > > }
> > > addr->desc_user_addr =3D driver_region.iova;
> > > avail_offset =3D svq_addr.avail_user_addr - svq_addr.desc_user_addr;
> > > addr->avail_user_addr =3D driver_region.iova + avail_offset;
> >=20
> > I think "addr->desc_user_addr" and "addr->avail_user_addr" will both be
> > mapped to a RO page in the device's address space.
> >=20
> > > device_region =3D (DMAMap) {
> > >=20
> > >     .translated_addr =3D svq_addr.used_user_addr,
> > >     .size =3D device_size - 1,
> > >     .perm =3D IOMMU_RW,
> > >=20
> > > };
> >=20
> > The device area/device event suppression structure on the other hand wi=
ll
> > be mapped to a RW page.
> >=20
> > I also think there are other issues with the current state of the patch.
> > According to the virtio spec (section 2.8.10) [1], the "device event
> > suppression" structure needs to be write-only for the device but is
> > mapped to a RW page.
>=20
> Yes, I'm not sure if all IOMMU supports write-only maps to be honest.

Got it. I think it should be alright to defer this issue until later.

> > Another concern I have is regarding the driver area size for packed vq.=
 In
> >=20
> > "hw/virtio/vhost-shadow-virtqueue.c" of the current patch:
> > > size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
> > > {
> > >=20
> > >     size_t desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > >     size_t avail_size =3D offsetof(vring_avail_t, ring[svq->vring.num=
]) +
> > >    =20
> > >                                                               sizeof(=
uin
> > >                                                               t16_t);
> > >    =20
> > >     return ROUND_UP(desc_size + avail_size, qemu_real_host_page_size(=
));
> > >=20
> > > }
> > >=20
> > > [...]
> > >=20
> > > size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
> > > {
> > >=20
> > >     size_t desc_size =3D sizeof(struct vring_packed_desc) * svq->num_=
free;
> > >     size_t driver_event_suppression =3D sizeof(struct
> > >     vring_packed_desc_event);
> > >     size_t device_event_suppression =3D sizeof(struct
> > >     vring_packed_desc_event);
> > >    =20
> > >     return ROUND_UP(desc_size + driver_event_suppression +
> > >     device_event_suppression,> >    =20
> > >                     qemu_real_host_page_size());
> > >=20
> > > }
> >=20
> > The size returned by "vhost_svq_driver_area_size" might not be the actu=
al
> > driver size which is given by desc_size + driver_event_suppression,
> > right? Will this have to be changed too?
>=20
> Yes, you're right this needs to be changed too.

Understood. I'll modify this too.

I have been trying to test my changes so far as well. I am not very clear on
a few things.

Q1.
I built QEMU from source with my changes and followed the vdpa_sim +
vhost_vdpa tutorial [1]. The VM seems to be running fine. How do I check
if the packed format is being used instead of the split vq format for shadow
virtqueues? I know the packed format is used when virtio_vdev has got the
VIRTIO_F_RING_PACKED bit enabled. Is there a way of checking that this is
the case?

Q2.
What's the recommended way to see what's going on under the hood? I tried
using the -D option so QEMU's logs are written to a file but the file was e=
mpty.
Would using qemu with -monitor stdio or attaching gdb to the QEMU VM be
worthwhile?

Thanks,
Sahil

[1] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-=
got-hardware-part-1



