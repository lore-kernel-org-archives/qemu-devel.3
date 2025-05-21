Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D3C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHefc-0004tj-M4; Wed, 21 May 2025 04:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefO-0004p1-Tw
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefC-0000AS-Dm
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvUeya4TNcUwgoPZj33+aR4D24x0qlLX7SAj8FdNXBQ=;
 b=h4trkLZvP103MBA0cQlHW9HYthawaqwyaVHPAtT+dt2GfOKajPU2Ue/UVPjUUKYwmDZuCA
 OVD30TduBYD5NcuK0pUuAlZ/rxesnbQM9jrKYWud6BF1MPWLAzkFBIfVY79ByFytGWrC85
 EEZ/8/JzV0HQYD3tlWSqiRDd+D5q2KY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-zRunBgQiNL2a_6eOQyLWyQ-1; Wed, 21 May 2025 04:18:54 -0400
X-MC-Unique: zRunBgQiNL2a_6eOQyLWyQ-1
X-Mimecast-MFC-AGG-ID: zRunBgQiNL2a_6eOQyLWyQ_1747815534
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so35327995e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815533; x=1748420333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvUeya4TNcUwgoPZj33+aR4D24x0qlLX7SAj8FdNXBQ=;
 b=rCp9BYwsC8U/J0TlUD6rYvo1G+hn6uIeDAfBCLgwLZ4eK8mSHX3dWZXwysyOSaoo2R
 k6uhgb3jkShd7YME1Mz6Oza23hZyl9XDPuGRHc2WZ5lRRyBTn3iIlJFwn6Rz+3VkqdEY
 A97CxC5/ZpwZ+XkKnD4xyQZeBc+7U02sup1dbDeethLl3x3rAiz2oj/zVLvT/gMQw/oQ
 AgInjRcL0gS2ZcddqGsPRAmzzpNK/RFFatem0jle1jCX20F8VysElRJWvq4tKYVlYxHR
 /yarNYYJOeFJvLab9soxBRpAvIcM1b0Vh8LPPNXM7ffCGxxUjU6Cgy8OxTY2U8b47/Lz
 gFUQ==
X-Gm-Message-State: AOJu0YweXr9jrTWNBz4B/OJVD8uVRsjPaEF4kqbOCgHRBb3nKSkUECBG
 3YJJlr3iNtjqrO+sdWCBodJ4uNx1kPdfmLeh5F7uXaTE7SKQI2wAwZu19Wyh0h29R5kdK0rfZc9
 xGW8AxW/YEaXb+twlf1QvslCDos/7uhRF/DgkWSfhrA9jEefllh382iD/DIpuaJ2YHmqBo41v5x
 1tPt3ROLPrIf3QlakXWQmm5mGwPYVxzVNm88xWOI2B
X-Gm-Gg: ASbGncsVHYln8xFkW7RcJQAYG0+eyhhnhfSG0SzhnMApjAGZyWa9p81hNARvZHSKkcs
 zsVrD1/eFlc3VlWZ+RR+NCRzpXYhwSxDsO5G+hsV/lR06qTk4D3kNcTwiRW+OKZ3hblOWOGhdUz
 8XVjlYI23aEgyjPMmEppv9UccO6qRUbQXDVBRxq0a4VV95E5bQyPqgO4ovXTEwNY1ocZIwmYt24
 k1MGVn7ha29WPO/TnJWmXNUTo7z0i1WVtO8uXluq6ruHCf1CCw1/XXlSXXuTQ8ZdiUeicSbXBHb
 14iAdAjEu2HZyg==
X-Received: by 2002:a05:600c:154b:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-442ff03c7ebmr141772995e9.33.1747815532544; 
 Wed, 21 May 2025 01:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSr4pzBy1XX8sKmCUrnbGxilzDfjYAPy6Afug8+TDre3jOzHh8kifNTVey5Nhkjy82ilnouw==
X-Received: by 2002:a05:600c:154b:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-442ff03c7ebmr141772735e9.33.1747815532098; 
 Wed, 21 May 2025 01:18:52 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4aa2sm61404105e9.21.2025.05.21.01.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:18:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 2/6] rust: pl011: use the bits macro
