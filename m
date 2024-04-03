Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E5FCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrwHQ-0007wF-QW; Wed, 03 Apr 2024 04:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rrwHP-0007vo-4y
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 04:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rrwHN-0001xP-29
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 04:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712134050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPA5fWUXgHRW5wAEfMjHf6l7NsfrTZrHU5JH732XUVs=;
 b=GmKqSajuV13nMgsj8QyfciLEjzlywkIYltk4GQe8K06jKPovk2nl3H244r5K3YiirDPvn0
 6YGe3H3pxnU6fR51fCDaKQUgW21MSb7BR8sVshW5qNyk32iuGu0bMcBqal0Vx6+Iap+eKO
 13OAPpk+cNTzKWI/qf7xuDhaeIroCFI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-IU8380GaO4GRXr4CMg1Cyw-1; Wed, 03 Apr 2024 04:47:28 -0400
X-MC-Unique: IU8380GaO4GRXr4CMg1Cyw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dd0ae66422fso1436867276.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 01:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712134048; x=1712738848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPA5fWUXgHRW5wAEfMjHf6l7NsfrTZrHU5JH732XUVs=;
 b=e1fZHpy/Z4CdceFNapsVbaVBoTed6EZ4hE8tBpvcJ+kgicRnoPLWDd8yUjriCHdzLF
 gMXbPV/IPDbq6mmr+97h0UQxK67hjs5rs9bs0TgPdZBmqCNh3NujlpqoSoN8q28OR+DM
 kKB8gAGGzPdgPLV7lmdC1fFrk4oJZ02Op5SKSxQ1X7c2gisZBaiH6uLulzapGtiXyxii
 pkjgwygAycXQlLf1nTmugzLITLKhL+e1g5RXn8t9LyZioQdHffJKXclkeJeVxZBvm+/l
 jtHnLDdVwssoz4ysELQJ0USTDy8KUzriGKRF6AlzCW5zrzrRRkwr+DlGt3AgSYGbx9/g
 VMYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9hKj81u6sanMY3rbOqcQMIXJWpGFD0HFI5Q14eFSGMPuRbEnbNvNvUy/qJF5LVHrxR1w1J0HHq009Op2Tz0VdnvQ3g44=
X-Gm-Message-State: AOJu0YwQn69OnuaZU9Cj9iE6m+f+tysXLa0JUQIK5mJFKKLz7NN1QH0W
 kjeULI+JD6rKHYfkeaFmhEDRqp2Q58qRH56EexUbrmRI3TbI/LpI9dUghHMv04bVsyHjFx/2iss
 uVn7jZ/9bm3CZdFdNAUSvqccZD0O6pI0pq+aRUEbIn+MzyAQapG8LJp4fthTc/iqDa320EcevoX
 yhwxVd/lgpCZ4XJ1BsllgasENFrVQ=
X-Received: by 2002:a25:bcc7:0:b0:ddc:d115:4768 with SMTP id
 l7-20020a25bcc7000000b00ddcd1154768mr1375771ybm.1.1712134048181; 
 Wed, 03 Apr 2024 01:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmHGtAifsmiROJ+epApsfVffXb20+4HUc4Oum5gXDjRuVBf2d25csyW1B84xDU6ZfPZUkqoJ9qmiRRSfS0DQk=
X-Received: by 2002:a25:bcc7:0:b0:ddc:d115:4768 with SMTP id
 l7-20020a25bcc7000000b00ddcd1154768mr1375762ybm.1.1712134047823; Wed, 03 Apr
 2024 01:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
 <20240213052102-mutt-send-email-mst@kernel.org>
 <c45af489-0f0a-4fc7-ad03-4a513f8b338d@oracle.com>
 <CAJaqyWdDRqMEwVh6ZcVdnEZoXy-_9B2qk25eYcoVmeeTxgGm8g@mail.gmail.com>
 <58cf082c-fa54-48a6-aa49-e8b6cba60f53@oracle.com>
 <CAJaqyWc4aFOEQMu9iHTHOA-cMt9jRWeZteaaZk+8VPw8T9GV=w@mail.gmail.com>
 <cb5296a3-cca4-46a6-8f3e-a96fdb46b1a4@oracle.com>
In-Reply-To: <cb5296a3-cca4-46a6-8f3e-a96fdb46b1a4@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Apr 2024 10:46:51 +0200
Message-ID: <CAJaqyWc-Vb2Mhj5Yv27NEwOuEog0M7zrD8u_8trr4JBLQuJjLg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Wed, Apr 3, 2024 at 8:53=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 4/2/2024 5:01 AM, Eugenio Perez Martin wrote:
> > On Tue, Apr 2, 2024 at 8:19=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >>
> >>
> >> On 2/14/2024 11:11 AM, Eugenio Perez Martin wrote:
> >>> On Wed, Feb 14, 2024 at 7:29=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> Hi Michael,
> >>>>
> >>>> On 2/13/2024 2:22 AM, Michael S. Tsirkin wrote:
> >>>>> On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
> >>>>>> Hi Eugenio,
> >>>>>>
> >>>>>> I thought this new code looks good to me and the original issue I =
saw with
> >>>>>> x-svq=3Don should be gone. However, after rebase my tree on top of=
 this,
