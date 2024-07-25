Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6D1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Lo-0007EB-Mg; Thu, 25 Jul 2024 19:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LS-0005tU-KF; Thu, 25 Jul 2024 19:58:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8LQ-0001Uk-3b; Thu, 25 Jul 2024 19:58:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d25b5b6b0so347328b3a.2; 
 Thu, 25 Jul 2024 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951878; x=1722556678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6NNf4u8aGBgUo+N3C/04sAy5MT6SljQKd+JhyyeJrg=;
 b=gUxWYI+WVUFHdrfdSCoHCNvWsbYW922im93DeWszpXli+HFL3c/9bWhMFX0z9nr6Qz
 CQjAXQbIbmc80wTnRfl3rU/TpH2bNKcobJuRADW8wlYgIv3OmlsvmiY8AZeE1eeSmkY7
 4FaH4Yt2VDzjX/GMEaSbHJyYc6pib2t8eo/ETXcVwPHIvJtNRLtYiDD3Vbo6PQbBlDj2
 2zlgAfV20g+ykVunAyu9+Z9rUOP6v0EaAsjtSJAnanfqXUAlRXD6ZGhmJGNXKxoMuqXD
 yftMev8MMGmX7cFGtfhTWzyTx2C9rQjgvhlJyRn5iySZF6etMPyoVBH7xnkThkNers5V
 tv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951878; x=1722556678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6NNf4u8aGBgUo+N3C/04sAy5MT6SljQKd+JhyyeJrg=;
 b=MtQJxqJAK8au16jC+0V1dJEC6fRmTX2BoaR2LerzXp8GgErJIQAuI2buDcnvKFqe3S
 31wpzPmvmKxPFulGe9nVLMq/X6rWnpd6lTJxsw3CUd+ANYNppjnUGFROUlvdJQw/S/IP
 nP2Q4z/+iqjq01MImVW7TPWBn1mtor8y31ce863z2YOxNf2rbA5Kq8ZsruF2VvXmtVvw
 QLMHw7/TftlGoXXMQvZfX5KdihGJAfYrP4dIvVMTSVleVctusP16RfaxFsi24W9y2+xO
 Lhz8RHunLSEpYcU3yVGiBbgjBpBqXeIdurMw0d5IMtVZrJbR5XeEqUsG4h4RuHj0ukt1
 mo4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuLfdvdO9irU1udwxt3HpKaUJBT/BENYc6JReppZg1xUn75+DfRFRjK5S0+tb8FQTiHQg+QhwgKcGDIvQxfvZefzcE
X-Gm-Message-State: AOJu0YxBPrZq4Kt/W64sUpFo+upRnIM2vd+n/e2nU/Y74GcDkco8ELLw
 2k1M9j9bqDiUPjjffed6AX1aOHSmlMP0Jxjhx0zr4bD7jcvwJkS97X4CQw==
X-Google-Smtp-Source: AGHT+IEN7igXr1p2xNuImy99aPjdavavdp812aIvj63QQuSinGkIbHnAM7zkNqgJXO9Ap3ifuL+Mww==
X-Received: by 2002:a05:6a21:3396:b0:1c0:f26e:2296 with SMTP id
 adf61e73a8af0-1c472c55c7emr5849839637.48.1721951877894; 
 Thu, 25 Jul 2024 16:57:57 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 59/96] target/ppc: Move VSX vector with length storage access
 insns to decodetree.
Date: Fri, 26 Jul 2024 09:53:32 +1000
Message-ID: <20240725235410.451624-60-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification :

        {l, st}xvl(l)           : X-form

The changes were verified by validating that the tcg-ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Also added a new function do_ea_calc_ra to calculate the effective address :
EA <- (RA == 0) ? 0 : GPR[RA], which is now used by the above-said insns,
and shall be used later by (p){lx, stx}vp insns.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
[np: Fix 32-bit build]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h                 |  8 +--
 target/ppc/insn32.decode            |  6 ++
 target/ppc/mem_helper.c             |  8 +--
 target/ppc/translate.c              | 17 ++++++
 target/ppc/translate/vsx-impl.c.inc | 94 ++++++++++++++++++++---------
 target/ppc/translate/vsx-ops.c.inc  |  8 ---
 6 files changed, 96 insertions(+), 45 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 13f20bb243..85be749004 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -277,10 +277,10 @@ DEF_HELPER_3(STVEBX, void, env, avr, tl)
 DEF_HELPER_3(STVEHX, void, env, avr, tl)
 DEF_HELPER_3(STVEWX, void, env, avr, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_4(lxvl, void, env, tl, vsr, tl)
-DEF_HELPER_4(lxvll, void, env, tl, vsr, tl)
-DEF_HELPER_4(stxvl, void, env, tl, vsr, tl)
-DEF_HELPER_4(stxvll, void, env, tl, vsr, tl)
+DEF_HELPER_4(LXVL, void, env, tl, vsr, tl)
+DEF_HELPER_4(LXVLL, void, env, tl, vsr, tl)
+DEF_HELPER_4(STXVL, void, env, tl, vsr, tl)
+DEF_HELPER_4(STXVLL, void, env, tl, vsr, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index f2661df918..e87b034159 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1006,6 +1006,12 @@ STXSIHX         011111 ..... ..... ..... 1110101101 .   @X_TSX
 STXSIWX         011111 ..... ..... ..... 0010001100 .   @X_TSX
 STXSSPX         011111 ..... ..... ..... 1010001100 .   @X_TSX
 
+LXVL            011111 ..... ..... ..... 0100001101 .   @X_TSX
+LXVLL           011111 ..... ..... ..... 0100101101 .   @X_TSX
+
+STXVL           011111 ..... ..... ..... 0110001101 .   @X_TSX
+STXVLL          011111 ..... ..... ..... 0110101101 .   @X_TSX
+
 ## VSX Vector Binary Floating-Point Sign Manipulation Instructions
 
 XVABSDP         111100 ..... 00000 ..... 111011001 ..   @XX2
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 953dd08d5d..51b137febd 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -475,8 +475,8 @@ void helper_##name(CPUPPCState *env, target_ulong addr,                 \
     *xt = t;                                                            \
 }
 
-VSX_LXVL(lxvl, 0)
-VSX_LXVL(lxvll, 1)
+VSX_LXVL(LXVL, 0)
+VSX_LXVL(LXVLL, 1)
 #undef VSX_LXVL
 
 #define VSX_STXVL(name, lj)                                       \
@@ -504,8 +504,8 @@ void helper_##name(CPUPPCState *env, target_ulong addr,           \
     }                                                             \
 }
 
