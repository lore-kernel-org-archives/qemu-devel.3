Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63284CF11C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqCF-0005Id-Gs; Thu, 10 Oct 2024 06:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1syqCD-0005I1-UA
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1syqCB-0002VO-EA
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728555298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2cXP80cW20Rygi6wWJ3GmAUSWWxAkAj5S3tY5JdXWM=;
 b=O4qWId54PTW9IZtq4n9m1eBcmIOO5/1cogAajYkyzhLWWYwtsqSdJHRPm0javZl1WSkNJx
 6itFB2E4Wqwg9guIqXKSFDNrpo0uIHei2sOPDvZUcwt8eqA5G75DzIYYNLAJR7FJYI4NNW
 LnWEYXT453gC58XGj6A1gTKjEm6pN3U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-VHsc5z2hPfKUdSK2kgvkDA-1; Thu, 10 Oct 2024 06:14:57 -0400
X-MC-Unique: VHsc5z2hPfKUdSK2kgvkDA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6e31d9c8efcso16660777b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555296; x=1729160096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2cXP80cW20Rygi6wWJ3GmAUSWWxAkAj5S3tY5JdXWM=;
 b=Xouv5CS1US8YTnssI+v6+T9NBAwwAW1nmN6RE/VT8IILu24r/sIqj2li/5JIZCkv3c
 ECT5S45A0wTHc6l+TL2gJqyyfjtSdwOwpTq4PdbmUlP+7fh3DuGg2ZMDfM/DNhPAnlMU
 x0dHAw0pKx/f+WgMtWERN//UVeGMEErrdTFlTEmFA/ZUNsFeWQkQmVMWry5OygtrcFbL
 hnzsXVqqq+sDJP8tTyBR/FK9gXxTCUA0hVCqU/+DC9t2mYa7um3jhNLDqFdOzWozTfWb
 NfHKxuExSIdxaIhxlIG7I8Jw1kyjy1GyV3oJNjFNRb0KCGP92cl6wlZ8MF+BPumkyFes
 mASw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTydT3KwvWEAEtTTIqGs9NIsEmlX4e0N+nGswwHFOJsPgSPuSJy10GyE7zNNBFvLEVinzZZbb1qU9V@nongnu.org
X-Gm-Message-State: AOJu0Yx8j4HXa4nW6mVDXWQSdcug0rC2yqZqh4Rm/F7bU1mrucRvUKWD
 ho4uE2RG0Zpgb/w8fwunrxLZvfqLy0NFBR1CqxbgMMCu/WLtDvgpl7eH8nO/bfq7ZuI4VzWGGop
 agKUGA2/mty/kvt8JB7VUsF6j5EzzWQJgA5LUY63PbEbh806vfTBG5GQTcznvXC3nJXg4zjsaoT
 y/G0gOz6W1cySacvQocrYfITBgHBg=
X-Received: by 2002:a05:690c:620a:b0:6d1:41:5b35 with SMTP id
 00721157ae682-6e32e1fe4efmr39209597b3.13.1728555296492; 
 Thu, 10 Oct 2024 03:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1TMVzFBf66TlVljepAl4VhgAPNJ5ujkb56WKKBha+4TBcZqyfAoooqcoMN8Q9F3t+UPbTvay5MFmSZTZeQ/U=
X-Received: by 2002:a05:690c:620a:b0:6d1:41:5b35 with SMTP id
 00721157ae682-6e32e1fe4efmr39209327b3.13.1728555296105; Thu, 10 Oct 2024
 03:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
 <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
 <CAJaqyWfYvD0nEYU9UgKzYgUo5JzuFu3PBKNEkDrM0BE0Ek5LfA@mail.gmail.com>
 <5ebfd766-c8b5-4fb3-86ad-17a74212ef5e@oracle.com>
 <c0983e7c-b857-46fa-a6ec-82215829bbc7@oracle.com>
 <CAJaqyWcP8EyE+nyCF1JBouhQp8Lgi5RwoK7SCJe8QKoshDfbhg@mail.gmail.com>
 <5444a3e3-d004-448a-bdf7-d366f37ea3b6@oracle.com>
In-Reply-To: <5444a3e3-d004-448a-bdf7-d366f37ea3b6@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 10 Oct 2024 12:14:20 +0200
Message-ID: <CAJaqyWctx77iF7vdrQUVcnjWwYnZF804zkMiuasbY_M=Pye0FQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 leiyang@redhat.com, peterx@redhat.com, dtatulea@nvidia.com, 
 jasowang@redhat.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 10, 2024 at 9:00=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/9/2024 2:29 AM, Eugenio Perez Martin wrote:
