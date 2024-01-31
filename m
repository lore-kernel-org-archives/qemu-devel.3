Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0214FC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6JP-0001s0-Tz; Wed, 31 Jan 2024 03:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JO-0001rn-FB
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:14 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JL-0007pN-MK
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:13 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cf3ed3b917so58550701fa.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691069; x=1707295869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDOC//9rYljv8JbNJSrklqxInCkoTiR/AirLn143wHQ=;
 b=fvZOpWE35/8nt82L5Fr9x3+foNAUT6sL7QWI27P7QzYzWOLPqPQaU5yD1ks3HNbWj7
 m1f154i56nuCfy2BTBMc+A+hiHahUdtPF9exSCFU/0RqszxvB14CpK47RH1ayt+mkOUL
 5trdq8UW+BN/VnbEcL3UneWd/h2esA3b1lQVZkr3F39N+8mbzz9AfYistPE0FzvJhyl5
 QNU8qogxdXtu+0E/xw7wElVJol+Lmo7j2cW7NVdeooRFe/7iodrqeGcGwGqvgF/QBT1z
 /507ATItTySMyZ6+vpRal6eNTWULv9CgMDOzeFgGfweZN441Kh6ef4wpgJCfsSAp/+BS
 c3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691069; x=1707295869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDOC//9rYljv8JbNJSrklqxInCkoTiR/AirLn143wHQ=;
 b=P2sJPyQYMDv8hUyDe8TD4268JxJt82nZ7jPoERItKAKCelx8Is0LC8zrlxebLlA456
 DTMomxbFI5JvEDmwIbkmJX7JYhEaBCbSo4kVcvNKtlPb3+xZnDoTohu4joq8APlJ1ZFw
 tQ4avIgIeVqwZL6/H64R+F0IEEVSN99vQn7ZdkMGzQXge7NUtxS3cU/UVy+38m6T/SJ+
 w2aS3jWesuZf+V72GNnqSmPSzL3MxMTrPODEz3Vj0TPiM+f/Aiin+CE+aU0phCGwTgpJ
 NkJLI4C7XpBgpb0dKt71eyAL6aG5xuWd8lhxYGFoWfUw/ELmvU/3ZlN/UtWBva02kWp+
 G0Xw==
X-Gm-Message-State: AOJu0YwM0Cg6RjsQtJvqIWkga1wGmAj5SF2Y/n6gSA2Zhi5RW7cxENas
 eMUNSoBTsyUc/ZJ7lozSn1NgZxFEgj4XqJq0yUaEvH6yvc4359noc5C7FI6+2Pq4TetiRWZg7b0
 =
X-Google-Smtp-Source: AGHT+IHlY5klwGaOyqwk3P5zy8miktx/NMWNhpGdqiR/I31mZaTsQEnlIZBt/l/ZkLB30hIdm5mQFw==
X-Received: by 2002:a05:6512:74c:b0:50f:f9b9:f542 with SMTP id
 c12-20020a056512074c00b0050ff9b9f542mr858980lfs.7.1706691069516; 
 Wed, 31 Jan 2024 00:51:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUnop1HaG+EJLNGY2/ijnkLBpWGLiqC4kvAc96rXI5UwuJaTicKlwnqSny2YZNcrlIkRfV4WoZsjvgBd5xvyr6HOvEqMIMktzDF3g4jOj/rkvDKM42gR3GD4l36
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:08 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/9] intc/grlib_irqmp: add ncpus property
Date: Wed, 31 Jan 2024 09:50:40 +0100
Message-Id: <20240131085047.18458-3-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=chigot@adacore.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This adds a "ncpus" property to the "grlib-irqmp" device to be used later,
this required a little refactoring of how we initialize the device (ie: use
realize instead of init).

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/grlib_irqmp.c | 30 +++++++++++++++++++++---------
 hw/sparc/leon3.c      |  2 +-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 11eef62457..744cd64c58 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB IRQMP Emulator
  *
- * (Multiprocessor and extended interrupt not supported)
+ * (Extended interrupt not supported)
  *
  * SPDX-License-Identifier: MIT
  *
@@ -63,6 +63,7 @@ struct IRQMP {
 
     MemoryRegion iomem;
 
+    unsigned int ncpus;
     IRQMPState *state;
     qemu_irq irq;
 };
@@ -326,33 +327,44 @@ static void grlib_irqmp_reset(DeviceState *d)
     irqmp->state->parent = irqmp;
 }
 
-static void grlib_irqmp_init(Object *obj)
+static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
 {
-    IRQMP *irqmp = GRLIB_IRQMP(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    IRQMP *irqmp = GRLIB_IRQMP(dev);
 
-    qdev_init_gpio_in(DEVICE(obj), grlib_irqmp_set_irq, MAX_PILS);
-    qdev_init_gpio_out_named(DEVICE(obj), &irqmp->irq, "grlib-irq", 1);
-    memory_region_init_io(&irqmp->iomem, obj, &grlib_irqmp_ops, irqmp,
+    if ((!irqmp->ncpus) || (irqmp->ncpus > IRQMP_MAX_CPU)) {
+        error_setg(errp, "Invalid ncpus properties: "
+                   "%u, must be 0 < ncpus =< %u.", irqmp->ncpus,
+                   IRQMP_MAX_CPU);
+    }
+
+    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
+    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
+    memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
 
     irqmp->state = g_malloc0(sizeof *irqmp->state);
 
-    sysbus_init_mmio(dev, &irqmp->iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &irqmp->iomem);
 }
 
+static Property grlib_irqmp_properties[] = {
+    DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void grlib_irqmp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = grlib_irqmp_realize;
     dc->reset = grlib_irqmp_reset;
+    device_class_set_props(dc, grlib_irqmp_properties);
 }
 
 static const TypeInfo grlib_irqmp_info = {
     .name          = TYPE_GRLIB_IRQMP,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IRQMP),
-    .instance_init = grlib_irqmp_init,
     .class_init    = grlib_irqmp_class_init,
 };
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index b7d81c76f3..b72761b959 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -265,11 +265,11 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate IRQ manager */
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
                                         env, "pil", 1);
     qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
                                 qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
     env->irq_manager = irqmpdev;
     env->qemu_irq_ack = leon3_irq_manager;
-- 
2.25.1


