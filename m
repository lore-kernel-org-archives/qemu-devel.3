Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62946C5AD44
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 18:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wslq6-0000Vw-2k; Sat, 08 Aug 2026 14:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslpv-0000ID-1G
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:32:02 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslps-0007gu-Vy
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:31:58 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so447651a91.0
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786213913; x=1786818713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M6SoCg6vQ+JGBOPRciaNgEEqNUscszLCnP78OgJYwLY=;
 b=gnmPBBD4n6oU2xotRhQpwBUrt5JLq1OCzDCCTrxXiPSqQTrtv4uiAU4I45FKVavXGi
 0yMy8KVOLXL9TqxQErdzjmtnX18jXmMLjHm4StyUL7jSgFz3DQ8NUQf9Ltkzq3+i/IB2
 CBmN8bi5lQP/ja0qTXO9tMo/D3Cjm3RbMOypZet7GT2LcqC2Vb13y9slXyhmh6FkduRm
 Ja0dreCsp6l+qfD7CgrycIoMWgaLrOjVgncQDa3jsJ56AwKlh7HfYukPQH72Smih9UZ8
 5e6MlcAsfqEPWg/npt9wDxozVxSuCTZDmOuqqgYLskE0Z2sraZPDvD0qz7Mb7N4bm07t
 xZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786213913; x=1786818713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M6SoCg6vQ+JGBOPRciaNgEEqNUscszLCnP78OgJYwLY=;
 b=VE58yCxodLlxNpfTk1UanHFmmyX4vA6CawHL5+FqAGpPWbX2bIcV/qDjSZzFo20QYI
 6F7KE2Hp8q3FcI/Paxz6MNbU+ZnBv7lZCGm4IAn7Q5CKXkudHst6UGBVnMomzD5Y92Ty
 KAnY7JQ6jdrN8/+VJ+qAueo9QnDWMLjNDxAqohn+bDmBGLEyU6V3PYA2v0wGT0jqjLbM
 ELGLIZU7mVimAPxYFlW5g2A3yopvaSLCS7nVfNXGX/+6k7vL9j6yJZN3Sw7qbh+nNeUn
 raZZzD7UwDTfDXDox4rwssI/B6nySysI/ry/Zjwxq5uaSuh4BOPgnI40Ej/E+M0m9wus
 ZD+w==
X-Gm-Message-State: AOJu0YxcULyVh7AOhfv6Rnlnd7tK41pV2OOA6she02G1wCj2To9oCu66
 dt8KY8Uw4vlWyLpo+9O51u/TELgPnFZJxC7xcqEezBThTO4FlEcVlOtKWpOhLFKdw+WhVA==
X-Gm-Gg: AR+sD10o5nNCdB/J00K5Aq/hY8gauwc9s22Ml7k3XdLccPxfoe119uHTQ3Um5eDj/RP
 HmztmxYAYcsXZ1IcCBHPczEGgG5PfOKpwBLVNe215+OlXJrs4B+ox1NeZgxeat9UhSDAFfsCT+o
 xobZpL8xqZHy12U/8qVRu2Zwlxucpn+FTu5DxVKY9IJHBRA7zSz9xznA41bw4Yn37WdYiPoVhHE
 q846GlBSkz7jOdBZKSZXbwER0NQkyJtABSM2gLyJ6QZGSLf4aeq0RpmMqAZg9WkroE6MsWsUhtk
 GsjLTcjvC3fAHw81S35/1V0FRZpHC1Q1hNGuzJFtXON3BoXZgmv/UhDFxYJPK6Ve5c6jNd/cOwj
 UHeqDm004SptyOdyxKLbgB0OESbVOncLdhrAy7X+UojGIA5FtfK1TmF3qxLTq+HZpHdiSR6T2LX
 +ogHgJZ5gy9UQmA7Knol2MVzljo+mvrjttEsJ+bJ0ollHDg5UUdvof/GNrS92GHU43SAjA1hQrY
 SS5gIuThM6CjTnuCw==
X-Received: by 2002:a17:90b:3eca:b0:37f:9e21:91d6 with SMTP id
 98e67ed59e1d1-392846ac637mr3312739a91.13.1786213913377; 
 Sat, 08 Aug 2026 11:31:53 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8a00:6035:79d0:50fd:3a6e:508:beb2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6c13asm6772393a91.2.2026.08.08.11.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 11:31:52 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v3 4/5] hw/riscv/k230: Route SSI interrupts to the PLIC
