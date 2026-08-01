Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9020BC55177
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqFPr-0002vc-Jf; Sat, 01 Aug 2026 15:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPp-0002uS-I4
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:37 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPn-0002It-NS
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:37 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so2000358a91.1
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785612634; x=1786217434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tjg9FT4duWt9gr9ZOut+ObsOGQFgQaiIiqjZb9R3imc=;
 b=Gh46x4owLfvDeS/mvfuTCOTUS19eLCol3B/+iq4ymimAJ2Q8nOsNlVqdozInUpOHnY
 H5Xt1X9/4vyOVsBAz2bcBuFDYC5o92fF63etoKLezzjMeufu7SGNPfSZISqH40EAo9DG
 p8p1Z7rjj0Wi73zTjM+uwwYenUrpY17fBuQY6sRFwiYCSFjQ6ZftElSULoW9PdegEpxx
 VZHez3gUfY3UdnBml6fCWgGNCIo+f3zUTDbkFSlKNCV0Uj/OeL8E4veN8DWFrTgUiw3F
 bTWPfaWYU3xv+UujCq5Sh/sNBfgAfqGuaiopP5rLC6+dwaySK6iFJIg1ZqQbVxi0CXBt
 HUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785612634; x=1786217434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tjg9FT4duWt9gr9ZOut+ObsOGQFgQaiIiqjZb9R3imc=;
 b=mc0A9sEP2ePJc0Y+y6lHwd982SjFkphgfyGB2VejeXHIF/w52dJ7RDpEVdnVNjlcah
 u0kOLUDrQSj7MS9QuC81WlOh9WCHAXmCpuDH9l13fL7Wxk33f4Q080q+ONh1eEELcP6G
 dyDXduTcQUONzd6xipnDpiNlliLuoVkMeyFjbrUTh1+gHZPSbb/tyaibmJrpq6AwjUAm
 xaETKHbNF7JSMmD+WhPTEbnCS43SAc2BCrsnCAgMKvFoDeB/JD4cM0L0TjLG6Mo4Vzlr
 Tp+hKIkbD039BLnKEVGFtBPi3MsMNyi8oQmxp2IafPoo+WkH+40E1vy+/ggkkNk7kU69
 zDFg==
X-Gm-Message-State: AOJu0YzBHctQH6+1nXEwgMT4vaHK97Ld7YFsfIzhUemdYumLCv1JtH17
 rfbedcaZ3WNyur9YQpzo4Z7WXMgvv8qo9uajisgh2dlGrhm9GCF4kM9A9NrIgXR5sI8Tag==
X-Gm-Gg: AR+sD10W9q9akNnFA/UykOFMPMgeeXOxUuQqk+r2XDZxzbYWO6oTCaZGmqCFERsKLtZ
 ClvQlOuD4df0LLV81fFI0A64eGhd91c1DuqEWyPiLBnE9pVhuTIR8zbNnuILzjSAVBYwXQYilLZ
 e5MOHTx+0FpK5PiEjl8VsnVW0OQhhojU1nT/l77GKbZdr8S1D7maebtfCxAaBH/DtSeqbZdm78U
 4r3WreDVIOnLjjaWdiqYWxgfCjDwB1sbQ9iS6Eq0cJvH8Ec+tHLvm+q19mh2cAQP2S2d8suxFXf
 CJaAx3wBB/5OgmjpsCxK6ZvgN7sceqwC3JvaKd340s0MvgCwPdDvhIeiVRUtwBaMrTcAxTusdZX
 8CNx7YfxzHlqLJ26MPaOOWkxD7GM/u1Q8xZY8jYO2+od82feLN6QmFEvfvaonGM0qmOdg5+YVdj
 3dPYeiIqTJ4CiB6qwsKuOuP4ldSlDoV8Gq4ZLk/cp+EZhkgQulwje8plolVVIma3ykOy0DKoUVD
 sGj0ZqAww==
X-Received: by 2002:a17:90b:5867:b0:381:96a2:14d7 with SMTP id
 98e67ed59e1d1-38fbc4ae4e7mr4158839a91.22.1785612634273; 
 Sat, 01 Aug 2026 12:30:34 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2bac654sm2148766a91.10.2026.08.01.12.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 12:30:33 -0700 (PDT)
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
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v2 4/5] hw/riscv/k230: Route SSI interrupts to the PLIC
Date: Sun,  2 Aug 2026 03:28:47 +0800
Message-ID: <20260801192848.30606-5-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Connect the nine interrupt outputs of each K230 SSI controller to the
documented PLIC source range.

