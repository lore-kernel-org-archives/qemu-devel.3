Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4238CD98F2
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 12:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbHf5-0000yA-7J; Sun, 21 Jun 2026 08:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wbHf1-0000xQ-D1
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 08:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wbHex-0003ok-Va
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782046342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZL2XYO9y9OkqTmi3pGZQ8KqD/78RwHqTrSxS8EQUPU=;
 b=CpLvbKlPDub5Hk7JiCiAudQ/JtGOreuLB6QWPPdnC0hLBzHKRFa5szJQ2FJXQm2Jilmw5I
 JLlYFNXLhxpgRSi00Gbkz7xBg15ZaH7ltjRmWNNlETthVXYtz+W/RgCfqBsgwi42ZWKh9J
 /fztikzbxcWWQfVzciHEKibwVmoyJEs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-RUe9vz2_P0eKOi8eNjHulw-1; Sun, 21 Jun 2026 08:52:20 -0400
X-MC-Unique: RUe9vz2_P0eKOi8eNjHulw-1
X-Mimecast-MFC-AGG-ID: RUe9vz2_P0eKOi8eNjHulw_1782046339
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49246459bc4so10976275e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782046339; x=1782651139; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZL2XYO9y9OkqTmi3pGZQ8KqD/78RwHqTrSxS8EQUPU=;
 b=eA4Jr6TPqNzxEwXA3w+OCXP94DCHS438e7yJTetPvoPJ8vy5sJwAfoma0uUDWchRC1
 Kf6SUui0CKKgAOHrZ8giuPtUxWwZn+5P4QEkv5aEQYrZ2l9Gazk8EnIEDYPMDwtYffcl
 Jh9gHpe8WOXX6JCnHcITXbfNFQZr0geenSY0CeHOg0ZpNB1MrP+fvH4299MwcCYbeU6J
 HTkrBjmeJUxWwOhw9F6K29t1nyVocZLKBpRj/0z2vs+A/1sD0mIyilN43tw+MZg1B4DM
 ZIAmLwU/LnjiWwdIdGY0nrwTqflZprsXMQ9Flm+vekUpJPZE7xOiZh4eaQV7odX6WNQG
 +79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782046339; x=1782651139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZL2XYO9y9OkqTmi3pGZQ8KqD/78RwHqTrSxS8EQUPU=;
 b=mfPyUL+yK2zQyTFhllcR20cShhM/NASewfOEOkJxt7rsWZOl6EtCBuTpK4w8v3v3BM
 Pity4usafNc+ZUXoby5QjZiqzyKMBH8f0cf/NwmamIADXloKx6DNLhjZimZe9/hahPrq
 SAFlDNdDVqBVFLG2I3PgBdnC7rYzQThJYzBwYLYnlruZAGXllRQ3qo0NcufXxDAfJE8m
 VDZvqibnH65eHbjN42KOLpY644NatSxHR9X6DPj/UB0PaUc9JmvIv62mMeugGKYYC9H9
 0XW+3CSZ9hfoXTjjf/ZWYNpZ4Gs2YnO988LpzMTDGs/SXTOEGAsH+uA1ZMuhA7u76TsY
 k2uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ka3Q/n8u1ZBgWNi5DkF1s9q24S+muJpi4ZuBEhC/yiR5blS5IoCP+o5xb/eCLZYKA1QGbzIakmmtK@nongnu.org
X-Gm-Message-State: AOJu0Yw1Hcvkz+tUXyuOn+Ujis8c3eKxU8VOXOUGJKrBXNWLmL+oUGMx
 OhPMeVs1biOeQeAsSe3zDZ1XFd7cVSFbhRw0RJqy6dJYRyCdU8Yngr+ncFIBszDgxk+YGMfZ3Eq
 2PfPrhyzvcQkXSgBE2HjAmQg3vBDuZ3mHxDRuYlblSGL+VAwtV7gI5PFg