> > On Tue, Oct 8, 2024 at 10:30=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 10/8/2024 8:40 AM, Jonah Palmer wrote:
> >>>
> >>> On 10/8/24 2:51 AM, Eugenio Perez Martin wrote:
> >>>> On Tue, Oct 8, 2024 at 2:14=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 10/7/2024 6:51 AM, Eugenio Perez Martin wrote:
> >>>>>> On Fri, Oct 4, 2024 at 8:48=E2=80=AFPM Jonah Palmer
> >>>>>> <jonah.palmer@oracle.com> wrote:
> >>>>>>>
> >>>>>>> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
> >>>>>>>> On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM Jonah Palmer
> >>>>>>>> <jonah.palmer@oracle.com> wrote:
> >>>>>>>>> Implements the IOVA->GPA tree for handling mapping, unmapping, =
and
> >>>>>>>>> translations for guest memory regions.
> >>>>>>>>>
> >>>>>>>>> When the guest has overlapping memory regions, an HVA to IOVA
> >>>>>>>>> translation
> >>>>>>>>> may return an incorrect IOVA when searching the IOVA->HVA tree.
> >>>>>>>>> This is
> >>>>>>>>> due to one HVA range being contained (overlapping) in another
> >>>>>>>>> HVA range
> >>>>>>>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can us=
e
> >>>>>>>>> GPAs to
> >>>>>>>>> translate and find the correct IOVA for guest memory regions.
> >>>>>>>>>
> >>>>>>>> Yes, this first patch is super close to what I meant, just one i=
ssue
> >>>>>>>> and a pair of nits here and there.
> >>>>>>>>
> >>>>>>>> I'd leave the second patch as an optimization on top, if the num=
bers
> >>>>>>>> prove that adding the code is worth it.
> >>>>>>>>
> >>>>>>> Ah okay, gotcha. I also wasn't sure if what you mentioned below o=
n
> >>>>>>> the
> >>>>>>> previous series you also wanted implemented or if these would als=
o be
> >>>>>>> optimizations on top.
> >>>>>>>
> >>>>>>> [Adding code to the vhost_iova_tree layer for handling multiple
> >>>>>>> buffers
> >>>>>>> returned from translation for the memory area where each iovec
> >>>>>>> covers]:
> >>>>>>> -----------------------------------------------------------------=
------
> >>>>>>>
> >>>>>>> "Let's say that SVQ wants to translate the HVA range
> >>>>>>> 0xfeda0000-0xfedd0000. So it makes available for the device two
> >>>>>>> chained buffers: One with addr=3D0x1000 len=3D0x20000 and the oth=
er one
> >>>>>>> with addr=3D(0x20000c1000 len=3D0x10000).
> >>>>>>>
> >>>>>>> The VirtIO device should be able to translate these two buffers i=
n
> >>>>>>> isolation and chain them. Not optimal but it helps to keep QEMU
> >>>>>>> source
> >>>>>>> clean, as the device already must support it."
> >>>>>>>
> >>>>>> This is 100% in the device and QEMU is already able to split the
> >>>>>> buffers that way, so we don't need any change in QEMU.
> >>>>> Noted that if working with the full HVA tree directly, the internal
> >>>>> iova
> >>>>> tree linear iterator iova_tree_find_address_iterator() today doesn'=
t
> >>>>> guarantee the iova range returned can cover the entire length of th=
e
> >>>>> iov, so things could happen like that the aliased range with smalle=
r
> >>>>> size (than the requested) happens to be hit first in the linear sea=
rch
> >>>>> and be returned, the fragmentation of which can't be guarded agains=
t by
> >>>>> the VirtIO device or the DMA API mentioned above.
> >>>>>
> >>>>> The second patch in this series kind of mitigated this side effect =
by
> >>>>> sorting out the backing ram_block with the help of
> >>>>> qemu_ram_block_from_host() in case of guest memory backed iov, so i=
t
> >>>>> doesn't really count on vhost_iova_gpa_tree_find_iova() to find the
> >>>>> matching IOVA, but instead (somehow implicitly) avoids the
> >>>>> fragmentation
> >>>>> side effect as mentioned above would never happen. Not saying I lik=
e
> >>>>> the
> >>>>> way how it is implemented, but just wanted to point out the implica=
tion
> >>>>> if the second patch has to be removed - either add special handling
> >>>>> code
> >>>>> to the iova-tree iterator sizing the range (same as how range selec=
tion
> >>>>> based upon permission will be done), or add special code in SVQ
> >>>>> layer to
> >>>>> deal with fragmented IOVA ranges due to aliasing.
> >>>>>
> >>>> This special code in SVQ is already there. And it will be needed eve=
n
> >>>> if we look for the buffers by GPA instead of by vaddr, the same way
> >>>> virtqueue_map_desc needs to handle it even if it works with GPA.
> >>>> Continuous GPA does not imply continuous vaddr.
> >>>>
> >>> My apologies if I misunderstood something here regarding size &
> >>> permission matching, but I attempted to implement both the size and
> >>> permission check to iova_tree_find_address_iterator(), however,
> >>> there's a sizing mismatch in the vhost_svq_translate_addr() code path
> >>> that's causing vhost-net to fail to start.
> >>>
> >>> qemu-system-x86_64: unable to start vhost net: 22: falling back on
> >>> userspace virtio
> >>>
> >>> More specifically, in vhost_svq_add_split(), the first call to
> >>> vhost_svq_vring_write_descs() returns false:
> >>>
> >>>      ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in=
_num >
> >>>                                       0, false);
> >>>      if (unlikely(!ok)) {
> >>>          return false;
> >>>      }
> >>>
> >>> Maybe I misunderstood the proposal, but in
> >>> iova_tree_find_address_iterator I'm checking for an exact match for
> >>> sizes:
> >>>
> >>>      if (map->size !=3D needle->size || map->perm !=3D needle->perm) =
{
> >>>          return false;
> >>>      }
> >> The permission needs to exact match,
> > Care with this, read only buffers can live in the guest's RW memory. I
> > think the only actual condition is that if the buffer is writable, the
> > memory area must be writable. If they don't match, we should keep
> > looking for the right area.
> Indeed.
>
> >
> >
> >> while the size doesn't have to. The
> >> current iova_tree_find_address_iterator() has the following check:
> >>
> >>       if (map->translated_addr + map->size < needle->translated_addr |=
|
> >>           needle->translated_addr + needle->size < map->translated_add=
r) {
> >>           return false;
> >>       }
> >>
> >> So essentially it does make sure the starting translated_addr on the
> >> needle is greater than or equal to the starting translated_addr on the
> >> map, and the first match of the map range in an ordered linear search
> >> will be returned, but it doesn't guarantee the ending address on the
> >> needle (needle->translated_addr + needle->size) will be covered by the
> >> ending address on the map (map->translated_addr + map->size), so this
> >> implementation is subjected to fragmented iova ranges with contiguous
> >> HVA address. I don't see the current SVQ handles this well, and the
> >> reason of iova fragmentation is due to overlapped region or memory
> >> aliasing (unlike the GPA tree implementation, we have no additional in=
fo
> >> to help us identify the exact IOVA when two or more overlapped HVA
> >> ranges are given), which is orthogonal to the HVA fragmentation (with
> >> contiguous GPA) handling in virtqueue_map_desc().
> >>
> >> How to handle this situation? Well, I guess Eugenio may have different
> >> opinion, but to me the only way seems to continue to search till a
> >> well-covered IOVA range can be found, or we may have to return multipl=
e
> >> IOVA ranges splitting a contiguous HVA buffer...
> >>
> > Not sure if I followed this 100%, but we must be capable of returning
> > multiple IOVA ranges if we trust in SVQ to do the translation anyway.
> >
> > When SVQ starts, the guest memory listener already gives the GPA ->
> > HVA translations fragmented and unordered, as QEMU can hotplug memory
> > for example. Let me put a simple example:
> >
> > GPA [0, 0x1000) -> HVA [0x10000, 0x10100)
> > GPA [0x1000, 0x2000) -> HVA [0x20000, 0x20100)
> >
> > Now we send the IOVA to the device this way:
> > IOVA [0x2000, 0x3000) -> HVA [0x20000, 0x20100)
> > IOVA [0x3000, 0x4000) -> HVA [0x10000, 0x10100)
> >
> > So we have this translation tree (assuming we already store them as GPA=
->IOVA):
> > GPA [0, 0x1000) -> IOVA [0x3000, 0x4000)
> > GPA [0x1000, 0x2000) -> IOVA [0x2000, 0x3000)
> >
> > Now the guest sends this single buffer in a single descriptor:
> > GPA 0x500, len 0x1000.
> >
> > We need to split it into two descriptors anyway. Without memory
> > aliases we're covered at this moment, as virtqueue_pop already solves
> > these splits for us in virtqueue_map_desc.
> That is what I said above, this case (contiguous GA backed by fragmented
> HVA ranges) is well covered by DMA API called by virtqueue_map_desc(). I
> was aware this case has been handled in the current SVQ code, i.e.
> reflected by below comments in vhost_handle_guest_kick(). This is
> definitively clear to me.
>
>                      /*
>                       * This condition is possible since a contiguous
> buffer in
>                       * GPA does not imply a contiguous buffer in qemu's =
VA
>                       * scatter-gather segments. If that happens, the buf=
fer
>                       * exposed to the device needs to be a chain of
> descriptors
>                       * at this moment.
>                       *
>                       * SVQ cannot hold more available buffers if we are
> here:
>                       * queue the current guest descriptor and ignore kic=
ks
>                       * until some elements are used.
>                       */
>
>
> > Now I realize that SVQ may not be able to cover these splits with
> > aliases, as we might need to return more addresses than MAX(out_num,
> > in_num) in vhost_svq_vring_write_descs.
> Right, this is the case (fragmented iova ranges with contiguous HVA
> range due to aliasing) I was referring to, and is not handled at all in
> the current SVQ or vhost-iova-tree code. This means we have to handle
> the 1:N mapping for each iovec, which essentially introduces unnecessary
> complexity rather than simple or straightforward change as claimed to
> be. Sorry for speaking straight, but I don't really see major benefit in
> either performance, extensibility or flexibility following this
> seemingly interim solution.
>
> On the contrary, instead of simplicity this is becoming more than a
> headache now - Jonah and I have to take extra caution of not breaking
> any other device which is not using aliased map in the same way as how
> the mch device does, as the latter is the only case Jonah used to test
> this patch series. That's why in the morning meeting I asked if more
> test case can be shared like how Lei Yang did in his previous testing of
> your early page pinning series (I recall one failing case seems to be
> related to hot plug) as the early pinning would open up Pandora's box
> that potentially break a lot of things while memory layout keeps
> changing in the early initialization time.
>
> Even so with one additional test case, it is not sufficient to prove
> everything gets done in the right way that can unblock all the memory
> aliasing use cases, as our direct customer may use vdpa device in
> various VM setups together with whatever devices, GPU, VGA, VNC or other
> device we don't know yet but is using aliased map. It'd be going crazy
> to exercise every possible device, and I don't see the real benefit to
> build yet another sub-system out of QEMU memory system's realm just to
> support all these existing devices, given the relevant alias supporting
> code is built-in and working quite well within QEMU's own memory system.
> Don't get me wrong, it's not me who asked to add this code but patch #2
> is definitely not an optimization patch - we have to make sure the code
> is being done in the right way no matter what.  Functional correctness
> always speak than performance or other thing.
>
> >   So maybe we need to allocate
> > the translated addresses array in vhost_svq_vring_write_descs and
> > return it, or allow it to grow.
> >
> > Having said that, I'd keep the plan as building something simple that
> > works first, re-prioritize if we want to focus on reducing the
> > downtime or in increasing the SVQ throughput, and then act in
> > consequence by profiling the advantages of the changes. I'm really
> > looking forward to the switching to (GPA|HVA)->IOVA tree, as I'm sure
> > it will increase the performance of the solution, but to review all of
> > it in one shot is out of my bandwith capabilities at the moment.
> No problem, and thank you for your time in reviewing. I think after
> almost get done with the other assigned work I can work with Jonah to
> implement the desired code changes for (GPA|HVA)->IOVA tree. It's not
> for optimization or performance - just I feel it's much simpler than
> take extra burden to implement and maintain those unwarranted,
> duplicated or preventative code in SVQ or vhost-iova-tree layer just to
> get around various issues in memory aliasing or overrlapping use cases.
> Actually I'm already getting regretted not giving Jonan the right
> guidance in the first place to implement all the necessary virtqueue
> layer supporting code than use the ram block API hack, believe me it's
> not a lot, and the code change is really simple and easy to follow or
> review, there's zero cost in GPA-HVA synchronization than what the
> current code already did. Otherwise past lesson learned told me it would
> spend 10x more if not  building it right in the first place - there'll
> be more cost in future time and effort to refactor or rewrite all the
> code in later point of time once all kinds of features are already built
> up.
>

Got it. Looking forward to the next version then!


