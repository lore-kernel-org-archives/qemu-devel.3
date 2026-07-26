Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F760C53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo0DI-00063o-05; Sun, 26 Jul 2026 10:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0D8-0005yv-Q1
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:52:15 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wo0D6-00063I-Sy
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:52:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ceae1ed204so19242065ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785077531; x=1785682331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QoTWc3iMRVDAE87hZh8x5OJDt+vuk8Y9yYBBrbPBSAo=;
 b=eNsxMuGo1duma8nBqmm+YeJr7cCjCG8R9zVebVFZk1xDQy61mgRIZ/rTeSv62g04il
 UToa3db+asnmIfy4f0unlnR1yGZUTPN4YnO1xwzAHBgaDJ479KzD9Ub6NBPkuXT7S1n5
 ccCjAMHdRz5cQOUCu79UBGUdDPgIk0UOgsuEr8md2kch7zxYt3GF0c5eYgD1akMcpKEC
 hMN+4yT/JbMmpmNOOcGn/6JTLqyJDawidVZrMiNDoY2mAr+t/DslkuQLizWJVb2iK08K
 W8dpnrXz2Nh9JMWXSZUjWCqrzQxwCR97FlAx07COxcqDfh68zfjEDnuJzQutV6SxPxRR
 MFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785077531; x=1785682331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QoTWc3iMRVDAE87hZh8x5OJDt+vuk8Y9yYBBrbPBSAo=;
 b=daKP9wsIpl/K6mnagwbTyENjlECSR3xmaS4DyyWik0OukXzLD5ljAlDrnvbQJg+A39
 2bJSByjXxuUihpj9V3ru8BjPiPpkAbQCgvrJwGucbuLhI9Oh7D89LVkgPJbpae0bKvm2
 KFVXHqTNSj457JADGu1T2nmvBbWgrZHWd461HhvvlLWbERHmPMUvGqJShPi3zmY1FYxA
 FyHruIPWkaTlE5KmY9fXll71XEnjYaVoatek0vs51Wb8m261jEN+YY4+YElAdTKnY3MF
 LC7KsozvD9Fphd4WDqhJMXXrN6Wa3AXADtzmgek/VTHfP0x+y2MrvNaJMN29lG6fHroy
 yyyQ==
X-Gm-Message-State: AOJu0YxniYa1l899zO9Y+nvIDSzuTOqF91lhuZaiO7NhFrD+F1D1YSHU
 TxNnVd8reS5GpA1KCO5xaCZILwFT+DemKKV1nFMUGf8J9iucw1SsL/nDosrXfw==
X-Gm-Gg: AR+sD11J2ikAZ0S4BaHJJP+nHzPCO12Wv8F+euUCDz2Xw30lcZPEDKnjgPe5rbBJqz7
 wPSVXmgBB073mAnJpaF7ozBkYyLnRvYZmEKD1QeyJbQf7w98iJTyHbHgLqiSLjerEMtBEiV4exT
 VTY0/Nwwo8ZE5kaIArZqRdoZ7gO0kdX9QOSW/u3knummpj8R3w4ikWWKRfTp92sDCd/3yAD76Dg
 JJgI3DCHm63H3LV9ZtVz5R7yvGUOAROjUwYfefOh5u/8he7PPox8n2kZG2SmAdYnyLoXtkGpgCR
 keXhE/pRaHFqanITnOfZ23X60HsjTzVjRmONzuv9qZ9AKliGYfjQVRaXJTeuDVSNvR9qoKWftHs
 HSHwuMWsJrqgyxFl7Ebg4dW/ThHpbX/JCysKwGVGbku/fnwrYjpvMppQ2oXRjwYnx4kHya1joEQ
 H1EdpQ6uJD5lS39/FprdHpo4iU
X-Received: by 2002:a17:903:22cc:b0:2c9:97a7:f543 with SMTP id
 d9443c01a7336-2cfde885feamr52557135ad.41.1785077531314; 
 Sun, 26 Jul 2026 07:52:11 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d7f5sm20934195ad.83.2026.07.26.07.52.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 26 Jul 2026 07:52:10 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 qemu-rust@nongnu.org, caojunze424@gmail.com,
 Jack Wang <163wangjack@gmail.com>
Subject: [RFC PATCH v1 5/5] rust/hw/gpio: add native unit tests
Date: Sun, 26 Jul 2026 22:51:19 +0800
Message-ID: <20260726145119.19881-6-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726145119.19881-1-163wangjack@gmail.com>
References: <20260726145119.19881-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x635.google.com
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

