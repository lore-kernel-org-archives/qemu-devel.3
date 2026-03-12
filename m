Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75209FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Xim-0004UM-UQ; Thu, 12 Mar 2026 00:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xik-0004U5-Ko
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Xii-00043M-Vl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:32:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ae5423b02aso4350595ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773289943; x=1773894743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epzAj+B6wXCrlYB6AtGb6lNn0V0ohZ2LaB8gM7SskXE=;
 b=Fe7zACZzi3XhFBUls4/L3kNT9ruTYBM3MP98E7L8eJv3O9fIwGMtYx/JcIMCCCnMO2
 qcET7Bvdsz60Kc0BfOFNwEsHJwssMeLLxxZ8cm3YkX91QguLP5Mq37xt+IExrL1RxSoQ
 CQouYjdHUKrD+Ke9LgDYdAfu0ICKrFV8ze1P9w4sOKfTlKUQLzYxxlFDKgmsyoTjkFpT
 ES/GsH1BYJLCeqTtKMzNzeJoCDXhLFKPKqbV1mkMshEfR7tqNNDRP1lQYjF2FPJMDakC
 3+6GT3wN3Kr5oP9MTMk1kWM2x0CIKwOcxMYmj65SWblvAyXrkdRniL/F4wNVCMeoaT76
 wr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289943; x=1773894743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=epzAj+B6wXCrlYB6AtGb6lNn0V0ohZ2LaB8gM7SskXE=;
 b=XpR/LEqQZoINzBqVHpOFVfFnIJ79bfXdYCf7g56jjShVpen6drCwauIrzUFEuQUJ9k
 jOmNX3tXpQ2zo6lBA3hCnkVRte/LmJTX3g64XsMnv5ORz3Um/6dwe6+GrkSrAwczPnRB
 C/iSiMSVTs8ReuNaj5NoPpxz6ysYtLmh2Hs+IfbTvBoQu+FbhLYjVu8C7FB5yMDsNIkt
 3o4l0DRbKkVZnxHn6kZFigMC7+2504KncgR74o00iGgfXA35N/S5FJdLqL0qoyN/7ctj
 lznKamX5iVAwICAM8i+WTy/dF/+bRTmwwqSUJl7o05k4+Nl/3SD+MHRyiquz+Q6g4fho
 rpXA==
X-Gm-Message-State: AOJu0YwTKJfEoiI+eJZcJi+GrgBeeLmOtF+G2bjTx641KuHOxp1Twy5Q
 ZWe5gKoBAZi2m7OQl5TXH0dU3DreaaTC2B8pUCvgl6Obw6kEU7125MYiPt1EEYCs
X-Gm-Gg: ATEYQzzmk6i0cCDYVOYd0ZwvSTHkUTdje+OEM11ObjXSzaqaSr7p4EG/EQ6ZomPNva1
 5vCCjhMsX1DvVTMkKqg+x6SuVioEdEtGMT6HImL4ktEaZGrJAILO9uKg+LSx3agTzdubDEyYWWG
 N6PJQfi8xcX8kTcapul9iyJtQtZtC4IYSwJk8iezqvDpEd9chC5U5n+4mtGOdayjv09LDaRluPw
 FPlNdC1aPAD/u8csnG93PlDFDPyt+Rz3n5EDcAuLnw/4g+nY67BNwBc1hMKafU3IClfFUhoFVVx
 86GIxRBqBuLCVrI3AILuPby/+gXgPpbCCL8NtfpplaP89vphBS0JG6WIaEUGOSESHDwx3XAU7LI
 3ZzK1WQ7ywcAMFbS9ZsZwoY2geQvQBXancpWGoxhASwE8nbbxuJMS+h1SK6qo+Vdc+kL52Q2FId
 gdG92GNvU6v6rUAaipHeZpbV9c5Uu4fQT83zntLIi3PeXfeuuAbP3N
X-Received: by 2002:a17:902:d50a:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2aeae890ce6mr49181665ad.35.1773289943102; 
 Wed, 11 Mar 2026 21:32:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222ab6sm54340785ad.10.2026.03.11.21.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:32:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, peterx@redhat.com, philmd@linaro.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 3/7] hw/arm: xlnx-zynqmp: Don't call qdev_get_machine in soc
 init
Date: Thu, 12 Mar 2026 14:31:54 +1000
Message-ID: <20260312043158.4191378-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312043158.4191378-1-alistair.francis@wdc.com>
References: <20260312043158.4191378-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the soc_init function would result in
the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-aarch64 -S -display none -M virt -device xlnx-zynqmp,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of initialising the CPUs in
the SoC init let's instead do it in the realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/arm/xlnx-zynqmp.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 5f0e34ccec..979e55e305 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -380,30 +380,15 @@ static void xlnx_zynqmp_create_unimp_mmio(XlnxZynqMPState *s)
 
 static void xlnx_zynqmp_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
-    int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
-    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 0);
 
-    for (i = 0; i < num_apus; i++) {
-        object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
-                                &s->apu_cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a53"));
-    }
-
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
 
-    if (num_rpus) {
-        /* Do not create the rpu_gic if we don't have rpus */
-        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
-                                gic_class_name());
-    }
-
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
         object_initialize_child(obj, "gem-irq-orgate[*]",
@@ -453,15 +438,6 @@ static void xlnx_zynqmp_init(Object *obj)
     object_initialize_child(obj, "qspi-irq-orgate",
                             &s->qspi_irq_orgate, TYPE_OR_IRQ);
 
-    if (num_rpus) {
-        for (i = 0; i < ARRAY_SIZE(s->splitter); i++) {
-            g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
-            object_initialize_child(obj, name, &s->splitter[i], TYPE_SPLIT_IRQ);
-        }
-    }
-
-
-
     for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
         object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3);
     }
@@ -483,6 +459,24 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     ram_size = memory_region_size(s->ddr_ram);
 
+    for (i = 0; i < num_apus; i++) {
+        object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
+                                &s->apu_cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    if (num_rpus) {
+        /* Do not create the rpu_gic if we don't have rpus */
+        object_initialize_child(OBJECT(dev), "rpu_gic", &s->rpu_gic,
+                                gic_class_name());
+
+        for (i = 0; i < ARRAY_SIZE(s->splitter); i++) {
+            g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
+            object_initialize_child(OBJECT(dev), name, &s->splitter[i], TYPE_SPLIT_IRQ);
+        }
+    }
+
+
     /*
      * Create the DDR Memory Regions. User friendly checks should happen at
      * the board level
-- 
2.53.0


