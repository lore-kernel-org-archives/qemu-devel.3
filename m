Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9213C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGRA-0002PX-C4; Fri, 24 Jul 2026 09:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wnGQz-0002Jb-By; Fri, 24 Jul 2026 09:59:36 -0400
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wnGQs-0003Qg-LI; Fri, 24 Jul 2026 09:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784901557; bh=cX1sq44kIbx5m5YVfMvT+RWwvcgYaf46P8vNXZ33vLc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dbWtySjWHaJxLkDpJ0nKiE8cdQH5ijo7J9mZxg3QTrEmLBKEpK2rP3GUtk1in81hF
 corCcXepN5jsGmciCtceQ1GYEveZb3BT6FRjj2yQh2/HYcjBXyoubSjgll5+3dTQhq
 t6NNtWgaPsKCAZ5U1yfOdw2M9rWPHp1fVKR2cUgw=
Received: from [127.0.1.1] ([240e:3bb:a98:9fe1:fbb4:4428:c3bc:a339])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id EC68C209; Fri, 24 Jul 2026 21:59:06 +0800
X-QQ-mid: xmsmtpt1784901553tc4ejbenm
Message-ID: <tencent_2DFD13C6A0515DD222F43CF8925F10F9ED08@qq.com>
X-QQ-XMAILINFO: MHMEtxMLMqJxAbe8NmnNGz8pVsReD7vf+Uavmn0vACDH6INhR+hsanEdM2LRxb
 2TpL2zmomzygvYRZLIzRruLGwHIpGGOl2jU/VqaWhy9AL2s1l8WhfPOC0EqZIOxalGzJ0DH2m6Ft
 aOzfMBrAU0GKUeSGDmPxEv5TzF4u9J6h/TLJp75QB0QqVnfjEcTWGUrxRIFjioNVnXhdpIfRxzb7
 ZbKqh+Bn+HkP1HSSOLp89M9qB+Trw/HRfLna9yK5o7lLs9j8jnHFruuSR9erXNBYYMFGwY7nwTrW
 E/FYMPLF/szYhzhkM4dLMMh286HRc6OGG+Rgu2S41uFTV7trbZFUmKtlp6n+cO5rBKgrfuMzMSmk
 8lIYVZnkTENKzG2RBJqd5qVsm0t8PQTjwMfNMf9bgQcYeWKCbg7hKJQrWz9/Y0+NVG6hlhuQnjuu
 hjdo8HBto9nMkxYEZQ08SY7hs9VwTuYJuez5w8FApYX5wIItwzBYAO4hLlSC22Pj4Ym1StMcerUC
 czbmX6GirCUmkS95iAtxETigKoYTq5Cum6DC2/u/nnmk0F6vLd9kpXTYsulrZapSdzzkEjukSbZQ
 Jp5lNM8xK2KAtLzfLqXBd2LuFvTSfWMNTgJRQbtwQarQUEKx02RqI1HueCa6q5RTV/v2wmo0as90
 qi3rcz0aw0XabXWOpm4k95q3QouD6IWr6YMQVDi0w4T9UMpcoIUxHf2hJIKbOjxqlK4UEOlydyQ3
 uiNm4EKMTLVzxkbetxnxxPcyK2aX8JGj3wFbwqKs6gDbv3JxtJRJU+1sGU10MtFMaoQ3iHmMT5Hn
 YXXlviGyg5A+kdekX45ZaeJXOg3immfOH0hQbQYKJBaehsX2EF6cHL0f1i6aHUgm2yL5S70oewu2
 fQ1qnotUJPVcaSxRGKQotQ1GEABmln1F9XL+C/T5FAFiRqHgWzDtEqmHumRot6c81CCXtsNGUuKE
 Qt4xMGcVBFRI/ZyDoyhFds2JP0jV3+A3DA3mcCFeFLri5EX7t0cGHhkHHkJlxVj2ldwYlR38abkk
 2R/OUrGnId0JaimzJSXLwRB7XcQSGYcAInUpmxtqj8Hlgs/vdRaOCg4e4CvmQyv3E7O3eLCgcT13
 4jQv60qOLPHwGih/S6IqcW0yD8NoB2Kcdcv453ujtsKosVEe5kRfd+Gwbrno6h3BY+lWWp7vu8Zp
 VSvvTFVNODOK6m6mLlFVU/Hp3y66j7CCofMbg=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: zhenbaii <1640586082@qq.com>
