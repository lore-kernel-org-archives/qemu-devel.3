Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCCBC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 15:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsl86-00088L-DP; Fri, 05 Apr 2024 11:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsl84-00085L-7e
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 11:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsl7y-0006wR-PU
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 11:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712329511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWOYiiCHwzVgoOLVC4CToKOiLp0LHQES+h7HDBozRXI=;
 b=fG8nK6Eorq00IMu0rdbWXheGuZrzHEJUJY2k+hsgHbSpaw1yU603j4iLxk3CCW0zi7UQW1
 xEXmscxKUVBmRd14xriMsRE9SJYxvTyQVv9nuT3rFAoNdIt2xehv0XxSFnhw4Q6+QzMSEd
 shAfjqclm8CQfaXJcQ26RNoYsRASgGE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-W82R9P_pPHS7cm-uJTNqzA-1; Fri, 05 Apr 2024 11:05:10 -0400
X-MC-Unique: W82R9P_pPHS7cm-uJTNqzA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-611e89cf3b5so36187197b3.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 08:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712329509; x=1712934309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWOYiiCHwzVgoOLVC4CToKOiLp0LHQES+h7HDBozRXI=;
 b=FU3DI1Dj1YPv2/dKKgh31EzFkj0TsXlfIcETfwG+RLiI/oN+QTty2jzaTBEJUQcIph
 ghTRNpDzDFUhAdcwDeOe8IwbxlOIDdgxWD5ImAhyfxO9hPo6SNXhvaUKm5lcYKGe51Xl
 xEx5biCCTppRRtuCbALZWH3ovGt3Qj4SFfj4177qiXW624gk4IJog1kX8j1utMsBh82o
 4emRMCavIz1PvSZ2p/wnhD0Xh+oH5YUKdtLhiidCl1LVxurNMAV+1rs0hoULfTIlMSzc
 0jZ1lC5HmfmxE6JiDAjprgCFlB1ITKY6sP/9JcOjbcefxLsKJLDoT41D+uihppcJYVcq
 QJ+A==
X-Gm-Message-State: AOJu0YxyqZE9fJaVhh7iR7t7ALgaoYIpt5+yKxRhDKWfHWIMFrKgTwHO
 0YrWvqKSKpHyoesjnW7urSxmX+lXm2pz1FOUWfGvJXYWfvhWHDTFHXToukpWMlli2mK6p/vuPaV
 +x8xvrr/tVwFEE6WdqADTC6aC+QRf82RAyeWpt7S9u7zd+qHumX0hY3QApDc2oUX8P9utXu4wbv
 No3sN6By7C4Z1tkZKP/aCbMdfBWtM=
X-Received: by 2002:a25:e481:0:b0:dc7:594b:f72b with SMTP id
 b123-20020a25e481000000b00dc7594bf72bmr1489424ybh.39.1712329509298; 
 Fri, 05 Apr 2024 08:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3DRjacfL6nyzKBLbrinceRTbQj67/TC5FI/ky+cP5MjrpKYiT2o5842q2oqagX/jX43Cwt15Ea3sjAL7ufGE=
X-Received: by 2002:a25:e481:0:b0:dc7:594b:f72b with SMTP id
 b123-20020a25e481000000b00dc7594bf72bmr1489381ybh.39.1712329508794; Fri, 05
 Apr 2024 08:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240328162203.3775114-1-jonah.palmer@oracle.com>
 <20240328162203.3775114-2-jonah.palmer@oracle.com>
 <CAJaqyWdyZdu48+cZ2umafLRi9NTz3YHxSxmyq6SD9d4noTR2jQ@mail.gmail.com>
 <768ffc05-333a-4f00-9944-940bcaca59fd@oracle.com>
 <CAJaqyWe3bw6WML9MLEhnpNuWL0_HUQJ4WrSyr1jnGHs6Jwn0-Q@mail.gmail.com>
 <42b8e8bf-ecfb-4633-b1b6-a33435f81cdc@oracle.com>
 <CAJaqyWf1=v7V-SzmbRCQo-DzuOKCQK2u5E9XVFV877Z5choVig@mail.gmail.com>
 <c1e78d58-53bb-4091-b775-3d4a004a8bfd@oracle.com>
