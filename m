Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF32BCFB422
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7som-0002RV-PR; Mon, 04 Nov 2024 03:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t7sok-0002RN-O5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t7soh-0000VE-Lh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730710325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K+cvWhjlcA5GQqteMJk24onsvI4M1IOytXcTeTVuXbE=;
 b=N2taYljAe93nJ8g/75bnT8+chUFEjAMQJ44FKDsUnS6RXgj8Qvj+IzCs1tLyygdvQ+ZgRz
 ojNeC9LvRlO4OLi+AlM0JTwE18LFj85EDUKLUOmGfN0PQeMoSM1mVT05g0Sbiw0hpwqy/7
 HdmOvXiDOMsHCFhysrROwUXS8lwtu7w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-LUzro0C4N8KDMZ3wPtY-XA-1; Mon, 04 Nov 2024 03:52:03 -0500
X-MC-Unique: LUzro0C4N8KDMZ3wPtY-XA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso26726985e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 00:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730710322; x=1731315122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K+cvWhjlcA5GQqteMJk24onsvI4M1IOytXcTeTVuXbE=;
 b=aU2+T2QdwE1SM6iOdUNTtVzdDKAOLjjgjARuwPbJGhpTjTlUkfDGTXGDSEteiT++N6
 vwAWLJwKloxuKQW+g1btPut8Oo/vW0GFRcLiYp7BpBF3nqHJJWcyeE0h+rbfeiLz6Q3G
 LKqiIJ7fDVGqfrvhYzs18p3S75BE//FwDoippc2995G09VohFniILCJ8nT1knk2Ej/tY
 2kQ/TLFmNfa3OmSDgL7JDws0iAOkk5EJRnRq/XiBrL5lb2qSv1WBSbrHmTNtZmRMsVL8
 CnoN5vTMG6YjkRxOtDQIcoZPCMvLRMvtUYQSeh9ZGvuKTPODbkPvIjruxefexxOz8l1v
 4R9g==
X-Gm-Message-State: AOJu0YyLqfksxHx4RuM5gVnjvlrUrSBbSDnPWFAKNDcf6vmXOyOfclZV
 QcjjgT7zaQIhHCbjAnN86G0I0d+jQBUfTyGaTmEnquXpxIrn4rQBQ/YKQ3/zEsu8Mb4uyBP3u/p
 BWJMl0joWIjoQkIKfyou4DCtFZ3HgM0RZYJZ2mTxVtwTpr4zZ8NDk1r3+E0tnqt3hRWmB7m9xy0
 sdreXm3/ei1zShWV1TkXtRQrgVsv+76oggtDjC68A=
X-Received: by 2002:a05:600c:1f81:b0:431:5465:807b with SMTP id
 5b1f17b1804b1-432832989c5mr86537225e9.32.1730710322221; 
 Mon, 04 Nov 2024 00:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHjD3mGXKwrkvyzKz0y/9o266XqvK8E0gDQPlEWFnMFwWWbjTUimP6vC2f/Re+eQIp6ZbxFg==
X-Received: by 2002:a05:600c:1f81:b0:431:5465:807b with SMTP id
 5b1f17b1804b1-432832989c5mr86536975e9.32.1730710321737; 
 Mon, 04 Nov 2024 00:52:01 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf225sm145558805e9.11.2024.11.04.00.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 00:52:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, kwolf@redhat.com, marcandre.lureau@redhat.com,
 hreitz@redhat.com
Subject: [RFC PATCH] rust: add bindings for interrupt sources + interior
 mutability discussion
Date: Mon,  4 Nov 2024 09:51:59 +0100
Message-ID: <20241104085159.76841-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The InterruptSource bindings let us call qemu_set_irq() and
sysbus_init_irq() as safe code.  Apart from this, they are a good starting
point to think more about Rust shared/exclusive reference requirements
and what this means for QEMU.

Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
They are QOM link properties and can be written to outside the control
of the device (i.e. from a shared reference); therefore their Rust
representation must be an interior-mutable field.

