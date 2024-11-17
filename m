Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9749D10F20
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 16:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tChrO-0000yI-J7; Sun, 17 Nov 2024 11:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tChrK-0000xm-G9
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 11:10:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tChrH-0001gP-Mi
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 11:10:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so18468405e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731859841; x=1732464641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GikP/iJqDN/uA4pIDU3RA3esUPeMcwTG8y/JwFqz7k4=;
 b=ILdUjcESzBVIGpV9RcUSSfuHrArIVYfrbUZ3ZrHDLv/mnFaWb6H8s4+KWdJuSKGW3w
 XjxY9hsgCoUMMA8aO4zdGwXcggOPatWd7rlc98noZEUUQcgyeN1UV91VdfZZvAPj0wte
 bAZ+oFb1kgn1d1RGdzSNiywIan5ZemazZp+JYTXWcMULDrhrqwfwqQ47vjZI15eNL6iG
 Asbwr4EGh9ANjfGlgxyU27mt8Q9X/WjDWS+md3TX02cKkW9+XrxGP3gSFMjGWu5Dtqiu
 c4AMRtrm2YKJOx47KKXjIdQfH/Yr88BiV1ayFCJjt8i/iHhNoFyOREE/PNYVZuVGO0OD
 Fp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731859841; x=1732464641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GikP/iJqDN/uA4pIDU3RA3esUPeMcwTG8y/JwFqz7k4=;
 b=BrDEH6qg4dPcrjo7pvk+gj6kxWgSnXZuZLBNzfdzCgHgLw8xZX3oiM5F79k+4RDVeY
 bNru1OnQqZCPHecwoTJk71lqCFmTqapD1PSe+CdC0D3Dk0WwdSX6cXeZiWuFWIaNNeF7
 DScN5tMTIGrovxuB4L6TFfWr9f4csJq7q4PSDk4UOIQtYe9c0HiipSQUv7stvbPMvphD
 O7etEEiJWBBPTqi3typxSqC584rCigmDnOMPK2RBR26rdO0VS6GkoGUHV5gz5t/xQwVR
 vIVYUn1DzKl39BGKxFqq2SSto//REVVrf4CvIOSELO1M/stwldCsEVqTjN/n0ZulF55G
 b74g==
X-Gm-Message-State: AOJu0YwJQ1OJ9t2CRlWIuloSOg7ajXE2kvow9L4ia6+Z4PER+IdEkGNE
 HduDxUF7jfhZgMTp4rk/7xtJC82jMAmeKKz4EkFCzP7n0pf+Ss1Xw7szrtYlO1w9z0n+/L4+g5f
 nSgw=
X-Google-Smtp-Source: AGHT+IFx8mitUN5+hjy8LV0JyN3UBFS9MIJ93hNT1dJ8Jy/uDEaUfuQTXR9XLYpPJ50FIFzxfXOHOA==
X-Received: by 2002:a05:600c:1e89:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-432df78e296mr76171445e9.24.1731859841438; 
 Sun, 17 Nov 2024 08:10:41 -0800 (PST)
