Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DB2CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 11:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsLOb-0007l8-Qt; Thu, 04 Apr 2024 07:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsLOa-0007jG-2i
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 07:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rsLOX-0007b5-UN
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 07:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712230596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNMoQEQsCVQ9u9TBUjJgMO33xcoOLuAj1qtb8Gwf8Uc=;
 b=Tdaet93wr060fPswxGBfSNHozGzFLoT6D65XKb6HINcRcA/EleUssNPzqL6Uivm2A3Edj/
 YMjNEMi8iXtvhKOOoR46vKLTGN+TJDcQbaF6X91Pp7Ju+fiZGs3LDHM8m9xG0Jv6OPttEi
 S9cje69OhLfoQhSHn1i4jvogNcItB6I=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-01g7zD7XM_GfMExqjM-D7w-1; Thu, 04 Apr 2024 07:36:35 -0400
X-MC-Unique: 01g7zD7XM_GfMExqjM-D7w-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dcc05887ee9so1332705276.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 04:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712230594; x=1712835394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNMoQEQsCVQ9u9TBUjJgMO33xcoOLuAj1qtb8Gwf8Uc=;
 b=OyKx98UapbGXl1OPVADqDfyAcHnzU0JAq41x9oOs6/uXkenpRG9xJC642lnByGbdWA
 0TGb/G0m64WFtAe+7LHuQ9l91ovAotE8T5cK948A/7TKQhUj/GEz3h89E/bD1Fai5+xi
 nuZFMdJamIiVaqhe89e6+gyZ8h7dpGFte4MtJzDdKeGvnmVtQaKQmkv4kGh/LAXTdQDy
 P4I6RDgh4/7QFx21KytMHvUsbK99eT+2glED+u3exn6YEZpTNyLqbuzn+6eKX+UD5WAO
 OAVRwZ0Ul28O1OAOB4jR+VnXypAiYrrkFG91cUgpm5Jn1NzpFw/WOPLfcKEhLzXwoWKw
 tDwg==
X-Gm-Message-State: AOJu0YxMGctTJ0Rwnwiyy300xBfY2/GOusUJnhpbzN2qEvHGfnYsJrTd
 bRKRiK01cwcdGjfMXuXRDCFjFWHu0pvg+vhzZ28AK6/+qj/4X6NItF+EzPXgNpeCZ3O6ygCkzLF
 DR6mgXNKyCjAYrQT8IFV3iyuGDkaQP4POc2ABp49F9OGX/aQYr9maeOa6cVIqnle2JqcffvmRkk
 ACPIp5GSdhNJmKhRo6P+kO3+w6Rh4=
X-Received: by 2002:a25:8f89:0:b0:dd1:48cf:5c8 with SMTP id
 u9-20020a258f89000000b00dd148cf05c8mr2199531ybl.2.1712230594531; 
 Thu, 04 Apr 2024 04:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfh0RuuGQrzpIEzwd0eFur/V5dVErXs+fFlCtdZBmyHK3U8/n+f+7xsZxheDWy/WdVW7oQfO4gbZgGUlvbhrg=
X-Received: by 2002:a25:8f89:0:b0:dd1:48cf:5c8 with SMTP id
 u9-20020a258f89000000b00dd148cf05c8mr2199518ybl.2.1712230594190; Thu, 04 Apr
 2024 04:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240328162203.3775114-1-jonah.palmer@oracle.com>
 <20240328162203.3775114-2-jonah.palmer@oracle.com>
 <CAJaqyWdyZdu48+cZ2umafLRi9NTz3YHxSxmyq6SD9d4noTR2jQ@mail.gmail.com>
 <768ffc05-333a-4f00-9944-940bcaca59fd@oracle.com>
In-Reply-To: <768ffc05-333a-4f00-9944-940bcaca59fd@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 4 Apr 2024 13:35:58 +0200
Message-ID: <CAJaqyWe3bw6WML9MLEhnpNuWL0_HUQJ4WrSyr1jnGHs6Jwn0-Q@mail.gmail.com>
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