But this actually applies to _all_ of the device struct!  Once a pointer
to the device has been handed out (for example via memory_region_init_io
or qdev_init_clock_in), accesses to the device struct must not use
&mut anymore.  It does not matter if C code handed you a *mut, such as
in a MemoryRegion or CharBackend callback: Rust disallows altogether
creating mutable references to data that has an active shared reference.
Instead, individual regions of the device must use cell types to make
_parts_ of the device structs mutable.

Back to interrupt sources, for now this patch uses a Cell, but this is
only an approximation of what is actually going on; a Cell can only
live within one thread, while here the semantics are "accessible by
multiple threads but only under the Big QEMU Lock".  It seems to me that
the way to go is for QEMU to provide its own "cell" types that check
locking rules with respect to the "Big QEMU Lock" or to ``AioContext``s.
For example, qemu_api::cell::Cell, which is for Copy types like
std::cell:Cell, would only allow get()/set() under BQL protection and
therefore could be Send/Sync.  Likewise, qemu_api::cell::RefCell would be
a RefCell that is Send/Sync, because it checks that borrow()/borrow_mut()
is only done under BQL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Do people think this is the right way forward for interior
	mutability?  Should these bindings be committed already with
	the FIXME comment, or should qemu_api::cell:Cell be written and
	committed first?  Should the implementation and use be split
	in separate patches or is the diff small enough?

 rust/hw/char/pl011/src/device.rs | 22 +++++++-----
 rust/qemu-api/meson.build        |  2 ++
 rust/qemu-api/src/irq.rs         | 61 ++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs         |  2 ++
 rust/qemu-api/src/sysbus.rs      | 26 ++++++++++++++
 5 files changed, 104 insertions(+), 9 deletions(-)
 create mode 100644 rust/qemu-api/src/irq.rs
 create mode 100644 rust/qemu-api/src/sysbus.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c05c2972716..bd6dc513bf6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,6 +13,7 @@
     c_str,
     definitions::ObjectImpl,
     device_class::TYPE_SYS_BUS_DEVICE,
+    irq::InterruptSource,
 };
 
 use crate::{
@@ -94,7 +95,7 @@ pub struct PL011State {
     ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
     /// ```
     #[doc(alias = "irq")]
-    pub interrupts: [qemu_irq; 6usize],
+    pub interrupts: [InterruptSource; IRQMASK.len()],
     #[doc(alias = "clk")]
     pub clock: NonNull<Clock>,
     #[doc(alias = "migrate_clk")]
@@ -139,7 +140,8 @@ impl PL011State {
     unsafe fn init(&mut self) {
         const CLK_NAME: &CStr = c_str!("clk");
 
-        let dev = addr_of_mut!(*self).cast::<DeviceState>();
+        let sbd = unsafe { &mut *(addr_of_mut!(*self).cast::<SysBusDevice>()) };
+
         // SAFETY:
         //
         // self and self.iomem are guaranteed to be valid at this point since callers
@@ -153,12 +155,15 @@ unsafe fn init(&mut self) {
                 Self::TYPE_INFO.name,
                 0x1000,
             );
-            let sbd = addr_of_mut!(*self).cast::<SysBusDevice>();
             sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
-            for irq in self.interrupts.iter_mut() {
-                sysbus_init_irq(sbd, irq);
-            }
         }
+
+        for irq in self.interrupts.iter() {
+            sbd.init_irq(irq);
+        }
+
+        let dev = addr_of_mut!(*self).cast::<DeviceState>();
+
         // SAFETY:
         //
         // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
@@ -498,8 +503,7 @@ pub fn put_fifo(&mut self, value: c_uint) {
     pub fn update(&self) {
         let flags = self.int_level & self.int_enabled;
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
-            // SAFETY: self.interrupts have been initialized in init().
-            unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)); }
+            irq.set(flags & i != 0);
         }
     }
 