X-Gm-Gg: AfdE7cnsF+lrsCE2Pcskh0tajJhsP3GPPiC2JZk0tifVb/6eQskRhn83SA8oCrcO3tP
 R0CZaWIJkRS0Pw+IQMQ+qVJvNcW8zLiDY3Y4W97UfoaHjuDwlT1GHoEXN7N2HxF4bZ5IaWnqFS2
 AjU7gTrxqZExSSf9InTYLLpqt0ZCtdCabM/r1cmA8BGnx/hDM+pC97Pmgeiqju3DouGPu9bImT1
 gRRcm9430L9K9Og3LRh3MAxb7CxqNCgVL1XvW/rtRLk+wdKlNNoPAsGhqlmoVQRnOlt4PJKIqmA
 3GbFBNPPev0yhyclA/fhs7AQCqgwuOgMyGifN0lIrGTjd+wyiA3Ga+JYc2eaDFHqrK9BMJTuX43
 p4vWhb5gvRpkgLzYDoQC5a3Tl/2hp48nJ
X-Received: by 2002:a05:600c:5290:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-49242189b1cmr153416905e9.0.1782046339198; 
 Sun, 21 Jun 2026 05:52:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5290:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-49242189b1cmr153416445e9.0.1782046338459; 
 Sun, 21 Jun 2026 05:52:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5ddbsm17777541f8f.12.2026.06.21.05.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 05:52:17 -0700 (PDT)
Date: Sun, 21 Jun 2026 08:52:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: list of memory/memcpy access issues
Message-ID: <20260621031129-mutt-send-email-mst@kernel.org>
References: <20260617022330-mutt-send-email-mst@kernel.org>
 <3f58de99-74a2-4ccc-b800-d254bbd40931@redhat.com>
 <20260619004237-mutt-send-email-mst@kernel.org>
 <829e6103-7f82-4884-9892-86cfb7b743bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829e6103-7f82-4884-9892-86cfb7b743bb@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jun 21, 2026 at 04:51:55PM +1000, Gavin Shan wrote:
> On 6/19/26 3:33 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 19, 2026 at 10:44:17AM +1000, Gavin Shan wrote:
> > > On 6/17/26 5:14 PM, Michael S. Tsirkin wrote:> This is a top post attempting to summarize some findings related to
> > > > emulating DMA and MMIO existing in QEMU memory core
> > > > using memcpy/memmove.
> > > > 
> > > > Hopefully, this will help inform discussion about multiple
> > > > changes currently proposed for QEMU.
> > > > 
> > > > At a high level, and in a variety of configurations, QEMU gets
> > > > DMA requests from a virtual device, or MMIO requests from
> > > > a VCPU, and wants to execute them either on guest ram or
> > > > passhtrough device memory.
> > > > 
> > > > Down the road this almost always (virtio ring implementation seems to be
> > > > a notable exception) translates to memcpy/memmove calls
> > > > (glibc e.g. on x86 currently implements memcpy through memmove).
> > > > 
> > > > However, memcpy's signature is:
> > > >          void *memcpy(void *dest, const void *src, size_t n);
> > > > note how neither src not more importantly dest are volatile.
> > > > Thus it was never designed either for a concurrent access
> > > > by another CPU, or for accessing devices.
> > > > (Mis)using it for that gives good performance but has issues,
> > > > some of which I am trying to enumerate below.
> > > > 
> > > > In the below I say memcpy but same applies to memmove just as well.
> > > > 
> > > 
> > > Firstly, thanks to Michael for the summary and helps to lead the discussions.
> > > 
> > > I went through the listed questions and suggestions, but I'm not sure if
> > > I understood every question and suggestion.
> > > 
> > > Figured out that we probably
> > > need to something as below. Please take a look when you get a chance to
> > > check if there are any gaps.
> > > 
> > > S1: New field MemoryRegion::cache_mode to indicate how it has been mapped
> > >      for those directly accessible regions: cache_{normal, writecombine, no}
> > >      corrresponding to pgprot_{normal, writecombine, noncached}.
> > > 
> > >      S1.1 MemoryRegion::cache_mode is meaningful to those directly accessible
> > >           regions like ram, ram device and rom device regions
> > >      S1.2 MemoryRegion::cache_mode should be set when those directly accessible
> > >           regions are created
> > >      S1.3 Only cache_{normal, writecombine} regions can be directly accessible
> > 
> > What is "directly accessible" here? That all memory ops thinkable work?
> > E.g. on power8 not all ops work on pgprot_writecombine, either (and glibc memcopy
> > uses these).
> > I am not 100% sure that's a sane userspace API. It's an internal kernel one.
> > If we are mirroring kernel, we need to include pgprot_device - the CDX vfio
> > driver uses it.
> > 
> > But if you want to know what memory instructions work from userspace, there is
> > a lot of detail and pgprot_ macros do not cover all of them.
> > 
> 
> A region is 'directly accessible' when memory_access_is_direct() returns true
> for it. The accesses to the directly accessible regions are turned into memcpy()
> and memmove()

