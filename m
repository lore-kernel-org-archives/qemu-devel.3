Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D71C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 19:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdamN-0008R0-TH; Mon, 12 Aug 2024 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sdamG-0008Q7-Is
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 15:32:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sdamD-0007al-Cc
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 15:32:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ff4fa918afso27121595ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723491138; x=1724095938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO5DAn40x9+Gw5raErTPti8A6K/CyQe1rvqRIGSx9QU=;
 b=bbdpZc9bDEgMrYleLwTzms0+PgEWXVslfNY0X4aWRz2nCIFQ5OjuuouUBTN4WgG7r6
 CsLVa61ncasW0385Gt7JGoihNgOO82tuRsM0lfclYexn24DP4khlm+ClLl7FWGbMipkM
 3T6iQ7hilgo/1HpyTVNOmQpAgulBKJ6Rzl6dpskEwcinH6rLtOMsfRQ2c9c31sSCNff/
 0A4l3g7fh2Sn1Fd/wrsIbfG+L1+UBtsDv3+gZbeQcEGtSdk77qsxVw/DB/VYKw0GXQ5D
 WMM4mdMdESDPbgF/IYnElVqQCQoZlumSRocOXNBIy7yYh3GmAO4tff/Bwzv1KXGnY33l
 pqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723491138; x=1724095938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rO5DAn40x9+Gw5raErTPti8A6K/CyQe1rvqRIGSx9QU=;
 b=Nl0wYa3JZXFdGN0h2JvHTBRLLvj/4DKWNYY+m+l2mGA3m1e3IvMbjp8VNjMb1M05ux
 Cit1H5FJC3/5zWvT8EK4Ay+s2eJNbJ7/YbZ29+H2kfjmMVGtm6YURHGJSCcY6hl+uNAs
 hsMWh0EZtl/KPAzJ4L0YreQfs2pTjuj5AjD52S9J79685YPeN3YDLLuHtfmYVnGqj7TY
 PdQdgBKXd2+cCjT7OohFSnuM1aTzQrjIakWc2ZqX08L1LDM3JwcM15CWRxxm1J11P8kS
 GqX2zagMEAP39VQ/w1LRzcfjXP8XlaiGSl3R2m8BgG5mXyij8c2ywtsNhUjcL5+V6OlQ
 K1Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaFhaQQ05LTNozsTAjTKmUXMV+TroMynQGLexqXNnzDFnjEBYaB2vXcW8Q1J5H7lqCQepaUjkxSBTyBlqH/yx5auS+Ua4=
X-Gm-Message-State: AOJu0YytzomGT13bAiIUeWMGaLgSB8JJyx4ph13gLAbOzyiBMmLTOK2b
 FXdS7KkXHTKbNBgbnHCeDsUiLyJnEjl7H2GsGbW47VE5wYnE29bt
X-Google-Smtp-Source: AGHT+IGcLfO2jlIpSdHGXlyEu7dNpZBi+zxZiTR07MoJay4Tm3QHoy53bNXA9AYK3YEVu46K7z++pg==
X-Received: by 2002:a17:903:41c3:b0:1fb:34ef:4467 with SMTP id
 d9443c01a7336-201ca1bff21mr15222095ad.43.1723491137673; 
 Mon, 12 Aug 2024 12:32:17 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.81.106])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1b452asm437795ad.184.2024.08.12.12.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 12:32:17 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Tue, 13 Aug 2024 01:02:03 +0530
Message-ID: <8454459.NyiUUSuA9g@valdaarhun>
In-Reply-To: <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <20240802112138.46831-4-sahilcdq@proton.me>
 <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x632.google.com
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

On Monday, August 12, 2024 12:01:00=E2=80=AFPM GMT+5:30 you wrote:
> On Sun, Aug 11, 2024 at 7:20=E2=80=AFPM Sahil <icegambit91@gmail.com> wro=
te:
> > On Wednesday, August 7, 2024 9:52:10=E2=80=AFPM GMT+5:30 Eugenio Perez =
Martin wrote:
> > > On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmai=
l.com> wrote:
> > > > [...]
> > > > @@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *sv=
q, VirtIODevice *vdev,
> > > >      svq->vring.num =3D virtio_queue_get_num(vdev,
> > > >      virtio_get_queue_index(vq));
> > > >      svq->num_free =3D svq->vring.num;
> > > >
> > > > -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> > > > -                           PROT_READ | PROT_WRITE, MAP_SHARED | MA=
P_ANONYMOUS,
> > > > -                           -1, 0);
> > > > -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > > > -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_s=
ize);
> > > > -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> > > > -                           PROT_READ | PROT_WRITE, MAP_SHARED | MA=
P_ANONYMOUS,
> > > > -                           -1, 0);
> > > > -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> > > > -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> > > > -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> > > > +    svq->is_packed =3D virtio_vdev_has_feature(svq->vdev, VIRTIO_F=
_RING_PACKED);
> > > > +
> > > > +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> > > > +        svq->vring_packed.vring.desc =3D mmap(NULL, vhost_svq_memo=
ry_packed(svq),
> > > > +                                          PROT_READ | PROT_WRITE, =
MAP_SHARED | MAP_ANONYMOUS,
> > > > +                                          -1, 0);
> > > > +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vrin=
g.num;
> > > > +        svq->vring_packed.vring.driver =3D (void *)((char *)svq->v=
ring_packed.vring.desc + desc_size);
> > > > +        svq->vring_packed.vring.device =3D (void *)((char *)svq->v=
ring_packed.vring.driver +
> > > > +                                     sizeof(struct vring_packed_de=
sc_event));
> > >
> > > This is a great start but it will be problematic when you start
> > > mapping the areas to the vdpa device. The driver area should be read
> > > only for the device, but it is placed in the same page as a RW one.
> > >
> > > More on this later.
> > >
> > > > +    } else {
> > > > +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(=
svq),
> > > > +                               PROT_READ | PROT_WRITE, MAP_SHARED =
|MAP_ANONYMOUS,
> > > > +                               -1, 0);
> > > > +        desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > > > +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + de=
sc_size);
> > > > +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(=
svq),
> > > > +                               PROT_READ | PROT_WRITE, MAP_SHARED =
|MAP_ANONYMOUS,
> > > > +                               -1, 0);
> > > > +    }
> > >
> > > I think it will be beneficial to avoid "if (packed)" conditionals on
> > > the exposed functions that give information about the memory maps.
> > > These need to be replicated at
> > > hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings.
> > >
> > > However, the current one depends on the driver area to live in the
> > > same page as the descriptor area, so it is not suitable for this.
> >
> > I haven't really understood this.
> >
> > In split vqs the descriptor, driver and device areas are mapped to RW p=
ages.
> > In vhost_vdpa.c:vhost_vdpa_svq_map_rings, the regions are mapped with
> > the appropriate "perm" field that sets the R/W permissions in the DMAMap
> > object. Is this problematic for the split vq format because the avail r=
ing is
> > anyway mapped to a RW page in "vhost_svq_start"?
> >
>=20
> Ok so maybe the map word is misleading here. The pages needs to be
> allocated for the QEMU process with both PROT_READ | PROT_WRITE, as
> QEMU needs to write into it.
>=20
> They are mapped to the device with vhost_vdpa_dma_map, and the last
> bool parameter indicates if the device needs write permissions or not.
> You can see how hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_ring checks
> the needle permission for this, and the needle permissions are stored
> at hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings. This is the
> function that needs to check for the maps permissions.
>

