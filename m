Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB79606A33E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sU/45KyC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDd-0001rE-4J; Wed, 21 Oct 2026 10:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXCy-0001Ax-Qx
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXCv-000272-NT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so6242905e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592540; x=1793197340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=inzVuAUZ8Jcrxx4+Xr5pjSSFFnjOVf+CJmfRcW6ExJE=;
 b=sU/45KyC/S9+XHei2MdDeOe3RjYsgFYqHGF/Uh+DGo2kdGRPOVigwVIdlEtslXqJ98
 ggGmbAMGrEtYDmhmhgr30seRlF8m6q+jvu4fsmGckk9z7QU+6xPZLFENFfQ8K10ksXoy
 nUK0Rlb1FhFBp/gvXQnGxptkGfLj6OnTXrdY3ut8E9RfOy0fAk8QLFWPuCcjn1vZSUue
 +8iim3Wx9OeNE7bZ5YhLLLel+fngnAUkw66/YxIWeg+gUrNtkygqjzku8593OdSZjME4
 DMI1j9DegUVguua9aHcXtGQZDEz2Dlziac0C7sZTQSHwdZ8sa8Jd1h3GWw0c7jO/nRFJ
 AvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592540; x=1793197340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=inzVuAUZ8Jcrxx4+Xr5pjSSFFnjOVf+CJmfRcW6ExJE=;
 b=nWpmMZsInQq7s91Hxt2zl5lIvSP1xOE01nSIAjfPHoUKhHswK8c/VICmdSyvtwAvBx
 tk00X+4AywVHuwlzIyOsJWjs+lM9KfdzHWslaRX0Uu7gk4X3tuDTtanIvaaC021jLI1q
 b++C/oU/nR9NYqmmRCg9No/3Q561v1dgU53qsRTkR6/lEpNxtiCVtFoqmiXbNAwhSPMD
 iJvesOSIvA9q2gAlHCxd6vDb0VzRYNUgLQlMJpiS/9sFkZ7TEbaGkWHNTJyr8YqwNZ9s
 E76kYkkbRyYluSOR1b0c29xPuAcbWD21vi8cuQZ8nnh2pxX4zsd/0v4f40dFwypjA2T1
 89Ng==
X-Gm-Message-State: AFq9FYJm9s2nAdnlgZ1wSIDWR9rQ0s/I7nHn0n5WO/0z9xoQNK6IM29t
 V2dwx3SU7y3A1QtCrjzegOW4cxkBoCsbnaJ1eTX2+5Vx8XXXgHZtkMDvGuM3QJqNSf2A1LoSZ/7
 vuv9VI+o=
X-Gm-Gg: AYBFou1P9USXBLE8BjY//OgXt2UKq7UN20GXAMJMMfU3U4/NpMvmEQL6L8DQ656RpZx
 BwQQFk8BN+jrlWlwmzOfwqvd/squ2Vh5dl/JvkFyRCcme9yVRxDcm8UlKiyPu8Wx1utQ6NJ5JtD
 cGQnLCm8ce1IF2N25OLyqvlIuUnFTPj/vjt8Vw10YgFNJA3/BOAAx4OV8ISKoCxdVMV1S35Jcge
 hzkWCxGHqtBNfia6lLlJvWRhg6NNTTvEO7gMds5L6xnJdyJ5W/MQKRdWuI/vU6Numfzl4ZI+xNq
 la62s0jrNoNkW3m6Hh6ZMGF94Jm/6LC56OE4aA0DC9RwN/hWBOct7SuLQfN/Fg7FRPssZ0IqrsR
 BI0S2EHQswaaeb9uvarW+aMp84nWe+xVvCEnlivXQYOh7e4eh5V6Jyl4mH25QFxyhIk3mZbIghC
 XOub01A6P4VFEsmtQbaRptQrvXOgLVt0wJq4Jaa56xuUnnWSh5zgd8kFUV75quA4CM94O0p1Fkw
 6DH6p/fqiWsj/NZlBxrYBxoxGKaEvGBuJxAoQeiCr4kamP0QZkUICPqROF+KYY3Q2+/STMVub3O
 Hmke9QfTQnXaBTnTA5MWaHdmusE=
X-Received: by 2002:a05:600c:3507:b0:49f:d6f0:6f24 with SMTP id
 5b1f17b1804b1-4a1fd8cb937mr48950015e9.2.1792592540212; 
 Wed, 21 Oct 2026 07:22:20 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 042/100] tcg: Generic expansion of tcg_gen_brcondi_*
Date: Wed, 21 Oct 2026 16:15:54 +0200
Message-ID: <20261021141652.363109-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
 include/tcg/tcg-op-common.h  | 10 ++--------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 25 +++++++++++--------------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ca249b999f..cad36f76eb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -218,7 +217,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
@@ -487,12 +485,8 @@ QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
 QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
 QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
 QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
-
-static inline void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
-                                       intptr_t b, TCGLabel *label)
-{
-    glue(tcg_gen_brcondi_,PTR)(cond, (NAT)a, b, label);
-}
+QEMU_ARG_NONNULL void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                                          intptr_t b, TCGLabel *label);
 
 static inline void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a)
 {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 10ed0438fd..a863215ffe 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
+DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a8752e916a..1039104ca6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -426,6 +426,12 @@ void tcg_gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
     }
 }
 
+void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
+                     int64_t src2, TCGLabel *l)
+{
+    tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -683,15 +689,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
-    }
-}
-
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1482,11 +1479,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
-{
-    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-}
-
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2)
 {
@@ -2450,6 +2442,11 @@ void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
     tcg_gen_addi(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), b);
 }
 
+void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a, intptr_t b, TCGLabel *label)
+{
+    tcg_gen_brcondi(TCG_TYPE_PTR, cond, tcgv_ptr_temp(a), b, label);
+}
+
 void tcg_gen_discard_ptr(TCGv_ptr s)
 {
     tcg_gen_discard(TCG_TYPE_PTR, tcgv_ptr_temp(s));
-- 
2.53.0


