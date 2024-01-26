Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7798C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMIl-00014P-LG; Fri, 26 Jan 2024 08:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIb-0000rO-Jx
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:13 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIZ-0007cx-H5
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:13 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55817a12ad8so288510a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706275870; x=1706880670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+kBSbmB+uu4ccq3+PBWVAG48fqoWqgXKPn/QchcjM0=;
 b=TxennN52JV8bHgwXoZ4PUTFZejDuxWdNSIUmZ6Gv1uk1T6ciwTQ5hG6HBktjoli1zL
 zGQrHzW87mYgIFy8w4q/fpnmt2+THZImgHpIr78M2HwDVk32MizEUayCMpyF2Cg8aqRY
 jKRX2TtCEvDeFDy/jwktwPPeZUIYcC3pNfl+IFJj57VBeyHUg86ZoTZ3x327LnJzxHbE
 7O5BpvPE3u7KWoauEEmaDWm5FjXz46FmQRxdWw3jGljSOCMfdtBcBKROC8vePqC8E5hW
 XYXiYMg62oJtD26e1qkaJcwcsLfW178WuPay00k4GwW985XsOcqMcAuMUADeSZavIU+W
 zijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706275870; x=1706880670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+kBSbmB+uu4ccq3+PBWVAG48fqoWqgXKPn/QchcjM0=;
 b=wQP8LajPyGDD2jj5Y3KWNDo4yOMz+R9CCEM1ClSLWyUNFFDrHlk6zHUpvt2hNxJfI2
 hJwgjVYxuXgrr23dLIlAoL9O8le4kLLPemI5XvIXWMNQRpLoiZRujV4ih8jlggg0XFTS
 21UxKlnTB2uXYjNpSPayMThds/Z3S7iANz6p7taQmXTUhV470p1Jh2633K6HWyUtY8nS
 G1xlIhhIbBkiekRg8tpDbyZWtYwJ/+24dLhEuIb6u3JWpxjsEtfH8rkKisPg622mmO0L
 J0aDqsWqlhgpFEgOVXGXVstPiceD6NWTq9aSb+K08Q1V5EsURqPL0e/uj6pUL+id5njv
 LjIQ==
X-Gm-Message-State: AOJu0Yy/+CP8B2MoGwOEg+MHM+3HzzU54HQUZQxpIBGM0t9aMOKRiCiM
 frnThxocK6Sva7gIWTnji8Cr/QPklAOsvBI37aiMyAY8386CfiZTdjlBP03kuEclhn3jcWTYch8
 a
X-Google-Smtp-Source: AGHT+IHnMPbpTkj4Cy8/ecQ2CRy1VMACkWyevAHtLHanlI4/I7u4hit1TnA+TN5C8tebRoTW9t0wkA==
X-Received: by 2002:a17:906:a2c8:b0:a2f:b9be:66df with SMTP id
 by8-20020a170906a2c800b00a2fb9be66dfmr783974ejb.17.1706275869993; 
 Fri, 26 Jan 2024 05:31:09 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ch21-20020a170906c2d500b00a317346a353sm629974ejb.123.2024.01.26.05.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 05:31:09 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 dbarboza@ventanamicro.com
Subject: [PATCH v2 5/6] target/riscv: Gate hardware A/D PTE bit updating
Date: Fri, 26 Jan 2024 14:31:07 +0100
Message-ID: <20240126133101.61344-13-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133101.61344-8-ajones@ventanamicro.com>
References: <20240126133101.61344-8-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 target/riscv/cpu.c         |  2 +-
 target/riscv/cpu_helper.c  | 18 ++++++++++++++----
 target/riscv/tcg/tcg-cpu.c | 16 +++++-----------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7fd433daee74..a56c2ff91d6d 100644
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
index 8da9104da450..9da9758cb4d4 100644
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
index 6d5028cf84d0..bc3c45b11704 100644
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


