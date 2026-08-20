Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4788C5DF89
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtiJ-00073J-7K; Wed, 19 Aug 2026 23:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiI-0006zy-5q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiG-0003o8-Gn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so399326b3a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197507; x=1787802307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qZOFXhGNRxNOm5KFMFQUurJQSlkP1SuCKksgxHQSBBc=;
 b=f9JotdpJGo8Y0LLbfBdxkBzCPIy36GmGJsbvK2UZ+WvKlEJdSjmxXMHic7K6O+TjHc
 qatJTJ0OVdJqOF/gc86Abg/pQTnf3aLjoGC0N32WI1dZ+jr7C9c9Z+PylK3sSqazpVMI
 VVinJ/X5uSNQSffNfdWletnleyeTraVwQ7JPJAwfTLT9mY272tOgtVaJ8wSCKrjxc7ry
 d1VR75+Bv0snjqLJjFamnCKZ4b9xd10UqkDlZcsfVqINZNjrrhz8hvDdQoQsR5o+AOv/
 zvrLmyTMAw1g1/ULApVZYkWEKD6m07iapl39HxAeBXu396lUI5NIzIFBvGs5y6Ti5GGF
 fVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197507; x=1787802307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qZOFXhGNRxNOm5KFMFQUurJQSlkP1SuCKksgxHQSBBc=;
 b=M6gza64N9mKXeas44CvZe2kIlTkG0Dx6JJJ2FhrlVHfwWqgFqDN3tNI1UiXDkqwp/w
 dxapTYyRtSoEKCIbtKDBw5oqHllMBiLHIUHEjqCEd2a2cekmzgRaXFxLn7YFDJT7ygFF
 ignPrR9jMLxFNsGIfUazuBV3/49ZtAGu7QCR0jz77m/f9p3PZkEgMJklX4t6kXz/KC0W
 eevbYwhxDA24T0Hsrzv7zsddGGN5s0irghJlnif/VmKbbu6t2nSaTMMFafcEA5Kn9uJz
 Ji6twT7U1xumifR7/JtGiSKWTRg+jKkSlmpm+L/82cvzBTtR2Ehp6IHi1//8G/MkYTCw
 BOmg==
X-Gm-Message-State: AOJu0YxD+LWbjfplP20YmGc38NfwOqNl4HyhXcDf33dZFx4j5xtYY5+a
 ia+7hWgspz8FD3NE+raor60maTqNvkKwHWkhDHccy5hVWOJzAF/7WRH+/d3Ydw==
X-Gm-Gg: AR+sD12oob8GY8klFRKpcRUH0yJXzGPDbAp3tKdvx62vq87u/H6BjUkEvGiQry1tEzp
 NAAWC28FTYuuYMN0YS1tVfRaXPQkOrcFHHrtMfLm1Al3EIbPiwjRdT+4q9MjWDnuLABRCx6HvNV
 w9TyXj1Cc7cFy/7Up26iR20bIeIHZNVUooOnwhQ2MMMyXMbDk7q5BsW+PcCFQA5kLMQdogiRZnw
 8/PBLzbALHwSEDnOiJTk+Yz58Sr0FcSkDhNSOKuk1T1nP8mj1ZubdbQYmXkySQEkbvruyl7W826
 oIzFghy2PaZjFidgT1tFFUoeid3mZ2ylBtjdTaRVBBvyqIloITPEpZSxcElpI6aYWJFSFM0aoCm
 ieIo9mWbKMny3ZmkNQ2its6ebopnbAUPLPZZE5lsX+83MXF3EoOFdy2o6UY2DiF2vCN6bcDGye5
 q1XY5Y8NEgfNZ/B2+dH1xAhokRnMNnMzC85AFhmSRean6/dIjnQdV3yOVjpNTk+YYfX/vid6fBT
 kgoUg==
X-Received: by 2002:a05:6a21:c188:b0:3cc:f9a0:3ada with SMTP id
 adf61e73a8af0-3cd14fbd28cmr3603558637.16.1787197506930; 
 Wed, 19 Aug 2026 20:45:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>, Junze Cao <caojunze424@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/93] hw/riscv: k230: add decomp gzip in K230 board
Date: Thu, 20 Aug 2026 13:43:05 +1000
Message-ID: <20260820034430.1186695-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Tao Ding <dingtao0430@163.com>

This commit replaces the unimplemented part of Decomp_gzip in K230.
Connect to the handshake interface of GSDMA.

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260808062227.66961-6-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/k230.h |  2 ++
 hw/riscv/k230.c         | 23 +++++++++++++++++++----
 hw/riscv/Kconfig        |  1 +
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 8879d56d98..8679d09891 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -20,6 +20,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
 #include "hw/dma/k230_gsdma.h"
+#include "hw/misc/k230_decomp_gzip.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -38,6 +39,7 @@ typedef struct K230SoCState {
     K230DDRPhyState ddr_phy;
     K230WdtState wdt[2];
     K230GSDMAState gsdma;
+    K230DecompGzipState decomp_gzip;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 49c3b50c57..5163eaa7ef 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -117,6 +117,8 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
+    object_initialize_child(obj, "k230-decomp-gzip", &s->decomp_gzip,
+                            TYPE_K230_DECOMP_GZIP);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -231,6 +233,23 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gsdma), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_GSDMA_IRQ));
 
+    /* Decomp gzip */
+    qdev_prop_set_uint64(DEVICE(&s->decomp_gzip), "sram-base",
+                         memmap[K230_DEV_SRAM].base);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->decomp_gzip), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->decomp_gzip), 0,
+                    memmap[K230_DEV_DECOMP_GZIP].base);
+    for (int i = 0; i < K230_DECOMP_GZIP_NUM_GPIOS_OUT; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->decomp_gzip), i,
+                              qdev_get_gpio_in(DEVICE(&s->gsdma), i));
+    }
+    for (int i = 0; i < K230_DECOMP_GZIP_NUM_GPIOS_IN; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->gsdma), i,
+                              qdev_get_gpio_in(DEVICE(&s->decomp_gzip), i));
+    }
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -249,10 +268,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
                                 memmap[K230_DEV_DMA].size);
 
-    create_unimplemented_device("decomp-gzip",
-                                memmap[K230_DEV_DECOMP_GZIP].base,
-                                memmap[K230_DEV_DECOMP_GZIP].size);
-
     create_unimplemented_device("2d-engine.non-ai",
                                 memmap[K230_DEV_NON_AI_2D].base,
                                 memmap[K230_DEV_NON_AI_2D].size);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d28ac06043..d06ac26648 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -163,3 +163,4 @@ config K230
     select UNIMP
     select K230_WDT
     select K230_GSDMA
+    select K230_DECOMP_GZIP
-- 
2.54.0


