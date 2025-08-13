Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5F3CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCRH-0000us-R4; Wed, 13 Aug 2025 10:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCR8-0000uZ-8M; Wed, 13 Aug 2025 10:26:42 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCQi-0005k9-EH; Wed, 13 Aug 2025 10:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755095176; x=1786631176;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=a5y3B8LCZDFWvjHQbj/gRBjzwV9ueDVJP9ZYf958Te0=;
 b=lCZXAMvkv/+78fHmFIMZHaa1LouYH1GsL2v96FXgmA6k2S/utQRXStLG
 9wc6uXmY1zuby1S3XB7anXJRmSrFEh9vdqFzfXv0vEgjEkhNkQ/BvCJ5v
 lYhnlm6cqtieG4ZkikbsEfSTUC3yEB+8tF1BZ8C+OnijjT50xP295Nc8l
 yQ1hhuY8jVa/h91wy6TDhBAZ+3HPyvVWBR0HCvqkOEqmolTwk/BuSVcLW
 QFv/lUzFmFqByBVXp4lt4cvTCFSv7Nn/r2uQXgOZXmNZrteK4NuHbOoft
 7pNm2qT5JzHnhrL2DOC9uMGro4BLcSdM26T1dCpQi0EpB/QUZxPxRLr/u Q==;
X-CSE-ConnectionGUID: fZ4j5p0sSYiUZSI/ZIExpQ==
X-CSE-MsgGUID: 1JiTyjL3SLqSzmRFJJzsPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56600895"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="56600895"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 07:26:00 -0700
X-CSE-ConnectionGUID: dC/NdvrrQWG+/Fssc2fWWQ==
X-CSE-MsgGUID: CWtlt2RRSFWOBIG9RAgLgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="197339564"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 13 Aug 2025 07:25:57 -0700
Date: Wed, 13 Aug 2025 22:47:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 24/26] rust/memory: Provide AddressSpace bindings
Message-ID: <aJyli3cW/Pifl+e2@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-25-zhao1.liu@intel.com>
 <3ce35920-919b-4caf-87c5-b92bd603388a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce35920-919b-4caf-87c5-b92bd603388a@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 07, 2025 at 03:50:45PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:50:45 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 24/26] rust/memory: Provide AddressSpace bindings
> 
> On 8/7/25 14:30, Zhao Liu wrote:
> > +impl GuestAddressSpace for AddressSpace {
> > +    type M = FlatView;
> > +    type T = FlatViewRefGuard;
> > +
> > +    /// Get the memory of the [`AddressSpace`].
> > +    ///
> > +    /// This function retrieves the [`FlatView`] for the current
> > +    /// [`AddressSpace`].  And it should be called from an RCU
> > +    /// critical section.  The returned [`FlatView`] is used for
> > +    /// short-term memory access.
> > +    ///
> > +    /// Note, this function method may **panic** if [`FlatView`] is
> > +    /// being distroying.  Fo this case, we should consider to providing
> > +    /// the more stable binding with [`bindings::address_space_get_flatview`].
> > +    fn memory(&self) -> Self::T {
> > +        let flatp = unsafe { address_space_to_flatview(self.0.as_mut_ptr()) };
> > +        FlatViewRefGuard::new(unsafe { Self::M::from_raw(flatp) }).expect(
> > +            "Failed to clone FlatViewRefGuard: the FlatView may have been destroyed concurrently.",
> > +        )
> 
> This is essentially address_space_get_flatview().  You can call it directly,
> or you need to loop if FlatViewRefGuard finds a zero reference count.

Yes. Here address_space_get_flatview() is better.

> > +    }
> > +}
> > +
> > +impl AddressSpace {
> > +    /// The write interface of `AddressSpace`.
> > +    ///
> > +    /// This function is similar to `address_space_write` in C side.
> > +    ///
> > +    /// But it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
> > +    pub fn write(&self, buf: &[u8], addr: GuestAddress) -> Result<usize> {
> > +        rcu_read_lock();
> > +        let r = self.memory().deref().write(buf, addr);
> > +        rcu_read_unlock();
> 
> self.memory() must not need rcu_read_lock/unlock around it, they should be
> called by the memory() function itself.

Ah, then rcu just ensures &FlatView is valid since we increments its
ref count during rcu critical section.

But rcu will no longer cover the entire write process!

Combining this RcuGuard proposal in the reply of patch 13:

https://lore.kernel.org/qemu-devel/aJsX9HH%2FJwblZEYO@intel.com/

impl AddressSpace {
    pub fn get_flatview<'g>(&self, rcu: &'g RcuGuard) -> &'g FlatView {
        let flatp = RcuCell::new(self.deref().current_map);
        unsafe { FlatView::from_raw(flatp.get(rcu).unwrap()) }
    }
}

