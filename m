Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E177D68BF0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 22:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCR7H-0005zm-MG; Sat, 16 Nov 2024 17:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCR7G-0005zK-Gn
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 17:18:06 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tCR7C-0000oI-S3
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 17:18:06 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so16777765e9.0
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 14:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731795481; x=1732400281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=90Z+uTvpepQAFzVHsVOwH1Xe3Nr8l4nE4g3HPoVibmQ=;
 b=LNQhZ9jKcWpZ3v+o2Kn0Kz4hIEQcfCl/liixdXrNiW9FJRZncJXe8e6DIuh3rPkTev
 6UiG3pMZKfuFH+32BrCIjmxfQSYfquiZBFFYSNLJJugNDm4z96Ywk2oYdHscChFywQ7s
 rs7QNUHM6f4cHm/WwVg0NNb5bAlBt6MIL53lA5aijOP1pg2l1Cbm2dmp18DwQHXthdBo
 7mO1XzJJNfYbrJvMe7MLlBuby7MFyo9UBRsoB7Xs5lNzTS1MWctMuyxeFN1TNbMwdpKv
 dBDJeJzdG7okg1fYLipTLjizC6LW5Q6N+tWbeWy4eWJcVKCUAEQ4Hb2EU7slMrvG5PH8
 ZzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731795481; x=1732400281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90Z+uTvpepQAFzVHsVOwH1Xe3Nr8l4nE4g3HPoVibmQ=;
 b=QV+pqfUeE4WERSRmcuIA4DMEqf0vSX2ftFzSSpo8n7L7PeeC8ra9zhEcenW6Vpw9HL
 KUuMEcXBnWCbmvJpG/q+7KT/ACispcOfolzGwBofqFZNHlDDpKtPvgpY7SW6hpoSYI2O
 e9ztrCUmkAvKhghr8EQmZb+5LCsYgSlKkjhprisIrLIqgOyqOQrqxxdah4PbGfPJsSOO
 03oZDGug9Uvd/9JvfVj7btcxXPHhGSsGoVEsePkRRo5R75o5NV6f7OWyc2rDg2dPxX6s
 BBbv+z0eT3omvd/t6irQGLDrq681nrvvhdWeoyTyugtcBz32i+F48Cw7NSF7CHGF+gvS
 F5bQ==
X-Gm-Message-State: AOJu0Yzfq8JLKg66pZnPpfX5B+v1paqpFfukq1RHC1uP0OerXwKOC50y
 tsEYj4uEk4+rOt89qGa6ZyjeecYx3LlLZOHLV7k44MaXmx6gPNGqe08ZrWuUKyZEs3NRxauYJ0/
 4rs4=
X-Google-Smtp-Source: AGHT+IE5Je1M/0sWbe3jl0H2L89jhWdgktlP6oktsPYUPJQBrF5vkAjkUnrY+zUFiUy0aJXZUd3HaA==
X-Received: by 2002:a05:600c:3c9e:b0:431:52da:9d89 with SMTP id
 5b1f17b1804b1-432defc8b2bmr66927325e9.1.1731795480613; 
 Sat, 16 Nov 2024 14:18:00 -0800 (PST)
Received: from localhost.localdomain (adsl-99.109.242.224.tellas.gr.
 [109.242.224.99]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28b76fsm105752685e9.28.2024.11.16.14.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 14:18:00 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] rust/pl011: Fix DeviceID reads
Date: Sun, 17 Nov 2024 00:17:56 +0200
Message-ID: <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

DeviceId, which maps the peripheral and PCell registers of a PL011
device, was not treating each register value as a 32 bit value.

Change DeviceId enum to return register values via constified getter
functions instead of leveraging the std::ops::Index<_> trait.

While at it, print errors when guest attempts to write to other RO
registers as well.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---

Notes:
    Changes from v1:
    
    - Print error when guest attempts to write to RO registers (Peter
      Maydell)
    
    Version 1:
     <20241116181549.3430225-1-manos.pitsidianakis@linaro.org/raw>

