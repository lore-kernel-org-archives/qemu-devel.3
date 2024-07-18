Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D263C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURGp-0006E5-Di; Thu, 18 Jul 2024 09:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGm-00060M-SU
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:05 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGl-0008TE-3i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:04 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so12638441fa.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309641; x=1721914441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9k+W618/88rRr04cAPSKh6//w4YIEYjOv2dqq83ZlE=;
 b=phUhKW+aS30YSM5QfgvcPzq7BvDPEj1WmGtwn4O5o3ePe3X74damjR8GBnracFLV5q
 4OBb9HG3/l9p2MqFhoSV+8i2b/254T8YP+AiIQWO1pZcEu3hsa2VC6Uk/U3ZKPlt2HCg
 02qXhdfpdq35NcQ57G+ARUcFRkBmyduy6tqw9NZiB8O4OIP3BjXst4J4d0bE3F7cBoJD
 lgB5gB077JWEQc7OcKMBjF6PkDOjujWV9qW/+yRsFSXr9CKXy0TBrEU5nvg0MkcOjn2D
 /BQMNB0irSmVA7jO1es4AFB5k6CJZ5Re2fc953x3797iqUI3YPe8t1QG1Rw/bZKWiUbY
 4Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309641; x=1721914441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9k+W618/88rRr04cAPSKh6//w4YIEYjOv2dqq83ZlE=;
 b=EvTgAMqpdt2WxDufE7Svc1PF4A4SOKBNW6jVb+2bfkPBU3z+yjcg4YruZjNejApng/
 lBngk/XcqQCB3tp3QuvPct7m57/vukMbWAihV/xAsi6o0JOes2wbU/A9yPzDOFbyzUwV
 SXIVcFixaL+YuPE70ERfJ90BwBMg+D2pWncMmF+gV7zIAwJDdpzdBxOumEIhccPVxOk8
 wwCCIutF44+mpbrN+TgNMd3w9lZMAoWUjVJpZIA/c/2K+Y1UpUx7cvvZfvMXctiKjp3D
 5oo7+VNsx4k4qC4Yl7AGv+roHJoBk/8o8+E54cAv43UIKmHzSladizFc38efJIKTC9XN
 Z14A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+oy4fivbZYURf5YAp2Hb3A61qspBxNAGtGq1qAMIxPQGeEcyFv1YdmKNLQeHPTFQhs9IPgdAWZU1KrNIJ9BXCJ4yTPYM=
X-Gm-Message-State: AOJu0YwfLtimorvB4b/5ZCq9REO7hxowWwPf2qTREraatUa2SlvBOxGB
 eE0fa5amWUMEHqvGvWM0DEt/dS6y4VflHIW46saADNiwHbqXMb/R5xNSntwvTpE=
X-Google-Smtp-Source: AGHT+IGl5Y278ikNuMFIXwFqaHZJUkHrmCM3SVsIulBP4+uJ9ULVbrHcGgPmFopPo/GM5MVjzlL/Fg==
X-Received: by 2002:a2e:9c84:0:b0:2ec:6608:a3af with SMTP id
 38308e7fff4ca-2ef05d2a5acmr15816121fa.31.1721309641036; 
 Thu, 18 Jul 2024 06:34:01 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3684ef5b688sm1771553f8f.1.2024.07.18.06.33.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 08/19] hw/intc/loongson_ipi: Move IPICore::mmio_mem to
 LoongsonIPIState
Date: Thu, 18 Jul 2024 15:33:00 +0200
Message-ID: <20240718133312.10324-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

It is easier to manage one array of MMIO MR rather
than one per vCPU.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/intc/loongson_ipi.h | 2 +-
 hw/intc/loongson_ipi.c         | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index d53bd5dcfe..00a65a82fb 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -19,7 +19,6 @@ OBJECT_DECLARE_TYPE(LoongsonIPIState, LoongsonIPIClass, LOONGSON_IPI)
 
 typedef struct IPICore {
     LoongsonIPIState *ipi;
-    MemoryRegion *ipi_mmio_mem;
     uint32_t status;
     uint32_t en;
     uint32_t set;
@@ -38,6 +37,7 @@ struct LoongsonIPIClass {
 struct LoongsonIPIState {
     LoongsonIPICommonState parent_obj;
 
+    MemoryRegion *ipi_mmio_mem;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
     uint32_t num_cpu;
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 20f3f6bd3f..2319aea18f 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -320,12 +320,12 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->ipi_mmio_mem = g_new0(MemoryRegion, s->num_cpu);
     for (unsigned i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
-        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
+        memory_region_init_io(&s->ipi_mmio_mem[i], OBJECT(dev),
                               &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
-        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
+        sysbus_init_mmio(sbd, &s->ipi_mmio_mem[i]);
     }
 }
 
@@ -379,6 +379,9 @@ static void loongson_ipi_common_finalize(Object *obj)
 
 static void loongson_ipi_finalize(Object *obj)
 {
+    LoongsonIPIState *s = LOONGSON_IPI(obj);
+
+    g_free(s->ipi_mmio_mem);
     loongson_ipi_common_finalize(obj);
 }
 
-- 
2.41.0


