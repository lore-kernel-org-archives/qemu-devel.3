Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D32AC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Aa-0000om-UL; Thu, 25 Jul 2024 19:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AU-0000Pf-Ks
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:42 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AS-0005Mh-ON
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:42 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3db12a2f530so248432b6e.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951199; x=1722555999;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUR8T2K29APrsJptEPEdK1z5i2IWbR5BdkNAdCNK1kM=;
 b=H1qvPFVrtuCZFvs6pxxDvTNbG4hh6mHFJY7OhGUvHwiJ06wQoqopaCN1pgxUlJjLis
 sknwFrOHOKvPG00MIoM55U109DU5A3mfuNuUaHiErDCsbM8wQZfT0wgvJgS1WU4lQbEn
 wDB4zGHR6bKY8C2w+9H6tseOW9typ0B0kVZIbiMIVa95tpFalsxXXFl2GEWEOalh/t1S
 HqoIHTslTxd4sVz+4SqqyXj/j4Kb6Alc1A+49oFZP6Q41pyY57bzexBSgOKmtdPy2K6r
 WXQSrdmNw4JWhij6HhG8qq4NRLAfKp9LeQkr7QY5ETJDPQ4oQG4P+MryyD2uNdIXRE0E
 +CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951199; x=1722555999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUR8T2K29APrsJptEPEdK1z5i2IWbR5BdkNAdCNK1kM=;
 b=ORUYqsSFcKzv5cw7iUb1TKlzJW2qtSnpPvPwhBqmqJ9Qr+4tzN1+rlwvmu4p6RYC36
 CAYhddc2Tc7o8YzH99c0UNz6FAvWFTfoGXiqDHt0/zRGfQh40EKITp4PWyo1ok4R4z4K
 C/6lURxSfrIpLxpVYGONhwOtl7VmdIwtO+V681fdQtsNLFZF0475/D2/931YQjU7XMeb
 Bj1NvfD+gFHTrcp58URsD0Zg69u6i3uFRl4V7Lt2aT7johJjrVhK9U57iR1gfhtJlbBJ
 Dp4ACA3tXn8eFpiWO/VuVqWnpB0Fof0rAmLxeFRXGn6jWUmBSbNJqBJCxAN9Kr+BmpYf
 4H0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXTr2sQXL8BmNSzBF5ZE+KxENP9+vghv06AY2hpMBFtmia7e7tR9a53PPGLZGcRcZoOMBcZZFsaJrOOktbtB1zyH8JFVc=
X-Gm-Message-State: AOJu0YyGCxUIoWYBwLyyMkNRrePzSYw8y62jE+ZFUvXHYMFbnjBIyIDD
 UFwO3UvY2lmuBK54sUShj7dxmbJKvNe8Xnn/xaT+8Erk9fwKsmqALXrAgQXJ/40=
X-Google-Smtp-Source: AGHT+IFoVeZ422tEPy+Fq939E8LOKAOTohfUKg/8ajvaM8rVyKLa0tU1d1fIS36XibaSRiuEzvtXjA==
X-Received: by 2002:a05:6808:2190:b0:3da:e2b1:10d2 with SMTP id
 5614622812f47-3db10ed0c45mr5577575b6e.2.1721951199301; 
 Thu, 25 Jul 2024 16:46:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 12/24] target/riscv: tb flag for shadow stack  instructions
Date: Thu, 25 Jul 2024 16:46:01 -0700
Message-ID: <20240725234614.3850142-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=debug@rivosinc.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Shadow stack instructions can be decoded as zimop / zcmop or shadow stack
instructions depending on whether shadow stack are enabled at current
privilege. This requires a TB flag so that correct TB generation and correct
TB lookup happens. `DisasContext` gets a field indicating whether bcfi is
enabled or not.

This patch also implements helper bcfi function which determines if bcfi
is enabled at current privilege or not. qemu-user also gets field
`ubcfien` indicating whether qemu user has shadow stack enabled or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c        |  2 ++
 target/riscv/cpu.h        |  4 ++++
 target/riscv/cpu_helper.c | 30 ++++++++++++++++++++++++++++++
 target/riscv/translate.c  |  4 ++++
 4 files changed, 40 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6b50ae0e45..e1ff246c24 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1029,6 +1029,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #ifdef CONFIG_USER_ONLY
     /* qemu-user for riscv, fcfi is off by default */
     env->ufcfien = false;
+    /* qemu-user for riscv, bcfi is off by default */
+    env->ubcfien = false;
 #endif
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 81283a1d76..0e0a9d2be1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -231,6 +231,7 @@ struct CPUArchState {
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
     bool ufcfien;
+    bool ubcfien;
 #endif
 
 #ifndef CONFIG_USER_ONLY
@@ -536,6 +537,7 @@ bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 bool cpu_get_fcfien(CPURISCVState *env);
+bool cpu_get_bcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
@@ -610,6 +612,8 @@ FIELD(TB_FLAGS, PRIV, 24, 2)
 FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 28, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 29, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2cb1d45467..ce68f5af72 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -93,6 +93,32 @@ bool cpu_get_fcfien(CPURISCVState *env)
 #endif
 }
 
+bool cpu_get_bcfien(CPURISCVState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    return env->ubcfien;
+#else
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return false;
+    }
+
+    switch (env->priv) {
+    case PRV_U:
+        return (env->senvcfg & SENVCFG_SSE) ? true : false;
+    case PRV_S:
+        if (env->virt_enabled) {
+            return (env->henvcfg & HENVCFG_SSE) ? true : false;
+        }
+        return (env->menvcfg & MENVCFG_SSE) ? true : false;
+    case PRV_M: /* M-mode shadow stack is always on if hart implements */
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -146,6 +172,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                            env->elp != NO_LP_EXPECTED);
     }
 
+    if (cpu_get_bcfien(env)) {
+        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c746d7df08..34c9bf093d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -121,6 +121,8 @@ typedef struct DisasContext {
     /* zicfilp extension. cfi enabled or not. lp expected or not */
     bool fcfi_enabled;
     bool fcfi_lp_expected;
+    /* zicfiss extension, if shadow stack was enabled during TB gen */
+    bool bcfi_enabled;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1243,6 +1245,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->bcfi_enabled = cpu_get_bcfien(env) &&
+                        FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = cpu_get_fcfien(env) && ctx->fcfi_lp_expected;
     ctx->zero = tcg_constant_tl(0);
-- 
2.44.0