In-Reply-To: <c1e78d58-53bb-4091-b775-3d4a004a8bfd@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Apr 2024 17:04:32 +0200
Message-ID: <CAJaqyWdZQpYUK=bNe1UsV-5F+U=JC3rkN6YEYxid-Zmha+WCpQ@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 5, 2024 at 3:59=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
>
>
> On 4/4/24 12:33 PM, Eugenio Perez Martin wrote:
> > On Thu, Apr 4, 2024 at 4:42=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >>
> >>
> >>
> >> On 4/4/24 7:35 AM, Eugenio Perez Martin wrote:
> >>> On Wed, Apr 3, 2024 at 6:51=E2=80=AFPM Jonah Palmer <jonah.palmer@ora=
cle.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/3/24 6:18 AM, Eugenio Perez Martin wrote:
> >>>>> On Thu, Mar 28, 2024 at 5:22=E2=80=AFPM Jonah Palmer <jonah.palmer@=
oracle.com> wrote:
> >>>>>>
> >>>>>> Initialize sequence variables for VirtQueue and VirtQueueElement
> >>>>>> structures. A VirtQueue's sequence variables are initialized when =
a
> >>>>>> VirtQueue is being created or reset. A VirtQueueElement's sequence
> >>>>>> variable is initialized when a VirtQueueElement is being initializ=
ed.
> >>>>>> These variables will be used to support the VIRTIO_F_IN_ORDER feat=
ure.
> >>>>>>
> >>>>>> A VirtQueue's used_seq_idx represents the next expected index in a
> >>>>>> sequence of VirtQueueElements to be processed (put on the used rin=
g).
> >>>>>> The next VirtQueueElement added to the used ring must match this
> >>>>>> sequence number before additional elements can be safely added to =
the
> >>>>>> used ring. It's also particularly useful for helping find the numb=
er of
> >>>>>> new elements added to the used ring.
> >>>>>>
> >>>>>> A VirtQueue's current_seq_idx represents the current sequence inde=
x.
> >>>>>> This value is essentially a counter where the value is assigned to=
 a new
> >>>>>> VirtQueueElement and then incremented. Given its uint16_t type, th=
is
> >>>>>> sequence number can be between 0 and 65,535.
> >>>>>>
> >>>>>> A VirtQueueElement's seq_idx represents the sequence number assign=
ed to
> >>>>>> the VirtQueueElement when it was created. This value must match wi=
th the
> >>>>>> VirtQueue's used_seq_idx before the element can be put on the used=
 ring
