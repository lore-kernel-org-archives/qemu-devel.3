Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB53C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMohw-0007Ha-A3; Thu, 27 Jun 2024 08:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMohv-0007HP-7l
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:58:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMoht-0004FE-Bp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:58:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42565697036so3663375e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719493111; x=1720097911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOg1K3ASk1D4ocxyo5Prrk5o6h1QXfZk+lUYF1qGDRU=;
 b=PhtJv+Yz8QTyyTy5Pdz7iZhHuBbvbn8ipKKFkZorBTgLJmVeIIIM2fyhLstDtDApN5
 2Fe8a6ovZyjeuSEo5CdkWyyBbVZlBBvQ0urY4k9yFj85EMAuipZuQ4Cu3V5ekBLlfRbG
 snEDc/N8kOMEn1Nfz7hjkPSzy+ZkPjQdmxGFp7+3wSwBZH86tA5kE+pLqjNhQTXo6sF1
 RoeyVfiVKgiQJgv2IaOkxoBPFoYeIG561MsSewAV143pZJ9AAJkZJn+T4TBCgSSMk3lB
 58btfsP0eGOrV3PmpdkO5yxBadc02KFK7+hBKjiV1nO/6EapkvLSrHaxyy8HGyuW3Lru
 ByHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719493111; x=1720097911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOg1K3ASk1D4ocxyo5Prrk5o6h1QXfZk+lUYF1qGDRU=;
 b=Bxc1SBCCvOfDa8PJqNydN9MmbtiZvLNWe8oTb+9b4/vPnKKJ3tnQmgU95c9AgAy5+x
 frVnuuN/oPsuUCZr7tdVP2svv9W8R6pxgI6KRHTw4L5dDzawV1+8U/BxORCgUNuYOJWY
 mUYA4VyvoH0lGBSUuNHKRErP0hgr4ebqyJQlpFveUMtiAhchZpZzwZFQwblQNy8xC3KQ
 6WLdtpypH5PaJgwoMemnPXlDNB5rIbehhdMNRLi3IwGjlL+sXoc3MOa/0zT3PWg9D/gx
 iczpN0QjKzmPUz0tDBp8qvvJbYeujlaPN03H2SM+Ai0HJqOBLr7q52Xkk2NsWV/Wm4M7
 D+hg==
X-Gm-Message-State: AOJu0Yz1wWj6FzvTbpAkAK74KuIdaXq21ZH08edRq7kBBp+BrcVlX6vn
 IvwQswIdwp3AXcTHXL/2zbGDnP6PRxXe+RPDXMh3UiQItWCgIcYeI2nztCiOjJXNKsWT5jevc3/
 KllM=
X-Google-Smtp-Source: AGHT+IHC4hTVAITVgiXfn5FGq3k8084fJm3MBtoGryKFm+ol7tNNOtcJ6TS8+Es2NpR8Nzy0wf7xXA==
X-Received: by 2002:a05:600c:3c8b:b0:424:8a34:9890 with SMTP id
 5b1f17b1804b1-4256450c71cmr18337555e9.7.1719493111052; 
 Thu, 27 Jun 2024 05:58:31 -0700 (PDT)
Received: from localhost.localdomain (72.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564b65a0fsm26893555e9.16.2024.06.27.05.58.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 05:58:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 maobibo <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/1] hw/intc/loongson_ipi: Gate MMIO regions creation with
 property
Date: Thu, 27 Jun 2024 14:58:19 +0200
Message-ID: <20240627125819.62779-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627125819.62779-1-philmd@linaro.org>
References: <20240627125819.62779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Commit 49eba52a52fe ("hw/intc/loongson_ipi: Provide per core MMIO address
spaces") implemented per core MMIO spaces for IPI registers.

However on LoongArch system emulation with high core count it may exhaust
QDEV_MAX_MMIO and trigger assertion.

Given that MMIO region is unused for LoongArch system emulation (we do have
it on hardware but kernel is in favor of IOCSR), gate MMIO regions creation
with "has-mmio" property and only set if for loongson3-virt machine to avoid
such limitation on LoongArch.

Reported-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h |  1 +
 hw/intc/loongson_ipi.c         | 16 ++++++++++------
 hw/mips/loongson3_virt.c       |  1 +
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 3f795edbf3..0e35674e7a 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -50,6 +50,7 @@ struct LoongsonIPI {
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
     uint32_t num_cpu;
+    bool has_mmio;
     IPICore *cpu;
 };
 
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e6a7142480..d1b7a80d7b 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -307,13 +307,16 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < s->num_cpu; i++) {
         s->cpu[i].ipi = s;
-        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
-        g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
-        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
-                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
-        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
-
         qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+
+        if (s->has_mmio) {
+            g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
+            s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
+            memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
+                                  &loongson_ipi_core_ops, &s->cpu[i],
+                                  name, 0x48);
+            sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
+        }
     }
 }
 
@@ -344,6 +347,7 @@ static const VMStateDescription vmstate_loongson_ipi = {
 
 static Property ipi_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
+    DEFINE_PROP_BOOL("has-mmio", LoongsonIPI, has_mmio, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4ad36f0c5b..a27b30ab31 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -537,6 +537,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     if (!kvm_enabled()) {
         ipi = qdev_new(TYPE_LOONGSON_IPI);
         qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
+        qdev_prop_set_bit(ipi, "has-mmio", true);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
         memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
-- 
2.41.0