> >>>>>> there's a new failure I found around setting up guest mappings at =
early
> >>>>>> boot, please see attached the specific QEMU config and correspondi=
ng event
> >>>>>> traces. Haven't checked into the detail yet, thinking you would ne=
ed to be
> >>>>>> aware of ahead.
> >>>>>>
> >>>>>> Regards,
> >>>>>> -Siwei
> >>>>> Eugenio were you able to reproduce? Siwei did you have time to
> >>>>> look into this?
> >>>> Didn't get a chance to look into the detail yet in the past week, bu=
t
> >>>> thought it may have something to do with the (internals of) iova tre=
e
> >>>> range allocation and the lookup routine. It started to fall apart at=
 the
> >>>> first vhost_vdpa_dma_unmap call showing up in the trace events, wher=
e it
> >>>> should've gotten IOVA=3D0x2000001000,  but an incorrect IOVA address
> >>>> 0x1000 was ended up returning from the iova tree lookup routine.
> >>>>
> >>>> HVA                    GPA                IOVA
> >>>> --------------------------------------------------------------------=
-----------------------------------------------------
> >>>> Map
> >>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x800=
00000)
> >>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> >>>> [0x80001000, 0x2000001000)
> >>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> >>>> [0x2000001000, 0x2000021000)
> >>>>
> >>>> Unmap
> >>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000=
,
> >>>> 0x20000) ???
> >>>>                                        shouldn't it be [0x2000001000=
,
> >>>> 0x2000021000) ???
> >>>>
> >> It looks the SVQ iova tree lookup routine vhost_iova_tree_find_iova(),
> >> which is called from vhost_vdpa_listener_region_del(), can't properly
> >> deal with overlapped region. Specifically, q35's mch_realize() has the
> >> following:
> >>
> >> 579     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch),
> >> "smram-open-high",
> >> 580                              mch->ram_memory,
> >> MCH_HOST_BRIDGE_SMRAM_C_BASE,
> >> 581                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
> >> 582     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda=
0000,
> >> 583 &mch->open_high_smram, 1);
> >> 584     memory_region_set_enabled(&mch->open_high_smram, false);
> >>
> >> #0  0x0000564c30bf6980 in iova_tree_find_address_iterator
> >> (key=3D0x564c331cf8e0, value=3D0x564c331cf8e0, data=3D0x7fffb6d749b0) =
at
> >> ../util/iova-tree.c:96
> >> #1  0x00007f5f66479654 in g_tree_foreach () at /lib64/libglib-2.0.so.0
> >> #2  0x0000564c30bf6b53 in iova_tree_find_iova (tree=3D<optimized out>,
> >> map=3Dmap@entry=3D0x7fffb6d74a00) at ../util/iova-tree.c:114
> >> #3  0x0000564c309da0a9 in vhost_iova_tree_find_iova (tree=3D<optimized
> >> out>, map=3Dmap@entry=3D0x7fffb6d74a00) at ../hw/virtio/vhost-iova-tre=
e.c:70
> >> #4  0x0000564c3085e49d in vhost_vdpa_listener_region_del
> >> (listener=3D0x564c331024c8, section=3D0x7fffb6d74aa0) at
> >> ../hw/virtio/vhost-vdpa.c:444
> >> #5  0x0000564c309f4931 in address_space_update_topology_pass
> >> (as=3Das@entry=3D0x564c31ab1840 <address_space_memory>,
> >> old_view=3Dold_view@entry=3D0x564c33364cc0,
> >> new_view=3Dnew_view@entry=3D0x564c333640f0, adding=3Dadding@entry=3Dfa=
lse) at
> >> ../system/memory.c:977
> >> #6  0x0000564c309f4dcd in address_space_set_flatview (as=3D0x564c31ab1=
840
> >> <address_space_memory>) at ../system/memory.c:1079
> >> #7  0x0000564c309f86d0 in memory_region_transaction_commit () at
> >> ../system/memory.c:1132
> >> #8  0x0000564c309f86d0 in memory_region_transaction_commit () at
> >> ../system/memory.c:1117
> >> #9  0x0000564c307cce64 in mch_realize (d=3D<optimized out>,
> >> errp=3D<optimized out>) at ../hw/pci-host/q35.c:584
> >>
> >> However, it looks like iova_tree_find_address_iterator() only check if
> >> the translated address (HVA) falls in to the range when trying to loca=
te
> >> the desired IOVA, causing the first DMAMap that happens to overlap in
> >> the translated address (HVA) space to be returned prematurely:
> >>
> >>    89 static gboolean iova_tree_find_address_iterator(gpointer key,
> >> gpointer value,
> >>    90                                                 gpointer data)
> >>    91 {
> >>    :
> >>    :
> >>    99     if (map->translated_addr + map->size < needle->translated_ad=
dr ||
> >> 100         needle->translated_addr + needle->size < map->translated_a=
ddr) {
> >> 101         return false;
> >> 102     }
> >> 103
> >> 104     args->result =3D map;
> >> 105     return true;
> >> 106 }
> >>
> >> In the QEMU trace file, it reveals that the first DMAMap as below gets
> >> returned incorrectly instead the second, the latter of which is what t=
he
> >> actual IOVA corresponds to:
> >>
> >> HVA                                                             GPA   =
                                          IOVA
