Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25858CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aKA-0003FI-Rv; Tue, 14 Oct 2025 04:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v8aK7-0003Ek-Ux
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:23:59 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v8aK5-0003t6-1J
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:23:59 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b554bb615dcso3451389a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1760430235; x=1761035035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=NXcExFps8uZgb0X9dCDCGB1w+T2Q0NWEm8FaX9heQcldLWwhxESVfKHdbTPE8ALjFL
 V9n44hY/tlF9peQfqWlNbGWe6x1ybX8r+d7znENVqHUFKL2XGy93VTo1ubgIaBrHUROC
 LCM3OeBCH9SNu/zK5lJ5wFdee6mGszTwtcUkwf+WFVPzzMhlAGYV9tBNje8ZzcHSJ5iI
 gUefVgplxeLPk5/3dHHqYctxYAMd2CnIlRQbSLsqWpJsrAw9a1HvvnSrjsYXJpN5dEVu
 Tl0ckvHIr1vKGyhHpVPcO2/tnr2o07FApUr4n+PEyndS0KQaj9cuNf5A6BXIwJEFnRW0
 Urkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760430235; x=1761035035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=SxOUlGFAEEjVmaT3XRwkk90kbiHmVxSvY7BqMsyY3CYojM6ai1r1IsPTJOlh8lryvz
 qaYa3TA2xDx3QsRSfTWlqU7wR831ZVBgOvO0W1Uq79y4w2Kw4yMoUWmUU68+fTN8SGJr
 kUiy5WV1qvHNjmwbW0jqybvOYBaGSgE+BpWBD8Y8fjz531y61eKiVcXA0BkHeCBqJuS2
 cxpCU3DD5ND2WDRIHppohtFMxGHGYktbinVYY0hPD692nYr4P2CsHJSZB5cbD8OaNn39
 FT9Bnn/+trqILzvjbjAMbPEYRRbOOK8Apzs8S6QRu/YpH4CHaE+Ce1cI6Xb+gefVaKW0
 Kp1g==
X-Gm-Message-State: AOJu0Yx7tg8eG/x3rXdML2DRdZSNcwn+++7DczZWagrs6Cc2snM/ylqx
 ytxV3ZwliSIPY5VpIciekM/mgs6W2eRb1vDueGmqa+yMpQfdkRLNfR3+RRXECw5Y/zHN5zLQBhT
 3fJZ7rnDwcO2qGT0aqQHv5MZlIi369gXmxsmu9u7Nh3VnOXemhuQWpxIFT01+DT7JKwAcUBS468
 hYCKeynpFxwQTdvIQ4gM0J9nU0mXrXcEODk8+D2/di
X-Gm-Gg: ASbGncuFkqcEJbC3Oy/r2Ek64elA86GtffFWswIx0kfOHQBb8GGlKs7flV7NNbZNEL6
 jLIYpKrikeBgAG7zYLxKBCXMbeWkKrDMQrYY1NwXUSx2gyXy3QrljgnLmNe4IDjtH//g+aOfo42
 QjiIy+AbXjQWfLrDn37zb/DeE+FJT0b+FMFr1I5fRK09jKvhDwDVAcABW+maaEdbZlNoLqQSv9s
 PbzYUyUACs1ZsqXAIOJ2YKqjH+6NOA8EnspmzZWj1MQDjsYaXB8lQgjij6miMAaeG7K/13E/VZA
 lZJm/ooc7oOlUSZ725MA3Ko7j33yBasNk2dWywcunpgJhNZxG+UEmYg1majjcdM8PTxi/1JV+4B
 L0XX0eRwf74qgaYd1yKA+4ivCc5jePLNcEKnKgqO2zmAIW48QhNd5iWmKVVeccxA4JgDD2/MzTr
 ITJ/lq
X-Google-Smtp-Source: AGHT+IGF7l+YAH2oduE9aCljvJtuOiw+VCE/hUqU/BLwDsTFsvHnvB5Lh11Y5I74xnWIrIckeDFeVQ==
X-Received: by 2002:a17:903:11c6:b0:264:70e9:dcb1 with SMTP id
 d9443c01a7336-290273a1750mr293434515ad.56.1760430234892; 
 Tue, 14 Oct 2025 01:23:54 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93e06sm157162815ad.115.2025.10.14.01.23.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Oct 2025 01:23:54 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v1 1/2] target/riscv: Make PMP granularity configurable
Date: Tue, 14 Oct 2025 16:23:37 +0800
Message-ID: <20251014082338.87618-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014082338.87618-1-jay.chang@sifive.com>
References: <20251014082338.87618-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x52c.google.com
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

Previously, the PMP granularity in qemu always used a minimum
granularity of 4 bytes, this patch add pmp-granularity to allow
platforms to configure the value.

A new CPU parameter pmp-granularity has been introduced to the QEMU
command line. For example:

        -cpu rv64, g=true, c=true, pmp=true, pmp-granularity=1024

If no specific value is provided, the default value is 4 bytes.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c                | 39 +++++++++++++++++++++++++++++++
 target/riscv/cpu.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a877018ab0..73d4280d7c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1121,6 +1121,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.pmp_regions = 16;
+    cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1606,6 +1607,43 @@ static const PropertyInfo prop_num_pmp_regions = {
     .set = prop_num_pmp_regions_set,
 };
 
+static void prop_pmp_granularity_set(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, errp);
+
+    if ((value < MIN_RISCV_PMP_GRANULARITY) && (value & (value - 1))) {
+        error_setg(errp, "PMP granularity must be a power of 2 and at least %d",
+                   MIN_RISCV_PMP_GRANULARITY);
+        return;
+    }
+
+    if (cpu->cfg.pmp_granularity != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.pmp_granularity = value;
+}
+
+static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint32_t value = RISCV_CPU(obj)->cfg.pmp_granularity;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_pmp_granularity = {
+    .description = "pmp-granularity",
+    .get = prop_pmp_granularity_get,
+    .set = prop_pmp_granularity_set,
+};
+
 static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
@@ -2606,6 +2644,7 @@ static const Property riscv_cpu_properties[] = {
     {.name = "mmu", .info = &prop_mmu},
     {.name = "pmp", .info = &prop_pmp},
     {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
+    {.name = "pmp-granularity", .info = &prop_pmp_granularity},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2c2266415e..04711f93a2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -176,6 +176,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MAX_RISCV_PMPS (64)
 #define OLD_MAX_RISCV_PMPS (16)
+#define MIN_RISCV_PMP_GRANULARITY 4
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0df..a154ecdc79 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -166,6 +166,7 @@ TYPED_FIELD(uint16_t, cbom_blocksize, 0)
 TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 TYPED_FIELD(uint8_t,  pmp_regions, 0)
+TYPED_FIELD(uint32_t, pmp_granularity, 0)
 
 TYPED_FIELD(int8_t, max_satp_mode, -1)
 
-- 
2.48.1


