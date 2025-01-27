Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00E4C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNgK-0005bB-W2; Mon, 27 Jan 2025 06:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcNgF-0005ad-Qy; Mon, 27 Jan 2025 06:53:28 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcNgD-0006fE-Qn; Mon, 27 Jan 2025 06:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737978806; x=1769514806;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=p/Ns84pvmRRQ8Ec+5wKSMGcwxNxmeBZgWM/aBoB6Es4=;
 b=b0CIrOh5I3u9tIh4M4YqcZ6Qb6IecuGgX2n+V7kJdw5n8X4qeaNL5xB4
 jCWmeINk4q5ebij1/M4rU55Rxqpg+e1t8/iuW3q+aOQGanwXy6VXY0pPR
 RkrsplqHjWBQXtZSKeYjUIGafS97kJOPblhvTzmYD+oAg8WDvyFhe3d2P
 PH0k5Bf4EP0kmpJHJMaF8rYqX0EFnACIkEMjYp074jI4TeXujxQ6cPBpM
 uC9JeWuyzVcYE+Pl381jlZ4LTVIybXz0MvbfT3DQgQx6MbmHx5KqCZ45Y
 sgSQ5OL41+O02U2csVU9/3Y8E2Ae2q7NlJGy9tctyMvXH/hWm7ujE8ISu g==;
X-CSE-ConnectionGUID: ds2gzJ1FTQuKRvlVyaExcA==
X-CSE-MsgGUID: Rkoi2m9zS8eVG8lFNc0yFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42096731"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="42096731"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2025 03:53:23 -0800
X-CSE-ConnectionGUID: xPPbDs0FReGqHyTLavpFZA==
X-CSE-MsgGUID: 9LWblnFPRDyKmhCH4DlQLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="113381902"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 27 Jan 2025 03:53:21 -0800
Date: Mon, 27 Jan 2025 20:12:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/10] rust: bindings for MemoryRegionOps
Message-ID: <Z5d4PTtIRhgZ0tss@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 17, 2025 at 08:40:03PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:40:03 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/10] rust: bindings for MemoryRegionOps
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs     |  43 +++---
>  rust/hw/char/pl011/src/lib.rs        |   1 -
>  rust/hw/char/pl011/src/memory_ops.rs |  36 -----
>  rust/qemu-api/meson.build            |   1 +
>  rust/qemu-api/src/lib.rs             |   1 +
>  rust/qemu-api/src/memory.rs          | 191 +++++++++++++++++++++++++++
>  rust/qemu-api/src/sysbus.rs          |   7 +-
>  rust/qemu-api/src/zeroable.rs        |  12 ++
>  8 files changed, 234 insertions(+), 58 deletions(-)
>  delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>  create mode 100644 rust/qemu-api/src/memory.rs
 
...

> @@ -490,20 +490,24 @@ impl PL011State {
>      /// location/instance. All its fields are expected to hold unitialized
>      /// values with the sole exception of `parent_obj`.
>      unsafe fn init(&mut self) {
> +        static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
> +            .read(&PL011State::read)
> +            .write(&PL011State::write)
> +            .native_endian()
> +            .impl_sizes(4, 4)
> +            .build();
> +

Nice design. Everything was done smoothly in one go.

> +pub struct MemoryRegionOps<T>(
> +    bindings::MemoryRegionOps,
> +    // Note: quite often you'll see PhantomData<fn(&T)> mentioned when discussing
> +    // covariance and contravariance; you don't need any of those to understand
> +    // this usage of PhantomData.  Quite simply, MemoryRegionOps<T> *logically*
> +    // holds callbacks that take an argument of type &T, except the type is erased
> +    // before the callback is stored in the bindings::MemoryRegionOps field.
> +    // The argument of PhantomData is a function pointer in order to represent
> +    // that relationship; while that will also provide desirable and safe variance
> +    // for T, variance is not the point but just a consequence.
> +    PhantomData<fn(&T)>,
> +);

Wow, it can be wrapped like this!

> +}
> +
> +/// A safe wrapper around [`bindings::MemoryRegion`].  Compared to the
> +/// underlying C struct it is marked as pinned because the QOM tree
> +/// contains a pointer to it.
> +pub struct MemoryRegion {
> +    inner: bindings::MemoryRegion,
> +    _pin: PhantomPinned,
> +}
> +
> +impl MemoryRegion {
> +    // inline to ensure that it is not included in tests, which only
> +    // link to hwcore and qom.  FIXME: inlining is actually the opposite
> +    // of what we want, since this is the type-erased version of the
> +    // init_io function below.  Look into splitting the qemu_api crate.

Ah, I didn't understand the issue described in this comment. Why would
inlining affect the linking of tests?

> +    #[inline(always)]
> +    unsafe fn do_init_io(
> +        slot: *mut bindings::MemoryRegion,
> +        owner: *mut Object,
> +        ops: &'static bindings::MemoryRegionOps,
> +        name: &'static str,
> +        size: u64,
> +    ) {
> +        unsafe {
> +            let cstr = CString::new(name).unwrap();
> +            memory_region_init_io(
> +                slot,
> +                owner.cast::<Object>(),
> +                ops,
> +                owner.cast::<c_void>(),
> +                cstr.as_ptr(),
> +                size,
> +            );
> +        }
> +    }
> +
> +    pub fn init_io<T: IsA<Object>>(
> +        &mut self,
> +        owner: *mut T,
> +        ops: &'static MemoryRegionOps<T>,
> +        name: &'static str,

What about &'static CStr?

Then pl011 could pass `c_str!("pl011")` or `Self::TYPE_NAMSelf::TYPE_NAME`.

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



