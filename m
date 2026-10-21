Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C85606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pOZRNkxk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8J-00039Y-M5; Wed, 21 Oct 2026 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8E-000374-L3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8B-0001Wr-Em
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4956869750eso6008265e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592246; x=1793197046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KeykI0HXUFggd5MsPpQnJX8Dn+l6twsnsbIFYp9+UeY=;
 b=pOZRNkxk4RIK8A0oTSdW6sBPWlHxQQLRoNSUvMHRd2FEJxIE1Wqjot5Ms6+mh2dmC8
 +8YF10SYNUEKi3TcjmV6KAjI8Z4Gw1mQK+1lxJ4RmRPeEc6n3XdvFq6gbsBft8BCG0dI
 wzpMtG5/xYle8Dir5C32AW3g/bxYKvz5xjGBtGHkMRTJXlvBZSl7mc16IPmQhERTix6C
 1uILkZemUfts+ucX1Yw7feX5fg3eSutX4LEA9tIZSWRde35k+MbBnN3Ye+QT+4qqrfLI
 sJlW/s2ZOKLLbFX1K2thZEhTM3Tstcv0LBgpH0ykO4u0HiLgS7iJ/3n/4HKAZeRxYeGH
 3tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592246; x=1793197046;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KeykI0HXUFggd5MsPpQnJX8Dn+l6twsnsbIFYp9+UeY=;
 b=y8cNP2CJYTNcJCy3LLG3TPDrgoiOqk359+hO8gG/atplEHL1If+MfaAijqkocJDjC/
 kQ6pDMxBhN0HLP0SDvlWX4MClDHX6J6l4J7tzs2YlfGy4hDxH5Y98KJzeNIbHhX8QijQ
 2cYdkRmsCPiCvEjbuemenYkBNi7A1E+eHbjIxdQxY9JXCdFJ21r0o6qoYalDsefZ2K34
 ajeyVfFQqgsHx210jjnG0WEG2haIs7KklZyaum2DdPYFpYgpf6vWe3ApRH8ms1gw8ZPW
 F3hn+4ik4dIsAALupWQEMoTCZ/iGQe2V8xGXS98Z83kl9LFyu2LyV34MmoazcysoSMA9
 L7hQ==
X-Gm-Message-State: AFq9FYKqOFF/7ALw5WvVyc22Q1bztOI27FeQaLKw1XdLuQd6lXu1ZpDA
 asEhOeFsuFhg9EeFU0XOFDCF6JM7mMNuuNIkucUYh4lSsF3ZfE1MiFxFy3fdEeG9vkHIecarb1s
 i48zR7dg=
X-Gm-Gg: AYBFou3dKkm7m+GOzimxHQUeW86BstM1D/mvFe8vOaQ4Jeucwj6f+8qbn10xBEF+3C+
 HbRovJJzpNtqxXETc7rrTHc1lYkIYDtb7KfzQRhmpDZN1ZyFzlU7Q3jZHwVAY25pfC3WGDe86Gz
 SZivJw/veYkL3fzQ3oT1iNQnBBINalbu6F/Qn9HCALkq4Ys18u6knmF8kmB0uwHXhWIPbbBEaqZ
 nOUD9iEA9ltg/05h4luL+CGPtT6emJpKjlk0rIZkONTKjAnYHaOPpAqBIPFOo0+lMtB/mqWmpQJ
 LEINMA39mtN0Nct3YyWJlFYTqUhmofMzLuVoe2Rzk4MTkHsSmB6cqccGT6D4sKPGUhTsjPNh/Cp
 1MGc0oWcn2I6+dGGp6gP2McAnSR/vv1R4UQTVzfMe1sfPAKKGAncFD+eFWfsGhV59hlrJBofrDg
 PO0+0jdVwgjT+DzPb5mckTtFDFE7pwm+VSaoHFf/8bz8TWG3KmkBEyIeKjjygylVjHVRqxQki5y
 d4fG4j5UgwQeDIIQ91bdCLcVPrrWwdWl3wheCoB/wg+aiyqW98X4Z01zzVbyyn/wl7VSzTyxI76
 2Vd4psE95UfGN6SC8+DU6Pqae0c=
X-Received: by 2002:a05:600c:4e47:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4a1fdd2ad0cmr39386005e9.15.1792592245867; 
 Wed, 21 Oct 2026 07:17:25 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 015/100] tcg: Generic expansion of tcg_gen_subfi_*
Date: Wed, 21 Oct 2026 16:15:27 +0200
Message-ID: <20261021141652.363109-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 21 ++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d7b40e6705..03f3cba216 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -222,7 +221,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b5ede94511..487ee5936e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,3 +9,4 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bb34f883e8..cdb9774ca6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -409,17 +409,17 @@ void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_addi(type, dst, src1, -src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
+void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
-    if (arg1 == 0) {
-        tcg_gen_neg_i32(ret, arg2);
+    if (src1 == 0) {
+        tcg_gen_neg(type, dst, src2);
     } else {
-        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
+        tcg_gen_sub(type, dst, tcg_constant_internal(type, src1), src2);
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1528,15 +1528,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i64(ret, arg2);
-    } else {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
-    }
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