Interdiff against v1:
  diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
  index 98dd97dbfd..fc6f3f394d 100644
  --- a/rust/hw/char/pl011/src/device.rs
  +++ b/rust/hw/char/pl011/src/device.rs
  @@ -277,13 +277,15 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
           use RegisterOffset::*;
           let value: u32 = value as u32;
           match RegisterOffset::try_from(offset) {
  -            Ok(PeriphID0) | Ok(PeriphID1) | Ok(PeriphID2) | Ok(PeriphID3) | Ok(PCellID0)
  -            | Ok(PCellID1) | Ok(PCellID2) | Ok(PCellID3) => {
  -                // Ignore writes to read-only registers.
  -            }
  -            Err(_bad_offset) => {
  +            Err(_) => {
                   eprintln!("write bad offset {offset} value {value}");
               }
  +            Ok(
  +                dev_id @ (PeriphID0 | PeriphID1 | PeriphID2 | PeriphID3 | PCellID0 | PCellID1
  +                | PCellID2 | PCellID3),
  +            ) => {
  +                eprintln!("write bad offset {offset} at RO register {dev_id:?} value {value}");
  +            }
               Ok(DR) => {
                   // ??? Check if transmitter is enabled.
                   let ch: u8 = value as u8;
  @@ -303,7 +305,7 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                   self.receive_status_error_clear = 0.into();
               }
               Ok(FR) => {
  -                // flag writes are ignored
  +                eprintln!("write bad offset {offset} at RO register UARTFR value {value}");
               }
               Ok(ILPR) => {
                   self.ilpr = value;
  @@ -353,8 +355,12 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                   self.int_enabled = value;
                   self.update();
               }
  -            Ok(RIS) => {}
  -            Ok(MIS) => {}
  +            Ok(RIS) => {
  +                eprintln!("write bad offset {offset} at RO register UARTRIS value {value}");
  +            }
  +            Ok(MIS) => {
  +                eprintln!("write bad offset {offset} at RO register UARTMIS value {value}");
  +            }
               Ok(ICR) => {
                   self.int_level &= !value;
                   self.update();

 rust/hw/char/pl011/src/device.rs | 93 ++++++++++++++++++++++++--------
 rust/hw/char/pl011/src/lib.rs    | 22 +++++++-
 2 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2a85960b81..fc6f3f394d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,7 +5,7 @@
 use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
-    os::raw::{c_int, c_uchar, c_uint, c_void},
+    os::raw::{c_int, c_uint, c_void},
 };
 
 use qemu_api::{
@@ -32,6 +32,7 @@
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
+/// State enum that represents the values of the peripheral and PCell registers of a PL011 device.
 #[derive(Clone, Copy, Debug)]
 enum DeviceId {
     #[allow(dead_code)]
@@ -39,20 +40,55 @@ enum DeviceId {
     Luminary,
 }
 
-impl std::ops::Index<hwaddr> for DeviceId {
-    type Output = c_uchar;
-
-    fn index(&self, idx: hwaddr) -> &Self::Output {
-        match self {
-            Self::Arm => &Self::PL011_ID_ARM[idx as usize],
-            Self::Luminary => &Self::PL011_ID_LUMINARY[idx as usize],
-        }
-    }
-}
-
 impl DeviceId {
-    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
-    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
+    /// Value of `UARTPeriphID0` register, which contains the `PartNumber0` value.
+    const fn uart_periph_id0(self) -> u64 {
+        0x11
+    }
+
+    /// Value of `UARTPeriphID1` register, which contains the `Designer0` and `PartNumber1` values.
+    const fn uart_periph_id1(self) -> u64 {
+        (match self {
+            Self::Arm => 0x10,
+            Self::Luminary => 0x00,
+        }) as u64
+    }
+
+    /// Value of `UARTPeriphID2` register, which contains the `Revision` and `Designer1` values.
+    const fn uart_periph_id2(self) -> u64 {
+        (match self {
+            Self::Arm => 0x14,
+            Self::Luminary => 0x18,
+        }) as u64
+    }
+
+    /// Value of `UARTPeriphID3` register, which contains the `Configuration` value.
+    const fn uart_periph_id3(self) -> u64 {
+        (match self {
+            Self::Arm => 0x0,
+            Self::Luminary => 0x1,
+        }) as u64
+    }
+
+    /// Value of `UARTPCellID0` register.
+    const fn uart_pcell_id0(self) -> u64 {
+        0x0d
+    }
+
+    /// Value of `UARTPCellID1` register.
+    const fn uart_pcell_id1(self) -> u64 {
+        0xf0
+    }
+
+    /// Value of `UARTPCellID2` register.
+    const fn uart_pcell_id2(self) -> u64 {
+        0x05
+    }
+
+    /// Value of `UARTPCellID3` register.
+    const fn uart_pcell_id3(self) -> u64 {
+        0xb1
+    }
 }
 
 #[repr(C)]
@@ -182,9 +218,14 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
         use RegisterOffset::*;
 
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
-            Err(v) if (0x3f8..0x400).contains(&v) => {
-                u64::from(self.device_id[(offset - 0xfe0) >> 2])
-            }
+            Ok(PeriphID0) => self.device_id.uart_periph_id0(),
+            Ok(PeriphID1) => self.device_id.uart_periph_id1(),
+            Ok(PeriphID2) => self.device_id.uart_periph_id2(),
+            Ok(PeriphID3) => self.device_id.uart_periph_id3(),
+            Ok(PCellID0) => self.device_id.uart_pcell_id0(),
+            Ok(PCellID1) => self.device_id.uart_pcell_id1(),
+            Ok(PCellID2) => self.device_id.uart_pcell_id2(),
+            Ok(PCellID3) => self.device_id.uart_pcell_id3(),
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
                 0
@@ -236,9 +277,15 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
         use RegisterOffset::*;
         let value: u32 = value as u32;
         match RegisterOffset::try_from(offset) {
-            Err(_bad_offset) => {
+            Err(_) => {
                 eprintln!("write bad offset {offset} value {value}");
             }
+            Ok(
+                dev_id @ (PeriphID0 | PeriphID1 | PeriphID2 | PeriphID3 | PCellID0 | PCellID1
+                | PCellID2 | PCellID3),
+            ) => {
+                eprintln!("write bad offset {offset} at RO register {dev_id:?} value {value}");
+            }
             Ok(DR) => {
                 // ??? Check if transmitter is enabled.
                 let ch: u8 = value as u8;
@@ -258,7 +305,7 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.receive_status_error_clear = 0.into();
             }
             Ok(FR) => {
-                // flag writes are ignored
+                eprintln!("write bad offset {offset} at RO register UARTFR value {value}");
             }
             Ok(ILPR) => {
                 self.ilpr = value;
@@ -308,8 +355,12 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.int_enabled = value;
                 self.update();
             }
-            Ok(RIS) => {}
-            Ok(MIS) => {}
+            Ok(RIS) => {
+                eprintln!("write bad offset {offset} at RO register UARTRIS value {value}");
+            }
+            Ok(MIS) => {
+                eprintln!("write bad offset {offset} at RO register UARTMIS value {value}");
+            }
             Ok(ICR) => {
                 self.int_level &= !value;
                 self.update();
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index cd0a49acb9..1f305aa13f 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -111,6 +111,22 @@ pub enum RegisterOffset {
     /// DMA control Register
     #[doc(alias = "UARTDMACR")]
     DMACR = 0x048,
+    #[doc(alias = "UARTPeriphID0")]
+    PeriphID0 = 0xFE0,
+    #[doc(alias = "UARTPeriphID1")]
+    PeriphID1 = 0xFE4,
+    #[doc(alias = "UARTPeriphID2")]
+    PeriphID2 = 0xFE8,
+    #[doc(alias = "UARTPeriphID3")]
+    PeriphID3 = 0xFEC,
+    #[doc(alias = "UARTPCellID0")]
+    PCellID0 = 0xFF0,
+    #[doc(alias = "UARTPCellID1")]
+    PCellID1 = 0xFF4,
+    #[doc(alias = "UARTPCellID2")]
+    PCellID2 = 0xFF8,
+    #[doc(alias = "UARTPCellID3")]
+    PCellID3 = 0xFFC,
     ///// Reserved, offsets `0x04C` to `0x07C`.
     //Reserved = 0x04C,
 }
@@ -137,7 +153,11 @@ const fn _assert_exhaustive(val: RegisterOffset) {
                 }
             }
         }
-        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR }
+        case! {
+            DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR,
+            PeriphID0, PeriphID1, PeriphID2, PeriphID3,
+            PCellID0, PCellID1, PCellID2, PCellID3,
+        }
     }
 }
 

base-commit: 43f2def68476697deb0d119cbae51b20019c6c86
-- 
γαῖα πυρί μιχθήτω


