Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8C5C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 11:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLi0j-0002WS-8O; Mon, 24 Jun 2024 07:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sLi0i-0002WJ-JC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sLi0g-0000to-EP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719229041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kkHQXYFhstTMykWlrAfAEHhlVfXCUVY7/kGEuPXpCY=;
 b=Y4uINMMPDOJ85CIKOoBA6Gx921cw09Qdobgve4dMZR/Zw2PyA9e9+9PbYvxGXeEYKGPs13
 EtVLoNuq+uo9wpLENSBFIWtCmBnCbtgyCPrrwNZhYrXFOyS5IZSjBz4mh5jTqwqhoIuSXL
 IpvQapDF5A3i8ft5iM5rAWo5kvo2wBo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-_eo0cXGROm675fu2MNjVOQ-1; Mon, 24 Jun 2024 07:37:19 -0400
X-MC-Unique: _eo0cXGROm675fu2MNjVOQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-63bb7fb3229so88769807b3.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 04:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719229039; x=1719833839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kkHQXYFhstTMykWlrAfAEHhlVfXCUVY7/kGEuPXpCY=;
 b=S8M/xGk0G3yokm/Cys6qMg5F/p5Mny7eaj5+lSAybmVymlqGiBEBfnUJbCi5WePatr
 Pf6WJLdlZwRqN0M0HqHmHZRpdR+ELDnLBcDP26j7E93l1m7DvxL0Y5AzPp7WHv0e3QlT
 H63QPBJMomqr1/ymLybftKr/s9CBh/SOnjhEScbJdBruQM7u2stUnvnYD41dUCV7NgXV
 iwQaRhTZkmQfcZGW721O0Negi5rnG3msAaTccNb5rD5rxMefIHgUq1/z3NguLHqxY0sk
 xwgrYOdzoeF7PJWoRhG+O2p6JjuVD9WpwbqpEOvTAhIyN2YXPsow/ZYW3TAH/dq93JMM
 3cGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXVwuQu7hBqP5B9yblBl3YYRJTc37PZFclbJm7VrafRktVFkkd8CQ19hYfkAzS0qRljxOdgLq2yKM316nFCZIhLdjv7E4=
X-Gm-Message-State: AOJu0YwWEkzWwsVo+xnzWzPiEq9I0Y6SuCgrKahVZiFK0KQmqvcEEtqw
 bsJvmCHM2NMlCFjFV97ez7khEVvz3NbF/iQZen+QNvZUUUiiADZ83oek2oqqyhvvu7fdbHrZ58Y
 +UlhmgSK3iibN6ra47+WzLPUYn1cHYZeAJxGRbWvxOmKLzr83zRFMmyD0syGyV7JvOSaP5btmG0
 9f7QMLwCUGKw2ocyJMTHMGBqVkg7Y=
X-Received: by 2002:a25:add9:0:b0:dfb:b53:aaf3 with SMTP id
 3f1490d57ef6-e0304042e33mr3436230276.64.1719229038780; 
 Mon, 24 Jun 2024 04:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWtSIoXLGqsFDwmxYDmMC00WH5DAyKjYRrVtyK87R67NaNk2rPjgZJPCdMQ0tZVJH3beWScLMnuQGs9qKUdRo=
X-Received: by 2002:a25:add9:0:b0:dfb:b53:aaf3 with SMTP id
 3f1490d57ef6-e0304042e33mr3436220276.64.1719229038443; Mon, 24 Jun 2024
 04:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240618181834.14173-1-sahilcdq@proton.me>
 <CAJaqyWc8L2rZULeHgqmuieAqmQvePm9sicJFGq+POKPLYQMLJg@mail.gmail.com>
 <3301839.44csPzL39Z@valdaarhun>
