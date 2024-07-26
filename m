Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1605C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 14:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLwt-0005lU-5I; Fri, 26 Jul 2024 10:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXLwr-0005kx-Jv
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 10:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXLwp-0005fr-H5
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 10:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722004169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvbUoevMOc3z/HgcATTlw+ZYyye26ur49hRwNTbFrfM=;
 b=g5WCp3K9Z95BjpZ6DmiKZwipoPh3VlI8hayBBYrWCOCbqc91ehATkuEhy3sZNLGuth19yi
 nLP4sHX3ic4eCZ9cIsGDH2h7FwC0tupSld7hSCvTn9NB4dResBcY2qv2Y/PTt/n0z0E7WY
 LVk+nDNNACh8+HL0amncavN9yBXibIg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-SBM6i6lHMVmMUVHzXGr_wA-1; Fri, 26 Jul 2024 10:29:27 -0400
X-MC-Unique: SBM6i6lHMVmMUVHzXGr_wA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-650ab31aabdso49735897b3.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 07:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722004167; x=1722608967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvbUoevMOc3z/HgcATTlw+ZYyye26ur49hRwNTbFrfM=;
 b=FslTEcFQh8hkJjUFlRZUPTPsfIP45S6dXJaEMPcBEN9tVneeRhtlAGpwNJhqVPhjdY
 hMIOgpC1gL2D9NVu2atHRWBxPdhUVJtsoASBzpFedKwjEMcMd/ckArjfhSx5XpigyHTt
 nDK/0iS5LA9T5QnsjSoF3bbxxrGddvPF3GQG+Yac7fa/Ew0YewElGx9rQR6nNmS+l/6B
 8RHuaaHO9d79S/Ad+CTJj2eke9cGqvw2IFkTItOIf3ADr3CqckVBPDe6ilfLxWVXnfqN
 +f5m89fYrAI1ugmxnkHt5uCIEZ2O88UicMB71UmMsYPskGDRZ9LTcRUf+acQG9XkULJ5
 St1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVssMMZ+yxZlixShzLoIPSJLAgh7TUvp/RWpdrqspDlfZk1byCvGEw0BKqpsxmlNO08uR0I7+e6yOkF9nod8EnpU3Ljurw=
X-Gm-Message-State: AOJu0YwvfWxHh6yGMscCn6CJJ17FDkPC/uJw4sBU3b0jUxGwpuqh2UwF
 3tyYp6B3tXt/FA3SUaxbjJPmBMHZkRb67el3rKfcsEl52fTzl1p8OI9PG5sdCY3GqMhzlfdbvF8
 8JDJabMEH57qbzfRHl6FuoLQhRTjdHzxDbtIFnwIPAQ/wzbIuLtile3p3CGzWVCiUoGMRKV12wT
 Na6LIsL1jeCV3wcA8ialJN6JckgNg=
X-Received: by 2002:a05:690c:3385:b0:64b:89cd:7db8 with SMTP id
 00721157ae682-675b9b60727mr61328427b3.28.1722004166668; 
 Fri, 26 Jul 2024 07:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG68qi+feTncWw4/dNpWWdWQOZfHKJXM1YtWrGmlSJD5piIRuPDFZX/vOjfWNaeX4a9m6X4ZnP5OmDIZuC2G5s=
X-Received: by 2002:a05:690c:3385:b0:64b:89cd:7db8 with SMTP id
 00721157ae682-675b9b60727mr61328107b3.28.1722004166200; Fri, 26 Jul 2024
 07:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <20240726095822.104017-4-sahilcdq@proton.me>
