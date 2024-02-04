Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DA0C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 22:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWke0-00037A-FD; Sun, 04 Feb 2024 17:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWkdy-00036z-IR
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 17:07:18 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWkdv-0007H8-KG
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 17:07:17 -0500
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7bf0f3bf331so172848039f.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 14:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707084434; x=1707689234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYB74W6ZjlZ8PNMpzJX0KJC3tdI0KE/sYDFK+5K0X4Y=;
 b=HXgSuY0e+kfgK7EboQb6nkTWIxBcRlFuGg0F/b+gZuY0kN2ycGmd3XAA84hF67yATZ
 HpvR3I6b7pzUkcaNVJX5gOnd1cH1+7lB11y6nEXWJrrQ2IjnV84H8DmvzRCYgPae3wDy
 L2/ZcK/hFHy18dyTaXGFkn3DwYeFFBFCdVZtzAnPUDd9hTExFUOOnydXqEdVMhsCBAUG
 Fe7cOztB3QUrxKESemaCXXsY44aRK1I8TRkrqysdOxLvDY4JznBIxVr+nTlYMT8orS5s
 QolZAQQH8W5S8raoV5W+F35/PQwiCfKfzw31QPiewkB6fc/FwECLJE+o4C6fk9TGb49r
 ruhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707084434; x=1707689234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYB74W6ZjlZ8PNMpzJX0KJC3tdI0KE/sYDFK+5K0X4Y=;
 b=aUbaWxhzU5PYOcMK2Lb6fD1bkNZ81yN2jThVNFsQ+bngmPFGAH95AQqpWm7tvhclvY
 teQxkuLi7NTtT154kuIUXAdi5JB+4UM2DEqQxdF1ceWpp7v0WgJLJzMAYyHGji2y1HMe
 aNHJEuzpiOViGpykQRaUzbVRmADpA1EAAoN4ObLNSU+mTgsjcbzvB0In4Zp1scPt7Vt2
 7SAoXfitfktE+PlBU04qIM9jun5eRx8ujQroHsniFYMVpT9eJTmVR3uP9ROW59K97ecP
 yfPuvAZzIGWksDNsXG3uSsWTrdNWTlDdb2VfVV2UnvXtk7XLEyGLehTx2dLO7mufd9mh
 VZjg==
X-Gm-Message-State: AOJu0YzNKNG7lkivFPfzKksAaeVWiw97dNCx4/jdD0xMu2y/8l7Hc+KW
 NpPzqB3u3CbvpJumWW4LT7shskPJl1daB306EeT7mnrSyEHT+IlExkEQpO8sIjOntqEImNXW9Zb
 NvD0MKZwIEGFMX5mYD5K3cm5inog=
X-Google-Smtp-Source: AGHT+IFephycKJijRd/+q9Hoza+nslMC3zhLUHZtb8DMDKx/sjxB/ODF3oQj4rLqhDB7J+g+tN44a/YQCNJfwhiR8Cc=
X-Received: by 2002:a6b:a03:0:b0:7bf:fa07:b7ff with SMTP id
 z3-20020a6b0a03000000b007bffa07b7ffmr16934575ioi.2.1707084434325; Sun, 04 Feb
 2024 14:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-12-david@redhat.com>
 <CAFubqFvC24ng0kHJectz3zN3UDHR6T+Cs7J+RUfm+zT92HR+Zg@mail.gmail.com>
 <21d326c9-f07f-435f-9cbb-6a4e7ac46c65@redhat.com>
In-Reply-To: <21d326c9-f07f-435f-9cbb-6a4e7ac46c65@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sun, 4 Feb 2024 17:07:03 -0500
Message-ID: <CAFubqFv6ryzXHC-wPaFv5hkFET+CO7H=M3LGMU5yXGYWeJuUpA@mail.gmail.com>
Subject: Re: [PATCH v1 11/15] libvhost-user: Speedup gpa_to_mem_region() and
 vu_gpa_to_va()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Feb 4, 2024 at 9:51=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.02.24 03:10, Raphael Norwitz wrote:
