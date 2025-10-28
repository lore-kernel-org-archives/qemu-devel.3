Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019AECCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhjN-00069X-Ca; Tue, 28 Oct 2025 07:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDhjK-00068L-Cj
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:19:10 -0400
Received: from sg-1-37.ptr.blmpb.com ([118.26.132.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDhj5-0002QX-RN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761650317;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=C9O2EX66xTbz0xtPCbTnhydl/i/4nh2R4sB9bd1aZ4o=;
 b=KIXt1BAlhqlq98txcIxT0IAR11FUhuv1MoOXD0q7rgZDJVFx787ojkWGiKRy0o+H8qPTh8
 YSwWLgrfsDZzigVAPhYXjGgikBWTB6VQznEedUPVsYhPk8udypufoCg4rp+FsCj9+uXv28
 AzMGbfhXEP+zy9Ke/npysXWEjP8CH7EwOFGxP3nIASmDVJZy14PPLVMl8cbp3eTxy+u6pt
 HOA4JssapLxT2OQ2K9dhRSm3fOCZQM1Y26neXC7E2QtWP/f2+ioaaDRYBjUshUACsTCC0a
 sgwPoZA9VcB2EiGWPF1B3z5F7u1lUZPyyiuW79Yio2NNyUjX+kgE/x4NeeWZbw==
Cc: <zhao1.liu@intel.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <chao.liu@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
In-Reply-To: <CABgObfaBbf9Hq7RRLkhsa5n0-J+boe1T4guEakOEXDHFrc=4AQ@mail.gmail.com>
Message-Id: <c1d55488-71e2-498f-a845-d8a336c46f07@openatom.club>
Mime-Version: 1.0
To: "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 2/5] rust/hw/core: Add rust bindings/funcs for i2c
 bus
X-Original-From: Chen Miao <chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
Received: from [198.18.0.1] ([114.249.194.57]) by smtp.feishu.cn with ESMTPS;
 Tue, 28 Oct 2025 19:18:35 +0800
User-Agent: Mozilla Thunderbird
From: "Chen Miao" <chenmiao@openatom.club>
Date: Tue, 28 Oct 2025 19:18:34 +0800
References: <db9abfc03f0dbc953ef314ff7f13ff19298efa7d.1761644606.git.chenmiao@openatom.club>
 <CABgObfaBbf9Hq7RRLkhsa5n0-J+boe1T4guEakOEXDHFrc=4AQ@mail.gmail.com>
X-Lms-Return-Path: <lba+26900a68c+f19f90+nongnu.org+chenmiao@openatom.club>
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=118.26.132.37;
 envelope-from=chenmiao@openatom.club; helo=sg-1-37.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/28/2025 6:45 PM, Paolo Bonzini wrote:
> On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.club=
> wrote:
>> During the implementation process, we found that the current two paradig=
ms in
>> Rust =E2=80=94 bindings and impl =E2=80=94 are extremely complex and lac=
k comprehensive
>> documentation. There is no clear explanation as to why Bus and Device mo=
dels
>> need to be implemented using different approaches.
> I don't think they need to be implemented using different approaches.
> The difference between the two is that:
>
> - the currently implemented devices do not expose any bus, they stay
> on a bus. This means the bus is never a child of the device
>
> - the currently implemented buses are all in C code, whereas there are
> devices implemented in Rust.
>
> I agree that the Rust-to-C bridge code is complex, but it does have
> documentation, much more so than the C versions in fact.  If there are
> specific aspects of the documentation that you would like to see
> improved, you can help by explaining what problems and sources of
> confusion you encountered.

That makes sense to me. Since buses are mainly implemented in C, the curren=
t=20
focus of Rust is on porting the device layer. Rust-implemented devices are=
=20
consumers and do not create any child objects.

I think our previous confusion stemmed from the assumption that Rust was=20
porting the entire hierarchy, when in fact Rust is currently only implement=
ing=20
the device layer.

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
>> +/// Trait for methods of [`I2CBus`] and its subclasses.
>> +pub trait I2CBusMethods: ObjectDeref
>> +where
>> +    Self::Target: IsA<I2CBus>
>
> There are no virtual methods, and therefore I2CBus does not have
> subclasses.  Therefore you don't need these traits and you can
> implement the functions directly on I2CBus.
For this part, we directly referred to the implementation of SysBus.
>> +{
>> +    /// # Safety
>> +    ///
>> +    /// Initialize an I2C bus
>> +    fn init_bus(&self, parent: &DeviceState, name: &str) -> *mut bindin=
gs::I2CBus {
>> +        assert!(bql::is_locked());
>> +        unsafe { bindings::i2c_init_bus(parent.as_mut_ptr(), name.as_pt=
r().cast()) }
>> +    }
> This should return an Owned<I2CBus>.
Yes, I'll fix it later.
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
>> +    ///
>> +    /// TODO: `bindings:QEMUBH` should be wrapped by Opaque<>.
>> +    unsafe fn set_master(&self, bh: *mut bindings::QEMUBH) {
>> +        assert!(bql::is_locked());
>> +        unsafe { bindings::i2c_bus_master(self.upcast().as_mut_ptr(), b=
h) }
>> +    }
> I agree with Zhao, I would leave out this completely. You can add a
> TODO ("i2c_bus_master missing until QEMUBH is wrapped").
>
>> +    /// # Safety
>> +    ///
>> +    /// Release an I2C bus
>> +    fn release(&self) {
>> +        assert!(bql::is_locked());
>> +        unsafe { bindings::i2c_bus_release(self.upcast().as_mut_ptr()) =
}
>> +    }
> Same for this, which is the counterpart of i2c_bus_master. In Rust, in
> fact, release() should be done with an RAII guard returned by
> set_master.
>
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
> Make it return an "enum I2CResult { Ack, Nack };" instead of a Result.
> Likewise other function pointers here do not need a Result<>.
>> +    /// Master to slave (asynchronous). Receiving slave must call `i2c_=
ack()`.
>> +    const SEND_ASYNC: Option<fn(&Self, data: u8)> =3D None;
> This requires the bottom half machinery. Leave it out.
>> +/// Trait for methods of [`I2CSlave`] and its subclasses.
>> +pub trait I2CSlaveMethods: ObjectDeref
>> +where
>> +    Self::Target: IsA<I2CSlave>,
>> +{
>> +    /// Create an I2C slave device on the heap.
>> +    ///
>> +    /// # Arguments
>> +    /// * `name` - a device type name
>> +    /// * `addr` - I2C address of the slave when put on a bus
>> +    ///
>> +    /// This only initializes the device state structure and allows
>> +    /// properties to be set. Type `name` must exist. The device still
>> +    /// needs to be realized.
>> +    fn init_new(name: &str, addr: u8) -> Owned<I2CSlave> {
>> +        assert!(bql::is_locked());
>> +        unsafe {
>> +            let slave =3D bindings::i2c_slave_new(name.as_ptr().cast(),=
 addr);
>> +            Owned::from(I2CSlave::from_raw(slave))
>> +        }
>> +    }
>> +
>> +    /// Create and realize an I2C slave device on the heap.
>> +    ///
>> +    /// # Arguments
>> +    /// * `bus` - I2C bus to put it on
>> +    /// * `name` - I2C slave device type name
>> +    /// * `addr` - I2C address of the slave when put on a bus
>> +    ///
>> +    /// Create the device state structure, initialize it, put it on the
>> +    /// specified `bus`, and drop the reference to it (the device is re=
alized).
>> +    fn create_simple(&self, bus: &I2CBus, name: &str, addr: u8) -> Owne=
d<I2CSlave> {
>> +        assert!(bql::is_locked());
>> +        unsafe {
>> +            let slave =3D
>> +                bindings::i2c_slave_create_simple(bus.as_mut_ptr(), nam=
e.as_ptr().cast(), addr);
>> +            Owned::from(I2CSlave::from_raw(slave))
>> +        }
>> +    }
>> +
>> +    /// Set the I2C bus address of a slave device
>> +    ///
>> +    /// # Arguments
>> +    /// * `address` - I2C address of the slave when put on a bus
>> +    fn set_address(&self, address: u8) {
>> +        assert!(bql::is_locked());
>> +        unsafe { bindings::i2c_slave_set_address(self.upcast().as_mut_p=
tr(), address) }
>> +    }
> These three are used by boards, which we don't model. We can keep the
> code simple by leaving them off (in addition, init_new and
> create_simple would be *class* methods, as visible from the fact that
> they don't use self at all).
>
>> +    /// Get the I2C bus address of a slave device
>> +    fn get_address(&self) -> u8 {
>> +        assert!(bql::is_locked());
>> +        // SAFETY: the BQL ensures that no one else writes to the I2CSl=
ave structure,
>> +        // and the I2CSlave must be initialized to get an IsA<I2CSlave>=
.
>> +        let slave =3D unsafe { *self.upcast().as_ptr() };
>> +        slave.address
>> +    }
>> +}
>> +
>> +impl<R: ObjectDeref> I2CSlaveMethods for R where R::Target: IsA<I2CSlav=
e> {}
>> +
>> +/// Enum representing I2C events
>> +#[repr(i32)]
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +pub enum I2CEvent {
>> +    StartRecv =3D 0,
>> +    StartSend =3D 1,
>> +    StartSendAsync =3D 2,
>> +    Finish =3D 3,
>> +    Nack =3D 4,
>> +}
> Make it "=3D bindings::I2C_START_RECV" etc. You can then use
> #[derive(common::TryInto)] instead of implementing by hand the From
> traits.
>
> Paolo

I'll revise all the points you have raised later.

Thanks,

Chen Miao