Date: Wed, 21 May 2025 10:18:41 +0200
Message-ID: <20250521081845.496442-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521081845.496442-1-pbonzini@redhat.com>
References: <20250521081845.496442-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This avoids the repeated ".0" when using the Interrupt struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                     |  1 +
 rust/hw/char/pl011/Cargo.toml       |  1 +
 rust/hw/char/pl011/meson.build      |  1 +
 rust/hw/char/pl011/src/device.rs    | 51 ++++++++++++++---------------
 rust/hw/char/pl011/src/registers.rs | 39 ++++++++++++----------
 5 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 0dfe0fb6ced..bccfe855a70 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -73,6 +73,7 @@ version = "0.1.0"
 dependencies = [
  "bilge",
  "bilge-impl",
+ "bits",
  "qemu_api",
  "qemu_api_macros",
 ]
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index a1f431ab4a3..003ef9613d4 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -18,6 +18,7 @@ crate-type = ["staticlib"]
 [dependencies]
 bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
+bits = { path = "../../../bits" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 547cca5a96f..f134a6cdc6b 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -12,6 +12,7 @@ _libpl011_rs = static_library(
   dependencies: [
     bilge_dep,
     bilge_impl_dep,
+    bits_rs,
     qemu_api,
     qemu_api_macros,
   ],
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bde3be65c5b..8d89c2448dc 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -85,8 +85,8 @@ pub struct PL011Registers {
     #[doc(alias = "cr")]
     pub control: registers::Control,
     pub dmacr: u32,
-    pub int_enabled: u32,
-    pub int_level: u32,
+    pub int_enabled: Interrupt,
+    pub int_level: Interrupt,
     pub read_fifo: Fifo,
     pub ilpr: u32,
     pub ibrd: u32,
@@ -199,9 +199,9 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
             LCR_H => u32::from(self.line_control),
             CR => u32::from(self.control),
             FLS => self.ifl,
-            IMSC => self.int_enabled,
-            RIS => self.int_level,
-            MIS => self.int_level & self.int_enabled,
+            IMSC => u32::from(self.int_enabled),
+            RIS => u32::from(self.int_level),
+            MIS => u32::from(self.int_level & self.int_enabled),
             ICR => {
                 // "The UARTICR Register is the interrupt clear register and is write-only"
                 // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register, UARTICR
@@ -263,13 +263,13 @@ pub(self) fn write(
                 self.set_read_trigger();
             }
             IMSC => {
-                self.int_enabled = value;
+                self.int_enabled = Interrupt::from(value);
                 return true;
             }
             RIS => {}
             MIS => {}
             ICR => {
-                self.int_level &= !value;
+                self.int_level &= !Interrupt::from(value);
                 return true;
             }
             DMACR => {
@@ -295,7 +295,7 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
             self.flags.set_receive_fifo_empty(true);
         }
         if self.read_count + 1 == self.read_trigger {
-            self.int_level &= !Interrupt::RX.0;
+            self.int_level &= !Interrupt::RX;
         }
         self.receive_status_error_clear.set_from_data(c);
         *update = true;
@@ -305,7 +305,7 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
     fn write_data_register(&mut self, value: u32) -> bool {
         // interrupts always checked
         let _ = self.loopback_tx(value.into());
-        self.int_level |= Interrupt::TX.0;
+        self.int_level |= Interrupt::TX;
         true
     }
 
@@ -361,19 +361,19 @@ fn loopback_mdmctrl(&mut self) -> bool {
         // Change interrupts based on updated FR
         let mut il = self.int_level;
 
-        il &= !Interrupt::MS.0;
+        il &= !Interrupt::MS;
 
         if self.flags.data_set_ready() {
-            il |= Interrupt::DSR.0;
+            il |= Interrupt::DSR;
         }
         if self.flags.data_carrier_detect() {
-            il |= Interrupt::DCD.0;
+            il |= Interrupt::DCD;
         }
         if self.flags.clear_to_send() {
-            il |= Interrupt::CTS.0;
+            il |= Interrupt::CTS;
         }
         if self.flags.ring_indicator() {
-            il |= Interrupt::RI.0;
+            il |= Interrupt::RI;
         }
         self.int_level = il;
         true
@@ -391,8 +391,8 @@ pub fn reset(&mut self) {
         self.line_control.reset();
         self.receive_status_error_clear.reset();
         self.dmacr = 0;
-        self.int_enabled = 0;
-        self.int_level = 0;
+        self.int_enabled = 0.into();
+        self.int_level = 0.into();
         self.ilpr = 0;
         self.ibrd = 0;
         self.fbrd = 0;
@@ -451,7 +451,7 @@ pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         }
 
         if self.read_count == self.read_trigger {
-            self.int_level |= Interrupt::RX.0;
+            self.int_level |= Interrupt::RX;
             return true;
         }
         false
@@ -632,7 +632,7 @@ fn update(&self) {
         let regs = self.regs.borrow();
         let flags = regs.int_level & regs.int_enabled;
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
-            irq.set(flags & i != 0);
+            irq.set(flags.any_set(i));
         }
     }
 
@@ -642,14 +642,13 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
-const IRQMASK: [u32; 6] = [
-    /* combined IRQ */
-    Interrupt::E.0 | Interrupt::MS.0 | Interrupt::RT.0 | Interrupt::TX.0 | Interrupt::RX.0,
-    Interrupt::RX.0,
-    Interrupt::TX.0,
-    Interrupt::RT.0,
-    Interrupt::MS.0,
-    Interrupt::E.0,
+const IRQMASK: [Interrupt; 6] = [
+    Interrupt::all(),
+    Interrupt::RX,
+    Interrupt::TX,
+    Interrupt::RT,
+    Interrupt::MS,
+    Interrupt::E,
 ];
 
 /// # Safety
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 690feb63785..7ececd39f86 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -9,7 +9,8 @@
 // https://developer.arm.com/documentation/ddi0183/latest/
 
 use bilge::prelude::*;
-use qemu_api::impl_vmstate_bitsized;
+use bits::bits;
+use qemu_api::{impl_vmstate_bitsized, impl_vmstate_forward};
 
 /// Offset of each register from the base memory address of the device.
 #[doc(alias = "offset")]
@@ -326,22 +327,24 @@ fn default() -> Self {
     }
 }
 
-/// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
-pub struct Interrupt(pub u32);
+bits! {
+    /// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
+    #[derive(Default)]
+    pub struct Interrupt(u32) {
+        OE = 1 << 10,
+        BE = 1 << 9,
+        PE = 1 << 8,
+        FE = 1 << 7,
+        RT = 1 << 6,
+        TX = 1 << 5,
+        RX = 1 << 4,
+        DSR = 1 << 3,
+        DCD = 1 << 2,
+        CTS = 1 << 1,
+        RI = 1 << 0,
 
-impl Interrupt {
-    pub const OE: Self = Self(1 << 10);
-    pub const BE: Self = Self(1 << 9);
-    pub const PE: Self = Self(1 << 8);
-    pub const FE: Self = Self(1 << 7);
-    pub const RT: Self = Self(1 << 6);
-    pub const TX: Self = Self(1 << 5);
-    pub const RX: Self = Self(1 << 4);
-    pub const DSR: Self = Self(1 << 3);
-    pub const DCD: Self = Self(1 << 2);
-    pub const CTS: Self = Self(1 << 1);
-    pub const RI: Self = Self(1 << 0);
-
-    pub const E: Self = Self(Self::OE.0 | Self::BE.0 | Self::PE.0 | Self::FE.0);
-    pub const MS: Self = Self(Self::RI.0 | Self::DSR.0 | Self::DCD.0 | Self::CTS.0);
+        E = bits!(Self as u32: OE | BE | PE | FE),
+        MS = bits!(Self as u32: RI | DSR | DCD | CTS),
+    }
 }
+impl_vmstate_forward!(Interrupt);
-- 
2.49.0