Received: from localhost.localdomain (adsl-123.37.6.2.tellas.gr. [37.6.2.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721d7sm126147905e9.9.2024.11.17.08.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 08:10:41 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3] rust/pl011: Fix DeviceID reads
Date: Sun, 17 Nov 2024 18:10:36 +0200
Message-ID: <20241117161039.3758840-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

DeviceId, which maps the peripheral and PCell registers of a PL011
device, was not treating each register value as a 32 bit value.

Change DeviceId enum to return register values via constified getter
functions instead of leveraging the std::ops::Index<_> trait.

While at it, print errors when guest attempts to write to other RO
registers as well.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---

Notes:
    Changes from v2:
    
    - Group invalid write case matches (Paolo)
    - Reduce register getter line count to aid review (Peter Maydell)
    
    v1 -> v2:
    
    - Print error when guest attempts to write to RO registers (Peter
      Maydell)
    
    Version 1:
     <20241116181549.3430225-1-manos.pitsidianakis@linaro.org>
    Version 2:
     <20241116221757.3501603-1-manos.pitsidianakis@linaro.org>

Interdiff against v2:
  diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
  index fc6f3f394d..f1d959ca28 100644
  --- a/rust/hw/char/pl011/src/device.rs
  +++ b/rust/hw/char/pl011/src/device.rs
  @@ -40,54 +40,50 @@ enum DeviceId {
       Luminary,
   }
   
  +macro_rules! pcell_reg_getter {
  +    ($($(#[$attrs:meta])* fn $getter_fn:ident -> $value:literal),*$(,)?) => {
  +        $($(#[$attrs])* const fn $getter_fn(self) -> u64 { $value })*
  +    };
  +}
  +
  +macro_rules! periph_reg_getter {
  +    ($($(#[$attrs:meta])* fn $getter_fn:ident -> { Arm => $arm:literal, Luminary => $lum:literal$(,)?}),*$(,)?) => {
  +        $(
  +            $(#[$attrs])*
  +            const fn $getter_fn(self) -> u64 {
  +                (match self {
  +                    Self::Arm => $arm,
  +                    Self::Luminary => $lum,
  +                }) as u64
  +            }
  +        )*
  +    };
  +}
  +
   impl DeviceId {
       /// Value of `UARTPeriphID0` register, which contains the `PartNumber0` value.
       const fn uart_periph_id0(self) -> u64 {
           0x11
       }
   
  -    /// Value of `UARTPeriphID1` register, which contains the `Designer0` and `PartNumber1` values.
  -    const fn uart_periph_id1(self) -> u64 {
  -        (match self {
  -            Self::Arm => 0x10,
  -            Self::Luminary => 0x00,
  -        }) as u64
  +    periph_reg_getter! {
  +        /// Value of `UARTPeriphID1` register, which contains the `Designer0` and `PartNumber1` values.
  +        fn uart_periph_id1 -> { Arm => 0x10, Luminary => 0x00 },
  +        /// Value of `UARTPeriphID2` register, which contains the `Revision` and `Designer1` values.
  +        fn uart_periph_id2 -> { Arm => 0x14, Luminary => 0x18 },
  +        /// Value of `UARTPeriphID3` register, which contains the `Configuration` value.
  +        fn uart_periph_id3 -> { Arm => 0x0, Luminary => 0x1 }
       }
   
  -    /// Value of `UARTPeriphID2` register, which contains the `Revision` and `Designer1` values.
  -    const fn uart_periph_id2(self) -> u64 {
  -        (match self {
  -            Self::Arm => 0x14,
  -            Self::Luminary => 0x18,
  -        }) as u64
  -    }
  -
  -    /// Value of `UARTPeriphID3` register, which contains the `Configuration` value.
  -    const fn uart_periph_id3(self) -> u64 {
  -        (match self {
  -            Self::Arm => 0x0,
  -            Self::Luminary => 0x1,
  -        }) as u64
  -    }
  -
  -    /// Value of `UARTPCellID0` register.
  -    const fn uart_pcell_id0(self) -> u64 {
  -        0x0d
  -    }
  -
  -    /// Value of `UARTPCellID1` register.
  -    const fn uart_pcell_id1(self) -> u64 {
  -        0xf0
  -    }
  -
  -    /// Value of `UARTPCellID2` register.
  -    const fn uart_pcell_id2(self) -> u64 {
  -        0x05
  -    }
  -
  -    /// Value of `UARTPCellID3` register.
  -    const fn uart_pcell_id3(self) -> u64 {
  -        0xb1
  +    pcell_reg_getter! {
  +        /// Value of `UARTPCellID0` register.
  +        fn uart_pcell_id0 -> 0x0d,
  +        /// Value of `UARTPCellID1` register.
  +        fn uart_pcell_id1 -> 0xf0,
  +        /// Value of `UARTPCellID2` register.
  +        fn uart_pcell_id2 -> 0x05,
  +        /// Value of `UARTPCellID3` register.
  +        fn uart_pcell_id3 -> 0xb1,
       }
   }
   
  @@ -282,7 +278,7 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
               }
               Ok(
                   dev_id @ (PeriphID0 | PeriphID1 | PeriphID2 | PeriphID3 | PCellID0 | PCellID1
  -                | PCellID2 | PCellID3),
  +                | PCellID2 | PCellID3 | FR | RIS | MIS),
               ) => {
                   eprintln!("write bad offset {offset} at RO register {dev_id:?} value {value}");
               }
  @@ -304,9 +300,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
               Ok(RSR) => {
                   self.receive_status_error_clear = 0.into();
               }
  -            Ok(FR) => {
  -                eprintln!("write bad offset {offset} at RO register UARTFR value {value}");
  -            }
               Ok(ILPR) => {
                   self.ilpr = value;
               }
  @@ -355,12 +348,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                   self.int_enabled = value;
                   self.update();
               }
  -            Ok(RIS) => {
  -                eprintln!("write bad offset {offset} at RO register UARTRIS value {value}");
  -            }
  -            Ok(MIS) => {
  -                eprintln!("write bad offset {offset} at RO register UARTMIS value {value}");
  -            }
               Ok(ICR) => {
                   self.int_level &= !value;
                   self.update();

 rust/hw/char/pl011/src/device.rs | 78 ++++++++++++++++++++++++--------
 rust/hw/char/pl011/src/lib.rs    | 22 ++++++++-
 2 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2a85960b81..f1d959ca28 100644
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
@@ -39,20 +40,51 @@ enum DeviceId {
     Luminary,
 }
 
-impl std::ops::Index<hwaddr> for DeviceId {
-    type Output = c_uchar;
+macro_rules! pcell_reg_getter {
+    ($($(#[$attrs:meta])* fn $getter_fn:ident -> $value:literal),*$(,)?) => {
+        $($(#[$attrs])* const fn $getter_fn(self) -> u64 { $value })*
+    };
+}
 
-    fn index(&self, idx: hwaddr) -> &Self::Output {
-        match self {
-            Self::Arm => &Self::PL011_ID_ARM[idx as usize],
-            Self::Luminary => &Self::PL011_ID_LUMINARY[idx as usize],
-        }
-    }
+macro_rules! periph_reg_getter {
+    ($($(#[$attrs:meta])* fn $getter_fn:ident -> { Arm => $arm:literal, Luminary => $lum:literal$(,)?}),*$(,)?) => {
+        $(
+            $(#[$attrs])*
+            const fn $getter_fn(self) -> u64 {
+                (match self {
+                    Self::Arm => $arm,
+                    Self::Luminary => $lum,
+                }) as u64
+            }
+        )*
+    };
 }
 
 impl DeviceId {
-    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
-    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
+    /// Value of `UARTPeriphID0` register, which contains the `PartNumber0` value.
+    const fn uart_periph_id0(self) -> u64 {
+        0x11
+    }
+
+    periph_reg_getter! {
+        /// Value of `UARTPeriphID1` register, which contains the `Designer0` and `PartNumber1` values.
+        fn uart_periph_id1 -> { Arm => 0x10, Luminary => 0x00 },
+        /// Value of `UARTPeriphID2` register, which contains the `Revision` and `Designer1` values.
+        fn uart_periph_id2 -> { Arm => 0x14, Luminary => 0x18 },
+        /// Value of `UARTPeriphID3` register, which contains the `Configuration` value.
+        fn uart_periph_id3 -> { Arm => 0x0, Luminary => 0x1 }
+    }
+
+    pcell_reg_getter! {
+        /// Value of `UARTPCellID0` register.
+        fn uart_pcell_id0 -> 0x0d,
+        /// Value of `UARTPCellID1` register.
+        fn uart_pcell_id1 -> 0xf0,
+        /// Value of `UARTPCellID2` register.
+        fn uart_pcell_id2 -> 0x05,
+        /// Value of `UARTPCellID3` register.
+        fn uart_pcell_id3 -> 0xb1,
+    }
 }
 
 #[repr(C)]
@@ -182,9 +214,14 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
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
@@ -236,9 +273,15 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
         use RegisterOffset::*;
         let value: u32 = value as u32;
         match RegisterOffset::try_from(offset) {
-            Err(_bad_offset) => {
+            Err(_) => {
                 eprintln!("write bad offset {offset} value {value}");
             }
+            Ok(
+                dev_id @ (PeriphID0 | PeriphID1 | PeriphID2 | PeriphID3 | PCellID0 | PCellID1
+                | PCellID2 | PCellID3 | FR | RIS | MIS),
+            ) => {
+                eprintln!("write bad offset {offset} at RO register {dev_id:?} value {value}");
+            }
             Ok(DR) => {
                 // ??? Check if transmitter is enabled.
                 let ch: u8 = value as u8;
@@ -257,9 +300,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
             Ok(RSR) => {
                 self.receive_status_error_clear = 0.into();
             }
-            Ok(FR) => {
-                // flag writes are ignored
-            }
             Ok(ILPR) => {
                 self.ilpr = value;
             }
@@ -308,8 +348,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.int_enabled = value;
                 self.update();
             }
-            Ok(RIS) => {}
-            Ok(MIS) => {}
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


