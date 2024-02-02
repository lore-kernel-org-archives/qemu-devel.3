Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C806C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvN0-0008P0-CS; Fri, 02 Feb 2024 10:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMy-0008Mt-R9
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:20 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMv-0004Wn-TP
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:20 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so19858035ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706887336; x=1707492136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anWEskpMfYSpOmzCuTelqUtl/bkEW7KZuVaTU0mxJhE=;
 b=Nt+/BQRe6CmF1v4b4avBbiWSTqQgFD3NckxBg/OIljXPZDJtyUzCFQWRBzILU2DAgc
 fhQ2AH92+TRnEzA2IyJMZ7HWgHUCYYIi4b4yWEzxNdnVw7M+rDYmjWp9vMiEfjwYJOCc
 /2qG2a5T0GsYiqlohbddRtXndlauWoGPalqBfR64isZWnr805PIwUAf8rqqv5iYsFxo2
 3LlA89s0I/tvLI04iOGMz6Cj9nlkwFFMmbtzCKyiSVPOU991qirUef4Q1R2MMwcYoYPf
 PzahHvuElCQSFo44BA5K6o/zBGIp9Ck539ujnikwxHMyIn4djmIinDEu4PqWIEGUbGM2
 SlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706887336; x=1707492136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anWEskpMfYSpOmzCuTelqUtl/bkEW7KZuVaTU0mxJhE=;
 b=nuFfNW8a0ZtTmuZ4IabO3NZNg/a4jIJ+D5jz15lgEMKJ/WShs5DawNa8w1IqlTE5C2
 0/md5zSoUduAb0CYhpSLGzxfy6F8bRIqau+eITy8JfezTPzs94BsakYpKshk6VCtpDDn
 eBuB6LN1e22Hopb3cTY2AJk01dRVdXjGA440fiWMd0etJH1KaAY7V4HQGM8oTzCWBcmp
 fUvy61mKdrpHlii8aTPTDgt29q9A2Pz4kVfrETg2GMQOWrniQjxxNEopM2nS+y1PcUfb
 3IGJKt2g0WFvJfHqQ4bjeHoXwKoCTM7i1kGEJUv0krvb5EMZCZ1buGY0f2XBwyqEBZCs
 DScA==
X-Gm-Message-State: AOJu0YwBoRwYWK9VMt/i7UfVcAnaVfKmd+AU11lB708Bhvg6AkEsngi4
 Bz+xX/FRPSpruK3h88dA0PKVEt5HZblyiU/4mEc14MBFoLaGvJTYwFShdZ8QdI1c4IKTaykd0TD
 p
X-Google-Smtp-Source: AGHT+IE+hS26wdIHKQ8z7rcq7rrPmSeGFGMImUYRoIyFca8TEGTDf11ZhRA/VZl/zmTIIj4Sn9vplQ==
X-Received: by 2002:a17:902:7d87:b0:1d8:a5c7:a383 with SMTP id
 a7-20020a1709027d8700b001d8a5c7a383mr4799907plm.60.1706887336122; 
 Fri, 02 Feb 2024 07:22:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWg8r0g33+iSTrGclldXtZRykaLvP5JIiZo9cglgwQDmzo7U2RhXsG3nkmP7CEw+RBX0hdfj76lbUxBWMNpX62wuVg1P92UPyitUPZKxdlL8Ah2YfhjOJOqKmzFhYUbZN0B6KiAFUtvoUHwoJt0caopIB7U8/soKYqUPCMPIogk6b7n0gFG/qI5mHUhK2ocC/TPm3HpEufUNGNNkGSPX4X138QJP4zdcsKh+Ve2+X5i7tlFlSX0W54y4yKBtlOqaOWlnN0ln1KGdsM54hP6aGkAYSRqFT7zaA==
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902f24300b001d714a1530bsm1734381plc.176.2024.02.02.07.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:22:15 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 5/6] target/riscv: Gate hardware A/D PTE bit updating
Date: Fri,  2 Feb 2024 12:21:53 -0300
Message-ID: <20240202152154.773253-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152154.773253-1-dbarboza@ventanamicro.com>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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
---
 target/riscv/cpu.c         |  3 ++-
 target/riscv/cpu_helper.c  | 19 +++++++++++++++----
 target/riscv/tcg/tcg-cpu.c | 15 +++++----------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9045f87481..50ac7845a8 100644
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
index 8da9104da4..3a440833f8 100644
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
index 673097c6e4..43c32b4a15 100644
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
 
@@ -348,8 +345,6 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
                           cpu->cfg.cboz_blocksize == 64;
-
-    cpu->cfg.ext_svade = !cpu->cfg.ext_svadu;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.43.0


