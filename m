Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F62C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3mw-0005xo-DN; Wed, 15 Jan 2025 08:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3mt-0005wg-F2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:27 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3mp-0007s1-K4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:25 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ee29277d44so3294434b6e.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736949021; x=1737553821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29DNBFKk4MNawdRctkWk2PBdF4ZL+YSuccvv3D3ogz0=;
 b=hkU7t0Y5e5bV5Z9tZuMKJvG8S4Cy71xW8K4Tg9MvxHbdB1b3my1jJnhmtc1M4Kt8H7
 rV9sp/1AT3qpoKwwEzLUbolawRxBNfJqc4RyRV691pqQUpbu9TDJ6aKXBzfi5ra1VsO5
 n+Hy7mWkEoh1YQTX2ZcUjUM8mar3NP1KU97va1jZR/OY37ReMJWkltWdl8XIkZF2pKIO
 9efsBXPm71mj+n2noXB3qyI7So4sGfAFcMPP24zaa1NLPY8EbjRQbL7ip7gKcjoaNJSH
 ejC1TFHo04F4cu137fWBBuzs5DmOJ3RRNyTp2VDwrMd+rfomwjQ27b73o45PBRi2wgB/
 jFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949021; x=1737553821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29DNBFKk4MNawdRctkWk2PBdF4ZL+YSuccvv3D3ogz0=;
 b=BpxuK9C2xU8KfFHP+8qG3v2pjpLBY/lLulvh6o3DGuvfAc/eF+0ViCbt0QgeDcB55S
 M1P7YlykwaOtLe8QJE1lZz1E2p1zzx+ULW0lG0eD64J+rzgrr1W+CrNvTqoY+zendAKu
 CNVfjkipce6NpuAqkhyZhxI2RFEj0BzrlQnyqWJozEwxkrQbOrlQO7GKpjNwrE4GsAVJ
 f015xDFWTKq6gzq5hM5EVNLpMM3/Bik1RfT0+BShm6hLGd1NO9BUZvF+4sTjLtWZ7cCV
 VF8P3qJuXkNbM6qp+ucu5ozFWJ2LtOrj/zgQ7Puhw5SqlbNP37+1Hqb1n3i0JyjC1ROj
 ssMg==
X-Gm-Message-State: AOJu0YwCe+t4EqXQQV1vFM0Es/oz9v5wfqQ8KfQS6d8Vuy1s2bQpOiK1
 WT+sB7YbhuRqciF++zYRmZl7ZpSUxi0hteqWT9kYnSZtLYRUyDstjY5bA0enwRbLgXLOG3Gj/kG
 lT4o=
X-Gm-Gg: ASbGnctz4yj2Jv79KsVqhG8UMRAmiDvRl2kwuHAGxjM9G3Txn5dXslmjEO/IyHx4p/R
 yeDL4CkBWPHI+Zm4dAaE0JFNuRCdqgjPrpAiTehohJMWWYage0VPB8KJxvdv7uAEizVdefq3Hug
 9Optrly3VqoODS1DKGPqgTCqcguXhePOgQkhSuMYB/IhdiPjdY5NPWXr+Q/Jv+Hm2ryk2rSZDZQ
 Nv1N8Dy3eiCZMHBr4MbqBbpLrchMmnlbw7a8ulW8XLy/8saUAkWK6FkcZE=
X-Google-Smtp-Source: AGHT+IHLwuRx0OR4XR+sGh7IUsh+pdLVGG7G0T8WassoE93yPZ13mCoQuQYDLnPkq0EgWmPkhe1q/w==
X-Received: by 2002:a05:6808:319b:b0:3ec:d34f:4c6f with SMTP id
 5614622812f47-3ef2ec42dc3mr17782253b6e.15.1736949019728; 
 Wed, 15 Jan 2025 05:50:19 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f0379eff69sm4952177b6e.41.2025.01.15.05.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:50:18 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/6] target/riscv: add profile u_parent and s_parent
Date: Wed, 15 Jan 2025 10:49:54 -0300
Message-ID: <20250115134957.2179085-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22f.google.com
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