Date: Fri, 24 Jul 2026 21:59:00 +0800
Subject: [PATCH 2/3] hw/riscv: k230: connect DW 8250 UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260724-k230-uart-v2-v1-2-4c0657a703e5@qq.com>
References: <20260724-k230-uart-v2-v1-0-4c0657a703e5@qq.com>
In-Reply-To: <20260724-k230-uart-v2-v1-0-4c0657a703e5@qq.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 zhenbaii <1640586082@qq.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784901547; l=4487;
 i=1640586082@qq.com; s=20260721; h=from:subject:message-id;
 bh=tt84MDyaxT0+b3W7VO/K2raUw0Fu9xLH8heZC5zcyQk=;
 b=I2RfbZLkqBIXPSk9UQ/+gjuIOsPUthkXDM2hkOlXlNCBlTg3FO++fFvTahzwQ/Kj21xxaGqva
 KzK4wEuj9cGAMuffSPzY9sFYqViqimoBCH58WW8cyfVBBnglKM4IOp1
X-Developer-Key: i=1640586082@qq.com; a=ed25519;
 pk=AjRy6i+I/zX9djX87K/xR2OQ2Myy7s7j7bDdi9Qz3zw=
Received-SPF: pass client-ip=162.62.57.252; envelope-from=1640586082@qq.com;
 helo=out162-62-57-252.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the generic serial-mm device with the K230 DW 8250-compatible
UART model added in the previous patch.  All five UART ports are
instantiated as children of the SoC and wired to their respective PLIC
interrupts.

Signed-off-by: zhenbaii <1640586082@qq.com>
---
 hw/riscv/k230.c         | 33 ++++++++++++++++++++++-----------
 include/hw/riscv/k230.h |  6 ++++--
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 502281c52cff1dce6febb7487dfdefefe6363e9c..d49fa23448f38dfed45a570eb5bece64519bfe27 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -29,7 +29,6 @@
 #include "hw/riscv/machines-qom.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
-#include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 
 /* Align K230_SDK k230_canmv_defconfig */
@@ -111,6 +110,11 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
 
+    for (int i = 0; i < K230_UART_COUNT; i++) {
+        g_autofree char *name = g_strdup_printf("k230-uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_K230_UART);
+    }
+
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
     qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
@@ -136,19 +140,26 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
                               memmap[K230_DEV_PLIC].size);
 }
 
-static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
-                             int index)
+static void k230_create_uart(K230SoCState *s, DeviceState *plic, int index)
 {
     int uart_dev = K230_DEV_UART0 + index;
-    g_autofree char *name = g_strdup_printf("uart%d", index);
+    g_autofree char *unimpl_name = g_strdup_printf("uart%d", index);
+    DeviceState *dev = DEVICE(&s->uart[index]);
 
-    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
-    create_unimplemented_device(name, memmap[uart_dev].base,
-                                memmap[uart_dev].size);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(index));
 
-    serial_mm_init(sys_mem, memmap[uart_dev].base, 2,
-                   qdev_get_gpio_in(plic, K230_UART0_IRQ + index),
-                   399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal)) {
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, memmap[uart_dev].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(plic, K230_UART0_IRQ + index));
+
+    /* Cover the non-16550 part of the SDK's 0x1000 UART window. */
+    create_unimplemented_device(unimpl_name,
+                                memmap[uart_dev].base + 0x100,
+                                memmap[uart_dev].size - 0x100);
 }
 
 static void k230_soc_realize(DeviceState *dev, Error **errp)
@@ -188,7 +199,7 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
 
     /* UART */
     for (int i = 0; i < K230_UART_COUNT; i++) {
-        k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
+        k230_create_uart(s, DEVICE(s->c908_plic), i);
     }
 
     /* Watchdog */
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf8a8f8a1c66653ff9b568fbfe98a3ea..fed0357c2b9e1f5254cb157e0cd4d75d4946d1a1 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -17,10 +17,13 @@
 
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/char/k230_uart.h"
 #include "hw/watchdog/k230_wdt.h"
 
 #define C908_CPU_HARTID   (0)
 
+#define K230_UART_COUNT 5
+
 #define TYPE_RISCV_K230_SOC "riscv.k230.soc"
 #define RISCV_K230_SOC(obj) \
     OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
@@ -32,6 +35,7 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230UartState uart[K230_UART_COUNT];
     K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
@@ -131,8 +135,6 @@ enum {
     K230_WDT1_IRQ   = 108,
 };
 
-#define K230_UART_COUNT 5
-
 /*
  * Integrates with the interrupt controller (PLIC),
  * which can process 208 interrupt external sources

-- 
2.48.1


