Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B234EC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJgY-0000Op-VF; Tue, 06 Aug 2024 08:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgW-0000Cc-2R
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:04 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgS-0008TS-Oy
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:03 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ef2cce8be8so5935571fa.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948776; x=1723553576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pc4HRKn0ABU9Etyo/i6+qtUkhxyrZpQEkVJjk1kRbzM=;
 b=zGVH41lOfI9QobnLVPP3IKg1NYgCrWieIp1p3WUTV+RpcWc23XXHBfQe5+VMpMPUEE
 yufuoKP5ENFt5lTxe2FrRLNOtcrGgjJJXvZ4keeZi1/IiSa0fEHsdOkAs0k4sIhmFkmm
 cJJnBKDvTce82KL0gf4+9F7uDRQS/gHL0i8cyZ5KQ4GpAuK1jx4uisMPCDZP1/MJ/nDD
 LSVQ2DiLP9/Yzy+V7w/1QCOx9ubQQfUhbz4oldB2eSDlWoO50uynR16CXkAssPIQY3hr
 Zy0yL5JGhnHc9WMoqwtEa8FC599cadtyt4QiTTf304j78t2LzhPDOidCSEofP0mdU8qn
 wiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948776; x=1723553576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pc4HRKn0ABU9Etyo/i6+qtUkhxyrZpQEkVJjk1kRbzM=;
 b=ewmZ/2qylKEBxE9AqYJZx/jwuQ+5AYw1E7+A9dHKunHRgMYyeEKZyY/2zBXGzKV71E
 1F8LCrWw5ZW3KexblnmxfFTjvgg59G3WcQMZfgO/2GZVoPnvig/rw5mRCMfMA4N8V2Pe
 9O3NAg3HWb8h+j51LtlJ38aDRD4MQLS5s2xXpk63G+zv7TEkcnKaJDNeXYMGF5S5Wthl
 IrKy7neFGS4e4P9pkGYXn1yMcwXle2whyQUD8YMRwTKvLoEuHKZYYRRY3ATSsge4YSQH
 NZgzQpZbmSMU+pEIkIMErP57LCTtJ5pJ2bvE4x2ic8yuWz24mJbD9XDGaqQMCafkU7V/
 YaiQ==
X-Gm-Message-State: AOJu0YzFzSvwW8cNyf0SvMOSRNK+3vKB9R2T5PfN8lkNaKpZf4BC9cP7
 vRNQKXTlqYBCFW6KIyGvK/cVqsdBci6YJm83IhUkDPV+fADisdTGNMvVhEh6RVNgwNCq3h8Elru
 X
X-Google-Smtp-Source: AGHT+IHzurmqcC2QcHCIcRuCYYdVCMIOyDluRId6nd/vITV2mzh8vtkWBTQ8HHIpwE57+Phc+89LPg==
X-Received: by 2002:a05:6512:1051:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-530bb39b06cmr11086986e87.44.1722948776211; 
 Tue, 06 Aug 2024 05:52:56 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e83eccsm543566666b.184.2024.08.06.05.52.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:52:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 09/28] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::cpu_by_arch_id handler
Date: Tue,  6 Aug 2024 14:51:37 +0200
Message-ID: <20240806125157.91185-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Allow Loongson IPI implementations to have their own
cpu_by_arch_id() handler.

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
Message-Id: <20240805180622.21001-10-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi_common.h |  1 +
 hw/intc/loongson_ipi.c                | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 1a2ee41cc9..8997676f0d 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -41,6 +41,7 @@ struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
 
     AddressSpace *(*get_iocsr_as)(CPUState *cpu);
+    CPUState *(*cpu_by_arch_id)(int64_t id);
 };
 
 /* Mainy used by iocsr read and write */
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index eb99de9068..4a8e743528 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -128,12 +128,13 @@ static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
 static MemTxResult mail_send(LoongsonIPICommonState *ipi,
                              uint64_t val, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     uint32_t cpuid;
     hwaddr addr;
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = cpu_by_arch_id(cpuid);
+    cs = licc->cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -147,12 +148,13 @@ static MemTxResult mail_send(LoongsonIPICommonState *ipi,
 static MemTxResult any_send(LoongsonIPICommonState *ipi,
                             uint64_t val, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     uint32_t cpuid;
     hwaddr addr;
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = cpu_by_arch_id(cpuid);
+    cs = licc->cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -169,6 +171,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
 {
     IPICore *s = opaque;
     LoongsonIPICommonState *ipi = s->ipi;
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     int index = 0;
     uint32_t cpuid;
     uint8_t vector;
@@ -203,7 +206,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
         cpuid = extract32(val, 16, 10);
         /* IPI status vector */
         vector = extract8(val, 0, 5);
-        cs = cpu_by_arch_id(cpuid);
+        cs = licc->cpu_by_arch_id(cpuid);
         if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
             return MEMTX_DECODE_ERROR;
         }
@@ -367,6 +370,7 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_unrealize(dc, loongson_ipi_unrealize,
                                       &lic->parent_unrealize);
     licc->get_iocsr_as = get_iocsr_as;
+    licc->cpu_by_arch_id = cpu_by_arch_id;
 }
 
 static const TypeInfo loongson_ipi_types[] = {
-- 
2.45.2


