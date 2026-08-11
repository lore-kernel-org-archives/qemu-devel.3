Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D136AC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgGL-0001Kf-J5; Tue, 11 Aug 2026 02:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wtgGI-0001Gf-Cc
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wtgGF-0005Ou-6h
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so33153115ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786430812; x=1787035612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XL7/RFf7m8h/trUqeMTE/jIbE0eOmEfGvnssk4XnbZI=;
 b=Sbq6ycqAtZgTD8vqlwySkmE9+IChJKaFkVXq6VmwJwNIyyZr61BoV7J3KblGhdkL5P
 g/BwR5KLWj37IoAL+wxgsKva48N+IThMWYNadnA98Qlf9GLf/0dl09Isi/AojTuxKY/V
 sk1jX91PsPmVFuM14BDGWVUvOuvW/0fsBxZ6VeqO456PYWqaij+BOjARdA+ffQuT8l0o
 ohWDMG8c/hMXcjm2g81j1ml7JRX+kWzXo2jdAR7SqfS9XwcsT3kG5zKynx1LEjYgy//7
 d7mIehtvLyOuBiYc85zN5athlzm7C073/N14YY3i9G3D7dY0Xot9X+LfiR+nxPUccCEH
 Ll/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430812; x=1787035612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XL7/RFf7m8h/trUqeMTE/jIbE0eOmEfGvnssk4XnbZI=;
 b=ekcSBv/Qk5+5E/U6MBhjqrt1e/nBzDOoZWquWwkY7Jqgk9vRrwRAlOsQT7hcXHGrXr
 1y9Rm3oliQSOTWxJNrHbujVJ8dQfij/HXW8vAQuKFKZlCeJfq2dpOGezs00KLrY2HBYp
 SCNYY53NpKXb1s/UMMBxzc1dAJxSJnkufS+PykTAtw8fZxKariDVpyS43ciZKnJTbIcz
 3Wk/VVAoMwmANrmJHFeWG8Av5M5sgY3eJq8wS3gxZLR04RT+7VSJzlyVb9MhIHMH0GCH
 rpsXx3Mg8pCcXJQae0vlanvol8tvIrAJEQm2Bmh9xhWY+oPiq4VmuvMdVYeHBG5WNDyC
 zN2w==
X-Gm-Message-State: AOJu0YwuUuJy8xleHHFMrYQ2JcPGXM/J/0z840luxdb38e3kB2pAfbMe
 x507c/brRofuDChIhe+42Lsps9nY4hDI8/1d4FqTlu6Z49i0/gbUTc/KQFFfiqov
X-Gm-Gg: AR+sD12xth7FIJqO7Z8xQivWBJ/75rhF1Tzb4a0salC1zhbO8j9nQwGHktl3yBF5oSJ
 te1qH7s18PQHIOQsUjMOWNXusU2Wdu8bf28UXb0tMhUHuVLU72O16JTpgmsgHtFJ13zuAJcoO9P
 +uM3NVVXyr6BsaIzY63XuiL92aFhG69W6Rh2Mbwi11oj59Onu/s0H9QTc5BKR1L30ym1c9mz9Dc
 cawK9Q9vC89A0/G5fYqav0NXi0V9zO3Muxv+9Nwnx9ZD09MDwCPjHFQA5J+KICv7NbR6t5uzR3V
 ddwPMO+Un9BliQeE16HS+XCy+SAgNkcNPVu6ltvdAp08pQaUrnNhk/eNYCrCSOKMPECj9VdfSSJ
 5CLuoutiE/LNDBI3tXWhP0r9Qo2yX5prytHMJEf4EV7e4EnkFzwhj5Rvzl9Rf0Aoj0xUwVvEi6K
 X8FzLSz8Apkfav3jsHVFhsz39tHpqay84JiCVsQ2TOyHziStPMQw31BJeA08Cl7PwVs0e4MBnU
