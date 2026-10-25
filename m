Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD2606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Hjwfbst+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsZz-0007Be-19; Sun, 25 Oct 2026 03:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZR-0006G2-13
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZP-000444-3N
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so13568405e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912985; x=1793517785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0LdjpKWeGZxFI1DJSRSYeExP8w/mpp5AQgeLKgfckY=;
 b=Hjwfbst+YjQi8XF+rGYgHT7Szta+z1mZSuAdLIPIuGbcu8OGIj/n8s2B60AWvvQbkM
 oXWxkk/16XmRD1Pc3T6Vb498dP530kuK895MC7vRcJEWqJ2OmH2rrpSa4p0MX+mJPH+g
 cX/Da37hvIth5+dTJZtjHV4RzpqJ6EoNoVbwrY8bw38YJ+e8yYvDBhdY22LbA6A4n+zr
 1pLxAvqgSW8IAMDzOdHoNdM20zF7sS0BbBS2xvs7VwH6ni4kcfWPL/z6ir8Uf1jmlvvC
 UsRYf0UxDXw9W0df15lg2WFjCx6NqSHELCSFfA7g+hurmKNYqYzT6lkIqsJ8LVli98sQ
 oi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912985; x=1793517785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x0LdjpKWeGZxFI1DJSRSYeExP8w/mpp5AQgeLKgfckY=;
 b=Ukwk328fNdOSqxPmQQFyEHKMDSY5fw3LvFOBlnB0JXztYJNl24myeMZfBznX00naVg
 pPA57vXKdL5SV5R8VVmp8okjb1GCSmZ1PsPRZTTZlfpjCSj/J1SvG9gs3iJdyRLZQb1m
 tLJ7MhKD4MXNLLVXQVjfal6aDjtqgsPkhV64SIpSiV04K/1GkdU6xyiQFhbv0ZT++cq2
 Cfn644XtT9hZ8WxbwJ6XBUeXYtJiJjpXoN7gZvxJ8hotIQADig266BLH5BGNEcUO3yIi
 bNWKva4ohHZRuqqoeiFVmdjD4lGmvZmhqZwMUz0/VSp3oO8iSAgJa44AqJ2oMhg6wwN9
 nEXA==
X-Gm-Message-State: AFq9FYLMx/l63mfnOOVmAvicD6D5USMRA2naEpFMsKeDhtKAIctAd8rZ
 VLpCyZmqMql8lrlsOXFIi2S5VAbjQ3fW4AUxQgAyOlKWR7FNuPKU6XvFu1+1WwLoMdAk7tii9K/
 rYxTScOA=
X-Gm-Gg: AYBFou1s6Dg4ebdjc6dzpNl+FYZdBTab2DvH57XvV0XKPVd2CDAFj1euOO3dLfoQ7by
 dwFu2SVJ+RszV0uMrM5TvlUhdh3KHZsFLa4O+GaCuK0r6jKD1pfG3cyQ6blnTbgJFWVPHnC/exM
 zOY7Ymgrvex5n3O/3ld46zxx6m50L/r0ro+UgaQ85WRa7spyEdaaG8BfzcwCzTOP1h3RRLMw24J
 K7Q3DE+sJCNbB7UoSqkbznakPa83wZgwEWmcrkLRHumc0LdlpAAMRg43YJt7iKMCpaNEyJTsCZu
 VrhCMxH7i1zqWGHEp+CxKuuIFZkfUsb6xDLAa3JAkF5SLNjmB3af57ZiDJH7xhmpN5/cWkdmsn5
 sogplgpx9agkSzU9bsesQbSzYlTNef/waJ4MlHfXiyEsaBQem5aWYV1pdjBasKO5ysAmBLLi+cK
 ozRKbWnquQ5sEQJtwF7Ech1kKFxO38UkBEaAQdViiB68JB/vFY7LLscdS4tXvzuwJE5f5bx18to
 sLAxQcxCYGhFPX+uVGB4XE2vSuhKh/4wdx8H8FD9bXKOHkGXJoQdtlm66pv
X-Received: by 2002:a05:600c:e548:10b0:4a3:5a42:b2af with SMTP id
 5b1f17b1804b1-4a35acba383mr34189775e9.34.1792912984970; 
 Sun, 25 Oct 2026 00:23:04 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 043/100] tcg: Generic expansion of tcg_gen_setcond_*
Date: Sun, 25 Oct 2026 08:18:18 +0100
Message-ID: <20261025071915.1123867-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ----
 tcg/tcg-internal.h           |  6 ++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cad36f76eb..117d66ef59 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -217,8 +215,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index cd481dfd27..0de8516447 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -120,6 +120,12 @@ static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static inline void tcg_gen_op_ttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                   TCGTemp *t1, TCGTemp *t2, TCGArg a3)
+{
+    tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
+}
+
 static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGTemp *t3, TCGTemp *t4)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a863215ffe..4934f117bb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -27,6 +27,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
+DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1039104ca6..a45244e64c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -621,6 +621,18 @@ void tcg_gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                     TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi(type, dst, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi(type, dst, 0);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_setcond, type, dst, src1, src2, cond);
+    }
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -689,18 +701,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
@@ -1479,18 +1479,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


