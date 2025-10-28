Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97848CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgoi-0005p2-QJ; Tue, 28 Oct 2025 06:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDgoE-0005aI-D0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:20:15 -0400
Received: from sg-1-35.ptr.blmpb.com ([118.26.132.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDgo1-0001sf-Gh
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761646717;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=c6pVqAJSGYqfSFkE77Rbsc265tMjCuI1XOJgB8RMqVs=;
 b=zspbSQBWI/AZV7CBUFnbLFGtJ5CT9ohR3+8CetKzvRg8z4UV+ND5khk2WasTgMXGzrFgaE
 ktSe8QnTyKTQ8MNkOXiZsla+C9+pAOZassNCtv1keOBSiIQe5plWpVpPPWgTanmzG9wPZu
 pH8peRR8bSBxype8QsaAGEWnkXHq6d5vLSpijHYmo+ecZNdIQ48jyE1o3i8h6/OGhPjQdp
 W9LH0ZjTrLvR2KTJA5J7NSmT7hEU0LQLbm0CAZLQTglDvd7u94CuJXyq6zqv0uqmeY+aZq
 tKRo1RKxxUL1Z3s1VXh8RgAHwJazhiDPiuX+RvweUV/FrnGX0deJBeJYRdtyiw==
Subject: [RFC PATCH v2 2/5] rust/hw/core: Add rust bindings/funcs for i2c bus
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Tue, 28 Oct 2025 18:18:34 +0800
To: <zhao1.liu@intel.com>, <pbonzini@redhat.com>, 
 <manos.pitsidianakis@linaro.org>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>
Message-Id: <db9abfc03f0dbc953ef314ff7f13ff19298efa7d.1761644606.git.chenmiao@openatom.club>
X-Lms-Return-Path: <lba+26900987b+8c37d8+nongnu.org+chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
Cc: <chao.liu@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
Date: Tue, 28 Oct 2025 10:18:26 +0000
X-Mailer: git-send-email 2.43.0
From: "chenmiao" <chenmiao@openatom.club>
X-Original-From: chenmiao <chenmiao@openatom.club>
Received-SPF: pass client-ip=118.26.132.35;
 envelope-from=chenmiao@openatom.club; helo=sg-1-35.ptr.blmpb.com
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

We have implemented the I2CBus and I2CSlave infrastructure in Rust by refer=
ring
to the SysBus device model.

Initially, we assumed that the I2CBus was at the same hierarchical level as=
 the
PL011 device. Therefore, we followed the implementation paradigm of the PL0=
11
device as a reference. However, in the end, we discovered that the I2CBus i=
s
actually at the same level as the SysBus. As a result, we adopted the bindi=
ng
implementation paradigm used for SysBus devices. With this adjustment, we
successfully compiled the code locally.

During the implementation process, we found that the current two paradigms =
in
Rust =E2=80=94 bindings and impl =E2=80=94 are extremely complex and lack c=
omprehensive
documentation. There is no clear explanation as to why Bus and Device model=
s
need to be implemented using different approaches. Furthermore, the
implementation of Bus and Device following these paradigms still has many
limitations. At present, at least vmstate is not easily supported.

Signed-off-by: Chao Liu <chao.liu@openatom.club>
Signed-off-by: chenmiao <chenmiao@openatom.club>

---
Changes in V2:
  - Rename the i2cbus.rs to i2c.rs.
  - Add some Safety comment for `unsafe function`.
  - Add the callback function for class_init.

---
 rust/hw/core/meson.build |   1 +
 rust/hw/core/src/i2c.rs  | 399 +++++++++++++++++++++++++++++++++++++++
 rust/hw/core/src/lib.rs  |   3 +
 rust/hw/core/wrapper.h   |   1 +
 4 files changed, 404 insertions(+)
 create mode 100644 rust/hw/core/src/i2c.rs

diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index efcda50fef..1a27c1cff7 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -52,6 +52,7 @@ _hwcore_rs =3D static_library(
       'src/bindings.rs',
       'src/bus.rs',
       'src/irq.rs',
+      'src/i2c.rs',
       'src/qdev.rs',
       'src/sysbus.rs',
     ],
diff --git a/rust/hw/core/src/i2c.rs b/rust/hw/core/src/i2c.rs
new file mode 100644
index 0000000000..2d297dbd6e
--- /dev/null
+++ b/rust/hw/core/src/i2c.rs
@@ -0,0 +1,399 @@
+// Copyright 2025 HUST OpenAtom Open Source Club.
+// Author(s): Chao Liu <chao.liu@openatom.club>
+// Author(s): Chen Miao <chenmiao@openatom.club>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings to access `i2c` functionality from Rust.
+
+use std::{ffi::CStr, ptr::NonNull};
+
+pub use crate::bindings::I2CSlaveClass;
+use common::Opaque;
+use qom::{prelude::*, Owned};
+use util::Result;
+
+use crate::{
+    bindings,
+    bus::{BusClass, BusState},
+    qdev::{DeviceImpl, DeviceState},
+};
+
+/// A safe wrapper around [`bindings::I2CBus`].
+#[repr(transparent)]
+#[derive(Debug, common::Wrapper)]
+pub struct I2CBus(Opaque<bindings::I2CBus>);
+
+unsafe impl Send for I2CBus {}
+unsafe impl Sync for I2CBus {}
+
+unsafe impl ObjectType for I2CBus {
+    type Class =3D BusClass;
+    const TYPE_NAME: &'static CStr =3D
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C_BU=
S) };
+}
+
+qom_isa!(I2CBus: BusState, Object);
+
+// TODO: add virtual methods
+pub trait I2CBusImpl: DeviceImpl + IsA<I2CBus> {}
+
+/// Trait for methods of [`I2CBus`] and its subclasses.
+pub trait I2CBusMethods: ObjectDeref
+where
+    Self::Target: IsA<I2CBus>,
+{
+    /// # Safety
+    ///
+    /// Initialize an I2C bus
+    fn init_bus(&self, parent: &DeviceState, name: &str) -> *mut bindings:=
:I2CBus {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_init_bus(parent.as_mut_ptr(), name.as_ptr()=
.cast()) }
+    }
+
+    /// # Safety
+    ///
+    /// Start a transfer on an I2C bus
+    fn start_transfer(&self, address: u8, is_recv: bool) -> i32 {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_start_transfer(self.upcast().as_mut_ptr(), =
address, is_recv) }
+    }
+
+    /// # Safety
+    ///
+    /// Start a receive transfer on an I2C bus
+    fn start_recv(&self, address: u8) -> i32 {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_start_recv(self.upcast().as_mut_ptr(), addr=
ess) }
+    }
+
+    /// # Safety
+    ///
+    /// Start a send transfer on an I2C bus
+    fn start_send(&self, address: u8) -> i32 {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_start_send(self.upcast().as_mut_ptr(), addr=
ess) }
+    }
+
+    /// # Safety
+    ///
+    /// Start an asynchronous send transfer on an I2C bus
+    fn start_send_async(&self, address: u8) -> i32 {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_start_send_async(self.upcast().as_mut_ptr()=
, address) }
+    }
+
+    /// # Safety
+    ///
+    /// End a transfer on an I2C bus
+    fn end_transfer(&self) {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_end_transfer(self.upcast().as_mut_ptr()) }
+    }
+
+    /// # Safety
+    ///
+    /// Send NACK on an I2C bus
+    fn nack(&self) {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_nack(self.upcast().as_mut_ptr()) }
+    }
+
+    /// # Safety
+    ///
+    /// Send ACK on an I2C bus
+    fn ack(&self) {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_ack(self.upcast().as_mut_ptr()) }
+    }
+
+    /// # Safety
+    ///
+    /// Send data on an I2C bus
+    fn send(&self, data: u8) -> i32 {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_send(self.upcast().as_mut_ptr(), data) }
+    }
+
+    /// # Safety
+    ///
+    /// Send data asynchronously on an I2C bus
+    fn send_async(&self, data: u8) -> i32 {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_send_async(self.upcast().as_mut_ptr(), data=
) }
+    }
+
+    /// # Safety
+    ///
+    /// Receive data from an I2C bus
+    fn recv(&self) -> u8 {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_recv(self.upcast().as_mut_ptr()) }
+    }
+
+    /// # Safety
+    ///
+    /// Check if the I2C bus is busy.
+    ///
+    /// Returns `true` if the bus is busy, `false` otherwise.
+    fn is_busy(&self) -> bool {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_bus_busy(self.upcast().as_mut_ptr()) !=3D 0=
 }
