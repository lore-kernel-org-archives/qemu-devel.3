Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E360AC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 18:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJe25-0007AI-DF; Tue, 18 Jun 2024 14:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sJe24-00079Z-L5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 14:58:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sJe1y-0003Mg-0z
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 14:58:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-705d9f4cd7bso3509740b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718737086; x=1719341886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSkiznYhEXENAQlHVHXSFEKuDCwngS71mEUVQSkE0eU=;
 b=LLj4w/G4K7NdNJ2r9Jy1HBSx1K8bqgSehd6+ychXRwm1+YtBEPVMI6tlwniTYxmNL0
 mPMLPabUhv5GCEZeqnQAOQifC1AYnnFneMLBNbL4QPJxF3tcyLbaAUaqI0b9gbcj7prN
 kTbXXN/bHeu09f+/F6w4cZ0RXRxVyvY5qx9iavh6HrfQUARmrmxRv9BzuHEXP4QECng0
 M03MqWKOlp40pc8C4qKUhEup03ROxpi1gpMKKtUqftEbP+Lwv+9vuIqmxFp2aQs2orRE
 7tEuOl+NyB5yZZIa4CiIx1V4Pw8GZS2CO9I8dGEJ+dVb2rlv6B8wXxMpvVTEB/GLcBmI
 7aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737086; x=1719341886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSkiznYhEXENAQlHVHXSFEKuDCwngS71mEUVQSkE0eU=;
 b=Lg7ghM34YzyG1D3IGqdSwsJkajCfPjWSdObGTnzdRxSZRuWtuRCZu2CBpGv+vM2u/R
 ZKN9wf0HsGxQM89Frr4Dqs00+/Iq+bImuXUNLL3rkTaTBpijc21CdY24CCbjx7cEi+0R
 egyJI3/b23YEoFOZGiwWM4Y0L+z75FOQjiBB03P+Rw1XT/1XCzmmcFWc4OMTxt4VaYlU
 sFLrwedcCvGqZiW4r32F0DYTlptiAv00quPaTeipktHWhulPMxm95rEEpoG1pu1O4my7
 JcHOLqi+yBFofM3DxwC/JQR6gL3UtGe7e22T2dVAxV6o6szKL7pjPy8qk5TwDXPTRl/o
 JtuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBHrm0EKVoWQb6I8OLP2KxzgJ7qR8HHgyweHm9vdFLo3FtKM6poWC0urZw+eTCQcK5UWUo5XK0ycbrVUVhlrH+4TMcBrU=
X-Gm-Message-State: AOJu0YzWZ/KYrWMsTbza5g7+uPL8YQBo2dcUtR2oYQTqqBDkEOCMAU1j
 Hw5ForgXiwYSCulGdty41NYLnMn/N1wRx22dbkUqsXSbn78qxDaD
X-Google-Smtp-Source: AGHT+IGX8XHrcR3PJror3hAF0zYo+M4r5Txl876AsDojuRPjgxQ1gV8aSLSKJV4DEpru4nUAk+C7WA==
X-Received: by 2002:a05:6a20:b211:b0:1b5:69cd:87e with SMTP id
 adf61e73a8af0-1bcbb5915eamr365146637.21.1718737086377; 
 Tue, 18 Jun 2024 11:58:06 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.82.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc974330sm9296295b3a.68.2024.06.18.11.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 11:58:05 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: eperezma@redhat.com, sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC] vhost: Introduce packed vq and add buffer elements
Date: Wed, 19 Jun 2024 00:28:02 +0530
Message-ID: <3813507.kQq0lBPeGt@valdaarhun>
In-Reply-To: <20240618181834.14173-1-sahilcdq@proton.me>
References: <20240618181834.14173-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tuesday, June 18, 2024 11:48:34=E2=80=AFPM GMT+5:30 Sahil Siddiq wrote:
> [...]
>
>  hw/virtio/vhost-shadow-virtqueue.c | 124 ++++++++++++++++++++++++++++-
>  hw/virtio/vhost-shadow-virtqueue.h |  66 ++++++++++-----
>  2 files changed, 167 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408f77..e3b276a9e9 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -217,6 +217,122 @@ static bool vhost_svq_add_split(VhostShadowVirtqueu=
e *svq,
>      return true;
>  }
> =20
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