The TXU, DONE, and AXIE lines are wired to preserve the physical K230
interrupt topology, but remain inactive until their transfer engines are
modeled.

Extend qtests to cover TXE routing for all instances and RXU routing and
instance isolation.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/riscv/k230.c                | 36 +++++++++++++++++++++++++++
 include/hw/riscv/k230.h        |  3 +++
 tests/qtest/k230-dw-ssi-test.c | 45 ++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 4c321002cd..d856864839 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -104,6 +104,21 @@ static const MemMapEntry memmap[] = {
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
 typedef struct K230DwSsiProfile {
     uint32_t num_cs;
     uint32_t fifo_depth;
@@ -193,6 +208,25 @@ static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
                    399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
 }
 
+static void k230_connect_ssi_irqs(K230SoCState *s)
+{
+    for (size_t route_idx = 0;
+         route_idx < ARRAY_SIZE(k230_ssi_routes); route_idx++) {
+        const K230SsiRoute *route = &k230_ssi_routes[route_idx];
+        SysBusDevice *ssi;
+
+        g_assert(route->ssi_index < ARRAY_SIZE(s->dw_ssi));
+        g_assert(route->irq_base + DW_SSI_IRQ_COUNT <=
+                 K230_PLIC_NUM_SOURCES);
+
+        ssi = SYS_BUS_DEVICE(&s->dw_ssi[route->ssi_index]);
+        for (unsigned int i = 0; i < DW_SSI_IRQ_COUNT; i++) {
+            sysbus_connect_irq(ssi, i,
+                qdev_get_gpio_in(DEVICE(s->c908_plic), route->irq_base + i));
+        }
+    }
+}
+
 static void k230_soc_realize(DeviceState *dev, Error **errp)
 {
     K230SoCState *s = RISCV_K230_SOC(dev);
@@ -247,6 +281,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    k230_connect_ssi_irqs(s);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 99996a93b1..275b6b62c3 100644
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
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index 6361c2b5ee..7252302c0e 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -14,6 +14,8 @@
 #define K230_SPI0_BASE          0x91584000ULL
 #define K230_SPI1_BASE          0x91582000ULL
 #define K230_SPI2_BASE          0x91583000ULL
+#define K230_PLIC_BASE          0xf00000000ULL
+#define K230_PLIC_PENDING_BASE  0x1000
 #define K230_SSI_CTRLR0          0x000
 #define K230_SSI_CTRLR1          0x004
 #define K230_SSI_SSIENR          0x008
@@ -57,6 +59,8 @@
 #define K230_SSI_INT_TXO                BIT(1)
 #define K230_SSI_INT_RXO                BIT(3)
 #define K230_SSI_INT_RXU                BIT(2)
+#define K230_SSI_IRQ_TXE                0
+#define K230_SSI_IRQ_RXU                5
 
 #define K230_SSI_RXFTLR                 0x01c
 #define K230_SSI_RXOICR                 0x03c
@@ -71,6 +75,7 @@ typedef struct K230SsiInstance {
     uint64_t base;
     uint32_t num_cs;
     uint32_t imr_reset;
+    uint32_t first_irq;
 } K230SsiInstance;
 
 static const K230SsiInstance k230_ssi_instances[3] = {
@@ -78,14 +83,17 @@ static const K230SsiInstance k230_ssi_instances[3] = {
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
 
@@ -106,6 +114,14 @@ static void k230_ssi_writel(QTestState *qts, uint64_t base,
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
@@ -281,6 +297,34 @@ static void test_interrupt_controller(void)
 }
 
 
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
+    qtest_quit(qts);
+}
+
 static void test_tx_only_mode(void)
 {
     QTestState *qts = k230_ssi_start();
@@ -455,6 +499,7 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dw-ssi/pio-data-path", test_pio_data_path);
     qtest_add_func("/k230-dw-ssi/interrupt-controller",
                    test_interrupt_controller);
+    qtest_add_func("/k230-dw-ssi/plic-routing", test_plic_routing);
     qtest_add_func("/k230-dw-ssi/tx-only-mode", test_tx_only_mode);
     qtest_add_func("/k230-dw-ssi/eeprom-read-contract",
                    test_eeprom_read_contract);
-- 
2.43.0


