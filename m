Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5202C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsQH-0005V1-0k; Wed, 19 Jun 2024 06:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sJsQF-0005U5-4Z
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sJsQD-00065A-1h
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718792407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iE4SunOPRH64KCjZrylfiBNYuPUiYejPJ1XrCqIZ8mc=;
 b=DCubtcipW7EKrKDicn3TOeAnJVegk3zbJgOdwF3/Ul8BySfRXUq5zg2zmWFeqH1sOitT3S
 4iajIZ2kmxuIcM5CNkhSZ8ZVazX2m46wpd1onltPDBrecBXNiiEfo4DE0EecBXlFutJenD
 NIrEUIDI/GQFFP/0JJCKDSZlUfb1KiY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-XE8BP-pUN1GXHivUW9lCUQ-1; Wed, 19 Jun 2024 06:20:06 -0400
X-MC-Unique: XE8BP-pUN1GXHivUW9lCUQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dfa7a8147c3so12481514276.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718792406; x=1719397206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iE4SunOPRH64KCjZrylfiBNYuPUiYejPJ1XrCqIZ8mc=;
 b=BY7RHv/942Bhuvz4kcD+GquRUpSfLfEU6LdQ0/d8yN3iUtZdv4aGAkAhJFYzDSqEHq
 Z37fSQOGK5qp4EKH4KrrVzuCuKXfqjtw1RrC5hArX+H+UT/csLgqIWwQmFHiwz3ZZbdY
 zr7YWpQ7DGixJAfXkh08WlRPDL3cLeZwrQQ2jnNGivOnCh+Km3ysIIBB+1MeS17XK+ZD
 Yww+GvDJnRe4n4vx+Sl980SnHjYC0ri9MLXtucjR4N7HK8y6LBMbFDCLK5VALhUpCFLQ
 xCtt3prTOZAucH4QRsB2L+TTBeuRWWJD8qbIVnO1eo+P8onylmUHP/s1fGi6f/iTBkmm
 3pEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQ/JhsQprMfhoPQyllmWoafZdHc8xxaRRpOA+To7KP5+i8lGPNfaHA8YtKtMtDV1MAEYozvM8qdr21axdu/fXNqUqApY=
X-Gm-Message-State: AOJu0YyKnDUFZRMYjzhdMnU9Ty4Vo0L2jbl/wOS+SP9FR83rmBbHL+Bb
 9Trd5zf1UQVWfonH6e+JlT9uARQ/W7AkWw3Jk/wwyX8flrKoqa6kdT3r2ChBBbjLFaFyfdKRUd6
 bNB3GePaPDMoyKUvc45GtDPLT8lkGi6xPeLKtyxRwS18Q2wTq88QyRwxgKNy2fwcjPwhDQ1Pg5Z
 Ssn1yH/vHSgNh4NMj6hKg4+Ox/M/c=
X-Received: by 2002:a25:e30b:0:b0:e02:c434:8b2a with SMTP id
 3f1490d57ef6-e02c4348dadmr989760276.54.1718792405875; 
 Wed, 19 Jun 2024 03:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPYXTstGYeHgi6iZpfqcHh2RKRMucNuyith/bBBw4aDSL2u/vx6Xl+FmW5odf2IQwY2aB5lMe6Aw2lX95Ngjo=
X-Received: by 2002:a25:e30b:0:b0:e02:c434:8b2a with SMTP id
 3f1490d57ef6-e02c4348dadmr989743276.54.1718792405428; Wed, 19 Jun 2024
 03:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240618181834.14173-1-sahilcdq@proton.me>
In-Reply-To: <20240618181834.14173-1-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:19:29 +0200
Message-ID: <CAJaqyWc8L2rZULeHgqmuieAqmQvePm9sicJFGq+POKPLYQMLJg@mail.gmail.com>
Subject: Re: [RFC] vhost: Introduce packed vq and add buffer elements
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Tue, Jun 18, 2024 at 8:19=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> This is the first patch in a series to add support for packed
> virtqueues in vhost_shadow_virtqueue. This patch implements the
> insertion of available buffers in the descriptor area. It takes
> into account descriptor chains, but does not consider indirect
> descriptors.
>
> VhostShadowVirtqueue has also been modified so it acts as a layer
> of abstraction for split and packed virtqueues.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Hi,
>
> I am currently working on adding support for packed virtqueues in
> vhost_shadow_virtqueue [1]. This patch only implements the insertion of
> available buffers in the descriptor area. It does not take into
> account indirect descriptors, event_idx or notifications.
>
> I don't think these changes are testable yet but I thought I would
> still post this patch for feedback. The following email annotates these
> changes with a few comments and questions that I have.
>
> Thanks,
> Sahil
>

