Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NKoyVDV+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrmc-0007Kj-IE; Fri, 30 Oct 2026 14:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlv-0006tB-8P
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:18 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlr-0004p3-Bs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:13 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6790844c9b0so803334d50.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386570; x=1793991370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1YZySs8MIn4PwSvFcs6OR/idr1m7L2c0nPNHdhNTkgs=;
 b=NKoyVDV+hYlEk+bHwrjflFZOo3N1J808+u4Sr+macFr+1wJ6ZHUA2FkemhHBYHHArW
 MX6Kfuy2EVbHDfbzIIidFKWcN1L3JCE7fOIza8RZitS99b/rZR3EVHmUkyjY6ZcfuM/A
 hXLyhnLYJV05fToEofWLN8Tsp7z5bXMYWkXPOP3CTgAXyl8FX71wI37xf3pJzEdx87DF
 bu3B7sjXX9FL8K4opmDFh7O4HzkDPoiholPNOwBGHAkPqpH+HuYdwnxaR9rQ7i9aROh1
 PsKGkrHXmL4UxO9Japz1t9/7vpqUt4MQA/sfWExjFqcW0xeF1g5K/YPOQ4XxrF+jNTH+
 j4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386570; x=1793991370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1YZySs8MIn4PwSvFcs6OR/idr1m7L2c0nPNHdhNTkgs=;
 b=nGqamO6t5NMp/vHZrkG6eKQT97FS2hpAmgv2oCNhJFbiqtP7imZPh8reEqtzoIgCpR
 ZI/87AICabhOKoHGf2E7HOSGSxJPhsSA9ML10VBJJKUA6rS9T/ar9wRuEQ/laO30NerF
 h5VPo7r6jg39SdusPQC3Dka1kfv+/CXC7w5Wn/SYe6knPqK/IEsNgwUclGbf6c0L/i8v
 w5hURYeL6w79h0dWHCrhwJz63bd4WCfn0x5WETASbEZnejGgEsdAv6rLkkCeguf18EA1
 8MS9cAdC/aTH/lth066KG8vaKINw9BgXUIBABNuu86BqKlZ8nYhk7rx58vSRCIGLol26
 +Bew==
X-Gm-Message-State: AFq9FYJbTMaV8yg/XzKf3IuGErjjIrkD5uW7hyX9qFOja43SNu6Fcfse
 +qm7aMz9eclzA0X0Zh4MFvIiHbbKEmmwzsoGSNePOSfKpGnX5HhFDKDjuuS7j+7O7VUtmcJINPv
 BhY3x
X-Gm-Gg: AYBFou3ZC6r6wpbXLp/nZxze7ZBhX5FD9UG02tYTjZyd+2P/L/01IBBPwkqM2yoTGqt
 VpkhC6qzbO22B94XqRqnT3fhtgsPNhZCAzF9BX2b7Zqj449Zk4WxKv48WnVirnYDlr/f+YpnCM3
 oGJRhYS3o2ppqtRI1aIymbdYpJ1bWpau1ywfAbe2TeWxfkLUgwzcdrNOL5iFRh+hMXLN7C92sUB
 kXpUOhTwRrAuvBuwQHzc39ALrisJMIzkdmGbKpj5YhWVkP/RxBVH9ju/FF9OP7pmUERXo/69CNM
 oj/ewUO8U6GtGgsUpWFeHYT/sBOL8fk9rvIOfBso2pfCbPPl0EVCzbOqcIDD+CcZ5jpq7XhPnuG
 IRvAqRbD7IsahybvgU0kys3b5+d7ynvkf2VzMQfCkikMwhtcxS3pq3Q68y8QuOFbLgY7oloHZNc
 uRnyBuguWuh4ZHx3toGk9qKTV1/1B+U04vS4RFd/CrW+5daLAojufKLOeYmryq6KCeMHdHodAvy
 /ybCGudzr++TUkDYKFYBiwJ/C3+6ri+opVAUhWOP69cRhan3qSOP47Sdv6B1Vba53/KFImBX05S
 9N9+mIEX4tN7mgE6k8XZB+TIZLkapZDPHNo=
X-Received: by 2002:a05:690e:e89:b0:675:41a6:7971 with SMTP id
 956f58d0204a3-67ba5057a6amr2392760d50.98.1793386569668; 
 Fri, 30 Oct 2026 11:56:09 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 10/14] tcg: Add INDEX_op_goto_jc
