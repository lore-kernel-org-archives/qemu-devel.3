Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA28C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHehQ-00006S-Vl; Wed, 21 May 2025 04:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHehO-0008Pn-GE; Wed, 21 May 2025 04:21:14 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHehK-0000eb-Ic; Wed, 21 May 2025 04:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747815670; x=1779351670;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Hh+nUxCSLeGPgtwvL2cg5MtqP4RP/+SynAUDmMEhYgw=;
 b=XqjJ18FLxOG+R1lfaSWfc9rqoEla0FkrKkot5aZXL0xgGgzQxWqsxfMU
 P3jDf3XziukcKI8P+OIfejiyBAbZoaXwVcH0g8JWOuXAnVYRGXg36522w
 swfrdRKuFedDRIlPb2LiAkT9ZzyKAw/jrIrHtsgipPGJpTJQ3WTPBRAoJ
 sgUv3moen7aip6JW/H+a4N0L2CPlJhLkVfOd7SnglqgQBp1c1cYDgjHZ4
 //IN6WlpffPj8gftjZtmp2E/gQvkdfNf0CQ7RPUqTkuoDudxfbZh790eU
 B2VrqPxGS9BZH0eWSXM7rEod0rltDazJ0pB+/q5vA7Dgi1Wz16ppLCa03 w==;
X-CSE-ConnectionGUID: uDg3E+HtRxa57pl8cb3iZQ==
X-CSE-MsgGUID: zV0MsFulRs2I7mxEZNe3tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60015244"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="60015244"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 01:21:03 -0700
X-CSE-ConnectionGUID: gE+Rdd1NTw2+9z1toHOTOA==
X-CSE-MsgGUID: hGhLjPjpR9iW77XbnyCxDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="141017027"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 21 May 2025 01:21:01 -0700
Date: Wed, 21 May 2025 16:42:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <bonzini@gnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Rust in QEMU update, April 2025
Message-ID: <aC2R4BOR2tsYgEFI@intel.com>
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <aCysct2L8Bosqy0N@intel.com>
 <abe683f2-e679-4579-b68a-38a11d41e00b@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe683f2-e679-4579-b68a-38a11d41e00b@gnu.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 07:48:11PM +0200, Paolo Bonzini wrote:
> Date: Tue, 20 May 2025 19:48:11 +0200
> From: Paolo Bonzini <bonzini@gnu.org>
> Subject: Re: Rust in QEMU update, April 2025
> 
> On 5/20/25 18:23, Zhao Liu wrote:
> > > HPET does some very simple memory accesses; a good safe solution
> > > for this may be the ``vm-memory`` crate.  While I have not looked into
> > > using it, ``vm-memory`` and ``vm-virtio`` were written with QEMU's
> > > use cases in mind.
> > I'm working on this and trying to wrap simple memory access by
> > vm-memory.
> 
> Ok.  Note that while the GuestAddressSpace corresponds QEMU's AddressSpace
> (so far so good :)), QEMU's MemoryRegion is completely unrelated to
> vm-memory's GuestMemoryRegion.  That's because vm-memory only operates on an
> array of non-overlapping regions, like QEMU's FlatRange or
> MemoryRegionSection structs.
> 
> The GuestMemory (GuestAddressSpace::M) corresponds to QEMU's FlatView.
> Indeed the functions in the trait match with what you expect of a FlatView:
> 
>     fn num_regions(&self) -> usize;
>     fn find_region(&self, addr: GuestAddress) -> Option<&Self::R>;
>     fn iter(&self) -> impl Iterator<Item = &Self::R>;

This is indeed exactly what I meet now. GuestMemory and QEMU's design don't
macth well! I've learned from the lessons of failure that MemoryRegion is
different from GuestMemoryRegion. Thank you for pointing the direction and
helping me decide to switch to FlatView.

> If the GuestMemory is a FlatView, the GuestAddressSpace::T, implements Clone
> + Deref<Target = FlatView>.  It's not too hard to see that
> GuestAddressSpace's memory() method must call address_space_get_flatview()
> and the GuestAddressSpace::T's drop method must call flatview_unref().
> Let's call this (Rust-specific) struct FlatViewRefGuard, or something like
> that.

I also realize that once FlatRange/FlatView is associated with GuestMemoryRegion/
GuestMemory, it changes the usual practice in QEMU, where most memory operations
are built around MemoryRegion/AddressSpace.

But that's okay because what users aware is the vm-memory interface.

> Going back to the GuestMemoryRegion (<FlatView as GuestMemory>::R), it could
> be either a QEMU FlatRange or a MemoryRegionSection.  Neither are good
> options.  Without a MemoryRegionSection you can't support IOMMU regions; but
> flatview_do_translate() returns the MemoryRegionSection by value, and
> GuestMemory's
> 
>     fn find_region(&self, addr: GuestAddress) -> Option<&Self::R>;
> 
> wants a reference instead!

Yes, there will be many gaps.

> Anyhow, all three types (AddressSpace, FlatView, FlatRange) are better
> wrapped with Opaque.
> 
> Looking more at FlatRange, these are easy:
> 
>     // Required methods
>     fn len(&self) -> GuestUsize;
>     fn start_addr(&self) -> GuestAddress;
> 
> But this one is another problem:
> 
>     fn bitmap(&self) -> &Self::B;
> 
> because it returns the "Bitmap" by reference.  QEMU's bitmap is a global
> variable indexed by ram_addr_t.  It would be better if this was declared
> like this:
> 
>    fn bitmap(&'a self) ->
>       <Self::B as WithBitmapSlice<'a>>::S
> 
> I have no idea if this can be changed in upstream vm-virtio.  For now maybe
> you can leave it as ().  That's buggy but it's ok for a proof of concept.

Yes, the bitmap is also a problem for me, and I also haven't figured out
how to align it with rust-vmm. In fact, in the code (that currently doesn't
run), I indeed used `()`. :-(

> So... not sure what to do there.  It seems like vm-memory is very close to
> being usable by QEMU, but maybe not completely. :(

Is it possible or necessary for vm-memory to support overlap? Because I
feel that if it is possible, the problem might be simplified. (As a
beginner, I have yet to understand exactly how difficult it is.)

Thanks,
Zhao