X-Received: by 2002:a17:902:fc4c:b0:2d0:4021:bb6b with SMTP id
 d9443c01a7336-2d3175f7523mr16659675ad.0.1786430812075; 
 Mon, 10 Aug 2026 23:46:52 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.190.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d315f3ffd5sm2591015ad.30.2026.08.10.23.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 23:46:50 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, bmeng.cn@gmail.com, raoyi <rao232328@gmail.com>
Subject: [PATCH v3 2/3] hw/riscv: add DesignWare APB timer to K230 board
Date: Tue, 11 Aug 2026 14:46:09 +0800
Message-ID: <20260811064612.16517-3-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811064612.16517-1-rao232328@gmail.com>
References: <20260811064612.16517-1-rao232328@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=rao232328@gmail.com; helo=mail-pl1-x62c.google.com
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

Wire up the DesignWare APB timer to the K230 SoC with
num-timers=6 and a 6.25 MHz clock. Connect timer IRQs
to the PLIC. Remove the previous unimplemented timer stub.

Signed-off-by: raoyi <rao232328@gmail.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/k230.c         | 32 +++++++++++++++++++++++++++++---
 include/hw/riscv/k230.h | 12 ++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..c2c01af6ee 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select DW_APB_TIMER
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..a3457e79ff 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -24,6 +24,8 @@
 #include "target/riscv/cpu.h"
 #include "hw/core/loader.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/riscv/k230.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/machines-qom.h"
@@ -110,6 +112,21 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "dw-apb-timer", &s->timer,
+                            TYPE_DW_APB_TIMER);
+
+    qdev_prop_set_uint32(DEVICE(&s->timer), "num-timers",
+                         K230_TIMER_NUM_CHANNELS);
+    qdev_prop_set_uint32(DEVICE(&s->timer), "comp-version",
+                         K230_TIMER_COMP_VERSION);
+
+    Clock *timer_clk = clock_new(OBJECT(s), "timer-clk");
+    clock_set_hz(timer_clk, K230_TIMER_DEFAULT_FREQ);
+    for (int i = 0; i < K230_TIMER_NUM_CHANNELS; i++) {
+        g_autofree char *clock_name = g_strdup_printf("timer[%d]", i);
+
+        qdev_connect_clock_in(DEVICE(&s->timer), clock_name, timer_clk);
+    }
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -191,6 +208,18 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         k230_create_uart(sys_mem, DEVICE(s->c908_plic), i);
     }
 
+    /* Timer */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, memmap[K230_DEV_TIMER].base);
+
+    for (int i = 0; i < K230_TIMER_NUM_CHANNELS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), i,
+                           qdev_get_gpio_in(DEVICE(s->c908_plic),
+                                            K230_TIMER0_IRQ + i));
+    }
+
     /* Watchdog */
     for (int i = 0; i < 2; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
@@ -283,9 +312,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
                                 memmap[K230_DEV_IOMUX].size);
 
-    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
-                                memmap[K230_DEV_TIMER].size);
-
     create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
                                 memmap[K230_DEV_WDT0].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..0f872554c8 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,9 +18,14 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/timer/dw-apb-timer.h"
 
 #define C908_CPU_HARTID   (0)
 
+#define K230_TIMER_NUM_CHANNELS 6
+#define K230_TIMER_DEFAULT_FREQ 6250000
+#define K230_TIMER_COMP_VERSION 0x3231312A
+
 #define TYPE_RISCV_K230_SOC "riscv.k230.soc"
 #define RISCV_K230_SOC(obj) \
     OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
@@ -33,6 +38,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    DWAPBTimerState timer;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -127,6 +133,12 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_TIMER0_IRQ = 101,
+    K230_TIMER1_IRQ = 102,
+    K230_TIMER2_IRQ = 103,
+    K230_TIMER3_IRQ = 104,
+    K230_TIMER4_IRQ = 105,
+    K230_TIMER5_IRQ = 106,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
 };
-- 
2.53.0