Hi Sahil,

Just some nitpicks here and there,

> [1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
>
>  hw/virtio/vhost-shadow-virtqueue.c | 124 ++++++++++++++++++++++++++++-
>  hw/virtio/vhost-shadow-virtqueue.h |  66 ++++++++++-----
>  2 files changed, 167 insertions(+), 23 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408f77..e3b276a9e9 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -217,6 +217,122 @@ static bool vhost_svq_add_split(VhostShadowVirtqueu=
e *svq,
>      return true;
>  }
>
> +/**
> + * Write descriptors to SVQ packed vring
> + *
> + * @svq: The shadow virtqueue
> + * @sg: Cache for hwaddr
> + * @out_sg: The iovec from the guest that is read-only for device
> + * @out_num: iovec length
> + * @in_sg: The iovec from the guest that is write-only for device
> + * @in_num: iovec length
> + * @head_flags: flags for first descriptor in list
> + *
> + * Return true if success, false otherwise and print error.
> + */
> +static bool vhost_svq_vring_write_descs_packed(VhostShadowVirtqueue *svq=
, hwaddr *sg,
> +                                        const struct iovec *out_sg, size=
_t out_num,
> +                                        const struct iovec *in_sg, size_=
t in_num,
> +                                        uint16_t *head_flags)
> +{
> +    uint16_t id, curr, head, i;
> +    unsigned n;
> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> +    bool ok;
> +
> +    head =3D svq->vring_packed.next_avail_idx;
> +    i =3D head;
> +    id =3D svq->free_head;
> +    curr =3D id;
> +
> +    size_t num =3D out_num + in_num;
> +
> +    if (num =3D=3D 0) {
> +        return true;
> +    }

num =3D=3D 0 is impossible now, the caller checks for that.

> +
> +    ok =3D vhost_svq_translate_addr(svq, sg, out_sg, out_num);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +
> +    ok =3D vhost_svq_translate_addr(svq, sg + out_num, in_sg, in_num);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +
> +    for (n =3D 0; n < num; n++) {
> +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_flag=
s |
> +                (n < out_num ? 0 : VRING_DESC_F_WRITE) |
> +                (n + 1 =3D=3D num ? 0 : VRING_DESC_F_NEXT));
> +        if (i =3D=3D head) {
> +            *head_flags =3D flags;
> +        } else {
> +            descs[i].flags =3D flags;
> +        }
> +
> +        descs[i].addr =3D cpu_to_le64(sg[n]);
> +        descs[i].id =3D id;
> +        if (n < out_num) {
> +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> +        } else {
> +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
> +        }
> +
> +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> +
> +        if (++i >=3D svq->vring_packed.vring.num) {
> +            i =3D 0;
> +            svq->vring_packed.avail_used_flags ^=3D
> +                    1 << VRING_PACKED_DESC_F_AVAIL |
> +                    1 << VRING_PACKED_DESC_F_USED;
> +        }
> +    }
> +
> +    if (i <=3D head) {
> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> +    }
> +
> +    svq->vring_packed.next_avail_idx =3D i;
> +    svq->free_head =3D curr;
> +    return true;
> +}
> +
> +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> +                                const struct iovec *out_sg, size_t out_n=
um,
> +                                const struct iovec *in_sg, size_t in_num=
,
> +                                unsigned *head)
> +{
> +    bool ok;
> +    uint16_t head_flags =3D 0;
> +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> +
> +    *head =3D svq->vring_packed.next_avail_idx;
> +
> +    /* We need some descriptors here */
> +    if (unlikely(!out_num && !in_num)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Guest provided element with no descriptors");
> +        return false;
> +    }
> +
> +    ok =3D vhost_svq_vring_write_descs_packed(svq, sgs, out_sg, out_num,
> +                                            in_sg, in_num, &head_flags);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +

Ok now I see why you switched sgs length from MAX to sum. But if we're
here, why not just embed all vhost_svq_vring_write_descs_packed here?
vhost_svq_vring_write_descs makes sense to split as we repeat the
operation, but I think it adds nothing here. What do you think?

> +    /*
> +     * A driver MUST NOT make the first descriptor in the list
> +     * available before all subsequent descriptors comprising
> +     * the list are made available.
> +     */
> +    smp_wmb();
> +    svq->vring_packed.vring.desc[*head].flags =3D head_flags;
> +
> +    return true;
> +}
> +
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>  {
>      bool needs_kick;
> @@ -258,7 +374,13 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const s=
truct iovec *out_sg,
>          return -ENOSPC;
>      }
>
> -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qem=
u_head);
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> +        ok =3D vhost_svq_add_packed(svq, out_sg, out_num,
> +                                  in_sg, in_num, &qemu_head);
> +    } else {
> +        ok =3D vhost_svq_add_split(svq, out_sg, out_num,
> +                                 in_sg, in_num, &qemu_head);
> +    }
>      if (unlikely(!ok)) {
>          return -EINVAL;
>      }
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 19c842a15b..ee1a87f523 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -46,10 +46,53 @@ typedef struct VhostShadowVirtqueueOps {
>      VirtQueueAvailCallback avail_handler;
>  } VhostShadowVirtqueueOps;
>
> +struct vring_packed {
> +    /* Actual memory layout for this queue. */
> +    struct {
> +        unsigned int num;
> +        struct vring_packed_desc *desc;
> +        struct vring_packed_desc_event *driver;
> +        struct vring_packed_desc_event *device;
> +    } vring;
> +
> +    /* Avail used flags. */
> +    uint16_t avail_used_flags;
> +
> +    /* Index of the next avail descriptor. */
> +    uint16_t next_avail_idx;
> +
> +    /* Driver ring wrap counter */
> +    bool avail_wrap_counter;
> +};
> +
>  /* Shadow virtqueue to relay notifications */
>  typedef struct VhostShadowVirtqueue {
> +    /* Virtio queue shadowing */
> +    VirtQueue *vq;
> +
> +    /* Virtio device */
> +    VirtIODevice *vdev;
> +
> +    /* SVQ vring descriptors state */
> +    SVQDescState *desc_state;
> +
> +    /*
> +     * Backup next field for each descriptor so we can recover securely,=
 not
> +     * needing to trust the device access.
> +     */
> +    uint16_t *desc_next;
> +
> +    /* Next free descriptor */
> +    uint16_t free_head;
> +
> +    /* Size of SVQ vring free descriptors */
> +    uint16_t num_free;
> +

Why the reorder of all of the previous members?

Apart from the nitpicks I don't see anything wrong with this part of
the project. Looking forward to the next!

Thanks!

>      /* Shadow vring */
> -    struct vring vring;
> +    union {
> +        struct vring vring;
> +        struct vring_packed vring_packed;
> +    };
>
>      /* Shadow kick notifier, sent to vhost */
>      EventNotifier hdev_kick;
> @@ -69,27 +112,12 @@ typedef struct VhostShadowVirtqueue {
>      /* Guest's call notifier, where the SVQ calls guest. */
>      EventNotifier svq_call;
>
> -    /* Virtio queue shadowing */
> -    VirtQueue *vq;
> -
> -    /* Virtio device */
> -    VirtIODevice *vdev;
> -
>      /* IOVA mapping */
>      VhostIOVATree *iova_tree;
>
> -    /* SVQ vring descriptors state */
> -    SVQDescState *desc_state;
> -
>      /* Next VirtQueue element that guest made available */
>      VirtQueueElement *next_guest_avail_elem;
>
> -    /*
> -     * Backup next field for each descriptor so we can recover securely,=
 not
> -     * needing to trust the device access.
> -     */
> -    uint16_t *desc_next;
> -
>      /* Caller callbacks */
>      const VhostShadowVirtqueueOps *ops;
>
> @@ -99,17 +127,11 @@ typedef struct VhostShadowVirtqueue {
>      /* Next head to expose to the device */
>      uint16_t shadow_avail_idx;
>
> -    /* Next free descriptor */
> -    uint16_t free_head;
> -
>      /* Last seen used idx */
>      uint16_t shadow_used_idx;
>
>      /* Next head to consume from the device */
>      uint16_t last_used_idx;
> -
> -    /* Size of SVQ vring free descriptors */
> -    uint16_t num_free;
>  } VhostShadowVirtqueue;
>
>  bool vhost_svq_valid_features(uint64_t features, Error **errp);
> --
> 2.45.2
>