Date: Sun,  9 Aug 2026 02:29:55 +0800
Message-ID: <20260808182956.290561-5-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Connect the nine interrupt outputs of each K230 DWC SSI controller to the
documented PLIC source range.

The TXU, DONE, and AXIE lines are wired to preserve the physical K230
interrupt topology, but remain inactive until their transfer engines are
modelled. Extend qtests to cover TXE routing for all instances, RXU routing,
and instance isolation.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/riscv/k230.c                 | 36 ++++++++++++++++++++
 include/hw/riscv/k230.h         |  3 ++
 tests/qtest/k230-dwc-ssi-test.c | 59 ++++++++++++++++++++++++++++-----
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index ea7eaa35a5..4911f2d1be 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -102,6 +102,21 @@ static const MemMapEntry memmap[] = {
     [K230_DEV_CLINT] =        { 0xF04000000, 0x00400000 },
 };
 
+typedef struct K230SsiRoute {
+    unsigned int ssi_index;
+    unsigned int irq_base;
+} K230SsiRoute;
+
+/*
+ * SDK numbering follows the address map: spi0 is the SPI-OPI instance,
+ * while spi1 and spi2 are QSPI0 and QSPI1.
+ */
+static const K230SsiRoute k230_ssi_routes[] = {
+    { .ssi_index = 2, .irq_base = K230_SPI0_IRQ_BASE },
+    { .ssi_index = 0, .irq_base = K230_SPI1_IRQ_BASE },
+    { .ssi_index = 1, .irq_base = K230_SPI2_IRQ_BASE },
+};
+
 typedef struct K230DwcSsiProfile {
     uint32_t num_cs;
     uint32_t fifo_depth;
@@ -191,6 +206,25 @@ static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
                    399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
 }
 
+static void k230_connect_ssi_irqs(K230SoCState *s)
+{
+    for (size_t route_idx = 0;
+         route_idx < ARRAY_SIZE(k230_ssi_routes); route_idx++) {
+        const K230SsiRoute *route = &k230_ssi_routes[route_idx];
+        SysBusDevice *ssi;
+
+        g_assert(route->ssi_index < ARRAY_SIZE(s->dwc_ssi));
+        g_assert(route->irq_base + DWC_SSI_IRQ_COUNT <=
+                 K230_PLIC_NUM_SOURCES);
+
+        ssi = SYS_BUS_DEVICE(&s->dwc_ssi[route->ssi_index]);
+        for (unsigned int i = 0; i < DWC_SSI_IRQ_COUNT; i++) {
+            sysbus_connect_irq(ssi, i,
+                qdev_get_gpio_in(DEVICE(s->c908_plic), route->irq_base + i));
+        }
+    }
+}
+
 static void k230_soc_realize(DeviceState *dev, Error **errp)
 {
     K230SoCState *s = RISCV_K230_SOC(dev);
@@ -245,6 +279,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    k230_connect_ssi_irqs(s);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index cd30fd6aaa..4eee78ddec 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -131,6 +131,9 @@ enum {
     K230_UART4_IRQ  = 20,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
+    K230_SPI0_IRQ_BASE = 146,
+    K230_SPI1_IRQ_BASE = 155,
+    K230_SPI2_IRQ_BASE = 164,
 };
 
 #define K230_UART_COUNT 5
diff --git a/tests/qtest/k230-dwc-ssi-test.c b/tests/qtest/k230-dwc-ssi-test.c
index 126b73ea01..a522fc4973 100644
--- a/tests/qtest/k230-dwc-ssi-test.c
+++ b/tests/qtest/k230-dwc-ssi-test.c
@@ -14,6 +14,8 @@
 #define K230_SPI0_BASE          0x91584000ULL
 #define K230_SPI1_BASE          0x91582000ULL
 #define K230_SPI2_BASE          0x91583000ULL
+#define K230_PLIC_BASE          0xf00000000ULL
+#define K230_PLIC_PENDING_BASE  0x1000
 #define K230_SSI_CTRLR0          0x000
 #define K230_SSI_CTRLR1          0x004
 #define K230_SSI_SSIENR          0x008
@@ -63,6 +65,10 @@
 #define K230_SSI_INT_RXF                BIT(4)
 #define K230_SSI_INT_DONE               BIT(11)
 #define K230_SSI_INT_AXIE               BIT(8)
+#define K230_SSI_IRQ_TXE                0
+#define K230_SSI_IRQ_RXU                5
+#define K230_SSI_IRQ_DONE               7
+#define K230_SSI_IRQ_AXIE               8
 
 #define K230_SSI_RXFTLR                 0x01c
 #define K230_SSI_RXOICR                 0x03c
@@ -77,6 +83,7 @@ typedef struct K230SsiInstance {
     uint64_t base;
     uint32_t num_cs;
     uint32_t imr_reset;
+    uint32_t first_irq;
 } K230SsiInstance;
 
 static const K230SsiInstance k230_ssi_instances[3] = {
@@ -84,14 +91,17 @@ static const K230SsiInstance k230_ssi_instances[3] = {
         .base = K230_SPI0_BASE,
         .num_cs = 1,
         .imr_reset = 0x0000003fU,
+        .first_irq = 146,
     }, {
         .base = K230_SPI1_BASE,
         .num_cs = 5,
         .imr_reset = 0x0000001fU,
+        .first_irq = 155,
     }, {
         .base = K230_SPI2_BASE,
         .num_cs = 5,
         .imr_reset = 0x0000001fU,
+        .first_irq = 164,
     },
 };
 
@@ -112,6 +122,14 @@ static void k230_ssi_writel(QTestState *qts, uint64_t base,
     qtest_writel(qts, base + offset, value);
 }
 
+static bool k230_ssi_plic_pending(QTestState *qts, uint32_t irq)
+{
+    uint64_t addr = K230_PLIC_BASE + K230_PLIC_PENDING_BASE +
+                    (irq / 32) * sizeof(uint32_t);
+
+    return qtest_readl(qts, addr) & BIT(irq % 32);
+}
+
 static void k230_ssi_disable(QTestState *qts, uint64_t base)
 {
     k230_ssi_writel(qts, base, K230_SSI_SSIENR, 0);
@@ -287,14 +305,38 @@ static void test_interrupt_controller(void)
                     ==, 1);
     g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
                     K230_SSI_INT_RXU, ==, 0);
