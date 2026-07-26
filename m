Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DECC531FA
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo0Cv-0005wA-V8; Sun, 26 Jul 2026 10:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0Cq-0005ua-GE
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:51:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0Ch-0005zo-82
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:51:55 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2caea3f742bso24353685ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785077504; x=1785682304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RGu17vjDGeJ3mfUvccD1KTtBIiIb8HX6pbI7ZxqAZFg=;
 b=bO8Iwaw2dIJeEEjk1vOK7wuTXv3jNA2cf/yjcx252QPavdufvrP8w8W+TeHmBwqFxK
 8aHJtj3lKQdPsyEIDhdmmihT+0UAGY0/EDkqeFBzT9jXK8U+WPUszc2o0nQwFEg3/EUX
 F2S7Qknr27+wP9CDgODJgjbDIlxxBQYEKeO7ykJdSTLzR0z3a6HJIejRuqPfmk/RnHy1
 4hvYOuh1YvIJoTeY3jcgTbxP2JKIuYjTqYfWcsJWOzUSmhExEAQprMT/K0cvzlYI1lS+
 v5FbNxhPTUaIPuAhKrcy/AV3B9JvJ9s4qJPKhB7Ejzf83iP5twpebwSubFVSUJ2KxEFs
 oaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785077504; x=1785682304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RGu17vjDGeJ3mfUvccD1KTtBIiIb8HX6pbI7ZxqAZFg=;
 b=Aaq0fCKaQBDsZ4hJC245J3TIvuqchmmowVX6C91U50izjAoKXGKDmFsFzH3/pP8JHV
 3aUNMk5cBRaVIjN6hURHKyuq6260/M3/WmEaeW/IoqNpGnR/U7aPS4xt0O7R4C1qt7GV
 09/74aGzAIzjal9MtKe3ZsU+cDaYOFjQvKMN1r5P1RKzn15joENUZpetB7tybSM49hLH
 uOUmx6KuT4rfXdCRMj8Eudl/uO/rcwqtWaqrVuwdgJ1Hoji+b8KFYvhfJr8IGEfUgpIZ
 NVU4OvJ5Z3en4gRysGm3sfcjq3d9gHPo2fm4kZ5IKUCFfbv6IaOFZItBKo0IkBKjChbC
 jIlA==
X-Gm-Message-State: AOJu0YwgLCCsPqcqc35tojD2i2TT03M1TZ3ltuQya3k/zLSfOlzTDUKS
 F8dAbAHktK14ZV4j2O+GyfTVY1Vg/mKd4nR/nDImBVcu5IQLgWSyiTDQdtbGeA==
X-Gm-Gg: AR+sD12pHuR3SmW5zEmanDnNMYv8xIDsAMxy1uhyWmmGpgbB+MLbvqhE0rI+5NWCSVe
 tNYOiCs8ax3z8SBszCawKW+8FwPy4CPvHOy5tx6P4alxYc5WpC+qVkqZKqHPujk4GXeFnlooYo9
 Hp/M+ia9QEetVKEi5sZH0ClMASTp7nY9H2CH8lcDwITh4M+TJT2NkKNJ8HvR2bwJo+5sBmRglex
 CipLEd2Li/YxC6f6yAasePqiw3/XCmS3iigaeS5NSbfp/e4kzl9ggHrbpXZweHI+LE2OdBcrqEg
 F6TmEsQ0ylwfL84dGf2TEe+vW4FlXOm0eem3Z2sUUbPkbh5EwBZo8LJDaGEbH1BcL8L3ofz+1GI
 9EUrDcUmyMES36qjOZRR12P0uMLeH+njXh9Xc/4yULPN8/yWrMZrZaMDj4eSRfjrZZNNowM+n6A
 y6fI3Zj4YYQQj6MtNZpbQ3PgDp
X-Received: by 2002:a17:902:e544:b0:2cc:f43b:fa4a with SMTP id
 d9443c01a7336-2cfde8253b7mr53274675ad.24.1785077503855; 
 Sun, 26 Jul 2026 07:51:43 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d7f5sm20934195ad.83.2026.07.26.07.51.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 26 Jul 2026 07:51:42 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 qemu-rust@nongnu.org, caojunze424@gmail.com,
 Jack Wang <163wangjack@gmail.com>