Date: Fri, 30 Oct 2026 13:55:47 -0500
Message-ID: <20261030185551.193092-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb133.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow goto_jc to be implemented in the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst           | 11 ++++++
 include/tcg/tcg-opc.h            |  1 +
 tcg/tcg-internal.h               |  8 ++++
 tcg/tcg-op.c                     | 65 ++++++++++++++++++--------------
 tcg/tcg.c                        | 22 +++++++++++
 tcg/aarch64/tcg-target.c.inc     |  4 ++
 tcg/loongarch64/tcg-target.c.inc |  4 ++
 tcg/ppc64/tcg-target.c.inc       |  4 ++
 tcg/riscv64/tcg-target.c.inc     |  4 ++
 tcg/s390x/tcg-target.c.inc       |  4 ++
 tcg/sparc64/tcg-target.c.inc     |  4 ++
 tcg/tci/tcg-target.c.inc         |  4 ++
 tcg/x86_64/tcg-target.c.inc      |  4 ++
 13 files changed, 111 insertions(+), 28 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 51fa183e91..ca640610b4 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -752,6 +752,17 @@ QEMU specific operations
        | This operation is optional. If the TCG backend does not implement the
          goto_ptr opcode, emitting this op is equivalent to emitting exit_tb(0).
 
+   * - goto_jc *jc*, *pc*, *cs_base*, *flags*, *label*
+
+     - | *jc* is a CPUJumpCache pointer.  Generate code for:
+       |
+       | if (jc->pc != pc) goto label;
+       | tb = jc->tb;
+       | if (tb == NULL) goto label;
+       | if (tb->flags != flags) goto label;
+       | if (tb->cs_base != cs_base) goto label;
+       | goto tb->tc.ptr;
+
    * - qemu_ld_i32/i64/i128 *t0*, *t1*, *flags*, *memidx*
 
        qemu_st_i32/i64/i128 *t0*, *t1*, *flags*, *memidx*
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 884345afe5..ce7703d583 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -122,6 +122,7 @@ DEF(insn_start, 0, 0, INSN_START_WORDS, TCG_OPF_NOT_PRESENT)
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+DEF(goto_jc, 0, 4, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index ae0a19a2f7..9f1fb91006 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -139,6 +139,14 @@ static inline void tcg_gen_op_tttt(TCGOpcode opc, TCGType type, TCGTemp *t0,
                 temp_arg(t2), temp_arg(t3));
 }
 
+static inline TCGOp *tcg_gen_op_tttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                      TCGTemp *t1, TCGTemp *t2,
+                                      TCGTemp *t3, TCGArg a4)
+{
+    return tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), temp_arg(t3), a4);
+}
+
 static inline void tcg_gen_op_tttii(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGArg a3, TCGArg a4)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1b4ee6d3d9..0040d149e0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1895,7 +1895,13 @@ static void gen_jc_probe(TCGTemp *pc, TCGTemp *cs_base, uint32_t flags)
     g_autoptr(TCGTemp) h = tcg_temp_new_ebb(TCG_TYPE_I64);
     g_autoptr(TCGTemp) p = tcg_temp_new_ebb(TCG_TYPE_PTR);
     TCGLabel *slow = gen_new_label();
-    uint64_t fpair;
+    /*
+     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
+     * and compare covers both.
+     */
+    uint64_t fpair = (HOST_BIG_ENDIAN
+                      ? deposit64(tb->cflags, 32, 32, flags)
+                      : deposit64(flags, 32, 32, tb->cflags));
 
     QEMU_BUILD_BUG_ON(sizeof_field(CPUJumpCache, array[0]) != 16);
     QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) % 8 != 0);
@@ -1911,37 +1917,40 @@ static void gen_jc_probe(TCGTemp *pc, TCGTemp *cs_base, uint32_t flags)
                offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
     tcg_gen_lea(TCG_TYPE_I64, p, t, h, 4, 0);
 
-    /*
-     * The pc first: on a hash miss it is the field most likely to differ,
-     * and an entry whose tb is NULL has a zero pc that only pc 0 matches.
-     */
-    tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(CPUJumpCache, array[0].pc));
-    tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, pc, slow);
+    if (tcg_op_supported(INDEX_op_goto_jc, TCG_TYPE_PTR, 0)) {
+        TCGOp *op = tcg_gen_op_tttti(INDEX_op_goto_jc, TCG_TYPE_PTR,
+                                     p, pc, cs_base,
+                                     tcg_constant_internal(TCG_TYPE_I64, fpair),
+                                     label_arg(slow));
+        add_as_label_use(slow, op);
+    } else {
+        /*
+         * The pc first: on a hash miss it is the field most likely
+         * to differ, and an entry whose tb is NULL has a zero pc
+         * that only pc 0 matches.
+         */
+        tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(CPUJumpCache, array[0].pc));
+        tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, pc, slow);
 
-    tcg_gen_ld(TCG_TYPE_PTR, p, p, offsetof(CPUJumpCache, array[0].tb));
-    tcg_gen_brcond(TCG_TYPE_PTR, TCG_COND_EQ,
-                   p, tcg_constant_internal(TCG_TYPE_PTR, 0), slow);
+        tcg_gen_ld(TCG_TYPE_PTR, p, p, offsetof(CPUJumpCache, array[0].tb));
+        tcg_gen_brcond(TCG_TYPE_PTR, TCG_COND_EQ,
+                       p, tcg_constant_internal(TCG_TYPE_PTR, 0), slow);
 
