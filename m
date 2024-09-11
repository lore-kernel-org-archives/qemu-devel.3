Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CFFEE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYT-00023z-Ul; Wed, 11 Sep 2024 12:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYS-0001ys-Dt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYQ-0003ee-Fx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso5116391b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073453; x=1726678253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/08vmd3pJmcPxGI9Dvd5g1DO6IpTA5tvF/u1ewyB0/g=;
 b=WRCrZvKoSYjDJnX3rABfvN7EJZExFB2uFGCgDuPIK21utUCYXVo0LURGvbKoLdTfaL
 NBLKP5+IMJ8C8h2dPGf5t9sEl6tUu4dtOVoU93hMcN5ur1BRFk+6UOyR6Re87vDZP2Vd
 VjuSaxabRO2USN1ip6TfLU1YuscGhbms5Wykfed4e/PLq+WMv8s3Y+Gc9Svpy3e5MSeQ
 In94KYTEdnN2E5ByGG+N+8888vfJLPQiU66V9ASqkNNeCGm8TK5vfiGOXo4maKrZF4E3
 dn/37xxuchnecQN881wlOhpA8NYWmqn+JnjytO4oHwycFx0LRL6BmKKV+8jcG7j6ZUOx
 k08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073453; x=1726678253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/08vmd3pJmcPxGI9Dvd5g1DO6IpTA5tvF/u1ewyB0/g=;
 b=pQcydhFcu5V0ofYoWny9/Y5QlZ4xCMekSTENTqJxKpyUQYOv3S6cIWN+dLdWk+jH/k
 kyBex1TYHzxKXXVE/io+67Jv6Bz5jr50MvYCmdV0efLP6mX6IoWvgowQsBJdyrGGuTNR
 qP02bbzcssLlC07QwH5Y4EJiq0vM3EiExNEI9XaPphBlj3VJjOUuqdQsP9mLO6itL9Hf
 nQ7oL+1iLkAwuRNH0wBH3tyCqIYKueToKMVrljzipd85IqvQEdKcP2CXM2cEANczkqdn
 WPxHQNLX2jsToPYEL5SE0oE7C3bUPlWMaC4PVoH/0NEtO3jReuPrFAc4YgRbKThquV/u
 kfZw==
X-Gm-Message-State: AOJu0Yw4Z2B2vY3zaY2g0I9mU1fjvhoeaxnK8fCy4ysfFxrm9rCto+jN
 8VHQQBTEq6i0iEnllubqLS9UdsHoyJHMAS9ZzxtUVLncp4DP4Gr4oIXCcV981Dz6DXBvE0w2wgm
 S
X-Google-Smtp-Source: AGHT+IEq0YMhjDuQJVwM+fn0GQGP+zOOtYW9EVYQUYe7/8O7hSViZUsE3Ei43Tt7tPlQEhd0RrPA1Q==
X-Received: by 2002:a05:6a20:cd0e:b0:1cf:3a2c:e3fe with SMTP id
 adf61e73a8af0-1cf5e199538mr7264012637.32.1726073452805; 
 Wed, 11 Sep 2024 09:50:52 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 04/18] tcg/i386: Do not expand cmpsel_vec early
Date: Wed, 11 Sep 2024 09:50:33 -0700
Message-ID: <20240911165047.1035764-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Expand during output instead of during opcode generation.
Remove x86_vpblendvb_vec opcode, this this removes the only user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  1 +
 tcg/i386/tcg-target.h         |  2 +-
 tcg/i386/tcg-target.opc.h     |  1 -
 tcg/i386/tcg-target.c.inc     | 84 +++++++++++++++++++++--------------
 4 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index e24241cfa2..da4411d96b 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -50,6 +50,7 @@ C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
 C_O1_I3(x, 0, x, x)
 C_O1_I3(x, x, x, x)
+C_O1_I4(x, x, x, x, x)
 C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2f67a97e05..342be30c4c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -223,7 +223,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       have_avx512vl
-#define TCG_TARGET_HAS_cmpsel_vec       -1
+#define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index b5f403e35e..4ffc084bda 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -25,7 +25,6 @@
  */
 
 DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
 DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
 DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 278e567b56..a04dc7d270 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3115,6 +3115,19 @@ static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
     }
 }
 
+static void tcg_out_cmpsel_vec(TCGContext *s, TCGType type, unsigned vece,
+                               TCGReg v0, TCGReg c1, TCGReg c2,
+                               TCGReg v3, TCGReg v4, TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond)) {
+        TCGReg swap = v3;
+        v3 = v4;
+        v4 = swap;
+    }
+    tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, v0, v4, v3, type);
+    tcg_out8(s, (TCG_TMP_VEC - TCG_REG_XMM0) << 4);
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3320,6 +3333,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_cmp_vec(s, type, vece, a0, a1, a2, args[3]);
         break;
 
