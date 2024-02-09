Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA6AC4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOcW-0005yP-Ph; Fri, 09 Feb 2024 06:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcC-0005gu-Jf
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:17 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOc7-0000Z9-Uc
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:15 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e12f8506ccso355858a34.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476410; x=1708081210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PW4HgfpqFA/T+gchjLsJDFYxSNqSSKYfz4pvfD/U1k=;
 b=bhLp3JK855VJltqDMbjPXOJL9P4zmAXh1mVXhu/yd74kx+keWsCFfy5SIUooHgMzG+
 EImeg+MGrB7zpxD5n/vXcIWOFvXEhWe5P0viMH6O6yc7UVFX11HqXeFOUkd3cV/iCbO4
 F/z5mCAQDAkpUi0szOwgEZkz9HUJEIRcaTfc6TABwDFmRgKL3s1+o4VoYFwFvRq/fzpj
 coZF5UN6M/gNLXc/GxMqV2BQZ8XCgMuj4iPzyu2fZS4vXsHpNHVgrWnL1h9H75SL4Zq1
 8dxQhZVHpGxfJc+vkUZ8rhR2GFdLtBezeDJMoqpDzvcDsydNkKPJFXFOlkMJI+qcNX36
 yG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476410; x=1708081210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PW4HgfpqFA/T+gchjLsJDFYxSNqSSKYfz4pvfD/U1k=;
 b=FXt+NynF1pztgmCXGZsUJLt4di2ynUyRhn7+wPtZs9Y/ph9QM0cF+Tvn0lwYh6Bk73
 k31TaqeGwChhSCLw7srMQ8GpNUY7L8YuJXs2Evms83snY4bBXhIfFPCo8T2Bnd+mgNAt
 JEsNQ/AdVZwC9gACk8mTJjF43sN0IyS8JMzy5sVxy3P5KsEtobJ2jGvu+2yIxLLVN24W
 FB81TA8n9D6COcKGS7aSLSm0DPPYtOeAgKgeYzuk8MoSsxzksr/HLo8Mk+9QErZi1xRI
 se1MG31T/2ozmcmYUE1/k/3XEG6kLruS829fwqZ/VhcLGmkIrdwahRM8WGUIRkp+Ah28
 gQNw==
X-Gm-Message-State: AOJu0YwFNi+AyTm05W9YcKS9KGKmTt+gYtj9IV55Myj0LQvwqhnUgMFX
 Buq/SfHTuFrMi3Y5n0SkPrrPzKXLiEoc+JCqhlqNpJkMy+Iwb+0iV1x4jszOspLx8w==
X-Google-Smtp-Source: AGHT+IHvb83LIaVPZRDQ6M7ufLcJ4RbsrM5IuULboI+O3eKulimyKbxDsh8WlUj+Njf1wRYtCnYjHA==
X-Received: by 2002:a05:6830:3b86:b0:6e1:1501:58a5 with SMTP id
 dm6-20020a0568303b8600b006e1150158a5mr1077380otb.13.1707476410481; 
 Fri, 09 Feb 2024 03:00:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUTGhUwF4A1yvTerOhSwlhlV0VB6J+9NSbgDICkHEEm9uYIG5sIT6MrkybrVIi3wItKObWpJFuJ8v/FNWfbl546ePyhQhfgVBRJhXIen0uYD4QAurzg8AN3TigT9PAXx0vAcqw=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/61] target/riscv: change vext_get_vlmax() arguments
Date: Fri,  9 Feb 2024 20:57:44 +1000
Message-ID: <20240209105813.3590056-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x331.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We'll re-use the logic froim vext_get_vlmax() in 2 other occurrences in
the next patch, but first we need to make it independent of both 'cpu'
and 'vtype'. To do that, add 'vlenb', 'vsew' and 'lmul' as parameters
instead.

Adapt the two existing callers. In cpu_get_tb_cpu_state(), rename 'sew'
to 'vsew' to be less ambiguous about what we're encoding into *pflags.

In HELPER(vsetvl) the following changes were made:

- add a 'vsew' var to store vsew. Use it in the shift to get 'sew';
- the existing 'lmul' var was renamed to 'vlmul';
- add a new 'lmul' var to store 'lmul' encoded like DisasContext:lmul.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h           |  7 +++----
 target/riscv/cpu_helper.c    | 11 +++++++----
 target/riscv/vector_helper.c | 16 ++++++++++------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1c5a363e4b..07f797406c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -688,11 +688,10 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
  *               = 256 >> 7
  *               = 2
  */
-static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
+static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
+                                      int8_t lmul)
 {
-    uint8_t vsew = FIELD_EX64(vtype, VTYPE, VSEW);
-    int8_t lmul = sextract32(FIELD_EX64(vtype, VTYPE, VLMUL), 0, 3);
-    uint32_t vlen = cpu->cfg.vlenb << 3;
+    uint32_t vlen = vlenb << 3;
 
     /*
      * We need to use 'vlen' instead of 'vlenb' to
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b6b23b7d03..d462d95ee1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -81,13 +81,16 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
          * which is not supported by GVEC. So we set vl_eq_vlmax flag to true
          * only when maxsz >= 8 bytes.
          */
-        uint32_t vlmax = vext_get_vlmax(cpu, env->vtype);
-        uint32_t sew = FIELD_EX64(env->vtype, VTYPE, VSEW);
-        uint32_t maxsz = vlmax << sew;
+
+        /* lmul encoded as in DisasContext::lmul */
+        int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
+        uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
+        uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
+        uint32_t maxsz = vlmax << vsew;
         bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
                            (maxsz >= 8);
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
-        flags = FIELD_DP32(flags, TB_FLAGS, SEW, sew);
+        flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
         flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
                            FIELD_EX64(env->vtype, VTYPE, VLMUL));
         flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8ee7717162..84cec73eb2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -35,16 +35,18 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
-    uint64_t lmul = FIELD_EX64(s2, VTYPE, VLMUL);
-    uint16_t sew = 8 << FIELD_EX64(s2, VTYPE, VSEW);
+    uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
+    uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
+    uint16_t sew = 8 << vsew;
     uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
     int xlen = riscv_cpu_xlen(env);
     bool vill = (s2 >> (xlen - 1)) & 0x1;
     target_ulong reserved = s2 &
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
+    int8_t lmul;
 
-    if (lmul & 4) {
+    if (vlmul & 4) {
         /*
          * Fractional LMUL, check:
          *
@@ -53,8 +55,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
          * (vlenb << 3) >> (8 - lmul) >= sew
          * vlenb >> (8 - 3 - lmul) >= sew
          */
-        if (lmul == 4 ||
-            cpu->cfg.vlenb >> (8 - 3 - lmul) < sew) {
+        if (vlmul == 4 ||
+            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
             vill = true;
         }
     }
@@ -68,7 +70,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         return 0;
     }
 
-    vlmax = vext_get_vlmax(cpu, s2);
+    /* lmul encoded as in DisasContext::lmul */
+    lmul = sextract32(FIELD_EX64(s2, VTYPE, VLMUL), 0, 3);
+    vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
     if (s1 <= vlmax) {
         vl = s1;
     } else {
-- 
2.43.0


