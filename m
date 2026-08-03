Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05AFC55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0yE-0000Ht-Fw; Mon, 03 Aug 2026 18:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wquid-00021u-W6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:36:48 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wquia-0005Jt-QI
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1785771402;
 bh=iTPytU5dyaV1hpS4WYZk97uj/XpbO2GAedrjVNZhASk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fE860EYR4WySsqPvGxY2v8i0VZGdVPEqG43oZIE8kb5TUX1D3ZZh3aAJ8+CCA1CtT
 mhJo0FWFxIfuy5Kw9agtDpVT4bqalYLA3xuYtIxD9GjBbDxh/qz50aiaUqg1PwnEUQ
 IH8tFdTxtcJw4tDwJVtqp+2KJkjFRZ1Me5oZD8+I=
Received: from DESKTOP-8MIQOKD.localdomain ([117.13.168.66])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 72397CE1; Mon, 03 Aug 2026 23:28:35 +0800
X-QQ-mid: xmsmtpt1785770917tw7g1mf84
Message-ID: <tencent_FCE92B3279D69F2A244C2691DD5C3922DD09@qq.com>
X-QQ-XMAILINFO: OQ+eaxRKS8WJpgmiOOHsV4j8aITjdun2cVUbi/lX+oPtfzMF2JjE3vZ+5ACGR9
 HHiy92fJKpz50GSAZaM1zvHmBEdyTTAkIPTTxIJXWP0m2WRCA4qnTsjCoHOUcEBvcOu4y/Xxnj7b
 fw7ADl4qky4KxjkGqg2R3y/PBzQsPVhR3Amx4fa5RM7FBstxEPxAqeOC+7k+yfdl4de5MK5eu8tO
 HAjMMAqMD7V6gHaLnhhh25lJmbKaM+vCDy3qc86fF9rffhP86hxMRJKjx4nr27pHj+Vzx+MiJyHi
 1Fwb9FrJH3y232XV+X4Ug2nTDvcq+Xt0+sMyWQt2/TNlS/Co6hVYRebtMM5I6pM+AKHoUJzTg5Sr
 k/AsOg/alp1nhyxmyMqQ2KR3+ZB6E4mduxjubO28HjNI3ma0KNza//7JCTYKFiwqIMGaaG9ziAHa
 XZ+9iLfHym2dnUmkaqVEMluQXetYFMJmf0Xbbir2olKgPUpgSjKtfF8EXFGAfQ6qXtrQ6PH68uow
 aX8lLl8tZRuqowOyiirrQKbLnc+i4dUlzoiF7jn21YdvbeVOPH7eg+0fW9ggxCYXrzUXpSjNE5J0
 9VqAVS4cd1wRPvD2t+wUHCi86EbC4ZusJaQvl/E/vtTOWYZv8I9ML3avrWYokVJ7KzrsW41yn9gQ
 Ao0LUvgQyBIvhsRbcJoQdFniZLpfM13VCIhrvzFaGFhaVUHnX5niNiQsvMFCuSxSwjUVXn6nGPp+
 Qxu3L/D3vPXoJTQDj9aTe87kG22pfTXmksJSTGVzXCZorYrKjpMI7JOOANmg9xS1Pyljtr0WPhSp
 GuGyRNf1kDldN7Ga6RzIFovppk8iEvIPt5xMK5ruAX104xM9L9TMJWKBG1m0Ov6J7BDzKyTitkky
 WJ4s9rmQomNKSCmPPkd++h1TjFq9EWY/ZcW1iGIQ9/MuJ4rl2Tqwtl7SAcycn2krhup3rqPoDERs
 t+sUPdBDitcYvQU9kLW6S4cls/ejhXbHWO76C9zNJqVujqMwj2RfpCsgC24VEP44D9xn0QTlnNs7
 MuCFk4zYTkrYwLIk35mnNAwrLICakGBCJWKcvfN4ic3RIvcrz76gjcw2nz1XSFHSU9QtTF04iffa
 WBOG2acf/KVtFqImWYs3quAwRtu1w5Y8bD2xvyA3Q3hz2s5ebKhk6jc746TLzvVKvGWTcG
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: guochun.wang@foxmail.com
To: qemu-devel@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com, qemu-riscv@nongnu.org,
 guochun wang <guochun.wang@foxmail.com>