"curr" is being updated here, but descs[i].id is always set to id which doe=
sn't change in
the loop. So all the descriptors in the chain will have the same id. I can'=
t find anything
in the virtio specification [1] that suggests that all descriptors in the c=
hain have the same
id. Also, going by the figure captioned "Three chained descriptors availabl=
e" in the blog
post on packed virtqueues [2], it looks like the descriptors in the chain h=
ave different
buffer ids.

The virtio implementation in Linux also reuses the same id value for all th=
e descriptors in a
single chain. I am not sure if I am missing something here.

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

Even though the same id is used, curr will not be id+1 here.

> +    return true;
> +}
> +
> +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> +                                const struct iovec *out_sg, size_t out_n=
um,
> +                                const struct iovec *in_sg, size_t in_num,
> +                                unsigned *head)
> +{
> +    bool ok;
> +    uint16_t head_flags =3D 0;
> +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);

I chose to use out_num+in_num as the size instead of MAX(ount_num, in_num).=
 I
found it easier to implement "vhost_svq_vring_write_descs_packed()" like th=
is.
Please let me know if this isn't feasible or ideal.

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
> =20
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
> =20
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
>      /* Shadow vring */
> -    struct vring vring;
> +    union {
> +        struct vring vring;
> +        struct vring_packed vring_packed;
> +    };
> =20
>      /* Shadow kick notifier, sent to vhost */
>      EventNotifier hdev_kick;
> @@ -69,27 +112,12 @@ typedef struct VhostShadowVirtqueue {
>      /* Guest's call notifier, where the SVQ calls guest. */
>      EventNotifier svq_call;
> =20
> -    /* Virtio queue shadowing */
> -    VirtQueue *vq;
> -
> -    /* Virtio device */
> -    VirtIODevice *vdev;
> -
>      /* IOVA mapping */
>      VhostIOVATree *iova_tree;
> =20
> -    /* SVQ vring descriptors state */
> -    SVQDescState *desc_state;
> -
>      /* Next VirtQueue element that guest made available */
>      VirtQueueElement *next_guest_avail_elem;
> =20
> -    /*
> -     * Backup next field for each descriptor so we can recover securely,=
 not
> -     * needing to trust the device access.
> -     */
> -    uint16_t *desc_next;
> -
>      /* Caller callbacks */
>      const VhostShadowVirtqueueOps *ops;
> =20
> @@ -99,17 +127,11 @@ typedef struct VhostShadowVirtqueue {
>      /* Next head to expose to the device */
>      uint16_t shadow_avail_idx;
> =20
> -    /* Next free descriptor */
> -    uint16_t free_head;
> -
>      /* Last seen used idx */
>      uint16_t shadow_used_idx;
> =20
>      /* Next head to consume from the device */
>      uint16_t last_used_idx;
> -
> -    /* Size of SVQ vring free descriptors */
> -    uint16_t num_free;
>  } VhostShadowVirtqueue;
> =20
>  bool vhost_svq_valid_features(uint64_t features, Error **errp);
> --=20
> 2.45.2
>

In "struct VhostShadowVirtqueue", I rearranged the order in which some memb=
ers appear.
I tried to keep the members common to split and packed virtqueues above the=
 union and
the rest below the union. I haven't entirely understood the role of some of=
 the members
(for example, VhostShadowVirtqueueOps *ops). I'll change this ordering if n=
eed be as I
continue to understand them better.

=46or the next step, I think I should work on "vhost_svq_start()" which is =
where members of
the struct are actually initialized. At the moment, only the split ring par=
t of the structure is
initialized.

I think I should also start working on enhancing "vhost_svq_kick()" to actu=
ally send the buffers
to the device. I think it'll be easier to test these changes once that's do=
ne (I am not sure about
this though). Would this involve implementing the notification mechanism an=
d event_idx?

Thanks,
Sahil

[1] https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.=
html#x1-720008
[2] https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-vir=
tio



