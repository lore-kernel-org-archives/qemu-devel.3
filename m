Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A278CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 16:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsQ3E-0005p7-Nt; Thu, 04 Apr 2024 12:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsQ2z-0005oF-Ja
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsQ2x-0008Qq-2L
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712248478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDuItuItuDphBBozinPM0R3kD6Bi88c5hDbn1dOvfdo=;
 b=FS6Z2TuKxtBgyz/2Kf1+M950pbhdZtWfkI3tyqI+RYTevfqfhifhzn2/jguxYkGP5/oV32
 byG5b4cr4fouMMa+6iw5G8Pubtvieeo1DU8+Eqx8N6CeYt78nMrEIEr5ZrPmFhjhfuKQGz
 8RQUWDDlQ9d2HGP9scynm/4Wb/9FHNs=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-OIh9H1sDMCq9_QRMrcU4Fg-1; Thu, 04 Apr 2024 12:34:36 -0400
X-MC-Unique: OIh9H1sDMCq9_QRMrcU4Fg-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcc05887ee9so1808325276.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 09:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712248475; x=1712853275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDuItuItuDphBBozinPM0R3kD6Bi88c5hDbn1dOvfdo=;
 b=XsjJb3VWlwadRf4zw1lPKBEvCBaeuCYVmcObzSdJADgg2rrAakWjQAO07wSKk+ysZo
 /uhjiIP3spbCZrSwqcwiSvnMxtpQ8Ca2mvsgeXyDdwOov1oANKrPOdCujJgvyNjaGjK2
 Xo7eSG4x4Ts8N+4IlnL3SVzirL+4zUH569k+MsLFOg8+JV+qCnpWXJhFmTF5UU9CocEc
 y7uIw3mZQ4BeHUQC9oP6CsSJOyosx/1reM9OK+B5fWdQqeEz597KOlmrzYqoLLU2RjHf
 iFecxNzWckSGz21biFVuC/g1zAJ6MTy+t+RS0FXhxVRtu0/8fsBtzXhD4jYbYW3gLV/+
 LLuA==
X-Gm-Message-State: AOJu0YwMfdr+ymBCLt9IvWsmCP6sf+yJE7yT1GeSPZQzsx/WNSFeEVyN
 qtefD1zBWiu7lrUJbzMUjSJcWMi2CvkexD+Q5YFB6AAyXUkV4ZfJMLqIiPG255IwzZVYpxOBU6C
 fuFQAOfyuppiPc1gDZkyWxpv0y1XbowT7gEHoxpGktwiJtuZcDsW8GRMsIESlzQOD/oth7pX8Mi
 BbixShmo/Naaj1uU/wnk+DexQMp8Y=
X-Received: by 2002:a5b:18e:0:b0:dd1:3cc1:5352 with SMTP id
 r14-20020a5b018e000000b00dd13cc15352mr2853340ybl.15.1712248475485; 
 Thu, 04 Apr 2024 09:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn3hQmF1aWRvabYCbooNUs/Q37TRz20cluy69J5S95SrZmzBRiTSy7ex+yHJG7c+gGfZ/tBBIJnp4xgaJq4Ic=
X-Received: by 2002:a5b:18e:0:b0:dd1:3cc1:5352 with SMTP id
 r14-20020a5b018e000000b00dd13cc15352mr2853316ybl.15.1712248475040; Thu, 04
 Apr 2024 09:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240328162203.3775114-1-jonah.palmer@oracle.com>
 <20240328162203.3775114-2-jonah.palmer@oracle.com>
 <CAJaqyWdyZdu48+cZ2umafLRi9NTz3YHxSxmyq6SD9d4noTR2jQ@mail.gmail.com>
 <768ffc05-333a-4f00-9944-940bcaca59fd@oracle.com>
 <CAJaqyWe3bw6WML9MLEhnpNuWL0_HUQJ4WrSyr1jnGHs6Jwn0-Q@mail.gmail.com>
 <42b8e8bf-ecfb-4633-b1b6-a33435f81cdc@oracle.com>
