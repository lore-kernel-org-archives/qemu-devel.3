Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C79AC5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxozi-0002de-3d; Sat, 22 Aug 2026 12:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wxozg-0002c7-Bd
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 12:54:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wxozc-0006ds-V1
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 12:54:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cace91f112so22908445ad.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787417691; x=1788022491; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T0xE1KANjQjJZlPwU/txw1/fcNoRFudGxhkULaXzqPI=;
 b=rSiHMRkJbt17/+Y5DCiqsSdd3fLFbaoz9k8S1+yQsc2Y68gFJx21tzkVoLhpvnHJsU
 g5/AYiPYQkDAAP46FeoLLcHWakv4n5IMoPb+zQwfXqnqEgbmByT3u8ECl2/t997cgTrb
 A1QAiYGAim02YuLX0NoI3sG1D1SDX5Md1wEtHb+7rTIVhSEJT99uit1/TqGs/jV6zO3A
 2Yq6Fp89PN5Fo1lp+b5l+P7w9hsZJTFtCO0PvSZPhuLgs+OwSjdM429kx0XicrpRdr6T
 DCmUzxq4WlcTOcj/skJEwGspKtxpL4lQScQK8fZFuExcv61Md6ZXbW/pRlOpOU9R4Ow9
 bWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787417691; x=1788022491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T0xE1KANjQjJZlPwU/txw1/fcNoRFudGxhkULaXzqPI=;
 b=ABZPITZyEW4b0Tqb0KZSiTZ1+npFj6qUJvaCMHPz6AakAn9MpEkh61E55vPSPO0ZWb
 CD07/kfDqqnpFAvk6F9XQU2e0YOS0kL5xxUIT0CuL9X3xHdiy+75/OD7e9R+oz1e4akA
 ZRrcMNisorKSXMpB+wo0mk5B91Y5ZVFi6QvwB/4Jn6xv3FU4OiFLByapTQ8x5GOWGi6W
 xiOYGOwMzzBsiMwrsOiJpqJPc7UwD48DxgtNrk6Vn+h8INxpPjqO8k/k2XDXIOk+9czk
 2qE0XOFwSoVZ92jGK3tyNb8Plnuh54CQ9REThUmHuNlfOYf9kaTYDg+M1c5sDAusnYxR
 FjNA==
X-Gm-Message-State: AFuF++lD8G6Y0+Qe/He7bzy3AEKhPvuHYYdUzxgA91JKLhAjUu7atDlO
 7t5dTltusO2MhH4drlIv2E1JGEWm7uh2nkLfbr2f6CNobT8Dz7MoQskJ
X-Gm-Gg: AR+sD10e5AQowHMeg0gkcnS2+EMyRidaNUEQgPOF0jGpRIb+o/Wyh4t3MR+WfVbHsk0
 PxkdO7tZo5cxHJe+5/OULI5hH+aaaN/UMESryDBDVE38bGMpZJJ2ToA1VWQr1s4FiDlwaaIFtKQ
 mqshJNBRuHI6tmk4IIm8EGDYZ5j+621JiUq08ie7oj8Ur0iZh3hrsWWv4oil3GNtvaw77/TyR/b
 p7AT5Q+MVY3UGU6R78pm4ByI6GsqBo1fHSlOu29DurfYI83/1WFusq97TZntVVE5/geHCIlhKxE
 BtSfJ4grvobaeAkrjyekm34XxgnHVwne1NO5y4ccUclNYG8HSjbgYLiQvZLwNvEv2gTkyKnb8ba
 vrsdyBeIo6J/+pzS4cEQ873M72orbfcYDlnbB0xENpRTUE8lSW486Ol3sP1xy+vHVyB5H0fEr0n
 /p/ABXa0ubo/9gDKJOpUM20/C0I+T1Tam2kGVYz8ETEH5sYfLeSnWHAV/d4C8Xbq/jQD+mynohy
 GDwaNsgEF7yFM1LqyLrWwPk2YRJD9Cw/NHYJyG8FPPbHRqBSlWqYy+xoLtVDkgbDjPEmN8=