Subject: [PATCH 1/2] hw/gpio: add K230 GPIO controller model
Date: Mon,  3 Aug 2026 23:28:31 +0800
X-OQ-MSGID: <20260803152832.222022-2-guochun.wang@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803152832.222022-1-guochun.wang@foxmail.com>
References: <20260803152832.222022-1-guochun.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.48;
 envelope-from=guochun.wang@foxmail.com; helo=xmbghk7.mail.qq.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Aug 2026 18:17:05 -0400
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

From: guochun wang <guochun.wang@foxmail.com>

Implement a K230 SoC APB GPIO controller model for QEMU, derived from
the Synopsys DesignWare APB GPIO (the Linux gpio-k230 driver is based
on gpio-dwapb.c and shares the same register layout), with a
Canaan-specific compatible ("canaan,k230-apb-gpio") and hardlock
integration. The model is capable of running the Linux gpio-k230 driver
and driving external input/output lines. Behaviour follows the K230
Technical Reference Manual v0.3.1.

Implemented:
  - Port A registers: SWPORTA_DR/DDR/CTL, EXT_PORTA, INTEN, INTMASK,
    INTTYPE_LEVEL, INT_POLARITY, INTSTATUS, RAW_INTSTATUS, DEBOUNCE,
    LS_SYNC, INT_BOTHEDGE, PORTA_EOI, ID_CODE, VER_ID_CODE,
    CONFIG_REG1/2
  - Software control mode: DR drives output pad, DDR selects direction,
    EXT_PORTA multiplexes external input vs. DR by DDR
  - Per-pin IRQ output lines (single interrupt scheme), 32 per group
  - Edge detection: rising / falling / both-edge via INT_BOTHEDGE
  - Level-sensitive interrupts: active-high / active-low
  - PORTA_EOI clears edge interrupts only; level interrupts cleared by
    source removal or INTMASK
  - INTMASK masking and INTEN gating
  - DDR/CTL mode switching: no new interrupts while output/hardware mode,
    pending interrupts preserved; on switch back to input/software mode,
    level interrupts re-evaluated against current ext level, edge left
    untouched, per TRM v0.3.1
  - Three-phase Resettable API (enter/hold); VMState migration

Not implemented (no observable effect under QEMU):
  - Hardware control mode (aux_porta_out/en/in signals, single-ctl params)
  - Debounce logic (dbclk, glitch filtering, both-edge debounce timing)
  - Combined interrupt output (gpio_intr_flag OR of all lines)
  - Clock-domain synchronization (pclk_intr, ls_sync metastability
    registers, gpio_intrclk_en output)
  - Config-time parameters GPIO_PA_SYNC_EXT_DATA / GPIO_PA_SYNC_INTERRUPTS
    / GPIO_INT_BOTH_EDGE / GPIO_PORTX_SINGLE_CTL

Two controllers are instantiated in the K230 SoC (gpio0 at 0x9140B000,
gpio1 at 0x9140C000), replacing the previous unimplemented-device
placeholders. Each controller exposes 32 per-pin IRQ lines connected
to the PLIC:
  - GPIO0: PLIC sources 32..63
  - GPIO1: PLIC sources 64..95

Signed-off-by: guochun wang <guochun.wang@foxmail.com>
---
 MAINTAINERS                 |   2 +
 hw/gpio/Kconfig             |   3 +
 hw/gpio/k230_gpio.c         | 362 ++++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build         |   1 +
 hw/riscv/Kconfig            |   1 +
 hw/riscv/k230.c             |  27 ++-
 include/hw/gpio/k230_gpio.h |  73 ++++++++
 include/hw/riscv/k230.h     |   5 +
 8 files changed, 468 insertions(+), 6 deletions(-)
 create mode 100644 hw/gpio/k230_gpio.c
 create mode 100644 include/hw/gpio/k230_gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..4301d29f7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,8 +1827,10 @@ M: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
