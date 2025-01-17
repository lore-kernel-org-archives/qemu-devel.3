Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE75C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidM-0002aH-I8; Fri, 17 Jan 2025 04:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidL-0002a6-S0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidJ-0003RF-Is
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzzo+asbhdDSlPNru2mbn4dyMHJpm2dSBxjyr6Sulsg=;
 b=AXRl3+SPSVMfXPF97bbyCKa6L7031n/rgIDiWCupU9j9F+VgzfbRa/Iras+uKyNEiNVb75
 cRfO2XkiRs33z/xvuaB7x3hzv3anTEKUL3czAkfTOVWCOvsqZDhfJJ/H2uBnEdgviXgyZn
 C9DzBsyZEtUXLtyuGiL0zTRxAChG9ZU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-4GQxnvr2MaeoOvV4MaL1Rw-1; Fri, 17 Jan 2025 04:27:15 -0500
X-MC-Unique: 4GQxnvr2MaeoOvV4MaL1Rw-1
X-Mimecast-MFC-AGG-ID: 4GQxnvr2MaeoOvV4MaL1Rw
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3ded861f5so1760756a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106033; x=1737710833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzzo+asbhdDSlPNru2mbn4dyMHJpm2dSBxjyr6Sulsg=;
 b=AHb75BRyAdbocI9deX3kZEmkUn4DAWc3yH83UCSfKVEkFiV2Wo6Z/oHYEqhgoNR/oI
 WUMiwuSL8MNjS+RKU2vGIPH3RCeoD5g91zJ/keA6cZm5hYTCbJZEVKMVOjYyd/szIYKO
 IAQ9WltyH4vR2lapgMyPpIANG+MygSpge/u2zklhOfkwCjgJmJ42lrtwboH59C1QU3od
 SQiYJWqIugiK0/8SsMZLKBM0zES5vuLSxd+cH6mZDzAWM297Oz5MqhFKHgCWkt52wAts
 NqzsLb4ewhLhssxk5CnowFrMFSNQPgPgLMX+M/G7qq0LQQWRkk3lksnnX4Xd2R4dlusH
 HVJA==
X-Gm-Message-State: AOJu0YwPBJi+v7tGuxOmQTbyMZN+bbgx8Ns8Kiu6yrhOsazNGtUe93bB
 VW2UFLWZYvxOrBggFyk8vHsvSBe5x6uklVflqfj0xh4V5zlg8X7GEgitDy23MvStxs5GQWT4ogD
 b3fkU4A40O3xKV+nH+Ou+SN8az3RfcWTEt8um3l7wpxEuSqivijMXrasTYTvER550GBdPvYIzzt
 p2JuaQv/xVLlq4Ric/lGuFDtHOy6wtgL54wE6BynU=
X-Gm-Gg: ASbGncv2RVw90Tx7icpuUdd/621pvh169e0bOFHiLYsVzGIgf0/E6bKOjC+lkhy9EHJ
 7OxJnuYYai9WHKtElHbmBIEKAOMG2dDBet1q2kV/YvtHHIq1fsa7yRtTapjQ+N23JFKmn09YWB0
 YZWgtK6ycAo4Tl++aHnc4kC16Dpy99bODvIDBdgYPVfvBATnd9q9EOWoJWpAIptioPPYarkKWWE
 DgNegAiSnKCFpKpspZqUSogG49/+/f9XYjdEPuNH3a65DuVgdPRYrI+x20r
X-Received: by 2002:a05:6402:1ed0:b0:5d9:fa36:5969 with SMTP id
 4fb4d7f45d1cf-5db7db139a6mr1295491a12.21.1737106032808; 
 Fri, 17 Jan 2025 01:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAAgAI3k17nYAtQJWUbdu7w6DjDAshtr+7w8oIUAkDSwu59XMws22hfBfHrQ7Aw45OLZTjiQ==
X-Received: by 2002:a05:6402:1ed0:b0:5d9:fa36:5969 with SMTP id
 4fb4d7f45d1cf-5db7db139a6mr1295467a12.21.1737106032227; 
 Fri, 17 Jan 2025 01:27:12 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db736716d6sm1214485a12.31.2025.01.17.01.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 06/10] rust: pl011: extract PL011Registers
Date: Fri, 17 Jan 2025 10:26:53 +0100
Message-ID: <20250117092657.1051233-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117092657.1051233-1-pbonzini@redhat.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

