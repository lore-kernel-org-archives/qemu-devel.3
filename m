Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776D7C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJfj-0005KG-Uw; Tue, 06 Aug 2024 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfj-0005Hj-AZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:15 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfh-0008Hi-DR
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:14 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b5b67d0024so931808a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948731; x=1723553531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3ILWy+ncwfc6QydM5V2TsF6gCu3vRJehqiG1EZoOS0=;
 b=XfUsLN/1hEwxDPU+Iwe6d6z4GT29++AU6jbVXWtxvl/52+U+1IblRNIS324J2l+yTq
 dSHX19ySUflsm4YH4/a0tmTXMf+EoXZmEDg+u3/v3Wp4Jpq8f+nsREWh7OIK157tNlEW
 quEcrIGnIvn6Jl+mfs6wdI4wWwRAaLUXFgE0vPqnbt/szXRBIHRDcAQQ/1daCWHEdqp4
 Z+IAyswko3TuUQ3qufXk870/md7pP4hiSprABTgLLioIfy51VBii6IlwiEHXs6oVY4ZW
 4dXQ7towbBz6qFOPMH0dLUvIyLeKkvUkfr2yWyyx8mP+EWcZhptBHxgrxh6cVcL4XQGi
 x+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948731; x=1723553531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3ILWy+ncwfc6QydM5V2TsF6gCu3vRJehqiG1EZoOS0=;
 b=VN9svrnX9S0Zbk7eigtG88q9IjSK/L/t3+rQ76D0gXDVXlBA5OQ5I19TJZf4qwPRAA
 puQgYaVSBTRXBeXrslwhFsC67+hjcNu4cJux0IJ8S5XqpIZMdvh9KW7oYbtt8Y+ITAC+
 aKzPXCESfSoLf37QAv7Aq/NyoUJboPWtm3nUljAgEl1pFtE5PXL6Pfz+BMNfPPEVjsAV
 YPGbeV2jh0ThJrSafNu3dQu8lRgyG18qqyiTDA08g0+HpA7W1OVtU/Z/p7ufUB6hz2kw
 osDqmBkia9Q0GEFpZ43VcD3d3Gws5cGNERRFo59nVoJIe6PN7gx+OPEsNt2FZ6enuXUr
 EuyQ==
X-Gm-Message-State: AOJu0YzjXbjkJvXtOGl27PMU12wBdsqrWNo1s1wikroLQ2h+EuM2bqPm
 tUgd5saLqhMreD6Rvm6gxFf96ubaaxTxBOO5xPRaDb7PqoKUsfWd8FTKLNwbxUbxGFwcb70eiG8
 b
X-Google-Smtp-Source: AGHT+IF/8iVuUEILhbMKAhGlXHPgFPqIxxY8NDVzXN0S+2jr7J63kyUrpsOJA1ktb622tYALz8sUoQ==
X-Received: by 2002:a17:907:2cc2:b0:a7a:a46e:dc3c with SMTP id
 a640c23a62f3a-a7dc4e50c0cmr962164766b.15.1722948731604; 
 Tue, 06 Aug 2024 05:52:11 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3cf3sm556585666b.13.2024.08.06.05.52.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:52:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 02/28] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
Date: Tue,  6 Aug 2024 14:51:30 +0200
Message-ID: <20240806125157.91185-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

In preparation to extract common IPI code in few commits,
extract loongson_ipi_common_realize().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240805180622.21001-3-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 903483ae80..8aab7e48e8 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -275,7 +275,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
 {
     LoongsonIPIState *s = LOONGSON_IPI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -301,30 +301,46 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
 
     s->cpu = g_new0(IPICore, s->num_cpu);
-    if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for IPICore faile");
-        return;
-    }
-
     for (i = 0; i < s->num_cpu; i++) {
         s->cpu[i].ipi = s;
-        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
-        g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
-        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
-                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
-        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
 
         qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
     }
 }
 
-static void loongson_ipi_unrealize(DeviceState *dev)
+static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
+
+    loongson_ipi_common_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    for (unsigned i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
+        g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
+        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
+                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
+        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
+    }
+}
+
+static void loongson_ipi_common_unrealize(DeviceState *dev)
 {
     LoongsonIPIState *s = LOONGSON_IPI(dev);
 
     g_free(s->cpu);
 }
 
+static void loongson_ipi_unrealize(DeviceState *dev)
+{
+    loongson_ipi_common_unrealize(dev);
+}
+
 static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
     .version_id = 2,
-- 
2.45.2


