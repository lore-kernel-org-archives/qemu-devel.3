Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC99C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOBq-000298-TI; Fri, 07 Feb 2025 08:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgOBm-00028G-I1; Fri, 07 Feb 2025 08:14:35 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgOBh-0000xJ-HQ; Fri, 07 Feb 2025 08:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738934070; x=1770470070;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oa5egkzz6wHMDqFUbjxrfEjYAs/qKVk2eEFoeXYlyNI=;
 b=dmPYr3WZOJP54eBt5tLlyoL8xPTQ99IuabYSILiGYlUmrT8sG2DvyXxI
 cTjYb5zIKIXl9qqu9hRncMxw+KoWY7NI3bJYaW7qq5rLXpCZ3/OZxT72f
 9QM1WoW5Vi9vqlo18nu7FVmW47ybGGD7nJF3Mu0qxlP++U0zhQYKgGjr+
 35gDl+0lsOH/qUUUJq6/fUS5gP0c63X+dje3juDUuMX2Rb/UcUSZs2y7B
 LxpvqgsZNJoPgXE/H6nEjpOICRNmevrfN5R53OL2FQTI1ls56Ap0XHleL
 pppTH7TeZrqEcEzg5Em0MLLYJcLqNe06ZuxgQx8iOgnQA4VKDe6Ce0xX6 w==;
X-CSE-ConnectionGUID: 4wvwRyQjSzC4hyW6szv81w==
X-CSE-MsgGUID: d5SiKoDISgCcVH6X2Go8Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39266364"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="39266364"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 05:14:26 -0800
X-CSE-ConnectionGUID: W7sB86+dQdCYr9YYBuXP/w==
X-CSE-MsgGUID: kmh0h/17RRG2vC+S6i74Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112417933"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 07 Feb 2025 05:14:23 -0800
Date: Fri, 7 Feb 2025 21:33:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/10] rust: add bindings for timer
Message-ID: <Z6YLwAqDGm+9aiaM@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-7-zhao1.liu@intel.com>
 <a30bfa1c-ddb8-4a5b-9f95-7b000c11cd54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30bfa1c-ddb8-4a5b-9f95-7b000c11cd54@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> > +pub use bindings::QEMUTimer;
> > +
> > +use crate::{
> > +    bindings::{
> > +        self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
> > +        QEMUTimerListGroup,
> > +    },
> > +    callbacks::FnCall,
> > +};
> > +
> > +impl QEMUTimer {
> > +    pub fn new() -> Self {
> > +        Default::default()
> > +    }
> > +
> > +    pub fn timer_init_full<'timer, 'opaque: 'timer, T, F>(
> 
> General question - should the names:
> 
> - include the "timer" part, matching QEMU C code, or exclude it to avoid
> repetition? I would say remove it, 

I agree and I would name it "init()" instead of "init_full()".

> but I'm open to suggestions and other
> opinions
>
> - include the "QEMU" part? I'd say remove it, similar to ClockType below
> that is:
> 
> -pub use bindings::QEMUTimer;
> +pub use bindings::QEMUTimer as Timer;
> +pub use bindings::QEMUTimerList as TimerList;
> +pub use bindings::QEMUTimerListGroup as TimerListGroup;

I notice you've picked another way for IRQState, so I could follow that
like:

pub type Timer = bindings::QEMUTimer;

This style make it easy to add doc (timer binding currently lacks
doc, but I will add it as much as possible).

Another option may be to wrap QEMUTimer as what MemoryRegionOps did, but
timer has only 1 callback so I think it's not necessary.

> > +        &'timer mut self,
> > +        timer_list_group: Option<&QEMUTimerListGroup>,
> > +        clk_type: QEMUClockType,
> 
> Please take a ClockType instead.

Sure.

> > +        scale: u32,
> > +        attributes: u32,
> > +        _f: F,
> > +        opaque: &'opaque T,
> > +    ) where
> > +        F: for<'a> FnCall<(&'a T,)>,
> > +    {
> > +        /// timer expiration callback
> > +        unsafe extern "C" fn rust_timer_handler<T, F: for<'a> FnCall<(&'a T,)>>(
> > +            opaque: *mut c_void,
> > +        ) {
> > +            // SAFETY: the opaque was passed as a reference to `T`.
> > +            F::call((unsafe { &*(opaque.cast::<T>()) },))
> > +        }
> 
> Please add "let _: () = F::ASSERT_IS_SOME;", which is added by the
> qdev_init_clock_in() patch.

Sure. Added it to the beginning of this function.

> > +        let timer_cb: unsafe extern "C" fn(*mut c_void) = rust_timer_handler::<T, F>;
> > +
> > +        // SAFETY: the opaque outlives the timer
> > +        unsafe {
> > +            timer_init_full(
> > +                self,
> > +                if let Some(g) = timer_list_group {
> > +                    g as *const QEMUTimerListGroup as *mut QEMUTimerListGroup
> > +                } else {
> > +                    ::core::ptr::null_mut()
> > +                },
> > +                clk_type,
> > +                scale as c_int,
> > +                attributes as c_int,
> > +                Some(timer_cb),
> > +                (opaque as *const T).cast::<c_void>() as *mut c_void,
> > +            )
> > +        }
> > +    }
> > +
> > +    pub fn timer_mod(&mut self, expire_time: u64) {
> > +        unsafe { timer_mod(self as *mut QEMUTimer, expire_time as i64) }
> > +    }
> 
> This can take &self, because timers are thread-safe:
> 
>     pub fn timer_mod(&self, expire_time: u64) {
>         unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
>     }

timer_mod means "modify a timer", so I'd rename this method to "modify"

>     const fn as_mut_ptr(&self) -> *mut Self {
>         self as *const QEMUTimer as *mut _
>     }

Thanks!

> > +}
> > +
> > +impl Drop for QEMUTimer {
> > +    fn drop(&mut self) {
> > +        unsafe { timer_del(self as *mut QEMUTimer) }
> > +    }
> 
> timer_del() can be useful even outside Drop, so
> 
>     pub fn timer_del(&self) {
>         unsafe { timer_del(self.as_mut_ptr()) }
>     }
> 
> and just use self.timer_del() here.

OK, will also rename "timer_del" to "delete".

> > +}
> > +
> > +pub fn qemu_clock_get_virtual_ns() -> u64 {
> > +    // SAFETY:
> > +    // Valid parameter.
> > +    (unsafe { qemu_clock_get_ns(QEMUClockType::QEMU_CLOCK_VIRTUAL) }) as u64
> > +}
> 
> Not needed.

Yes!

> > +pub struct ClockType {
> > +    pub id: QEMUClockType,
> > +}
> 
> The field does not have to be "pub" (maybe "pub(self)", I'm not sure
> offhand).
> 

You're right! Making it private is enough, since I should also make
timer_init_full accept ClockType instead of QEMUClockType.

Thanks,
Zhao