Subject: [RFC PATCH v1 1/5] hw/gpio: add stm32f1xx GPIO device model (Rust)
Date: Sun, 26 Jul 2026 22:51:15 +0800
Message-ID: <20260726145119.19881-2-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726145119.19881-1-163wangjack@gmail.com>
References: <20260726145119.19881-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62d.google.com
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

Add a native-Rust model of the STM32F1xx GPIO port (RM0008). The device
implements the CRL/CRH mode/config decode and the IDR update algorithm,
driving its 16 gpio-out lines from ODR according to each pin's push-pull,
open-drain or input pull configuration.

The pure register logic lives in GpioRegisters with no QOM/MemoryRegion
coupling so it can be unit-tested natively.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 MAINTAINERS                  |   7 +
 hw/gpio/Kconfig              |   5 +
 hw/gpio/trace-events         |   7 +
 rust/hw/gpio/Kconfig         |   2 +
 rust/hw/gpio/src/bindings.rs |  19 ++
 rust/hw/gpio/src/gpio.rs     | 539 +++++++++++++++++++++++++++++++++++
 rust/hw/gpio/src/lib.rs      |   3 +
 7 files changed, 582 insertions(+)
 create mode 100644 rust/hw/gpio/Kconfig
 create mode 100644 rust/hw/gpio/src/bindings.rs
 create mode 100644 rust/hw/gpio/src/gpio.rs
 create mode 100644 rust/hw/gpio/src/lib.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 72357df7c4..4870da54ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1184,6 +1184,13 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f100_soc.c
 
+STM32F1xx GPIO (Rust)
+M: Jack Wang <163wangjack@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: rust/hw/gpio/
+F: tests/qtest/stm32f103_gpio-test.c
+
 STM32F205
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294c20..3762135114 100644
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
index cea896b28f..c77c6e24a3 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -46,3 +46,10 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s addr: 0x%" PRIx64 " "
 stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr) "GPIO%s from: 0x%x to: 0x%x"
 stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPIO%s disconnected pins: 0x%x levels: 0x%x"