This is unlikely to *generally* be safe for any memory that can be concurrently
accessed by guest. Not device memory, nor guest memory.
But, it might be safe for specific architectures, devices, and lengths.
A heuristic similar to "memcpy/memmove for specific lengths" might
practically work, though.


> in flatview_{read, write}_continue_step(), or {ldm, stm}_p() in
> address_space_{ldm, stm}_internal(). Currently, the mmapable VFIO PCI BARs are
> exposed as ram device regions, which are indirectly accessible. One of our goals
> is to make part of the mappable VFIO PCI BARs (not all of them) directly accessible,
> so that the DMA bounce buffer is bypassed when the DMA target buffer resides in
> the BAR (region).
> 
> Yes, I don't know if pgprot_xxx is adequate or not, but it's just the thought. We
> probably need more information like the combination (host_arch, guest_arch, pgprot_xxx).
> The idea is to have more information fed to MemoryRegion and our private accessing
> functions, which are mentioned in S2 to replace the standard memcpy() and
> memmove(), know which instructions are safe to use, if vector instructions can
> be used, and whatever else.
> 
> I don't think we can do everything in one shot. Initially, we probably just provide
> a sustainable design (or inrastructure) for long-term evolving. From there, we can
> extend it to other architectures and cases step by step.
> 
>     #if defined(__x86_64__) || defined(__aarch64__)
>     #define RAM_DEVICE_REGION_CAN_BE_DIRECTLY_ACCESSIBLE  1
>     #define USE_OUR_OWN_MEMCPY_AND_MEMMOVE                1
>     #else
>     #define RAM_DEVICE_REGION_CAN_BE_DIRECTLY_ACCESSIBLE  0
>     #define USE_OUR_OWN_MEMCPY_AND_MEMMOVE                0
>     #endif
> 
> we also can put more constraints to S1.3 so that only cache_normal
> MMIO region can be directly accessible.

The idea that anything at all is "directly accessible" is kinda flawed.
memcpy can easily be broken for a specific use and it does not
then matter how the memory is mapped.

>     S1.3 Only cache_normal regions can be directly accessible. The question
>          is the cache_normal MMIO region is tolerant to unaligned and vectored
>          access on all architectures?
> 
> > 
> > > S2: qemu_ram_{copy, move}() which are our private implementations of memcpy()
> > >      and memmove(). They're going to replace memcpy/memove() in the memory
> > >      region directly access paths like flatview_{read, write}_continue_step()
> > > 
> > >      S2.1 Small fixed length (1/2/4/8 bytes) accesses shouldn't be either
> > >           split or reordered
> > >      S2.2 Arcitectural optimization based on the MemoryRegion::cache_mode,
> > >           unaligned accesses and vector instructions may be allowed
> > 
> > hmm. meaning what exactly?
> > 
> 
> glibc::{memcopy, memmove}() aren't reliable. There are several related bugs,
> as you listed. For [1], where one-byte-store is translated to triple stores
> to same location. it seems we have to bypass glibc::memcopy(), at least for
> some cases? If so, we need our own (well-behaved) memcpy/memmove(), and
> qemu_ram_{copy, move}() are our own implementations to replace memcpy/memmove()
> in the direct access paths.
> 
>     [1] example of a bug caused by memcpy as result of DMA
>         https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn
>     [2] an attempt to fix bugs caused by memcpy to device memory in response to
>         MMIO. 4a2e242bbb "memory: Don't use memcpy for ram_device regions"
>         https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg08129.html