In-Reply-To: <20240726095822.104017-4-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jul 2024 16:28:49 +0200
Message-ID: <CAJaqyWeNBw=xqmFLPx40VuRGuAW9ntYcAUVXK0GKHzdxTTBoVQ@mail.gmail.com>
Subject: Re: [RFC v2 3/3] vhost: Allocate memory for packed vring.
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 26, 2024 at 11:59=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
>
> Allocate memory for the packed vq format and support
> packed vq in the SVQ "start" operation.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes v1 -> v2:
> * vhost-shadow-virtqueue.h
>   (struct VhostShadowVirtqueue): New member "is_packed"
>   (vhost_svq_get_vring_addr): Renamed function.
>   (vhost_svq_get_vring_addr_packed): New function.
>   (vhost_svq_memory_packed): Likewise.
> * vhost-shadow-virtqueue.c:
>   (vhost_svq_add): Use "is_packed" to check vq format.
>   (vhost_svq_get_vring_addr): Rename function.
>   (vhost_svq_get_vring_addr_packed): New function but is yet to be implem=
ented.
>   (vhost_svq_memory_packed): New function.
>   (vhost_svq_start): Support packed vq format.
> * vhost-vdpa.c
>   (vhost_svq_get_vring_addr): Rename function.
>
>
>  hw/virtio/vhost-shadow-virtqueue.c | 70 ++++++++++++++++++++++--------
>  hw/virtio/vhost-shadow-virtqueue.h | 10 ++++-
>  hw/virtio/vhost-vdpa.c             |  4 +-
>  3 files changed, 63 insertions(+), 21 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index c7b7e0c477..045c07304c 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -343,7 +343,7 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const st=
ruct iovec *out_sg,
>          return -ENOSPC;
>      }
>
> -    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> +    if (svq->is_packed) {
>          ok =3D vhost_svq_add_packed(svq, out_sg, out_num,
>                                    in_sg, in_num, &qemu_head);
>      } else {
> @@ -679,18 +679,29 @@ void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue=
 *svq, int call_fd)