> >>>>>> by the device.
> >>>>>>
> >>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>>>> ---
> >>>>>>     hw/virtio/virtio.c         | 18 ++++++++++++++++++
> >>>>>>     include/hw/virtio/virtio.h |  1 +
> >>>>>>     2 files changed, 19 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>>>>> index fb6b4ccd83..069d96df99 100644
> >>>>>> --- a/hw/virtio/virtio.c
> >>>>>> +++ b/hw/virtio/virtio.c
> >>>>>> @@ -132,6 +132,10 @@ struct VirtQueue
> >>>>>>         uint16_t used_idx;
> >>>>>>         bool used_wrap_counter;
> >>>>>>
> >>>>>> +    /* In-Order sequence indices */
> >>>>>> +    uint16_t used_seq_idx;
> >>>>>> +    uint16_t current_seq_idx;
> >>>>>> +
> >>>>>
> >>>>> I'm having a hard time understanding the difference between these a=
nd
> >>>>> last_avail_idx and used_idx. It seems to me if we replace them
> >>>>> everything will work? What am I missing?
> >>>>>
> >>>>
> >>>> For used_seq_idx, it does work like used_idx except the difference i=
s
> >>>> when their values get updated, specifically for the split VQ case.
> >>>>
> >>>> As you know, for the split VQ case, the used_idx is updated during
> >>>> virtqueue_split_flush. However, imagine a batch of elements coming i=
n
> >>>> where virtqueue_split_fill is called multiple times before
> >>>> virtqueue_split_flush. We want to make sure we write these elements =
to
> >>>> the used ring in-order and we'll know its order based on used_seq_id=
x.
> >>>>
> >>>> Alternatively, I thought about replicating the logic for the packed =
VQ
> >>>> case (where this used_seq_idx isn't used) where we start looking at
> >>>> vq->used_elems[vq->used_idx] and iterate through until we find a use=
d
> >>>> element, but I wasn't sure how to handle the case where elements get
> >>>> used (written to the used ring) and new elements get put in used_ele=
ms
> >>>> before the used_idx is updated. Since this search would require us t=
o
> >>>> always start at index vq->used_idx.
> >>>>
> >>>> For example, say, of three elements getting filled (elem0 - elem2),
> >>>> elem1 and elem0 come back first (vq->used_idx =3D 0):
> >>>>
> >>>> elem1 - not in-order
> >>>> elem0 - in-order, vq->used_elems[vq->used_idx + 1] (elem1) also now
> >>>>            in-order, write elem0 and elem1 to used ring, mark elemen=
ts as
> >>>>            used
> >>>>
> >>>> Then elem2 comes back, but vq->used_idx is still 0, so how do we kno=
w to
> >>>> ignore the used elements at vq->used_idx (elem0) and vq->used_idx + =
1
> >>>> (elem1) and iterate to vq->used_idx + 2 (elem2)?
> >>>>
> >>>> Hmm... now that I'm thinking about it, maybe for the split VQ case w=
e
> >>>> could continue looking through the vq->used_elems array until we fin=
d an
> >>>> unused element... but then again how would we (1) know if the elemen=
t is
> >>>> in-order and (2) know when to stop searching?
> >>>>
> >>>
> >>> Ok I think I understand the problem now. It is aggravated if we add
> >>> chained descriptors to the mix.
> >>>
> >>> We know that the order of used descriptors must be the exact same as
> >>> the order they were made available, leaving out in order batching.
> >>> What if vq->used_elems at virtqueue_pop and then virtqueue_push just
> >>> marks them as used somehow? Two booleans (or flag) would do for a
> >>> first iteration.
> >>>
> >>> If we go with this approach I think used_elems should be renamed actu=
ally.
> >>>
> >>
> >> If I'm understanding correctly, I don't think adding newly created
> >> elements to vq->used_elems at virtqueue_pop will do much for us.
> >
> > By knowing what descriptor id must go in each position of the used ring=
.
> >
> > Following your example, let's say avail_idx is 10 at that moment.
> > Then, the driver makes available the three elements you mention, so:
> > used_elems[10] =3D elem0
> > used_elems[11] =3D elem1
> > used_elems[12] =3D elem2
> >
> > Now the device uses elem1. virtqueue_push can search linearly for
> > elem->index in used_elems[used_idx]...used_elems[avail_idx] range. As
> > the device is mis-behaving, no need to optimize this behavior.
> > used_elems[11].index =3D=3D elem->index, so we mark it as used somehow.
> > Let's say we add a boolean to VirtQueueElement.
> >
> > virtqueue_flush can scan used_elems[used_idx]...used_elems[avail_idx]
> > looking for used elements. At this moment used_elems[used_idx] is not
> > used so it stops there.
> >
> > Now elem0 is pushed. It is the first one in the
> > used_elems[used_idx]...used_elems[avail_idx] range, so we can write it
> > to the used ring at fill. used_idx++. We use the rest of the
> > descriptor until we find one in used_elems that is not used, which is
> > used_elems[12].
> >
> > After that virtqueue_flush is called. At its scanning, used_elems[10]
> > is used, so it writes it to the used ring. After that, used_elems[11]
> > is also used, so it is written also. used_elems[12] is not used, so it
> > stops there.
> >
> > Finally, elem2 is pushed, so used_elems[12] is written.
> > virtqueue_flush detects it, so it writes it to the guest's used ring.
> >
> > Let me know what you think. I find it simpler than declaring new
> > indexes, but I may be wrong.
> >
>
> I think I see where you're getting at, but I just have a few clarifying
> questions about your proposal here.
>
> So you're proposing to add entries to used_elems at virtqueue_pop, ok.
>
> avail_idx =3D 10, then the driver makes some new entries (elems) availabl=
e
> in the avail ring:
>
> used_elems[10] =3D elem0
> used_elems[11] =3D elem1
> used_elems[12] =3D elem2
>
> At this point, avail_idx =3D 13, used_idx =3D 10.
>
> elem1 gets used first, ok.
>
> Now, if I'm understanding correctly, you're saying that in
> virtqueue_push explicitly (not virtqueue_fill/virtqueue_flush), we scan
> used_elems[used_idx] - used_elems[avail_idx] to find used_elems[i].index
> =3D=3D elem->index and mark it as used, e.g. used_elems[i].used =3D true.
> Okay, now used_elems[11] has been marked as used.
>
> Now we make it to virtqueue_fill. What's the role you want
> virtqueue_fill to take here (if any)?
>

Sorry I meant virtqueue_fill here.

> You say that after we mark this element as used, we go to
> virtqueue_flush and scan for used elements in used_elems[used_idx] -
> used_elems[avail_idx]. Of course, the first one of this order will be in
> used_elems[used_idx], which is currently showing the element as unused,
> so we're done with this element for now.
>
> So, what exactly is the role of virtqueue_flush here? I'm inferring here
> that you want the virtqueue_flush role (for split VQs) to do both the
> writing to the used ring (normally done in virtqueue_fill) as well as
> updating the used_idx (normally done in virtqueue_flush). Is this correct=
?
>

I modelled this after the packed vq scenario, where all is updated at
_flush. But yes, I think you got it totally right.

> Next, elem0 gets used second.
>
> Again, in virtqueue_push we scan scan used_elems[used_idx] -
> used_elems[avail_idx] to find used_elems[i].index =3D=3D elem->index and
> mark it as used. Okay, used_elems[10] has been marked as used.
>
> Then you say, "It is the first one in the used_elems[used_idx] -
> used_elems[avail_idx] range, so we can write it to the used ring at
> fill. used_idx++. We use the rest of the descriptor until we find one in
> used_elems that is not used, which is used_elems[12]."
>
> This, to me, sounds like "in virtqueue_fill, when we find an order (e.g.
> used_elems[used_idx].index =3D=3D elem->index) write it to the used ring =
AND
> increment the used_idx. Keep writing elements to the used ring if
> used_elems[used_idx].used =3D=3D true and, for each element being written=
,
> incremented used_idx."
>
> This is a bit confusing to me since next you say "After that,
> virtqueue_flush is called. At its scanning, used_elems[10] is used, so
> it writes it to the used ring. After that, used_elems[11] is also used,
> so it is written also. used_elems[12] is not used, so it stops there."
>
> This sounds very similar to what you proposed for virtqueue_fill, except
> it looks like you're also saying to do this in virtqueue_flush, hence my
> confusion.
>
> If you wouldn't mind, could you clarify the roles of virtqueue_fill and
> virtqueue_flush here for me? Thanks :)!
>