-    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_AXIECR, UINT32_MAX);
-    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_DONECR, UINT32_MAX);
-    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_AXIECR),
-                    ==, 0);
-    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_DONECR),
-                    ==, 0);
-    g_assert_cmphex(k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_RISR) &
-                    (K230_SSI_INT_DONE | K230_SSI_INT_AXIE), ==, 0);
+    qtest_quit(qts);
+}
+
+static void test_plic_routing(void)
+{
+    QTestState *qts = k230_ssi_start();
+    const K230SsiInstance *target = &k230_ssi_instances[1];
+
+    for (int i = 0; i < ARRAY_SIZE(k230_ssi_instances); i++) {
+        const K230SsiInstance *inst = &k230_ssi_instances[i];
+
+        g_assert_true(k230_ssi_plic_pending(qts,
+                                           inst->first_irq +
+                                           K230_SSI_IRQ_TXE));
+        k230_ssi_writel(qts, inst->base, K230_SSI_IMR, 0);
+        g_assert_false(k230_ssi_plic_pending(qts, inst->first_irq +
+                                              K230_SSI_IRQ_DONE));
+        g_assert_false(k230_ssi_plic_pending(qts, inst->first_irq +
+                                              K230_SSI_IRQ_AXIE));
+    }
+
+    k230_ssi_writel(qts, target->base, K230_SSI_IMR, K230_SSI_INT_RXU);
+    (void)k230_ssi_read_frame(qts, target->base);
+    g_assert_true(k230_ssi_plic_pending(qts,
+                                       target->first_irq +
+                                       K230_SSI_IRQ_RXU));
+    for (int i = 0; i < ARRAY_SIZE(k230_ssi_instances); i++) {
+        if (&k230_ssi_instances[i] != target) {
+            g_assert_false(k230_ssi_plic_pending(
+                qts, k230_ssi_instances[i].first_irq + K230_SSI_IRQ_RXU));
+        }
+    }
     qtest_quit(qts);
 }
 
@@ -560,6 +602,7 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dwc-ssi/pio-data-path", test_pio_data_path);
     qtest_add_func("/k230-dwc-ssi/interrupt-controller",
                    test_interrupt_controller);
+    qtest_add_func("/k230-dwc-ssi/plic-routing", test_plic_routing);
     qtest_add_func("/k230-dwc-ssi/tx-only-mode", test_tx_only_mode);
     qtest_add_func("/k230-dwc-ssi/eeprom-read-contract",
                    test_eeprom_read_contract);
-- 
2.43.0


