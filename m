Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0999C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYP-0001Jn-PO; Mon, 24 Aug 2026 01:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNY6-0001EU-Vu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNY5-0001kx-8p
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:46 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e347638adso2729383a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550523; x=1788155323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qZOFXhGNRxNOm5KFMFQUurJQSlkP1SuCKksgxHQSBBc=;
 b=oDvZzr/nDIJ+EzZu6ViZuUztaXwqfQv4ZYCzL2IvXtns6oa52cFxKW/vMPVCga/QGg
 yVmIQE8AcQBYjE/SH79onF4JMTB3/nlG+i98R2OJEANurO5fzXv3Gq7uK0dvEbU3ocjU
 R76VnTwLUoBqG7fWWXgBbjxRxvnmqvuIyO/p0zW0zKouIC3OSNOX4QZLwvisrzv9SWjU
 G4CdFkjtSwInouuviYRgUzkLzQlmhP+6KLZu/ng4h3c16trVc5eZqkw9l4G9I90S43Cn
 XT3cVixV+Gg0r1qynhZPFSKQmWGIYiaNkw9zj+Fi3zxCG42ikZceZNNAoVnK1QBHcYY+
 IwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550523; x=1788155323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qZOFXhGNRxNOm5KFMFQUurJQSlkP1SuCKksgxHQSBBc=;
 b=NDjwMJPVjId0PfngpSIFO2Lm/7Yy1eMDZ5+r1MdjQhDEZPCLc0y1PvIQUNkOLbYB3h
 hLiRc8lyCBHHotGDFwZLgXVdmn6O+cy0W40TaTAt5DX5W5nd6sQvnWX0l/flavqtmWZx
 LNvhDIO37shBtgYXOtVhWW0HgR510afvKt7+nO2M3ETZg7/O0BWMIZPSTUelZTXKcvFc
 sR1uskphEjw0pAQGIBzrNnTTnUts2tIvgXEjGhHleJ+CBnn/1KL4Pjt72eCrzZtLfs2B
 r0WpRZAaYXkqCsSMCLicwLxM+2sB4SDKPNUocisF7gcJ+5Ttlb3KSCpVS1SXtjHp+aMT
 og1A==
X-Gm-Message-State: AFuF++nR2TukHneIQLVeNyIWhXF/9SwA9C4IwnIyzky7Y7v8Gz0CNpXT
 1CRRhrFHZ7MW83sZ21DXKZ26M+eoi7zy0g81zhZ9y431f2WFBQhk7Atl60p8Pw==
X-Gm-Gg: AR+sD121CZUmKefX3AhHmeAP4wdlpG/EcsbNe0WWKrXxpCZuY68SdNSfZQoc3XaCxeZ
 +nH8e4u8INrA4k/MHpe8YzhMn9jWNmaOw+vMplRm1OMfTfrvzm1MfOhTWqRR+oAbU7Yx4Uh2Xy9
 B8PLZYMP4MpPG+BsobGYw5cS2JQP4bcPrvmdX2D2yagAvJ4cjyldXdsoq3W0nwDjISoLMjZauVs
 ETdvpxrDTDX0h+tVdVnwm8jm8m0b6Qf8VGv3lg4OkVvtU9J7/SNDa0wbqjnHbgDyG9t07gqOWdw
 AVcVS5xhGV7AHVZrQLwJg8lARBu6Z36BMQ+XY7EqSJVKKai2h/xM9aVAdkphbA+eEWhT8VeSw58
 CO7zdYh6pww+NsvmpgFE2i+noTkmfRnSQN7FbUK/l8/q7wW618jkejnPF2e63hV/rkKNHwW7mP4
 xrbIor1mvSef8rV/MkZxZIKiWScziWlbP6Z14COvXxj6CUyNrsStY+++1KM0FQ68IOHjqQpu2MG
 zxYPQ==
X-Received: by 2002:a17:90b:5790:b0:38e:9045:babe with SMTP id
 98e67ed59e1d1-395deecf08fmr30815803a91.7.1787550523503; 
 Sun, 23 Aug 2026 22:48:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>, Junze Cao <caojunze424@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 08/96] hw/riscv: k230: add decomp gzip in K230 board
Date: Mon, 24 Aug 2026 15:46:38 +1000
Message-ID: <20260824054806.2790041-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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


