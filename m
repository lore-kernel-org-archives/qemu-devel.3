Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E9606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UpI0Xd7v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnJ3-0004ux-IZ; Fri, 30 Oct 2026 10:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmoU-000639-5p
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:34 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmoS-0007c3-BL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:33 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-702dedeb70dso487766eaf.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793367511; x=1793972311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M54vx+wx4hKVGaumjpxsRCNAzEUUl0ekxzc9Veev8CM=;
 b=UpI0Xd7vRGBDv0LT9YQCgKt5wKEhi5571imhpKs62zdndgBNBv4g8NcBpyve2S4H4V
 WWnZoLXZW0VHqKuDxGq0+z7vitzEHnXJ8H7ye14g4mUJbO/2SV9ATSveE2fU85BsDlqv
 k+2OHhU8kmm4Okj7iZmPK7zM1nVrxuYzZU1vilcV6KKm/aVL8JvwvsbV57n3O8hy8mXf
 bd9vlbPU5uCyXqD11QxfJSnGJ8FQ9DvxnH/xYXqwyc5YNI7qzqQeU23vCmhPdSQ2l4Sk
 4eGKkL0d0AMf/+MGN12hvhBFGQkCh52t1kwntGCkDsK4y1LZpjPcVzQCahS/GH8pwXuv
 xzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367511; x=1793972311;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M54vx+wx4hKVGaumjpxsRCNAzEUUl0ekxzc9Veev8CM=;
 b=vOoUKzE92d+whOSZaFXe52LW4TtkH6aEuVzAtZaTNrt/VdV2KiwHFGSoBSsiFPxg2Y
 FZqslSR6vU5arym59GRw2yrLERYnOcgGXkuspFeRJVY/T3Tb5ZnRYUsJ34EW4HjXFZpn
 Hezq7w0ACePUlkJOrro8qiNj2DIlcPtAW15Z4XNY1JynouNatWc4Lvoaj6Lvdoq76jbv
 YbdEDlKAkZ61BfFT80x/lJkec6BIXXKSI75cC/u2gS5T1ey1mijkB3comDvXVEC/XvLW
 UTM+tCX4NwItc/z73v5a25lyRUCqvP6Rl47rOo3XVh4pp/ON6HtrgfIHEee0pqP3Fp47
 hWKA==
X-Gm-Message-State: AFq9FYJnM03fZg+8TxqpKeuyxAsIcciAgIme7EC9OazMj5FGJqeeQobl
 grmd1v87+VTjCsRE0n7R1DJbc5yYiCxMjgZpcEiCQARgBnjTOowtyNe8LV8G/Q==
X-Gm-Gg: AYBFou2TCPgfvxpwn/vQjR15/FwlI4dABSd62YGjjxm5hEXLVsYwHmDPmnnmbYlD+pb
 szNRcHoQEp8v8ARgbat8Xbn9uL4u8/FvWCGLbiaZjpGFmh+wk9eH5/SbY/0k9jR9VuVEuSpVSKc
 V8/huhOQr2gob+aM0VMKqpnMvryrlGNVxfBfWmdkABQAhQh46nTztuUCsY3QcZtZyl5EyO5R4Jx
 Q8h35zxcv06BYcNylEGJifvTGy1AlhhCwIo+UCV+UKzn07ix9XdQZaznnm1tRYZweErlHs3LvmP
 ozYxxVJ3WUjDMOWcLCVMzvX+WYHVRpBSGV1W5eOgUhFLPJpRzINpKjBIT6eIOsvBrNemg4W4SC5
 tSFOIRsWKqiKe6pCvHi+nx8p20PxVKjgBs6YkyhTuoTKY0SpChE4bPAVHwshGtcNcCb6ylRHiOw
 VjFoAnvh7Z81qm/GpEgXrQK1c5oKn5cjcyjfh03nxiScSKB3qWo3ZxJoyRE0eMkbJgAn7WMrnyg
 HQdhSJoel7uHGJx6nMQkOjk6Uo2weoSjuQd+qSSx7hd/ngzOlqq22Qq782QtFgagk2nOOt8TcwJ
 VxO8H6jO+gNw/1sUlsecfrqvx4hJ3FoPXUiEai40S9eD+/lkCTfYtKcF1Sb7dQA=
X-Received: by 2002:a05:6820:1ca5:b0:700:52ae:7e4a with SMTP id
 006d021491bc7-714f27855cdmr1319617eaf.71.1793367510876; 
 Fri, 30 Oct 2026 06:38:30 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.190.244])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f30600f0sm1861421eaf.12.2026.10.30.06.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:38:25 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 bmeng.cn@gmail.com, philmd@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de, caojunze424@gmail.com,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v6 2/3] hw/riscv: add DesignWare APB timer to K230 board
Date: Fri, 30 Oct 2026 21:37:03 +0800
Message-ID: <20261030133704.99678-3-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030133704.99678-1-rao232328@gmail.com>
References: <20261030133704.99678-1-rao232328@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=rao232328@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:09:55 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wire up the DesignWare APB timer to the K230 SoC with
num-timers=6 and a 50 MHz clock. Connect timer IRQs
to the PLIC. Remove the previous unimplemented timer stub.

Signed-off-by: raoyi <rao232328@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/k230.c         | 33 ++++++++++++++++++++++++++++++---
 include/hw/riscv/k230.h |  8 ++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d89fdfcc86..dea1430b94 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -181,6 +181,7 @@ config K230
     select K230_WDT
     select K230_GSDMA
     select K230_DECOMP_GZIP
+    select DW_APB_TIMER
 
 config SOPHGO_CV1800B
     bool
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 1e4ca38579..a5d789c070 100644
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
 #include "hw/intc/riscv_aclint.h"
@@ -36,6 +38,9 @@
 #define K230_DIRECT_KERNEL_ADDR  0x8200000
 #define K230_DIRECT_DTB_ADDR     0xa000000
 
+#define K230_TIMER_NUM_CHANNELS 6
+#define K230_TIMER_DEFAULT_FREQ 50000000
+
 static const MemMapEntry memmap[] = {
     [K230_DEV_DDRC] =         { 0x00000000,  0x80000000 },
     [K230_DEV_KPU_L2_CACHE] = { 0x80000000,  0x00200000 },
@@ -118,6 +123,19 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
     object_initialize_child(obj, "k230-decomp-gzip", &s->decomp_gzip,
                             TYPE_K230_DECOMP_GZIP);
+    object_initialize_child(obj, "dw-apb-timer", &s->timer,
+                            TYPE_DW_APB_TIMER);
+
+    qdev_prop_set_uint32(DEVICE(&s->timer), "num-timers",
+                         K230_TIMER_NUM_CHANNELS);
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
@@ -212,6 +230,18 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
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
@@ -325,9 +355,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
                                 memmap[K230_DEV_IOMUX].size);
 
-    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
-                                memmap[K230_DEV_TIMER].size);
-
     create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
                                 memmap[K230_DEV_WDT0].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 8679d09891..4c416573eb 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -21,6 +21,7 @@
 #include "hw/watchdog/k230_wdt.h"
 #include "hw/dma/k230_gsdma.h"
 #include "hw/misc/k230_decomp_gzip.h"
+#include "hw/timer/dw-apb-timer.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -40,6 +41,7 @@ typedef struct K230SoCState {
     K230WdtState wdt[2];
     K230GSDMAState gsdma;
     K230DecompGzipState decomp_gzip;
+    DWAPBTimerState timer;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -135,6 +137,12 @@ enum {
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
     K230_GSDMA_IRQ  = 140,
-- 
2.53.0


