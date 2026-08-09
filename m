Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A69C5AC80
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 11:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt1yT-0002vo-Mi; Sun, 09 Aug 2026 07:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswuE-000818-0o
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswuC-0005t2-FG
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cea3004256so9897445ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786256467; x=1786861267; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XUsiX20NPZUJ5pQd/u9R/lymrgW+Q7K98qrZgTyAjqw=;
 b=YSrRrpev6n4cRACE60AaOzOoyetgCtSWqTF2UBDtk0Bu6jCs2MSDUADuvPfnJSqDlE
 PxUcqPRCu/iXmSVpJWzj657f9tohBji+bQubtTZetKvzXdAvVP571TT3yAEzPQH1yPcD
 PxMTSFK3zxeoHIZGmoPTGsgOBzfiqRab0g0lhFW7FJ8QgPObNaawetsA7Ighey7QOmOO
 2mnuN1IIdDZ+fr5qAWjqAyD+0jNF2QsIDSLTNfv1g2+eCZmFWGr3O0Bi+7E2SWA1qj5q
 Rr7SGfv6Zk+3Urs7kJtAx6SvzSaXEbFxUYw+tR0TGmTYjjo/nGv4Tmh5abdTlVB+6hWU
 XIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786256467; x=1786861267;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUsiX20NPZUJ5pQd/u9R/lymrgW+Q7K98qrZgTyAjqw=;
 b=oOpqPcugm28gVFYVjOeKTXMN0Bd7xZXazUzGgX5ErQSIvqNGGcAOnoyNo7vG539QWc
 peXRta58hpQiJMPXlkFb6o7byInFp9ZIRLFa7DOzaFRrg4y6+oExdiBh80oWJWONlfM9
 8UAuvEdLUiuskvEfQ5JeXITUAVkGiSXDg2O1VLab9VokYDT1Mn5iKErQ5YKyQKC62PcW
 cPZUX7qutStuG7DXZotS+ZWwE6tyJJN3jxwKmCPss/fEn7B+ig0/FxGZhcOXOltJDT2I
 LS7hecOrMcwV4VMd6ybcj2r8T1Qb5YoZNsA745eP1vExA4+81i6VMdnunPUmM/8L4azi
 qVtw==
X-Gm-Message-State: AOJu0Yz1edOs15JSSYH7jmmOZ4EW5Tg+bgyiJhmhgpe69FfZAYKRS2vV
 GWFeh7j/iMge/T5c/DcbUwTc+mydNAZFAR+1sWdCiRNmWoTLxz1R2dXzTzdifZjDBapyMA==
X-Gm-Gg: AR+sD11Obk3Jqm/HRCAxM2jnPwwk+UXiwATeNqVGn1TpSPvedQxci9rq+RiVMGccdUJ
 npSbLrX/Xnu4Ollc3HLdsm9kTcPMG44ogUzHTHpfPJs5XUe/xFvZT0J882vJrFezdIDqjZp57jC
 7ynl+Vq1VeBuFspNgyknVssoJ/eiqMQejaUQXDScGp3rzv4YE6TkL2gTl5egTYQotSLSszULV0R
 wmEiVjJV8Yk/Fo9Z4/yuZt4k6iCeitGsIJrAiXArg7lb5qwaz8tWmU3o7KYraYmO4na6/anp8Bx
 xeJFGr31hRCTQSei0JQ0aeQnMyD0hlSL9aQUxYDN6KASyd8xclpBtjDL5kotQpSVwBPhoGvOg7h
 /agwL7L1rUYM6OGd+HtpYM9GW3cONWcUKepCgeOm9RwaGRS5ckM2zn6zjAhEXxYymU0Tc+IBQ1v
 GnKu4C5qnlOS4/HVKc8g6q/53muZ+Mn+wfd1KMWBX22DSTJc9MQxkjFTDinkRwhRbe1pdHOAcw8
 knAh6sI4c2jDFeZIs/9Zw==
X-Received: by 2002:a17:903:2a86:b0:2c8:1f58:55dd with SMTP id
 d9443c01a7336-2d0ca7586cemr437343505ad.9.1786256467029; 
 Sat, 08 Aug 2026 23:21:07 -0700 (PDT)
Received: from localhost.localdomain ([159.75.12.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccac6d7sm21805265ad.6.2026.08.08.23.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 23:21:06 -0700 (PDT)
From: Simon Law <0860734llx@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 2/4] hw/riscv: connect the K230 CMU
Date: Sun,  9 Aug 2026 14:20:42 +0800
Message-ID: <20260809-feat-k230-cmu-v1-2-8792982c446c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
References: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=0860734llx@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 09 Aug 2026 07:45:49 -0400
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

