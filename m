Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3708606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nOx6QNnZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsW8-00069w-2d; Fri, 30 Oct 2026 15:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVg-00063U-BJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:34 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVe-00009A-5O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:32 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7f48c750afcso766467a34.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389409; x=1793994209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MeuLuPZYwOdXNfYKOD6A+UEuVbDk00qgFvrdKJmF5B8=;
 b=nOx6QNnZUWW/8Bc1EhrXRCzOziJ2ektBq4oAKmo4QMNnGBA0oG+RD3Nj8H4yd4n5uW
 gMVrqLI8xMqotyTecfY2mnIpC586EFj66OVefV0+ruo12pLbXp5e3Ybt4vvXSJRi4WYg
 5znb7skKJfENOVCYEwYEhvcvW5gt5mnRakiXFX37Ormkbd59eEc89MmC7bdzlxV8sS3c
 Kq05AJLbPbw7w51vV0a/dX8X8Z5bP42TF5SEj/RoPcUTVWQC/+Ndz9zVW8bPXF7cwEQz
 RAYqALX9682CWzwUFAXjk2eUHRkDfTaBh568ER6x/tp4DYJ+HJ1Fwhc3gPtEF8yJaulY
 K9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389409; x=1793994209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MeuLuPZYwOdXNfYKOD6A+UEuVbDk00qgFvrdKJmF5B8=;
 b=etp7+yJWrUt/bL/eR4kvVAXFxVVTJPhhzfmuTMysmZEQheYO9QfB+QlxTzARfBCxCh
 XXJtzKf7WgSQhfIxyubpm1CVamJj5FqVjkpKy8L2nIf7uIV3In6rXAl9gCKiFzKjp4wr
 JgL9vN52RxCCf43kOi/uV2H954M33okYHVOtDmx42iJk4GnPlUPsc+Wuxs3eUa3HnPO5
 /KkPA1vIzRWtoqGrrhgI+YeD0f4KvB6VnJyZNLnWxF9LOf948abg2F/0MKhU+HJH4vAu
 LWuKgWMlZ0X4nKNm+M9uinwIZxN0YZo01ILRZE5QJkjljUMHzBMKRWpDyCNWoWgDcEl0
 ntRg==
X-Gm-Message-State: AFq9FYLS33c0ENhZyW66K9/rCj74KTX68vZB8qTcJ2Wgn8b8ph3EgIM/
 Xnmky+eBpkP52UeWE0ehMqb1r1I+sg+esT3M8TOqVGVNprdHlsolzkScbmVVpmEq+EDEzV71fay
 q17lh
X-Gm-Gg: AYBFou2Ybeun0RMNZ1e1k+zCoitUBswGtx5L3erG1ugHG5dbNp9bYXYxjVPpqLnLmwl
 viklz5y0VqbGsrmW7q5DVTtKIpL0Odv4oEeS1OMvmCGDChph2ACM666y9bhWsIMM4cZorpEuWHY
 fgvSceFXguwhd/tPTCV7VzFEcunp7cqTk8SFEJueuNpL13Bhad/XpOL1QpnpfhbPS0EZEZt+No4
 RScw5V/xEGEi46vnaX+O1tVe1JEcteh6OKNln1OdFTfQBmERIeOlwjZyWBxz9Uw2AS1hRJ/b7oa
 TRAQb86XuEywPoze4jGQrWf2vfei1UbaPK+PoteXiI5lXhQlOiStQlcPdwpsq1ViwEvKUsOgNzz
 BXD4WY+w0SWubVJHOleousyVAn7G95Hbhv8Cjd7ismx86zRO2cKY8EWHDyJWYQ3gfLyGKKap7+m
 oo41GGB6QJcUDUkKSu2e60XHlX638EueNjbmqZgrXdor1gZkRt4iOKA+Wt8SS+WeXaYaQmOYpsR
 sUxQ3PQuGTAkkk0dlD+Xf1hu6tLXcHT6Y1ERtYks7VXKBkS2wWRMHgWkMNz85s8DI8HziRn6lfj
 Qcc7L93Sqvua/2w7MZWdUy8Qg/XM7yHZ+lg=
X-Received: by 2002:a05:6830:640e:b0:7fa:ac4f:79c with SMTP id
 46e09a7af769-85d364471d1mr2382376a34.24.1793389408926; 
 Fri, 30 Oct 2026 12:43:28 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/9] target/arm: Split out gen_cbranch_goto_tb
