Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5DBC54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9d-0006ei-0b; Fri, 08 Mar 2024 06:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9a-0006eT-R5
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:42 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9Z-0001Xi-2a
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dd70a43f7dso865745ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896359; x=1710501159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuHccklI388mSdq2J0JFOWSnAHZxnbO0CMAZtqZWP5c=;
 b=f6S9OVbQZUYqHYcFiWX6Yruyf1mWiJh8oTRCKC6Fgk2XkH8/T0AGdBDDO0toVUuAEO
 AHIsUO32JxmMC6i8bS9Y1VZCtcIrQgN++h2nZW2ZgNsdVca/ZwkWqGl0KjHGubR2FUaQ
 b6i3lU7xDCOcr3v3JALXlxe355xt25g3tAoLNavV54CzJXwOu8OtAA574jSwlUTbdIOj
 g30SQgsiaM18F29bsgEnVwwhXyUWuY0BRWEVkcGLOXBuRmi3T0ar1elRWCWwdUCjHK18
 butF6kLAAx567owRWhobCONuPSUjviBo9Imkv1McV4+SVjdkZwMCkZeYvF1XmVC9EomY
 ztOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896359; x=1710501159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuHccklI388mSdq2J0JFOWSnAHZxnbO0CMAZtqZWP5c=;
 b=QjcSOkATib+c4BQIjwOQ97l95ZfoMls2tdhgK2zlMWBcfGwOkzJm+3DX9upzcBKNiF
 R3dYvv2Vlbvdq+v2vQ+ROwIoHu/sQwZfsFifrATn6B8qgYz0myRS0q2Y72iR+eSi8nHG
 hP3hCNmnpx0Bu3Yp+sYVtHW3+dgW6TxAcFTiCAcBNoC52aP2s2BjO0fAlkkiB4YpbQL4
 FqcDqh4PGVmlNqgwbAzvsF54aCX5zLHuCHikSEcHqtZpPhNG9HRfTNe2tS6jjPb/TtYa
 aeT5ZEXHTtjBs0RH/eKq2A4A7o5sVrVu6+Vaca+TXd39Y+/+4YFepw5/O1d24+p4Vo7o
 LmMw==
X-Gm-Message-State: AOJu0Yyi7lKBBkvxSCHi3BDoxKAXZ23d39hNWenCo5pNYabyCbo5nLH6
 /PofNsFFMDyqxBJp/e7y7z/QxkEOFhtKkupXpHEx2BEi5zr0QJv+yTep7DqcvAuuxA==
X-Google-Smtp-Source: AGHT+IHg++cxk330UttmdKICESh8UVikjyaEgRMWgklFuNchNFiuC68ExzBYDtrXYRfZqkvkwY66Gw==
X-Received: by 2002:a17:902:e889:b0:1dc:56a9:5e9a with SMTP id
 w9-20020a170902e88900b001dc56a95e9amr12027499plg.46.1709896359514; 
 Fri, 08 Mar 2024 03:12:39 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:39 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/34] target/riscv: Gate hardware A/D PTE bit updating
Date: Fri,  8 Mar 2024 21:11:29 +1000
Message-ID: <20240308111152.2856137-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240215223955.969568-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  3 ++-
 target/riscv/cpu_helper.c  | 19 +++++++++++++++----
 target/riscv/tcg/tcg-cpu.c | 15 +++++----------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5507c11161..e9cf950d6b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -960,7 +960,8 @@ static void riscv_cpu_reset_hold(Object *obj)
     env->two_stage_lookup = false;
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
+                   (!cpu->cfg.ext_svade && cpu->cfg.ext_svadu ?
+                    MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
     /* Initialized default priorities of local interrupts. */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d462d95ee1..c994a72634 100644
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
@@ -1082,9 +1084,18 @@ restart:
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
+    } else if (!(pte & PTE_A) ||
+               (access_type == MMU_DATA_STORE && !(pte & PTE_D))) {
+        return TRANSLATE_FAIL;
+    }
 
     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ea763abb31..ccfb7b2dd3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -196,17 +196,14 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
 
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
-        g_assert_not_reached();
     }
 }
 
@@ -321,8 +318,6 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
                           cpu->cfg.cboz_blocksize == 64;
-
-    cpu->cfg.ext_svade = !cpu->cfg.ext_svadu;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.44.0


