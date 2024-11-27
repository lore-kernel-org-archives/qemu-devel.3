Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB57D6ACCA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGHZm-0003eP-KT; Wed, 27 Nov 2024 07:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tGHZl-0003eG-CS
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tGHZj-0007b6-If
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732712120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWMMDXVVOvHVqToDsn9lDVTktAE6dgm5Ktu8y8yladY=;
 b=RRVHSODVDghgu3y59or7UsRcglHoA3aehvEESXHRiaYLVbQpkQLdzrmQ2ZAWvAvHpSdyeX
 OnTCLJaWpWLmlcwivN+WnTB2Q9BjkqEt/tlQ5F62cuuAL0h4AXiRvk7HVNF4LPEh0cZSzL
 l6JUfv7iKDgwhvbhSIaUDIhN15lx6x8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-JrHV_qemO4WyLVXqv4eOcw-1; Wed, 27 Nov 2024 07:55:18 -0500
X-MC-Unique: JrHV_qemO4WyLVXqv4eOcw-1
X-Mimecast-MFC-AGG-ID: JrHV_qemO4WyLVXqv4eOcw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ea9d209e75so6413223a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712117; x=1733316917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWMMDXVVOvHVqToDsn9lDVTktAE6dgm5Ktu8y8yladY=;
 b=kt422k5Ctf1DVh/D7QdgdEuro03zQnRSgkp9MudtZ18SeKfYgkCghJ4Ie/cayAkjj+
 pt7/bKtzynC52Kr93UyAD0gENzqe+MSACkiTIJOX98sDsZbPNnHpcVjKO1Cf3VtlHMr0
 y5TzW+M1c5r8OOnCJjxvvoAbamX0JxjPCuhC2FV7NsmwI4njTBWovGn/hFtOJjToYrZz
 u58Tajtshd02Vz72UIsZH+UnBM0+NeQqUAI80biJ0o5UG26UTI7U8c4qC5hQo8vtBeBH
 FMgJoukdi9F1SyzZh8AraSzK608FcNPUZ22bENuI6syvybG/NUGE1t4IgYvPSNi95WmU
 qAaw==
X-Gm-Message-State: AOJu0YzK59ZNyVkEu4UkPeC7ZvG7VFwTz40CMZTmAUeWXNTdFtCHNdeh
 finkXtsHzTr1XpqyG/z7c652h6eTyKYuIYFNIACH88oIgfRSVGCAFXgUCOjG0sJOkO9yDv0eN0n
 qynG0eKOHAm4hip0dk4swtmnzEHN2xJBOMEpdv21mDB0MoHp2ombOctGsfiWmx2EWazd2QzlgfU
 EWrzkmLBb/cYn9UvaN3zzHVpzkjco=
X-Gm-Gg: ASbGnctJ+ZNJUdC1p7+ReXMpmYR4JEYp6AOdcgJonRJAeOL/lZQoGGgaz+V4pwqlHQl
 G64A5x9U8nIiK35Tm30MY8LJbNEVlaM58
X-Received: by 2002:a17:90b:38c5:b0:2ea:5823:c150 with SMTP id
 98e67ed59e1d1-2ee097bbec2mr3735391a91.30.1732712116938; 
 Wed, 27 Nov 2024 04:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmL3GQ48EkaOoZAAVQXs2tOqpxLugvdi2VU4o2sZI/4mTaJC3LJwnfReBIpi/zSCOQFkbjx2fmAC1z8ySrufw=
X-Received: by 2002:a17:90b:38c5:b0:2ea:5823:c150 with SMTP id
 98e67ed59e1d1-2ee097bbec2mr3735367a91.30.1732712116617; Wed, 27 Nov 2024
 04:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-2-aesteve@redhat.com>
 <abfd06b7-ad85-454b-a973-6c939c4588e3@redhat.com>
 <CADSE00+Yg+ufOT1NQ+8H7DSaE0zCFrWbn-yTajx72G0BZdUw9g@mail.gmail.com>
 <c998c231-5034-4a7e-bf97-1470959c052d@redhat.com>