Date: Fri, 30 Oct 2026 14:43:15 -0500
Message-ID: <20261030194318.319310-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A common helper for all conditional branches, using DisasCompare64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 142 ++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 63 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c8d1251f13..e66ccdff6f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -584,6 +584,50 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
     }
 }
 
+static bool gen_cbranch(DisasContext *s, const DisasCompare64 *c,
+                        int64_t taken_diff)
+{
+    int64_t not_taken_diff = 4;
+    bool may_goto_t = use_goto_tb(s, s->pc_curr + taken_diff);
+    bool may_goto_f = use_goto_tb(s, s->pc_curr + not_taken_diff);
+
+    /*
+     * If there is a choice, place a real goto_tb path first.
+     * If neither path can use goto_tb, convert to an indirect branch.
+     */
+    if (may_goto_f) {
+        DisasLabel l = gen_disas_label(s);
+
+        tcg_gen_brcond_i64(c->cond, c->v1, c->v2, l.label);
+        gen_goto_tb_int(s, 0, not_taken_diff);
+
+        set_disas_label(s, l);
+        if (may_goto_t) {
+            gen_goto_tb_int(s, 1, taken_diff);
+            s->base.is_jmp = DISAS_NORETURN;
+            return true;
+        }
+        gen_a64_update_pc(s, taken_diff);
+    } else if (may_goto_t) {
+        DisasLabel l = gen_disas_label(s);
+
+        tcg_gen_brcond_i64(tcg_invert_cond(c->cond), c->v1, c->v2, l.label);
+        gen_goto_tb_int(s, 1, taken_diff);
+
+        set_disas_label(s, l);
+        gen_a64_update_pc(s, not_taken_diff);
+    } else {
+        TCGv_i64 pc_t = tcg_temp_new_i64();
+        TCGv_i64 pc_f = tcg_temp_new_i64();
+
+        gen_pc_plus_diff(s, pc_t, taken_diff);
+        gen_pc_plus_diff(s, pc_f, not_taken_diff);
+        tcg_gen_movcond_i64(c->cond, cpu_pc, c->v1, c->v2, pc_t, pc_f);
+        s->pc_save = -1;
+    }
+    return gen_indirect_branch(s);
+}
+
 /*
  * Register access functions
  *
@@ -1758,38 +1802,26 @@ static bool trans_BL(DisasContext *s, arg_i *a)
 
 static bool trans_CBZ(DisasContext *s, arg_cbz *a)
 {
-    DisasLabel match;
-    TCGv_i64 tcg_cmp;
+    DisasCompare64 c = {
+        .cond = a->nz ? TCG_COND_NE : TCG_COND_EQ,
+        .v1 = read_cpu_reg(s, a->rt, a->sf),
+        .v2 = tcg_constant_i64(0),
+    };
 
-    tcg_cmp = read_cpu_reg(s, a->rt, a->sf);
     reset_btype(s);
-
-    match = gen_disas_label(s);
-    tcg_gen_brcondi_i64(a->nz ? TCG_COND_NE : TCG_COND_EQ,
-                        tcg_cmp, 0, match.label);
-    gen_goto_tb(s, 0, 4);
-    set_disas_label(s, match);
-    gen_goto_tb(s, 1, a->imm);
-    return true;
+    return gen_cbranch(s, &c, a->imm);
 }
 
 static bool trans_TBZ(DisasContext *s, arg_tbz *a)
 {
-    DisasLabel match;
-    TCGv_i64 tcg_cmp;
-
-    tcg_cmp = tcg_temp_new_i64();
-    tcg_gen_andi_i64(tcg_cmp, cpu_reg(s, a->rt), 1ULL << a->bitpos);
+    DisasCompare64 c = {
+        .cond = a->nz ? TCG_COND_TSTNE : TCG_COND_TSTEQ,
+        .v1 = cpu_reg(s, a->rt),
+        .v2 = tcg_constant_i64(1ULL << a->bitpos),
+    };
 
     reset_btype(s);
-
-    match = gen_disas_label(s);
-    tcg_gen_brcondi_i64(a->nz ? TCG_COND_NE : TCG_COND_EQ,
-                        tcg_cmp, 0, match.label);
-    gen_goto_tb(s, 0, 4);
-    set_disas_label(s, match);
-    gen_goto_tb(s, 1, a->imm);
-    return true;
+    return gen_cbranch(s, &c, a->imm);
 }
 
 static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
@@ -1801,11 +1833,10 @@ static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
     reset_btype(s);
     if (a->cond < 0x0e) {
         /* genuinely conditional branches */