But note the ordering issues (of which multiple stores are one example)
are distinct from ISA issues, and they apply universally for any memory.



> > > 
> > > S3: Support VFIO_REGION_INFO_CAP_MMAP_CACHE_MODE where cache_{normal,
> > >      writecombine, no} is provided for every mmapable region or all
> > >      sparse mmaps on the region
> > 
> > seems like you are trying to drive the cache mode from userspace?
> > but how will userspace know what to set?
> > I'd expect, instead, to just have VFIO report how it is mapped.
> > 
> 
> No, the capability should be reported by host's VFIO PCI driver. For my GH100
> specific case, it's nvgrace_gpu_vfio_pci driver where this capability is reported.

good

> > > 
> > >      S2.1 The capability is only meaningful when VFIO_REGION_INFO_FLAG_MMAP
> > >           is absent
> > >      S2.2 All sparse mmaps for one specific region should have unified cache
> > >           mode
> > 
> > you can not trust userspace to do that.
> > 
> 
> See above explanation. We don't trust userspace to do it. Instead, the host's
> VFIO PCI driver needs to report it.

good

> > > 
> > > > 
> > > > ------------------
> > > > 
> > > > 1. On x86, memcpy is different from __builtin_memcpy if
> > > > one uses old 1.0 force-headers from 2019. Thus, QEMU
> > > > sometimes uses __builtin sometimes it does not, inconsitently.
> > > > Likely no longer relevant and should be cleaned up.
> > > > 
> > > 
> > > S2. old 1.0 force-headers won't be used with S2?
> > > 
> > > > 
> > > > 2. variable length memcpy can translate 2,4,8 byte guest access
> > > > into multiple byte accesses. doing this for mmio is
> > > > guaranteed to break devices.
> > > > 
> > > 
> > > S2.1. However, is it still a problem when the MMIO region is mapped with
> > > pgprot_{normal, writecombine}?
> > 
> > MMIO as pgprot_{normal, writecombine} will break devices whatever
> > userspace does.
> > 
> 
> If we're going to introduce something similar to linux-kernel::readl/writel(),
> and use them to access MMIO region, it should be fine then?
> 

For aligned memory. Unaligned accesses seems to be generally unfixable
unless host and guest are x86. We can split them up and hope for the
best, given we always did.

> > 
> > > > 
> > > > 3. (theoretical concern) also on x86, unaligned accesses are possible on guest and host,
> > > > so converting an unaligned access to a series of aligned ones can
> > > > in theory break devices.
> > > > 
> > > 
> > > S1.3, the directly accessible regions have attribute cache_{normal, writecombine}
> > > where unaligned access is allowed. The question is unaligned access on those
> > > regions are always safe on all architectures?
> > 
> > Define "directly accessible regions". Or better, avoid even thinking
> > in these terms.
> > 
> 
> Please see my explanation above.
> 
> > 
> > > > 4. also on x86, vector instructions for large (>16 byte) writes
> > > > into pgprot_noncached memory are safe and faster than multiple 8 byte
> > > > ones.
> > > > 
> > > 
> > > S1.3, region with pgprot_noncached is indirectly accessible.
> > > 
> > > > 5. also on x86 it so happens that if you write a fixed-size memcpy this
> > > > gets optimized to a single store/load and it works for aligned and
> > > > unaligned addresses on that architecture. How to ensure this keeps being
> > > > correct is left as an excerise for the reader. But qemu already relies
> > > > on this and did for years.
> > > > 
> > > 
> > > Sorry, Not fully understood.
> > 
> > 
> > what is unclear? on x86, and some others, glibc will see size 1,2,4 and
> > maybe 8 of 64 and inline memcpy and it happens to do exactly a single
> > load/store.  and code in bswap.h relies on this to mirror guest MMIO on
> > the host. So assuming that is it least not regressing too much.
> > 
> 
> Ok. So you're saying that __builtin_{memcpy, memmove}() aren't safe for MMIO
> accesses?