The current 'parent' mechanic for profiles allows for one profile to be
a child of a previous/older profile, enabling all its extensions (and
the parent profile itself) and sparing us from tediously listing all
extensions for every profile.

This works fine for u-mode profiles. For s-mode profiles this is not
enough: a s-mode profile extends not only his equivalent u-mode profile
but also the previous s-mode profile. This means, for example, that
RVA23S64 extends both RVA23U64 and RVA22S64.

To fit this usage, rename the existing 'parent' to 'u_parent' and add a
new 's_parent' attribute for profiles. Handle both like we're doing with
the previous 'profile' attribute, i.e. if set, enable it. This change
does nothing for the existing profiles but will make RVA23S64 simpler.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         |  6 ++++--
 target/riscv/cpu.h         |  3 ++-
 target/riscv/tcg/tcg-cpu.c | 35 ++++++++++++++++++++++++++---------
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6fb4d5f374..e215b1004d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2349,7 +2349,8 @@ static const PropertyInfo prop_marchid = {
  * doesn't need to be manually enabled by the profile.
  */
 static RISCVCPUProfile RVA22U64 = {
-    .parent = NULL,
+    .u_parent = NULL,
+    .s_parent = NULL,
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
@@ -2381,7 +2382,8 @@ static RISCVCPUProfile RVA22U64 = {
  * The remaining features/extensions comes from RVA22U64.
  */
 static RISCVCPUProfile RVA22S64 = {
-    .parent = &RVA22U64,
+    .u_parent = &RVA22U64,
+    .s_parent = NULL,
     .name = "rva22s64",
     .misa_ext = RVS,
     .priv_spec = PRIV_VERSION_1_12_0,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cb..986131a191 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,7 +81,8 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
 
 typedef struct riscv_cpu_profile {
-    struct riscv_cpu_profile *parent;
+    struct riscv_cpu_profile *u_parent;
+    struct riscv_cpu_profile *s_parent;
     const char *name;
     uint32_t misa_ext;
     bool enabled;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 48be24bbbe..c9e5a3b580 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -713,13 +713,29 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
 }
 #endif
 
+static void riscv_cpu_check_parent_profile(RISCVCPU *cpu,
+                                           RISCVCPUProfile *profile,
+                                           RISCVCPUProfile *parent)
+{
+    const char *parent_name;
+    bool parent_enabled;
+
+    if (!profile->enabled || !parent) {
+        return;
+    }
+
+    parent_name = parent->name;
+    parent_enabled = object_property_get_bool(OBJECT(cpu), parent_name, NULL);
+    profile->enabled = profile->enabled && parent_enabled;
+}
+
 static void riscv_cpu_validate_profile(RISCVCPU *cpu,
                                        RISCVCPUProfile *profile)
 {
     CPURISCVState *env = &cpu->env;
     const char *warn_msg = "Profile %s mandates disabled extension %s";
     bool send_warn = profile->user_set && profile->enabled;
-    bool parent_enabled, profile_impl = true;
+    bool profile_impl = true;
     int i;
 
 #ifndef CONFIG_USER_ONLY
@@ -773,12 +789,8 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
 
     profile->enabled = profile_impl;
 
-    if (profile->parent != NULL) {
-        parent_enabled = object_property_get_bool(OBJECT(cpu),
-                                                  profile->parent->name,
-                                                  NULL);
-        profile->enabled = profile->enabled && parent_enabled;
-    }
+    riscv_cpu_check_parent_profile(cpu, profile, profile->u_parent);
+    riscv_cpu_check_parent_profile(cpu, profile, profile->s_parent);
 }
 
 static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
@@ -1181,8 +1193,13 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     profile->user_set = true;
     profile->enabled = value;
 
-    if (profile->parent != NULL) {
-        object_property_set_bool(obj, profile->parent->name,
+    if (profile->u_parent != NULL) {
+        object_property_set_bool(obj, profile->u_parent->name,
+                                 profile->enabled, NULL);
+    }
+
+    if (profile->s_parent != NULL) {
+        object_property_set_bool(obj, profile->s_parent->name,
                                  profile->enabled, NULL);
     }
 
-- 
2.47.1