In-Reply-To: <3301839.44csPzL39Z@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Jun 2024 13:36:42 +0200
Message-ID: <CAJaqyWeXZ3HAxga1aH4hURnydwZhTMSoV65ReqiX1hVWMRYzbA@mail.gmail.com>
Subject: Re: [RFC] vhost: Introduce packed vq and add buffer elements
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jun 22, 2024 at 6:34=E2=80=AFAM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Wednesday, June 19, 2024 3:49:29=E2=80=AFPM GMT+5:30 Eugenio Perez Mar=
tin wrote:
> > [...]
> > Hi Sahil,
> >
> > Just some nitpicks here and there,
> >
> > > [1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqu=
eue
> > >
> > >  hw/virtio/vhost-shadow-virtqueue.c | 124 +++++++++++++++++++++++++++=
+-
> > >  hw/virtio/vhost-shadow-virtqueue.h |  66 ++++++++++-----
> > >  2 files changed, 167 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> > > b/hw/virtio/vhost-shadow-virtqueue.c index fc5f408f77..e3b276a9e9 100=
644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -217,6 +217,122 @@ static bool vhost_svq_add_split(VhostShadowVirt=
queue *svq,
> > >      return true;
> > >  }
> > >
> > > +/**
> > > + * Write descriptors to SVQ packed vring
> > > + *
> > > + * @svq: The shadow virtqueue
> > > + * @sg: Cache for hwaddr
> > > + * @out_sg: The iovec from the guest that is read-only for device
> > > + * @out_num: iovec length
> > > + * @in_sg: The iovec from the guest that is write-only for device
> > > + * @in_num: iovec length
> > > + * @head_flags: flags for first descriptor in list
> > > + *
> > > + * Return true if success, false otherwise and print error.
> > > + */
> > > +static bool vhost_svq_vring_write_descs_packed(VhostShadowVirtqueue =
*svq, hwaddr *sg,
> > > +                                        const struct iovec *out_sg, =
size_t out_num,
> > > +                                        const struct iovec *in_sg, s=
ize_t in_num,
> > > +                                        uint16_t *head_flags)
> > > +{
> > > +    uint16_t id, curr, head, i;
> > > +    unsigned n;
> > > +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc=
;
> > > +    bool ok;
> > > +
> > > +    head =3D svq->vring_packed.next_avail_idx;
> > > +    i =3D head;
> > > +    id =3D svq->free_head;
> > > +    curr =3D id;
> > > +
> > > +    size_t num =3D out_num + in_num;
> > > +
> > > +    if (num =3D=3D 0) {
> > > +        return true;
> > > +    }
> >
> > num =3D=3D 0 is impossible now, the caller checks for that.
>
> Oh yes, I missed that.
>
> >
> > > +
> > > +    ok =3D vhost_svq_translate_addr(svq, sg, out_sg, out_num);
> > > +    if (unlikely(!ok)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    ok =3D vhost_svq_translate_addr(svq, sg + out_num, in_sg, in_num=
);
> > > +    if (unlikely(!ok)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    for (n =3D 0; n < num; n++) {
> > > +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_=
flags |
> > > +                (n < out_num ? 0 : VRING_DESC_F_WRITE) |
> > > +                (n + 1 =3D=3D num ? 0 : VRING_DESC_F_NEXT));
> > > +        if (i =3D=3D head) {
> > > +            *head_flags =3D flags;
> > > +        } else {
> > > +            descs[i].flags =3D flags;
> > > +        }
> > > +
> > > +        descs[i].addr =3D cpu_to_le64(sg[n]);
> > > +        descs[i].id =3D id;
> > > +        if (n < out_num) {
> > > +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> > > +        } else {
> > > +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len)=
;
> > > +        }
> > > +
> > > +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> > > +
> > > +        if (++i >=3D svq->vring_packed.vring.num) {
> > > +            i =3D 0;
> > > +            svq->vring_packed.avail_used_flags ^=3D
> > > +                    1 << VRING_PACKED_DESC_F_AVAIL |
> > > +                    1 << VRING_PACKED_DESC_F_USED;
> > > +        }
> > > +    }
> > > +
> > > +    if (i <=3D head) {
> > > +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> > > +    }
> > > +
> > > +    svq->vring_packed.next_avail_idx =3D i;
> > > +    svq->free_head =3D curr;
> > > +    return true;
> > > +}
> > > +
> > > +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > > +                                const struct iovec *out_sg, size_t o=
ut_num,
> > > +                                const struct iovec *in_sg, size_t in=
_num,
> > > +                                unsigned *head)
> > > +{
> > > +    bool ok;
> > > +    uint16_t head_flags =3D 0;
> > > +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> > > +
> > > +    *head =3D svq->vring_packed.next_avail_idx;
> > > +
> > > +    /* We need some descriptors here */
> > > +    if (unlikely(!out_num && !in_num)) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "Guest provided element with no descriptors");
> > > +        return false;
> > > +    }
> > > +
> > > +    ok =3D vhost_svq_vring_write_descs_packed(svq, sgs, out_sg, out_=
num,
> > > +                                            in_sg, in_num, &head_fla=
gs);
> > > +    if (unlikely(!ok)) {
> > > +        return false;
> > > +    }
> > > +
> >
> > Ok now I see why you switched sgs length from MAX to sum. But if we're
> > here, why not just embed all vhost_svq_vring_write_descs_packed here?
> > vhost_svq_vring_write_descs makes sense to split as we repeat the
> > operation, but I think it adds nothing here. What do you think?
>
> You're right. The function is called only once and there is nothing to re=
use.
> I'll move "vhost_svq_vring_write_descs_packed" to "vhost_svq_add_packed".
>
> > > [...]
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.h
> > > b/hw/virtio/vhost-shadow-virtqueue.h index 19c842a15b..ee1a87f523 100=
644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.h
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.h
> > > @@ -46,10 +46,53 @@ typedef struct VhostShadowVirtqueueOps {
> > >
> > >      VirtQueueAvailCallback avail_handler;
> > >
> > >  } VhostShadowVirtqueueOps;
> > >
> > > +struct vring_packed {
> > > +    /* Actual memory layout for this queue. */
> > > +    struct {
> > > +        unsigned int num;
> > > +        struct vring_packed_desc *desc;
> > > +        struct vring_packed_desc_event *driver;
> > > +        struct vring_packed_desc_event *device;
> > > +    } vring;
> > > +
> > > +    /* Avail used flags. */
> > > +    uint16_t avail_used_flags;
> > > +
> > > +    /* Index of the next avail descriptor. */
> > > +    uint16_t next_avail_idx;
> > > +
> > > +    /* Driver ring wrap counter */
> > > +    bool avail_wrap_counter;
> > > +};
> > > +
> > >
> > >  /* Shadow virtqueue to relay notifications */
> > >  typedef struct VhostShadowVirtqueue {
> > >
> > > +    /* Virtio queue shadowing */
> > > +    VirtQueue *vq;
> > > +
> > > +    /* Virtio device */
> > > +    VirtIODevice *vdev;
> > > +
> > > +    /* SVQ vring descriptors state */
> > > +    SVQDescState *desc_state;
> > > +
> > > +    /*
> > > +     * Backup next field for each descriptor so we can recover secur=
ely,
> > > not +     * needing to trust the device access.
> > > +     */
> > > +    uint16_t *desc_next;
> > > +
> > > +    /* Next free descriptor */
> > > +    uint16_t free_head;
> > > +
> > > +    /* Size of SVQ vring free descriptors */
> > > +    uint16_t num_free;
> > > +
> >
> > Why the reorder of all of the previous members?
>
> I was thinking of placing all the members that are common to packed and
> split vring above the union while leaving the remaining members below the
> union. I did this based on our discussion here [1]. I don't think this re=
ordering
> serves any purpose implementation-wise. Please let me know if I should re=
vert
> this change.
>

I'm not against the change, but removing superfluous changes helps the
reviewing. If you send the reordering, please use a separate patch so
it's easier to review.

Thanks!

> > Apart from the nitpicks I don't see anything wrong with this part of
> > the project. Looking forward to the next!
> >
>
> Thank you for the review.
>
> Thanks,
> Sahil
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg02591.htm=
l
>
>