I think I have understood what's going on in "vhost_vdpa_svq_map_rings",
"vhost_vdpa_svq_map_ring" and "vhost_vdpa_dma_map". But based on
what I have understood it looks like the driver area is getting mapped to
an iova which is read-only for vhost_vdpa. Please let me know where I am
going wrong.

Consider the following implementation in hw/virtio/vhost_vdpa.c:

> size_t device_size =3D vhost_svq_device_area_size(svq);
> size_t driver_size =3D vhost_svq_driver_area_size(svq);

The driver size includes the descriptor area and the driver area. For
packed vq, the driver area is the "driver event suppression" structure
which should be read-only for the device according to the virtio spec
(section 2.8.10) [1].

> size_t avail_offset;
> bool ok;
>=20
> vhost_svq_get_vring_addr(svq, &svq_addr);

Over here "svq_addr.desc_user_addr" will point to the descriptor area
while "svq_addr.avail_user_addr" will point to the driver area/driver
event suppression structure.

> driver_region =3D (DMAMap) {
>     .translated_addr =3D svq_addr.desc_user_addr,
>     .size =3D driver_size - 1,
>     .perm =3D IOMMU_RO,
> };

This region points to the descriptor area and its size encompasses the
driver area as well with RO permission.

> ok =3D vhost_vdpa_svq_map_ring(v, &driver_region, errp);

The above function checks the value of needle->perm and sees that it is RO.
It then calls "vhost_vdpa_dma_map" with the following arguments:

> r =3D vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>                                                needle->size + 1,
>                                                (void *)(uintptr_t)needle-=
>translated_addr,
>                                                needle->perm =3D=3D IOMMU_=
RO);

Since needle->size includes the driver area as well, the driver area will be
mapped to a RO page in the device's address space, right?

> if (unlikely(!ok)) {
>     error_prepend(errp, "Cannot create vq driver region: ");
>     return false;
> }
> addr->desc_user_addr =3D driver_region.iova;
> avail_offset =3D svq_addr.avail_user_addr - svq_addr.desc_user_addr;
> addr->avail_user_addr =3D driver_region.iova + avail_offset;

I think "addr->desc_user_addr" and "addr->avail_user_addr" will both be
mapped to a RO page in the device's address space.

> device_region =3D (DMAMap) {
>     .translated_addr =3D svq_addr.used_user_addr,
>     .size =3D device_size - 1,
>     .perm =3D IOMMU_RW,
> };

The device area/device event suppression structure on the other hand will
be mapped to a RW page.

I also think there are other issues with the current state of the patch. Ac=
cording
to the virtio spec (section 2.8.10) [1], the "device event suppression" str=
ucture
needs to be write-only for the device but is mapped to a RW page.

Another concern I have is regarding the driver area size for packed vq. In
"hw/virtio/vhost-shadow-virtqueue.c" of the current patch:
> size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
> {
>     size_t desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
>     size_t avail_size =3D offsetof(vring_avail_t, ring[svq->vring.num]) +
>                                                               sizeof(uint=
16_t);
>=20
>     return ROUND_UP(desc_size + avail_size, qemu_real_host_page_size());
> }
>=20
> [...]
>=20
> size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
> {
>     size_t desc_size =3D sizeof(struct vring_packed_desc) * svq->num_free;
>     size_t driver_event_suppression =3D sizeof(struct vring_packed_desc_e=
vent);
>     size_t device_event_suppression =3D sizeof(struct vring_packed_desc_e=
vent);
>=20
>     return ROUND_UP(desc_size + driver_event_suppression + device_event_s=
uppression,
>                     qemu_real_host_page_size());
> }

The size returned by "vhost_svq_driver_area_size" might not be the actual d=
river
size which is given by desc_size + driver_event_suppression, right? Will th=
is have to
be changed too?

Thanks,
Sahil

[1] https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.=
html#x1-720008




