Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA32C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJfg-00056x-J9; Tue, 06 Aug 2024 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfe-0004yH-Hv
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:10 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfc-0008FO-Ga
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:10 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a9e25008aso70062566b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948726; x=1723553526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r9MKTSBwgwttJvbysh5jbQ4GwhF2zf+7qcgRbCi1Lk=;
 b=ZpxCe7GQZdveWiEjicBG/2MYWDl6a/dtfnN4mtDLAuaJNCH3NiIuJjG6PO7dWmQMGb
 haGe7TNNGligbpo5YOk10a/UzjMX9Z1PlgBBX6T39UKYOFEEYgeTjrMsUL2yTQkp3WnH
 RcRx4XWN431UrWdCP1eEwhtNVIzXO33An1lNUthCBLmTNbIg04poaXO5G/r1hvLvdIx3
 dL/XgPHgbXn/RwUFkLkPEMVJorP3JjKbHMxAHlsgPnHBlkgVq92d/HViXJ0J0C+VvMAV
 Jay7lPATB7hIFLgejVfHN1OZAWX/uQWyIRFf+IrWfKr3JfZx27G1FOUCXGPR8qBQQXxr
 PpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948726; x=1723553526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7r9MKTSBwgwttJvbysh5jbQ4GwhF2zf+7qcgRbCi1Lk=;
 b=N6hJdkU5FNowqQQ86EF65Ns423VMUnhzfyvjJ3mH21JNK6816tSnfG/KUL3Wjb4r+F
 WRNe4e7bsXi9piJmS2VavBvT4/hA5SM7BCsJQvjexQSAhvilK3Dz96hbTJkpCGwgynlm
 n7bqFGrKGWpFtygCGZuiThSEL+Ed1iqvxmoRPJaRz5OCCouv6bXpS/gpj0ES0AMzGJRr
 ORpQkh3vgKaOpe0BnwDc8nLxsmGIgUvXzZCziKhPsS7paCr7OQglQQLXaZOYSopbjRjd
 uSmH+Bb0tX/POyrPvR3DJs1/VoFzMCEo8S+FOrZEFSOxS+hivuc3SsbTp9P7+xd9bMlK
 tB6A==
X-Gm-Message-State: AOJu0YySuBmpjxQTx5FLv8YGv2t3sjxhM+iwGSZZ3z6MT2AqksAvXI3j
 YAQbNuPdtZVsYFhOdPtNq0JVR5y8BUBiQ5t9Gn96iVWdazVt+PfrVlqCtg43aYj1c8gRbB4sWjk
 e
X-Google-Smtp-Source: AGHT+IFO3crPfC584RU5U8wdeX1CGSIRxzKXGCnI7vNlfd6YKgtrV6M3MpMwSOV+ViaqMTORlBC+kg==
X-Received: by 2002:a17:907:7f21:b0:a7a:9144:e254 with SMTP id
 a640c23a62f3a-a7dc4d94affmr1109244466b.10.1722948725813; 
 Tue, 06 Aug 2024 05:52:05 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ecb129sm544015566b.222.2024.08.06.05.52.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:52:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 01/28] hw/intc/loongson_ipi: Rename LoongsonIPI ->
 LoongsonIPIState
Date: Tue,  6 Aug 2024 14:51:29 +0200
Message-ID: <20240806125157.91185-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

We'll have to add LoongsonIPIClass in few commits,
so rename LoongsonIPI as LoongsonIPIState for clarity.

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
Message-Id: <20240805180622.21001-2-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h |  6 +++---
 hw/intc/loongson_ipi.c         | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 3f795edbf3..efb772f384 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -31,10 +31,10 @@
 #define IPI_MBX_NUM           4
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
+OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPIState, LOONGSON_IPI)
 
 typedef struct IPICore {
-    LoongsonIPI *ipi;
+    LoongsonIPIState *ipi;
     MemoryRegion *ipi_mmio_mem;
     uint32_t status;
     uint32_t en;
@@ -45,7 +45,7 @@ typedef struct IPICore {
     qemu_irq irq;
 } IPICore;
 
-struct LoongsonIPI {
+struct LoongsonIPIState {
     SysBusDevice parent_obj;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 682cec96f3..903483ae80 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -64,7 +64,7 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
                                             uint64_t *data,
                                             unsigned size, MemTxAttrs attrs)
 {
-    LoongsonIPI *ipi = opaque;
+    LoongsonIPIState *ipi = opaque;
     IPICore *s;
 
     if (attrs.requester_id >= ipi->num_cpu) {
@@ -160,7 +160,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
                                             MemTxAttrs attrs)
 {
     IPICore *s = opaque;
-    LoongsonIPI *ipi = s->ipi;
+    LoongsonIPIState *ipi = s->ipi;
     int index = 0;
     uint32_t cpuid;
     uint8_t vector;
@@ -214,7 +214,7 @@ static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
                                             uint64_t val, unsigned size,
                                             MemTxAttrs attrs)
 {
-    LoongsonIPI *ipi = opaque;
+    LoongsonIPIState *ipi = opaque;
     IPICore *s;
 
     if (attrs.requester_id >= ipi->num_cpu) {
@@ -277,7 +277,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
 
 static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 {
-    LoongsonIPI *s = LOONGSON_IPI(dev);
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     int i;
 
@@ -320,7 +320,7 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 
 static void loongson_ipi_unrealize(DeviceState *dev)
 {
-    LoongsonIPI *s = LOONGSON_IPI(dev);
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
 
     g_free(s->cpu);
 }
@@ -344,14 +344,14 @@ static const VMStateDescription vmstate_loongson_ipi = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPI, num_cpu,
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPIState, num_cpu,
                          vmstate_ipi_core, IPICore),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static Property ipi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPIState, num_cpu, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -369,7 +369,7 @@ static const TypeInfo loongson_ipi_types[] = {
     {
         .name               = TYPE_LOONGSON_IPI,
         .parent             = TYPE_SYS_BUS_DEVICE,
-        .instance_size      = sizeof(LoongsonIPI),
+        .instance_size      = sizeof(LoongsonIPIState),
         .class_init         = loongson_ipi_class_init,
     }
 };
-- 
2.45.2


