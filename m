Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580AAC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoJ-0005YB-8a; Sun, 27 Sep 2026 05:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknv-0004gR-Bf
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:15 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknt-0007eI-0X
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:14 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so1378122a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499852; x=1791104652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ng3sgW80Xzeb9sb+obeASA5JwXfs3ISjUa09IbUQL9M=;
 b=o0ru2RwHSIR3/o2aMC+n+tSf5rlbMZRIoWTBPwvIDPMmQ5tYCB6LAL43DRTjqSNai7
 XB/JC/XwlXaroOYV9JSMYPwJLADZMZOJskS7W7Y4TF0S3ePVQ1BDVuPDWCG8kg8PNEJZ
 Adqs8ZbwR8SpiQ2hXWBuQmbyp6Ua+PykP4Q6/ddnbtuugPZPWN3CTnq0eU3lfOZUjpaL
 5PnRXnUxVeDaNiVXK+yWrlJl2MgPkUN5dOGgHSZTiemOe2dEeyoiQTwCTjkxnjssNY2f
 HImjJrbiG+R0KvvyRLayruhxQPS0EeRbLqW/EaFzoETvZY2o6k8xyXeT//aBxTbLCJ/U
 NQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499852; x=1791104652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ng3sgW80Xzeb9sb+obeASA5JwXfs3ISjUa09IbUQL9M=;
 b=VktLbVVkAkzAnZalfRkSr7t/a5N5PY+vtxr0TVfqTkjRFbZmgsy6JrTr+/8cuB9xKu
 Y3wtJpL5lQxw709QMKStUVUg2bcEtHwvFSpr1bLEIwHvIxn3Opa93S54cEah0/1hlNZe
 lQWt2NWGfj8MKEvw5u/YhsIYjffGXqqPwl7W8D/aTKu/qye9iy1KjzuGIdjKBZw9XxrX
 8UiakOTiLzZvOwUt8cRuOk9zz+XoPb3Qxf+VLSbMIZwlb59tr48irDy0Y6A8+3BObL27
 kNV8ndYeIvNugq5ZCo9LTuGckYsH0bb5YhbPoqz0QJG94OU1NprJddNxjLuV4+iOhjw2
 /AUA==
X-Gm-Message-State: AFq9FYKUD/vuEh6FucsFOYxXjeV5pJHTYsvPYt6vey5hXiNys6HKKnM4
 5KvmEzLAODAgU0Amn6ObFwxaw9bUYmc8gaNN2SkxvR41s4b6HNT6NMuIQ6PrT9QLEIqmOlN7Wdr
 05X0M
X-Gm-Gg: AYBFou1XyCGMRQaetuPpwNnY5MCg+X2sY1x4ilys+RAyboVleGZusnSSQo3wIO7I4hA
 QbXWdc4LCLXawYdniqYXoBxykz2NrSAWeOwMH14sd9sZxrINzdw+KkGc0yDva03g1AptE4jOpRv
 BN8YXVmGcunrFAwr5rwKh111jNBENt6xI8hFM9vebUJHbAxDcVTP/9d+L/VqvU2Kr59WfsCi9af
 Xcr9Buo/HxM82puF11IpXLgoKqPKfrVNiu1PAHIuuyOWJ3xB4ffXHu/L15GRbO14I1JlsvbafW7
 C150FdVVaEgYY6GfB4vJDfFHkPP3y5yyE/D8zCwbxu4zFgqA8lirAKF/ULCVbTvh5J3gvsCuZMh
 p+jI2JsQjoaPIBFwW27ZInBFDT5SbdnPAMHzctQ7LxMjnTpuuApNOWqe7LcrkCl/MaJSJfNK60T
 GQi1Gt2j0kgbRFcxcwUgv4P7JAsvPJ89HhpCxI2fJT73iLPv0epCNbo6YHJaLYxs4DlQdt3IMk8
 AGcINNmKB3N56IbwkSJXLheNyWDdQ==
X-Received: by 2002:a17:90b:4c0c:b0:3a0:f2bb:53c7 with SMTP id
 98e67ed59e1d1-3a0f2bb5768mr2012039a91.30.1790499851560; 
 Sun, 27 Sep 2026 02:04:11 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 056/101] tcg: Generic expansion of tcg_gen_ctzi_*
Date: Sun, 27 Sep 2026 01:59:26 -0700
Message-ID: <20260927090011.10724-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/tcg-op.c                 | 45 +++++++++---------------------------
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 94c2a3d1682..ede4743b1ae 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -186,7 +185,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2436fea04dc..7ee00c9d53e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,6 +12,7 @@ DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
+DEF3(ctzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1c0c1566d92..3498be09e70 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -470,6 +470,7 @@ void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
 void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) t1 = NULL;
+    int width = tcg_type_size(type) * 8;
 
     if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
         tcg_gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
@@ -479,10 +480,13 @@ void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
         t1 = tcg_temp_new_ebb(type);
         tcg_gen_addi(type, t1, src1, -1);
         tcg_gen_andc(type, t1, t1, src1);
+        if (src2->kind == TEMP_CONST && src2->val == width) {
+            /* No fixup required. */
+            tcg_gen_ctpop(type, dst, t1);
+            return;
+        }
         tcg_gen_ctpop(type, t1, t1);
     } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
-        int width = tcg_type_size(type) * 8;
-
         t1 = tcg_temp_new_ebb(type);
         tcg_gen_neg(type, t1, src1);
         tcg_gen_and(type, t1, t1, src1);
@@ -513,6 +517,11 @@ void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
                     tcg_constant_internal(type, 0), src2, t1);
 }
 
+void tcg_gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -821,22 +830,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 32
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(ret, t);
-        tcg_temp_free_i32(t);
-    } else {
-        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1682,22 +1675,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 64
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        tcg_gen_ctz_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


