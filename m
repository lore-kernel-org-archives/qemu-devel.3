Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD63BC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmaBg-0003xf-DM; Mon, 24 Feb 2025 10:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tmaBd-0003xL-Sv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tmaBb-0004NU-Ur
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740410157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YC+cxWuqs1YzrKHxMQCjCBsX5eXPEvqdmtOgm/ENclo=;
 b=hyIZZgC3buwD3jxbvyObz9UQYxvkDr/vQ3qC5YCylud4Ce/moOWGkYLZQfK+x5lINQcycY
 oHIMw2tVSZm4NKSRfg2vw4IPYKL9jd31teg1WsYzYfA9mCCca6+PHCotsMx6cRqyz9XjjC
 kxESG61ksB8h3YX6i0aZH7O3iG8MGAQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-9i2yRiomMjahZOGWKyMv2g-1; Mon, 24 Feb 2025 10:15:52 -0500
X-MC-Unique: 9i2yRiomMjahZOGWKyMv2g-1
X-Mimecast-MFC-AGG-ID: 9i2yRiomMjahZOGWKyMv2g_1740410151
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc57652924so9044346a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 07:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740410151; x=1741014951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YC+cxWuqs1YzrKHxMQCjCBsX5eXPEvqdmtOgm/ENclo=;
 b=UqMlhSIEo/PNnaHVE3ci8fLRoM8G4slN0jRuvgfqX1FCbkxa5th75Q4fjEWtqlbtYF
 mJXg9Y3erQt2lvGXd38Ir3QX2LoeF0uMTaAMPlpfIe7rlsFNMfFtHV6dlf9XvJjICwrJ
 vs+jUQSMulW3r8s11icP1LHqh3xITU5I4oh5FyENlLgQPlDGfL58Auus4Sj3zf3v9GNc
 qUEh+mwwdDiX0ra4NaUlvkOgMdrdpCj9PmZ4j5o40gRMm52trNQrDRnOTVu4BUM5hvrK
 ndYJkTlo5D1m2uDkCN9h7dZjkA8HW6kIb8UXAPJ3cA+sHY2QE0hmt1BZPPzjgyWt+gHL
 Uf3A==
X-Gm-Message-State: AOJu0Yz5VwgzBnRaTpdc3KyVd5+Yki/5EP8i5uGLHYkxyXAJ90ee7EaK
 B/N1/mDqdO37C17UbFsYFqZJ5fdWtqivp0XZeuZxYXXNe+Vui/COzqSomLMcHyWuBFRKc/0nQxj
 ewLOWzHA9F8X26qKF88k9iCREmJ6uiNVh5Oqw7IlrE8639YYA0sbLzhY6wIKQ6NdvT6y75q7zIn
 2gZIzd+usN/ITdy3ZwJWRTsflzjE8=
X-Gm-Gg: ASbGncsKsw1bY4RZSeO+6jlB2P7TEjWlFAuZx9xT3+osdN7ASTb5w55tKyAyttzwhGB
 jj45f70Y2KhfExDVSHeGrGx+tFgu2czWoHJqzAi7//aq2PMherjqul4LSofyHBWZra8Ab1neimY
 g=
X-Received: by 2002:a17:90b:3cc4:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-2fccc0f9782mr31219716a91.1.1740410151482; 
 Mon, 24 Feb 2025 07:15:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH29bDqm3oYeZpZfkQDQYciNB8KVQi7w3h1G/NwVRQRv3n/AiwMn6ToNftAKoxFTaUhnAoqiqc/eu1Y1MBJH5M=
X-Received: by 2002:a17:90b:3cc4:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-2fccc0f9782mr31219678a91.1.1740410151140; Mon, 24 Feb 2025
 07:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20250217164012.246727-1-aesteve@redhat.com>
 <aad375d5-8dab-41df-9986-4967ef485a71@redhat.com>
 <CADSE00+Tq8KVTW3BhLwRiQLQuFmauHRvXh34zP6fvvYFrB_t9g@mail.gmail.com>
 <40859ece-0850-40cb-b8b9-28d0d76aefde@redhat.com>
 <CADSE00JPHcXXK4dhvwY7rrXNV=1WSQYMv8vOGjVE0TG0+fVkNA@mail.gmail.com>
 <b320f128-3604-40c8-961c-ceb431f82f6d@redhat.com>
 <CADSE00LvNbCR6cn-FuDCVF-vvXULrx7=5SyceMtdgxwpUa3NMw@mail.gmail.com>
 <933cf843-e845-45e0-8c48-a34541ad0afb@redhat.com>
