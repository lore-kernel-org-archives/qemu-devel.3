Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F1DECE579
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dT-000385-4d; Sat, 07 Sep 2024 22:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dS-000336-2T
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:42 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dQ-00050H-2Y
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:41 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5e1ba0adcb0so774233eaf.0
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762399; x=1726367199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnL0glGXZj+IRh5HnNxFKu2Xl8Anqsqr5rwYjln/1tc=;
 b=wRVqPGNNH3MLA2v/gqeS8f8a7o6/MVlTOr53oTtsAn3Fqy4eQhLDnOOLSiVpAcGI3E
 hJuVfTTqaBof9otJhy2/rxRKCeXOiPjpSl9aXZKW4E1RidDRbPtcoEyxFG5Nb1r51Jo5
 vl+3raX6dwUYQ64iwMO19W4UTzuIAbSVmWq5SS/FUSBmrn1GVjdJXm6utaHDIt+iIb4i
 s5dRIecZ0POt6NSZHEKaXiy3cmcD/8fnOgqXVvpnBrTkXucfQuyly+X1iOOLkLHqsJbU
 m9CVVcIWvNLPy1exxcQOBn4nvYoiC9h551q5aaFAQ95clt/BhlYND+McBe52MC0dxE4z
 2YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762399; x=1726367199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnL0glGXZj+IRh5HnNxFKu2Xl8Anqsqr5rwYjln/1tc=;
 b=fgLX0OjFGnD7lR3xltoh9KVX4WNJHfWSrG8S+3FAslqY2F29YiihJ3yNQ0v7kxeNTA
 7yTjSX3D2rBV9R6tVXIIN67qadHYh7SH4xryVcDwHZVkOlfls7Pdq/sZ2VeeGYxG4o0t
 dB8UbyhqgxUEndWP7D2F/UZdPYz3cKDQ/GCYs0OhvACeyJzmLjwi+zCgkYJPSFyYvhU6
 Fzx0W/MDAkeRI4h9E+u7iNXymCgIw80rwzy0DkqLyfs+RCkkUBA4M4dRCRt5NPBi99zW
 CNX735M47iGSL1VuVHq2kEwL5ot6mHsY0xSyXnT39byoFHuHhj0fb99az7gA+7+W6QGV
 GziQ==
X-Gm-Message-State: AOJu0YyvWAcy6IURDdGw2Jp4ICPxa9gkSN1bg7UobAwftNhoKeEcyZH/
 ai8qbmxRWEmBXy2ke1LYJBg/cE0zdlrf+T04/Srm99libieQUlR/CjQjs2ytuQMmjysd/UUyhrr
 U
X-Google-Smtp-Source: AGHT+IHeNcIoPywnqaqhHmHeaHsiVVIhW4r9rLYGnu8/a1VV5I8a5Ri1lRYJwNP3z3rIEEkLwQHKew==
X-Received: by 2002:a05:6830:90e:b0:70f:36ff:ed09 with SMTP id
 46e09a7af769-710cc26e87emr8453710a34.28.1725762398510; 
 Sat, 07 Sep 2024 19:26:38 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 04/12] tcg/i386: Do not expand cmp_vec early
Date: Sat,  7 Sep 2024 19:26:24 -0700
Message-ID: <20240908022632.459477-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Move most of expansion to opcode generation, leaving the
conversion of unsigned to signed to be done in the early phase.
Small inefficiencies, but not incorrect results, are introduced
until cmpsel_vec is converted in the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 223 +++++++++++++++++---------------------
 1 file changed, 100 insertions(+), 123 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index af71a397b1..278e567b56 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3029,6 +3029,92 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #undef OP_32_64
 }
 
