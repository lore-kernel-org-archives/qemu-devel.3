Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A691C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJzG-0007Ca-OK; Tue, 18 Aug 2026 09:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wwJz7-00074O-VY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:36:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wwJz5-0000fd-PI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:36:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d530328efbso41814335ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787060166; x=1787664966; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XUsiX20NPZUJ5pQd/u9R/lymrgW+Q7K98qrZgTyAjqw=;
 b=NTGTc5pgZctob5NOER4+5i5VXR3iiobEz4FHOfoJSLJTawj88Qu0iy05WdfA+aO+sY
 oYSUkT5aDtcv+0bUYVKYrS2XnFtelPOha161HD9TXfwzqLCLe3qv2/fwXEZfLL7foScJ
 x+03ExNvGtgPOZA6rkARh5t33s+JaI8Zi7xbQ1WYNR5Gyp6FPSXgb0+zLXe9fBLdUI4Z
 YuwW0zGA1ZezoQv+kfXLATrtejdEwQO1of7OM2+Bo6YjGOvdelfwniLd1hN5sj52yTWK
 V5rNPTAsKxmry3nrJ6+xx8YkRd8yykuVh5KfqqTDHUHGlHFiwfUmf3ZxgAqpxlHu+hrl
 cmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060166; x=1787664966;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUsiX20NPZUJ5pQd/u9R/lymrgW+Q7K98qrZgTyAjqw=;
 b=EbckJh3/fp+dIejbnzPhVoM1WV7K4Cng2UODjtKrov+PJcyvIIUUuWr68VnMj2W96q
 8OdDgD6eUCFcUQxNEgGbwdVmIXatUt3S5YnXJTPJP4FYldS2+uOLeUbt2RYXe1JCfCen
 Z27vegyKuQ3s0tmR7m9mGbtWvbpBPFYOPHXuC9jRulDvfqyDEgfInZ+YYrL5IgDJtBtc
 Yi9FRVesu/33RLPKqH+tJkmSFlujZLEoO3o1LXv7W2ytTf3Eoq4jXMXW6hQVXb+hj++g
 hQa3C2SSabkg+3O7roNpMMaD7k/WNYyABRtEmNkvtO/Ya2Pt3L+sW2xIKkZY23Wf3vQa
 R+iA==
X-Gm-Message-State: AOJu0YycgFr3awUAjOtpBlblWw9UFzbHnnkqT8/34t8Scgt3J055nE/h
 UYfbmXTYVmY/aPG1LBX+29DUa17Br1cJSaaLo/Kjw+DZGNHgOrKoieNR
X-Gm-Gg: AR+sD10nCt1Ibctzr2nTOcq6jKMJCT1zbzWxyomfgm4XwQovrKeVi//oav4OpM3LcLe
 TtEIPx5PEHTt5OFqc6/cLs5CNFs8qiiIqD2dmtzOmLZ116GXP8DbqZGFdyncQwEPgEL8kRo/+kT
 iBiSMrICTDfLcA3U0s3zKZcCBxgqALJjO1JMWqcJuQZJrl1PeInORRlWxLi6OkmtHPgTp11o4xB
 Rdy2KdxNarF2od1t9Lu+Z9mT3cmRXwfHny2ZmvACQt2vhhh6ley510zZZfBIBoBgMmPEO5SfTsw
 KV7w5PFVTduCBVzslrLocJ/r2EpH7kBRpmYurI0XhnEIdg8lWmqoS0v+AF+Hr17K/LI+2BQ2PfR
 OPTvXDrM7cr5rh0xrnXUqv/Z5K2Cxok9helff90YAP9rSkg40T9yGLiyvruJt3ddXOneRuLS17h
 MRN6EQmIP7FBkBTr0laK3jylxT7WsPDiqCg08oUq/ggSUi3v79rO+lisS6jAxEGGdDB5OR68Aes
 5CE3k/U7R1y
X-Received: by 2002:a17:903:1b48:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2d5c4f20383mr130101765ad.6.1787060166234; 
 Tue, 18 Aug 2026 06:36:06 -0700 (PDT)
Received: from [172.17.0.5] ([42.193.175.155])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5d014d965sm8066845ad.35.2026.08.18.06.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:36:05 -0700 (PDT)
From: Simon Law <0860734llx@gmail.com>
Date: Tue, 18 Aug 2026 21:35:51 +0800
Subject: [PATCH v2 2/4] hw/riscv: connect the K230 CMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-feat-k230-cmu-v2-2-57eadb98f40f@gmail.com>
References: <20260818-feat-k230-cmu-v2-0-57eadb98f40f@gmail.com>
In-Reply-To: <20260818-feat-k230-cmu-v2-0-57eadb98f40f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=0860734llx@gmail.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Simon Law <0860734llx@gmail.com>
---
 hw/riscv/k230.c         | 14 +++++++++-----
 include/hw/riscv/k230.h |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..e50062f7df 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -108,6 +108,7 @@ static void k230_soc_init(Object *obj)
     RISCVHartArrayState *cpu0 = &s->c908_cpu;
 
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "k230-cmu", &s->cmu, TYPE_K230_CMU);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
 
@@ -206,6 +207,12 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cmu), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cmu), 0, K230_CMU_BASE_ADDR);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cmu), 1, K230_SYSCLK_BASE_ADDR);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -265,14 +272,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
                                 memmap[K230_DEV_RTC].size);
 
-    create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
-                                memmap[K230_DEV_CMU].size);
-
     create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
                                 memmap[K230_DEV_RMU].size);
 
-    create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
-                                memmap[K230_DEV_BOOT].size);
+    create_unimplemented_device("boot", K230_CMU_BASE_ADDR + K230_CMU_SIZE,
+                                memmap[K230_DEV_BOOT].size - K230_CMU_SIZE);
 
     create_unimplemented_device("pwr", memmap[K230_DEV_PWR].base,
                                 memmap[K230_DEV_PWR].size);
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..5e1579c5b3 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -16,6 +16,7 @@
 #define HW_K230_H
 
 #include "hw/core/boards.h"
+#include "hw/misc/k230_cmu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
 
@@ -32,6 +33,7 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230CmuState cmu;
     K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;

-- 
2.43.0


