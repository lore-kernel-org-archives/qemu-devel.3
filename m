Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02469C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5K-0003u7-1y; Fri, 17 Jan 2025 13:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5H-0003qF-S0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:43 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5F-00006e-FP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:43 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso3431519a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138519; x=1737743319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQRj5TU2Posy8KjGsBBbhkR+my+46AivX5CKfGm3PoM=;
 b=NItBjXZ/Lxb498MWeJDdnbmOidYBla74PLq0HvUPq3b5xeYu+IgyueRWuXBfSRMdlB
 Jy72GnbVUBYwkdvkzyYSeM/k5m6/zoYQjigXAqlZcLGLGYJ8xzVjSYmngsXRNXChRgEW
 +yrl2Lguk4Jrof0BZ2CYEsGL1X41TSS8mIjfoYQjsqxM7qO5AvvFKnDEwA8l3btVtQZX
 Zbmpiq6q83rmp+eKjl8+i5yL3fiU4hdjNRImEy2fqZlPcPj/TFLuJCLvxF/uQcbpvUrG
 c7lrsBy2XsWpEIIMEpkZR3YvUyp2faChh1CPlRftIgPWqIkPa3rFBZkt54tdAZqXCcTr
 FMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138519; x=1737743319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQRj5TU2Posy8KjGsBBbhkR+my+46AivX5CKfGm3PoM=;
 b=XwX/Nq8VuMu2EVef+652dLQ+RItOJovGOLEQO4+PzsZfl8oas0PTs7OqbomkvYU6Nz
 PfoXQqDljfwU4pnejvGp+d9+SPBPK0Ij017Dlk3R35HGEB7Ii7Go4u1QFwvwDcY9986+
 cgpcKJ8svJNkdODXVt9idA/tjlw57b/wnnKXE3l4kYOgbZ4ZYGV3z2TJfyAD5Ez0CG8M
 wGezI6Ga8jk3ksHpYZcgXDVuyfr4DSQhEz2hrrfGx2Et0aNh9eF53n1+l4sXhm4lkJvN
 i2DNlpsOwa4mNKO2SQoarHMrLOO1+Xuky3CnSYiTiJrxXD2UzQD4oMB7+rqmcoCwiDTL
 E/yQ==
X-Gm-Message-State: AOJu0YwRJyUy2SVMzM47E3tnTqXAhs4T64l55obHB18yLIaq2uOlSHrZ
 ++2+RhdknkGctRu+IujYoYgpm8exk3UYAdKBTTtkBAwZt/dhKjdFWf7tRZ6H1SOTH2sKDrqE2rM
 p
X-Gm-Gg: ASbGnctDYYjGF0mbWFShVc60/F6ADeG5CcLa/PSIlMcTdPjPYBcemCPZF946tXszGFU
 RT0B/QSiYng9n2UasO4tPjY8QcycjddLC6IJe+e/wk/cMxYgQlgXmzi0ZRZVQ/uepDMj8NzKNun
 pSdNLQoGMZCxgChlOUI97hBvSrbZAZAs31M7Lk8V2xw9laVkbtC0/CO1AGMqVaICzhpRrb/z0ic
 qjSMEdxBJw2oha/ans1LKTehDYcOZb8QwiooTjuYOVSrFQzsyPPXpbgKRmKANecrODESvjFTp/K
 /zrmZKx4jsEJFFU=
X-Google-Smtp-Source: AGHT+IGtgw3Jzme0YSAbdofYo+o2Li8rOikVvfNkHzcnRol+ZeGKtqQPMiJdq5F8tU+gSf6gqX6D1A==
X-Received: by 2002:a17:90b:2748:b0:2ee:dd79:e046 with SMTP id
 98e67ed59e1d1-2f782c79fe8mr5059590a91.13.1737138519441; 
 Fri, 17 Jan 2025 10:28:39 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/68] tcg: Add TCGType argument to tcg_out_op
