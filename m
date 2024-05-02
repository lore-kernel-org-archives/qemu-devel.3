Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52791C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFM-0008UL-4K; Thu, 02 May 2024 01:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFC-0008Nr-68
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:34 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF7-0002dC-Kw
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:33 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6eb93ec8804so4248055a34.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628667; x=1715233467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJ19L6XEqsk3lyVXCAHdcn8K6R6cA/YjCpdra8gDDvU=;
 b=dZ/N3j57yL4gETQ4Xsr3OCGPVg2tKVxDTZf8Cryd7YuZ9RgIc5ZBxCIZ5B6aMqqjv+
 pSawaLFgD+8zv74Z5+04bAQjTRILM3Ir2Jo29rqQvILAEONsCts+U4hDXs7ZVWRY0gED
 LJ7jZ9DdcxAyvIB/9w8mnFiC2smGox/EHXEwnXPWO5ICbcVPUA15ZgMCE2Ypdz2A12TR
 g08iANjulmBN0X5Ng43vq3EFuWy7L0VzlUEnzIcBNHYyPUbxZu/FzLovUTs7Hxp9aiC6
 5j6CSRUQFHoWX9MVOL5Nxncw36y+aNh1qRefts9iRxEWbVXFDF45jBPhUPlC9XHa/lyX
 CeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628667; x=1715233467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJ19L6XEqsk3lyVXCAHdcn8K6R6cA/YjCpdra8gDDvU=;
 b=H7tM+uuW/yrZInh2jr8Uf3E0DzqUy1bfz14e0zbZ8RdIkeVTNR8LD+HJvv+2qXxl47
 Z99ZKsJGUgr306ziQFyh+3O1VePU+IA5g1aEfrCh3pAQNIaOzDDaDC38vbG1nuUDhzL7
 6ZTmyfF4W5SeTWYX2MZs59bbjxwKQui1ZKC6PzMcZ5SeJ/OQX31T4oVfUXwfRPe/hvQW
 JZT665eRChVxl72u6SDAy471gZqkGut4YJbbvU9eoezMe5sw0nz3TW46cD2KUmpvjpjg
 JNoT1lO1aIa7UKHkwpGQvvOK+jEdfPMozDZRz73QXkLxfs2MhkE0Q1ywt4WaZPNyVMZs
 uy8Q==
X-Gm-Message-State: AOJu0Yyh5OlhwhxePBtgyJK1+idhSkI+LLMt+kK/D14yH+cbe6sJF1sS
 hILom1k+QZyIR7QFPoM1dttXpt5Q/RTe6opqEh64lSLEQqPFCoYVeLseh7xjQYkWuyeCMMyswWd
 P
X-Google-Smtp-Source: AGHT+IH4Zb1Icq/SzNftReom4B5aiA1d+l+PV3pqwtjpgF5Q7lhHj1cizhsS74e0hQXAAH5GbHwPlw==
X-Received: by 2002:a05:6870:a450:b0:22e:e1e5:b8e with SMTP id
 n16-20020a056870a45000b0022ee1e50b8emr4973422oal.41.1714628666820; 
 Wed, 01 May 2024 22:44:26 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 07/14] target/s390x: Simplify help_branch
Date: Wed,  1 May 2024 22:44:10 -0700
Message-Id: <20240502054417.234340-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Always use a tcg branch, instead of movcond.  The movcond
was not a bad idea before PER was added, but since then
we have either 2 or 3 actions to perform on each leg of
the branch, and multiple movcond is inefficient.

Reorder the taken branch to be fallthrough of the tcg branch.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 164 ++++++++++++-----------------------
 1 file changed, 56 insertions(+), 108 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index b1a93070cb..e77660ee50 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -355,25 +355,6 @@ static void per_branch(DisasContext *s, bool to_next)
 #endif
 }
 
-static void per_branch_cond(DisasContext *s, TCGCond cond,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-#ifndef CONFIG_USER_ONLY
-    if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
-        TCGLabel *lab = gen_new_label();
-        tcg_gen_brcond_i64(tcg_invert_cond(cond), arg1, arg2, lab);
-
-        tcg_gen_movi_i64(gbea, s->base.pc_next);
-        gen_helper_per_branch(tcg_env, gbea, psw_addr);
-
-        gen_set_label(lab);
-    } else {
-        TCGv_i64 pc = tcg_constant_i64(s->base.pc_next);
-        tcg_gen_movcond_i64(cond, gbea, arg1, arg2, gbea, pc);
-    }
-#endif
-}
-
 static void per_breaking_event(DisasContext *s)
 {
     tcg_gen_movi_i64(gbea, s->base.pc_next);
@@ -1130,14 +1111,12 @@ static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
 static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
                                  bool is_imm, int imm, TCGv_i64 cdest)
 {
-    DisasJumpType ret;
     uint64_t dest = s->base.pc_next + (int64_t)imm * 2;
-    TCGLabel *lab;
+    TCGLabel *lab, *over;
 
     /* Take care of the special cases first.  */
     if (c->cond == TCG_COND_NEVER) {
-        ret = DISAS_NEXT;
-        goto egress;
+        return DISAS_NEXT;
     }
     if (is_imm) {
         /*
@@ -1147,104 +1126,73 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         if (c->cond == TCG_COND_ALWAYS
             || (dest == s->pc_tmp &&
                 !(s->base.tb->flags & FLAG_MASK_PER_BRANCH))) {
-            ret = help_goto_direct(s, dest);
-            goto egress;
+            return help_goto_direct(s, dest);
         }
     } else {
         if (!cdest) {
             /* E.g. bcr %r0 -> no branch.  */
-            ret = DISAS_NEXT;
-            goto egress;
+            return DISAS_NEXT;
         }
         if (c->cond == TCG_COND_ALWAYS) {
-            ret = help_goto_indirect(s, cdest);
-            goto egress;
+            return help_goto_indirect(s, cdest);
         }
     }
 