@@ -526,7 +530,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
-pub const IRQMASK: [u32; 6] = [
+const IRQMASK: [u32; 6] = [
     /* combined IRQ */
     Interrupt::E
         | Interrupt::MS
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index e3870e901e3..a3a3d0101fd 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -13,7 +13,9 @@ _qemu_api_rs = static_library(
       'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/irq.rs',
       'src/offset_of.rs',
+      'src/sysbus.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
new file mode 100644
index 00000000000..813330ad802
--- /dev/null
+++ b/rust/qemu-api/src/irq.rs
@@ -0,0 +1,61 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use core::{cell::Cell, ptr};
+
+use crate::bindings::{qemu_set_irq, IRQState};
+
+/// Interrupt sources are used by devices to pass changes to a boolean value to
+/// other devices (typically interrupt or GPIO controllers).  QEMU interrupt
+/// sources are always active-high.
+///
+/// Interrupts are implemented as a pointer to the interrupt "sink", which has
+/// type [`IRQState`].  A device exposes its source as a QOM link property using
+/// a function such as
+/// [`SysBusDevice::init_irq`](crate::sysbus::SysBusDevice::init_irq), and
+/// initially leaves the pointer to a NULL value, representing an unconnected
+/// interrupt. To connect it, whoever creates the device fills the pointer with
+/// the sink's `IRQState *`, for example using `sysbus_connect_irq`.  Because
+/// devices are generally shared objects, interrupt sources are an example of
+/// the interior mutability pattern.
+///
+/// FIXME: Interrupt sources can only be triggered under the Big QEMU Lock, but
+/// they _are_ both `Send` and `Sync`.  `core::cell::Cell` does not capture that.
+#[derive(Debug)]
+pub struct InterruptSource(Cell<*mut IRQState>);
+
+impl InterruptSource {
+    /// Send a low (`false`) value to the interrupt sink.
+    pub fn lower(&self) {
+        self.set(false);
+    }
+
+    /// Send a high-low pulse to the interrupt sink.
+    pub fn pulse(&self) {
+        self.set(true);
+        self.set(false);
+    }
+
+    /// Send a high (`true`) value to the interrupt sink.
+    pub fn raise(&self) {
+        self.set(true);
+    }
+
+    /// Send `level` to the interrupt sink.
+    pub fn set(&self, level: bool) {
+        unsafe {
+            qemu_set_irq(self.0.get(), level as i32);
+        }
+    }
+
+    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
+        self.0.as_ptr()
+    }
+}
+
+impl Default for InterruptSource {
+    fn default() -> Self {
+        InterruptSource(Cell::new(ptr::null_mut()))
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 440aff3817d..fdda5f1d94f 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -10,7 +10,9 @@
 pub mod c_str;
 pub mod definitions;
 pub mod device_class;
+pub mod irq;
 pub mod offset_of;
+pub mod sysbus;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
new file mode 100644
index 00000000000..1a9b8a1f971
--- /dev/null
+++ b/rust/qemu-api/src/sysbus.rs
@@ -0,0 +1,26 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::ptr::addr_of;
+
+pub use bindings::{SysBusDevice, SysBusDeviceClass};
+
+use crate::{bindings, irq::InterruptSource};
+
+impl SysBusDevice {
+    /// Return `self` cast to a mutable pointer, for use in calls to C code.
+    const fn as_mut_ptr(&self) -> *mut SysBusDevice {
+        addr_of!(*self) as *mut _
+    }
+
+    /// Expose an interrupt source outside the device as a qdev GPIO output.
+    /// Note that the ordering of calls to `init_irq` is important, since
+    /// whoever creates the sysbus device will refer to the interrupts with
+    /// a number that corresponds to the order of calls to `init_irq`.
+    pub fn init_irq(&self, irq: &InterruptSource) {
+        unsafe {
+            bindings::sysbus_init_irq(self.as_mut_ptr(), irq.as_ptr());
+        }
+    }
+}
-- 
2.47.0