> >> [0x7f7903e00000, 0x7f7983e00000)        [0x0, 0x80000000)             =
          [0x1000, 0x80001000)
> >> [0x7f7903ea0000, 0x7f7903ec0000)        [0xfeda0000, 0xfedc0000)      =
  [0x2000001000, 0x2000021000)
> >>
> > I think the analysis is totally accurate as no code expects to unmap /
> > map overlapping regions. In particular, vdpa kernel does not expect it
> > either.
>
> Maybe I missed something, but I don't see how vdpa kernel prohibits this
> overlapping case? The same HVA gets remapped under a different GPA or
> IOVA range should be a valid use case it seems? For e.g. I don't see
> mapping failure when x-svq=3Don was removed from QEMU's vhost-vdpa
> arguments (where you can see in the attached trace, mch_realize with the
> exactly same overlapping region got remapped successfully, and then got
> unmapped right after).
>

I meant to remove part of a map. You can see that vhost_vdpa_pa_unmap
/ vhost_vdpa_va_unmap removes all the map, not only the portion of it,
much like iova_tree does.

> > Since it is issued at _realize, it should be ok to unmap all the
> > region range and then map the right range again, even if that implies
> > a lot of unpin / pin.
> You'll find out mch_realize() already did that -  where line 582 is to
> create a mapping overlapped with entire range, while line 583 is to
> disable (unmap) this same mapping shortly after.
>
> 582     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda000=
0,
> 583 &mch->open_high_smram, 1);
> 584     memory_region_set_enabled(&mch->open_high_smram, false);
>
> So we don't have to add any special case to deal with these overlapping
> case (just use the GPA as the hint to help identify which iova range it
> tries to unmap), as the vdpa's memory listener now moves upfront to the
> earliest point of time at machine boot, the relevant SVQ code needs to
> be more flexible and tolerate to the extra churns for the rest of QEMU's
> subsystems to stabilize the guest memory layout.

Yes I think the same.

> >> Maybe other than check the HVA range, we should also match GPA, or at
> >> least the size should exactly match?
> >>
> > The safe actions here would be to unmap all the memory chunk and then
> > map the overlap memory? Or am I missing something?
> >
> > Another thing I don't get, is this reproducible in previous versions?
> It is not reproducible without this series. I thought that may be
> because previously the vhost-vdpa's memory listener was registered at a
> later point of time, after all the overlapped regions are gone and the
> memory layout is completely stabilized. Now we move registration to the
> init time, then all the devils come out biting us.
>
> Previous versions of this patch series we didn't get this far yet, when
> x-svq=3Don is specified.
>

Right, good point.

Thanks!

> https://lore.kernel.org/qemu-devel/92ecfd90-8d06-4669-b260-a7a3b106277e@o=
racle.com/
> > As far as I understand, this bug was never found before. I guess this
> > path of q35's mch_realize is recent?
> No, it's been there for quite a while.
>
> Cheers,
> -Siwei
> >
> > Thanks!
> >
> >>> Yes, I'm still not able to reproduce. In particular, I don't know how
> >>> how the memory listener adds a region and then release a region with =
a
> >>> different size. I'm talking about these log entries:
> >>>
> >>> 1706854838.154394:vhost_vdpa_listener_region_add vdpa: 0x556d45c75140
> >>> iova 0x0 llend 0x80000000 vaddr: 0x7f7903e00000 read-only: 0
> >>> 452:vhost_vdpa_listener_region_del vdpa: 0x556d45c75140 iova 0x0 llen=
d
> >>> 0x7fffffff
> >> Didn't see a different size here, though if you referred to the
> >> discrepancy in the traces around llend, I thought the two between _add=
()
> >> and _del() would have to be interpreted differently due to:
> >>
> >> 3d1e4d34 "vhost_vdpa: fix the input in
> >> trace_vhost_vdpa_listener_region_del()"
> >>
> >> Regards,
> >> -Siwei
> >>> Is it possible for you to also trace the skipped regions? We should
> >>> add a debug trace there too...
> >>>
> >>> Thanks!
> >>>
> >>>> PS, I will be taking off from today and for the next two weeks. Will=
 try
> >>>> to help out looking more closely after I get back.
> >>>>
> >>>> -Siwei
> >>>>>     Can't merge patches which are known to break things ...


