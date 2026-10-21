Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E9606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NbLSRHOw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFt-0004ho-0S; Wed, 21 Oct 2026 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0001Yd-Q5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD9-00029e-L6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso633613f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592554; x=1793197354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p45eqdHagrnJIm87OhNs0uUWYZ+eVQfUVbuWaeTdSGY=;
 b=NbLSRHOw9vP05DPk8G2mg0tr05LK4/4wOYNsmh0J52Btzlq+2F8jnhtXZ7M1jut4BP
 S27yCiaQP0VhvvruooEDi3srdf0Bf7cxo6/a8NY8uDYckqMQjaLDHtZp9+KireM1JJpp
 zlU1vLAyhc0Kbuv3rv6GMlB4wH9lhlA48iv0j/PqokyeHu/q6iwHA1HQqsJf6E9fvzcs
 DFb+YQbnt+xJgK31ciRK8IscFWRu5COJ7R1CGDUKHfKL0scLZOQI3VpbefYB5iSdeXez
 pS/6HCxGqmpMXLJrt14LLKKMnHgehmRkR4+0yTuykh/v1olNoQY49GrKclfP64CDc0PM
 JjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592554; x=1793197354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p45eqdHagrnJIm87OhNs0uUWYZ+eVQfUVbuWaeTdSGY=;
 b=pqQYubyD7YBPyXLc/pFHwOPwxvG5JC/KWZvUQatjWUQof10BYQ4lB0/U2r2Du+Ws7q
 nT6q4opUveUEQuHBpMEKb62XyohsBW5Oy6SwoTESfbGdbCylLmNGgnPXv0f7raxTARkq
 Yh5C8n8f7mnVcVflMvqj5JQz7Zcf+y6KYiuc4PpdvLk299nL8cpC7slfywsPQdh5gBRp
 3p8JdQ4gXUA36cUYcy29ba752QHLShHJw7bxAcTqQcE2tcqFlkrd2L28ZgBugAsM38go
 jgufyfM5JNY4tJDCDUqpK0VZWMezavwKD8eGNy6vA+ngU5tX3JIMDhqf4t0hQdIFCrlI
 s1Jw==
X-Gm-Message-State: AFq9FYLBxfmTyFkWHvK9sWFBmRP+y3AjbVpQj9Cj51rU7S4nUauNv82c
 wmoBSbwopBa1VOGZExltLw2fDH8id1ILW/rHD9Y+3r0fyxCyWWSUpfnTzzojKoRzaF+6H5k02Vg
 mGAl7h80=
X-Gm-Gg: AYBFou2BascsYUiwve+X/HFO3kjVKzgmMF1Vajjvl2ieFVF1hh6VdyiNH0jKl7+qMI0
 bq4r9HeTe+TI+JIZhqAnVJYWdgSEzKPqqkJ+YkYE7BSsIaNqG3Br7zBUOLX1sYLiXpf0Jwrfqm2
 ky/n9CCJgsJdvmnnRePTnHsb9lNtYkB1YLgmIxNhH+4ckR0asPKK3iTo/Rgwv6FC/xtZ1qNeE0P
 YWOiwonj0BKbfnlB45BUDtBt2tXERnPbIwyK9TZ7dvYwX3Ho4aPt9k2kz4x0ZMJ3UJnvfaxtYnu
 6plZT1ZG91liGkmjPZpW99DtsgdxoMqH/zNK+9YD4kSjV8RqFm06IUy+S7SUPriqUuHIftboy1a
 e+CYINq/OHvHhV1klKvjo41O1YoNrOAY0jSEk19pDB5UnJ5SorZss6ehMCNCCD1hrv9YTPWlQZi
 vheeNBOQM8A/sLQUiSRG+Ke55XTPDJNRLh3I26eHQprXDqiihb/aTRnUUsaQuFKw8ChA7bGItTu
 I3aHCicLdM2qyYIl5grZ4g3mzhIayhm/KOuABnLVHuukJUCNaAzAYkrex/Evf7AQL2wB/SnC4Lt
 saqJYyiWDtq0R/H3/xOc27USlhQ=
X-Received: by 2002:a05:600c:8b41:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a1fd8a7c32mr47891125e9.2.1792592554033; 
 Wed, 21 Oct 2026 07:22:34 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 055/100] tcg: Generic expansion of tcg_gen_ctzi_*
Date: Wed, 21 Oct 2026 16:16:07 +0200
Message-ID: <20261021141652.363109-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 45 +++++++++---------------------------
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4c8ef80474..b1a66149b5 100644
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
index 2436fea04d..7ee00c9d53 100644
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
index 730962f052..476b8bbdfa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -470,6 +470,7 @@ void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
 void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) t1 = NULL;
+    int width = tcg_type_bits(type);
 
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
-        int width = tcg_type_bits(type);
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
@@ -819,22 +828,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1680,22 +1673,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