Pull all the mutable fields of PL011State into a separate struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 251 ++++++++++++++-----------
 rust/hw/char/pl011/src/device_class.rs |  46 +++--
 2 files changed, 168 insertions(+), 129 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 67c3e63baa1..476abe765a9 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -78,11 +78,8 @@ fn index(&self, idx: u32) -> &Self::Output {
 }
 
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
-/// PL011 Device Model in QEMU
-pub struct PL011State {
-    pub parent_obj: ParentField<SysBusDevice>,
-    pub iomem: MemoryRegion,
+#[derive(Debug, Default, qemu_api_macros::offsets)]
+pub struct PL011Registers {
     #[doc(alias = "fr")]
     pub flags: registers::Flags,
     #[doc(alias = "lcr")]
@@ -102,8 +99,17 @@ pub struct PL011State {
     pub read_pos: u32,
     pub read_count: u32,
     pub read_trigger: u32,
+}
+
+#[repr(C)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
+/// PL011 Device Model in QEMU
+pub struct PL011State {
+    pub parent_obj: ParentField<SysBusDevice>,
+    pub iomem: MemoryRegion,
     #[doc(alias = "chr")]
     pub char_backend: CharBackend,
+    pub regs: PL011Registers,
     /// QEMU interrupts
     ///
     /// ```text
@@ -161,61 +167,8 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     const RESET: Option<fn(&mut Self)> = Some(Self::reset);
 }
 
-impl PL011State {
-    /// Initializes a pre-allocated, unitialized instance of `PL011State`.
-    ///
-    /// # Safety
-    ///
-    /// `self` must point to a correctly sized and aligned location for the
-    /// `PL011State` type. It must not be called more than once on the same
-    /// location/instance. All its fields are expected to hold unitialized
-    /// values with the sole exception of `parent_obj`.
-    unsafe fn init(&mut self) {
-        const CLK_NAME: &CStr = c_str!("clk");
-
-        // SAFETY:
-        //
-        // self and self.iomem are guaranteed to be valid at this point since callers
-        // must make sure the `self` reference is valid.
-        unsafe {
-            memory_region_init_io(
-                addr_of_mut!(self.iomem),
-                addr_of_mut!(*self).cast::<Object>(),
-                &PL011_OPS,
-                addr_of_mut!(*self).cast::<c_void>(),
-                Self::TYPE_NAME.as_ptr(),
-                0x1000,
-            );
-        }
-
-        // SAFETY:
-        //
-        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
-        // we can overwrite the undefined value without side effects. This is
-        // safe since all PL011State instances are created by QOM code which
-        // calls this function to initialize the fields; therefore no code is
-        // able to access an invalid self.clock value.
-        unsafe {
-            let dev: &mut DeviceState = self.upcast_mut();
-            self.clock = NonNull::new(qdev_init_clock_in(
-                dev,
-                CLK_NAME.as_ptr(),
-                None, /* pl011_clock_update */
-                addr_of_mut!(*self).cast::<c_void>(),
-                ClockEvent::ClockUpdate.0,
-            ))
-            .unwrap();
-        }
-    }
-
-    fn post_init(&self) {
-        self.init_mmio(&self.iomem);
-        for irq in self.interrupts.iter() {
-            self.init_irq(irq);
-        }
-    }
-
-    fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
+impl PL011Registers {
+    pub(self) fn read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
         use RegisterOffset::*;
 
         std::ops::ControlFlow::Break(match offset {
@@ -257,7 +210,12 @@ fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
         })
     }
 
-    fn regs_write(&mut self, offset: RegisterOffset, value: u32) -> bool {
+    pub(self) fn write(
+        &mut self,
+        offset: RegisterOffset,
+        value: u32,
+        char_backend: *mut CharBackend,
+    ) -> bool {
         // eprintln!("write offset {offset} value {value}");
         use RegisterOffset::*;
         match offset {
@@ -267,10 +225,10 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) -> bool {
                 // XXX this blocks entire thread. Rewrite to use
                 // qemu_chr_fe_write and background I/O callbacks
 
-                // SAFETY: self.char_backend is a valid CharBackend instance after it's been
+                // SAFETY: char_backend is a valid CharBackend instance after it's been
                 // initialized in realize().
                 unsafe {
-                    qemu_chr_fe_write_all(addr_of_mut!(self.char_backend), &ch, 1);
+                    qemu_chr_fe_write_all(char_backend, &ch, 1);
                 }
                 // interrupts always checked
                 let _ = self.loopback_tx(value);
@@ -305,7 +263,7 @@ fn regs_write(&mut self, offset: RegisterOffset, value: u32) -> bool {
                     // initialized in realize().
                     unsafe {
                         qemu_chr_fe_ioctl(
-                            addr_of_mut!(self.char_backend),
+                            char_backend,
                             CHR_IOCTL_SERIAL_SET_BREAK as i32,
                             addr_of_mut!(break_enable).cast::<c_void>(),
                         );
@@ -424,23 +382,6 @@ fn set_read_trigger(&mut self) {
         self.read_trigger = 1;
     }
 
-    pub fn realize(&mut self) {
-        // SAFETY: self.char_backend has the correct size and alignment for a
-        // CharBackend object, and its callbacks are of the correct types.
-        unsafe {
-            qemu_chr_fe_set_handlers(
-                addr_of_mut!(self.char_backend),
-                Some(pl011_can_receive),
-                Some(pl011_receive),
-                Some(pl011_event),
-                None,
-                addr_of_mut!(*self).cast::<c_void>(),
-                core::ptr::null_mut(),
-                true,
-            );
-        }
-    }
-
     pub fn reset(&mut self) {
         self.line_control.reset();
         self.receive_status_error_clear.reset();
@@ -473,26 +414,6 @@ pub fn reset_tx_fifo(&mut self) {
         self.flags.set_transmit_fifo_empty(true);
     }
 
-    pub fn can_receive(&self) -> bool {
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        self.read_count < self.fifo_depth()
-    }
-
-    pub fn receive(&mut self, ch: u32) {
-        if !self.loopback_enabled() && self.put_fifo(ch) {
-            self.update();
-        }
-    }
-
-    pub fn event(&mut self, event: QEMUChrEvent) {
-        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
-            let update = self.put_fifo(registers::Data::BREAK.into());
-            if update {
-                self.update();
-            }
-        }
-    }
-
     #[inline]
     pub fn fifo_enabled(&self) -> bool {
         self.line_control.fifos_enabled() == registers::Mode::FIFO
@@ -531,14 +452,7 @@ pub fn put_fifo(&mut self, value: u32) -> bool {
         false
     }
 
-    pub fn update(&self) {
-        let flags = self.int_level & self.int_enabled;
-        for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
-            irq.set(flags & i != 0);
-        }
-    }
-
-    pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
+    pub fn post_load(&mut self) -> Result<(), ()> {
         /* Sanity-check input state */
         if self.read_pos >= self.read_fifo.len() || self.read_count > self.read_fifo.len() {
             return Err(());
@@ -558,8 +472,66 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 
         Ok(())
     }
+}
+
+impl PL011State {
+    /// Initializes a pre-allocated, unitialized instance of `PL011State`.
+    ///
+    /// # Safety
+    ///
+    /// `self` must point to a correctly sized and aligned location for the
+    /// `PL011State` type. It must not be called more than once on the same
+    /// location/instance. All its fields are expected to hold unitialized
+    /// values with the sole exception of `parent_obj`.
+    unsafe fn init(&mut self) {
+        const CLK_NAME: &CStr = c_str!("clk");
+
+        // SAFETY:
+        //
+        // self and self.iomem are guaranteed to be valid at this point since callers
+        // must make sure the `self` reference is valid.
+        unsafe {
+            memory_region_init_io(
+                addr_of_mut!(self.iomem),
+                addr_of_mut!(*self).cast::<Object>(),
+                &PL011_OPS,
+                addr_of_mut!(*self).cast::<c_void>(),
+                Self::TYPE_NAME.as_ptr(),
+                0x1000,
+            );
+        }
+
+        self.regs = Default::default();
+
+        // SAFETY:
+        //
+        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
+        // we can overwrite the undefined value without side effects. This is
+        // safe since all PL011State instances are created by QOM code which
+        // calls this function to initialize the fields; therefore no code is
+        // able to access an invalid self.clock value.
+        unsafe {
+            let dev: &mut DeviceState = self.upcast_mut();
+            self.clock = NonNull::new(qdev_init_clock_in(
+                dev,
+                CLK_NAME.as_ptr(),
+                None, /* pl011_clock_update */
+                addr_of_mut!(*self).cast::<c_void>(),
+                ClockEvent::ClockUpdate.0,
+            ))
+            .unwrap();
+        }
+    }
+
+    fn post_init(&self) {
+        self.init_mmio(&self.iomem);
+        for irq in self.interrupts.iter() {
+            self.init_irq(irq);
+        }
+    }
 
     pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
+        let regs = &mut self.regs;
         match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
@@ -569,7 +541,7 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
                 ControlFlow::Break(0)
             }
-            Ok(field) => match self.regs_read(field) {
+            Ok(field) => match regs.read(field) {
                 ControlFlow::Break(value) => ControlFlow::Break(value.into()),
                 ControlFlow::Continue(value) => {
                     self.update();
@@ -580,14 +552,71 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
+        let regs = &mut self.regs;
         if let Ok(field) = RegisterOffset::try_from(offset) {
-            if self.regs_write(field, value as u32) {
+            if regs.write(field, value as u32, &mut self.char_backend) {
                 self.update();
             }
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
     }
+
+    pub fn can_receive(&self) -> bool {
+        // trace_pl011_can_receive(s->lcr, s->read_count, r);
+        let regs = &self.regs;
+        regs.read_count < regs.fifo_depth()
+    }
+
+    pub fn receive(&mut self, ch: u32) {
+        let regs = &mut self.regs;
+        if !regs.loopback_enabled() && regs.put_fifo(ch) {
+            self.update();
+        }
+    }
+
+    pub fn event(&mut self, event: QEMUChrEvent) {
+        let regs = &mut self.regs;
+        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !regs.loopback_enabled() {
+            let update = regs.put_fifo(registers::Data::BREAK.into());
+            if update {
+                self.update()
+            }
+        }
+    }
+
+    pub fn realize(&mut self) {
+        // SAFETY: self.char_backend has the correct size and alignment for a
+        // CharBackend object, and its callbacks are of the correct types.
+        unsafe {
+            qemu_chr_fe_set_handlers(
+                addr_of_mut!(self.char_backend),
+                Some(pl011_can_receive),
+                Some(pl011_receive),
+                Some(pl011_event),
+                None,
+                addr_of_mut!(*self).cast::<c_void>(),
+                core::ptr::null_mut(),
+                true,
+            );
+        }
+    }
+
+    pub fn reset(&mut self) {
+        self.regs.reset();
+    }
+
+    pub fn update(&self) {
+        let regs = &self.regs;
+        let flags = regs.int_level & regs.int_enabled;
+        for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
+            irq.set(flags & i != 0);
+        }
+    }
+
+    pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
+        self.regs.post_load()
+    }
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 2fd805fd12d..e25645ceb0d 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -6,11 +6,11 @@
 use std::os::raw::{c_int, c_void};
 
 use qemu_api::{
-    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of, vmstate_subsections,
-    vmstate_unused, zeroable::Zeroable,
+    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
+    vmstate_subsections, vmstate_unused, zeroable::Zeroable,
 };
 
-use crate::device::PL011State;
+use crate::device::{PL011Registers, PL011State};
 
 extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     unsafe {
@@ -45,6 +45,30 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     }
 }
 
+static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
+    name: c_str!("pl011").as_ptr(),
+    version_id: 2,
+    minimum_version_id: 2,
+    fields: vmstate_fields! {
+        vmstate_of!(PL011Registers, flags),
+        vmstate_of!(PL011Registers, line_control),
+        vmstate_of!(PL011Registers, receive_status_error_clear),
+        vmstate_of!(PL011Registers, control),
+        vmstate_of!(PL011Registers, dmacr),
+        vmstate_of!(PL011Registers, int_enabled),
+        vmstate_of!(PL011Registers, int_level),
+        vmstate_of!(PL011Registers, read_fifo),
+        vmstate_of!(PL011Registers, ilpr),
+        vmstate_of!(PL011Registers, ibrd),
+        vmstate_of!(PL011Registers, fbrd),
+        vmstate_of!(PL011Registers, ifl),
+        vmstate_of!(PL011Registers, read_pos),
+        vmstate_of!(PL011Registers, read_count),
+        vmstate_of!(PL011Registers, read_trigger),
+    },
+    ..Zeroable::ZERO
+};
+
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
     name: c_str!("pl011").as_ptr(),
     version_id: 2,
@@ -52,21 +76,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     post_load: Some(pl011_post_load),
     fields: vmstate_fields! {
         vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_of!(PL011State, flags),
-        vmstate_of!(PL011State, line_control),
-        vmstate_of!(PL011State, receive_status_error_clear),
-        vmstate_of!(PL011State, control),
-        vmstate_of!(PL011State, dmacr),
-        vmstate_of!(PL011State, int_enabled),
-        vmstate_of!(PL011State, int_level),
-        vmstate_of!(PL011State, read_fifo),
-        vmstate_of!(PL011State, ilpr),
-        vmstate_of!(PL011State, ibrd),
-        vmstate_of!(PL011State, fbrd),
-        vmstate_of!(PL011State, ifl),
-        vmstate_of!(PL011State, read_pos),
-        vmstate_of!(PL011State, read_count),
-        vmstate_of!(PL011State, read_trigger),
+        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, PL011Registers),
     },
     subsections: vmstate_subsections! {
         VMSTATE_PL011_CLOCK
-- 
2.47.1