I see how they're confusing if following the split vq way, sorry!
* _fill: Only update used_elems (or equivalent)
* _flush: Write information to used ring or descriptor ring.

> > This makes it difficult to actually batch used descriptors. My
> > proposal is to address it in another series, by delegating it to the
> > caller and recovering proper usage of virtqueue_push(idx) parameter.
> > The caller can specify either to batch as usual, or to delegate the
> > automatic (and potentially inefficient) ordering I'm proposing here.
> >
>
> Just to be clear, for this series, you'd like me to implement a solution
> that does *not* consider the case where virtqueue_fill is called
> multiple times before virtqueue_flush (and to put a solution for this in
> a separate series)?
>

No, it is supported. It is just not very efficient because of the linear se=
arch.

For it to be supported properly the caller should indicate
virtqueue_fill idx properly. But that requires modifications to all
devices, so I'm proposing to do it on top.

> Are we not concerned that we might shoot ourselves in the foot here by
> implementing a process that may not work well for a batching solution,
> especially when we have an almost-working solution for batching and
> non-batching cases?
>
> >> We
> >> could just keep adding processed elements to vq->used_elems at
> >> virtqueue_fill but instead of:
> >>
> >> vq->used_elems[seq_idx].in_num =3D elem->in_num;
> >> vq->used_elems[seq_idx].out_num =3D elem->out_num;
> >>
> >> We could do:
> >>
> >> vq->used_elems[seq_idx].in_num =3D 1;
> >> vq->used_elems[seq_idx].out_num =3D 1;
> >>
> >> We'd use in_num and out_num as separate flags. in_num could indicate i=
f
> >> this element has been written to the used ring while out_num could
> >> indicate if this element has been flushed (1 for no, 0 for yes). In
> >> other words, when we go to write to the used ring, start at index
> >> vq->used_idx and iterate through the used elements.
> >>
> >> If a used element's in_num and out_num =3D=3D 0, then this element is
> >> invalid (not yet processed) and we stop the search.
> >>
> >> If a used element's in_num and out_num =3D=3D 1, then this element is =
valid,
> >> written to the used ring, in_num is set to 0, and the search continues=
.
> >>
> >> Lastly, if a used element's in_num =3D=3D 0 but out_num =3D=3D 1, then=
 this
