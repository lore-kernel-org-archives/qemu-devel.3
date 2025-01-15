Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB792C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxEe-0003te-39; Wed, 15 Jan 2025 01:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXxEZ-0003tC-Pk; Wed, 15 Jan 2025 01:50:36 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXxES-0001AM-Nm; Wed, 15 Jan 2025 01:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736923829; x=1768459829;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=w1W6rlQfcGyzJJxG5ZQpv6yqnDxH0DbXb3AANEBszhQ=;
 b=AvX5e8LmjmvaucHBIVC/P3UOQQSqCbhovgNjzUF9NY7yEOY4/FskkP/0
 RkeIYonYLY/9/IKsci0yKb/HMo8bfePj1gA6BmdFbibEV2z5xtfO30WKN
 MRewRb6uc8ftGWTjAI8/ff17p4AQmicJlcTsbkKDpMe+A5sFLRbI+GU5V
 TysvV1nOkJzRurQUDnLimtxobFKaF8psXsHxk2KOjqQYHr273fI3X2mgR
 6ErUdyUyT4QuamiY689beRSCGhZhh0PrLSaYe/p9d8foJAAEJjZ2E5e02
 jyapCAlXRAJz02CSPgMkLq+1xf0PgeDr9i8hixXq5GbIyzxgHimiMDW4Z A==;
X-CSE-ConnectionGUID: HtGBxQPqTauKc6Ge/ilkSw==
X-CSE-MsgGUID: yaloiS38Q2STZikA9LY/bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40925512"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; d="scan'208";a="40925512"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 22:50:25 -0800
X-CSE-ConnectionGUID: y6vRTzulR7q3LLL2IqdOzQ==
X-CSE-MsgGUID: eVEVxukNQ4++drC6garH0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="135901500"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 Jan 2025 22:50:22 -0800
Date: Wed, 15 Jan 2025 15:09:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 07/13] rust: add bindings for timer
Message-ID: <Z4dfGcf1SbXaNSEM@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-8-zhao1.liu@intel.com>
 <9cb123e2-5237-46e7-b6fe-ce8f813cc43c@redhat.com>
 <Z4aEkLhcGVbXX82O@intel.com>
 <CABgObfYRAYPBidb+cUPCrtdAEXGZiSG2hf5CvJskXmTpR1ftpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYRAYPBidb+cUPCrtdAEXGZiSG2hf5CvJskXmTpR1ftpQ@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.794,
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

On Tue, Jan 14, 2025 at 05:14:48PM +0100, Paolo Bonzini wrote:
> Date: Tue, 14 Jan 2025 17:14:48 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 07/13] rust: add bindings for timer
> 
> On Tue, Jan 14, 2025 at 4:18 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > ...Now I have a draft for timer binding:
> >
> > * timer binding:
> >
> > impl QEMUTimer {
> >     pub fn new() -> Self {
> >         Zeroable::ZERO
> >     }
> 
> Maybe Default too (not sure if you even need new())?

Yes, I find bindgen has already implemented Default for QEMUTimer:

#[repr(C)]
#[derive(Debug)]
pub struct QEMUTimer {
    pub expire_time: i64,
    pub timer_list: *mut QEMUTimerList,
    pub cb: QEMUTimerCB,
    pub opaque: *mut std::os::raw::c_void,
    pub next: *mut QEMUTimer,
    pub attributes: std::os::raw::c_int,
    pub scale: std::os::raw::c_int,
}

impl Default for QEMUTimer {
    fn default() -> Self {
        let mut s = ::std::mem::MaybeUninit::<Self>::uninit();
        unsafe {
            ::std::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
            s.assume_init()
        }
    }
}

HPETTimer just has a pointer to a QEMUTimer, so I need the new() in
init_timer_with_state() to create QEMUTimer within a Box<>. I'll use
Default instead in new().

> >     pub fn timer_init_full<'a, 'b: 'a, T, F>(
> 
> It's better to use longer names like 'timer and 'opaque. But it's also
> always possible to pass a longer lifetime, so 'opaque: 'timer is
> strictly speaking not needed: you can just use &'timer T which in turn
> means that lifetime elision applies. That said, I think I like the
> idea of using 'timer and 'opaque lifetimes here, for clarity.

Thanks, I'll change the lifetime names.

> >         &'a mut self,
> >         timer_list_group: Option<&mut QEMUTimerListGroup>,
> 
> I think QEMUTimerListGroup can (should) be shared because it's thread safe.

I understand here I can pass the immutable reference like (and that's
the updated timer_init_full()):

    pub fn timer_init_full<'timer, 'opaque: 'timer, T, F>(
        &'timer mut self,
        timer_list_group: Option<&QEMUTimerListGroup>,
        clk_type: QEMUClockType,
        scale: u32,
        attributes: u32,
        _f: F,
        opaque: &'opaque T,
    ) where
        F: for<'a> FnCall<(&'a T,)>,
    {
        let timer_cb: unsafe extern "C" fn(*mut c_void) = rust_timer_handler::<T, F>;

        // SAFETY: the opaque outlives the timer
        unsafe {
            timer_init_full(
                self,
                if let Some(g) = timer_list_group {
                    g as *const QEMUTimerListGroup as *mut QEMUTimerListGroup
                } else {
                    ::core::ptr::null_mut()
                },
                clk_type,
                scale as c_int,
                attributes as c_int,
                Some(timer_cb),
                opaque as *const T as *const c_void as *mut c_void,
            )
        }
    }

> >         clk_type: QEMUClockType,
> >         scale: u32,
> >         attributes: u32,
> >         _f: &F,
> 
> Better: "_f: &'static F", or even "_f: F" if it works.

"_f: F" can work since I passed a function reference (&cb, not a
function pointer).

With "_f: F", passing timer_handler directly is better.

> >         opaque: &'b T,
> >     ) where
> >         F: for<'c> FnCall<(&'c T,)> + 'b,
> 
> 'b ('opaque) is not needed here because the opaque is passed _into_
> the function (thus its lifetime is 'c). 'timer would make sense, but
> in fact the function itself is always 'static (see FnCall declaration)
> so it is unnecessary to add a lifetime to FnCall.

I see! Thank you for clarification.

> > fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
> >     timer_cell.borrow_mut().callback()
> > }
> >
> > impl HPETTimer {
> >     ...
> >
> >     fn init_timer_with_state(&mut self) {
> >         let index = self.index;
> >         let cb = |cell: &BqlRefCell<HPETTimer>| {
> >             timer_handler(cell);
> >         };
> 
> Why is the anonymous function needed?  Can you just pass "timer_handler"?

Yes, I should clean up this closure...

> > Is this timer binding as you expected? Hope I am on the right track. :-)
> 
> If the only correction is to the function declaration, that's as good
> as it can be for Rust! ;)
> 

Thank you! Now I have a updated timer_init_full() (like I pasted above).

Regards,
Zhao


