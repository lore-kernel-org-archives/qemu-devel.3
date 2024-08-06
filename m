Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C723BC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJgQ-000803-6E; Tue, 06 Aug 2024 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgL-0007ZC-QX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:53 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgJ-0008TG-8y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:52 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5afa207b8bfso557259a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948769; x=1723553569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mKdPYX00cysnIaHHc614x0QrHflyLw6OzvKS8k0g7I=;
 b=rXhG4b4/uKpFn6/cxsG/DZb34p7J5FqOaBSnmWqczCCZSPhdexW36i0/Syu+g2/zj2
 qZfcUQGH9kTdiNV/4l1w4ZNKnY9vulYdGXvM8DVNmWYHyL4jLe+1XcTwwwpRGNpH+7w5
 CJVy0LG6Lin5RqqYGqkOCA4WeJVEhOqNOZE+xcwDXqjGLJxDgRvI0yICYwLTK4djXTKr
 Yf/1B1VP+Uo+Nb+InCuGfeOlP1/XPK1l0TK8RHgt9+Z0RHTE3pADw1AORHScTxx1qzEW
 Pw9tztTIo47hrLnPIgFBvfVhYQj9bhBXsNWngh+kvNeBh+QjKVXoMyYADVg0ib5vaA95
 bNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948769; x=1723553569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mKdPYX00cysnIaHHc614x0QrHflyLw6OzvKS8k0g7I=;
 b=JXUcoKadFSke+j5JlfDv/3eL37B/RcrtMFOz+pd8ONHM6H+L9MfxuDql5EopDk2FIN
 mpOLc6IUHOcI4aymf0aSxyp4yWtf/6fTuWoQE5/eD1ZDa6ysRUeeiUjY1CCMiFMBRXb2
 ATzh7jq7e/mUotg8u0Q26X1ucP33NCeGvRUVe5YvbpGK+ztSARioQE7u56N2VqC3CrhM
 qvn/ap4YddLRXa/4cvM043Zyyb7ZYiWlRQjIVSd77+CIu7p0ao0ZTmH6Fqr47xIk0YuE
 LW8KtfIKHu0pFXV/xfKbA7CYusG6+7NA9vFN6UBGoDPoQygTf4ZrzWu15603Of62hpD6
 AfVQ==
X-Gm-Message-State: AOJu0YzUmRl9RT4PMb3JccDO/8i8ZSOlFdS9i6eUTZjhNGfjC83KggCJ
 BvbqsLHtAeqGuvq7qEbsg+/Wcqzp8SS9zJwq2V8FSzowlMf6ELbyJc6Ugo4AasyXR2BlRx2nrfE
 E
X-Google-Smtp-Source: AGHT+IG2iXGLH7xg5xXZO0cJfqpcejKmxTSK5PCb8+BH4F/+U0VgtzAxSioxsrDQHLZScrfUb3EOaA==
X-Received: by 2002:a05:6402:129a:b0:57d:72e:5b3a with SMTP id
 4fb4d7f45d1cf-5b7f56fb7cbmr9883959a12.33.1722948769369; 
 Tue, 06 Aug 2024 05:52:49 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b82c068sm5896520a12.60.2024.08.06.05.52.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:52:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 08/28] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::get_iocsr_as handler
Date: Tue,  6 Aug 2024 14:51:36 +0200
Message-ID: <20240806125157.91185-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Allow Loongson IPI implementations to have their own get_iocsr_as()
handler.

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
Message-Id: <20240805180622.21001-9-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi_common.h |  2 ++
 hw/intc/loongson_ipi.c                | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 967c70ad1c..1a2ee41cc9 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -39,6 +39,8 @@ struct LoongsonIPICommonState {
 
 struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
+
+    AddressSpace *(*get_iocsr_as)(CPUState *cpu);
 };
 
 /* Mainy used by iocsr read and write */
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8bf16f26d4..eb99de9068 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -75,24 +75,30 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
     return loongson_ipi_core_readl(s, addr, data, size, attrs);
 }
 
-static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
-{
 #ifdef TARGET_LOONGARCH64
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+}
 #endif
+
 #ifdef TARGET_MIPS
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
         return &MIPS_CPU(cpu)->env.iocsr.as;
     }
-#endif
+
     return NULL;
 }
+#endif
 
 static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
                                  uint64_t val, hwaddr addr, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     int i, mask = 0, data = 0;
-    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
+    AddressSpace *iocsr_as = licc->get_iocsr_as(cpu);
 
     if (!iocsr_as) {
         return MEMTX_DECODE_ERROR;
@@ -354,11 +360,13 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongson_ipi_realize,
                                     &lic->parent_realize);
     device_class_set_parent_unrealize(dc, loongson_ipi_unrealize,
                                       &lic->parent_unrealize);
+    licc->get_iocsr_as = get_iocsr_as;
 }
 
 static const TypeInfo loongson_ipi_types[] = {
-- 
2.45.2


