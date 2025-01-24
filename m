Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBD0C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHv-0003ii-GS; Fri, 24 Jan 2025 04:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGT-0007rL-6G
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGQ-0003zZ-Fs
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnYPmmzbHtO9VYxLsF7WeRrLBt7TIDcweZucQbIAULs=;
 b=bcpQ9EBOhXBq7pT0Nn4/Di/gdwxx/QAZmUGOvDRxBpHL0QEUxTgoUVgDL0n1+17r8dIpik
 e84PubB7gxwxMQbWKIXjOkibVxnroFUNFlIiBum6z+iLxSo5JuvVyIlFeXZvBMMT+AU4z6
 OcQZmPoypXIMY8z1WqzcR9779PMmhG4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-aQMRFyNBPOWxMDhjRNLCnA-1; Fri, 24 Jan 2025 04:46:08 -0500
X-MC-Unique: aQMRFyNBPOWxMDhjRNLCnA-1
X-Mimecast-MFC-AGG-ID: aQMRFyNBPOWxMDhjRNLCnA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436225d4389so14625265e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711966; x=1738316766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnYPmmzbHtO9VYxLsF7WeRrLBt7TIDcweZucQbIAULs=;
 b=Xy83KKrg2K+fvQh+swHWx6lyVtOMsBzFd4LgPE1dYvebFSoY8r23bjlxLnLeP5kPd9
 RJM0xDcSAKyHoKwxMF/f9heumD2USeuXCoiz/gpd2XBl6rSoxNunhJX/HXnKL4x2Gwq2
 X+CHrnqXGd8w4A/ze4LimJQ4hkq8z3c0DHCgCHQj3b5AMCQnnTkqbm8vcSOSzCPDG0UZ
 POgEscQIq1DyzmsRZHLmjxnmjpDOHKEsPJkGWElRXDl2SGDsGyQbtm6jj9w83RqFp5vR
 M2Ej1HpQch8fZC4ci+/evmBRjHYpJQZPFbMUjnvkfW0oj+pf8Bv0ZCqF3sMGHJvFUJFv
 qEpw==
X-Gm-Message-State: AOJu0Yw7IYz1CyghzM0y2H+ZJeEy14bNOW9u7jy4DQ4WNUy4UZZlBInq
 jYP5GGMOwRNBcAiQjzpfxAPzYalLC4odMQ3FGHZr+aEZJUPk76LUtoiseH/bSgg59QX34IM79rs
 70a/cB1g0uW03F7ZMWdiUo8VoJtD6BQ60fXtfeQNRJDkHvWHUSNYrIA8mFl8Rd1nIX/cmE2l9zB
 BqOkGEpYaLnWorzV5+k+y0nYBlkCZEgcMde+Wd4x4=
X-Gm-Gg: ASbGncs8f9EoRWpil+uX4iVVsNq5IhWkklt0gjQA/V5oWMB/aWb4jeB+HEUwacf2Ugk
 YrXQI+kgIV47NaIxyClVsAfjNSpSSlu3d57vDXG/XEwx6E1O4Ns5t2GrE95EsV5RA2pH3RBOT+Q
 6kDB7lPU6ZK2tEkXgpRm89/vACg36gluQgUq8nUtceg0WsnUZjPjFhu19V8rPGIlcNi9imeugLE
 XKS2ezqtrcGy9pwC9cao9MUa4rBW6TL0Uhm5au7hsn/7fw+MileL26m0FaD4Sy5uGOH8EOXyg==
X-Received: by 2002:a05:600c:58c9:b0:436:e3ea:64dd with SMTP id
 5b1f17b1804b1-438bd0a88dbmr22948015e9.11.1737711966482; 
 Fri, 24 Jan 2025 01:46:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXene5jhJddv0rJmibbIevqjM3Q7qVX6fnc4nuI5ZR4uq6NX3kd8xFBwOws2RK1dhn7pKf5Q==
X-Received: by 2002:a05:600c:58c9:b0:436:e3ea:64dd with SMTP id
 5b1f17b1804b1-438bd0a88dbmr22947645e9.11.1737711965962; 
 Fri, 24 Jan 2025 01:46:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9990sm20855065e9.29.2025.01.24.01.46.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/48] rust: pl011: wrap registers with BqlRefCell