>  }
>
>  /**
> - * Get the shadow vq vring address.
> + * Get the split shadow vq vring address.
>   * @svq: Shadow virtqueue
>   * @addr: Destination to store address
>   */
> -void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
> -                              struct vhost_vring_addr *addr)
> +void vhost_svq_get_vring_addr_split(const VhostShadowVirtqueue *svq,
> +                                    struct vhost_vring_addr *addr)
>  {
>      addr->desc_user_addr =3D (uint64_t)(uintptr_t)svq->vring.desc;
>      addr->avail_user_addr =3D (uint64_t)(uintptr_t)svq->vring.avail;
>      addr->used_user_addr =3D (uint64_t)(uintptr_t)svq->vring.used;
>  }
>
> +/**
> + * Get the packed shadow vq vring address.
> + * @svq: Shadow virtqueue
> + * @addr: Destination to store address
> + */
> +void vhost_svq_get_vring_addr_packed(const VhostShadowVirtqueue *svq,
> +                                     struct vhost_vring_addr *addr)
> +{
> +    /* TODO */
> +}
> +
>  size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
>  {
>      size_t desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> @@ -707,6 +718,16 @@ size_t vhost_svq_device_area_size(const VhostShadowV=
irtqueue *svq)
>      return ROUND_UP(used_size, qemu_real_host_page_size());
>  }
>
> +size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq)
> +{
> +    size_t desc_size =3D sizeof(struct vring_packed_desc) * svq->num_fre=
e;
> +    size_t driver_event_suppression =3D sizeof(struct vring_packed_desc_=
event);
> +    size_t device_event_suppression =3D sizeof(struct vring_packed_desc_=
event);
> +
> +    return ROUND_UP(desc_size + driver_event_suppression + device_event_=
suppression,
> +                    qemu_real_host_page_size());
> +}
> +
>  /**
>   * Set a new file descriptor for the guest to kick the SVQ and notify fo=
r avail
>   *
> @@ -759,19 +780,34 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Vir=
tIODevice *vdev,
>      svq->vq =3D vq;
>      svq->iova_tree =3D iova_tree;
>
> -    svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_index=
(vq));
> -    svq->num_free =3D svq->vring.num;
> -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
> -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
> -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
> -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> +        svq->is_packed =3D true;
> +        svq->vring_packed.vring.num =3D virtio_queue_get_num(vdev, virti=
o_get_queue_index(vq));
> +        svq->num_free =3D svq->vring_packed.vring.num;
> +        svq->vring_packed.vring.desc =3D mmap(NULL, vhost_svq_memory_pac=
ked(svq),
> +                                            PROT_READ | PROT_WRITE, MAP_=
SHARED | MAP_ANONYMOUS,
> +                                            -1, 0);
> +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vring.num;
> +        svq->vring_packed.vring.driver =3D (void *)((char *)svq->vring_p=
acked.vring.desc + desc_size);

(Expanding on the cover letter comment) Here the driver area is
aligned properly too as each descriptor is 16 bytes length, and
required alignment for the driver area is 4 bytes by VirtIO standard.

> +        svq->vring_packed.vring.device =3D (void *)((char *)svq->vring_p=
acked.vring.driver +
> +                                                  sizeof(struct vring_pa=
cked_desc_event));
> +    } else {
> +        svq->is_packed =3D false;
> +        svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_i=
ndex(vq));
> +        svq->num_free =3D svq->vring.num;

Nitpicks,

The variables is_packed and num_free can be merged out of the if/else
to reduce code duplication.

Also it is clearer to me to assign svq->is_packed =3D
virtio_vdev_has_feature(...) and then check the variable in the if.
But other parts of QEMU do as you do here so I don't have a strong
opinion.

> +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> +                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_=
ANONYMOUS,
> +                               -1, 0);
> +        desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_siz=
e);
> +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> +                               PROT_READ | PROT_WRITE, MAP_SHARED | MAP_=
ANONYMOUS,
> +                               -1, 0);
> +    }
> +
> +    svq->desc_state =3D g_new0(SVQDescState, svq->num_free);
> +    svq->desc_next =3D g_new0(uint16_t, svq->num_free);
> +    for (unsigned i =3D 0; i < svq->num_free - 1; i++) {
>          svq->desc_next[i] =3D cpu_to_le16(i + 1);
>      }
>  }
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index ee1a87f523..b396daf57d 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -67,6 +67,9 @@ struct vring_packed {
>
>  /* Shadow virtqueue to relay notifications */
>  typedef struct VhostShadowVirtqueue {
> +    /* True if packed virtqueue */
> +    bool is_packed;
> +
>      /* Virtio queue shadowing */
>      VirtQueue *vq;
>
> @@ -146,10 +149,13 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, si=
ze_t num);
>
>  void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_f=
d);
>  void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
> -void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
> -                              struct vhost_vring_addr *addr);
> +void vhost_svq_get_vring_addr_split(const VhostShadowVirtqueue *svq,
> +                                    struct vhost_vring_addr *addr);
> +void vhost_svq_get_vring_addr_packed(const VhostShadowVirtqueue *svq,
> +                                     struct vhost_vring_addr *addr);
>  size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
>  size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
> +size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq);

Ok now I get the question on the cover letter better,

It is ok to reuse the already present functions, no need to create new
ones to export in this header.

Thanks!


>
>  void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                       VirtQueue *vq, VhostIOVATree *iova_tree);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..688de4a662 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1130,7 +1130,7 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost=
_dev *dev,
>      struct vhost_vdpa *v =3D dev->opaque;
>      struct vhost_vring_addr svq_addr;
>
> -    vhost_svq_get_vring_addr(svq, &svq_addr);
> +    vhost_svq_get_vring_addr_split(svq, &svq_addr);
>
>      vhost_vdpa_svq_unmap_ring(v, svq_addr.desc_user_addr);
>
> @@ -1189,7 +1189,7 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_d=
ev *dev,
>      size_t avail_offset;
>      bool ok;
>
> -    vhost_svq_get_vring_addr(svq, &svq_addr);
> +    vhost_svq_get_vring_addr_split(svq, &svq_addr);
>
>      driver_region =3D (DMAMap) {
>          .translated_addr =3D svq_addr.desc_user_addr,
> --
> 2.45.2
>


