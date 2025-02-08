Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE04C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 08:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgfnW-0001oq-QF; Sat, 08 Feb 2025 03:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgfnU-0001nB-Sk; Sat, 08 Feb 2025 03:02:40 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgfnR-0002vc-VB; Sat, 08 Feb 2025 03:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739001758; x=1770537758;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=PgO8/WqlJ+zgEu78mjjyldEkBb1UJgABH000P/22n3Q=;
 b=TgHmA861RlcbnnCOOJfpbY4KJM/FJIjHVjQxYkfsWYMpXiY2/8D0Tzhv
 Vz0UdMY1UHnhhwOfvRUcMJm1DaPtZRASwkMnvWeUGhP17992ARlYGcrh+
 UyfXUV+ZuWGEtzpnBtCUHLzqxETN8Yacl5wkjFxkQIQ3NwTx1VU8QooB0
 ybzLrqZ5e1Y71wiQWHNgTTJjtBDbN0ZkPiKeZ/y8V5fckPNy58zoRtAF1
 KiSSTaEgvYIE4m7dl4f1Ig0AogvM3Id/7I0Gfb2BOajCBSoTWp8fVLKxQ
 GppCJmnVOAleLX8Nt0FWR8p8FkKd615YAM38eTyT47UxVmIbDlFC1jkQp A==;
X-CSE-ConnectionGUID: xjSaLEoSSYGy9hkyFddQUw==
X-CSE-MsgGUID: jImCDJJ9Rsise3E+0gY12w==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="65002522"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="65002522"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2025 00:01:33 -0800
X-CSE-ConnectionGUID: v8BgjGh9QqqlPwAG+H/FRw==
X-CSE-MsgGUID: s4rTIjvbTMC6AHHK66MMMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="111561563"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 08 Feb 2025 00:00:31 -0800
Date: Sat, 8 Feb 2025 16:19:58 +0800
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
Subject: Re: [PATCH 08/10] rust/timer/hpet: add basic HPET timer and HPETState
Message-ID: <Z6cTrkww4n9lPe2X@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-9-zhao1.liu@intel.com>
 <b9ce64fa-b2b8-4f61-8380-9ec582936b26@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9ce64fa-b2b8-4f61-8380-9ec582936b26@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jan 29, 2025 at 11:57:18AM +0100, Paolo Bonzini wrote:
> Date: Wed, 29 Jan 2025 11:57:18 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 08/10] rust/timer/hpet: add basic HPET timer and
>  HPETState
> 
> 
> 
> On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > +// Register space for each timer block. (HPET_BASE isn't defined here.)
> > +const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
> 
> Use doc comments "///"...

OK,

> > +// Timer N FSB Interrupt Route Register (masked by 0x18)
> > +const HPET_TN_FSB_ROUTE_REG: u64 = 0x010;
> 
> ... all the way to here.

Done.

> > +/// HPET Timer Abstraction
> > +#[repr(C)]
> > +#[derive(Debug, Default, qemu_api_macros::offsets)]
> > +pub struct HPETTimer {
> > +    /// timer N index within the timer block (HPETState)
> > +    #[doc(alias = "tn")]
> > +    index: usize,
> > +    qemu_timer: Option<Box<QEMUTimer>>,
> > +    /// timer block abstraction containing this timer
> > +    state: Option<NonNull<HPETState>>,
> > +
> > +    /// Memory-mapped, software visible timer registers
> 
> These "headings" cannot be doc comments, because they would be attached
> to the field after.  Same below:
> 
> -    /// Hidden register state
> +    // Hidden register state
> 
> -    /// HPET block Registers: Memory-mapped, software visible registers
> +    // HPET block Registers: Memory-mapped, software visible registers
> 
> -    /// Internal state
> +    // Internal state

Fixed. Thanks!

> > +    fn get_state(&self) -> &HPETState {
> > +        // SAFETY:
> > +        // the pointer is convertible to a reference
> > +        unsafe { self.state.unwrap().as_ref() }
> > +    }
> 
> Note for the future: I looked briefly into why a NonNull<> is needed
> and the reasons are two.  First, the offset_of! replacement does not
> support lifetime parameters.  Second, it's messy to pass a &HPETState
> to the &HPETTimer, because the HPETTimer still has to be written into
> the HPETState.

Yes, and the second use would be a common case in practice. So maybe we
need some wrapper on this, to provide someting like HPETTimer::get_state(),
which returns a reference of the parent structure.

In addition, for underlying library, NonNull<> is nice thinks to its low
overhead. But for device implementation, I'm not sure if it's the good
choice. Rust uses RefCell<Weak<>> (for QEMU, it could be BqlRefCell<Weak<>>)
to handle this cycle reference case.

As I mentioned in RFC,

	The device instance is not created in Rust side, and there's
	only init() method to initialize created device instance. This
	way, it's hard to be compatible with the pattern of creating
	weak references (at least I failed).

To address this issue, the method `from` or `from_raw` seems necessary,
like `Owned::from`, but it's tricky... So I don't have a good idea to
replace NonNull<> yet! 

> This may be worth revisiting when QEMU starts using
> pinned-init is added, but for now is self-contained.
> 
> > +        if let Some(timer) = self.qemu_timer.as_mut() {
> > +            timer.timer_mod(self.last);
> > +        }
> 
> I think this can be just "timer.unwrap().timer_mod(self.last)" (not
> sure if it needs an as_ref() too).
> 

Yes, it needs as_ref(). A direct unwrap() consumes the Some() since
inter type of qemu_timer (Box<Timer>) is non-`Copy`.

Another example is

    fn get_state(&self) -> &HPETState {
        // SAFETY:
        // the pointer is convertible to a reference
        unsafe { self.state.unwrap().as_ref() }
    }

Because the state (Option<NonNull<HPETState>>) has `Copy` so that this
case doesn't need as_ref before unwrap.

Thanks,
Zhao