> >> element has already been written to the used ring but not yet flushed,
> >> so ignore this element and continue searching.
> >>
> >> There should never be a case where in_num =3D=3D 1 and out_num =3D=3D =
0.
> >>
> >> However, this would probably mean that before (or right after) we
> >> actually perform the flush we'll have to iterate through the used_elem=
s
> >> array one more time and set their out_num's to 0 to indicate the eleme=
nt
> >> has been flushed.
> >>
> >> Again, this is just for the batched split VQ case where we have to kee=
p
> >> track of elements that have been written but not flushed and elements
> >> that have been written and flushed, given that we don't know which
> >> elements have actually been written to the used ring until the used_id=
x
> >> is updated.
> >>
> >> This approach appears more costly though if we're really trying to avo=
id
> >> having this new used_seq_idx VirtQueue member.
> >>
> >>>> In any case, the use of this variable could be seen as an optimizati=
on
> >>>> as its value will tell us where to start looking in vq->used_elems
> >>>> instead of always starting at vq->used_idx.
> >>>>
> >>>> If this is like a one-shot scenario where one element gets written a=
nd
> >>>> then flushed after, then yes in this case used_seq_idx =3D=3D used_i=
dx.
> >>>>
> >>>> ------
> >>>>
> >>>> For current_seq_idx, this is pretty much just a counter. Every new
> >>>> VirtQueueElement created from virtqueue_pop is given a number and th=
e
> >>>> counter is incremented. Like grabbing a ticket number and waiting fo=
r
> >>>> your number to be called. The next person to grab a ticket number wi=
ll
> >>>> be your number + 1.
> >>>>
> >>>
> >>> So it's like last_avail_idx, isn't it?
> >>>
> >>
> >> For the split VQ case, pretty much. Though if we hit this case in
> >> virtqueue_split_pop, we may get into some trouble:
> >>
> >> if (!virtqueue_get_head(vq, vq->last_avail_idx++, &head)) {
> >>       goto done;
> >> }
> >>
> >
> > That's a fatal mistake and the device breaks, vdev->broken =3D true. It
> > cannot be used anymore from that point on, because of all the checks
> > of that variable.
> >
> > Does that solve the problem?
> >
>
> Ah, it does. My apologies, I should've recognized this would result in
> the device breaking.
>
> >> However for the packed VQ case, last_avail_idx might not work in the w=
ay
> >> we'd need it to for this implementation. In virtqueue_packed_pop, we s=
ee
> >> this:
> >>
> >> elem->ndescs =3D (desc_cache =3D=3D &indirect_desc_cache) ? 1 : elem_e=
ntries;
> >> vq->last_avail_idx +=3D elem->ndescs;
> >>
> >> It would appear as though last_avail_idx is incremented by total numbe=
r
> >> of descriptors associated with the element, which can be greater than =
1.
> >> This implementation increments by 1 for each element.
> >>
> >> Actually... It's good you mentioned this because I think my packed VQ
> >> implementation is wrong. For packed VQs, vq->used_idx is incremented b=
y
> >> the total number of descriptors in the flushed elements and not
> >> necessarily the number of elements being flushed like in the split VQ
> >> case. I'm adding elements to vq->used_elems in a per-element sequence
> >> rather than going by the number of descriptors an element holds, which
> >> should be the case for packed VQs.
> >>
> >
> > If you keep it by your proposed index I think you can increase it one
> > per head, as they are the entries that are written in both cases.
> > unsed_idx should increment properly already.
> >
> > If you move to my proposal, both should increase by elem->ndescs as
> > you suggest here.
> >
>
> Ack! Thanks!
>
> >>>> Let me know if I'm making any sense. Thanks :)
> >>>>
> >>>> Jonah
> >>>>
> >>>>>>         /* Last used index value we have signalled on */
> >>>>>>         uint16_t signalled_used;
> >>>>>>
> >>>>>> @@ -1621,6 +1625,11 @@ static void *virtqueue_split_pop(VirtQueue =
*vq, size_t sz)
> >>>>>>             elem->in_sg[i] =3D iov[out_num + i];
> >>>>>>         }
> >>>>>>
> >>>>>> +    /* Assign sequence index for in-order processing */
> >>>>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> >>>>>> +        elem->seq_idx =3D vq->current_seq_idx++;
> >>>>>> +    }
> >>>>>> +
> >>>>>>         vq->inuse++;
> >>>>>>
> >>>>>>         trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num)=
;
> >>>>>> @@ -1760,6 +1769,11 @@ static void *virtqueue_packed_pop(VirtQueue=
 *vq, size_t sz)
