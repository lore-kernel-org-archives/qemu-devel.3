Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A52C52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb27F-0000RP-2i; Mon, 05 Aug 2024 14:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27E-0000H2-09
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:28 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27C-0006QN-0U
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:27 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f1798eaee6so18244461fa.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881244; x=1723486044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWI9WsLINkzAsWulOrb1N3N13JevfSw6Gy6N0mmyEKk=;
 b=fHrTqtHXd2ZcTORlSrRbkbNjor9biQl4Ff0C5gJky1QVXZo47A9fCXVuVAa8l2Q0U6
 fR/BOuAE8hw2Uec+j14I4cFQVXeZSXEnL5jPcjMbfmeqKl4t6LTk6OHzBrsVVPVItHCV
 ffPkVhiy19aesTRilUjw6QvXY8YSL9kHcIkeaHYKrKLsnkaT8NQZKQn/vYf9sODRO9Gc
 OgO2iLm+OZh+v0tzGVTGz8jo65n7tnBDeQI4ZdZYdK5i5zKLLveMZVPjTxCmKRV8nTQl
 826LGFp759bmaDuFLyLRD1HYtZUzVPCYCCWtJ7pRCiTncJd3K7nlc2Ctn7TiA8GWiw3C
 XxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881244; x=1723486044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWI9WsLINkzAsWulOrb1N3N13JevfSw6Gy6N0mmyEKk=;
 b=HPF2DaUJwwig4TvRL8miwFrFaOS2fB4uMoZyTwMa3CNlHao3QAFBk+vyeiIykEahyl
 Jn0iNPfWP5xQnuw/PcP1iJUaiUxWHFvR7YjAVpn4LC2qMSEOQoHdu5ZtTEc+DYvIiwht
 KcZhfnGLHNIvBjp/0sWheCP06f3G3EjEgEYfJd1dv62pnUI3a6n7YykKpph2Tp1zScxy
 x7wgVYHYFiJHE6OHhtu+qziV4iygmMpT+vv/d+K2nSu59aM6S14CvxIRjatIb09im+El
 5nM3XK0E9sunUbLs3BbqD8dT2TfYZqGPCPOdRShVyVGBD/pFgeAoY3o4oaOMwRBDdLwS
 9DbQ==
X-Gm-Message-State: AOJu0YyjXQ2jh+UZZlW2gC1cPGtKarvYbY4alqgMtwAaKPLLuQzedWDj
 9B7xaM8kXb9ENHGTgdEpDQsDHwu/Fzg4xgzIdy3ySQ4EzEm2XlBRGHIJSNJqVhB+/6j5dkZqBf4
 g
X-Google-Smtp-Source: AGHT+IFs5b/zlA8tvY5B9p52V42qhwp5X5Ig25V8zv1MxpO0NJhtSvhKMROOhZaLxU4qIl/tFAmfww==
X-Received: by 2002:a2e:9b58:0:b0:2ed:5c34:4082 with SMTP id
 38308e7fff4ca-2f15aa8354emr81576271fa.8.1722881243507; 
 Mon, 05 Aug 2024 11:07:23 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd059841sm10737504f8f.89.2024.08.05.11.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 09/15] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::cpu_by_arch_id handler
Date: Mon,  5 Aug 2024 20:06:16 +0200
Message-ID: <20240805180622.21001-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
Message-Id: <20240718133312.10324-13-philmd@linaro.org>
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


