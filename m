Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA672C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 11:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td6Ei-0000cM-Jd; Wed, 29 Jan 2025 06:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td6Ed-0000bL-Ox
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 06:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td6Ea-0005gQ-V2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 06:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738150070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvX7KkwjwfyMYAQIhTbOqeVVBOy7GQEsIWLfcqKRV64=;
 b=NihPoemIFyEzma2MqrUV4mnD62O/dmF5F0MfG+Axt0uJRaCDzZjlxBsv8vbnJZ5df1KphT
 V/GSXX9BoNlfZDnG1VPbrflCkuYAWaTfVqa3DIxin1QS/Dzn7k/Qmwuh2vguEGybe52STO
 oR8XAiU2REozkmJSUJR20uo7ILOQEr8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-q8sZh8VbOr60Zi3Ja4iCGg-1; Wed, 29 Jan 2025 06:27:49 -0500
X-MC-Unique: q8sZh8VbOr60Zi3Ja4iCGg-1
X-Mimecast-MFC-AGG-ID: q8sZh8VbOr60Zi3Ja4iCGg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38c24cd6823so347734f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 03:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738150067; x=1738754867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvX7KkwjwfyMYAQIhTbOqeVVBOy7GQEsIWLfcqKRV64=;
 b=JpWblfIiWWUQCcy1DWM4UwV0GABrvSvbjhN405msG68tBnMDHcAQqb2qwVeiwbvWJW
 IRrD2F7Ly+3KHkTd8yN/mYCyth8kiV7wn01KvOFib98ICxp9oaIrCT5nYdNDA1Ki7wO6
 x+HLQWCI3dzGbfTHD2Gjf9DDnXa3/p7rwF9aGv60H4awZItQhPSsp6HylCp2oBWaM430
 gm/gG+qhGgg2O5Ech6VgQlROvdaq+0Btxdme1D0ECH11YpmStNyzk0g2zbFI2z5EwaAj
 0VcnL7stXuszLGIatlAJBg/kYrTapNXGO4IJTSj8xmC1c4tadNriN3bU8BRPv+u+YkyF
 OLDw==
X-Gm-Message-State: AOJu0YxNZZHx84J34Bh3x/M+kaUYg9Un53nr06T0cQm+tandsbkQ7Alx
 Ui7BaaTqH/Yx7XkGFmPZFqIy8nspKxyd4vklCxkfM+icECq7p5BuByHHmGe5m0D4rkTu33C/dcM
 9P0b4H5RXBmiHJgHA4tDYNk0HM0yyIhnmFb7XBsSFC27W9a5Dg/pUILwpLX3926qIFyhkabz6GB
 Xhc2r8SNDexJ2pOLrGmO1WBe2aFdpRkUiowwO5KAU=
X-Gm-Gg: ASbGnctx1qG8ATTilkUcIXOsmiFS0vNvZgcYTuoScYVH+vmXsv4iSVKbCpROiecguoO
 wrDKtSIPy+vg4QPUH9G5m5bp0yzonXQLf4Jcf/iezDbI8LYwdRv0r34K/KDFynzPigDcLOeWkzX
 LwyFYehw58xVInGCbxYG7md9px/q3Odkcml4ZEyBRVAI4t6y1v6sD4qJpD7nPtq1k3ErMfe2zs7
 8FiKwOeXxXLSiqDlx1DXxdmRYaxSZpKww+8Z3bLXwTZmxRvfduN7P96Mk8xcSW32Y5n11r+kK96
 i0BCaQ==
X-Received: by 2002:a5d:47c8:0:b0:38a:5d7d:4bd6 with SMTP id
 ffacd0b85a97d-38c51079cdcmr2575794f8f.25.1738150067029; 
 Wed, 29 Jan 2025 03:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/6zvFLxULWh+aonZOkqNwL/5oWgru7y2U30PHEZ9iF1mG/cGqf9ZP3Bb4Ivg2muKipCAhig==
X-Received: by 2002:a5d:47c8:0:b0:38a:5d7d:4bd6 with SMTP id
 ffacd0b85a97d-38c51079cdcmr2575766f8f.25.1738150066480; 
 Wed, 29 Jan 2025 03:27:46 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6edsm16515811f8f.40.2025.01.29.03.27.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 03:27:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/49] rust: pl011: wrap registers with BqlRefCell
Date: Wed, 29 Jan 2025 12:27:42 +0100
Message-ID: <20250129112743.1348764-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129112743.1348764-1-pbonzini@redhat.com>
References: <20250129112743.1348764-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 rust/hw/char/pl011/src/device.rs       | 46 ++++++++++++++++----------
 rust/hw/char/pl011/src/device_class.rs |  8 ++---
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 91c71d0989a..861b8645b76 100644
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
@@ -528,6 +528,7 @@ fn post_init(&self) {
         }
     }
 
+    #[allow(clippy::needless_pass_by_ref_mut)]
     pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
         let mut update_irq = false;
         let result = match RegisterOffset::try_from(offset) {
@@ -539,7 +540,7 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
                 ControlFlow::Break(0)
             }
-            Ok(field) => match self.regs.read(field) {
+            Ok(field) => match self.regs.borrow_mut().read(field) {
                 ControlFlow::Break(value) => ControlFlow::Break(value.into()),
                 ControlFlow::Continue(value) => {
                     update_irq = true;
@@ -570,7 +571,10 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 }
             }
 
-            update_irq = self.regs.write(field, value as u32, &mut self.char_backend);
+            update_irq = self
+                .regs
+                .borrow_mut()
+                .write(field, value as u32, &mut self.char_backend);
         } else {
             eprintln!("write bad offset {offset} value {value}");
         }
@@ -581,24 +585,30 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
 
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
+        // Release the BqlRefCell before calling self.update()
+        drop(regs);
+
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
+        // Release the BqlRefCell before calling self.update()
+        drop(regs);
+
         if update_irq {
             self.update()
         }
@@ -622,19 +632,19 @@ pub fn realize(&self) {
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
 
@@ -671,11 +681,11 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
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
@@ -686,8 +696,8 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
 pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEvent) {
-    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_mut().event(event) }
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_ref().event(event) }
 }
 
 /// # Safety
@@ -712,7 +722,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
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