> >>>>>>         vq->shadow_avail_idx =3D vq->last_avail_idx;
> >>>>>>         vq->shadow_avail_wrap_counter =3D vq->last_avail_wrap_coun=
ter;
> >>>>>>
> >>>>>> +    /* Assign sequence index for in-order processing */
> >>>>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> >>>>>> +        elem->seq_idx =3D vq->current_seq_idx++;
> >>>>>> +    }
> >>>>>> +
> >>>>>>         trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num)=
;
> >>>>>>     done:
> >>>>>>         address_space_cache_destroy(&indirect_desc_cache);
> >>>>>> @@ -2087,6 +2101,8 @@ static void __virtio_queue_reset(VirtIODevic=
e *vdev, uint32_t i)
> >>>>>>         vdev->vq[i].notification =3D true;
> >>>>>>         vdev->vq[i].vring.num =3D vdev->vq[i].vring.num_default;
> >>>>>>         vdev->vq[i].inuse =3D 0;
> >>>>>> +    vdev->vq[i].used_seq_idx =3D 0;
> >>>>>> +    vdev->vq[i].current_seq_idx =3D 0;
> >>>>>>         virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> >>>>>>     }
> >>>>>>
> >>>>>> @@ -2334,6 +2350,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vd=
ev, int queue_size,
> >>>>>>         vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
> >>>>>>         vdev->vq[i].handle_output =3D handle_output;
> >>>>>>         vdev->vq[i].used_elems =3D g_new0(VirtQueueElement, queue_=
size);
> >>>>>> +    vdev->vq[i].used_seq_idx =3D 0;
> >>>>>> +    vdev->vq[i].current_seq_idx =3D 0;
> >>>>>>
> >>>>>>         return &vdev->vq[i];
> >>>>>>     }
> >>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio=
.h
> >>>>>> index b3c74a1bca..910b2a3427 100644
> >>>>>> --- a/include/hw/virtio/virtio.h
> >>>>>> +++ b/include/hw/virtio/virtio.h
> >>>>>> @@ -75,6 +75,7 @@ typedef struct VirtQueueElement
> >>>>>>         hwaddr *out_addr;
> >>>>>>         struct iovec *in_sg;
> >>>>>>         struct iovec *out_sg;
> >>>>>> +    uint16_t seq_idx;
> >>>>>>     } VirtQueueElement;
> >>>>>>
> >>>>>>     #define VIRTIO_QUEUE_MAX 1024
> >>>>>> --
> >>>>>> 2.39.3
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>