In-Reply-To: <42b8e8bf-ecfb-4633-b1b6-a33435f81cdc@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 4 Apr 2024 18:33:58 +0200
Message-ID: <CAJaqyWf1=v7V-SzmbRCQo-DzuOKCQK2u5E9XVFV877Z5choVig@mail.gmail.com>
Subject: Re: [RFC v2 1/5] virtio: Initialize sequence variables
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Apr 4, 2024 at 4:42=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
>
>
> On 4/4/24 7:35 AM, Eugenio Perez Martin wrote:
> > On Wed, Apr 3, 2024 at 6:51=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >>
> >>
> >>
> >> On 4/3/24 6:18 AM, Eugenio Perez Martin wrote:
> >>> On Thu, Mar 28, 2024 at 5:22=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>> Initialize sequence variables for VirtQueue and VirtQueueElement
> >>>> structures. A VirtQueue's sequence variables are initialized when a
> >>>> VirtQueue is being created or reset. A VirtQueueElement's sequence
> >>>> variable is initialized when a VirtQueueElement is being initialized=
.
> >>>> These variables will be used to support the VIRTIO_F_IN_ORDER featur=
e.
> >>>>
> >>>> A VirtQueue's used_seq_idx represents the next expected index in a
> >>>> sequence of VirtQueueElements to be processed (put on the used ring)=
.
> >>>> The next VirtQueueElement added to the used ring must match this
> >>>> sequence number before additional elements can be safely added to th=
e
> >>>> used ring. It's also particularly useful for helping find the number=
 of
> >>>> new elements added to the used ring.
> >>>>
> >>>> A VirtQueue's current_seq_idx represents the current sequence index.
> >>>> This value is essentially a counter where the value is assigned to a=
 new
> >>>> VirtQueueElement and then incremented. Given its uint16_t type, this
> >>>> sequence number can be between 0 and 65,535.
> >>>>
> >>>> A VirtQueueElement's seq_idx represents the sequence number assigned=
 to
> >>>> the VirtQueueElement when it was created. This value must match with=
 the