Date: Fri, 24 Jan 2025 10:44:36 +0100
Message-ID: <20250124094442.13207-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a step towards making memory ops use a shared reference to the
device type; it's not yet possible due to the calls to character device
functions.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 40 ++++++++++++++------------
 rust/hw/char/pl011/src/device_class.rs |  8 +++---
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f1319d1a8bd..4fd9bdc8584 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -109,14 +109,14 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
     pub iomem: MemoryRegion,
     #[doc(alias = "chr")]
     pub char_backend: CharBackend,
-    pub regs: PL011Registers,
+    pub regs: BqlRefCell<PL011Registers>,
     /// QEMU interrupts
     ///
     /// ```text
@@ -538,6 +538,7 @@ fn post_init(&self) {
         }
     }
 
+    #[allow(clippy::needless_pass_by_ref_mut)]
     pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
         let mut update_irq = false;
         let result = match RegisterOffset::try_from(offset) {
@@ -549,7 +550,7 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
                 ControlFlow::Break(0)
             }
-            Ok(field) => match self.regs.read(field) {
+            Ok(field) => match self.regs.borrow_mut().read(field) {
                 ControlFlow::Break(value) => ControlFlow::Break(value.into()),
                 ControlFlow::Continue(value) => {
                     update_irq = true;
@@ -566,7 +567,10 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
     pub fn write(&mut self, offset: hwaddr, value: u64) {
         let mut update_irq = false;
         if let Ok(field) = RegisterOffset::try_from(offset) {
-            update_irq = self.regs.write(field, value as u32, &mut self.char_backend);
+            update_irq = self
+                .regs
+                .borrow_mut()
+                .write(field, value as u32, &mut self.char_backend);
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
@@ -577,21 +581,21 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
 
     pub fn can_receive(&self) -> bool {
         // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        let regs = &self.regs;
+        let regs = self.regs.borrow();
         regs.read_count < regs.fifo_depth()
     }
 
-    pub fn receive(&mut self, ch: u32) {
-        let regs = &mut self.regs;
+    pub fn receive(&self, ch: u32) {
+        let mut regs = self.regs.borrow_mut();
         let update_irq = !regs.loopback_enabled() && regs.put_fifo(ch);
         if update_irq {
             self.update();
         }
     }
 
-    pub fn event(&mut self, event: QEMUChrEvent) {
+    pub fn event(&self, event: QEMUChrEvent) {
         let mut update_irq = false;
-        let regs = &mut self.regs;
+        let mut regs = self.regs.borrow_mut();
         if event == QEMUChrEvent::CHR_EVENT_BREAK && !regs.loopback_enabled() {
             update_irq = regs.put_fifo(registers::Data::BREAK.into());
         }
@@ -618,19 +622,19 @@ pub fn realize(&self) {
     }
 
     pub fn reset(&mut self) {
-        self.regs.reset();
+        self.regs.borrow_mut().reset();
     }
 
     pub fn update(&self) {
-        let regs = &self.regs;
+        let regs = self.regs.borrow();
         let flags = regs.int_level & regs.int_enabled;
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
             irq.set(flags & i != 0);
         }
     }
 
-    pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
-        self.regs.post_load()
+    pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
+        self.regs.borrow_mut().post_load()
     }
 }
 
@@ -667,11 +671,11 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 ///
 /// The buffer and size arguments must also be valid.
 pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8, size: c_int) {
-    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
     unsafe {
         if size > 0 {
             debug_assert!(!buf.is_null());
-            state.as_mut().receive(u32::from(buf.read_volatile()));
+            state.as_ref().receive(u32::from(buf.read_volatile()));
         }
     }
 }
@@ -682,8 +686,8 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
 pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEvent) {
-    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_mut().event(event) }
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_ref().event(event) }
 }
 
 /// # Safety
@@ -708,7 +712,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 }
 
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
+#[derive(qemu_api_macros::Object)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index d94b98de7bb..8a157a663fb 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -6,7 +6,7 @@
 use std::os::raw::{c_int, c_void};
 
 use qemu_api::{
-    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
+    bindings::*, c_str, prelude::*, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
     vmstate_subsections, vmstate_unused, zeroable::Zeroable,
 };
 
@@ -31,8 +31,8 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
 };
 
 extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
-    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    let result = unsafe { state.as_mut().post_load(version_id as u32) };
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    let result = unsafe { state.as_ref().post_load(version_id as u32) };
     if result.is_err() {
         -1
     } else {
@@ -71,7 +71,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     post_load: Some(pl011_post_load),
     fields: vmstate_fields! {
         vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, PL011Registers),
+        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
     },
     subsections: vmstate_subsections! {
         VMSTATE_PL011_CLOCK
-- 
2.48.1


