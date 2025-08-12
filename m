Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1773CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 10:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullx6-0006qp-Cj; Tue, 12 Aug 2025 06:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ullx3-0006ph-Kp; Tue, 12 Aug 2025 06:09:53 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ullwv-0006jM-Vj; Tue, 12 Aug 2025 06:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754993386; x=1786529386;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Vw+FHGD2q2/KmePx1+TKPwDLeoLgmtH00nur/P1aXlQ=;
 b=m4O0JHgfW3/nAiMN7ZA5JC8kJkEAYn81kxkN4jtqkO4Q4zEifAhjoHYQ
 zQvuvFi5fMNhRgfq93EwCYM+LUh5v42M7YyZc/WyFnm7FqRqefRKlkJU4
 xxH7PFMI8bT0/kEthpp8XNbT9E+NSxU9mVoFy8ZCW/bPBy0HQ/uewLIXm
 Xskdr7xnLaiV0u9zZggA4RKfIW5gtH7cOdUMPqDdY7iv1IrJlHN4isPCk
 4edEBXkHwsFgoJWGrsY204XMnPv+cumzk6ozzUiOp5z57qU617B6cgf7h
 ovkiVV8HHBDGQ7zm/Y4SbY43w6O22m2YuQl4aHHiCqV0eyvNDA9K5UOfK w==;
X-CSE-ConnectionGUID: 1KsGYHRZRKG3HSJAnWsqxw==
X-CSE-MsgGUID: SpOp+gwEQi+iCJd4IPTnLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68334078"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="68334078"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 03:09:39 -0700
X-CSE-ConnectionGUID: 0POCVWucRHGjpL70arIjaA==
X-CSE-MsgGUID: FHEv73oZRAiVnlzCQFwpjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="166162280"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 12 Aug 2025 03:09:36 -0700
Date: Tue, 12 Aug 2025 18:31:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 13/26] rust: Add RCU bindings
Message-ID: <aJsX9HH/JwblZEYO@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-14-zhao1.liu@intel.com>
 <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
 <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 07, 2025 at 03:38:52PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:38:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 13/26] rust: Add RCU bindings
> 
> On 8/7/25 14:29, Manos Pitsidianakis wrote:
> 
> > > +//! Bindings for `rcu_read_lock` and `rcu_read_unlock`.
> > > +//! More details about RCU in QEMU, please refer docs/devel/rcu.rst.
> > > +
> > 
> > How about a RAII guard type? e.g. RCUGuard and runs `rcu_read_unlock` on Drop.
> 
> Clippy says Rcu not RCU.  :)
> 
> You're right, not just because it's nice but also because it bounds the
> dereference of the FlatView.  Something like this build on top of the guard
> object:
> 
> pub struct RcuCell<T> {
>     data: AtomicPtr<T>
> }
> 
> impl<T> RcuCell {
>     pub fn raw_get(&self) -> *mut T {
>         self.data.load(Ordering::Acquire)
>     }
> 
>     pub fn get<'g>(&self, _: &'g RcuGuard) -> Option<&'g T> {
>         unsafe {
>             self.raw_get().as_ref()
>         }
>     }
> }

I just implement a simple RcuGuard (but this doesn't consider the refer
count or flag. I would like to talk more about this at the last of this
reply.):

pub struct RcuGuard;

impl RcuGuard {
    pub fn new() -> Self {
        unsafe { bindings::rcu_read_lock() };
        Self
    }
}

impl Drop for RcuGuard {
    fn drop(&mut self) {
        unsafe { bindings::rcu_read_unlock() };
    }
}

> Using this is a bit ugly, because you need transmute, but it's isolated:
> 
> impl AddressSpace {
>    pub fn get_flatview(&self, rcu: &'g Guard) -> &'g FlatView {
>        let flatp = unsafe {
>            std::mem::transmute::<&*mut FlatView, &RcuCell<FlatView>>(
>                &self.0.as_ptr().current_map)
>        };
>        flatp.get(rcu)
>    }
> }
>
> impl GuestAddressSpace for AddressSpace {
>     fn memory(&self) -> Self::T {
>         let rcu = RcuGuard::guard();
>         FlatViewRefGuard::new(self.get_flatview(rcu))
>     }
> }

Why not use a constructor RcuCell::new() to replace transmute()? Then
we just need to play with the pointer without touching memory.

impl<T> RcuCell<T> {
    pub fn new(p: *mut T) -> Self {
        Self {
            data: AtomicPtr::new(p),
        }
    }
}

Then we could :

impl Deref for AddressSpace {
    type Target = bindings::AddressSpace;

    fn deref(&self) -> &Self::Target {
        unsafe { &*self.0.as_ptr() }
    }
}

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

> > Destructors are not guaranteed to run or run only once, but the former
> > should happen when things go wrong e.g. crashes/aborts. You can add a
> > flag in the RCUGuard to make sure Drop runs unlock only once (since it
> > takes &mut and not ownership)
> 
> Yeah I think many things would go wrong if Arc could run its drop
> implementation more than once.

wait, isn't RCU be held at thread-local case? We shouldn't share RCU
guard/cell at Arc<>. Furthermore, it seems necessary to introduce
`NotThreadSafe` into QEMU from kernel.

pub type NotThreadSafe = PhantomData<*mut ()>;

Then we could have stronger restrictions on RCU stuff, just like
kernel'rcu:

pub struct RcuGuard(NotThreadSafe);

Maybe we can also add `NotThreadSafe` to RcuCell. But the lifetime has
already restrict its use.

For another consideration about "guaranteeing to run" (for crashes/aborts
case), QEMU program will stop and OS will clean every thing up. Then we
don't need to care about the state of RCU, right?

Thanks,
Zhao