-        DisasLabel match = gen_disas_label(s);
-        arm_gen_test_cc(a->cond, match.label);
-        gen_goto_tb(s, 0, 4);
-        set_disas_label(s, match);
-        gen_goto_tb(s, 1, a->imm);
+        DisasCompare64 c;
+
+        a64_test_cc(&c, a->cond);
+        return gen_cbranch(s, &c, a->imm);
     } else {
         /* 0xe and 0xf are both "always" conditions */
         gen_goto_tb(s, 0, a->imm);
@@ -1825,35 +1856,27 @@ static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
         [6] = TCG_COND_EQ,
         [7] = TCG_COND_NE,
     };
-    TCGCond cond = cb_cond[a->cc];
-    TCGv_i64 t, m;
-    DisasLabel match;
+    DisasCompare64 c = { .cond = cb_cond[a->cc] };
 
-    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
+    if (!dc_isar_feature(aa64_cmpbr, s) || c.cond == TCG_COND_NEVER) {
         return false;
     }
 
-    t = cpu_reg(s, a->rt);
-    m = cpu_reg(s, a->rm);
+    c.v1 = cpu_reg(s, a->rt);
+    c.v1 = cpu_reg(s, a->rm);
     if (a->esz != MO_64) {
-        MemOp mop = a->esz | (is_signed_cond(cond) ? MO_SIGN : 0);
+        MemOp mop = a->esz | (is_signed_cond(c.cond) ? MO_SIGN : 0);
         TCGv_i64 tt = tcg_temp_new_i64();
         TCGv_i64 tm = tcg_temp_new_i64();
 
-        tcg_gen_ext_i64(tt, t, mop);
-        tcg_gen_ext_i64(tm, m, mop);
-        t = tt;
-        m = tm;
+        tcg_gen_ext_i64(tt, c.v1, mop);
+        tcg_gen_ext_i64(tm, c.v1, mop);
+        c.v1 = tt;
+        c.v1 = tm;
     }
 
     reset_btype(s);
-    match = gen_disas_label(s);
-
-    tcg_gen_brcond_i64(cond, t, m, match.label);
-    gen_goto_tb(s, 0, 4);
-    set_disas_label(s, match);
-    gen_goto_tb(s, 1, a->imm);
-    return true;
+    return gen_cbranch(s, &c, a->imm);
 }
 
 static bool trans_CB_cond_imm(DisasContext *s, arg_CB_cond_imm *a)
@@ -1869,34 +1892,27 @@ static bool trans_CB_cond_imm(DisasContext *s, arg_CB_cond_imm *a)
         [6] = TCG_COND_EQ,
         [7] = TCG_COND_NE,
     };
-    TCGCond cond = cb_cond[a->cc];
-    TCGv_i64 t;
-    DisasLabel match;
+    DisasCompare64 c = { .cond = cb_cond[a->cc] };
 
-    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
+    if (!dc_isar_feature(aa64_cmpbr, s) || c.cond == TCG_COND_NEVER) {
         return false;
     }
 
-    t = cpu_reg(s, a->rt);
+    c.v1 = cpu_reg(s, a->rt);
     if (!a->sf) {
         TCGv_i64 tt = tcg_temp_new_i64();
 
-        if (is_signed_cond(cond)) {
-            tcg_gen_ext32s_i64(tt, t);
+        if (is_signed_cond(c.cond)) {
+            tcg_gen_ext32s_i64(tt, c.v1);
         } else {
-            tcg_gen_ext32u_i64(tt, t);
+            tcg_gen_ext32u_i64(tt, c.v1);
         }
-        t = tt;
+        c.v1 = tt;
     }
+    c.v2 = tcg_constant_i64(a->imm6);
 
     reset_btype(s);
-    match = gen_disas_label(s);
-
-    tcg_gen_brcondi_i64(cond, t, a->imm6, match.label);
-    gen_goto_tb(s, 0, 4);
-    set_disas_label(s, match);
-    gen_goto_tb(s, 1, a->imm9);
-    return true;
+    return gen_cbranch(s, &c, a->imm9);
 }
 
 static void set_btype_for_br(DisasContext *s, int rn)
-- 
2.53.0