+
+# stm32f1xx GPIO Rust device
+stm32f1xx_gpio_instance_init(void) "instance init"
+stm32f1xx_gpio_reset(void) "reset"
+stm32f1xx_gpio_read(uint64_t offset, uint64_t value, unsigned size) "offset 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
+stm32f1xx_gpio_write(uint64_t offset, uint64_t value, unsigned size) "offset 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
+stm32f1xx_gpio_irq(unsigned line, int level) "line %u level %d"
diff --git a/rust/hw/gpio/Kconfig b/rust/hw/gpio/Kconfig
new file mode 100644
index 0000000000..1f2bc9e0e4
--- /dev/null
+++ b/rust/hw/gpio/Kconfig
@@ -0,0 +1,2 @@
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
index 0000000000..a8197d003d
--- /dev/null
+++ b/rust/hw/gpio/src/gpio.rs
@@ -0,0 +1,539 @@
+// STM32F1xx GPIO port device model (Rust)
+// Copyright 2026, Jack Wang
+// Author(s): Jack Wang <163wangjack@gmail.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Reference: ST RM0008, GPIO and AFIO registers.
+// The register model deliberately follows the C stm32l4x5_gpio.c IDR
+// algorithm, adapted to the F1 CRL/CRH (MODE[1:0]+CNF[1:0]) layout.
+//
+// The register state and all of its logic live in `GpioRegisters`, a plain
+// struct with no QOM/MMIO/IRQ coupling. `Stm32f1xxGpioState` is a thin QOM
+// device shell that owns a `GpioRegisters` plus the GPIO-out lines, forwards
+// MMIO/pin callbacks into it, and propagates the resulting pin-level changes
+// onto the out lines. Keeping the logic free of C dependencies lets the unit
+// tests in tests/tests.rs exercise it natively, without booting a machine.
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
+// Trace bindings are generated from hw/gpio/trace-events (group "hw_gpio").
+// Each `stm32f1xx_gpio_<name>` event yields a
+// `trace::trace_stm32f1xx_gpio_<name>` function whose argument types match the
+// trace-events declaration verbatim.
+::trace::include_trace!("hw_gpio");
+
+/// Register offsets (RM0008), shared by the device and its tests.
+pub const REG_CRL: u64 = 0x00;
+pub const REG_CRH: u64 = 0x04;
+pub const REG_IDR: u64 = 0x08;
+pub const REG_ODR: u64 = 0x0C;
+pub const REG_BSRR: u64 = 0x10;
+pub const REG_BRR: u64 = 0x14;
+pub const REG_LCKR: u64 = 0x18;
+
+/// RM0008 reset values: CRL/CRH = 0x44444444 (all pins floating input).
+pub const RESET_CRL: u32 = 0x4444_4444;
+pub const RESET_CRH: u32 = 0x4444_4444;
+
+/// Pure register state + behaviour of one GPIO port.
+///
+/// This holds no QOM object, no `MemoryRegion` and no `InterruptSource`, so it
+/// can be constructed and driven directly from unit tests. Methods that can
+/// change pin levels return a [`PinUpdate`] describing which output lines
+/// flipped; the QOM shell turns those into `InterruptSource` edges.
+#[repr(C)]
+#[derive(Debug)]
+pub struct GpioRegisters {
+    crl: BqlCell<u32>,
+    crh: BqlCell<u32>,
+    idr: BqlCell<u32>,
+    odr: BqlCell<u32>,
+    lckr: BqlCell<u32>,
+
+    // Bit i set  => pin i is not driven by an external source.
+    // Bit i clear => pin i is driven, and `pins_connected_high` bit i
+    //                gives the level driven.
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
+/// Which output pins changed level as a result of an operation.
+///
+/// `mask` bit i set means pin i has a determined level in `levels` bit i and
+/// that level differs from before the operation.
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
+    // ---- register accessors (for tests / vmstate / shell) ----
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
+    // ---- pin configuration helpers (decode CRL/CRH nibbles) ----
+
+    fn extract(value: u32, start: u32, length: u32) -> u32 {
+        assert!(length > 0 && length <= 32 - start);
+        (value >> start) & (!0u32 >> (32 - length))
+    }
+
+    // 4-bit MODE[1:0]+CNF[1:0] field for `pin`.
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
+    // MODE != 0 means output (any speed).
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
+    // Input with pull-up/pull-down selected: MODE=00, CNF=10 (0b1000).
+    fn is_input_pull_up_down_mode(&self, pin: usize) -> bool {
+        self.get_modecnf(pin) == 0b1000
+    }
+
+    // In pull mode, ODR bit selects pull-up (1) vs pull-down (0).
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
+                    "stm32f1xx_gpio: AF mode configured on pin {}. Downgrading to General Output \
+                     to keep simulation running.",
+                    pin
+                );
+            }
+        }
+    }
+
+    // ---- operations (all return which out pins changed) ----
+
+    /// Restore the RM0008 documented reset state.
+    pub fn reset(&self) -> PinUpdate {
+        self.crl.set(RESET_CRL);
+        self.crh.set(RESET_CRH);
+        self.idr.set(0);
+        self.odr.set(0);
+        self.lckr.set(0);
+        self.disconnected_pins.set(0xFFFF);
+        self.pins_connected_high.set(0);
+        self.update_gpio_idr()
+    }
+
+    /// External source drives pin `line` to `level`.
+    pub fn gpio_set(&self, line: usize, level: u32) -> PinUpdate {
+        // A push-pull output (or an open-drain output driven high) cannot be
+        // driven externally without a short-circuit; refuse it. An open-drain
+        // output driven low is allowed.
+        if self.is_output(line)
+            && !((self.is_alternate_open_drain(line) || self.is_general_open_drain(line))
+                && (level == 0))
+        {
+            log_mask_ln!(
+                Log::GuestError,
+                "stm32f1xx_gpio: Line {} can't be driven externally",
+                line
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
+    // Return mask of pins that are both configured in output mode and
+    // externally driven (except open-drain pins externally set to 0), which
+    // must be disconnected to avoid a short circuit.
+    fn get_gpio_pinmask_to_disconnect(&self) -> u16 {
+        let mut pins_to_disconnect: u16 = 0;
+        for i in 0..GPIO_NUM_PINS {
+            if (self.disconnected_pins.get() & (1 << i) == 0) && self.is_output(i) {
+                if self.is_general_push_pull(i)
+                    || self.is_alternate_push_pull(i)
+                    || (self.pins_connected_high.get() & (1 << i) != 0)
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
+    /// MMIO write. Returns the resulting output-pin changes.
+    pub fn write(&self, offset: u64, data: u32) -> PinUpdate {
+        match offset {
+            REG_CRL => {
+                self.crl.set(data);
+                self.check_and_warn_af(0);
+                // A pin reconfigured to output can no longer be driven.
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
+                self.lckr.set(data);
+                log_mask_ln!(
+                    Log::Unimp,
+                    "stm32f1xx_gpio: Locking port bits configuration isn't supported"
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
+    /// MMIO read.
+    pub fn read(&self, offset: u64) -> u32 {
+        match offset {
+            REG_CRL => self.crl.get(),
+            REG_CRH => self.crh.get(),
+            REG_IDR => self.idr.get(),
+            REG_ODR => self.odr.get(),
+            REG_BSRR => 0,
+            REG_BRR => 0,
+            REG_LCKR => self.lckr.get(),
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
+    /// Recompute IDR from the pin configuration and external drive state.
+    /// Returns which determined output pins changed level.
+    fn update_gpio_idr(&self) -> PinUpdate {
+        // new_idr_mask bit i => pin i has a determined level in new_idr.
+        let mut new_idr_mask = 0u32;
+        let mut new_idr = self.odr.get();
+        let old_idr = self.idr.get();
+
+        for i in 0..GPIO_NUM_PINS {
+            if self.is_output(i) {
+                if self.is_general_push_pull(i) || self.is_alternate_push_pull(i) {
+                    // push-pull output: pin follows ODR
+                    new_idr_mask |= 1 << i;
+                } else if (self.odr.get() & (1 << i)) == 0 {
+                    // open-drain, ODR 0: pin driven low
+                    new_idr_mask |= 1 << i;
+                } else if (self.disconnected_pins.get() & (1 << i)) == 0
+                    && (self.pins_connected_high.get() & (1 << i)) == 0
+                {
+                    // open-drain, ODR 1, externally pulled low
+                    new_idr &= !(1 << i);
+                    new_idr_mask |= 1 << i;
+                } else if self.is_input_pullup(i) {
+                    new_idr_mask |= 1 << i;
+                } else if self.is_input_pulldown(i) {
+                    new_idr &= !(1 << i);
+                    new_idr_mask |= 1 << i;
+                }
+                // otherwise open-drain ODR 1 floating: keep old value
+            } else if (self.disconnected_pins.get() & (1 << i)) == 0 {
+                // input/analog, externally driven
+                if (self.pins_connected_high.get() & (1 << i)) != 0 {
+                    new_idr_mask |= 1 << i;
+                    new_idr |= 1 << i;
+                } else {
+                    new_idr_mask |= 1 << i;
+                    new_idr &= !(1 << i);
+                }
+            } else {
+                // input/analog, not driven: pull-up/down or floating
+                if self.is_input_pullup(i) {
+                    new_idr |= 1 << i;
+                    new_idr_mask |= 1 << i;
+                } else if self.is_input_pulldown(i) {
+                    new_idr &= !(1 << i);
+                    new_idr_mask |= 1 << i;
+                }
+            }
+        }
+
+        self.idr
+            .set((old_idr & !new_idr_mask) | (new_idr & new_idr_mask));
+
+        // Report which determined pins actually flipped level.
+        let mut changed = 0u32;
+        for i in 0..GPIO_NUM_PINS {
+            if (new_idr_mask & (1 << i)) != 0
+                && ((new_idr & (1 << i)) != 0) != ((old_idr & (1 << i)) != 0)
+            {
+                changed |= 1 << i;
+            }
+        }
+        PinUpdate {
+            mask: changed,
+            levels: new_idr,
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
+    // One output line per pin, exposed as GPIO-out (to EXTI/board).
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
+        // Pin-change interrupts on F1 are delivered through EXTI, not a
+        // dedicated NVIC line, so the port only exposes GPIO in/out lines
+        // (no sysbus IRQ).
+        self.init_gpio_in(GPIO_NUM_PINS as u32, Self::gpio_set);
+        self.init_gpio_out(&self.outlines);
+    }
+
+    /// Drive the out lines according to a [`PinUpdate`].
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
+    // GPIO-in callback: external source drives a pin.
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
+// Migration: register block only; IRQ links are reconstructed on wire-up.
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


