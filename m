Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE911CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQO-0005kS-Oz; Thu, 21 May 2026 20:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOB-0002dF-Hh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO9-0004dY-FV
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:19 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c801b30188dso3153389a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408315; x=1780013115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRaz1TlypKE5ho+rp9KhYgTc5x2rHfXcx74X3Pi8EsI=;
 b=Mr4SvUin/jgMwj1ukjbLtXGxeBrIFF5PooHxFl5rZHyYEx9donZ1BKihT9tlvwNFh9
 dIrWtMvmzhjPQrfbobXLYzAIhY9W2FHorxi8E9t8wnxFsz069XUUDqffHq9lVlzg46zc
 USlxZmBXFEe4ztFqMNb/jMDLgihBsQGWDlOd0d0jEgjDux5q1Im7KeQJQK0UFKdviczA
 oC0jBk+tR+lGEWjJUtpBhNBKwS4c7N0YM5Ds1ep7zdoFLLRGrOoKlx/SD4FyURxB8qpJ
 q0BDO538dwsAJPpqeYQdjP0EyXTCWb2FT3H6NBvNwexaV6uocwCHbjJc9Y2MNCWUBIJR
 gPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408315; x=1780013115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iRaz1TlypKE5ho+rp9KhYgTc5x2rHfXcx74X3Pi8EsI=;
 b=sagjIY99zuYN0L0MA/+vWkTK8siwlN/0u3FhMlVVlVBpNTUbri0mKr4Yz4nWWfwwvh
 JsOWgjl3ba+5nIEfZOBvamwIuHk3aItwCMWAdDoAqISGs5BLqlE850r6hSYe+8FUEPnL
 jotjhmoXeh31SK5y0K+vvUTIVRcqhZtYzV7mvEf1yBntQh0/tVrmX2HsCc13+v8i9WrB
 paH49JdQ/2iX07Gk2s/8huvvDLRl/A9IsoZ1XwnNOVx86mX+i3Y3WDATGPK+QjrlL+0C
 195GX3OEL7WFWA7XHQU0PpjuQ3Q3LliiXSQbfI/yJx84Bzxgvh9R++Xlie96ee1ioEGn
 HGVg==
X-Gm-Message-State: AOJu0YxyY5Eft3jHTkiJkK5hwWzQVXt5M4ElrgNk1IsMrUMUUf1qRaKZ
 aDLXgxg5edXb0ktYqFC0qM9deqh+jLSMynriUybVUaU6o+kamvIaTItXd/4pWIZK
X-Gm-Gg: Acq92OG7carDsKLnBsNYbvGjXfCqf/7lU87/TU9IdIVaR4vU0QsW+Nb5pZ3FovK7aJu
 HufdRh3uVYNwFLP0yzzWRnIBsX0ZMx+43bF8YtPhuoWjszI2XP+0888lnqtgKsKCvV4Ksg8+WhP
 BshzMQPCclVye1FG3EgKEKKIU/DgJFybOwpwA50WMTI2fV0QJs0Q/P59FR53Lc9nLwPObyo+RxM
 2FafONVHakwvFah5B1vV7IO3bwO51/7NMggOzc0p/KLPGtz2hvA8OoqEdSJLElD+Dm9UiJ6tlvR
 5R8yT1CXNSbLbJ8ZV9Dnc6nVoABD/og1tAcl8CM59zFLXvhRVojBvryH96E9xov/HWFo/TWaWHU
 IF4NZiQzpWDVfcD00zdYjhK2/TLHvnhnkRKEN2WmkwL6iSSgIBCY6Ozwhn9UzjUN4MyzOC4KIUw
 sy/ee15Y66TavrDFEjE+45sSQDeLTMVetlxBJc+ceCmOIGwxJI11v+
X-Received: by 2002:a17:903:1a10:b0:2bd:2430:eb7b with SMTP id
 d9443c01a7336-2beb06cbf6cmr11040485ad.12.1779408315556; 
 Thu, 21 May 2026 17:05:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/48] target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
Date: Fri, 22 May 2026 10:03:07 +1000
Message-ID: <20260522000324.23255-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Deprecate riscv_cpu_enable_named_feat() by creating implied rules for
'sha' and 'ssstateen'.  'zic64' is always true given that our default
block size is set to 64.

With this change we homogeneize extension handling when enabling
profiles.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-7-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 25 ++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c | 40 --------------------------------------
 2 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0f8ddeb42e..ecf31599c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2599,6 +2599,17 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SHA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_sha),
+    .implied_misa_exts = RVH,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smstateen),
+        CPU_CFG_OFFSET(ext_ssstateen),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_ssccfg),
     .implied_multi_exts = {
@@ -2647,6 +2658,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SSSTATEEN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_ssstateen),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smstateen),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvfbfa),
     .implied_multi_exts = {
@@ -2673,8 +2693,9 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
+    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
+    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
+    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
     NULL
 };
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 704105d3df..c3e354b0ae 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -322,42 +322,6 @@ static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
-static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
-{
-    const RISCVCPUMultiExtConfig *feat;
-
-    for (feat = riscv_cpu_named_features; feat->name != NULL; feat++) {
-        if (feat->offset == ext_offset) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
-{
-     /*
-      * All other named features are already enabled
-      * in riscv_tcg_cpu_instance_init().
-      */
-    switch (feat_offset) {
-    case CPU_CFG_OFFSET(ext_zic64b):
-        cpu->cfg.cbom_blocksize = 64;
-        cpu->cfg.cbop_blocksize = 64;
-        cpu->cfg.cboz_blocksize = 64;
-        break;
-    case CPU_CFG_OFFSET(ext_sha):
-        if (!cpu_misa_ext_is_user_set(RVH)) {
-            riscv_cpu_write_misa_bit(cpu, RVH, true);
-        }
-        /* fallthrough */
-    case CPU_CFG_OFFSET(ext_ssstateen):
-        cpu->cfg.ext_smstateen = true;
-        break;
-    }
-}
-
 static void cpu_bump_multi_ext_priv_ver(CPURISCVState *env,
                                         uint32_t ext_offset)
 {
@@ -1327,10 +1291,6 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
         ext_offset = profile->ext_offsets[i];
 
         if (profile->enabled) {
-            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
-                riscv_cpu_enable_named_feat(cpu, ext_offset);
-            }
-
             cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
         }
 
-- 
2.53.0