+    case INDEX_op_cmpsel_vec:
+        tcg_out_cmpsel_vec(s, type, vece, a0, a1, a2,
+                           args[3], args[4], args[5]);
+        break;
+
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
         tcg_out_vex_modrm_type(s, insn, a0, a2, a1, type);
@@ -3431,11 +3449,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out8(s, sub);
         break;
 
-    case INDEX_op_x86_vpblendvb_vec:
-        tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, a0, a1, a2, type);
-        tcg_out8(s, args[3] << 4);
-        break;
-
     case INDEX_op_x86_psrldq_vec:
         tcg_out_vex_modrm(s, OPC_GRP14, 3, a0, a1);
         tcg_out8(s, a2);
@@ -3701,8 +3714,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I3(x, 0, x, x);
 
     case INDEX_op_bitsel_vec:
-    case INDEX_op_x86_vpblendvb_vec:
         return C_O1_I3(x, x, x, x);
+    case INDEX_op_cmpsel_vec:
+        return C_O1_I4(x, x, x, x, x);
 
     default:
         g_assert_not_reached();
@@ -4038,8 +4052,8 @@ static void expand_vec_mul(TCGType type, unsigned vece,
     }
 }
 
-static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
-                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+static TCGCond expand_vec_cond(TCGType type, unsigned vece,
+                               TCGArg *a1, TCGArg *a2, TCGCond cond)
 {
     /*
      * Without AVX512, there are no 64-bit unsigned comparisons.
@@ -4047,46 +4061,50 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
      * All other swapping and inversion are handled during code generation.
      */
     if (vece == MO_64 && is_unsigned_cond(cond)) {
+        TCGv_vec v1 = temp_tcgv_vec(arg_temp(*a1));
+        TCGv_vec v2 = temp_tcgv_vec(arg_temp(*a2));
         TCGv_vec t1 = tcg_temp_new_vec(type);
         TCGv_vec t2 = tcg_temp_new_vec(type);
         TCGv_vec t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
 
         tcg_gen_sub_vec(vece, t1, v1, t3);
         tcg_gen_sub_vec(vece, t2, v2, t3);
-        v1 = t1;
-        v2 = t2;
+        *a1 = tcgv_vec_arg(t1);
+        *a2 = tcgv_vec_arg(t2);
         cond = tcg_signed_cond(cond);
     }
-
-    /* Expand directly; do not recurse.  */
-    vec_gen_4(INDEX_op_cmp_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
+    return cond;
 }
 
-static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
-                              TCGv_vec c1, TCGv_vec c2,
-                              TCGv_vec v3, TCGv_vec v4, TCGCond cond)
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGArg a0,
+                           TCGArg a1, TCGArg a2, TCGCond cond)
 {
-    TCGv_vec t = tcg_temp_new_vec(type);
+    cond = expand_vec_cond(type, vece, &a1, &a2, cond);
+    /* Expand directly; do not recurse.  */
+    vec_gen_4(INDEX_op_cmp_vec, type, vece, a0, a1, a2, cond);
+}
 
-    expand_vec_cmp(type, vece, t, c1, c2, cond);
-    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v4),
-              tcgv_vec_arg(v3), tcgv_vec_arg(t));
-    tcg_temp_free_vec(t);
+static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGArg a0,
+                              TCGArg a1, TCGArg a2,
+                              TCGArg a3, TCGArg a4, TCGCond cond)
+{
+    cond = expand_vec_cond(type, vece, &a1, &a2, cond);
+    /* Expand directly; do not recurse.  */
+    vec_gen_6(INDEX_op_cmpsel_vec, type, vece, a0, a1, a2, a3, a4, cond);
 }
 
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGArg a2;
-    TCGv_vec v0, v1, v2, v3, v4;
+    TCGArg a1, a2, a3, a4, a5;
+    TCGv_vec v0, v1, v2;
 
     va_start(va, a0);
-    v0 = temp_tcgv_vec(arg_temp(a0));
-    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a1 = va_arg(va, TCGArg);
     a2 = va_arg(va, TCGArg);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(a1));
 
     switch (opc) {
     case INDEX_op_shli_vec:
@@ -4122,15 +4140,15 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         break;
 
     case INDEX_op_cmp_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
+        a3 = va_arg(va, TCGArg);
+        expand_vec_cmp(type, vece, a0, a1, a2, a3);
         break;
 
     case INDEX_op_cmpsel_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        v3 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-        v4 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-        expand_vec_cmpsel(type, vece, v0, v1, v2, v3, v4, va_arg(va, TCGArg));
+        a3 = va_arg(va, TCGArg);
+        a4 = va_arg(va, TCGArg);
+        a5 = va_arg(va, TCGArg);
+        expand_vec_cmpsel(type, vece, a0, a1, a2, a3, a4, a5);
         break;
 
     default:
-- 
2.43.0


