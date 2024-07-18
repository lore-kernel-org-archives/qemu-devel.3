Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BBAC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMfh-0003LT-Gj; Thu, 18 Jul 2024 04:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMff-0003EP-MJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfe-0004jl-2p
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-367e50f71bbso316370f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291964; x=1721896764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+5AHR8p04TtPyVB2xdxLCWoE6SoJESjvxVPVtFQfTE=;
 b=iwk7cJ+jh30jfxt29wlY3xkIgbT4wA1Aj5S2Y8vmFH4+LTRTpoli+X6ME3Wyr/PwTK
 YB+Le9UzuKqZ2uJH8NMfpZGYKRD0313tgWey3g+TWwM3pTuGBDeleFVyOII5Hi0qiuSi
 zyadFt8B1YOZb778eQC2PrIhOg3hx/SRIna5CWIf1fKp+IsluLdxyoEWY19Nh68p/Fr0
 5zy97tNx22i4xG/KbAjdv/PX+F7rTK7itlmhBdhoqFnqoTJzxe9utt2puBW9BCX2+/PY
 H8zmNqRIrc6YvTgpf03FQM8Y4g2voG+UdtFpXv+RYlROpL1CXhNR9YuxxJ6wzUpOZ+zG
 Zr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291964; x=1721896764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+5AHR8p04TtPyVB2xdxLCWoE6SoJESjvxVPVtFQfTE=;
 b=HDryNVmC8rAgagzTIeVwtSedu0xPBgeck9TDYEdNfdS8la7RXxbE7OtOpeYbo/GgE6
 P+nVR2yFZeMqm0oK/sVDMv4zMd/Ha+UJkv3Vr/zhMHJcShAfBY9d8bY7Wb2AUUznmIj/
 2buAodadOkDdwTkw3oSo3sF3KEg+Mo+pGLEFtWvpcwaGLPV2gWCXZ+Uv/50bYkEyoyGa
 Ef9B93vC/mbcwDJg+l0htqHaHNeqEdDN+Wttn6DmHNot6Fd2n9It0pgyUfbbsWDikH0s
 CDBZLPz/hHVp3vrQSgEo1WFATyJC29CLmwLIW49CqW14a0XE3qZIkObuGA6WhpcBvZPa
 IfWg==
X-Gm-Message-State: AOJu0Yzfb+0LFkIfri0i7zE+W/snf/UMb3J4mg1z2uUmAdzgNKcaUjgK
 PbhD6bRmvz/xjeFmC+9fD/AiV3Tbqx4lFb7ZuoukW52an7dZ3zrQxOG49JOReBJQ6fzEFlPVenH
 br8M=
X-Google-Smtp-Source: AGHT+IEh20DsuUrkBqNwB2tdDZP0O8sPLPelij+/plFK9RjZz80nSZE9U98pMThu3sR/kCO3tiZFHQ==
X-Received: by 2002:a05:6000:e88:b0:35f:1c34:adfc with SMTP id
 ffacd0b85a97d-36831797724mr2189240f8f.67.1721291964275; 
 Thu, 18 Jul 2024 01:39:24 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabefa6sm13595076f8f.44.2024.07.18.01.39.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:39:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 05/18] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
Date: Thu, 18 Jul 2024 10:38:29 +0200
Message-ID: <20240718083842.81199-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
---
 hw/intc/loongson_ipi.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 960d1e604f..bab4d8816b 100644
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
@@ -301,20 +301,31 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
 
     s->cpu = g_new0(IPICore, s->num_cpu);
-    if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for IPICore faile");
+    for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi = s;
+
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    }
+}
+
+static void loongson_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
+
+    loongson_ipi_common_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
 
-    for (i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi = s;
+    for (unsigned i = 0; i < s->num_cpu; i++) {
         s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
         memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
                               &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
         sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
-
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
     }
 }
 
-- 
2.41.0