+static int const umin_insn[4] = {
+    OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
+};
+
+static int const umax_insn[4] = {
+    OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_VPMAXUQ
+};
+
+static bool tcg_out_cmp_vec_noinv(TCGContext *s, TCGType type, unsigned vece,
+                                  TCGReg v0, TCGReg v1, TCGReg v2, TCGCond cond)
+{
+    static int const cmpeq_insn[4] = {
+        OPC_PCMPEQB, OPC_PCMPEQW, OPC_PCMPEQD, OPC_PCMPEQQ
+    };
+    static int const cmpgt_insn[4] = {
+        OPC_PCMPGTB, OPC_PCMPGTW, OPC_PCMPGTD, OPC_PCMPGTQ
+    };
+
+    enum {
+        NEED_INV  = 1,
+        NEED_SWAP = 2,
+        NEED_UMIN = 4,
+        NEED_UMAX = 8,
+        INVALID   = 16,
+    };
+    static const uint8_t cond_fixup[16] = {
+        [0 ... 15] = INVALID,
+        [TCG_COND_EQ] = 0,
+        [TCG_COND_GT] = 0,
+        [TCG_COND_NE] = NEED_INV,
+        [TCG_COND_LE] = NEED_INV,
+        [TCG_COND_LT] = NEED_SWAP,
+        [TCG_COND_GE] = NEED_SWAP | NEED_INV,
+        [TCG_COND_LEU] = NEED_UMIN,
+        [TCG_COND_GTU] = NEED_UMIN | NEED_INV,
+        [TCG_COND_GEU] = NEED_UMAX,
+        [TCG_COND_LTU] = NEED_UMAX | NEED_INV,
+    };
+    int fixup = cond_fixup[cond];
+
+    assert(!(fixup & INVALID));
+
+    if (fixup & NEED_INV) {
+        cond = tcg_invert_cond(cond);
+    }
+
+    if (fixup & NEED_SWAP) {
+        TCGReg swap = v1;
+        v1 = v2;
+        v2 = swap;
+        cond = tcg_swap_cond(cond);
+    }
+
+    if (fixup & (NEED_UMIN | NEED_UMAX)) {
+        int op = (fixup & NEED_UMIN ? umin_insn[vece] : umax_insn[vece]);
+
+        /* avx2 does not have 64-bit min/max; adjusted during expand. */
+        assert(vece <= MO_32);
+
+        tcg_out_vex_modrm_type(s, op, TCG_TMP_VEC, v1, v2, type);
+        v2 = TCG_TMP_VEC;
+        cond = TCG_COND_EQ;
+    }
+
+    switch (cond) {
+    case TCG_COND_EQ:
+        tcg_out_vex_modrm_type(s, cmpeq_insn[vece], v0, v1, v2, type);
+        break;
+    case TCG_COND_GT:
+        tcg_out_vex_modrm_type(s, cmpgt_insn[vece], v0, v1, v2, type);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return fixup & NEED_INV;
+}
+
+static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg v0, TCGReg v1, TCGReg v2, TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, type, vece, v0, v1, v2, cond)) {
+        tcg_out_dupi_vec(s, type, vece, TCG_TMP_VEC, -1);
+        tcg_out_vex_modrm_type(s, OPC_PXOR, v0, v0, TCG_TMP_VEC, type);
+    }
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3058,12 +3144,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const shift_imm_insn[4] = {
         OPC_UD2, OPC_PSHIFTW_Ib, OPC_PSHIFTD_Ib, OPC_PSHIFTQ_Ib
     };
-    static int const cmpeq_insn[4] = {
-        OPC_PCMPEQB, OPC_PCMPEQW, OPC_PCMPEQD, OPC_PCMPEQQ
-    };
-    static int const cmpgt_insn[4] = {
-        OPC_PCMPGTB, OPC_PCMPGTW, OPC_PCMPGTD, OPC_PCMPGTQ
-    };
     static int const punpckl_insn[4] = {
         OPC_PUNPCKLBW, OPC_PUNPCKLWD, OPC_PUNPCKLDQ, OPC_PUNPCKLQDQ
     };
@@ -3082,12 +3162,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const smax_insn[4] = {
         OPC_PMAXSB, OPC_PMAXSW, OPC_PMAXSD, OPC_VPMAXSQ
     };
-    static int const umin_insn[4] = {
-        OPC_PMINUB, OPC_PMINUW, OPC_PMINUD, OPC_VPMINUQ
-    };
-    static int const umax_insn[4] = {
-        OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_VPMAXUQ
-    };
     static int const rotlv_insn[4] = {
         OPC_UD2, OPC_UD2, OPC_VPROLVD, OPC_VPROLVQ
     };
@@ -3243,15 +3317,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_cmp_vec:
-        sub = args[3];
-        if (sub == TCG_COND_EQ) {
-            insn = cmpeq_insn[vece];
-        } else if (sub == TCG_COND_GT) {
-            insn = cmpgt_insn[vece];
-        } else {
-            g_assert_not_reached();
-        }
-        goto gen_simd;
+        tcg_out_cmp_vec(s, type, vece, a0, a1, a2, args[3]);
+        break;
 
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
@@ -3971,88 +4038,19 @@ static void expand_vec_mul(TCGType type, unsigned vece,
     }
 }
 