In-Reply-To: <c998c231-5034-4a7e-bf97-1470959c052d@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 27 Nov 2024 13:55:05 +0100
Message-ID: <CADSE00Lq8k8VJy5swfRgW7a3YvX0d3PQyGfLM6oiWF1-tSPHUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] vhost-user: Add VIRTIO Shared Memory map request
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com, 
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Wed, Nov 27, 2024 at 11:50=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
>
> >> RAM memory region/ RAMBlock that has properly set flags/fd/whatssoever
> >> and map whatever you want in there.
> >>
> >> Likely you would need a distinct RAMBlock/RAM memory region per mmap()=
,
> >> and would end up mmaping implicitly via qemu_ram_mmap().
> >>
> >> Then, your shared region would simply be an empty container into which
> >> you map these RAM memory regions.
> >
>
> Hi,
>
> > Hi, sorry it took me so long to get back to this. Lately I have been
> > testing the patch and fixing bugs, and I am was going to add some
> > tests to be able to verify the patch without having to use a backend
> > (which is what I am doing right now).
> >
> > But I wanted to address/discuss this comment. I am not sure of the
> > actual problem with the current approach (I am not completely aware of
> > the concern in your first paragraph), but I see other instances where
> > qemu mmaps stuff into a MemoryRegion.
>
> I suggest you take a look at the three relevant MAP_FIXED users outside
> of user emulation code.
>
> (1) hw/vfio/helpers.c: We create a custom memory region + RAMBlock with
>      memory_region_init_ram_device_ptr(). This doesn't mmap(MAP_FIXED)
>      into any existing RAMBlock.
>
> (2) system/physmem.c: I suggest you take a close look at
>      qemu_ram_remap() and how it is one example of how RAMBlock
>      properties describe exactly what is mmaped.
>
> (3) util/mmap-alloc.c: Well, this is the code that performs the mmap(),
>      to bring a RAMBlock to life. See qemu_ram_mmap().
>
> There is some oddity hw/xen/xen-mapcache.c; XEN mapcache seems to manage
> guest RAM without RAMBlocks.
>
> > Take into account that the
> > implementation follows the definition of shared memory region here:
> > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.=
html#x1-10200010
> > Which hints to a memory region per ID, not one per required map. So
> > the current strategy seems to fit it better.
>
> I'm confused, we are talking about an implementation detail here? How is
> that related to the spec?

What I try to say is that for me, conceptually, sounds weird to
implement it (as per your suggestion) as a ram block per mmap(); when
the concept we are trying to implement is multiple ram blocks, with
different IDs, and each accepting multiple mmap() as long as there is
enough free space. I fail to see how having multiple IDs for different
shared memory block translates to the implementation when each mmap()
gets its own RAMBlock. Or how the offset the device requests for the
mmap has a meaning when the base memory will change for different
RAMBlocks? But I do not mean as it your suggestion is wrong, I
definitively need to review this more in depth, as my understanding of
this code in QEMU is relatively limited still.

>
> >
> > Also, I was aware that I was not the first one attempting this, so I
> > based this code in previous attempts (maybe I should give credit in
> > the commit now that I think of):
> > https://gitlab.com/virtio-fs/qemu/-/blob/qemu5.0-virtiofs-dax/hw/virtio=
/vhost-user-fs.c?ref_type=3Dheads#L75
> > As you can see, it pretty much follows the same strategy.
>
> So, people did some hacky things in a QEMU fork 6 years ago ... :) That
> cannot possibly be a good argument why we should have it like that in QEM=
U.

Fair. I just took those patches as a good source for what I was trying
to do, as people involved had (and have, for the most part :) ) better
idea of QEMU internals that I do. But it is true that that does not
make it a source of truth.

>
> > And in my
> > examples I have been able to use this to video stream with multiple
> > queues mapped into the shared memory (used to capture video frames),
> > using the backend I mentioned above for testing. So the concept works.
> > I may be wrong with this, but for what I understood looking at the
> > code, crosvm uses a similar strategy. Reserve a memory block and use
> > for all your mappings, and use an allocator to find a free slot.
> >
>
> Again, I suggest you take a look at what a RAMBlock is, and how it's
> properties describe the containing mmap().
>
> > And if I were to do what you say, those distinct RAMBlocks should be
> > created when the device starts? What would be their size? Should I
> > create them when qemu receives a request to mmap? How would the driver
> > find the RAMBlock?
>
> You'd have an empty memory region container into which you will map
> memory regions that describe the memory you want to share.
>
> mr =3D g_new0(MemoryRegion, 1);
> memory_region_init(mr, OBJECT(TODO), "vhost-user-shm", region_size);
>
>
> Assuming you are requested to mmap an fd, you'd create a new
> MemoryRegion+RAMBlock that describes the memory and performs the mmap()
> for you:
>
> map_mr =3D g_new0(MemoryRegion, 1);
> memory_region_init_ram_from_fd(map_mr, OBJECT(TODO), "TODO", map_size,
>                                RAM_SHARED, map_fd, map_offs, errp);
>
> To then map it into your container:
>
> memory_region_add_subregion(mr, offset_within_container, map_mr);
>
>
> To unmap, you'd first remove the subregion, to then unref the map_mr.
>
>
>
> The only alternative would be to do it like (1) above: you perform all
> of the mmap() yourself, and create it using
> memory_region_init_ram_device_ptr(). This will set RAM_PREALLOC on the
> RAMBlock and tell QEMU "this is special, just disregard it". The bad
> thing about RAM_PREALLOC will be that it will not be compatible with
> vfio, not communicated to other vhost-user devices etc ... whereby what
> I describe above would just work with them.

OK. Given that I have a device with which to test, I think it is
definitively worth trying to implement this approach and see how it
works. I'll respond to this thread with progress/results before
sending the next version.

And thanks for the explanation!

BR,
Albert.

>
> --
> Cheers,
>
> David / dhildenb
>


