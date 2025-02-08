Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7A6C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 10:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgiCP-0007S9-Ib; Sat, 08 Feb 2025 05:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiCN-0007Rc-Rt; Sat, 08 Feb 2025 05:36:31 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiCK-0003TO-Fb; Sat, 08 Feb 2025 05:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739010989; x=1770546989;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0JTr5C7lCU/zR2Yl75EYqnRVv2KwKeWBGdVg0HXEuF0=;
 b=KAuxxhQxXN1g9umticgb3ZJAewE/MJf+lj+12U3ik5PpAEgjROmLemoI
 kD8AWIGy3soema5bcwxswwR1jFubPQfFfjuLSR+Enig1UXDvHkEz8qVd1
 8tpqDOdxt3VE6+A5TwiVK3us07Y/GfprA6bilGXSr4wNHmMXyb4upmyMd
 bOZ30FzLian2SRzFIcxak6yFPkFWr+pmM/dZgrssPWs1wi0m3yfYM56aP
 eHkP0hkPEFmgWa7jr/3ZlMbcIZwtahVF02pm7735ngVkbHIbxBMJjTLpf
 Be/2dsvplBYBGLeSD77AEQ83Cg5IC5q0OdfmylUD6VxgFIsRhsAjCzsIA w==;
X-CSE-ConnectionGUID: s9KNjlqhTBKUwiJpKrjp8A==
X-CSE-MsgGUID: DtCW/yHPQrC8ugObvBd2ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50632344"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="50632344"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2025 02:36:23 -0800
X-CSE-ConnectionGUID: licO+vvqQASptpgi8CirBg==
X-CSE-MsgGUID: Cwmlper6Q86A36ZnH0ksfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="112264621"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 08 Feb 2025 02:36:19 -0800
Date: Sat, 8 Feb 2025 18:55:49 +0800
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
Subject: Re: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs support
Message-ID: <Z6c4NVX4wteIEIOA@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-10-zhao1.liu@intel.com>
 <750f06f3-6326-473f-9d08-ad6bb1f2a54a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <750f06f3-6326-473f-9d08-ad6bb1f2a54a@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 29, 2025 at 11:58:14AM +0100, Paolo Bonzini wrote:
> Date: Wed, 29 Jan 2025 11:58:14 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs support
> 
> 
> 
> On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >      fn read(&mut self, addr: hwaddr, _size: u32) -> u64 {
> 
> This can be &self.

Done.

> >          let shift: u64 = (addr & 4) * 8;
> > 
> > +        match addr {
> > +            HPET_TN_CFG_REG => self.config >> shift, // including interrupt capabilities
> 
> This needs to be "match addr & !4".

I understand it's not necessary:

In timer_and_addr(), I've masked the address with 0x18. 

    fn timer_and_addr(&self, addr: hwaddr) -> Option<(&BqlRefCell<HPETTimer>, hwaddr)> {
        let timer_id: usize = ((addr - 0x100) / 0x20) as usize;

        if timer_id > self.num_timers.get() {
            None
        } else {
            Some((&self.timers[timer_id], addr & 0x18))
        }
    }

And in HPETState::read(), I pass the masked address to
HPETTimer::read():

    fn read(&self, addr: hwaddr, size: u32) -> u64 {
        let shift: u64 = (addr & 4) * 8;

        if (0x100..=0x3ff).contains(&addr) {
            match self.timer_and_addr(addr) {
                None => 0, // Reserved,
                Some((timer, addr)) => timer.borrow_mut().read(addr, size),
            }
        }

Ah, the `addr` variable in Some() is misleading, and I should use
anothor name like `tn_addr`.

0x18 is a subset of !0x4, so the bitwise & operation with !0x4 can be
omitted (I understand that this is why you also omitted this in the C
side in the commit c2366567378dd :-) ).

But `match addr & !4` is also reasonable, which explicitly emphasize
`& !4` makes the code clearer. I would do this.

> > +            HPET_TN_CMP_REG => self.cmp >> shift,    // comparator register
> > +            HPET_TN_FSB_ROUTE_REG => self.fsb >> shift,
> > +            _ => {
> > +                // TODO: Add trace point - trace_hpet_ram_read_invalid()
> > +                // Reserved.
> > +                0
> > +            }
> > +        }
> > +    }
> > +
> > +    fn write(&mut self, addr: hwaddr, value: u64, size: u32) {
> > +        let shift = ((addr & 4) * 8) as u32;
> > +        let len = std::cmp::min(size * 8, 64 - shift);
> > +
> > +        match addr {
> > +            HPET_TN_CFG_REG => self.set_tn_cfg_reg(shift, len, value),
> 
> Likewise.

Done. Thanks!

> > +    fn write(&self, addr: hwaddr, value: u64, size: u32) {
> > +        let shift = ((addr & 4) * 8) as u32;
> > +        let len = std::cmp::min(size * 8, 64 - shift);
> > +
> > +        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
> > +        if (0x100..=0x3ff).contains(&addr
> ) {
> > +            match self.timer_and_addr(addr) {
> > +                None => return, // Reserved.
> 
> Clippy complains about an unnecessary return, just replace it with "()".

Fixed.

> > +                Some((timer, addr)) => timer.borrow_mut().write(addr, value, size),
> > +            }
> 
> > +
> > +    fn reset_hold(&self, _type: ResetType) {
> > +        let sbd = self.upcast::<SysBusDevice>();
> > +
> > +        for timer in self.timers.iter().take(self.num_timers.get()) {
> > +            timer.borrow_mut().reset();
> > +        }
> > +
> > +        self.counter.set(0);
> > +        self.config.set(0);
> > +        self.pit_enabled.set(true);
> > +        self.hpet_offset.set(0);
> > +
> > +        HPETFwConfig::update_hpet_cfg(
> > +            self.hpet_id.get(),
> > +            Some(self.capability.get() as u32),
> > +            Some((*sbd).mmio[0].addr),
> > +        );
> 
> This can be simply sbd.mmio[0].addr, without the (*...).
> 
> Also, you can change update_hpet_cfg to take arguments without the Option<>
> around them.

Good idea! Done.

> > +// TODO: add OBJECT_DECLARE_SIMPLE_TYPE.
> > +#[repr(C)]
> > +pub struct HPETClass {
> > +    parent_class: <SysBusDevice as ObjectType>::Class,
> > +}
> > +
> > +unsafe impl ObjectType for HPETState {
> > +    type Class = HPETClass;
> > +    const TYPE_NAME: &'static CStr = crate::TYPE_HPET;
> > +}
> 
> No need for HPETClass (and for ClassInitImpl<HPETClass>), just do
> 
> unsafe impl ObjectType for HPETState {

Pls let me add a comment here:

// No need for HPETClass. Just like OBJECT_DECLARE_SIMPLE_TYPE in C.

Then this can be "grep", as a reference.

>     type Class = <SysBusDevice as ObjectType>::Class;
>      const TYPE_NAME: &'static CStr = crate::TYPE_HPET;
> }
> 
> which is indeed more similar to OBJECT_DECLARE_SIMPLE_TYPE().

Awesome! Thanks.

Regards,
Zhao