X-Received: by 2002:a17:902:ceca:b0:2d3:6fac:d67c with SMTP id
 d9443c01a7336-2d670c980e1mr95821195ad.10.1787417690424; 
 Sat, 22 Aug 2026 09:54:50 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([117.55.237.216]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d2d1esm8688456eec.17.2026.08.22.09.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 09:54:49 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
Date: Sun, 23 Aug 2026 00:54:35 +0800
Subject: [PATCH RFC v2 1/5] hw/gpio: add STM32F1xx GPIO device model in
 Rust
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-stm32f100-gpio-v2-final-v2-1-02e31f589dd0@gmail.com>
References: <20260823-stm32f100-gpio-v2-final-v2-0-02e31f589dd0@gmail.com>
In-Reply-To: <20260823-stm32f100-gpio-v2-final-v2-0-02e31f589dd0@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19912;
 i=163wangjack@gmail.com; h=from:subject:message-id;
 bh=aTOA2nKXadaYHcYn7zlDRiKQ/nrcmrFXHHTST5uYI34=;
 b=owEBiQJ2/ZANAwAIARVa4Yx0u1BNAcsmYgBqidRSu8yq6tqphqilCkL6IRbEk3tubFBdtYXYq
 Q45OUSLB/yJAk8EAAEIADkWIQQlXkw4qdbVYyKFm20VWuGMdLtQTQUCaonUUhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQFVrhjHS7UE2Dgw//a6VCqbvlJGacSWS1WL89+ptfM65uy9U
 G5ART/3Tm3L2GwuWxDH/LIBSXNvXeH80IfUNorv4OuyJirQx63w2B/EXej9m2WpXdYPOLGUNTyu
 cun9uK6sebR3PygsTd6IWrQ9PUip33D210quvyTd3dwKS9PYFsPLZfNZd5D76ZUbwk3M9Wehoyc
 qztzdCeukksx/VF4mVB6zobIf4kN/UoVW8g3BGhacXY3tTOjeIffbS0IJzdocrrEnCBY1Lqpq1k
 WCbgJBKAUk1QOr+XDqXkGPkO5e5/gvO+OIn6wFa6qVWabHkWSD15qc6Obnk0Aqn27GXuvAoQrb5
 uhDcRq/k66DIJK9LmEUTacRDXZGA52Nrqf4y3L/heUE2c8CI76Xr4pwaS9EjbMUOx4zzQJ1IKbD
 W1B4QOHafN2kRQ92st5O/vu9XkkYLyflV1mHmNzITUN+55FSETEczXEhbcUP9o2+mZZfT52QMUr
 qLlyaSXRd5Mk37yTJL0zqGBlJDn8O4XZoCMRJb6VoCXDVq+0qgMuaiNRIHy9EM7niuv18XSEhLF
 d5upCEumgecTuz5PAAaPyJrJzEwSaKPlcXHaaTJeTjDdWF3YBEVc3XnGROB50pWrFA/Irfqpy0Z
 Qr467R5KQuLQfpGQNm0F3Lujz2zJsFXw1x8mYMx9lEvJlZNUc1aE=
X-Developer-Key: i=163wangjack@gmail.com; a=openpgp;
 fpr=255E4C38A9D6D56322859B6D155AE18C74BB504D
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a reusable STM32F1xx GPIO port model implemented in Rust and based on the STM32F100xx RM0041 register definition.

The device implements the CRL/CRH configuration registers, IDR/ODR and atomic BSRR/BRR updates. Restrict accesses to aligned 32-bit words and model analog input, push-pull output and released open-drain input sampling. Alternate-function routing is not implemented, so AF outputs are not driven from ODR.

LCKR configuration locking, AFIO routing and EXTI integration remain unimplemented. Ignore LCKR writes rather than reporting a false lock.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 hw/gpio/Kconfig              |   5 +
 hw/gpio/trace-events         |   7 +
 rust/hw/gpio/Kconfig         |   4 +
 rust/hw/gpio/src/bindings.rs |  19 ++
 rust/hw/gpio/src/gpio.rs     | 491 +++++++++++++++++++++++++++++++++++++++++++
 rust/hw/gpio/src/lib.rs      |   3 +
 6 files changed, 529 insertions(+)

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index fcc7c70bd5..c0b97f2fb2 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,6 +16,11 @@ config SIFIVE_GPIO
 config STM32L4X5_GPIO
     bool
 
+config STM32F1XX_GPIO
+    bool
+    depends on HAVE_RUST
+    select X_STM32F1XX_GPIO_RUST
+
 config PCA9552
     bool
     depends on I2C
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 80ca783a03..480beea606 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -51,3 +51,10 @@ stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPIO%s di
 cdns_gpio_read(const char *path, uint64_t offset, uint32_t value) "%s:reg[0x%04" PRIx64 "] -> 0x%" PRIx32
 cdns_gpio_write(const char *path, uint64_t offset, uint64_t value) "%s:reg[0x%04" PRIx64 "] <- 0x%04" PRIx64
 cdns_gpio_set(const char *path, int line, int level) "%s:[%d] <- %d"
+
+# stm32f1xx GPIO Rust device
+stm32f1xx_gpio_instance_init(void) "instance init"
+stm32f1xx_gpio_reset(void) "reset"
+stm32f1xx_gpio_read(uint64_t offset, uint64_t value, unsigned size) "offset 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
+stm32f1xx_gpio_write(uint64_t offset, uint64_t value, unsigned size) "offset 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
+stm32f1xx_gpio_irq(unsigned line, int level) "line %u level %d"
diff --git a/rust/hw/gpio/Kconfig b/rust/hw/gpio/Kconfig
new file mode 100644
index 0000000000..acedd7a004
--- /dev/null
+++ b/rust/hw/gpio/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config X_STM32F1XX_GPIO_RUST
+    bool
diff --git a/rust/hw/gpio/src/bindings.rs b/rust/hw/gpio/src/bindings.rs
new file mode 100644
index 0000000000..b0189065b4
--- /dev/null
+++ b/rust/hw/gpio/src/bindings.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unnecessary_transmutes,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
+)]
diff --git a/rust/hw/gpio/src/gpio.rs b/rust/hw/gpio/src/gpio.rs
new file mode 100644
index 0000000000..6a66608a1d
--- /dev/null
+++ b/rust/hw/gpio/src/gpio.rs
@@ -0,0 +1,491 @@
+// STM32F1xx GPIO port device model (Rust)
+// Copyright 2026, Jack Wang
+// Author(s): Jack Wang <163wangjack@gmail.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Reference: ST RM0041, section 7.
+
+use std::ffi::CStr;
+
+use bql::prelude::*;
+use common::prelude::*;
+use hwcore::prelude::*;
+use migration::prelude::*;
+use qom::prelude::*;
+use system::prelude::*;
+use util::prelude::*;
+
+pub const GPIO_NUM_PINS: usize = 16;
+
+pub const TYPE_STM32F1XX_GPIO_RUST: &CStr = c"stm32f1xx-gpio-rust";
+qom_isa!(Stm32f1xxGpioState: SysBusDevice, DeviceState, Object);
+
+unsafe impl ObjectType for Stm32f1xxGpioState {
+    type Class = <SysBusDevice as ObjectType>::Class;
+    const TYPE_NAME: &'static CStr = TYPE_STM32F1XX_GPIO_RUST;
+}
+
+::trace::include_trace!("hw_gpio");
+
+pub const REG_CRL: u64 = 0x00;
+pub const REG_CRH: u64 = 0x04;
+pub const REG_IDR: u64 = 0x08;
+pub const REG_ODR: u64 = 0x0C;
+pub const REG_BSRR: u64 = 0x10;
+pub const REG_BRR: u64 = 0x14;
+pub const REG_LCKR: u64 = 0x18;
+
+pub const RESET_CRL: u32 = 0x4444_4444;
+pub const RESET_CRH: u32 = 0x4444_4444;
+
+#[repr(C)]
+#[derive(Debug)]
+pub struct GpioRegisters {
+    crl: BqlCell<u32>,
+    crh: BqlCell<u32>,
+    idr: BqlCell<u32>,
+    odr: BqlCell<u32>,
+    lckr: BqlCell<u32>,
+
+    // Set bits have no external driver.
+    disconnected_pins: BqlCell<u16>,
+    pins_connected_high: BqlCell<u16>,
+}
+
+impl Default for GpioRegisters {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+/// Changed output pins and their new levels.
+#[derive(Debug, Default, Clone, Copy)]
+pub struct PinUpdate {
+    pub mask: u32,
+    pub levels: u32,
+}
+
+impl GpioRegisters {
+    pub const fn new() -> Self {
+        Self {
+            crl: BqlCell::new(RESET_CRL),
+            crh: BqlCell::new(RESET_CRH),
+            idr: BqlCell::new(0),
+            odr: BqlCell::new(0),
+            lckr: BqlCell::new(0),
+            disconnected_pins: BqlCell::new(0xFFFF),
+            pins_connected_high: BqlCell::new(0),
+        }
+    }
+
+    pub fn idr(&self) -> u32 {
+        self.idr.get()
+    }
+    pub fn odr(&self) -> u32 {
+        self.odr.get()
+    }
+    pub fn crl(&self) -> u32 {
+        self.crl.get()
+    }
+    pub fn crh(&self) -> u32 {
+        self.crh.get()
+    }
+    pub fn disconnected_pins(&self) -> u16 {
+        self.disconnected_pins.get()
+    }
+
+    fn extract(value: u32, start: u32, length: u32) -> u32 {
+        assert!(length > 0 && length <= 32 - start);
+        (value >> start) & (!0u32 >> (32 - length))
+    }
+
+    fn get_modecnf(&self, pin: usize) -> u8 {
+        let reg = if pin < 8 {
+            self.crl.get()
+        } else {
+            self.crh.get()
+        };
+        let shift = ((pin % 8) * 4) as u32;
+        Self::extract(reg, shift, 4) as u8
+    }
+
+    fn is_output(&self, pin: usize) -> bool {
+        (self.get_modecnf(pin) & 0x03) != 0
+    }
+
+    fn is_alternate_open_drain(&self, pin: usize) -> bool {
+        let modecnf = self.get_modecnf(pin);
+        ((modecnf & 0x03) != 0) && ((modecnf >> 2) == 0x03)
+    }
+
+    fn is_alternate_push_pull(&self, pin: usize) -> bool {
+        let modecnf = self.get_modecnf(pin);
+        ((modecnf & 0x03) != 0) && ((modecnf >> 2) == 0x02)
+    }
+
+    fn is_general_push_pull(&self, pin: usize) -> bool {
+        let modecnf = self.get_modecnf(pin);
+        ((modecnf & 0x03) != 0) && ((modecnf >> 2) == 0x00)
+    }
+
+    fn is_general_open_drain(&self, pin: usize) -> bool {
+        let modecnf = self.get_modecnf(pin);
+        ((modecnf & 0x03) != 0) && ((modecnf >> 2) == 0x01)
+    }
+
+    fn is_analog_input(&self, pin: usize) -> bool {
+        self.get_modecnf(pin) == 0b0000
+    }
+
+    fn is_odr_high(&self, pin: usize) -> bool {
+        self.odr.get() & (1 << pin) != 0
+    }
+
+    fn is_input_pull_up_down_mode(&self, pin: usize) -> bool {
+        self.get_modecnf(pin) == 0b1000
+    }
+
+    fn is_input_pullup(&self, pin: usize) -> bool {
+        self.is_input_pull_up_down_mode(pin) && ((self.odr.get() & (1 << pin)) != 0)
+    }
+
+    fn is_input_pulldown(&self, pin: usize) -> bool {
+        self.is_input_pull_up_down_mode(pin) && ((self.odr.get() & (1 << pin)) == 0)
+    }
+
+    fn check_and_warn_af(&self, start_pin: usize) {
+        for i in 0..8 {
+            let pin = start_pin + i;
+            if self.is_alternate_push_pull(pin) || self.is_alternate_open_drain(pin) {
+                log_mask_ln!(
+                    Log::Unimp,
+                    "stm32f1xx_gpio: alternate-function routing for pin {} is not implemented",
+                    pin
+                );
+            }
+        }
+    }
+
+    pub fn reset(&self) -> PinUpdate {
+        self.crl.set(RESET_CRL);
+        self.crh.set(RESET_CRH);
+        self.idr.set(0);
+        self.odr.set(0);
+        self.lckr.set(0);
+        self.disconnected_pins.set(0xFFFF);
+        self.pins_connected_high.set(0);
+
+        // RM0041 leaves IDR undefined; use low and deassert every output.
+        PinUpdate {
+            mask: 0xFFFF,
+            levels: 0,
+        }
+    }
+
+    pub fn gpio_set(&self, line: usize, level: u32) -> PinUpdate {
+        let push_pull = self.is_general_push_pull(line) || self.is_alternate_push_pull(line);
+        let open_drain_drives_low = self.is_general_open_drain(line) && !self.is_odr_high(line);
+
+        if push_pull || (open_drain_drives_low && level != 0) {
+            log_mask_ln!(
+                Log::GuestError,
+                "stm32f1xx_gpio: line {} cannot be driven to {} externally",
+                line,
+                level
+            );
+            return PinUpdate::default();
+        }
+
+        self.disconnected_pins
+            .set(self.disconnected_pins.get() & !(1 << line));
+
+        if level != 0 {
+            self.pins_connected_high
+                .set(self.pins_connected_high.get() | (1 << line));
+        } else {
+            self.pins_connected_high
+                .set(self.pins_connected_high.get() & !(1 << line));
+        }
+
+        self.update_gpio_idr()
+    }
+
+    // Retain an open-drain source so it can be sampled after release.
+    fn get_gpio_pinmask_to_disconnect(&self) -> u16 {
+        let mut pins_to_disconnect: u16 = 0;
+        for i in 0..GPIO_NUM_PINS {
+            if (self.disconnected_pins.get() & (1 << i) == 0) && self.is_output(i) {
+                if self.is_general_push_pull(i)
+                    || self.is_alternate_push_pull(i)
+                    || self.is_alternate_open_drain(i)
+                {
+                    pins_to_disconnect |= 1 << i;
+                    log_mask_ln!(
+                        Log::GuestError,
+                        "stm32f1xx_gpio: Line {} can't be driven externally",
+                        i
+                    );
+                }
+            }
+        }
+        pins_to_disconnect
+    }
+
+    fn disconnect_gpio_pins(&self, lines: u16) -> PinUpdate {
+        self.disconnected_pins
+            .set(self.disconnected_pins.get() | lines);
+        self.update_gpio_idr()
+    }
+
+    pub fn write(&self, offset: u64, data: u32) -> PinUpdate {
+        match offset {
+            REG_CRL => {
+                self.crl.set(data);
+                self.check_and_warn_af(0);
+                self.disconnect_gpio_pins(self.get_gpio_pinmask_to_disconnect())
+            }
+            REG_CRH => {
+                self.crh.set(data);
+                self.check_and_warn_af(8);
+                self.disconnect_gpio_pins(self.get_gpio_pinmask_to_disconnect())
+            }
+            REG_ODR => {
+                self.odr.set(data & 0xFFFF);
+                self.update_gpio_idr()
+            }
+            REG_BRR => {
+                let bits_to_reset = data & 0xFFFF;
+                self.odr.set(self.odr.get() & !bits_to_reset);
+                self.update_gpio_idr()
+            }
+            REG_BSRR => {
+                let bits_to_set = data & 0xFFFF;
+                let bits_to_reset = (data >> 16) & 0xFFFF;
+
+                // If both BSx and BRx are set, BSx has priority.
+                let mut current_odr = self.odr.get();
+                current_odr &= !bits_to_reset;
+                current_odr |= bits_to_set;
+                self.odr.set(current_odr);
+
+                self.update_gpio_idr()
+            }
+            REG_LCKR => {
+                log_mask_ln!(
+                    Log::Unimp,
+                    "stm32f1xx_gpio: LCKR configuration locking is not implemented"
+                );
+                PinUpdate::default()
+            }
+            _ => {
+                log_mask_ln!(
+                    Log::GuestError,
+                    "stm32f1xx_gpio_write: Bad offset 0x{:x}",
+                    offset
+                );
+                PinUpdate::default()
+            }
+        }
+    }
+
+    pub fn read(&self, offset: u64) -> u32 {
+        match offset {
+            REG_CRL => self.crl.get(),
+            REG_CRH => self.crh.get(),
+            REG_IDR => self.idr.get(),
+            REG_ODR => self.odr.get(),
+            REG_BSRR => 0,
+            REG_BRR => 0,
+            REG_LCKR => 0,
+            _ => {
+                log_mask_ln!(
+                    Log::GuestError,
+                    "stm32f1xx_gpio_read: Bad offset 0x{:x}",
+                    offset
+                );
+                0
+            }
+        }
+    }
+
+    fn update_gpio_idr(&self) -> PinUpdate {
+        let old_idr = self.idr.get();
+        let mut new_idr = old_idr;
+        let mut new_idr_mask = 0u32;
+
+        for i in 0..GPIO_NUM_PINS {
+            let bit = 1u32 << i;
+            let pin_bit = 1u16 << i;
+            let external_connected = self.disconnected_pins.get() & pin_bit == 0;
+            let external_high = self.pins_connected_high.get() & pin_bit != 0;
+
+            if self.is_analog_input(i) {
+                new_idr &= !bit;
+                new_idr_mask |= bit;
+            } else if self.is_alternate_push_pull(i) || self.is_alternate_open_drain(i) {
+                // AF routing is not modelled.
+                new_idr &= !bit;
+                new_idr_mask |= bit;
+            } else if self.is_general_push_pull(i) {
+                if self.is_odr_high(i) {
+                    new_idr |= bit;
+                } else {
+                    new_idr &= !bit;
+                }
+                new_idr_mask |= bit;
+            } else if self.is_general_open_drain(i) {
+                if !self.is_odr_high(i) {
+                    new_idr &= !bit;
+                } else if external_connected && external_high {
+                    new_idr |= bit;
+                } else {
+                    new_idr &= !bit;
+                }
+                new_idr_mask |= bit;
+            } else if external_connected {
+                if external_high {
+                    new_idr |= bit;
+                } else {
+                    new_idr &= !bit;
+                }
+                new_idr_mask |= bit;
+            } else if self.is_input_pullup(i) {
+                new_idr |= bit;
+                new_idr_mask |= bit;
+            } else if self.is_input_pulldown(i) {
+                new_idr &= !bit;
+                new_idr_mask |= bit;
+            }
+        }
+
+        let resolved_idr = (old_idr & !new_idr_mask) | (new_idr & new_idr_mask);
+        self.idr.set(resolved_idr);
+
+        PinUpdate {
+            mask: (old_idr ^ resolved_idr) & new_idr_mask,
+            levels: resolved_idr,
+        }
+    }
+}
+
+impl_vmstate_struct!(
+    GpioRegisters,
+    VMStateDescriptionBuilder::<GpioRegisters>::new()
+        .name(c"stm32f1xx-gpio/regs")
+        .version_id(1)
+        .minimum_version_id(1)
+        .fields(vmstate_fields! {
+            vmstate_of!(GpioRegisters, crl),
+            vmstate_of!(GpioRegisters, crh),
+            vmstate_of!(GpioRegisters, idr),
+            vmstate_of!(GpioRegisters, odr),
+            vmstate_of!(GpioRegisters, lckr),
+            vmstate_of!(GpioRegisters, disconnected_pins),
+            vmstate_of!(GpioRegisters, pins_connected_high),
+        })
+        .build()
+);
+
+#[repr(C)]
+#[derive(qom::Object, hwcore::Device)]
+pub struct Stm32f1xxGpioState {
+    parent_obj: ParentField<SysBusDevice>,
+    mmio: MemoryRegion,
+
+    regs: GpioRegisters,
+
+    outlines: [InterruptSource; GPIO_NUM_PINS],
+}
+
+impl Stm32f1xxGpioState {
+    unsafe fn init(mut this: ParentInit<Self>) {
+        static STM32F1XX_GPIO_OPS: MemoryRegionOps<Stm32f1xxGpioState> =
+            MemoryRegionOpsBuilder::<Stm32f1xxGpioState>::new()
+                .read(&Stm32f1xxGpioState::read)
+                .write(&Stm32f1xxGpioState::write)
+                .little_endian()
+                .valid_sizes(4, 4)
+                .impl_sizes(4, 4)
+                .build();
+
+        MemoryRegion::init_io(
+            &mut uninit_field_mut!(*this, mmio),
+            &STM32F1XX_GPIO_OPS,
+            "stm32f1xx-gpio-rust",
+            0x400,
+        );
+
+        uninit_field_mut!(*this, regs).write(GpioRegisters::new());
+        uninit_field_mut!(*this, outlines).write(Default::default());
+
+        trace::trace_stm32f1xx_gpio_instance_init();
+    }
+
+    fn post_init(&self) {
+        self.init_mmio(&self.mmio);
+        // Pin interrupts are routed through EXTI, not a sysbus IRQ.
+        self.init_gpio_in(GPIO_NUM_PINS as u32, Self::gpio_set);
+        self.init_gpio_out(&self.outlines);
+    }
+
+    fn apply_pin_update(&self, upd: PinUpdate) {
+        for i in 0..GPIO_NUM_PINS {
+            if (upd.mask & (1 << i)) != 0 {
+                let level = (upd.levels & (1 << i)) != 0;
+                self.outlines[i].set(level);
+                trace::trace_stm32f1xx_gpio_irq(i as u32, i32::from(level));
+            }
+        }
+    }
+
+    fn reset_hold(&self, _type: ResetType) {
+        trace::trace_stm32f1xx_gpio_reset();
+        let upd = self.regs.reset();
+        self.apply_pin_update(upd);
+    }
+
+    fn gpio_set(&self, line: u32, level: u32) {
+        let upd = self.regs.gpio_set(line as usize, level);
+        self.apply_pin_update(upd);
+    }
+
+    fn write(&self, offset: hwaddr, data: u64, size: u32) {
+        trace::trace_stm32f1xx_gpio_write(offset, data, size);
+        let upd = self.regs.write(offset, data as u32);
+        self.apply_pin_update(upd);
+    }
+
+    fn read(&self, offset: hwaddr, size: u32) -> u64 {
+        let value = self.regs.read(offset);
+        trace::trace_stm32f1xx_gpio_read(offset, u64::from(value), size);
+        u64::from(value)
+    }
+}
+
+impl ObjectImpl for Stm32f1xxGpioState {
+    type ParentType = SysBusDevice;
+
+    const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
+    const INSTANCE_INIT: Option<unsafe fn(ParentInit<Self>)> = Some(Self::init);
+    const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
+}
+
+impl DeviceImpl for Stm32f1xxGpioState {
+    const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_STM32F1XX_GPIO);
+}
+
+impl SysBusDeviceImpl for Stm32f1xxGpioState {}
+
+impl ResettablePhasesImpl for Stm32f1xxGpioState {
+    const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
+}
+
+const VMSTATE_STM32F1XX_GPIO: VMStateDescription<Stm32f1xxGpioState> =
+    VMStateDescriptionBuilder::<Stm32f1xxGpioState>::new()
+        .name(c"stm32f1xx-gpio")
+        .version_id(1)
+        .minimum_version_id(1)
+        .fields(vmstate_fields! {
+            vmstate_of!(Stm32f1xxGpioState, regs),
+        })
+        .build();
diff --git a/rust/hw/gpio/src/lib.rs b/rust/hw/gpio/src/lib.rs
new file mode 100644
index 0000000000..57a1420bb1
--- /dev/null
+++ b/rust/hw/gpio/src/lib.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+pub mod bindings;
+pub mod gpio;

-- 
2.53.0


