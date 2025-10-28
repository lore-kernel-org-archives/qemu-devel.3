Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D804CCF9E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 02:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDZP9-0002Yl-TC; Mon, 27 Oct 2025 22:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDZP7-0002YV-59
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 22:25:45 -0400
Received: from sg-1-21.ptr.blmpb.com ([118.26.132.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDZOw-0003cS-FI
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 22:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761618314;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=o54b0pDg9yXREB1dN2LH8NZeQ92OBhMKqCmOFsRu6Sw=;
 b=t9ZckaihNE6hwr2o+wvXQ9mJ8V7AflRyfDegxGgUjALJ5ERQ0LhjFgUF7E51YIGFEFQfCn
 Sjpj+y9E+xK9QDc5ri1JlCbk2UrWg2Oeqc/C9lznQX9aWgeg2oNhw0walch79PQkopwSgQ
 sazM0y67YVm90zEg5ljfHmr3GpYKyr4UjWCq34xUU6ODMYig76Bxr6ssw/vXPFkfhAVObx
 7XtPdiDax25GwOH1aoV3D5a8g0YoQgTCWf1J5stqCIXNgOGSFlgJhdV6PW69t91d/Aack/
 NVDK7Yvovxd9DrQx4v6iTGkKWx8d7tOZ3HzC/vGvFcwKr3AUgYYarfkDzmT8tw==
Subject: Re: [RFC 2/5] rust: hw: core: Add rust bindings/funcs for i2c bus
To: "Zhao Liu" <zhao1.liu@intel.com>
Received: from [198.18.0.1] ([114.249.194.57]) by smtp.feishu.cn with ESMTPS;
 Tue, 28 Oct 2025 10:25:11 +0800
References: <20251025123853.63139-3-chenmiao@openatom.club>
 <aP8cp3y6uCa7tsel@intel.com>
Content-Transfer-Encoding: quoted-printable
From: "Chen Miao" <chenmiao@openatom.club>
Message-Id: <257dc812-a7c0-492a-a03a-d1e567bb6442@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
X-Lms-Return-Path: <lba+269002988+d3a40b+nongnu.org+chenmiao@openatom.club>
Cc: <pbonzini@redhat.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>, 
 "Chao Liu" <chao.liu@openatom.club>
Date: Tue, 28 Oct 2025 10:25:10 +0800
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <aP8cp3y6uCa7tsel@intel.com>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.21;
 envelope-from=chenmiao@openatom.club; helo=sg-1-21.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/27/2025 3:17 PM, Zhao Liu wrote:
> On Sat, Oct 25, 2025 at 12:38:50PM +0000, chenmiao wrote:
>> Date: Sat, 25 Oct 2025 12:38:50 +0000
>> From: chenmiao <chenmiao@openatom.club>
>> Subject: [RFC 2/5] rust: hw: core: Add rust bindings/funcs for i2c bus
>> X-Mailer: git-send-email 2.43.0
>>
>> We have implemented the I2CBus and I2CSlave infrastructure in Rust by re=
ferring
>> to the SysBus device model.
>>
>> Initially, we assumed that the I2CBus was at the same hierarchical level=
 as the
>> PL011 device. Therefore, we followed the implementation paradigm of the =
PL011
>> device as a reference. However, in the end, we discovered that the I2CBu=
s is
>> actually at the same level as the SysBus. As a result, we adopted the bi=
nding
>> implementation paradigm used for SysBus devices. With this adjustment, w=
e
>> successfully compiled the code locally.
>>
>> During the implementation process, we found that the current two paradig=
ms in
>> Rust =E2=80=94 bindings and impl =E2=80=94 are extremely complex and lac=
k comprehensive
>> documentation. There is no clear explanation as to why Bus and Device mo=
dels
>> need to be implemented using different approaches. Furthermore, the
>> implementation of Bus and Device following these paradigms still has man=
y
>> limitations. At present, at least vmstate is not easily supported.
>>
>> Signed-off-by: Chao Liu <chao.liu@openatom.club>
>> Signed-off-by: chenmiao <chenmiao@openatom.club>
>> ---
>>   rust/hw/core/meson.build   |   1 +
>>   rust/hw/core/src/i2cbus.rs | 291 +++++++++++++++++++++++++++++++++++++
>>   rust/hw/core/src/lib.rs    |   3 +
>>   rust/hw/core/wrapper.h     |   1 +
>>   4 files changed, 296 insertions(+)
>>   create mode 100644 rust/hw/core/src/i2cbus.rs
>>
>> diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
>> index efcda50..7c44786 100644
>> --- a/rust/hw/core/meson.build
>> +++ b/rust/hw/core/meson.build
>> @@ -52,6 +52,7 @@ _hwcore_rs =3D static_library(
>>         'src/bindings.rs',
>>         'src/bus.rs',
>>         'src/irq.rs',
>> +      'src/i2cbus.rs',
>>         'src/qdev.rs',
>>         'src/sysbus.rs',
>>       ],
>> diff --git a/rust/hw/core/src/i2cbus.rs b/rust/hw/core/src/i2cbus.rs
>> new file mode 100644
>> index 0000000..c026955
>> --- /dev/null
>> +++ b/rust/hw/core/src/i2cbus.rs
> This file implements both I2CBus and I2C device (Slave).
>
> To be general, I think it's better to name it as "i2c.rs".
>
>> @@ -0,0 +1,291 @@
>> +// Copyright 2025 HUST OpenAtom Open Source Club.
>> +// Author(s): Chao Liu <chao.liu@openatom.club>
>> +// Author(s): Chen Miao <chenmiao@openatom.club>
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +//! Bindings to access `i2c` functionality from Rust.
>> +
>> +use std::ffi::CStr;
>> +
>> +pub use bindings::I2CSlaveClass;
>> +use common::Opaque;
>> +use qom::{prelude::*, Owned};
>> +use util::Result;
>> +
>> +use crate::{
>> +    bindings,
>> +    bus::{BusClass, BusState},
>> +    qdev::{DeviceImpl, DeviceState},
>> +};
>> +
>> +/// A safe wrapper around [`bindings::I2CBus`].
>> +#[repr(transparent)]
>> +#[derive(Debug, common::Wrapper)]
>> +pub struct I2CBus(Opaque<bindings::I2CBus>);
>> +
>> +unsafe impl Send for I2CBus {}
>> +unsafe impl Sync for I2CBus {}
>> +
>> +unsafe impl ObjectType for I2CBus {
>> +    type Class =3D BusClass;
>> +    const TYPE_NAME: &'static CStr =3D
>> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C=
_BUS) };
>> +}
>> +
>> +qom_isa!(I2CBus: BusState, Object);
>> +
>> +// TODO: add virtual methods
>> +pub trait I2CBusImpl: DeviceImpl + IsA<I2CBus> {}
>> +
>> +/// Trait for methods of [`I2CBus`] and its subclasses.
>> +pub trait I2CBusMethods: ObjectDeref
>> +where
>> +    Self::Target: IsA<I2CBus>,
>> +{
>> +    /// Initialize an I2C bus
>> +    fn init_bus(&self, parent: &DeviceState, name: &str) -> *mut bindin=
gs::I2CBus {
>> +        assert!(bql::is_locked());
> It's better to add # SFAETY comment (others methods below also need it).
>
>> +        unsafe { bindings::i2c_init_bus(parent.as_mut_ptr(), name.as_pt=
r().cast()) }
>> +    }
> ...
>
>> +    /// Sets the I2C bus master.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function is unsafe because:
>> +    /// - `bh` must be a valid pointer to a `QEMUBH`.
>> +    /// - The caller must ensure that `self` is in a valid state.
>> +    /// - The caller must guarantee no data races occur during executio=
n.
>> +    unsafe fn set_master(&self, bh: *mut bindings::QEMUBH) {
> I think it's better to have a Opaque<> wrapper over bindings::QEMUBH.
> However, async has not yet been fully considered.
>
> IMO, It seems i2c_bus_master() is only used by i2c-echo, which is not
> implememnted in this series. Perhaps this series could initially omit
> QEMUBH (with a TODO comment) until QEMUBH binding is introduced.
I think our team is also interested in the implementation of QEMUBH, and we=
=20
will try to implement this part as well. Regarding the omission of QEMUBH, =
I=20
believe we can add a comment here for now!
>> +        assert!(bql::is_locked());
>> +        unsafe { bindings::i2c_bus_master(self.upcast().as_mut_ptr(), b=
h) }
>> +    }
>> +
>> +    /// Release an I2C bus
>> +    fn release(&self) {
>> +        assert!(bql::is_locked());
>> +        unsafe { bindings::i2c_bus_release(self.upcast().as_mut_ptr()) =
}
>> +    }
>> +}
>> +
>> +impl<R: ObjectDeref> I2CBusMethods for R where R::Target: IsA<I2CBus> {=
}
>> +
>> +/// A safe wrapper around [`bindings::I2CSlave`].
>> +#[repr(transparent)]
>> +#[derive(Debug, common::Wrapper)]
>> +pub struct I2CSlave(Opaque<bindings::I2CSlave>);
>> +
>> +unsafe impl Send for I2CSlave {}
>> +unsafe impl Sync for I2CSlave {}
>> +
>> +unsafe impl ObjectType for I2CSlave {
>> +    type Class =3D I2CSlaveClass;
>> +    const TYPE_NAME: &'static CStr =3D
>> +        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C=
_SLAVE) };
>> +}
>> +
>> +qom_isa!(I2CSlave: DeviceState, Object);
>> +
>> +// TODO: add virtual methods
>> +pub trait I2CSlaveImpl: DeviceImpl + IsA<I2CSlave> {
>> +    /// Master to slave. Returns non-zero for a NAK, 0 for success.
>> +    const SEND: Option<fn(&Self, data: u8) -> Result<bool>> =3D None;
>> +
>> +    /// Master to slave (asynchronous). Receiving slave must call `i2c_=
ack()`.
>> +    const SEND_ASYNC: Option<fn(&Self, data: u8) -> Result<()>> =3D Non=
e;
>> +
>> +    /// Slave to master. This cannot fail, the device should always ret=
urn something here.
>> +    const RECV: Option<fn(&Self) -> Result<bool>> =3D None;
>> +
>> +    /// Notify the slave of a bus state change. For start event,
>> +    /// returns non-zero to NAK an operation. For other events the
>> +    /// return code is not used and should be zero.
>> +    const EVENT: Option<fn(&Self, event: I2CEvent) -> Result<I2CEvent>>=
 =3D None;
>> +
>> +    /// Check if this device matches the address provided. Returns bool=
 of
>> +    /// true if it matches (or broadcast), and updates the device list,=
 false
>> +    /// otherwise.
>> +    ///
>> +    /// If broadcast is true, match should add the device and return tr=
ue.
>> +    type AddressMatcher;
>> +    const MATCH_AND_ADD: Option<Self::AddressMatcher> =3D None;
>> +}
>> +
>> +impl I2CSlaveClass {
>> +    /// Fill in the virtual methods of `I2CSlaveClass` based on the
>> +    /// definitions in the `I2CSlaveImpl` trait.
>> +    pub fn class_init<T: I2CSlaveImpl>(self: &mut I2CSlaveClass) {
> It seems the callbacks (SEND/SEND_ASYNC/...) are missing to set here.
>
> For example, add a callback wrapper first:
>
> unsafe extern "C" fn rust_i2c_slave_send_fn<T: I2CSlaveImpl>(
>      slave: *mut bindings::I2CSlave,
>      date: u8,
> ) {
>      let state =3D NonNull::new(slave).unwrap().cast::<T>();
>      T::SEND.unwrap()(unsafe { state.as_ref() }, data);
> }
>
> Then create C callback like:
>
> pub fn class_init<T: I2CSlaveImpl>(self: &mut I2CSlaveClass) {
>      ...
>      if <T as I2CSlaveImpl>::SEND.is_some() {
>          self.send =3D Some(rust_i2c_slave_send_fn::<T>);
>      }
>      ...
> }
>
> Similarly, you can refer to ResettableClass::class_init and
> DeviceClass::class_init.

Ok, I'll complete it strictly according to your instructions.

>
>> +        self.parent_class.class_init::<T>();
>> +    }
>> +}
>> +
> Regards,
> Zhao

Waiting for your next review for other patch.

Thanks,

Chen Miao

>