impl GuestAddressSpace for AddressSpace {
    fn memory(&self) -> Self::T {
        let rcu = RcuGuard::new();
        FlatViewRefGuard::new(self.get_flatview(&rcu)).unwrap()
    }
}

rcu is dropped at the end of memory(). So `&'g RcuGuard` is not enough
for this case.

> > +        r.map_err(guest_mem_err_to_qemu_err)
> > +    }
> 
> I think it's ok to return the vm-memory error.  Ultimately, the error will
> be either ignored or turned into a device error condition, but I don't think
> it's ever going to become an Error**.

Sure, and for HPET, the error isn't be handled except panic...

> > +    /// The store interface of `AddressSpace`.
> > +    ///
> > +    /// This function is similar to `address_space_st{size}` in C side.
> > +    ///
> > +    /// But it only assumes @val follows target-endian by default. So ensure
> > +    /// the endian of `val` aligned with target, before using this method.
> 
> QEMU is trying to get rid of target endianness.  We should use the vm-memory
> BeNN and LeNN as much as possible.  It would be great if you could write
> either

Yes, this is the ideal way. 

This will involve the changes in both vm-memory and QEMU:

* vm-memory: we need to implement AtomicAccess trait for BeNN and LeNN in
  vm-memory (but this is not a big deal).

* For QEMU,

Now to handle AtomicAccess, I've abstracted a uniform C store() binding
in patch 21:

MemTxResult section_rust_store(MemoryRegionSection *section,
                               hwaddr mr_offset, const uint8_t *buf,
                               MemTxAttrs attrs, hwaddr len);

If you haven't looked at this, you can see the comments in:

impl Bytes<MemoryRegionAddress> for MemoryRegionSection {
    fn store<T: AtomicAccess>(
        &self,
        val: T,
        addr: MemoryRegionAddress,
        _order: Ordering,
    ) -> GuestMemoryResult<()> {}
}

section_rust_store() supports target endian by default like
address_space_st(). If we wants to add LE & BE support, I think we have
2 options:
 1) Add another endian argument in section_rust_store, but this also
    requires to pass endian informantion in Bytes trait. Ethier we need to
    implement Bytes<(MemoryRegionAddress, DeviceEndiann)>, or we need to
    add endian info in AtomicAccess.

 2) simplify section_rust_store() further: ignore endian stuff and just
    store the data from *buf to MMIO/ram. For this way, we need to
    adjust adjust_endianness() to do nothing:
    section_rust_store()
     -> memory_region_dispatch_write()
      -> adjust_endianness()

    However, adjust_endianness() is still very useful, especially for
    QEMU, the caller of store() doesn't know the access is for MMIO or
    RAM.

So I prefer 1) for now, and maybe it's better to add endian info in
AtomicAccess.

>     ADDRESS_SPACE_MEMORY.store::<Le32>(addr, 42);
> 
> or
> 
>     let n = Le32(42);
>     ADDRESS_SPACE_MEMORY.store(addr, n);
> 
> but not
> 
>     ADDRESS_SPACE_MEMORY.store(addr, 42);

Yes, this way is similar with my previous attempt...but I don't know
what's the best to handler LE/BE, so this RFC just omitted these cases,
and chose a simplest case - native endian.

> (Also I've not looked at the patches closely enough, but wouldn't store()
> use *host* endianness? Same in patch 23).

It seems QEMU's interfaces don't use *host* endianness?

I'm referring address_space_ld*() & address_space_st*(), and their doc
said:

/* address_space_ld*: load from an address space
 * address_space_st*: store to an address space
 *
 * These functions perform a load or store of the byte, word,
 * longword or quad to the specified address within the AddressSpace.
 * The _le suffixed functions treat the data as little endian;
 * _be indicates big endian; no suffix indicates "same endianness
 * as guest CPU".
 *
 * The "guest CPU endianness" accessors are deprecated for use outside
 * target-* code; devices should be CPU-agnostic and use either the LE
 * or the BE accessors.
 */

I also considerred host endianness. But host endianness doesn't align
with C side... C side only supports little/big/native (target/guest)
endianness.

So, do you think Rust side should consider host endianness? Or maybe
we can add DEVICE_HOST_ENDIAN in device_endian. But is there the way to
check what the specific endianness of Host is?

Thanks,
Zhao