On Wed, Apr 3, 2024 at 6:51=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
>
>
> On 4/3/24 6:18 AM, Eugenio Perez Martin wrote:
> > On Thu, Mar 28, 2024 at 5:22=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Initialize sequence variables for VirtQueue and VirtQueueElement
> >> structures. A VirtQueue's sequence variables are initialized when a
> >> VirtQueue is being created or reset. A VirtQueueElement's sequence
> >> variable is initialized when a VirtQueueElement is being initialized.
> >> These variables will be used to support the VIRTIO_F_IN_ORDER feature.
> >>
> >> A VirtQueue's used_seq_idx represents the next expected index in a
> >> sequence of VirtQueueElements to be processed (put on the used ring).
> >> The next VirtQueueElement added to the used ring must match this
> >> sequence number before additional elements can be safely added to the
> >> used ring. It's also particularly useful for helping find the number o=
f
> >> new elements added to the used ring.
> >>
> >> A VirtQueue's current_seq_idx represents the current sequence index.
> >> This value is essentially a counter where the value is assigned to a n=
ew
> >> VirtQueueElement and then incremented. Given its uint16_t type, this
> >> sequence number can be between 0 and 65,535.
> >>
> >> A VirtQueueElement's seq_idx represents the sequence number assigned t=
o
> >> the VirtQueueElement when it was created. This value must match with t=
he
> >> VirtQueue's used_seq_idx before the element can be put on the used rin=
g
> >> by the device.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/virtio/virtio.c         | 18 ++++++++++++++++++
> >>   include/hw/virtio/virtio.h |  1 +
> >>   2 files changed, 19 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index fb6b4ccd83..069d96df99 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -132,6 +132,10 @@ struct VirtQueue
> >>       uint16_t used_idx;
> >>       bool used_wrap_counter;
> >>
> >> +    /* In-Order sequence indices */
> >> +    uint16_t used_seq_idx;
> >> +    uint16_t current_seq_idx;
> >> +
> >
> > I'm having a hard time understanding the difference between these and
> > last_avail_idx and used_idx. It seems to me if we replace them
> > everything will work? What am I missing?
> >
>
> For used_seq_idx, it does work like used_idx except the difference is
> when their values get updated, specifically for the split VQ case.
>
> As you know, for the split VQ case, the used_idx is updated during
> virtqueue_split_flush. However, imagine a batch of elements coming in
> where virtqueue_split_fill is called multiple times before
> virtqueue_split_flush. We want to make sure we write these elements to
> the used ring in-order and we'll know its order based on used_seq_idx.
>
> Alternatively, I thought about replicating the logic for the packed VQ
> case (where this used_seq_idx isn't used) where we start looking at
> vq->used_elems[vq->used_idx] and iterate through until we find a used
> element, but I wasn't sure how to handle the case where elements get
> used (written to the used ring) and new elements get put in used_elems
> before the used_idx is updated. Since this search would require us to
> always start at index vq->used_idx.
>
> For example, say, of three elements getting filled (elem0 - elem2),
> elem1 and elem0 come back first (vq->used_idx =3D 0):
>
> elem1 - not in-order
> elem0 - in-order, vq->used_elems[vq->used_idx + 1] (elem1) also now
>          in-order, write elem0 and elem1 to used ring, mark elements as
>          used
>
> Then elem2 comes back, but vq->used_idx is still 0, so how do we know to
> ignore the used elements at vq->used_idx (elem0) and vq->used_idx + 1
> (elem1) and iterate to vq->used_idx + 2 (elem2)?
>
> Hmm... now that I'm thinking about it, maybe for the split VQ case we
> could continue looking through the vq->used_elems array until we find an
> unused element... but then again how would we (1) know if the element is
> in-order and (2) know when to stop searching?
>

Ok I think I understand the problem now. It is aggravated if we add
chained descriptors to the mix.

We know that the order of used descriptors must be the exact same as
the order they were made available, leaving out in order batching.
What if vq->used_elems at virtqueue_pop and then virtqueue_push just
marks them as used somehow? Two booleans (or flag) would do for a
first iteration.

If we go with this approach I think used_elems should be renamed actually.

> In any case, the use of this variable could be seen as an optimization
> as its value will tell us where to start looking in vq->used_elems
> instead of always starting at vq->used_idx.
>
> If this is like a one-shot scenario where one element gets written and
> then flushed after, then yes in this case used_seq_idx =3D=3D used_idx.
>
> ------
>
> For current_seq_idx, this is pretty much just a counter. Every new
> VirtQueueElement created from virtqueue_pop is given a number and the
> counter is incremented. Like grabbing a ticket number and waiting for
> your number to be called. The next person to grab a ticket number will
> be your number + 1.
>

So it's like last_avail_idx, isn't it?

> Let me know if I'm making any sense. Thanks :)
>
> Jonah
>
> >>       /* Last used index value we have signalled on */
> >>       uint16_t signalled_used;
> >>
> >> @@ -1621,6 +1625,11 @@ static void *virtqueue_split_pop(VirtQueue *vq,=
 size_t sz)
> >>           elem->in_sg[i] =3D iov[out_num + i];
> >>       }
> >>
> >> +    /* Assign sequence index for in-order processing */
> >> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> >> +        elem->seq_idx =3D vq->current_seq_idx++;
> >> +    }
> >> +
> >>       vq->inuse++;
> >>
> >>       trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> >> @@ -1760,6 +1769,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq=
, size_t sz)
> >>       vq->shadow_avail_idx =3D vq->last_avail_idx;
> >>       vq->shadow_avail_wrap_counter =3D vq->last_avail_wrap_counter;
> >>
> >> +    /* Assign sequence index for in-order processing */
> >> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> >> +        elem->seq_idx =3D vq->current_seq_idx++;
> >> +    }
> >> +
> >>       trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> >>   done:
> >>       address_space_cache_destroy(&indirect_desc_cache);
> >> @@ -2087,6 +2101,8 @@ static void __virtio_queue_reset(VirtIODevice *v=
dev, uint32_t i)
> >>       vdev->vq[i].notification =3D true;
> >>       vdev->vq[i].vring.num =3D vdev->vq[i].vring.num_default;
> >>       vdev->vq[i].inuse =3D 0;
> >> +    vdev->vq[i].used_seq_idx =3D 0;
> >> +    vdev->vq[i].current_seq_idx =3D 0;
> >>       virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> >>   }
> >>
> >> @@ -2334,6 +2350,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, =
int queue_size,
> >>       vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
> >>       vdev->vq[i].handle_output =3D handle_output;
> >>       vdev->vq[i].used_elems =3D g_new0(VirtQueueElement, queue_size);
> >> +    vdev->vq[i].used_seq_idx =3D 0;
> >> +    vdev->vq[i].current_seq_idx =3D 0;
> >>
> >>       return &vdev->vq[i];
> >>   }
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index b3c74a1bca..910b2a3427 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -75,6 +75,7 @@ typedef struct VirtQueueElement
> >>       hwaddr *out_addr;
> >>       struct iovec *in_sg;
> >>       struct iovec *out_sg;
> >> +    uint16_t seq_idx;
> >>   } VirtQueueElement;
> >>
> >>   #define VIRTIO_QUEUE_MAX 1024
> >> --
> >> 2.39.3
> >>
> >
>


