Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4C2C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiC0H-00045c-VU; Wed, 12 Feb 2025 07:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBza-0003T4-G5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:26 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBzN-0000Pv-Us
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dd9b3419cso2061985f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 04:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739363831; x=1739968631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqvweuXzxTEGE7Ytky6rwqFAbfXEcGIETL91y68eY3A=;
 b=OHHgMdZwoUKLE/JJEzE3xpTlFA8hf70P6l+44A6cArOiPblCbAO/nOFXgkj5YPQ2pB
 cFYAWv/HOmXeT6usjE0iZlwLyu0GOyHdEsg8QCmhyLoU9CQGvFNr5q/5mjA17YQEpvJd
 2g6pMqBGtL7kMRiwu0fHcnnV9g6KVSDHWQCzD5RdjigguRXc20sIXj5kP6vo+A/8+5t7
 pbpQTVIriFs/vw3YUaSu78HG3P2hu+FQC2wVpoXPmln80bM5fxLYTu7f6rAL9+TsDPhx
 FBPjg+QjDux6v6k2iCiOD1wycVUdYjsawiG6AnqKi0ZTvzXRT0VLrxT6MI7mSVzIYnPG
 whPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739363831; x=1739968631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqvweuXzxTEGE7Ytky6rwqFAbfXEcGIETL91y68eY3A=;
 b=QXpeLeTJWdUb129aA2sb7ENs2hHwBnu9q/R/UwVv9HI1oHnLMYZv0mixC3FF2OIuYa
 w1AoaBORvvfOBoEoy7cRUlCyi3+47Y40Yv1rgAvICztgPQ9XhP9PGFMW5tyIJ2eMQmow
 SiiA8dJUn+wHZG5reA2d7kF2rAv4dcLXsfXgyleBvRLjivNh+eNJ734Y6lGxz2dHcJzo
 FoccYiX2w7OJZr36j435FLWFCjU9L5ACtl+HNz25cK3GUqH5efyhK/8N3NHHoqgzkVUU
 n4+KnOFR4FjSwTwPRTcPtkapzuJ7JrIfw0wApA4Y92CrT/vgOQlyIKkgTe7Q/fpoYVkD
 qa3Q==
X-Gm-Message-State: AOJu0YymqzFAhVz5c3/87fpig/rxobFqkWuCeZgcqZK4OP1jvOgG6ko0
 o1kK8Zgf1f9rQ1uBTOENRFPVGEdv3CuSu+ZFGIm7JoNbnuIS+p7xR7geVOeSlfTjxacFIqodksR
 AylM=
X-Gm-Gg: ASbGncs3EYYTLtDEvmc442awzcvHwLfqm5pTv07xtzu7PwIQj7kMGvt18glhpR+KdK5
 mzQgkVX4Ar2AxtUOFkcgTS40CxrwSiFoa1aMwjDntvbZF9Zb9Yt7KccpLs8CAldt1NAuehao3RB
 86I15/BStGpb6kf5wtVQEKMAYKUzi3KdI4vqglk4AEDCrDoNwnejCGKSw2glPt5KC6Aw0IfsC39
 wC7GhQuWF8Xg/xJwfVhFNcO+oeMMDix9alkEVUjrHW/wjnSRgzkjTE/3cO6icPvZ3wjTuOx8dEH
 XU3DXX2pX/ZgsoylQR0iUY1Yfk0+zOpuEcPRmySPnjXJ24wl1CozVULxpf/EBfZhZA==
X-Google-Smtp-Source: AGHT+IGMKNA+uUDvHF0CkQPEsrpvpjPJQMCnomkah1kqAb4fDPI0e+A2UP8kmVgqsP2Bq5W4SfRZbA==
X-Received: by 2002:a5d:6d0d:0:b0:38d:e3fd:1990 with SMTP id
 ffacd0b85a97d-38dea354aafmr2995134f8f.0.1739363831289; 
 Wed, 12 Feb 2025 04:37:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc73c2e00sm15487467f8f.57.2025.02.12.04.37.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 04:37:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 02/10] hw/intc/xilinx_intc: Make device endianness
 configurable