In-Reply-To: <933cf843-e845-45e0-8c48-a34541ad0afb@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 24 Feb 2025 16:15:39 +0100
X-Gm-Features: AWEUYZmzmXhtT-y6DMx4MRhy5o-UKmPCUtPfGDN5_e8GSBp9LLBNB74Bu1AXmGI
Message-ID: <CADSE00Lzxt7AuzLe24=T+C1TCOAmV1SkAMqAkSXwLBK+x4NHbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] vhost-user: Add SHMEM_MAP/UNMAP requests
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 24, 2025 at 2:57=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 24.02.25 14:41, Albert Esteve wrote:
> > On Mon, Feb 24, 2025 at 10:49=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 24.02.25 10:35, Albert Esteve wrote:
> >>> On Mon, Feb 24, 2025 at 10:16=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>
> >>>> On 24.02.25 09:54, Albert Esteve wrote:
> >>>>> On Mon, Feb 17, 2025 at 9:01=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>>
> >>>>>> On 17.02.25 17:40, Albert Esteve wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> looks like our debugging session was successfu :)
> >>>>>>
> >>>>>> One question below.
> >>>>>>
> >>>>>>> v3->v4
> >>>>>>> - Change mmap strategy to use RAM blocks
> >>>>>>>       and subregions.
> >>>>>>> - Add new bitfield to qmp feature map
> >>>>>>> - Followed most review comments from
> >>>>>>>       last iteration.
> >>>>>>> - Merged documentation patch again with
> >>>>>>>       this one. Makes more sense to
> >>>>>>>       review them together after all.
> >>>>>>> - Add documentation for MEM_READ/WRITE
> >>>>>>>       messages.
> >>>>>>>
> >>>>>>> The goal of this patch is to support
> >>>>>>> dynamic fd-backed memory maps initiated
> >>>>>>> from vhost-user backends.
> >>>>>>> There are many devices that could already
> >>>>>>> benefit of this feature, e.g.,
> >>>>>>> virtiofs or virtio-gpu.
> >>>>>>>
> >>>>>>> After receiving the SHMEM_MAP/UNMAP request,
> >>>>>>> the frontend creates the RAMBlock form the
> >>>>>>> fd and maps it by adding it as a subregion
> >>>>>>> of the shared memory region container.
> >>>>>>>
> >>>>>>> The VIRTIO Shared Memory Region list is
> >>>>>>> declared in the `VirtIODevice` struct
> >>>>>>> to make it generic.
> >>>>>>>
> >>>>>>> TODO: There was a conversation on the
> >>>>>>> previous version around adding tests
> >>>>>>> to the patch (which I have acknowledged).
> >>>>>>> However, given the numerous changes
> >>>>>>> that the patch already has, I have
> >>>>>>> decided to send it early and collect
> >>>>>>> some feedback while I work on the
> >>>>>>> tests for the next iteration.
> >>>>>>> Given that I have been able to
> >>>>>>> test the implementation with
> >>>>>>> my local setup, I am more or less
> >>>>>>> confident that, at least, the code
> >>>>>>> is in a relatively sane state
> >>>>>>> so that no reviewing time is
> >>>>>>> wasted on broken patches.
> >>>>>>>
> >>>>>>> This patch also includes:
> >>>>>>> - SHMEM_CONFIG frontend request that is
> >>>>>>> specifically meant to allow generic
> >>>>>>> vhost-user-device frontend to be able to
> >>>>>>> query VIRTIO Shared Memory settings from the
> >>>>>>> backend (as this device is generic and agnostic
> >>>>>>> of the actual backend configuration).
> >>>>>>>
> >>>>>>> - MEM_READ/WRITE backend requests are
> >>>>>>> added to deal with a potential issue when having
> >>>>>>> multiple backends sharing a file descriptor.
> >>>>>>> When a backend calls SHMEM_MAP it makes
> >>>>>>> accessing to the region fail for other
> >>>>>>> backend as it is missing from their translation
> >>>>>>> table. So these requests are a fallback
> >>>>>>> for vhost-user memory translation fails.
> >>>>>>
> >>>>>> Can you elaborate what the issue here is?
> >>>>>>
> >>>>>> Why would SHMEM_MAP make accessing the region fail for other backe=
nds --
> >>>>>> what makes this missing from their translation?
> >>>>>
> >>>>> This issue was raised by Stefan Hajnoczi in one of the first
> >>>>> iterations of this patchset, based upon previous David Gilbert's wo=
rk
> >>>>> on the virtiofs DAX Window.
> >>>>>
> >>>>> Let me paste here some of his remarks:
> >>>>>
> >>>>> """
> >>>>> Other backends don't see these mappings. If the guest submits a vri=
ng
> >>>>> descriptor referencing a mapping to another backend, then that back=
end
> >>>>> won't be able to access this memory.
> >>>>> """
> >>>>> [...]
> >>>>> """
> >>>>> A bit more detail:
> >>>>>
> >>>>> Device A has a VIRTIO Shared Memory Region. An application mmaps th=
at
> >>>>> memory (examples: guest userspace driver using Linux VFIO, a guest
> >>>>> kernel driver that exposes the memory to userspace via mmap, or gue=
st
> >>>>> kernel DAX). The application passes that memory as an I/O buffer to
> >>>>> device B (e.g. O_DIRECT disk I/O).
> >>>>>
> >>>>> The result is that device B's vhost-user backend receives a vring
> >>>>> descriptor that points to a guest memory address in device A's VIRT=
IO
> >>>>> Shared Memory Region. Since device B does not have this memory in i=
ts
> >>>>> table, it cannot translate the address and the device breaks.
> >>>>> """
> >>>>>
> >>>>> I have not triggered the issue myself. So the idea is that the next
> >>>>> patch will *definitively* include some testing for the commits that=
 I