No, I am saying 1,2,4 byte __builtin_{memcpy, memmove} on x86 hosts
are currently translated to single 1,2,4 byte stores/loads,
and they work for unaligned accesses, which is nice.
I am also saying there's no difference between them and memcpy/memmove
on modern systems.


> All the functions in bswap.h, based on __builtin_{memcpy, memmove}(),
> are only safe to RAM accesses, but unsafe to MMIO accesses?
> 
> Currently, ram_device_mem_ops::memory_region_ram_device_write() runs into
> stn_he_p() and then __builtin_memcpy(), which aren't safe to access to VFIO PCI
> BARs. This path wasn't considered in the proposed design and something needs
> to be considered in the revised design. For this, I'm going add the following
> context to the design.
> 
> S1: A new set of functions added to include/qemu/io.h, similar to linux/
>     include/asm/io.h::{read,write}{b, w, l q}() to access MMIO region
> 
>     S1.1 Those new fuctions will be used to access MMIO region
>          S1.1.1 Directly access paths in address_space_{ldm, stm}_internal(),
>                 to replace {ldm, stm}_p().
>          S1.1.2 Directly access paths in flatview_{read, write}_continue_step()
>                 to replace memcpy() and memmove().
>          S1.1.3 Indirectly access paths where MemoryRegionOps is invoked, to
>                 replace {ldn, stn}_he_p() or their RAM access variants if the
>                 region is a MMIO region.
> 
> > 
> > 
> > > It's perhaps covered by S2 if we're talking
> > > about address_space_{read,write}. If we're talking about address_space_{ldl, stl}(),
> > > we perhaps need to replace __builtin_{memcpy, memmove}() with those private
> > > functions introduced in S2.
> > 
> > Not sure what "covered" means.
> > 
> 
> Ok, it's not important now since the paths invokved by those functions in bswap.h,
> which target a MMIO region, aren't considered in the proposed design.
> 
> > 
> > > 
> > > > 6. on non-x86 both unaligned accesses and vector instructions
> > > > for accessing  UC memory are illegal.
> > > > 
> > > 
> > > Assume UC is equivalent to pgprot_noncached. In that case, it's true on aarch64
> > > at least. With S1.3 applied, this kind of region becomes indirectly accessible.
> > > 
> > > > 7. standard vfio gives KVM VM_ALLOW_ANY_UNCACHED, so even on non x86
> > > > guest can
> > > > map the memory as as pgprot_noncached/ioremap or pgprot_writecombine/ioremap_uc.
> > > > If it does the second then it can use unaligned or vector for access.
> > > > This is why normal passthrough tends to work - it never traps to qemu at
> > > > all.
> > > > 
> > > > 
> > > > But for qemu, vfio uses  pgprot_noncached unconditionally so qemu
> > > > can't use unaligned or vector instructions on non-x86.
> > > > 
> > > 
> > > VM_ALLOW_ANY_UNCACHED is exclusively to arm64 since commit 8c47ce3e1d2c ("KVM:
> > > arm64: Set io memory s2 pte as normalnc for vfio pci device). After that, all
> > > VFIO PCI BARs have pgprot_writecombine attribute on arm64, thus unaligned or
> > > vector accesses are safe on those BARs from guest POV instead of host.
> > 
> > But not e.g. on power8, sadly.
> > 
> 
> Ok. With more constraints applied to S1.3 as I mentioned above, only cache_normal
> regions can be directly accessible, I guess power8 will be happy with unaligned
> and vector access?
> 
>     S1.3 Only cache_normal regions can be directly accessible. The question
>          is the cache_normal MMIO region is tolerant to unaligned and vectored
>          access on all architectures?

I assume you mean pgprot_normal?

For unaligned access there - generally no, but of major ones qemu cares
about, I think only sparc and maybe riscv don't support unaligned memory
accesses for pgprot_normal. Of others, I think mips doesn't.

