Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58DECCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 02:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBOnV-0003Q2-3L; Tue, 21 Oct 2025 22:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOnS-0003PC-VT
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:41:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOnQ-0002JL-Mp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:41:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-290d4d421f6so49097015ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 19:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761100911; x=1761705711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=GhRFt3/ytNFuDG/zI9MECKYTKCl5YiSwCeLCwQ4v5Lh0oOLZ7sbD1rSKNxFaCMqb8O
 nM5oT2puD6tLVXOeDw3Lm362S/abg6uIlmbcMGYmu6OY227Y9pVZeftBQ+xgaUnqgwcF
 dI4siNcU7IKttVCKcr/ArGD15ftULk4GVXGOZ241ZS8AyG+LbKdtiru2m8lcO58Trbx9
 ezKzIIqLV1ZOO6ali1tspIzHAfGf4YOMOclfUb9JPoMU5+PyNC+8jR6kWMv4vmLeEWPM
 gwzNO/o++is4Vqxrb0NZBtYDMz0G02lCe7ZQBamJXjGiX9IGek1oV6St/L2veEqBMwJz
 1Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761100911; x=1761705711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=hubyMimaHHszu8kgaW8CmISirof+fPweN1wc14YEeMgWK68gWnUjQ6qNFg6ZLvLwZv
 QTExXe7BZsVf81tP7djkRU0BpXiZkX5AIcl3RZuC2L0ZJWekLaYCDUiAk0nEw346rQso
 FK3h0XQErGnkRH81xqmG0KR82uTs/ebAg7TvvQn/amngB7SCZymkGjM++hkLvosXK8eW
 Vl+3LDcR4Qb2N4u+o10RXDFak4CujTTCvz+mK7z5W8YitMvCKnAj98Gw1I0/6APhQ/Ll
 jIc+5vz8WZhoDX/8JusjXwIJ/C4NU/emvpWM7VtDiGzp9Wd7USR6+FajoU5Wj58bdCbQ
 NAnQ==
X-Gm-Message-State: AOJu0Yzl1Pbevu/7fda+7eHmA2vfzA7t+olYkCL5OyAJU8K97l9yjj8/
 vaJiIs0573Du1oksN4Qgttd4ei+AsVgnTm+AEb5nlJeXwKqq3pYsDII9+Dh3ZCE1P6SvzCn7StM
 yBhAtgIRd2CirRGJxjwwFceKGcYJ02b3ciztRv9r0i4WXD6X809A70Mz5cre8jd4J5LBtkrTDsk
 /yk743vLfmnMNR9Gh6RM2DOQEbO95TG/ZYUavvCy/W
X-Gm-Gg: ASbGnctk8mNkCcpPu/bIezypESMyugqYAV9+M9wfBiJeOUiy5gRdosZ42bwWZszrTWl
 3kgUsv+lawfn//GH6m3KFMHeZbYANpfvvBg9+mVbWB0AyRCmnSPpxz4/7Oy6OHAw9ni9B5ltkqH
 FhtjbTJ7u8WCoEuJLQcOIZzwcCg0mk6eDQX0z801r8qg26XnRsWjJ4rRKKwi1hT1CXFlsdSNYfk
 7wFi+5S0sVqOEaOzSb++ORKjJ8POepQMsQqHtFyBvldEaOMAori0G0t30Ak4wPizeutJo0uGE8M
 PNk4gif0bs8mMnSPnCEes/i9gs7sbXg8a4FvKVTIKnciUNCdt054C0vu/HGkppg0rE9ePD38jri
 NpXtyKcKBmD+AEaNb5uKwvuwhdYk2qIGsi6sUH9XTNkpojx9CJ54q1O55TEjs6cghaVtGXZEIfe
 kngRmI+c3S/+aW0XJW+T420K9JfCu8nPcAe36T5rI=
X-Google-Smtp-Source: AGHT+IFb6J9Io8exj8o+qJbFf40aUI1cA8t55wtn/Hd08ZlcuC9kSYk+0HWZPNgXyYDpBWR7f1mWXw==
X-Received: by 2002:a17:902:e5c2:b0:26d:72f8:8d0a with SMTP id
 d9443c01a7336-290c9c8c7c2mr246464205ad.12.1761100910803; 
 Tue, 21 Oct 2025 19:41:50 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff1591dsm13204731b3a.7.2025.10.21.19.41.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 19:41:50 -0700 (PDT)
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
Subject: [PATCH v3 1/2] target/riscv: Make PMP granularity configurable
Date: Wed, 22 Oct 2025 10:41:40 +0800
Message-ID: <20251022024141.42178-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022024141.42178-1-jay.chang@sifive.com>
References: <20251022024141.42178-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x629.google.com
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