-static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
-                                 TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
 {
-    enum {
-        NEED_INV  = 1,
-        NEED_SWAP = 2,
-        NEED_BIAS = 4,
-        NEED_UMIN = 8,
-        NEED_UMAX = 16,
-    };
-    TCGv_vec t1, t2, t3;
-    uint8_t fixup;
+    /*
+     * Without AVX512, there are no 64-bit unsigned comparisons.
+     * We must bias the inputs so that they become signed.
+     * All other swapping and inversion are handled during code generation.
+     */
+    if (vece == MO_64 && is_unsigned_cond(cond)) {
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
+        TCGv_vec t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
 
-    switch (cond) {
-    case TCG_COND_EQ:
-    case TCG_COND_GT:
-        fixup = 0;
-        break;
-    case TCG_COND_NE:
-    case TCG_COND_LE:
-        fixup = NEED_INV;
-        break;
-    case TCG_COND_LT:
-        fixup = NEED_SWAP;
-        break;
-    case TCG_COND_GE:
-        fixup = NEED_SWAP | NEED_INV;
-        break;
-    case TCG_COND_LEU:
-        if (tcg_can_emit_vec_op(INDEX_op_umin_vec, type, vece)) {
-            fixup = NEED_UMIN;
-        } else {
-            fixup = NEED_BIAS | NEED_INV;
-        }
-        break;
-    case TCG_COND_GTU:
-        if (tcg_can_emit_vec_op(INDEX_op_umin_vec, type, vece)) {
-            fixup = NEED_UMIN | NEED_INV;
-        } else {
-            fixup = NEED_BIAS;
-        }
-        break;
-    case TCG_COND_GEU:
-        if (tcg_can_emit_vec_op(INDEX_op_umax_vec, type, vece)) {
-            fixup = NEED_UMAX;
-        } else {
-            fixup = NEED_BIAS | NEED_SWAP | NEED_INV;
-        }
-        break;
-    case TCG_COND_LTU:
-        if (tcg_can_emit_vec_op(INDEX_op_umax_vec, type, vece)) {
-            fixup = NEED_UMAX | NEED_INV;
-        } else {
-            fixup = NEED_BIAS | NEED_SWAP;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (fixup & NEED_INV) {
-        cond = tcg_invert_cond(cond);
-    }
-    if (fixup & NEED_SWAP) {
-        t1 = v1, v1 = v2, v2 = t1;
-        cond = tcg_swap_cond(cond);
-    }
-
-    t1 = t2 = NULL;
-    if (fixup & (NEED_UMIN | NEED_UMAX)) {
-        t1 = tcg_temp_new_vec(type);
-        if (fixup & NEED_UMIN) {
-            tcg_gen_umin_vec(vece, t1, v1, v2);
-        } else {
-            tcg_gen_umax_vec(vece, t1, v1, v2);
-        }
-        v2 = t1;
-        cond = TCG_COND_EQ;
-    } else if (fixup & NEED_BIAS) {
-        t1 = tcg_temp_new_vec(type);
-        t2 = tcg_temp_new_vec(type);
-        t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
         tcg_gen_sub_vec(vece, t1, v1, t3);
         tcg_gen_sub_vec(vece, t2, v2, t3);
         v1 = t1;
@@ -4060,26 +4058,9 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
         cond = tcg_signed_cond(cond);
     }
 
-    tcg_debug_assert(cond == TCG_COND_EQ || cond == TCG_COND_GT);
     /* Expand directly; do not recurse.  */
     vec_gen_4(INDEX_op_cmp_vec, type, vece,
               tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
-
-    if (t1) {
-        tcg_temp_free_vec(t1);
-        if (t2) {
-            tcg_temp_free_vec(t2);
-        }
-    }
-    return fixup & NEED_INV;
-}
-
-static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
-                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
-{
-    if (expand_vec_cmp_noinv(type, vece, v0, v1, v2, cond)) {
-        tcg_gen_not_vec(vece, v0, v0);
-    }
 }
 
 static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
@@ -4088,11 +4069,7 @@ static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
 {
     TCGv_vec t = tcg_temp_new_vec(type);
 
-    if (expand_vec_cmp_noinv(type, vece, t, c1, c2, cond)) {
-        /* Invert the sense of the compare by swapping arguments.  */
-        TCGv_vec x;
-        x = v3, v3 = v4, v4 = x;
-    }
+    expand_vec_cmp(type, vece, t, c1, c2, cond);
     vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
               tcgv_vec_arg(v0), tcgv_vec_arg(v4),
               tcgv_vec_arg(v3), tcgv_vec_arg(t));
-- 
2.43.0


