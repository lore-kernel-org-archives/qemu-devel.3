Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEF4C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURGZ-0004p1-04; Thu, 18 Jul 2024 09:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGV-0004c2-LM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGS-0008SK-VM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so2808235e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309623; x=1721914423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJ1Jzmp+9J5R2QdMsXruspBz2Qg6XytMsq9xTnRszl0=;
 b=ieHRK1T5Ezk1fvP0vGybye/1zaS0mdq2hKS5mJttBmYDokg1ZqhpziDAmeah3MIiW3
 3fbK+1Kt79EE1CSEcwEG5UEV21SPnmXZAtERDB+GOlk8mda2f4SfQC1LwSRyyq2GRoCW
 vjcAYQHnVs9Bj0uCJcBbfBUWR8lesmOBbM3rj5BBXwlifztD8/AaKh0k67M3iqEHp/RF
 f5OdxGEAFK4PA7MsNikX6ln4vYB7uVYgoG5d3hm7yyUGWQKoFneVeWwf+0I8TDqLGqxc
 M/Rgyl73kZNmdNRQakn5RNmpyrFOS4fZHomN7G46dIbeiCk1SPLBO7YR4DCQRAnSqICy
 u4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309623; x=1721914423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJ1Jzmp+9J5R2QdMsXruspBz2Qg6XytMsq9xTnRszl0=;
 b=gjVaSfgcJvTKgvhYkDBKj8z4bHJRN+JSgBYKZK5qMT+5VtF5DxWfK5KEe69hFHhCe0
 YkNl4dAZ7l/YBMtM+4RMiO+p4FBg7eQxz7z5pangDrD+VGbIN6xYW/dcSI+Defoaws9p
 GKmR9tDHummSdyMGggOQlkXJdbMgku45GdAKpii9ixR1jTqVxMVz36VVCXNRfKxB97Hj
 jdyxPzWVNxzGrvgCj9lxlcnQV0zIyQL2A/kTpQBisneFhgd9l/e5LWal7KaW7P9Tlobe
 eH2h2lXfIaF6d97Hn/KLkYnoOrNK+vKqhcEegML5LsB0xFjUHNtDbFIVeuG+QtsZ8rBk
 PnXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVenk2hjsKMKSE3SYgHZh1MgAkmv0kSUxdIQEN87V3RbQpnNJcwYK5FSnZrtmPfFreyL/R9faDDXc03edv+j9eeWHQhVAo=
X-Gm-Message-State: AOJu0YxCStksGdXg5N9wVEpltodD2bVbwhzdXaZvf45tjCBEoCvvXBFX
 E2ra2+Vr4DxznOV9YngCnT4Dt9P2AaJoizLLSligethD1ifSCGll5xrHXXVQpIc=
X-Google-Smtp-Source: AGHT+IEFr9TsrX65mzWefCuFfIqH7yaREfHfabmMxJ2PMt7wM4slcU9juao6YnMxxZJzJtEdS+WfbA==
X-Received: by 2002:a05:600c:4ec6:b0:427:9dad:8063 with SMTP id
 5b1f17b1804b1-427c2cc3000mr34172355e9.12.1721309623577; 
 Thu, 18 Jul 2024 06:33:43 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b1815esm13697925e9.13.2024.07.18.06.33.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:33:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 05/19] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
Date: Thu, 18 Jul 2024 15:32:57 +0200
Message-ID: <20240718133312.10324-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


