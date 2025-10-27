Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1013CCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDH97-0002mS-L1; Mon, 27 Oct 2025 02:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDH94-0002ld-Cv; Mon, 27 Oct 2025 02:55:58 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDH91-0002lb-FH; Mon, 27 Oct 2025 02:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761548155; x=1793084155;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7VBtFJm4gcK5ITJB2nzY5mEtKMbWKAYKFLoNJChgKm8=;
 b=OnDi67MQVEknsvI8cOdSHrvJ6sHSNNm9rWYcLLkNthfanPngKGYIINf5
 ON6rS/7PmOt2x9bAUirUoUkk6+P8/Lq9J92X8l6m3Y2chl//httIoTju2
 man/WacT9iSkNnQVFConnRxrDOmFoM3hF8s3LcVCrSoqYXbQIVBn5npoD
 MSVsFR3SDHW/MCZXsdKoVeeTace9Dr8b9iX4Ii5or4krRq5apuEdAa2cJ
 jDejpsnvKQrAGBsaTqBp7TVi0WameD1CpxeY9V9w0Lky3TnOQKDST8eY7
 H+sq6PC54OGMRtxdb/HaztJa5n3xUFjzaUXcAk2+zhw0Hkyz1+4MSgaDz Q==;
X-CSE-ConnectionGUID: ugOEiGPxTFOBYO7Sij7OUw==
X-CSE-MsgGUID: YpjpTOhGSPu5gjpo5i8JKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63715418"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="63715418"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 23:55:52 -0700
X-CSE-ConnectionGUID: Ftmsx6llRjygD0JA0UCXzQ==
X-CSE-MsgGUID: uRc5dHYQRHintTgLlw/B+A==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 26 Oct 2025 23:55:49 -0700
Date: Mon, 27 Oct 2025 15:17:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: chenmiao <chenmiao@openatom.club>
Cc: pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 qemu-rust@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@openatom.club>
Subject: Re: [RFC 2/5] rust: hw: core: Add rust bindings/funcs for i2c bus
Message-ID: <aP8cp3y6uCa7tsel@intel.com>
References: <20251025123853.63139-3-chenmiao@openatom.club>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251025123853.63139-3-chenmiao@openatom.club>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Sat, Oct 25, 2025 at 12:38:50PM +0000, chenmiao wrote:
> Date: Sat, 25 Oct 2025 12:38:50 +0000
> From: chenmiao <chenmiao@openatom.club>
> Subject: [RFC 2/5] rust: hw: core: Add rust bindings/funcs for i2c bus
> X-Mailer: git-send-email 2.43.0
> 
> We have implemented the I2CBus and I2CSlave infrastructure in Rust by referring
> to the SysBus device model.
> 
> Initially, we assumed that the I2CBus was at the same hierarchical level as the
> PL011 device. Therefore, we followed the implementation paradigm of the PL011
> device as a reference. However, in the end, we discovered that the I2CBus is
> actually at the same level as the SysBus. As a result, we adopted the binding
> implementation paradigm used for SysBus devices. With this adjustment, we
> successfully compiled the code locally.
> 
> During the implementation process, we found that the current two paradigms in
> Rust — bindings and impl — are extremely complex and lack comprehensive
> documentation. There is no clear explanation as to why Bus and Device models
> need to be implemented using different approaches. Furthermore, the
> implementation of Bus and Device following these paradigms still has many
> limitations. At present, at least vmstate is not easily supported.
> 
> Signed-off-by: Chao Liu <chao.liu@openatom.club>
> Signed-off-by: chenmiao <chenmiao@openatom.club>
> ---
>  rust/hw/core/meson.build   |   1 +
>  rust/hw/core/src/i2cbus.rs | 291 +++++++++++++++++++++++++++++++++++++
>  rust/hw/core/src/lib.rs    |   3 +
>  rust/hw/core/wrapper.h     |   1 +
>  4 files changed, 296 insertions(+)
>  create mode 100644 rust/hw/core/src/i2cbus.rs
> 
> diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
> index efcda50..7c44786 100644
> --- a/rust/hw/core/meson.build
> +++ b/rust/hw/core/meson.build
> @@ -52,6 +52,7 @@ _hwcore_rs = static_library(
>        'src/bindings.rs',
>        'src/bus.rs',
>        'src/irq.rs',
> +      'src/i2cbus.rs',
>        'src/qdev.rs',
>        'src/sysbus.rs',
>      ],
> diff --git a/rust/hw/core/src/i2cbus.rs b/rust/hw/core/src/i2cbus.rs
> new file mode 100644
> index 0000000..c026955
> --- /dev/null
> +++ b/rust/hw/core/src/i2cbus.rs

This file implements both I2CBus and I2C device (Slave).

To be general, I think it's better to name it as "i2c.rs".