> > One comment on this one.
> >
> > On Fri, Feb 2, 2024 at 4:56=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> Let's speed up GPA to memory region / virtual address lookup. Store th=
e
> >> memory regions ordered by guest physical addresses, and use binary
> >> search for address translation, as well as when adding/removing memory
> >> regions.
> >>
> >> Most importantly, this will speed up GPA->VA address translation when =
we
> >> have many memslots.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>   subprojects/libvhost-user/libvhost-user.c | 49 +++++++++++++++++++++=
--
> >>   1 file changed, 45 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/l=
ibvhost-user/libvhost-user.c
> >> index d036b54ed0..75e47b7bb3 100644
> >> --- a/subprojects/libvhost-user/libvhost-user.c
> >> +++ b/subprojects/libvhost-user/libvhost-user.c
> >> @@ -199,19 +199,30 @@ vu_panic(VuDev *dev, const char *msg, ...)
> >>   static VuDevRegion *
> >>   vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
> >>   {
> >> -    unsigned int i;
> >> +    int low =3D 0;
> >> +    int high =3D dev->nregions - 1;
> >>
> >>       /*
> >>        * Memory regions cannot overlap in guest physical address space=
. Each
> >>        * GPA belongs to exactly one memory region, so there can only b=
e one
> >>        * match.
> >> +     *
> >> +     * We store our memory regions ordered by GPA and can simply perf=
orm a
> >> +     * binary search.
> >>        */
> >> -    for (i =3D 0; i < dev->nregions; i++) {
> >> -        VuDevRegion *cur =3D &dev->regions[i];
> >> +    while (low <=3D high) {
> >> +        unsigned int mid =3D low + (high - low) / 2;
> >> +        VuDevRegion *cur =3D &dev->regions[mid];
> >>
> >>           if (guest_addr >=3D cur->gpa && guest_addr < cur->gpa + cur-=
>size) {
> >>               return cur;
> >>           }
> >> +        if (guest_addr >=3D cur->gpa + cur->size) {
> >> +            low =3D mid + 1;
> >> +        }
> >> +        if (guest_addr < cur->gpa) {
> >> +            high =3D mid - 1;
> >> +        }
> >>       }
> >>       return NULL;
> >>   }
> >> @@ -273,9 +284,14 @@ vu_remove_all_mem_regs(VuDev *dev)
> >>   static void
> >>   _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int f=
d)
> >>   {
> >> +    const uint64_t start_gpa =3D msg_region->guest_phys_addr;
> >> +    const uint64_t end_gpa =3D start_gpa + msg_region->memory_size;
> >>       int prot =3D PROT_READ | PROT_WRITE;
> >>       VuDevRegion *r;
> >>       void *mmap_addr;
> >> +    int low =3D 0;
> >> +    int high =3D dev->nregions - 1;
> >> +    unsigned int idx;
> >>
> >>       DPRINT("Adding region %d\n", dev->nregions);
> >>       DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> >> @@ -295,6 +311,29 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion=
 *msg_region, int fd)
> >>           prot =3D PROT_NONE;
> >>       }
> >>
> >> +    /*
> >> +     * We will add memory regions into the array sorted by GPA. Perfo=
rm a
> >> +     * binary search to locate the insertion point: it will be at the=
 low
> >> +     * index.
> >> +     */
> >> +    while (low <=3D high) {
> >> +        unsigned int mid =3D low + (high - low)  / 2;
> >> +        VuDevRegion *cur =3D &dev->regions[mid];
> >> +
> >> +        /* Overlap of GPA addresses. */
> >
> > Looks like this check will only catch if the new region is fully
> > contained within an existing region. I think we need to check whether
> > either start or end region are in the range, i.e.:
>
> That check should cover all cases of overlaps, not just fully contained.
>
> See the QEMU implementation of range_overlaps_rang() that contains a
> similar logic:
>
> return !(range2->upb < range1->lob || range1->upb < range2->lob);
>
>     !(range2->upb < range1->lob || range1->upb < range2->lob);
> =3D  !(range2->upb < range1->lob) && !(range1->upb < range2->lob)
> =3D   range2->upb >=3D range1->lob && range1->upb >=3D range2->lob
> =3D   range1->lob <=3D range2->upb && range2->lob <=3D range1->upb
>
> In QEMU, upb is inclusive, if it were exclusive (like we have here):
>
> =3D   range1->lob < range2->upb && range2->lob < range1->upb
>
> Which is what we have here with:
>
> range1->lob =3D start_gpa
> range1->upb =3D end_gpa
> range2->lob =3D cur->gpa
> range2->upb =3D cur->gpa + cur->size
>
> Also if you are interested, see
>
> https://stackoverflow.com/questions/3269434/whats-the-most-efficient-way-=
to-test-if-two-ranges-overlap
>
> Thanks!

Got it, thanks for the full explanation. With that:

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

>
> --
> Cheers,
>
> David / dhildenb
>

