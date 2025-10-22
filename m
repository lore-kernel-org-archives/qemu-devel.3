Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C576CCD1A5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 02:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBOYn-00072C-80; Tue, 21 Oct 2025 22:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYl-00071X-Fo
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOYj-0000wi-JH
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:26:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-269af38418aso78436455ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 19:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761099999; x=1761704799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=mFQ42KHDaMe0xQom01hozNjHKp9QvEYY/EKRJCr2QdhMVUu4AXL1o2gVhc96Xz9SbC
 tKoaLfsGyW0oMgWLnQ6eknhQnzCgCyqWptd7bnkROkBIg43U5/ECNn8eg7FfHHiRIAFT
 JDOLJExaOhbf5wQOA5tf8Q0wGMLjDEFukZpap/LSnEi4a80MP/wZSddWH5Ck8bsDDeDY
 +Ht8Pm4K3Doiuy5KIkxdx50ZvHwdz0aI9kDv31dLzoK9ih9bSkIKHPA5YhZOEqNUDoZb
 ky9FvOvm1VWbx/He2ifZIkQt8D25u0rpTJdrzBy/fuD/KtFWn/jNezQwbX/oY7uXXo5y
 wdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761099999; x=1761704799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=LAYT7Om5i/BqxH3tlvgIIBinHcan9ZwwBOb5htlBuxpUGlDWnPUkmQLkGo74YGXWW8
 T3QnBB937icDqrZLAEd1XFe6bg3Xw/Eb0DHL/A/+jsvI8cyGHf13VfQtilRaatS89rg0
 MR0Jd9tQ7xO0VVIUkWN54wzPPMgv9jbRiXhLmBmtTdTjwdiIBrtdocOVCmOPmzsu30AZ
 cYQUEoVstJaGJ3tIpmhC7T+8bqL9aYsk64kgVlTNguyULM3B6WoPOHaQrddp77LEGvMK
 N0nXeWOUeAZV/lhxnebk2LOi/7sHhCkPmDtTMyZSFEujm+3eUgcz3dPmkgqWyagcFElz
 WHng==
X-Gm-Message-State: AOJu0YytgBqGM1nje3K7fUimbycx1Q6kKdLeJZIXku5EcVpGvajO+LYG
 fGRJYlukqTkfUXPTksRiXJh94e96pkFU094m6t/ZT/nbUFHxc8dR2CNa9HGxA0v7L5i9kLZ/RCB
 kER66JCLwjPDVJx0D+RaSzyc0WsaAndQQToi0aphYbE5IwqQg9d7tWxxpnuupk11oO6mJai5eO4
 K5DuZ/KjRpiyH/jtrdygcE4u9k6wuzdIVx772d1mVK
X-Gm-Gg: ASbGnctQcB0YrWnsiHmdSCoW3JjXlIiwZvjDBENgCrS2llg2z/seU+1pWtOxi5p+44U
 Fz1bNl6iq2KTrE2POydJKEPZjRkkW4gHlC3GKs5xUaO1xkvr2nV4HB9UEat6vSyA2GNB0nuDP2G
 JKogBcU758HGlB4vlFUvXLtNPxRnkhPxLJIgRrZ/bSpzF/M22ww1kxUhEQi6GJPhpYeki+XB4RM
 8CXpvf0FFs6dbaJfgSo3N3hQ6CPVQoPIgGJ1heFADvnU6XG12f3MYYYIe6K27syfxP+TXkewnfM
 AT4NNw6pE5V7lQ86sYqJb4kDuPSwjY6dMEXhH+OtV1DriHjnlvv3nQbKAN+eVkGT0Tc3JwtQHxK
 LJ0F/PE//pUb+t3ON2Um2jgE/WAsRCYs6vz6HhXcjaSyoWZxkflQTUfZ7A+0Tnf4OaNxfJaY7jT
 bv7URnKhmIRejuRuNXo3k/tggsXnvNWEldLyFaiB5orMtz6PUEdWVlm4ymNxTH
X-Google-Smtp-Source: AGHT+IHrnWkZFh02KcWnwFZ6SA0AevY3gArLXrkmpSsvhFAFWPgLULqpv20TSwEPyQQxl+Ph3vdVyQ==
X-Received: by 2002:a17:902:ce12:b0:26b:da03:60db with SMTP id
 d9443c01a7336-290c9ca6b1cmr238723685ad.13.1761099999416; 
 Tue, 21 Oct 2025 19:26:39 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2930340092dsm4673545ad.42.2025.10.21.19.26.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 19:26:39 -0700 (PDT)
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
Date: Wed, 22 Oct 2025 10:26:24 +0800
Message-ID: <20251022022628.41307-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022022628.41307-1-jay.chang@sifive.com>
References: <20251022022628.41307-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62b.google.com
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


