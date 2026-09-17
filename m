Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07691C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pI-0005yy-AP; Thu, 17 Sep 2026 00:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73na-0001f2-BS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:41 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nX-0007IS-94
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:36 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396cccbba92so331744a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619554; x=1790224354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nXDsPJde9RcA7gkmx9tU38OTY+zchKLPLswLbYww2aU=;
 b=yaY34lROxhnTg4CY5CncZEjpav4vnpXpr7IzDh9/uUb7aaB17nkjlUq6b8/4GrKXbV
 30qpQVjcnuZhRBX7wz5DEoqOtxP6wZi8s+puF66w91wBCOmtukvYn0S10tZXbvBev+qQ
 66rbiP4Altn9GdP8QFcMAukYJQgIVMGWHL5ozfvz+4HbV9JUhDjzOapAwM9BgijLiuKV
 4IuXx2RkHnT4beJ45fYWhDkdaD36022Ey4BMFoNhZAB76NHosPQxCW1U97pWL6u9VqUK
 KZQxEFa0tFgkGHPTcGSO55VOxYJH3aJQ81eGGYS+FatvfyD8ndSmDBCebyqYwPSDCfdt
 qLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619554; x=1790224354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nXDsPJde9RcA7gkmx9tU38OTY+zchKLPLswLbYww2aU=;
 b=QoidloJkEZ8va6Go75HFuPXYVOioESfVA1CCgBOiYVS5+yld2op8wsKyEM/V5s7jT0
 A27YrfyN47cEdBl4T44H5EFtBb5ycvYSxLjGAhbQkT04snfIhsrKZuc0pKpVsgUFxCPk
 Hic06KPV5k9gE3HBrZw1kgB5yIbzB3Xa/BW1bBXSaASmSmGTxdlI5Mn3BlA6oVEqSnTa
 SgFwFob7lYkS3CCibu5oEOp5S6FjzePPTThrkNBdtd0pF7Y1xRUb8yGLbYqkSfPq4rP8
 wZWPwfhxREJoEpUeptD4w7s0UgpeAjoE3M3tAOOYSIgN8MHQLd7tHokztKqndefIh8KA
 RnTw==
X-Gm-Message-State: AFuF++mMGB06VPDXxIfeII2x/OfgDjSQICXY4av37woIsVavBM5O6Ql3
 wbqTp4cYx5hP5VWed60T4oT0q/9JmDXPfUPwCQnojELUS1G2N3DJ4U991xvvzwq5xgPUYlAXutg
 8x96w26Q=
X-Gm-Gg: AYBFou060MXIHB/byvsVsIebStKmn2MlJPoVSLdll4p8AWJ2/ZQpRxOuetwTVd/ZCUP
 AKk0Vq3htKbmZyHmsG6bpMJhC5NUQFxWlScpb8eGQzGjQbZCFGB3SjPwnga/jtQy7iVWbLvvbVJ
 +KS81sOQYFVBqByn+TQEHMY9SvIsi7eXkKBS3hVHeQuWzcMrqZ1OytqrQiSii52a36cqn32Oza+
 Pis3fuFhnhuXe7io77vMTX1UrHg7uXZFt3TaiGU/xHT/EXYTQ1QfV1iaNLDIfNV1PfwRowZsEq3
 0hop1gY2/fuUkw4ozlg/QnPBohkzqo8HFFsiRY/xBiic30XcIUlMHCcYywcAgNqxk8ZHjhwFPwm
 XdJq+9i2mA4E3lfSMsqWcYE/K12E6g9ceq5opHKEDcuEyW9fd5+dxN2/rVsIS/x+rJtj/V8WOIY
 GstQVxqiNgOcYZxEdwhdeu66f7h3JGvk67/TNRURErsEnUjP6TNghhhl6YX7d7TAfJGWc+6H4sO
 cdQsG0gA7pbsSo19A==
X-Received: by 2002:a17:90b:560c:b0:399:1f8b:d255 with SMTP id
 98e67ed59e1d1-39e1e277431mr12218374a91.5.1789619553957; 
 Wed, 16 Sep 2026 21:32:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 064/101] tcg: Generic expansion of tcg_gen_rotli_*
Date: Wed, 16 Sep 2026 18:27:46 -1000
Message-ID: <20260917042823.542588-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 39 ++++++++++++++----------------------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index aa5257d9e31..2b65e996acc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -181,7 +180,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 383a13aa1e9..57d6f07b907 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 389cdf22b73..a4607044da1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -858,6 +858,21 @@ static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else {
+        gen_rotri(type, dst, src1, width - src2);
+    }
+}
+
 static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
@@ -998,18 +1013,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
-    } else {
-        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1772,18 +1775,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
-    } else {
-        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