-    if (use_goto_tb(s, s->pc_tmp)) {
-        if (is_imm && use_goto_tb(s, dest)) {
-            /* Both exits can use goto_tb.  */
-            update_cc_op(s);
+    update_cc_op(s);
 
-            lab = gen_new_label();
-            if (c->is_64) {
-                tcg_gen_brcond_i64(c->cond, c->u.s64.a, c->u.s64.b, lab);
-            } else {
-                tcg_gen_brcond_i32(c->cond, c->u.s32.a, c->u.s32.b, lab);
-            }
-
-            /* Branch not taken.  */
-            tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
-            tcg_gen_exit_tb(s->base.tb, 0);
-
-            /* Branch taken.  */
-            gen_set_label(lab);
-            per_breaking_event(s);
-            tcg_gen_goto_tb(1);
-            tcg_gen_movi_i64(psw_addr, dest);
-            tcg_gen_exit_tb(s->base.tb, 1);
-
-            ret = DISAS_NORETURN;
-        } else {
-            /* Fallthru can use goto_tb, but taken branch cannot.  */
-            /* Store taken branch destination before the brcond.  This
-               avoids having to allocate a new local temp to hold it.
-               We'll overwrite this in the not taken case anyway.  */
-            if (!is_imm) {
-                tcg_gen_mov_i64(psw_addr, cdest);
-            }
-
-            lab = gen_new_label();
-            if (c->is_64) {
-                tcg_gen_brcond_i64(c->cond, c->u.s64.a, c->u.s64.b, lab);
-            } else {
-                tcg_gen_brcond_i32(c->cond, c->u.s32.a, c->u.s32.b, lab);
-            }
-
-            /* Branch not taken.  */
-            update_cc_op(s);
-            tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
-            tcg_gen_exit_tb(s->base.tb, 0);
-
-            gen_set_label(lab);
-            if (is_imm) {
-                tcg_gen_movi_i64(psw_addr, dest);
-            }
-            per_breaking_event(s);
-            ret = DISAS_PC_UPDATED;
-        }
+    /*
+     * Ensure the taken branch is fall-through of the tcg branch.
+     * This keeps @cdest usage within the extended basic block,
+     * which avoids an otherwise unnecessary spill to the stack.
+     */
+    lab = gen_new_label();
+    if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
+        over = gen_new_label();
     } else {
-        /* Fallthru cannot use goto_tb.  This by itself is vanishingly rare.
-           Most commonly we're single-stepping or some other condition that
-           disables all use of goto_tb.  Just update the PC and exit.  */
-
-        TCGv_i64 next = tcg_constant_i64(s->pc_tmp);
-        if (is_imm) {
-            cdest = tcg_constant_i64(dest);
-        }
-
-        if (c->is_64) {
-            tcg_gen_movcond_i64(c->cond, psw_addr, c->u.s64.a, c->u.s64.b,
-                                cdest, next);
-            per_branch_cond(s, c->cond, c->u.s64.a, c->u.s64.b);
-        } else {
-            TCGv_i32 t0 = tcg_temp_new_i32();
-            TCGv_i64 t1 = tcg_temp_new_i64();
-            TCGv_i64 z = tcg_constant_i64(0);
-            tcg_gen_setcond_i32(c->cond, t0, c->u.s32.a, c->u.s32.b);
-            tcg_gen_extu_i32_i64(t1, t0);
-            tcg_gen_movcond_i64(TCG_COND_NE, psw_addr, t1, z, cdest, next);
-            per_branch_cond(s, TCG_COND_NE, t1, z);
-        }
-
-        ret = DISAS_PC_UPDATED;
+        over = NULL;
     }
 
- egress:
-    return ret;
+    if (c->is_64) {
+        tcg_gen_brcond_i64(tcg_invert_cond(c->cond),
+                           c->u.s64.a, c->u.s64.b, lab);
+    } else {
+        tcg_gen_brcond_i32(tcg_invert_cond(c->cond),
+                           c->u.s32.a, c->u.s32.b, lab);
+    }
+
+    /* Branch taken.  */
+    if (is_imm) {
+        tcg_gen_movi_i64(psw_addr, dest);
+    } else {
+        tcg_gen_mov_i64(psw_addr, cdest);
+    }
+    per_branch(s, false);
+
+    if (is_imm && use_goto_tb(s, dest)) {
+        tcg_gen_goto_tb(0);
+        tcg_gen_exit_tb(s->base.tb, 0);
+    } else if (over) {
+        tcg_gen_br(over);
+    } else {
+        tcg_gen_lookup_and_goto_ptr();
+    }
+
+    gen_set_label(lab);
+
+    /* Branch not taken.  */
+    tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+    if (use_goto_tb(s, s->pc_tmp)) {
+        tcg_gen_goto_tb(1);
+        tcg_gen_exit_tb(s->base.tb, 1);
+    }
+
+    if (over) {
+        gen_set_label(over);
+        return DISAS_PC_UPDATED;
+    }
+
+    tcg_gen_lookup_and_goto_ptr();
+    return DISAS_NORETURN;
 }
 
 /* ====================================================================== */
-- 
2.34.1