+    }
+
+    /// # Safety
+    ///
+    /// Schedule pending master on an I2C bus
+    fn schedule_pending_master(&self) {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_schedule_pending_master(self.upcast().as_mu=
t_ptr()) }
+    }
+
+    /// Sets the I2C bus master.
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe because:
+    /// - `bh` must be a valid pointer to a `QEMUBH`.
+    /// - The caller must ensure that `self` is in a valid state.
+    /// - The caller must guarantee no data races occur during execution.
+    ///
+    /// TODO: `bindings:QEMUBH` should be wrapped by Opaque<>.
+    unsafe fn set_master(&self, bh: *mut bindings::QEMUBH) {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_bus_master(self.upcast().as_mut_ptr(), bh) =
}
+    }
+
+    /// # Safety
+    ///
+    /// Release an I2C bus
+    fn release(&self) {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_bus_release(self.upcast().as_mut_ptr()) }
+    }
+}
+
+impl<R: ObjectDeref> I2CBusMethods for R where R::Target: IsA<I2CBus> {}
+
+/// A safe wrapper around [`bindings::I2CSlave`].
+#[repr(transparent)]
+#[derive(Debug, common::Wrapper)]
+pub struct I2CSlave(Opaque<bindings::I2CSlave>);
+
+unsafe impl Send for I2CSlave {}
+unsafe impl Sync for I2CSlave {}
+
+unsafe impl ObjectType for I2CSlave {
+    type Class =3D I2CSlaveClass;
+    const TYPE_NAME: &'static CStr =3D
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_I2C_SL=
AVE) };
+}
+
+qom_isa!(I2CSlave: DeviceState, Object);
+
+// TODO: add virtual methods
+pub trait I2CSlaveImpl: DeviceImpl + IsA<I2CSlave> {
+    /// Master to slave. Returns non-zero for a NAK, 0 for success.
+    const SEND: Option<fn(&Self, data: u8) -> Result<bool>> =3D None;
+
+    /// Master to slave (asynchronous). Receiving slave must call `i2c_ack=
()`.
+    const SEND_ASYNC: Option<fn(&Self, data: u8)> =3D None;
+
+    /// Slave to master. This cannot fail, the device should always return=
 something here.
+    const RECV: Option<fn(&Self) -> Result<bool>> =3D None;
+
+    /// Notify the slave of a bus state change. For start event,
+    /// returns non-zero to NAK an operation. For other events the
+    /// return code is not used and should be zero.
+    const EVENT: Option<fn(&Self, event: I2CEvent) -> Result<I2CEvent>> =
=3D None;
+
+    /// Check if this device matches the address provided. Returns bool of
+    /// true if it matches (or broadcast), and updates the device list, fa=
lse
+    /// otherwise.
+    ///
+    /// If broadcast is true, match should add the device and return true.
+    const MATCH_AND_ADD: Option<
+        fn(
+            &Self,
+            address: u8,
+            broadcast: bool,
+            current_devs: *mut bindings::I2CNodeList,
+        ) -> Result<bool>,
+    > =3D None;
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_i2c_slave_send_fn<T: I2CSlaveImpl>(
+    obj: *mut bindings::I2CSlave,
+    data: u8,
+) -> std::os::raw::c_int {
+    let state =3D NonNull::new(obj).unwrap().cast::<T>();
+    match T::SEND.unwrap()(unsafe { state.as_ref() }, data) {
+        Ok(_) =3D> 0,
+        Err(_) =3D> 1,
+    }
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_i2c_slave_send_async_fn<T: I2CSlaveImpl>(
+    obj: *mut bindings::I2CSlave,
+    data: u8,
+) {
+    let state =3D NonNull::new(obj).unwrap().cast::<T>();
+    T::SEND_ASYNC.unwrap()(unsafe { state.as_ref() }, data);
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_i2c_slave_event_fn<T: I2CSlaveImpl>(
+    obj: *mut bindings::I2CSlave,
+    event: bindings::i2c_event,
+) -> std::os::raw::c_int {
+    let state =3D NonNull::new(obj).unwrap().cast::<T>();
+    match T::EVENT.unwrap()(unsafe { state.as_ref() }, I2CEvent::from(even=
t)) {
+        Ok(e) =3D> bindings::i2c_event::from(e).try_into().unwrap(),
+        Err(_) =3D> -1,
+    }
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_i2c_slave_match_and_add_fn<T: I2CSlaveImpl>(
+    obj: *mut bindings::I2CSlave,
+    address: u8,
+    broadcast: bool,
+    current_devs: *mut bindings::I2CNodeList,
+) -> bool {
+    let state =3D NonNull::new(obj).unwrap().cast::<T>();
+    T::MATCH_AND_ADD.unwrap()(unsafe { state.as_ref() }, address, broadcas=
t, current_devs).is_ok()
+}
+
+impl I2CSlaveClass {
+    /// Fill in the virtual methods of `I2CSlaveClass` based on the
+    /// definitions in the `I2CSlaveImpl` trait.
+    pub fn class_init<T: I2CSlaveImpl>(&mut self) {
+        if <T as I2CSlaveImpl>::SEND.is_some() {
+            self.send =3D Some(rust_i2c_slave_send_fn::<T>);
+        }
+        if <T as I2CSlaveImpl>::SEND_ASYNC.is_some() {
+            self.send_async =3D Some(rust_i2c_slave_send_async_fn::<T>);
+        }
+        if <T as I2CSlaveImpl>::EVENT.is_some() {
+            self.event =3D Some(rust_i2c_slave_event_fn::<T>);
+        }
+        if <T as I2CSlaveImpl>::MATCH_AND_ADD.is_some() {
+            self.match_and_add =3D Some(rust_i2c_slave_match_and_add_fn::<=
T>);
+        }
+        self.parent_class.class_init::<T>();
+    }
+}
+
+/// Trait for methods of [`I2CSlave`] and its subclasses.
+pub trait I2CSlaveMethods: ObjectDeref
+where
+    Self::Target: IsA<I2CSlave>,
+{
+    /// Create an I2C slave device on the heap.
+    ///
+    /// # Arguments
+    /// * `name` - a device type name
+    /// * `addr` - I2C address of the slave when put on a bus
+    ///
+    /// This only initializes the device state structure and allows
+    /// properties to be set. Type `name` must exist. The device still
+    /// needs to be realized.
+    fn init_new(name: &str, addr: u8) -> Owned<I2CSlave> {
+        assert!(bql::is_locked());
+        unsafe {
+            let slave =3D bindings::i2c_slave_new(name.as_ptr().cast(), ad=
dr);
+            Owned::from(I2CSlave::from_raw(slave))
+        }
+    }
+
+    /// Create and realize an I2C slave device on the heap.
+    ///
+    /// # Arguments
+    /// * `bus` - I2C bus to put it on
+    /// * `name` - I2C slave device type name
+    /// * `addr` - I2C address of the slave when put on a bus
+    ///
+    /// Create the device state structure, initialize it, put it on the
+    /// specified `bus`, and drop the reference to it (the device is reali=
zed).
+    fn create_simple(&self, bus: &I2CBus, name: &str, addr: u8) -> Owned<I=
2CSlave> {
+        assert!(bql::is_locked());
+        unsafe {
+            let slave =3D
+                bindings::i2c_slave_create_simple(bus.as_mut_ptr(), name.a=
s_ptr().cast(), addr);
+            Owned::from(I2CSlave::from_raw(slave))
+        }
+    }
+
+    /// Set the I2C bus address of a slave device
+    ///
+    /// # Arguments
+    /// * `address` - I2C address of the slave when put on a bus
+    fn set_address(&self, address: u8) {
+        assert!(bql::is_locked());
+        unsafe { bindings::i2c_slave_set_address(self.upcast().as_mut_ptr(=
), address) }
+    }
+
+    /// Get the I2C bus address of a slave device
+    fn get_address(&self) -> u8 {
+        assert!(bql::is_locked());
+        // SAFETY: the BQL ensures that no one else writes to the I2CSlave=
 structure,
+        // and the I2CSlave must be initialized to get an IsA<I2CSlave>.
+        let slave =3D unsafe { *self.upcast().as_ptr() };
+        slave.address
+    }
+}
+
+impl<R: ObjectDeref> I2CSlaveMethods for R where R::Target: IsA<I2CSlave> =
{}
+
+/// Enum representing I2C events
+#[repr(i32)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum I2CEvent {
+    StartRecv =3D 0,
+    StartSend =3D 1,
+    StartSendAsync =3D 2,
+    Finish =3D 3,
+    Nack =3D 4,
+}
+
+impl From<bindings::i2c_event> for I2CEvent {
+    fn from(event: bindings::i2c_event) -> Self {
+        match event {
+            bindings::I2C_START_RECV =3D> I2CEvent::StartRecv,
+            bindings::I2C_START_SEND =3D> I2CEvent::StartSend,
+            bindings::I2C_START_SEND_ASYNC =3D> I2CEvent::StartSendAsync,
+            bindings::I2C_FINISH =3D> I2CEvent::Finish,
+            bindings::I2C_NACK =3D> I2CEvent::Nack,
+            _ =3D> panic!("Unknown I2C event: {event}"),
+        }
+    }
+}
+
+impl From<I2CEvent> for bindings::i2c_event {
+    fn from(event: I2CEvent) -> Self {
+        match event {
+            I2CEvent::StartRecv =3D> bindings::I2C_START_RECV,
+            I2CEvent::StartSend =3D> bindings::I2C_START_SEND,
+            I2CEvent::StartSendAsync =3D> bindings::I2C_START_SEND_ASYNC,
+            I2CEvent::Finish =3D> bindings::I2C_FINISH,
+            I2CEvent::Nack =3D> bindings::I2C_NACK,
+        }
+    }
+}
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
index 10cc516664..3f3aecb258 100644
--- a/rust/hw/core/src/lib.rs
+++ b/rust/hw/core/src/lib.rs
@@ -16,3 +16,6 @@
=20
 mod bus;
 pub use bus::*;
+
+mod i2c;
+pub use i2c::*;
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
index 3bdbd1249e..399be594da 100644
--- a/rust/hw/core/wrapper.h
+++ b/rust/hw/core/wrapper.h
@@ -30,3 +30,4 @@ typedef enum memory_order {
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
+#include "hw/i2c/i2c.h"
--=20
2.43.0

