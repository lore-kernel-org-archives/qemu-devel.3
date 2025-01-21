Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92F4C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 20:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taKlA-00023i-3W; Tue, 21 Jan 2025 15:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taKl8-00023L-8b
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 15:22:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taKl5-0001Xl-29
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 15:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737490915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mt99Q6PTtiVRyEYeMJowEAmD8Ow8/OY0SKvysNI4H7s=;
 b=inKIVjfKdymgmZYkd0h48BVw15meCsXAWvgDAZYRNKXs2aVmZ5eHnW461VmNcGhr5ZprhO
 /GtG6jn9HF2RlD5zp8ns5iHZjo2DJnGklwTdcANnmRPAoPrlPRHBLpX5UBizZVEELV5bon
 C45pp2C/1+nCkd8dzitLIXszjYg4QdQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-GjfjCKdvO7q0zX9yrbhghw-1; Tue, 21 Jan 2025 15:21:53 -0500
X-MC-Unique: GjfjCKdvO7q0zX9yrbhghw-1
X-Mimecast-MFC-AGG-ID: GjfjCKdvO7q0zX9yrbhghw
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46e2504c3aaso52218501cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 12:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737490913; x=1738095713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mt99Q6PTtiVRyEYeMJowEAmD8Ow8/OY0SKvysNI4H7s=;
 b=P3pttqQJixEtWP7aOGlXNdfPWhErg4v75e5eDozGCSGhCKZ/2oJiO0ng1bzr+3kFTV
 B+Vx1/zZ7qIo2IgaKrzPkm1pTIDrAA848nnwj4N7joK1cuGU3QUOkjALor1+psLE1wI2
 WP6has1jpij52CKqn7vZiu9EC+LbOSPQrWvGYNjQH7XJJy1f8OO9c9h0qInfsNWNmRQ/
 VxmSBNpEywwH62QkqbsBiFHNJccLng73bQpLkXc5F4drX0Q2wU0BeaPUyEjUbBWrn0kL
 4Qiz0/gxllc/zWEVA6tj/DAlDhMSePF74qtNkpLQfzXjdS2VJMEIBTRVdUgtgvKuor9q
 gp1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9BhNuO4J+mJTNNBwLroybkwW22IyVgZ6vTkIzfpuUHNqMwK3SC71NnLUWdup1YhG1ptnD0K0Ahxmf@nongnu.org
X-Gm-Message-State: AOJu0YycB+M9zckmBITomnjDFJYs3vYzzEDTt6OgqLRNz9n58aVrQ62y
 2c8xjVYYjargcnZQP/2nqm2IZQc5YPBiRzL9GcoIAY2bGftTTC5Z3pUx3b4tOGpUHoQNpw1XQf3
 5cJW0AdN6ZZH45xWs1VGVn6/cYEsJQRb0hBqjDPhBpQM7pz8g0/ly
X-Gm-Gg: ASbGncvvo3IJnzkm2FDzSUdzhWjtXb7jCGS34uGNpnvX6/Cx7Sl6XdUq6t30AUeOQNf
 mM6LrQv3LIdzOO/GtcZhpPS3FMafR/DvIJSKE8R9vcBRj/2XXdjxjibBGri1baYweyhiFrrgsyQ
 M3NBoe22796lJQp2j73R0g288mJ6yOxJEnHt+sv7qijc3jvP+gs/d9arWSnYZZPjcXtqhZT22SI
 rJRF/Q+/nbyhiVEVe/GsBaIF7Bx5cQ+sQL10GdBeGJ+uHKoPyU21H8I2IvoOx/q7chNN/tboAEp
 e2zH2WVn3f3MGcspqwF+8QfZB26f46o=
X-Received: by 2002:a05:622a:1116:b0:467:59f6:3e56 with SMTP id
 d75a77b69052e-46e12b56ef7mr286167141cf.36.1737490913035; 
 Tue, 21 Jan 2025 12:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhKqh/niV03ikVCafvYgoRQT21WqQAnCgYjazIyuuJxjrOz+2e+gwnsOhhs8U6ygSh0qOixw==
X-Received: by 2002:a05:622a:1116:b0:467:59f6:3e56 with SMTP id
 d75a77b69052e-46e12b56ef7mr286166701cf.36.1737490912642; 
 Tue, 21 Jan 2025 12:21:52 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102eeafcsm56434351cf.16.2025.01.21.12.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 12:21:51 -0800 (PST)
Date: Tue, 21 Jan 2025 15:21:49 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 07/49] HostMem: Add mechanism to opt in kvm guest
 memfd via MachineState
Message-ID: <Z5AB3SlwRYo19dOa@x1n>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-8-michael.roth@amd.com>
 <Z4_b3Lrpbnyzyros@x1n>
 <fa29f4ef-f67d-44d7-93f0-753437cf12cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa29f4ef-f67d-44d7-93f0-753437cf12cb@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Tue, Jan 21, 2025 at 07:24:29PM +0100, David Hildenbrand wrote:
> On 21.01.25 18:39, Peter Xu wrote:
> > On Wed, Mar 20, 2024 at 03:39:03AM -0500, Michael Roth wrote:
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > 
> > > Add a new member "guest_memfd" to memory backends. When it's set
> > > to true, it enables RAM_GUEST_MEMFD in ram_flags, thus private kvm
> > > guest_memfd will be allocated during RAMBlock allocation.
> > > 
> > > Memory backend's @guest_memfd is wired with @require_guest_memfd
> > > field of MachineState. It avoid looking up the machine in phymem.c.
> > > 
> > > MachineState::require_guest_memfd is supposed to be set by any VMs
> > > that requires KVM guest memfd as private memory, e.g., TDX VM.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > ---
> > > Changes in v4:
> > >   - rename "require_guest_memfd" to "guest_memfd" in struct
> > >     HostMemoryBackend;	(David Hildenbrand)
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > ---
> > >   backends/hostmem-file.c  | 1 +
> > >   backends/hostmem-memfd.c | 1 +
> > >   backends/hostmem-ram.c   | 1 +
> > >   backends/hostmem.c       | 1 +
> > >   hw/core/machine.c        | 5 +++++
> > >   include/hw/boards.h      | 2 ++
> > >   include/sysemu/hostmem.h | 1 +
> > >   7 files changed, 12 insertions(+)
> > > 
> > > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > > index ac3e433cbd..3c69db7946 100644
> > > --- a/backends/hostmem-file.c
> > > +++ b/backends/hostmem-file.c
> > > @@ -85,6 +85,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> > >       ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
> > >       ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
> > >       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> > > +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
> > >       ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
> > >       ram_flags |= RAM_NAMED_FILE;
> > >       return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
> > > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > > index 3923ea9364..745ead0034 100644
> > > --- a/backends/hostmem-memfd.c
> > > +++ b/backends/hostmem-memfd.c
> > > @@ -55,6 +55,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> > >       name = host_memory_backend_get_name(backend);
> > >       ram_flags = backend->share ? RAM_SHARED : 0;
> > >       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> > > +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
> > >       return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
> > >                                             backend->size, ram_flags, fd, 0, errp);
> > >   }
> > > diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> > > index d121249f0f..f7d81af783 100644
> > > --- a/backends/hostmem-ram.c
> > > +++ b/backends/hostmem-ram.c
> > > @@ -30,6 +30,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> > >       name = host_memory_backend_get_name(backend);
> > >       ram_flags = backend->share ? RAM_SHARED : 0;
> > >       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> > > +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
> > >       return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
> > >                                                     name, backend->size,
> > >                                                     ram_flags, errp);
> > 
> > These change look a bit confusing to me, as I don't see how gmemfd can be
> > used with either file or ram typed memory backends..
> 
> I recall that the following should work:
> 
> "private" memory will come from guest_memfd, "shared" (as in, accessible by
> the host) will come from anonymous memory.
> 
> This "anon" memory cannot be "shared" with other processes, but
> virtio-kernel etc. can just use it.
> 
> To "share" the memory with other processes, we'd need memfd/file.

Ah OK, thanks David.  Is this the planned long term solution for
vhost-kernel?

I wonder what happens if vhost tries to DMA to a region that is private
with this setup.

AFAIU, it'll try to DMA to the fake address of ramblock->host that is
pointing to by the memory backend (either anon, shmem, file, etc.).  The
ideal case IIUC is it should crash QEMU because it's trying to access an
illegal page which is private. But if with this model, it won't crash but
silently populate some page in the non-gmemfd backend.

Is that expected?

> 
> > 
> > When specified gmemfd=on with those, IIUC it'll allocate both the memory
> > (ramblock->host) and gmemfd, but without using ->host.  Meanwhile AFAIU the
> > ramblock->host will start to conflict with gmemfd in the future when it
> > might be able to be mapp-able (having valid ->host).
> 
> These will require a new guest_memfd memory backend (I recall that was
> discussed a couple of times).

Do you know if anyone is working on this one?

> 
> > 
> > I have a local fix for this (and actually more than below.. but starting
> > from it), I'm not sure whether I overlooked something, but from reading the
> > cover letter it's only using memfd backend which makes perfect sense to me
> > so far.
> 
> Does the anon+guest_memfd combination not work or are you speculating about
> the usability (which I hopefully addressed above).

IIUC, if with above solution and with how QEMU interacts memory convertions
right now, at least hugetlb pages will suffer from double allocation, as
kvm_convert_memory() won't free hugetlb pages even if converted to private.

It sounds like also doable (and also preferrable..) that for each of the VM
we always stich with pages in the gmemfd page cache, no matter if it's
shared or private.  For private, we could zap all pgtables and sigbus any
faults afterwards.  I thought that was always the plan, but I could lose
many latest informations..

Thanks,

-- 
Peter Xu