-VSX_STXVL(stxvl, 0)
-VSX_STXVL(stxvll, 1)
+VSX_STXVL(STXVL, 0)
+VSX_STXVL(STXVLL, 1)
 #undef VSX_STXVL
 #undef GET_NB
 #endif /* TARGET_PPC64 */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index cba943a49d..46aabce82b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2543,6 +2543,7 @@ static inline void gen_align_no_le(DisasContext *ctx)
                       (ctx->opcode & 0x03FF0000) | POWERPC_EXCP_ALIGN_LE);
 }
 
+/* EA <- {(ra == 0) ? 0 : GPR[ra]} + displ */
 static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
 {
     TCGv ea = tcg_temp_new();
@@ -2557,6 +2558,22 @@ static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
     return ea;
 }
 
+#if defined(TARGET_PPC64)
+/* EA <- (ra == 0) ? 0 : GPR[ra] */
+static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
+{
+    TCGv EA = tcg_temp_new();
+    if (!ra) {
+        tcg_gen_movi_tl(EA, 0);
+    } else if (NARROW_MODE(ctx)) {
+        tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
+    } else {
+        tcg_gen_mov_tl(EA, cpu_gpr[ra]);
+    }
+    return EA;
+}
+#endif
+
 /***                             Integer load                              ***/
 #define DEF_MEMOP(op) ((op) | ctx->default_tcg_memop_mask)
 #define BSWAP_MEMOP(op) ((op) | (ctx->default_tcg_memop_mask ^ MO_BSWAP))
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index de2a26a213..46bab49215 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -232,36 +232,72 @@ static void gen_lxvb16x(DisasContext *ctx)
     set_cpu_vsr(xT(ctx->opcode), xtl, false);
 }
 
-#ifdef TARGET_PPC64
-#define VSX_VECTOR_LOAD_STORE_LENGTH(name)                         \
-static void gen_##name(DisasContext *ctx)                          \
-{                                                                  \
-    TCGv EA;                                                       \
-    TCGv_ptr xt;                                                   \
-                                                                   \
-    if (xT(ctx->opcode) < 32) {                                    \
-        if (unlikely(!ctx->vsx_enabled)) {                         \
-            gen_exception(ctx, POWERPC_EXCP_VSXU);                 \
-            return;                                                \
-        }                                                          \
-    } else {                                                       \
-        if (unlikely(!ctx->altivec_enabled)) {                     \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                  \
-            return;                                                \
-        }                                                          \
-    }                                                              \
-    EA = tcg_temp_new();                                           \
-    xt = gen_vsr_ptr(xT(ctx->opcode));                             \
-    gen_set_access_type(ctx, ACCESS_INT);                          \
-    gen_addr_register(ctx, EA);                                    \
-    gen_helper_##name(tcg_env, EA, xt, cpu_gpr[rB(ctx->opcode)]);  \
-}
-
-VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
-VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
-VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
-VSX_VECTOR_LOAD_STORE_LENGTH(stxvll)
+#if defined(TARGET_PPC64)
+static bool do_ld_st_vl(DisasContext *ctx, arg_X *a,
+                        void (*helper)(TCGv_ptr, TCGv, TCGv_ptr, TCGv))
+{
+    TCGv EA;
+    TCGv_ptr xt;
+    if (a->rt < 32) {
+        REQUIRE_VSX(ctx);
+    } else {
+        REQUIRE_VECTOR(ctx);
+    }
+    xt = gen_vsr_ptr(a->rt);
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc_ra(ctx, a->ra);
+    helper(tcg_env, EA, xt, cpu_gpr[a->rb]);
+    return true;
+}
+#endif
+
+static bool trans_LXVL(DisasContext *ctx, arg_LXVL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_LXVL);
+#else
+    qemu_build_not_reached();
 #endif
+    return true;
+}
+
+static bool trans_LXVLL(DisasContext *ctx, arg_LXVLL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_LXVLL);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STXVL(DisasContext *ctx, arg_STXVL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_STXVL);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STXVLL(DisasContext *ctx, arg_STXVLL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_STXVLL);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
 
 static bool do_stxs(DisasContext *ctx, arg_X *a,
                     void (*op)(DisasContext *, TCGv_i64, TCGv))
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index d44cb55836..7f4326c974 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -4,19 +4,11 @@ GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxvll, 0x1F, 0x0D, 0x09, 0, PPC_NONE, PPC2_ISA300),
-#endif
 
 GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(stxvl, 0x1F, 0x0D, 0x0C, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stxvll, 0x1F, 0x0D, 0x0D, 0, PPC_NONE, PPC2_ISA300),
-#endif
 
 GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX207),
-- 
2.45.2