And I am not sure what do you call "MMIO region".


> > > I maybe
> > > wrong and Alex can correct me.
> > > 
> > > S1.3 only cache_{normal, writecombine} regions can be directly accessible.
> > > A region with pgprot_noncached attribute is indirectly accessible.
> > > 
> > > > 
> > > > 8. But for nvgrace RAM, vfio has a driver that uses pgprot_writecombine/ioremap_uc.
> > > > so qemu could safely use unaligned/vector instructioons even on non-x86.
> > > > 
> > > 
> > > For my specific case related to GH100 card, Region-0/2 have pgprot_writecombine
> > > while Region-4 has pgprot_normal attribute.
> > > 
> > >    Region 0: Memory at 44080000000 (64-bit, prefetchable) [size=16M]
> > >    Region 2: Memory at 44000000000 (64-bit, prefetchable) [size=2G]
> > >    Region 4: Memory at 42000000000 (64-bit, prefetchable) [size=128G]
> > > 
> > > 
> > > > 9. Except sadly, vfio currently does not tell qemu how it maps
> > > > the memory, so qemu can not know what is safe on non-x86.
> > > > 
> > > 
> > > S3. Host VFIO driver needs ABI changes to expose the cache mode.
> > > 
> > > > 10. on x86 memcpy will sometimes do multiple overlapping stores when
> > > > size is not a power of 2. for example, a 15 byte write is done with
> > > > 2 8-byte stores. This is theoretically an issue
> > > > if guest does something super clever with ordering,
> > > > but does not seem to be in practice.
> > > > 
> > > 
> > > S2. This should be avoided in qemu_ram_{copy, move}() which are going to replace
> > > the standard memcpy() and memmove().
> > > 
> > > 
> > > > 11. on non-x86 memcpy will do multiple overlapping stores even
> > > > for single byte writes. E.g. it does it to avoid extra branches.
> > > > This is causing issues in practice.
> > > > 
> > > 
> > > S2, This should be avoided in qemu_ram_{copy, move}().
> > > 
> > > 
> > > > 12. PCI writes are in order, last byte is written last.
> > > > memmove especially writes last byte first sometimes.
> > > > Violating that theoretically can break guests.
> > > > 
> > > 
> > > S2, the reordering should be avoided in qemu_ram_{copy, move}(). However,
> > > I would think this region becomes indirectly accessible with S1.3 applied?
> > > 
> > > 
> > > > 13. but if we are copying between 2 addresses that are overlapping,
> > > > the standard trick (used by memmove) is to compare dst and src and copy
> > > > backwards if dst < src, so last byte is written first.
> > > > 
> > > 
> > > Backwards copying happens on (dst > src) not on (dst < src). We potentially
> > > convert this to a forwards copying by moving the data in the overlapped area
> > > to somewhere else, and then take that as the src in the subsequent forwards
> > > copying.
> > 
> > Not that simple. Issue is, the size of the overlap is not really limited.
> > Maybe make last X bytes go through the buffer, the rest copy backwards and hope for the best?
> > 
> 
> I guess it would work with luck. Alternative, it can be converted to two
> forwards copying. The source buffer is split into two parts, the second
> part of the source buffer is copied before the first part.

I'm not sure I see it:

Imagine: src 0 to 2G, dst 1G to 3G


SRC:
1G ------ 1G ------- 2G

DST:
          1G ------- 2G ------ 3G


if you want to emulate pci ordering exactly, DST has to be over-written
in exactly address order.

I don't yet see how it can be done without buffering 1G data.




> > 
> > > I think it's unliekly to be a directly accessible region with S1.3 applied.
> > 
> > No, this does not have much to do with how the region is mapped.
> > If guest or device write bytes 1 to X in order and you decide to
> > write them X to 1, you have broken some drivers, unless you know
> > exactly how the device and driver are supposed to work.
> > 
> 
> Ideally, we should disallow data movement between two overlapped MMIO regions.

