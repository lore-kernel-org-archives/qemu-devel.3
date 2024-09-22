Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A1ACF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLI8-0003Vx-FY; Sun, 22 Sep 2024 08:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0000x5-UO
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHL-0002Ow-IZ
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:30 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8a789c4fc5so757466066b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006486; x=1727611286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nf2KKD8gpkfqLcprZUwSXAhZF2kW47U2PBUtTXC4uSQ=;
 b=JTqqg2XkgWDGpSgv+3Rcx2QikqSdNlbbtO+ceZq5vOly/Wp+QPz2yhd8FmtnvLx7ge
 K14SJsZrDfmv9IL+sOexpNL0SB7g9jStJ9radWLbYxpLGuCyxUNZ786iWnHV2+uWnONu
 5iV43NIieB3hPyJdt6pLIkxXO7NqCgn5p+XR42/pg4MU6VqYip481SlUVzlGRV/7vcuN
 wN4Y025ekQ4sQWA+/oHb++/1++4Rasq5wdyKBqlsFWnurP+o8COlvRbVlYw8g5k8Rwqd
 tT5KL1u6iRrt3+foyvLlvk5ePyzo1d/4jMon0znLjwz88z5SBd7FR3G3pVdHzjG9z4V4
 Ku3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006486; x=1727611286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nf2KKD8gpkfqLcprZUwSXAhZF2kW47U2PBUtTXC4uSQ=;
 b=Zg95Gjgj+15ek5ZMKQnGe2dL0qlGU2G3aoimAri83i7MrZZZmSsOy8lJP+7ZkPNNQ7
 gVT22wXM1t4irH0qzqclsAL5P/isjfSc4ubI4zxYRgDn9HmM+qCWVDYSQz6cyxUoMfg2
 kJeJWl5QebuF8YSMeNKkVDRXUTF8TLAgMYbEeE0GvWBYnAPtPiVuIyJFvsq7pAJbqUtK
 /99wizR4nnLwHZpW4oLyHIUIKirjGukR0UgIeVcuek4WWL4OtZ3WJW8vdCOpc779xKSf
 g0AhWcTfE623mpd/NC7FlqzVtKoTf9UHZ8DZlN5DDLr0WsuFumIg6+dycu0TwVyrPfDb
 rGtw==
X-Gm-Message-State: AOJu0YwXj/4+LBvgClZ6vrQYJivAwuRkoSEkJGh4Fo0jgCrBW5bzGvFl
 Ni0LL9ZUPIfT+yv4Cs2kdpcGxQgzvUghYghqpWfpl64PfsxLPLGBQBz9+ncnLMDW7p1FNlRtFSG
 Pe8s=
X-Google-Smtp-Source: AGHT+IGurQixq/GTnnOHE85suiegFp2TuDiYOHA1f4mf7TLXs1aG5R3Bt4nrBALEV58Iv/Hg0W388A==
X-Received: by 2002:a17:907:3ea8:b0:a8d:2281:94d9 with SMTP id
 a640c23a62f3a-a90c1d6f9c0mr1456859866b.23.1727006486091; 
 Sun, 22 Sep 2024 05:01:26 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 21/31] tcg/s390x: Optimize cmpsel with constant 0/-1 arguments
Date: Sun, 22 Sep 2024 14:01:02 +0200
Message-ID: <20240922120112.5067-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

These can be simplified to and/or/andc/orc,
avoiding the load of the constantinto a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  3 ++-
 tcg/s390x/tcg-target-con-str.h |  1 +
 tcg/s390x/tcg-target.c.inc     | 40 ++++++++++++++++++++++++++--------
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 670089086d..370e4b1295 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -38,7 +38,8 @@ C_O1_I2(r, rZ, r)
 C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
-C_O1_I4(v, v, v, v, v)
+C_O1_I4(v, v, v, vZ, v)
+C_O1_I4(v, v, v, vZM, v)
 C_O1_I4(r, r, ri, rI, r)
 C_O1_I4(r, r, rC, rI, r)
 C_O2_I1(o, m, r)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 745f6c0df5..3e574e0662 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -20,6 +20,7 @@ CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('J', TCG_CT_CONST_S32)
 CONST('K', TCG_CT_CONST_P32)
+CONST('M', TCG_CT_CONST_M1)
 CONST('N', TCG_CT_CONST_INV)
 CONST('R', TCG_CT_CONST_INVRISBG)
 CONST('U', TCG_CT_CONST_U32)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e044168826..a5d57197a4 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -36,6 +36,7 @@
 #define TCG_CT_CONST_INV        (1 << 13)
 #define TCG_CT_CONST_INVRISBG   (1 << 14)
 #define TCG_CT_CONST_CMP        (1 << 15)
+#define TCG_CT_CONST_M1         (1 << 16)
 
 #define ALL_GENERAL_REGS     MAKE_64BIT_MASK(0, 16)
 #define ALL_VECTOR_REGS      MAKE_64BIT_MASK(32, 32)
@@ -607,6 +608,9 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
         return true;
     }
+    if ((ct & TCG_CT_CONST_M1) && val == -1) {
+        return true;
+    }
 
     if (ct & TCG_CT_CONST_INV) {
         val = ~val;
@@ -2904,15 +2908,30 @@ static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
 }
 
 static void tcg_out_cmpsel_vec(TCGContext *s, unsigned vece, TCGReg a0,
-                               TCGReg c1, TCGReg c2,
-                               TCGReg v3, TCGReg v4, TCGCond cond)
+                               TCGReg c1, TCGReg c2, TCGArg v3,
+                               int const_v3, TCGReg v4, TCGCond cond)
 {
-    if (tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP0, c1, c2, cond)) {
-        TCGReg swap = v3;
-        v3 = v4;
-        v4 = swap;
+    bool inv = tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP0, c1, c2, cond);
+
+    if (!const_v3) {
+        if (inv) {
+            tcg_out_insn(s, VRRe, VSEL, a0, v4, v3, TCG_VEC_TMP0);
+        } else {
+            tcg_out_insn(s, VRRe, VSEL, a0, v3, v4, TCG_VEC_TMP0);
+        }
+    } else if (v3) {
+        if (inv) {
+            tcg_out_insn(s, VRRc, VOC, a0, v4, TCG_VEC_TMP0, 0);
+        } else {
+            tcg_out_insn(s, VRRc, VO, a0, v4, TCG_VEC_TMP0, 0);
+        }
+    } else {
+        if (inv) {
+            tcg_out_insn(s, VRRc, VN, a0, v4, TCG_VEC_TMP0, 0);
+        } else {
+            tcg_out_insn(s, VRRc, VNC, a0, v4, TCG_VEC_TMP0, 0);
+        }
     }
-    tcg_out_insn(s, VRRe, VSEL, a0, v3, v4, TCG_VEC_TMP0);
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -3036,7 +3055,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
         break;
     case INDEX_op_cmpsel_vec:
-        tcg_out_cmpsel_vec(s, vece, a0, a1, a2, args[3], args[4], args[5]);
+        tcg_out_cmpsel_vec(s, vece, a0, a1, a2, args[3], const_args[3],
+                           args[4], args[5]);
         break;
 
     case INDEX_op_s390_vuph_vec:
@@ -3388,7 +3408,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
         return C_O1_I3(v, v, v, v);
     case INDEX_op_cmpsel_vec:
-        return C_O1_I4(v, v, v, v, v);
+        return (TCG_TARGET_HAS_orc_vec
+                ? C_O1_I4(v, v, v, vZM, v)
+                : C_O1_I4(v, v, v, vZ, v));
 
     default:
         g_assert_not_reached();
-- 
2.43.0


