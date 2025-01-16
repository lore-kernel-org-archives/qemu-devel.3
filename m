Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A83C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 02:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYFtK-0003YL-9e; Wed, 15 Jan 2025 21:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYFtJ-0003Y7-7p; Wed, 15 Jan 2025 21:45:53 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYFtG-0001pm-Js; Wed, 15 Jan 2025 21:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736995550; x=1768531550;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/MEp7Ja/ZIQvM3D5ev3oVp39/DU7F9jwhT+6+q/m/aQ=;
 b=bB3cGaHCSDmJQOSHrJvxXlWmcNoDvcryUDbc6dfpzQBc0lvAo1LOe3mb
 oo0LFR+d0PgQE2GEPhQpcOT0LAZIm3YXj48HvOLSdh1Mb/atSITp7pRhq
 /5axqg0XVYJ0alFHaHdtzXdCBqxZLUXW2L9Xj5OKZe6PHJhotLSuGnnpF
 QmIQ2icSbmLBJvVHYpauhHgZHAxCsHvEXJVPbP2mW9lg+xWiG4HizF4jE
 i+oKbsySr9fjz/K8fmiJ0ubrrji+cXqZrlp4FkeEiYk/aztXR1xWdCyZ+
 VUVYSI5utJW0ktDJEuMAmeQ9VWHgh5Jm4Bmh/b0k1fLSh0A81L+yh5PnX A==;
X-CSE-ConnectionGUID: SbLngo7hQsiwt1C7GqrtWg==
X-CSE-MsgGUID: AAtBQYmhR1u9mLYS3eU5Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="24957923"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="24957923"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 18:45:46 -0800
X-CSE-ConnectionGUID: Ak9i/FK0QB6+jUT1sgdaNw==
X-CSE-MsgGUID: rOJeAuYeQ9OpsNaWGnVR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="105151986"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 15 Jan 2025 18:45:44 -0800
Date: Thu, 16 Jan 2025 11:04:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 04/13] rust: add bindings for gpio_{in|out} initialization
Message-ID: <Z4h3Q/JBxtWxi+bK@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-5-zhao1.liu@intel.com>
 <6108dfe6-f629-431c-be91-51abff338e85@redhat.com>
 <Z1XJBJp+l92+OrY9@intel.com>
 <CABgObfaeoLociD5rzptg4Uj4anMonc0M8iP_TK3qa-17FecR2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaeoLociD5rzptg4Uj4anMonc0M8iP_TK3qa-17FecR2A@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

> and the structure of all the blanket implementation is always the same:
> 
> pub trait DeviceClassMethods: IsA<DeviceState> {...}
> impl<T> DeviceClassMethods for T where T: IsA<DeviceState> {}
> 
> pub trait DeviceMethods: ObjectDeref
> where
>     Self::Target: IsA<DeviceState>,
> {...}
> impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
> 
> impl<T> ClassInitImpl<DeviceClass> for T
> where
>     T: ClassInitImpl<ObjectClass> + DeviceImpl
> {...}
> 

Similiar to timer, now I've also worked out the gpio bindings (but one
thing that's different is that it uses `self` as an parameter) like:

* gpio_in and gpio_out:

/// Trait for methods of [`DeviceState`] and its subclasses.
pub trait DeviceMethods: ObjectDeref
where
    Self::Target: IsA<DeviceState>,
{
    fn init_gpio_in<F>(&self, lines_num: u32, _f: F)
    where
        F: for<'a> FnCall<(&'a Self::Target, u32, u32)>,
    {
        unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
            opaque: *mut c_void,
            lines_num: c_int,
            level: c_int,
        ) {
            // SAFETY: the opaque was passed as a reference to `T`
            F::call((
                unsafe { &*(opaque.cast::<T>()) },
                lines_num as u32,
                level as u32,
            ))
        }

        let gpio_in_cb: unsafe extern "C" fn(*mut c_void, c_int, c_int) =
            rust_irq_handler::<Self::Target, F>;

        unsafe {
            qdev_init_gpio_in(
                self.upcast::<DeviceState>() as *const DeviceState as *mut DeviceState,
                Some(gpio_in_cb),
                lines_num as c_int,
            );
        }
    }

    fn init_gpio_out(&self, pins: &[InterruptSource]) {
        assert!(pins.len() > 0);

        unsafe {
            qdev_init_gpio_out(
                self.upcast::<DeviceState>() as *const DeviceState as *mut DeviceState,
                pins[0].as_ptr(),
                pins.len() as c_int,
            );
        }
    }
}

impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}


* Use case in HPET:

impl HPETState {
    ...

    fn handle_legacy_irq(&self, irq: u32, level: u32) {
        if irq == HPET_LEGACY_PIT_INT {
            if !self.is_legacy_mode() {
                self.irqs[0].set(level != 0);
            }
        } else {
            self.rtc_irq_level.set(level as u8);
            if !self.is_legacy_mode() {
                self.irqs[RTC_ISA_IRQ].set(level != 0);
            }
        }
    }

    ...

    fn realize(&self) {
        ...
        self.init_gpio_in(2, HPETState::handle_legacy_irq);
        self.init_gpio_out(from_ref(&self.pit_enabled));
    }
}

---

I made the handler accept the inmuttable reference, but init_gpio_in()
is called in realize(), which now accepts the `&mut self`.

I think init_gpio_in() should be called in realize() so that realize()
needs to become safe in advance (before your plan).

The safe realize() mainly affects pl011, and before you formally
introduce char binding, if you don't mind, I can make this change to
pl011:

-    pub fn realize(&mut self) {
+    pub fn realize(&self) {
         // SAFETY: self.char_backend has the correct size and alignment for a
         // CharBackend object, and its callbacks are of the correct types.
         unsafe {
             qemu_chr_fe_set_handlers(
-                addr_of_mut!(self.char_backend),
+                addr_of!(self.char_backend) as *mut CharBackend,
                 Some(pl011_can_receive),
                 Some(pl011_receive),
                 Some(pl011_event),
                 None,
-                addr_of_mut!(*self).cast::<c_void>(),
+                addr_of!(*self).cast::<c_void>() as *mut c_void,
                 core::ptr::null_mut(),
                 true,
             );

Thanks,
Zhao