> >>>> VirtQueue's used_seq_idx before the element can be put on the used r=
ing
> >>>> by the device.
> >>>>
> >>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>> ---
> >>>>    hw/virtio/virtio.c         | 18 ++++++++++++++++++
> >>>>    include/hw/virtio/virtio.h |  1 +
> >>>>    2 files changed, 19 insertions(+)
> >>>>
> >>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>>> index fb6b4ccd83..069d96df99 100644
> >>>> --- a/hw/virtio/virtio.c
> >>>> +++ b/hw/virtio/virtio.c
> >>>> @@ -132,6 +132,10 @@ struct VirtQueue
> >>>>        uint16_t used_idx;
> >>>>        bool used_wrap_counter;
> >>>>
> >>>> +    /* In-Order sequence indices */
> >>>> +    uint16_t used_seq_idx;
> >>>> +    uint16_t current_seq_idx;
> >>>> +
> >>>
> >>> I'm having a hard time understanding the difference between these and
> >>> last_avail_idx and used_idx. It seems to me if we replace them
> >>> everything will work? What am I missing?
> >>>
> >>
> >> For used_seq_idx, it does work like used_idx except the difference is
> >> when their values get updated, specifically for the split VQ case.
> >>
> >> As you know, for the split VQ case, the used_idx is updated during
> >> virtqueue_split_flush. However, imagine a batch of elements coming in
> >> where virtqueue_split_fill is called multiple times before
> >> virtqueue_split_flush. We want to make sure we write these elements to
> >> the used ring in-order and we'll know its order based on used_seq_idx.
> >>
> >> Alternatively, I thought about replicating the logic for the packed VQ
> >> case (where this used_seq_idx isn't used) where we start looking at
> >> vq->used_elems[vq->used_idx] and iterate through until we find a used
> >> element, but I wasn't sure how to handle the case where elements get
> >> used (written to the used ring) and new elements get put in used_elems
> >> before the used_idx is updated. Since this search would require us to
> >> always start at index vq->used_idx.
> >>
> >> For example, say, of three elements getting filled (elem0 - elem2),
> >> elem1 and elem0 come back first (vq->used_idx =3D 0):
> >>
> >> elem1 - not in-order
> >> elem0 - in-order, vq->used_elems[vq->used_idx + 1] (elem1) also now
> >>           in-order, write elem0 and elem1 to used ring, mark elements =
as
> >>           used
> >>
> >> Then elem2 comes back, but vq->used_idx is still 0, so how do we know =
to
> >> ignore the used elements at vq->used_idx (elem0) and vq->used_idx + 1
> >> (elem1) and iterate to vq->used_idx + 2 (elem2)?
> >>
> >> Hmm... now that I'm thinking about it, maybe for the split VQ case we
> >> could continue looking through the vq->used_elems array until we find =
an
> >> unused element... but then again how would we (1) know if the element =
is
> >> in-order and (2) know when to stop searching?
> >>
> >
> > Ok I think I understand the problem now. It is aggravated if we add
> > chained descriptors to the mix.
> >
> > We know that the order of used descriptors must be the exact same as
> > the order they were made available, leaving out in order batching.
> > What if vq->used_elems at virtqueue_pop and then virtqueue_push just
> > marks them as used somehow? Two booleans (or flag) would do for a
> > first iteration.
> >
> > If we go with this approach I think used_elems should be renamed actual=
ly.
> >
>
> If I'm understanding correctly, I don't think adding newly created
> elements to vq->used_elems at virtqueue_pop will do much for us.

By knowing what descriptor id must go in each position of the used ring.

Following your example, let's say avail_idx is 10 at that moment.
Then, the driver makes available the three elements you mention, so:
used_elems[10] =3D elem0
used_elems[11] =3D elem1
used_elems[12] =3D elem2

Now the device uses elem1. virtqueue_push can search linearly for
elem->index in used_elems[used_idx]...used_elems[avail_idx] range. As
the device is mis-behaving, no need to optimize this behavior.
used_elems[11].index =3D=3D elem->index, so we mark it as used somehow.
Let's say we add a boolean to VirtQueueElement.

virtqueue_flush can scan used_elems[used_idx]...used_elems[avail_idx]
looking for used elements. At this moment used_elems[used_idx] is not
used so it stops there.

Now elem0 is pushed. It is the first one in the
used_elems[used_idx]...used_elems[avail_idx] range, so we can write it
to the used ring at fill. used_idx++. We use the rest of the
descriptor until we find one in used_elems that is not used, which is
used_elems[12].

After that virtqueue_flush is called. At its scanning, used_elems[10]
is used, so it writes it to the used ring. After that, used_elems[11]
is also used, so it is written also. used_elems[12] is not used, so it
stops there.

Finally, elem2 is pushed, so used_elems[12] is written.
virtqueue_flush detects it, so it writes it to the guest's used ring.

Let me know what you think. I find it simpler than declaring new
indexes, but I may be wrong.

This makes it difficult to actually batch used descriptors. My
proposal is to address it in another series, by delegating it to the
caller and recovering proper usage of virtqueue_push(idx) parameter.
The caller can specify either to batch as usual, or to delegate the
automatic (and potentially inefficient) ordering I'm proposing here.

> We
> could just keep adding processed elements to vq->used_elems at
> virtqueue_fill but instead of:
>
> vq->used_elems[seq_idx].in_num =3D elem->in_num;
> vq->used_elems[seq_idx].out_num =3D elem->out_num;
>
> We could do:
>
> vq->used_elems[seq_idx].in_num =3D 1;
> vq->used_elems[seq_idx].out_num =3D 1;
>
> We'd use in_num and out_num as separate flags. in_num could indicate if
> this element has been written to the used ring while out_num could
> indicate if this element has been flushed (1 for no, 0 for yes). In
> other words, when we go to write to the used ring, start at index
> vq->used_idx and iterate through the used elements.
>
> If a used element's in_num and out_num =3D=3D 0, then this element is
> invalid (not yet processed) and we stop the search.
>
> If a used element's in_num and out_num =3D=3D 1, then this element is val=
id,
> written to the used ring, in_num is set to 0, and the search continues.
>
> Lastly, if a used element's in_num =3D=3D 0 but out_num =3D=3D 1, then th=
is
> element has already been written to the used ring but not yet flushed,
> so ignore this element and continue searching.
>
> There should never be a case where in_num =3D=3D 1 and out_num =3D=3D 0.
>
> However, this would probably mean that before (or right after) we
> actually perform the flush we'll have to iterate through the used_elems
> array one more time and set their out_num's to 0 to indicate the element
> has been flushed.
>
> Again, this is just for the batched split VQ case where we have to keep
> track of elements that have been written but not flushed and elements
> that have been written and flushed, given that we don't know which
> elements have actually been written to the used ring until the used_idx
> is updated.
>
> This approach appears more costly though if we're really trying to avoid
> having this new used_seq_idx VirtQueue member.
>
> >> In any case, the use of this variable could be seen as an optimization
> >> as its value will tell us where to start looking in vq->used_elems
> >> instead of always starting at vq->used_idx.
> >>
> >> If this is like a one-shot scenario where one element gets written and
> >> then flushed after, then yes in this case used_seq_idx =3D=3D used_idx=
.
> >>
> >> ------
> >>
> >> For current_seq_idx, this is pretty much just a counter. Every new
> >> VirtQueueElement created from virtqueue_pop is given a number and the
> >> counter is incremented. Like grabbing a ticket number and waiting for
> >> your number to be called. The next person to grab a ticket number will
> >> be your number + 1.
> >>
> >
> > So it's like last_avail_idx, isn't it?
> >
>
> For the split VQ case, pretty much. Though if we hit this case in
> virtqueue_split_pop, we may get into some trouble:
>
> if (!virtqueue_get_head(vq, vq->last_avail_idx++, &head)) {
>      goto done;
> }
>

That's a fatal mistake and the device breaks, vdev->broken =3D true. It
cannot be used anymore from that point on, because of all the checks
of that variable.

Does that solve the problem?

> However for the packed VQ case, last_avail_idx might not work in the way
> we'd need it to for this implementation. In virtqueue_packed_pop, we see
> this:
>
> elem->ndescs =3D (desc_cache =3D=3D &indirect_desc_cache) ? 1 : elem_entr=
ies;
> vq->last_avail_idx +=3D elem->ndescs;
>
> It would appear as though last_avail_idx is incremented by total number
> of descriptors associated with the element, which can be greater than 1.
> This implementation increments by 1 for each element.
>
> Actually... It's good you mentioned this because I think my packed VQ
> implementation is wrong. For packed VQs, vq->used_idx is incremented by
> the total number of descriptors in the flushed elements and not
> necessarily the number of elements being flushed like in the split VQ
> case. I'm adding elements to vq->used_elems in a per-element sequence
> rather than going by the number of descriptors an element holds, which
> should be the case for packed VQs.
>

If you keep it by your proposed index I think you can increase it one
per head, as they are the entries that are written in both cases.
unsed_idx should increment properly already.

If you move to my proposal, both should increase by elem->ndescs as
you suggest here.

> >> Let me know if I'm making any sense. Thanks :)
> >>
> >> Jonah
> >>
> >>>>        /* Last used index value we have signalled on */
> >>>>        uint16_t signalled_used;
> >>>>
> >>>> @@ -1621,6 +1625,11 @@ static void *virtqueue_split_pop(VirtQueue *v=
q, size_t sz)
> >>>>            elem->in_sg[i] =3D iov[out_num + i];
> >>>>        }
> >>>>
> >>>> +    /* Assign sequence index for in-order processing */
> >>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> >>>> +        elem->seq_idx =3D vq->current_seq_idx++;
> >>>> +    }
> >>>> +
> >>>>        vq->inuse++;
> >>>>
> >>>>        trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> >>>> @@ -1760,6 +1769,11 @@ static void *virtqueue_packed_pop(VirtQueue *=
vq, size_t sz)
> >>>>        vq->shadow_avail_idx =3D vq->last_avail_idx;
> >>>>        vq->shadow_avail_wrap_counter =3D vq->last_avail_wrap_counter=
;
> >>>>
> >>>> +    /* Assign sequence index for in-order processing */
> >>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> >>>> +        elem->seq_idx =3D vq->current_seq_idx++;
> >>>> +    }
> >>>> +
> >>>>        trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> >>>>    done:
> >>>>        address_space_cache_destroy(&indirect_desc_cache);
> >>>> @@ -2087,6 +2101,8 @@ static void __virtio_queue_reset(VirtIODevice =
*vdev, uint32_t i)
> >>>>        vdev->vq[i].notification =3D true;
> >>>>        vdev->vq[i].vring.num =3D vdev->vq[i].vring.num_default;
> >>>>        vdev->vq[i].inuse =3D 0;
> >>>> +    vdev->vq[i].used_seq_idx =3D 0;
> >>>> +    vdev->vq[i].current_seq_idx =3D 0;
> >>>>        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> >>>>    }
> >>>>
> >>>> @@ -2334,6 +2350,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev=
, int queue_size,
> >>>>        vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
> >>>>        vdev->vq[i].handle_output =3D handle_output;
> >>>>        vdev->vq[i].used_elems =3D g_new0(VirtQueueElement, queue_siz=
e);
> >>>> +    vdev->vq[i].used_seq_idx =3D 0;
> >>>> +    vdev->vq[i].current_seq_idx =3D 0;
> >>>>
> >>>>        return &vdev->vq[i];
> >>>>    }
> >>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >>>> index b3c74a1bca..910b2a3427 100644
> >>>> --- a/include/hw/virtio/virtio.h
> >>>> +++ b/include/hw/virtio/virtio.h
> >>>> @@ -75,6 +75,7 @@ typedef struct VirtQueueElement
> >>>>        hwaddr *out_addr;
> >>>>        struct iovec *in_sg;
> >>>>        struct iovec *out_sg;
> >>>> +    uint16_t seq_idx;
> >>>>    } VirtQueueElement;
> >>>>
> >>>>    #define VIRTIO_QUEUE_MAX 1024
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>
> >>
> >
>


