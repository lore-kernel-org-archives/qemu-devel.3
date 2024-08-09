Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0256EC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKjs-0005p9-NU; Fri, 09 Aug 2024 04:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scKjr-0005mQ-VS
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:12:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1scKjq-0006o8-6N
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:12:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc52394c92so17668745ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723191160; x=1723795960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lnyy3iG1ppUhes/NXnsprwtoY4OtwR9FbGvONHrEws4=;
 b=nlrU6lLUynn10G5MHcr8kOnc/xCk6hqT67bgo3/FIrJhRYWxRPtIq3YAnQn3Mi7OAy
 X3aZsMEfwYxzvB2qaHSSyfYZhPC3TJnjWaujqX0Y8y9OfL3VX+CjnS3qS5drO9mIb6PD
 5wc3yRDibWUnIfO2hWpVt0+uJv4pFrZwyyHdyxAuloslkiriR7TCwHpEVB13PrPUqX/r
 P8ZILJKmRBBUMNkbxVdQU6YpV8BIKFqqhMa8BP7rjHpc2rWbQ0sdmEslRc2agRiKGIpX
 b8rD3KVE6RRP9PrbJOJNOscks5qqHNlKDhEg/idEwfM9JeRtBiEtarQ8btD8n72Fvg8h
 fZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723191160; x=1723795960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lnyy3iG1ppUhes/NXnsprwtoY4OtwR9FbGvONHrEws4=;
 b=JtFvds4AbAvZi3xMNeQ/Gu91cjqXObgYoQnm1UakvJ6QVI4r6Jqkuz8joQxSLWtIQb
 RjNyAi9wCP1YbgLqeF6HSXWeWAJRcZ2Z7Nh01srxZeujt9w9bgwfx1WB6aoav+hk1gDt
 GlJ+RLa4EN5hYldjZIFB5aNy1r5E9OG5Fr5pZKUaSw3ubJDI5BP+egsEbbcU1CRo1u6H
 3+WU1CmH/gcm8bWvc8i0OlMFliDSUVqarXljTssIcrsZ7NDBse21yNgvIYjuFrQKQZD7
 y2o2tpoT5V5ilwNlScfv1uj8o9aKj7IntCCyXDsGvqFzkmznH82ilcvHoLqxVQJXnf7F
 Qyhg==
X-Gm-Message-State: AOJu0Yw+IReHab9ZRpPT8FPGTkdjQdyKnBBqHWKE/zhDA5hFqvvO96vP
 QLL271t4HOBN/oDNvRcvByR4FlOdJl1p1sN35Z31F3q72PGI3fZtj2XKZF6NuOjLsA5kFNclsU/
 Tdj9xR1oMDTFPRJZNoPow9KhRRUJAyYSMwGB9gpDdo2iC2tyUC7b1iV5C2hEnmC9GouwazF+S7H
 OfUYRcX6Vq0StyMHhwYMPrB9N3C698PfNN/K5aBw==
X-Google-Smtp-Source: AGHT+IFBgG0clyz7afN9hi4gW03bwRKThMZ1JXg/HKqNLrxWgOUMocZsinWjmK5J27VcOwe2nM9XSQ==
X-Received: by 2002:a17:902:d4c8:b0:1fb:9280:c970 with SMTP id
 d9443c01a7336-200ae4db87fmr6802285ad.7.1723191160068; 
 Fri, 09 Aug 2024 01:12:40 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b6cfbsm136391185ad.306.2024.08.09.01.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 01:12:39 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v5 4/5] target/riscv: Add Smrnmi mnret instruction.
Date: Fri,  9 Aug 2024 01:12:26 -0700
Message-Id: <20240809081227.1588508-5-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240809081227.1588508-1-tommy.wu@sifive.com>
References: <20240809081227.1588508-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=tommy.wu@sifive.com; helo=mail-pl1-x634.google.com
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

This patch adds a new instruction `mnret`. `mnret` is an M-mode-only
instruction that uses the values in `mnepc` and `mnstatus` to return to the
program counter, privilege mode, and virtualization mode of the
interrupted context.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 ++
 .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++++
 target/riscv/op_helper.c                      | 46 +++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..16ea240d26 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c45b8fa1d8..d320631e8c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -121,6 +121,9 @@ wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
+# *** NMI ***
+mnret       0111000    00010 00000 000 00000 1110011
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index bc5263a4e0..06bc20dda4 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -106,6 +106,18 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_mnret(cpu_pc, tcg_env);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 25a5263573..3e26392e65 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -353,6 +353,52 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_mnret(CPURISCVState *env)
+{
+    if (!riscv_cpu_cfg(env)->ext_smrnmi) {
+        /* RNMI feature is not presented. */
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    if (!(env->priv >= PRV_M)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    /* Get return PC from mnepc CSR. */
+    target_ulong retpc = env->mnepc;
+    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+    }
+
+    /* Get previous privilege level from mnstatus CSR. */
+    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
+
+    if (riscv_cpu_cfg(env)->pmp &&
+        !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    target_ulong prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
+                             (prev_priv != PRV_M);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, true);
+
+    /*
+     * If MNRET changes the privilege mode to a mode
+     * less privileged than M, it also sets mstatus.MPRV to 0.
+     */
+    if (prev_priv < PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
+    }
+
+    if (riscv_has_ext(env, RVH) && prev_virt) {
+        riscv_cpu_swap_hypervisor_regs(env);
+    }
+
+    riscv_cpu_set_mode(env, prev_priv, prev_virt);
+
+    return retpc;
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.39.3