Sadly, devices use exactly this for DMA, this is why qemu switched to
memmove.

> In APIs of linux kernel like readl/writel, one of the operand always resides
> in RAM, the source/destination are never overlapped.



> > 
> > > 
> > > > -------------
> > > > 
> > > > 
> > > > 
> > > > Some conclusions:
> > > > 
> > > > A. on x86, we must avoid converting 2,4,8 byte accesses into byte accesses.
> > > > At least for aligned, perferably for unaligned accesses too.
> > > > Fixed width memcpy seems to work for this. Whether we should bother with
> > > > __builtin to work around broken old fortify headers, I donnu.
> > > > I do not have any answer how to check that compiler does this correctly.
> > > > If anyone is motivated enough, adding a GCC builtin could be possible.
> > > > Given qemu did this for years, I think we can leave solving this for
> > > > another day.
> > > > 
> > > 
> > > Covered by S2.1
> > > 
> > > > B. Also on many architectures, memcpy is much faster for large transfers
> > > > than iterating over 8 byte chunks in C.
> > > > When we can get away with doing that (e.g. for emulated devices where
> > > > we know the concurrency rules, writing into guest RAM), we should.
> > > > 
> > > 
> > > S2.2, something related to performance optimization for the future
> > > 
> > > > C. on non-x86, we currently must not memcpy into host devices
> > > > since we do not know if it is pgprot_noncached. yes, performance will be
> > > > bad for DMA into device RAM.
> > > > 
> > > 
> > > S1.3. This specific region becomes indirectly accessible after S1.3 is applied.
> > > 
> > > > 
> > > > D.  It goes without saying that casting an unaligned address to unint32_t
> > > > (be it for qatomic_set or whatever) is undefined behaviour in C
> > > > and so a bad idea on any architecture.
> > > > 
> > > 
> > > S1.3. The directly accessible region always have cache_{normal, writecombine}
> > > attribute.
> > > 
> > > > 
> > > > E. also for non-x86, we really should teach vfio to tell qemu whether
> > > > it maps device pgprot_noncached or pgprot_writecombine.
> > > > we will then be able to do things like use vector ops
> > > > (through memcpy or not) for >8 accesses.
> > > > 
> > > 
> > > S3. pgprot_normal is also needed. In my case related to GH100 card, the PCI
> > > BAR-4 is mapped with pgprot_normal.
> > > 
> > > Yes, with those information fed to MemoryRegion::cache_mode in S1, it's
> > > possible to optimize qemu_ram_{copy, move}() in S2.2 for the performance sake.
> > > 
> > > 
> > > > F. Arbitrary device passthrough with drivers doing unalined accesses and
> > > > when working cross architectures basically is a best effort thing.  It
> > > > can't be 100% perfect for all devices.
> > > > 
> > > 
> > > Yes. For the first step, we perhaps need to gurantee the directly accessible region
> > > have pgprot_{normal, writecombine} in S1.3 if you agree.
> > 
> > I do not know what "directly accessible" is and I feel we should get
> > out of the habit of thinking in these terms.
> > VFIO likely DTRT mapping already, and userspace really has no
> > business overriding it.
> > 
> 
> Sorry that I didn't explain 'directly accessible', which has been explained at
> the beginning of this reply.
> 
> > 
> > > > 
> > > > --------------------
> > > > 
> > > > Links:
> > > > 
> > > > 
> > > > example of a fix for a bug caused by memcpy to overlapping addresses:
> > > > 4a73aee881 - "softmmu: Use memmove in flatview_write_continue"
> > > > https://lore.kernel.org/qemu-devel/20230131030155.18932-1-akihiko.odaki@daynix.com
> > > > 
> > > > 
> > > > example of a bug caused by memcpy as result of DMA:
> > > > https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn
> > > > 
> > > > an attempt to fix bugs caused by memcpy to device memory in response to
> > > > MMIO:
> > > > 4a2e242bbb "memory: Don't use memcpy for ram_device regions"
> > > > https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg08129.html
> > > > 
> > > 
> 
> Thanks,
> Gavin