Date: Fri, 17 Jan 2025 10:24:30 -0800
Message-ID: <20250117182456.2077110-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Pass TCGOp.type to the output function.
For aarch64 and tci, use this instead of testing TCG_OPF_64BIT.
For s390x, use this instead of testing INDEX_op_deposit_i64.
For i386, use this to initialize rexw.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        |  4 ++--
 tcg/aarch64/tcg-target.c.inc     |  6 +-----
 tcg/arm/tcg-target.c.inc         |  2 +-
 tcg/i386/tcg-target.c.inc        | 10 +++++-----
 tcg/loongarch64/tcg-target.c.inc |  2 +-
 tcg/mips/tcg-target.c.inc        |  2 +-
 tcg/ppc/tcg-target.c.inc         |  2 +-
 tcg/riscv/tcg-target.c.inc       |  2 +-
 tcg/s390x/tcg-target.c.inc       |  7 +++----
 tcg/sparc64/tcg-target.c.inc     |  2 +-
 tcg/tci/tcg-target.c.inc         |  4 ++--
 11 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 83356d932d..9b54a8bec8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -134,7 +134,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg, TCGReg, tcg_target_long);
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2);
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg);
 static void tcg_out_goto_tb(TCGContext *s, int which);
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS]);
 #if TCG_TARGET_MAYBE_vec
@@ -5423,7 +5423,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             tcg_out_vec_op(s, op->opc, TCGOP_TYPE(op) - TCG_TYPE_V64,
                            TCGOP_VECE(op), new_args, const_args);
         } else {
-            tcg_out_op(s, op->opc, new_args, const_args);
+            tcg_out_op(s, op->opc, TCGOP_TYPE(op), new_args, const_args);
         }
         break;
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 9116f85667..ede6f47235 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2115,14 +2115,10 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    /* 99% of the time, we can signal the use of extension registers
-       by looking to see if the opcode handles 64-bit data.  */
-    TCGType ext = (tcg_op_defs[opc].flags & TCG_OPF_64BIT) != 0;
-
     /* Hoist the loads of the most common arguments.  */
     TCGArg a0 = args[0];
     TCGArg a1 = args[1];
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 182cac1a8a..9cfb733a14 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1805,7 +1805,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 64826c7419..8d1057cdb3 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2612,17 +2612,16 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* no need to flush icache explicitly */
 }
 
-static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
-                              const TCGArg args[TCG_MAX_OP_ARGS],
-                              const int const_args[TCG_MAX_OP_ARGS])
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
+                       const TCGArg args[TCG_MAX_OP_ARGS],
+                       const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2;
-    int c, const_a2, vexop, rexw = 0;
+    int c, const_a2, vexop, rexw;
 
 #if TCG_TARGET_REG_BITS == 64
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_, x), _i64): \
-            rexw = P_REXW; /* FALLTHRU */    \
         case glue(glue(INDEX_op_, x), _i32)
 #else
 # define OP_32_64(x) \
@@ -2634,6 +2633,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     a1 = args[1];
     a2 = args[2];
     const_a2 = const_args[2];
+    rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2f0d4d01ff..3dff29facb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1278,7 +1278,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index b89b279a0e..b31b8f0007 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1678,7 +1678,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 1e7b8a204c..9205ac99e9 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2940,7 +2940,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 432a2fe26f..e381ba4e77 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1960,7 +1960,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e09a726ecf..fc7d986e68 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2117,9 +2117,9 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
         case glue(glue(INDEX_op_,x),_i32): \
         case glue(glue(INDEX_op_,x),_i64)
 
-static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
-                              const TCGArg args[TCG_MAX_OP_ARGS],
-                              const int const_args[TCG_MAX_OP_ARGS])
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
+                       const TCGArg args[TCG_MAX_OP_ARGS],
+                       const int const_args[TCG_MAX_OP_ARGS])
 {
     S390Opcode op, op2;
     TCGArg a0, a1, a2;
@@ -2713,7 +2713,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             /* Since we can't support "0Z" as a constraint, we allow a1 in
                any register.  Fix things up as if a matching constraint.  */
             if (a0 != a1) {
-                TCGType type = (opc == INDEX_op_deposit_i64);
                 if (a0 == a2) {
                     tcg_out_mov(s, type, TCG_TMP0, a2);
                     a2 = TCG_TMP0;
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 48de490120..afc778fae7 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1288,7 +1288,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 {
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 662acbdcb6..88cecbd62f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -708,7 +708,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
-static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
@@ -790,7 +790,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
         {
             TCGArg pos = args[2], len = args[3];
-            TCGArg max = tcg_op_defs[opc].flags & TCG_OPF_64BIT ? 64 : 32;
+            TCGArg max = type == TCG_TYPE_I32 ? 32 : 64;
 
             tcg_debug_assert(pos < max);
             tcg_debug_assert(pos + len <= max);
-- 
2.43.0


