Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4485EEE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYw-0003lo-2n; Wed, 11 Sep 2024 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYf-0002nB-B4
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:10 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYd-0003hS-9x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-717934728adso5173278b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073466; x=1726678266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nf2KKD8gpkfqLcprZUwSXAhZF2kW47U2PBUtTXC4uSQ=;
 b=xa8rkY1XmNjHsqmS+m3G3AzgZ5EatdbBlQe3gtSqGvfVD/Fz9UrfdmE/b6dqDFSYSp
 iLlLuGvy0BDC+azWKALjXdol510ZJaIl3/SUnJDDl3qzSWHH1IVqqnKKrZ8h8b5RaVZj
 uf2wBZNPD+ZkUYFDycNcawa/RQp12Z5bexDGxztIjaFhX/AXyrmavEddJpTdQMPj5fll
 1UIEa8OS6N144KG0NrAwCaGL2grO6lE5J9vWImJT44XJmoKwRrCUpJX/YTXnDLQoVtQd
 yZ8PZy7XFB5J4nSiJazJnx0+3XCEBtgGug92mZHuF2cWdbAgW7Z4IUXQZr31RHf/6qcM
 aJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073466; x=1726678266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nf2KKD8gpkfqLcprZUwSXAhZF2kW47U2PBUtTXC4uSQ=;
 b=p9IQj/UcDt69eHtzfhR0uSkVeQU2hAYf0xGFVBZkydKovdyEdkGZ1Tq+/Uc2+8V9eC
 h3PZl9ahdSccyaoeBw1f2AOF1rMPNfgnafMULLJFWf4bnv+PEMNum6LeG9eMZlOzYQOQ
 5wWe2KitngVl5mtRX3hTyeS7b+3obwXf0XCgk8igTvUEhuXR3njYhJkX/QXnhvufVqhx
 l1OkefFxl6jwbYietk9607/+tmU4yHdbu1XEbNYbz9iB3/RfGSHxZUGhLHrEK2v8Xa2T
 izgDqgkZZBVcTmDzvHt4D7Eq4XCdTGwXjlsTnkNII9NjahNbGItN+zsdfkwKSGqWbJ3u
 mgKw==
X-Gm-Message-State: AOJu0YxKgVEBcNP+f5CpxoHWA3BlYHa6MzQ4XifpgpdmfKIq8xvVNdb1
 zhNTV0zHQhou4F+KBxg6Oh5IxT76UnUMdB+/PvqyG0SOnKBBvP5K4cSboAueYrjith9WpFypz8o
 o
X-Google-Smtp-Source: AGHT+IFIRcxULGhFCZ/bAMuVohDntJldVrf8vHcuIW0wOXvPxgS9clUSNomZyvj4OVeQCrVKatyYXg==
X-Received: by 2002:a05:6a00:4f90:b0:717:97ac:ef46 with SMTP id
 d2e1a72fcca58-7192609615amr16010b3a.15.1726073465714; 
 Wed, 11 Sep 2024 09:51:05 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:51:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 18/18] tcg/s390x: Optimize cmpsel with constant 0/-1
 arguments
Date: Wed, 11 Sep 2024 09:50:47 -0700
Message-ID: <20240911165047.1035764-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


