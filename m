Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E71CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 15:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXilK-0005kL-2O; Tue, 14 Jan 2025 10:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXilH-0005jk-LW; Tue, 14 Jan 2025 10:23:23 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXilF-0002jT-TB; Tue, 14 Jan 2025 10:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736868201; x=1768404201;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3yJHop55XQ39mq3ghQytuM6d87sG6SZyRTsPiM1tEas=;
 b=G0pKhi5OpHvs14/l3ptdsnlb4SQszCzZR7pawuxnzNjv6iVlJcp21ooA
 JJ6LG/esZ6CgY++msZTILnw6w1o0zDa2LJuj4xMCwqZDpP9T4AobnEGeu
 wr0N5ipN+NTSRyieZh3rwxGh0VpoXsfjFh+SskxcuslAyAs7brLiheb9W
 CtCEGw83SQWc83WBo+jhZL4CaXY4xmdDPeSdmBBvilXEKVuxaK3eH5aEx
 iXbrL8T5ssz3koH0FNOT+fr7v0u8BM2s3BvMBJHcR5T37572oGE8EDb0g
 uEazrQqJOrqBiLgqyAUF4u8QBoLsrbjbVfT9kRtigmUqKXPHhQOFWcv7O Q==;
X-CSE-ConnectionGUID: dyqThTONTv2RU6VZOdzPIQ==
X-CSE-MsgGUID: U6Z1xukdTuioWEBzSRqmDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37397992"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="37397992"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 07:23:18 -0800
X-CSE-ConnectionGUID: PPrXyPwVSaiwJ3acH8b9LA==
X-CSE-MsgGUID: W7KxnblOS/28YYtpxnnvNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="128082253"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 07:23:16 -0800
Date: Tue, 14 Jan 2025 23:42:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 07/13] rust: add bindings for timer
Message-ID: <Z4aFz5uWJt/6woxy@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-8-zhao1.liu@intel.com>
 <9cb123e2-5237-46e7-b6fe-ce8f813cc43c@redhat.com>
 <Z4aEkLhcGVbXX82O@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4aEkLhcGVbXX82O@intel.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

On Tue, Jan 14, 2025 at 11:36:48PM +0800, Zhao Liu wrote:
> Date: Tue, 14 Jan 2025 23:36:48 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [RFC 07/13] rust: add bindings for timer
> 
> Hi Paolo,
> 
> Thanks for your FnCall and the guidance below...
> 
> > This gets tricky when you have more than one timer per device.  With the right
> > infrastructure we can make this something like
> > 
> >     fn timer_init_full<'a, 'b: 'a, T, F: 'b Fn(&'b T)>(
> >         &'a mut self,
> >         timer_list_group: Option<&mut QEMUTimerListGroup>,
> >         clk_type: QEMUClockType,
> >         scale: u32,
> >         attributes: u32,
> >         f: &F,
> >         opaque: &'b T) {
> >         // SAFETY: the opaque outlives the timer
> >         unsafe {
> >             timer_init_full(...)
> >         }
> >     }
> 
> ...
> 
> > pub struct Clock {
> >     id: QEMUClockType
> > }
> > 
> > impl Clock {
> >     pub fn get_ns() -> u64 {
> >         // SAFETY: cannot be created outside this module, therefore id
> >         // is valid
> >         (unsafe { qemu_clock_get_ns(self.id) }) as u64
> >     }
> > }
> > 
> > pub static CLOCK_VIRTUAL: Clock = Clock { id: QEMUClockType::QEMU_CLOCK_VIRTUAL };
> > // etc.
> > 
> > and then the user can do timer::CLOCK_VIRTUAL::get_ns().
> >
> 
> ...Now I have a draft for timer binding:
> 
> * timer binding:

Missed rust_timer_handler, which follows the good example of FnCall doc:

unsafe extern "C" fn rust_timer_handler<T, F: for<'a> FnCall<(&'a T,)>>(opaque: *mut c_void) {
    // SAFETY: the opaque was passed as a reference to `T`.
    F::call((unsafe { &*(opaque.cast::<T>()) },))
}

 
> impl QEMUTimer {
>     pub fn new() -> Self {
>         Zeroable::ZERO
>     }
> 
>     pub fn timer_init_full<'a, 'b: 'a, T, F>(
>         &'a mut self,
>         timer_list_group: Option<&mut QEMUTimerListGroup>,
>         clk_type: QEMUClockType,
>         scale: u32,
>         attributes: u32,
>         _f: &F,
>         opaque: &'b T,
>     ) where
>         F: for<'c> FnCall<(&'c T,)> + 'b,
>     {
>         let timer_cb: unsafe extern "C" fn(*mut c_void) = rust_timer_handler::<T, F>;
> 
>         // SAFETY: the opaque outlives the timer
>         unsafe {
>             timer_init_full(
>                 self,
>                 if let Some(g) = timer_list_group {
>                     g
>                 } else {
>                     ::core::ptr::null_mut()
>                 },
>                 clk_type,
>                 scale as c_int,
>                 attributes as c_int,
>                 Some(timer_cb),
>                 opaque as *const T as *const c_void as *mut c_void,
>             )
>         }
>     }
> 
>     pub fn timer_mod(&mut self, expire_time: u64) {
>         unsafe { timer_mod(self as *mut QEMUTimer, expire_time as i64) }
>     }
> }
> 
> 
> * use of timer binding:
> 
> fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
>     timer_cell.borrow_mut().callback()
> }
> 
> impl HPETTimer {
>     ...
> 
>     fn init_timer_with_state(&mut self) {
>         let index = self.index;
>         let cb = |cell: &BqlRefCell<HPETTimer>| {
>             timer_handler(cell);
>         };
> 
>         self.qemu_timer = Some(Box::new({
>             let mut t = QEMUTimer::new();
>             t.timer_init_full(
>                 None,
>                 CLOCK_VIRTUAL.id,
>                 SCALE_NS,
>                 0,
>                 &cb,
>                 &self.get_state().timer[index],
>             );
>             t
>         }));
>     }
>     ...
> }
> 
> ---
> 
> Is this timer binding as you expected? Hope I am on the right track. :-)
> 
> Thanks,
> Zhao
> 
> 
> 