> >>>>> cannot verify with my local setup.
> >>>>
> >>>> Hah! But isn't that exact problem which is now solved by our rework?
> >>>>
> >>>> Whatever is mapped in the VIRTIO Shared Memory Region will be
> >>>> communicated to all other vhost-user devices. So they should have th=
at
> >>>> memory in their map and should be able to access it.
> >>>
> >>> You mean the SET_MEM_TABLE message after the vhost_commit is sent to
> >>> all vhost-user devices? I was not sure, as I was testing with a singl=
e
> >>> device, that would be great, and simplify the patch a lot.
> >>
> >> Yes, all vhost-user devices should be updated.
> >
> > Then, I think I agree with you, it would seem that this approach
> > naturally solved the issue with address translation among different
> > devices, as they all get the most up-to-date memory table after each
> > mmap.
> >
> > WDYT, @Stefan Hajnoczi ?
> > If we are unsure, maybe we can leave the MEM_READ/WRITE support as a
> > later extension, and try to integrate the rest of this patch first.
>
> As commented offline, maybe one would want the option to enable the
> alternative mode, where such updates (in the SHM region) are not sent to
> vhost-user devices. In such a configuration, the MEM_READ / MEM_WRITE
> would be unavoidable.

At first, I remember we discussed two options, having update messages
sent to all devices (which was deemed as potentially racy), or using
MEM_READ / MEM _WRITE messages. With this version of the patch there
is no option to avoid the mem_table update messages, which brings me
to my point in the previous message: it may make sense to continue
with this patch without MEM_READ/WRITE support, and leave that and the
option to make mem_table updates optional for a followup patch?

>
> What comes to mind are vhost-user devices with limited number of
> supported memslots.
>
> No idea how relevant that really is, and how many SHM regions we will
> see in practice.

In general, from what I see they usually require 1 or 2 regions,
except for virtio-scmi which requires >256.

>
> I recently increased the number of supported memslots for rust-vmm and
> libvhost-user, but not sure about other devices (in particular, dpdk,
> spdk, and whether we really care about that here).
>
> --
> Cheers,
>
> David / dhildenb
>


