Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D41C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5nI-0004gm-Fl; Thu, 25 Jan 2024 14:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5nE-0004fi-M0
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:44 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5nC-0001bP-Us
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:44 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso3792998a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706212421; x=1706817221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBiik9g1hx97vjGuUcUYUffnQTp9SD2PKIA/lEbjSmE=;
 b=g2ngQMNH9OZIo+vyqz5bfU6Ky258cUk4dswczPQ9kvnHxDNDWACBJp44g5l+v29pF4
 d7KVarPx6/Ag53CaQmtGeEE9e2A+pZ0jCIruYjzda4/+aLQjFtztOBY2r9Q1Z5eLyOAG
 HqiYUnrXxuc8aA2AwWjPSWk3xmyTC310TULCEuqFZ/lKmxvQONTjxXkrcQZcMGDU+xMC
 DKWJW8e7NXYcz4TdIUbaQHJHopzMeMzDfWfHG6o6+Acfm0miEWLr9kBLDHEn2yDEZ/3V
 o42bN3XvxARNZPzchXMfL6Lw4V48U6a1+EgiqSOYaMLcUoeXsZolx0BfoP91CKYoklCY
 Wa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706212421; x=1706817221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBiik9g1hx97vjGuUcUYUffnQTp9SD2PKIA/lEbjSmE=;
 b=qc3HqvUUTh6MgRhDAxe5npaFbhS2fyxcgaxsrszXZo4JfoOu9qdhdi7uoYleEjmi8J
 2UA6D6w8v0WWYiswSp2d1QbmY0UdKe4TWulXBh2o3w3bJgZaqoHPZyVMXRKBu6+1r5Ky
 iYVKgi5vMP8BYohBEfKMmy+ff7rEvukEd0Wzy42xWGfdAQGv5g/S3p8sLnXQbwEobqFz
 lUmeTRPMpYKdn6KSRqeGzqvsn3hJj6rPOX8/rBaHikL7S9nSfM0BHtwqWGBMOjXNfCwb
 7bBxr8I6QdmbS0P38DDESd1oSWCWdmSfXk2ZpkPAuhdiSef7xFKtE2YAWJa/4JZZ8NIe
 To8Q==
X-Gm-Message-State: AOJu0Yz4wGSdFVRRV0F57B3qSrV36k9YC/QaW1PZ3lDykhEVoc3fILMA
 WLVRxtZXkBGyCOyi1ZMfg250hOOdChEPaZtKIL8KI8iR61xaJGWFWQ92J8gPUhjvdMZHwUmSGf6
 1
X-Google-Smtp-Source: AGHT+IFD0WOrv6nrjq96zwvaJPlRiVf32b4TwM3zf0rVDSpJmuP7prTqIicpfEo5SXpQ50vKvP28UA==
X-Received: by 2002:a17:90a:680e:b0:28e:8522:7a3f with SMTP id
 p14-20020a17090a680e00b0028e85227a3fmr129707pjj.28.1706212421019; 
 Thu, 25 Jan 2024 11:53:41 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a17090ad40700b0028b6759d8c1sm1958613pju.29.2024.01.25.11.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 11:53:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/6] target/riscv: Gate hardware A/D PTE bit updating
Date: Thu, 25 Jan 2024 16:53:18 -0300
Message-ID: <20240125195319.329181-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125195319.329181-1-dbarboza@ventanamicro.com>
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

Gate hardware A/D PTE bit updating on {m,h}envcfg.ADUE and only
enable menvcfg.ADUE on reset if svade has not been selected. Now
that we also consider svade, we have four possible configurations:

 1) !svade && !svadu
    use hardware updating and there's no way to disable it
    (the default, which maintains past behavior. Maintaining
     the default, even with !svadu is a change that fixes [1])

 2) !svade && svadu
    use hardware updating, but also provide {m,h}envcfg.ADUE,
    allowing software to switch to exception mode
    (being able to switch is a change which fixes [1])

 3) svade && !svadu
    use exception mode and there's no way to switch to hardware
    updating
    (this behavior change fixes [2])

 4) svade && svadu
    use exception mode, but also provide {m,h}envcfg.ADUE,
    allowing software to switch to hardware updating
    (this behavior change fixes [2])

Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in address translation") [1]
Fixes: 48531f5adb2a ("target/riscv: implement svade") [2]
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         |  2 +-
 target/riscv/cpu_helper.c  | 18 ++++++++++++++----
 target/riscv/tcg/tcg-cpu.c | 16 +++++-----------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7fd433daee..a56c2ff91d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -960,7 +960,7 @@ static void riscv_cpu_reset_hold(Object *obj)
     env->two_stage_lookup = false;
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
+                   (!cpu->cfg.ext_svade && cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
     /* Initialized default priorities of local interrupts. */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8da9104da4..9da9758cb4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -907,7 +907,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     bool pbmte = env->menvcfg & MENVCFG_PBMTE;
-    bool adue = env->menvcfg & MENVCFG_ADUE;
+    bool svade = riscv_cpu_cfg(env)->ext_svade;
+    bool svadu = riscv_cpu_cfg(env)->ext_svadu;
+    bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
 
     if (first_stage && two_stage && env->virt_enabled) {
         pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
@@ -1082,9 +1084,17 @@ restart:
         return TRANSLATE_FAIL;
     }
 
-    /* If necessary, set accessed and dirty bits. */
-    target_ulong updated_pte = pte | PTE_A |
-                (access_type == MMU_DATA_STORE ? PTE_D : 0);
+    target_ulong updated_pte = pte;
+
+    /*
+     * If ADUE is enabled, set accessed and dirty bits.
+     * Otherwise raise an exception if necessary.
+     */
+    if (adue) {
+        updated_pte |= PTE_A | (access_type == MMU_DATA_STORE ? PTE_D : 0);
+    } else if (!(pte & PTE_A) || (access_type == MMU_DATA_STORE && !(pte & PTE_D))) {
+        return TRANSLATE_FAIL;
+    }
 
     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 6d5028cf84..bc3c45b117 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -196,18 +196,14 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
 
 static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
 {
-    switch (feat_offset) {
-    case CPU_CFG_OFFSET(ext_zic64b):
+     /*
+      * All other named features are already enabled
+      * in riscv_tcg_cpu_instance_init().
+      */
+    if (feat_offset == CPU_CFG_OFFSET(ext_zic64b)) {
         cpu->cfg.cbom_blocksize = 64;
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
-        break;
-    case CPU_CFG_OFFSET(ext_svade):
-        cpu->cfg.ext_svadu = false;
-        break;
-    default:
-        /* Named feature already enabled in riscv_tcg_cpu_instance_init */
-        return;
     }
 }
 
@@ -349,8 +345,6 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
                           cpu->cfg.cboz_blocksize == 64;
-
-    cpu->cfg.ext_svade = !cpu->cfg.ext_svadu;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.43.0