+F: hw/gpio/k230_gpio.c
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: include/hw/gpio/k230_gpio.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: tests/functional/riscv64/test_k230.py
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294c20..2d37a8bb6f 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,6 +16,9 @@ config SIFIVE_GPIO
 config STM32L4X5_GPIO
     bool
 
+config K230_GPIO
+    bool
+
 config PCA9552
     bool
     depends on I2C
diff --git a/hw/gpio/k230_gpio.c b/hw/gpio/k230_gpio.c
new file mode 100644
index 0000000000..a589d94712
--- /dev/null
+++ b/hw/gpio/k230_gpio.c
@@ -0,0 +1,362 @@
+/*
+ * QEMU K230 GPIO Controller
+ *
+ * Copyright (c) 2025 Wang Guochun <wdasn99@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18), section 12.5 GPIO
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+
+#include "hw/gpio/k230_gpio.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+static void k230_gpio_update_int(K230GPIOState *s)
+{
+    uint32_t masked_status = s->raw_intstatus & ~s->intmask & s->inten;
+    for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+        if (s->irq[i]) {
+            qemu_set_irq(s->irq[i], extract32(masked_status, i, 1));
+        }
+    }
+}
+
+static void k230_gpio_set_int_line(K230GPIOState *s, int line, int level)
+{
+    if (line >= K230_GPIO_PINS_PER_GROUP) {
+        return;
+    }
+
+    uint32_t prev_level = extract32(s->ext_porta, line, 1);
+    uint32_t curr_level = level;
+
+    s->ext_porta = deposit32(s->ext_porta, line, 1, curr_level);
+
+    if (extract32(s->swporta_ddr, line, 1)) {
+        return;
+    }
+
+    if (extract32(s->swporta_ctl, line, 1)) {
+        return;
+    }
+
+    uint32_t pol = extract32(s->int_polarity, line, 1);
+    uint32_t both = extract32(s->int_bothedge, line, 1);
+    uint32_t is_level = !extract32(s->inttype_level, line, 1);
+
+    if (both) {
+        if (prev_level != curr_level) {
+            s->raw_intstatus |= (1U << line);
+        }
+    } else if (is_level) {
+        if (curr_level == pol) {
+            s->raw_intstatus |= (1U << line);
+        } else {
+            s->raw_intstatus &= ~(1U << line);
+        }
+    } else {
+        if (prev_level != curr_level && curr_level == pol) {
+            s->raw_intstatus |= (1U << line);
+        }
+    }
+}
+
+static void k230_gpio_set(void *opaque, int line, int level)
+{
+    K230GPIOState *s = K230_GPIO(opaque);
+
+    k230_gpio_set_int_line(s, line, level);
+    k230_gpio_update_int(s);
+}
+
+static void k230_gpio_set_all_output_lines(K230GPIOState *s)
+{
+    int i;
+
+    for (i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+        if (extract32(s->swporta_ddr, i, 1) && s->output[i]) {
+            qemu_set_irq(s->output[i], extract32(s->swporta_dr, i, 1));
+        }
+    }
+}
+
+static uint64_t k230_gpio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    K230GPIOState *s = K230_GPIO(opaque);
+
+    switch (offset) {
+    case K230_GPIO_SWPORTA_DR:
+        return s->swporta_dr;
+    case K230_GPIO_SWPORTA_DDR:
+        return s->swporta_ddr;
+    case K230_GPIO_SWPORTA_CTL:
+        return s->swporta_ctl;
+    case K230_GPIO_INTEN:
+        return s->inten;
+    case K230_GPIO_INTMASK:
+        return s->intmask;
+    case K230_GPIO_INTTYPE_LEVEL:
+        return s->inttype_level;
+    case K230_GPIO_INT_POLARITY:
+        return s->int_polarity;
+    case K230_GPIO_INTSTATUS:
+        return s->raw_intstatus & ~s->intmask;
+    case K230_GPIO_RAW_INTSTATUS:
+        return s->raw_intstatus;
+    case K230_GPIO_DEBOUNCE:
+        return s->debounce;
+    case K230_GPIO_EXT_PORTA:
+        return (s->ext_porta & ~s->swporta_ddr) |
+               (s->swporta_dr & s->swporta_ddr);
+    case K230_GPIO_LS_SYNC:
+        return s->ls_sync;
+    case K230_GPIO_ID_CODE:
+        return s->id_code;
+    case K230_GPIO_INT_BOTHEDGE:
+        return s->int_bothedge;
+    case K230_GPIO_VER_ID_CODE:
+        return s->ver_id_code;
+    case K230_GPIO_CONFIG_REG2:
+        return s->config_reg2;
+    case K230_GPIO_CONFIG_REG1:
+        return s->config_reg1;
+    case K230_GPIO_PORTA_EOI:
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_K230_GPIO, __func__, offset);
+        return 0;
+    }
+}
+
+static void k230_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                            unsigned size)
+{
+    K230GPIOState *s = K230_GPIO(opaque);
+
+    switch (offset) {
+    case K230_GPIO_SWPORTA_DR:
+        s->swporta_dr = value;
+        k230_gpio_set_all_output_lines(s);
+        break;
+    case K230_GPIO_SWPORTA_DDR: {
+        uint32_t prev_ddr = s->swporta_ddr;
+        s->swporta_ddr = value;
+        k230_gpio_set_all_output_lines(s);
+        for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+            /* Skip pins whose direction did not change */
+            if (extract32(prev_ddr, i, 1) == extract32(s->swporta_ddr, i, 1)) {
+                continue;
+            }
+            /*
+             * When switching back to input mode (and still in software
+             * control), re-evaluate level-sensitive interrupts. Edge
+             * interrupts are left untouched, matching the manual TRM v0.3.1.
+             */
+            if (!extract32(s->swporta_ddr, i, 1) &&
+                !extract32(s->swporta_ctl, i, 1)) {
+                uint32_t is_level = !extract32(s->inttype_level, i, 1);
+                if (is_level) {
+                    uint32_t curr_level = extract32(s->ext_porta, i, 1);
+                    uint32_t pol = extract32(s->int_polarity, i, 1);
+                    if (curr_level == pol) {
+                        s->raw_intstatus |= (1U << i);
+                    } else {
+                        s->raw_intstatus &= ~(1U << i);
+                    }
+                }
+            }
+        }
+        k230_gpio_update_int(s);
+        break;
+    }
+    case K230_GPIO_SWPORTA_CTL: {
+        uint32_t prev_ctl = s->swporta_ctl;
+        s->swporta_ctl = value;
+        for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+            /* Skip pins whose control mode did not change */
+            if (extract32(prev_ctl, i, 1) == extract32(s->swporta_ctl, i, 1)) {
+                continue;
+            }
+            /*
+             * When switching back from hardware to software control (and DDR
+             * is input), re-evaluate level-sensitive interrupts. Edge
+             * interrupts are left untouched, matching the manual TRM v0.3.1.
+             */
+            if (!extract32(s->swporta_ddr, i, 1) &&
+                !extract32(s->swporta_ctl, i, 1)) {
+                uint32_t is_level = !extract32(s->inttype_level, i, 1);
+                if (is_level) {
+                    uint32_t curr_level = extract32(s->ext_porta, i, 1);
+                    uint32_t pol = extract32(s->int_polarity, i, 1);
+                    if (curr_level == pol) {
+                        s->raw_intstatus |= (1U << i);
+                    } else {
+                        s->raw_intstatus &= ~(1U << i);
+                    }
+                }
+            }
+        }
+        k230_gpio_update_int(s);
+        break;
+    }
+    case K230_GPIO_INTEN:
+        s->inten = value;
+        k230_gpio_update_int(s);
+        break;
+    case K230_GPIO_INTMASK:
+        s->intmask = value;
+        k230_gpio_update_int(s);
+        break;
+    case K230_GPIO_INTTYPE_LEVEL:
+        s->inttype_level = value;
+        break;
+    case K230_GPIO_INT_POLARITY:
+        s->int_polarity = value;
+        break;
+    case K230_GPIO_DEBOUNCE:
+        s->debounce = value;
+        break;
+    case K230_GPIO_PORTA_EOI:
+        for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+            if (extract32(value, i, 1) && extract32(s->inttype_level, i, 1)) {
+                s->raw_intstatus = deposit32(s->raw_intstatus, i, 1, 0);
+            }
+        }
+        k230_gpio_update_int(s);
+        break;
+    case K230_GPIO_LS_SYNC:
+        s->ls_sync = value;
+        break;
+    case K230_GPIO_ID_CODE:
+        break;
+    case K230_GPIO_INT_BOTHEDGE:
+        s->int_bothedge = value;
+        break;
+    case K230_GPIO_VER_ID_CODE:
+        break;
+    case K230_GPIO_CONFIG_REG2:
+        break;
+    case K230_GPIO_CONFIG_REG1:
+        break;
+    case K230_GPIO_INTSTATUS:
+        break;
+    case K230_GPIO_RAW_INTSTATUS:
+        break;
+    case K230_GPIO_EXT_PORTA:
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_K230_GPIO, __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_gpio_ops = {
+    .read = k230_gpio_read,
+    .write = k230_gpio_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_k230_gpio = {
+    .name = TYPE_K230_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(swporta_dr, K230GPIOState),
+        VMSTATE_UINT32(swporta_ddr, K230GPIOState),
+        VMSTATE_UINT32(swporta_ctl, K230GPIOState),
+        VMSTATE_UINT32(inten, K230GPIOState),
+        VMSTATE_UINT32(intmask, K230GPIOState),
+        VMSTATE_UINT32(inttype_level, K230GPIOState),
+        VMSTATE_UINT32(int_polarity, K230GPIOState),
+        VMSTATE_UINT32(intstatus, K230GPIOState),
+        VMSTATE_UINT32(raw_intstatus, K230GPIOState),
+        VMSTATE_UINT32(debounce, K230GPIOState),
+        VMSTATE_UINT32(ext_porta, K230GPIOState),
+        VMSTATE_UINT32(ls_sync, K230GPIOState),
+        VMSTATE_UINT32(int_bothedge, K230GPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_gpio_enter_reset(Object *obj, ResetType type)
+{
+    K230GPIOState *s = K230_GPIO(obj);
+
+    s->swporta_dr = 0;
+    s->swporta_ddr = 0;
+    s->swporta_ctl = 0;
+    s->inten = 0;
+    s->intmask = 0;
+    s->inttype_level = 0;
+    s->int_polarity = 0;
+    s->intstatus = 0;
+    s->raw_intstatus = 0;
+    s->debounce = 0;
+    s->porta_eoi = 0;
+    s->ext_porta = 0;
+    s->ls_sync = 0;
+    s->id_code = 0;
+    s->int_bothedge = 0;
+    s->ver_id_code = 0;
+    s->config_reg2 = 0;
+    s->config_reg1 = 0;
+}
+
+static void k230_gpio_hold_reset(Object *obj, ResetType type)
+{
+    K230GPIOState *s = K230_GPIO(obj);
+
+    k230_gpio_update_int(s);
+}
+
+static void k230_gpio_realize(DeviceState *dev, Error **errp)
+{
+    K230GPIOState *s = K230_GPIO(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &k230_gpio_ops, s,
+                          TYPE_K230_GPIO, K230_GPIO_MEM_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    qdev_init_gpio_in(DEVICE(s), k230_gpio_set, K230_GPIO_PINS_PER_GROUP);
+    qdev_init_gpio_out(DEVICE(s), s->output, K230_GPIO_PINS_PER_GROUP);
+
+    for (i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+}
+
+static void k230_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = k230_gpio_realize;
+    rc->phases.enter = k230_gpio_enter_reset;
+    rc->phases.hold = k230_gpio_hold_reset;
+    dc->vmsd = &vmstate_k230_gpio;
+    dc->desc = "K230 GPIO controller";
+}
+
+static const TypeInfo k230_gpio_info = {
+    .name = TYPE_K230_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230GPIOState),
+    .class_init = k230_gpio_class_init,
+};
+
+static void k230_gpio_register_types(void)
+{
+    type_register_static(&k230_gpio_info);
+}
+
+type_init(k230_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 6a67ee958f..94b5d9e2fa 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -19,3 +19,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_K230_GPIO', if_true: files('k230_gpio.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..410877425c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_GPIO
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..62967a67d0 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,8 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-gpio0", &s->gpio[0], TYPE_K230_GPIO);
+    object_initialize_child(obj, "k230-gpio1", &s->gpio[1], TYPE_K230_GPIO);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -206,6 +208,25 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    /* GPIO */
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio[0]), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[0]), 0,
+                    memmap[K230_DEV_GPIO0].base);
+    for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[0]), i,
+                           qdev_get_gpio_in(DEVICE(s->c908_plic),
+                                            K230_GPIO0_IRQ_BASE + i));
+    }
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio[1]), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[1]), 0,
+                    memmap[K230_DEV_GPIO1].base);
+    for (int i = 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[1]), i,
+                           qdev_get_gpio_in(DEVICE(s->c908_plic),
+                                            K230_GPIO1_IRQ_BASE + i));
+    }
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -322,12 +343,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
                                 memmap[K230_DEV_PWM].size);
 