Date: Wed, 12 Feb 2025 13:36:51 +0100
Message-ID: <20250212123659.52764-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212123659.52764-1-philmd@linaro.org>
References: <20250212123659.52764-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
Add the "little-endian" property to select the device
endianness, defaulting to little endian.
Set the proper endianness for each machine using the device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/xilinx_intc.c                    | 59 ++++++++++++++++++------
 hw/microblaze/petalogix_ml605_mmu.c      |  1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  3 ++
 hw/ppc/virtex_ml507.c                    |  1 +
 hw/riscv/microblaze-v-generic.c          |  1 +
 5 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6930f83907a..ab1c4a32221 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * https://docs.amd.com/v/u/en-US/xps_intc
+ * DS572: LogiCORE IP XPS Interrupt Controller (v2.01a)
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -23,10 +26,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
 #define D(x)
@@ -49,6 +54,7 @@ struct XpsIntc
 {
     SysBusDevice parent_obj;
 
+    EndianMode model_endianness;
     MemoryRegion mmio;
     qemu_irq parent_irq;
 
@@ -140,18 +146,28 @@ static void pic_write(void *opaque, hwaddr addr,
     update_irq(p);
 }
 
-static const MemoryRegionOps pic_ops = {
-    .read = pic_read,
-    .write = pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
+static const MemoryRegionOps pic_ops[2] = {
+    [0 ... 1] = {
+        .read = pic_read,
+        .write = pic_write,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            /*
+             * All XPS INTC registers are accessed through the PLB interface.
+             * The base address for these registers is provided by the
+             * configuration parameter, C_BASEADDR. Each register is 32 bits
+             * although some bits may be unused and is accessed on a 4-byte
+             * boundary offset from the base address.
+             */
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
     },
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [1].endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void irq_handler(void *opaque, int irq, int level)
@@ -174,13 +190,27 @@ static void xilinx_intc_init(Object *obj)
 
     qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &p->parent_irq);
-
-    memory_region_init_io(&p->mmio, obj, &pic_ops, p, "xlnx.xps-intc",
-                          R_MAX * 4);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
 }
 
+static void xilinx_intc_realize(DeviceState *dev, Error **errp)
+{
+    XpsIntc *p = XILINX_INTC(dev);
+
+    if (p->model_endianness == ENDIAN_MODE_UNSPECIFIED) {
+        error_setg(errp, TYPE_XILINX_INTC " property 'endianness'"
+                         " must be set to 'big' or 'little'");
+        return;
+    }
+
+    memory_region_init_io(&p->mmio, OBJECT(dev),
+                          &pic_ops[p->model_endianness == ENDIAN_MODE_BIG],
+                          p, "xlnx.xps-intc",
+                          R_MAX * 4);
+}
+
 static const Property xilinx_intc_properties[] = {
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XpsIntc, model_endianness),
     DEFINE_PROP_UINT32("kind-of-intr", XpsIntc, c_kind_of_intr, 0),
 };
 
@@ -188,6 +218,7 @@ static void xilinx_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = xilinx_intc_realize;
     device_class_set_props(dc, xilinx_intc_properties);
 }
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8b44be75a22..55398cc67d1 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -111,6 +111,7 @@ petalogix_ml605_init(MachineState *machine)
 
 
     dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "kind-of-intr", 1 << TIMER_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2c0d8c34cd2..15cabe11777 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -71,6 +71,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
+    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
+                                              : ENDIAN_MODE_LITTLE;
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
@@ -95,6 +97,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_enum(dev, "endianness", endianness);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 23238119273..df8f9644829 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -217,6 +217,7 @@ static void virtex_init(MachineState *machine)
 
     cpu_irq = qdev_get_gpio_in(DEVICE(cpu), PPC40x_INPUT_INT);
     dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
     qdev_prop_set_uint32(dev, "kind-of-intr", 0);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 26788a1824a..ebdd461ae98 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -79,6 +79,7 @@ static void mb_v_generic_init(MachineState *machine)
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
     dev = qdev_new("xlnx.xps-intc");
+    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << UARTLITE_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.47.1