Add native Rust unit tests that link GpioRegisters directly and exercise
the CRL/CRH decode and IDR update algorithm in-process, without booting a
machine or pulling in the softmmu memory subsystem.

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 rust/hw/gpio/tests/tests.rs | 191 ++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100644 rust/hw/gpio/tests/tests.rs

diff --git a/rust/hw/gpio/tests/tests.rs b/rust/hw/gpio/tests/tests.rs
new file mode 100644
index 0000000000..ca4d5ed4d6
--- /dev/null
+++ b/rust/hw/gpio/tests/tests.rs
@@ -0,0 +1,191 @@
+// Native Rust unit tests for the STM32F1xx GPIO register logic.
+//
+// Copyright 2026, Jack Wang
+// Author(s): Jack Wang <163wangjack@gmail.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Unlike tests/qtest/stm32f103_gpio-test.c (which drives the device over a
+// socket from an external qemu-system-arm process), these tests link the
+// device crate directly and exercise `GpioRegisters` in-process. This gives
+// fast, native Rust coverage of the CRL/CRH decode + IDR algorithm without
+// booting a machine or pulling in the softmmu memory subsystem.
+//
+// `GpioRegisters` deliberately has no QOM object, no MemoryRegion and no
+// InterruptSource, so it can be constructed with `GpioRegisters::new()` and
+// called directly. Only the BQL mock (bql::start_test) is required, because
+// the register cells are `BqlCell`s.
+//
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use stm32f1xx_gpio::gpio::{
+    GpioRegisters, PinUpdate, REG_BRR, REG_BSRR, REG_CRH, REG_CRL, REG_IDR, REG_ODR, RESET_CRH,
+    RESET_CRL,
+};
+
+/// Take the mock BQL so `BqlCell` accesses are permitted. Integration tests
+/// run with `--test-threads=1`, so this is safe to call from every test.
+fn regs() -> GpioRegisters {
+    bql::start_test();
+    GpioRegisters::new()
+}
+
+// 4-bit MODE[1:0]+CNF[1:0] pin configurations (RM0008).
+const CFG_INPUT_FLOATING: u32 = 0x4; // MODE=00 CNF=01 (reset default)
+const CFG_INPUT_PULL: u32 = 0x8; // MODE=00 CNF=10, ODR selects up/down
+const CFG_OUTPUT_PP: u32 = 0x1; // MODE=01 CNF=00, general push-pull
+
+/// Set the 4-bit config nibble for `pin` in CRL/CRH via an MMIO write.
+fn set_config(r: &GpioRegisters, pin: usize, cfg: u32) {
+    let reg = if pin < 8 { REG_CRL } else { REG_CRH };
+    let shift = ((pin % 8) * 4) as u32;
+    let old = r.read(reg);
+    r.write(reg, (old & !(0xF << shift)) | (cfg << shift));
+}
+
+fn set_odr_bit(r: &GpioRegisters, pin: usize, value: u32) {
+    let old = r.read(REG_ODR);
+    r.write(REG_ODR, (old & !(1 << pin)) | (value << pin));
+}
+
+/// True if pin `pin` is set in a [`PinUpdate`] and its reported level is
+/// `level`.
+fn pin_changed_to(upd: PinUpdate, pin: usize, level: bool) -> bool {
+    (upd.mask & (1 << pin)) != 0 && (((upd.levels >> pin) & 1) != 0) == level
+}
+
+#[test]
+/// A freshly created register block holds the RM0008 reset values.
+fn test_reset_values() {
+    let r = regs();
+    assert_eq!(r.read(REG_CRL), RESET_CRL);
+    assert_eq!(r.read(REG_CRH), RESET_CRH);
+    assert_eq!(r.read(REG_IDR), 0);
+    assert_eq!(r.read(REG_ODR), 0);
+}
+
+#[test]
+/// `reset` restores the reset state after the registers are dirtied.
+fn test_reset_restores() {
+    let r = regs();
+    r.write(REG_CRL, 0xDEAD_BEEF);
+    r.write(REG_ODR, 0x0000_FFFF);
+    assert_ne!(r.read(REG_CRL), RESET_CRL);
+
+    r.reset();
+
+    assert_eq!(r.read(REG_CRL), RESET_CRL);
+    assert_eq!(r.read(REG_CRH), RESET_CRH);
+    assert_eq!(r.read(REG_IDR), 0);
+    assert_eq!(r.read(REG_ODR), 0);
+}
+
+#[test]
+/// Push-pull output: IDR follows ODR; ODR written while input is latched,
+/// and the out-pin change is reported.
+fn test_output_mode() {
+    let r = regs();
+    let pin = 5;
+
+    // Set ODR while still a floating input: IDR unaffected, no out change.
+    let idle = set_odr_and_report(&r, pin, 1);
+    assert_eq!(r.read(REG_IDR), 0);
+    assert_eq!(idle.mask & (1 << pin), 0);
+
+    // Switch to push-pull output: pin now follows ODR (high), and flips.
+    let old = r.read(REG_CRL);
+    let to_output = r.write(
+        REG_CRL,
+        (old & !(0xF << (pin * 4))) | (CFG_OUTPUT_PP << (pin * 4)),
+    );
+    assert_eq!(r.read(REG_IDR), 1 << pin);
+    assert!(pin_changed_to(to_output, pin, true));
+
+    // Clear ODR bit: pin goes low, and flips back.
+    let to_low = set_odr_and_report(&r, pin, 0);
+    assert_eq!(r.read(REG_IDR), 0);
+    assert!(pin_changed_to(to_low, pin, false));
+}
+
+/// Helper: write one ODR bit and return the resulting [`PinUpdate`].
+fn set_odr_and_report(r: &GpioRegisters, pin: usize, value: u32) -> PinUpdate {
+    let old = r.read(REG_ODR);
+    r.write(REG_ODR, (old & !(1 << pin)) | (value << pin))
+}
+
+#[test]
+/// Floating input: an external drive is reflected in IDR and reported.
+fn test_input_mode() {
+    let r = regs();
+    let pin = 6usize;
+
+    set_config(&r, pin, CFG_INPUT_FLOATING);
+
+    let drive_high = r.gpio_set(pin, 1);
+    assert_eq!(r.read(REG_IDR), 1 << pin);
+    assert!(pin_changed_to(drive_high, pin, true));
+
+    let drive_low = r.gpio_set(pin, 0);
+    assert_eq!(r.read(REG_IDR), 0);
+    assert!(pin_changed_to(drive_low, pin, false));
+}
+
+#[test]
+/// Input pull mode: ODR selects pull-up (IDR=1) vs pull-down (IDR=0),
+/// with no external driver connected.
+fn test_pull_up_down() {
+    let r = regs();
+    let pin = 0;
+
+    set_odr_bit(&r, pin, 1);
+    set_config(&r, pin, CFG_INPUT_PULL);
+    assert_eq!(r.read(REG_IDR), 1 << pin);
+
+    set_odr_bit(&r, pin, 0);
+    assert_eq!(r.read(REG_IDR), 0);
+}
+
+#[test]
+/// BSRR sets/resets ODR bits (set has priority); BRR resets ODR bits.
+fn test_bsrr_brr() {
+    let r = regs();
+    let pin = 1;
+
+    r.write(REG_BSRR, 1 << pin);
+    assert_eq!(r.read(REG_ODR), 1 << pin);
+
+    r.write(REG_BSRR, 1 << (pin + 16));
+    assert_eq!(r.read(REG_ODR), 0);
+
+    r.write(REG_BSRR, 1 << pin);
+    r.write(REG_BRR, 1 << pin);
+    assert_eq!(r.read(REG_ODR), 0);
+
+    // Set has priority over reset within one BSRR write.
+    r.write(REG_BSRR, (1 << pin) | (1 << (pin + 16)));
+    assert_eq!(r.read(REG_ODR), 1 << pin);
+}
+
+#[test]
+/// A pin driven externally, then reconfigured as push-pull output, is
+/// disconnected: IDR follows ODR, not the stale external level.
+fn test_push_pull_disconnect() {
+    let r = regs();
+    let pin = 7usize;
+
+    // Drive high externally as input.
+    set_config(&r, pin, CFG_INPUT_FLOATING);
+    r.gpio_set(pin, 1);
+    assert_eq!(r.read(REG_IDR), 1 << pin);
+    assert_eq!(r.disconnected_pins() & (1 << pin), 0); // now connected
+
+    // Reconfigure as push-pull output with ODR=0: pin must drop to 0,
+    // and the external driver must be disconnected.
+    set_odr_bit(&r, pin, 0);
+    set_config(&r, pin, CFG_OUTPUT_PP);
+    assert_eq!(r.read(REG_IDR), 0);
+    assert_ne!(r.disconnected_pins() & (1 << pin), 0); // disconnected again
+
+    // Further external drives are ignored while output push-pull.
+    r.gpio_set(pin, 1);
+    assert_eq!(r.read(REG_IDR), 0);
+}
-- 
2.53.0