-    /*
-     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
-     * and compare covers both.
-     */
-    fpair = (HOST_BIG_ENDIAN
-             ? deposit64(tb->cflags, 32, 32, flags)
-             : deposit64(flags, 32, 32, tb->cflags));
-    tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, flags));
-    tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE,
-                   t, tcg_constant_internal(TCG_TYPE_I64, fpair), slow);
+        tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, flags));
+        tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE,
+                       t, tcg_constant_internal(TCG_TYPE_I64, fpair), slow);
 
-    /*
-     * cs_base is a second word of target-specific flags despite the name,
-     * and the pc alone does not imply it on a target that uses it.
-     */
-    tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, cs_base));
-    tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, cs_base, slow);
+        /*
+         * cs_base is a second word of target-specific flags despite
+         * the name, and the pc alone does not imply it on a target
+         * that uses it.
+         */
+        tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, cs_base));
+        tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, cs_base, slow);
 
-    tcg_gen_ld(TCG_TYPE_PTR, p, p, offsetof(TranslationBlock, tc.ptr));
-    gen_goto_ptr(p);
+        tcg_gen_ld(TCG_TYPE_PTR, p, p, offsetof(TranslationBlock, tc.ptr));
+        gen_goto_ptr(p);
+    }
 
     /*
      * Emit a second goto_ptr rather than branching to a shared one: a temp
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d19c3fb857..671cf8fd0e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1101,6 +1101,12 @@ typedef struct TCGOutOpLea {
                 TCGReg a2, unsigned sh, tcg_target_long imm);
 } TCGOutOpLea;
 
+typedef struct TCGOutOpGotoJC {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGReg jc, TCGReg pc, TCGArg cs, bool const_cs,
+                TCGArg fl, bool const_fl, TCGLabel *l);
+} TCGOutOpGotoJC;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -1190,6 +1196,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
     OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
+    OUTOP(INDEX_op_goto_jc, TCGOutOpGotoJC, outop_goto_jc),
     OUTOP(INDEX_op_ld, TCGOutOpLoad, outop_ld),
     OUTOP(INDEX_op_ld8s, TCGOutOpLoad, outop_ld8s),
     OUTOP(INDEX_op_ld8u, TCGOutOpLoad, outop_ld8u),
@@ -3013,6 +3020,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_set_label:
             case INDEX_op_br:
             case INDEX_op_brcond:
+            case INDEX_op_goto_jc:
                 col += ne_fprintf(f, "%s$L%d", k ? "," : "",
                                   arg_label(op->args[k])->id);
                 i++, k++;
@@ -3482,6 +3490,9 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     case INDEX_op_brcond:
         remove_label_use(op, 3);
         break;
+    case INDEX_op_goto_jc:
+        remove_label_use(op, 4);
+        break;
     default:
         break;
     }
@@ -3580,6 +3591,9 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
         case INDEX_op_brcond:
             op->args[3] = label_arg(to);
             break;
+        case INDEX_op_goto_jc:
+            op->args[4] = label_arg(to);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -3654,6 +3668,7 @@ reachable_code_pass(TCGContext *s)
         case INDEX_op_br:
         case INDEX_op_exit_tb:
         case INDEX_op_goto_ptr:
+        case INDEX_op_goto_jc:
             /* Unconditional branches; everything following is dead.  */
             dead = true;
             break;
@@ -5823,6 +5838,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         tcg_out_goto_ptr(s, new_args[0]);
         break;
 
+    case INDEX_op_goto_jc:
+        tcg_debug_assert(!const_args[0]);
+        tcg_debug_assert(!const_args[1]);
+        outop_goto_jc.out(s, new_args[0], new_args[1], new_args[2], const_args[2],
+                          new_args[3], const_args[3], arg_label(new_args[4]));
+        break;
+
     default:
         tcg_debug_assert(def->flags & TCG_OPF_VECTOR);
         tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 5c186156c0..1c3cf835e2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2008,6 +2008,10 @@ static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
     .out = tgen_qemu_st2,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 377cd9ec08..733cce516e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2113,6 +2113,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index 99f4469f4b..466ae836d5 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3637,6 +3637,10 @@ static const TCGOutOpLea outop_lea = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 6da52929a4..8c4ce59935 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2758,6 +2758,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index db3b2fc3c9..3b63383315 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3202,6 +3202,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index cb457453ff..0582dc8bdd 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -2124,6 +2124,10 @@ static const TCGOutOpLea outop_lea = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 6942fdbb4e..5d8892abc4 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1224,6 +1224,10 @@ static const TCGOutOpLea outop_lea = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 /* Test if a constant matches the constraint. */
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 3fca0693e2..04c83fbe6b 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3374,6 +3374,10 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static const TCGOutOpGotoJC outop_goto_jc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static int const umin_insn[4] = {
     OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
 };
-- 
2.53.0