> @@ -0,0 +1,291 @@
> +// Copyright 2025 HUST OpenAtom Open Source Club.
> +// Author(s): Chao Liu <chao.liu@openatom.club>
> +// Author(s): Chen Miao <chenmiao@openatom.club>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Bindings to access `i2c` functionality from Rust.
> +
> +use std::ffi::CStr;
> +
> +pub use bindings::I2CSlaveClass;
> +use common::Opaque;
> +use qom::{prelude::*, Owned};
> +use util::Result;
> +
> +use crate::{
> +    bindings,
> +    bus::{BusClass, BusState},
> +    qdev::{DeviceImpl, DeviceState},
> +};
> +
> +/// A safe wrapper around [`bindings::I2CBus`].
> +#[repr(transparent)]
> +#[derive(Debug, common::Wrapper)]
> +pub struct I2CBus(Opaque<bindings::I2CBus>);
> +
> +unsafe impl Send for I2CBus {}
> +unsafe impl Sync for I2CBus {}
> +
> +unsafe impl ObjectType for I2CBus {
> +    type Class = BusClass;
> +    const TYPE_NAME: &'static CStr =
> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C_BUS) };
> +}
> +
> +qom_isa!(I2CBus: BusState, Object);
> +
> +// TODO: add virtual methods
> +pub trait I2CBusImpl: DeviceImpl + IsA<I2CBus> {}
> +
> +/// Trait for methods of [`I2CBus`] and its subclasses.
> +pub trait I2CBusMethods: ObjectDeref
> +where
> +    Self::Target: IsA<I2CBus>,
> +{
> +    /// Initialize an I2C bus
> +    fn init_bus(&self, parent: &DeviceState, name: &str) -> *mut bindings::I2CBus {
> +        assert!(bql::is_locked());

It's better to add # SFAETY comment (others methods below also need it).

> +        unsafe { bindings::i2c_init_bus(parent.as_mut_ptr(), name.as_ptr().cast()) }
> +    }

...

> +    /// Sets the I2C bus master.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function is unsafe because:
> +    /// - `bh` must be a valid pointer to a `QEMUBH`.
> +    /// - The caller must ensure that `self` is in a valid state.
> +    /// - The caller must guarantee no data races occur during execution.
> +    unsafe fn set_master(&self, bh: *mut bindings::QEMUBH) {

I think it's better to have a Opaque<> wrapper over bindings::QEMUBH.
However, async has not yet been fully considered.

IMO, It seems i2c_bus_master() is only used by i2c-echo, which is not
implememnted in this series. Perhaps this series could initially omit
QEMUBH (with a TODO comment) until QEMUBH binding is introduced.

> +        assert!(bql::is_locked());
> +        unsafe { bindings::i2c_bus_master(self.upcast().as_mut_ptr(), bh) }
> +    }
> +
> +    /// Release an I2C bus
> +    fn release(&self) {
> +        assert!(bql::is_locked());
> +        unsafe { bindings::i2c_bus_release(self.upcast().as_mut_ptr()) }
> +    }
> +}
> +
> +impl<R: ObjectDeref> I2CBusMethods for R where R::Target: IsA<I2CBus> {}
> +
> +/// A safe wrapper around [`bindings::I2CSlave`].
> +#[repr(transparent)]
> +#[derive(Debug, common::Wrapper)]
> +pub struct I2CSlave(Opaque<bindings::I2CSlave>);
> +
> +unsafe impl Send for I2CSlave {}
> +unsafe impl Sync for I2CSlave {}
> +
> +unsafe impl ObjectType for I2CSlave {
> +    type Class = I2CSlaveClass;
> +    const TYPE_NAME: &'static CStr =
> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C_SLAVE) };
> +}
> +
> +qom_isa!(I2CSlave: DeviceState, Object);
> +
> +// TODO: add virtual methods
> +pub trait I2CSlaveImpl: DeviceImpl + IsA<I2CSlave> {
> +    /// Master to slave. Returns non-zero for a NAK, 0 for success.
> +    const SEND: Option<fn(&Self, data: u8) -> Result<bool>> = None;
> +
> +    /// Master to slave (asynchronous). Receiving slave must call `i2c_ack()`.
> +    const SEND_ASYNC: Option<fn(&Self, data: u8) -> Result<()>> = None;
> +
> +    /// Slave to master. This cannot fail, the device should always return something here.
> +    const RECV: Option<fn(&Self) -> Result<bool>> = None;
> +
> +    /// Notify the slave of a bus state change. For start event,
> +    /// returns non-zero to NAK an operation. For other events the
> +    /// return code is not used and should be zero.
> +    const EVENT: Option<fn(&Self, event: I2CEvent) -> Result<I2CEvent>> = None;
> +
> +    /// Check if this device matches the address provided. Returns bool of
> +    /// true if it matches (or broadcast), and updates the device list, false
> +    /// otherwise.
> +    ///
> +    /// If broadcast is true, match should add the device and return true.
> +    type AddressMatcher;
> +    const MATCH_AND_ADD: Option<Self::AddressMatcher> = None;
> +}
> +
> +impl I2CSlaveClass {
> +    /// Fill in the virtual methods of `I2CSlaveClass` based on the
> +    /// definitions in the `I2CSlaveImpl` trait.
> +    pub fn class_init<T: I2CSlaveImpl>(self: &mut I2CSlaveClass) {

It seems the callbacks (SEND/SEND_ASYNC/...) are missing to set here.

For example, add a callback wrapper first:

unsafe extern "C" fn rust_i2c_slave_send_fn<T: I2CSlaveImpl>(
    slave: *mut bindings::I2CSlave,
    date: u8,
) {
    let state = NonNull::new(slave).unwrap().cast::<T>();
    T::SEND.unwrap()(unsafe { state.as_ref() }, data);
}

Then create C callback like:

pub fn class_init<T: I2CSlaveImpl>(self: &mut I2CSlaveClass) {
    ...
    if <T as I2CSlaveImpl>::SEND.is_some() {
        self.send = Some(rust_i2c_slave_send_fn::<T>);
    }
    ...
}

Similarly, you can refer to ResettableClass::class_init and
DeviceClass::class_init.

> +        self.parent_class.class_init::<T>();
> +    }
> +}
> +

Regards,
Zhao


