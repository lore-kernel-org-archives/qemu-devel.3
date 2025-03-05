Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6145C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxP-00024Q-5h; Tue, 04 Mar 2025 20:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxL-0001wg-U8
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:56 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxK-0008Q8-5E
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22339936bbfso93833725ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139632; x=1741744432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4wTDWyRukJNFQg7ktARpeS3eUQxJqwAuPTgYYQtFxQ=;
 b=b7IYSkREh0KJaxIzS0UAmdKrdo6XKtET5NjtFS84jLFk0Bv71095713VZ6zokj6qz1
 2AdGwyoHJfkrpgrgTjC/lVpqGjwQ7g5YEiGRhCnJTFockQbUFahOYkLElt9frDhP9Vc1
 My6T55a1uhtVigpF2FzpEn42yiF1doORm0BgTGIibUz10OLRGDLHJ2YmJMjDNk+sC4Ly
 VHuoWr4cHTGGUZucgtfz6EhcOwqfe8V2KNuzrTef/DgL9lXceqB3LbD1Rh1nSM9o7y2U
 uCVQ3YfjJMTwY5mqIsMgLMFGaxElRE1EwJz2NqH6A9inJmLxNbtRO07ImrpLOXc26UHa
 AkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139632; x=1741744432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4wTDWyRukJNFQg7ktARpeS3eUQxJqwAuPTgYYQtFxQ=;
 b=QbKCP+352B5+D6mCgMSG1jyBvGkckNmr83BQA1yF2ZrvZhAObFYIX4JnryenOQBYnk
 cxLlVli0mWPtNokRnAS8VlmHKeQSewgprcSK220lJGuz6GPOAWT55TO57TS7wDurDFc6
 4opzh+EWllcbzOxzSCSTLMzcKOK2YDVYzUaG7XZ4+2bmdqGAI3xSjrl+0S/QMGmbSgKW
 t4nWYNeUANbz7zzooyW+Kpq7MIsLYh/19q+v4IdgG5m8QD2we+427psnlvP+oRpxLnM7
 G82zysSieidCv9TUiGbbomjYvyXKGlRw4+yTfg9MepnU+SwfPxqGLqKh8b0Yb5xlGgTY
 68wQ==
X-Gm-Message-State: AOJu0YwqNeMbS9FUHWVL5/rmSlqISpSvI1jfLgCpayZaR1Em+qblanMG
 pMApN6SpUTgYb7MZwYHRB39bLGENY9YN/8g01+As28njPWjAzYmbg6r5IjMVOYg=
X-Gm-Gg: ASbGncsQp4BT/8/nPEsnCUe4Aw6PQ882CCRBQgrJJ9NTJouKzN3FPF2OmIvba0vQwtA
 J4pmTGj9bRKVRqrZfv5UVnciTE90WUzLRkwy7rjU9ypOrc7xqcF7oIstn+9q2uKZmePIWMMIyCI
 m1nh0dn+FU0gjcFevBZENltuxsuK2gYRNgMv7qUtDCqers8Zn0sGc9oblS3qAH6qQiiX+Dm8vY0
 Zo/qEGzHHOQcJp8U7h6cqbVNrT5uhvc+kkVnW9ox8p0lVwOECeYF3WN4KC9lCIjFYqZg1zp9sQd
 EWad0/XSKIEdIRxiVsbAxinAYno4JJLsE2f0RHHsudLmXcM/d6KdUPJY0TJ7SAQCwxtW2PJ8sCx
 IRLFtFEo7DqmkSS3DXLnjxqEAgEQrBH+Azd7Jkw86K/pRvE0wOLA=
X-Google-Smtp-Source: AGHT+IF68F3AuHg0GczcHwvN7WSGgFCnnjrkmQWCgJuyfSdY/kdmKtMe1f+tcL46B4VTrZwki741dA==
X-Received: by 2002:a17:902:ec82:b0:223:66bb:8995 with SMTP id
 d9443c01a7336-223f1c95124mr19962015ad.20.1741139632443; 
 Tue, 04 Mar 2025 17:53:52 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:51 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/59] target/riscv: add profile u_parent and s_parent
Date: Wed,  5 Mar 2025 11:52:21 +1000
Message-ID: <20250305015307.1463560-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The current 'parent' mechanic for profiles allows for one profile to be
a child of a previous/older profile, enabling all its extensions (and
the parent profile itself) and sparing us from tediously listing all
extensions for every profile.

This works fine for u-mode profiles. For s-mode profiles this is not
enough: a s-mode profile extends not only his equivalent u-mode profile
but also the previous s-mode profile. This means, for example, that
RVA23S64 extends both RVA23U64 and RVA22S64.

To fit this usage, rename the existing 'parent' to 'u_parent' and add a
new 's_parent' attribute for profiles. Handle both like we were doing
with the previous 'parent' attribute, i.e. if set, enable it. This
change does nothing for the existing profiles but will make RVA23S64
simpler.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115184316.2344583-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  3 ++-
 target/riscv/cpu.c         |  6 ++++--
 target/riscv/tcg/tcg-cpu.c | 35 ++++++++++++++++++++++++++---------
 3 files changed, 32 insertions(+), 12 deletions(-)

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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 578bc95652..7b708bd010 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2343,7 +2343,8 @@ static const PropertyInfo prop_marchid = {
  * doesn't need to be manually enabled by the profile.
  */
 static RISCVCPUProfile RVA22U64 = {
-    .parent = NULL,
+    .u_parent = NULL,
+    .s_parent = NULL,
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
@@ -2375,7 +2376,8 @@ static RISCVCPUProfile RVA22U64 = {
  * The remaining features/extensions comes from RVA22U64.
  */
 static RISCVCPUProfile RVA22S64 = {
-    .parent = &RVA22U64,
+    .u_parent = &RVA22U64,
+    .s_parent = NULL,
     .name = "rva22s64",
     .misa_ext = RVS,
     .priv_spec = PRIV_VERSION_1_12_0,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d7e694fdb3..2b21942ef2 100644
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
+    profile->enabled = parent_enabled;
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
@@ -1190,8 +1202,13 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
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
2.48.1