-    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
-                                memmap[K230_DEV_GPIO0].size);
-
-    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
-                                memmap[K230_DEV_GPIO1].size);
-
     create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
                                 memmap[K230_DEV_ADC].size);
 
diff --git a/include/hw/gpio/k230_gpio.h b/include/hw/gpio/k230_gpio.h
new file mode 100644
index 0000000000..2e52bbf760
--- /dev/null
+++ b/include/hw/gpio/k230_gpio.h
@@ -0,0 +1,73 @@
+/*
+ * QEMU K230 GPIO Controller
+ *
+ * Copyright (c) 2025 Wang Guochun <wdasn99@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18), section 12.5 GPIO
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+
+#ifndef HW_K230_GPIO_H
+#define HW_K230_GPIO_H
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_GPIO "k230.gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(K230GPIOState, K230_GPIO)
+
+#define K230_GPIO_MEM_SIZE 0x1000
+
+#define K230_GPIO_SWPORTA_DR      0x00
+#define K230_GPIO_SWPORTA_DDR     0x04
+#define K230_GPIO_SWPORTA_CTL     0x08
+#define K230_GPIO_INTEN           0x30
+#define K230_GPIO_INTMASK         0x34
+#define K230_GPIO_INTTYPE_LEVEL   0x38
+#define K230_GPIO_INT_POLARITY    0x3c
+#define K230_GPIO_INTSTATUS       0x40
+#define K230_GPIO_RAW_INTSTATUS   0x44
+#define K230_GPIO_DEBOUNCE        0x48
+#define K230_GPIO_PORTA_EOI       0x4c
+#define K230_GPIO_EXT_PORTA       0x50
+#define K230_GPIO_LS_SYNC         0x60
+#define K230_GPIO_ID_CODE         0x64
+#define K230_GPIO_INT_BOTHEDGE    0x68
+#define K230_GPIO_VER_ID_CODE     0x6c
+#define K230_GPIO_CONFIG_REG2     0x70
+#define K230_GPIO_CONFIG_REG1     0x74
+
+#define K230_GPIO_PINS_PER_GROUP 32
+
+struct K230GPIOState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t swporta_dr;
+    uint32_t swporta_ddr;
+    uint32_t swporta_ctl;
+    uint32_t inten;
+    uint32_t intmask;
+    uint32_t inttype_level;
+    uint32_t int_polarity;
+    uint32_t intstatus;
+    uint32_t raw_intstatus;
+    uint32_t debounce;
+    uint32_t porta_eoi;
+    uint32_t ext_porta;
+    uint32_t ls_sync;
+    uint32_t id_code;
+    uint32_t int_bothedge;
+    uint32_t ver_id_code;
+    uint32_t config_reg2;
+    uint32_t config_reg1;
+
+    qemu_irq irq[K230_GPIO_PINS_PER_GROUP];
+    qemu_irq output[K230_GPIO_PINS_PER_GROUP];
+};
+
+#endif
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..5fccea7fd5 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/gpio/k230_gpio.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230GPIOState gpio[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -127,8 +129,11 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_GPIO0_IRQ_BASE  = 32,
+    K230_GPIO1_IRQ_BASE  = 64,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
+
 };
 
 #define K230_UART_COUNT 5
-- 
2.43.0


