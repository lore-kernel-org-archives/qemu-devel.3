Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B0606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KcLqXlie
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGS-0005y3-1u; Wed, 21 Oct 2026 10:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD2-0001FC-NM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD0-00027n-TJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso710776f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592545; x=1793197345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zydDe529qTK4n3gEGOhkNPuHEwewBdbN9tPZu0ZFyu0=;
 b=KcLqXlieXpIPcIcR3kPH5mYaBv+pB2hoMr6Gg7xtSAfRxWGCUoSlEWYhMaTY8BDaQ1
 M+zmc4bSXpJEIpJgVyXMuw03ZZ79g4VPblbTDazw1V8EOTSFjkK57cH3y7noOD/cysn7
 jBRfUSsvvFojvbjv7n5O6AsmX+kBRRIeY/O3fjXIR0Spsc07tK9sCiEZ1qNQj9jNQ23k
 4G8DYGxCwrCP9XM0N1oHgnGtwAFP3XQ9nb75K0BtvTrz5eXhpfr0KHZHgIHO070UuvY7
 yVG0EYfngAFqvIIk7Ks594SV+ysFjuzNxj6G5VBKEKZTxYgqcLnMU/QpxAo3S2AMd+jE
 aljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592545; x=1793197345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zydDe529qTK4n3gEGOhkNPuHEwewBdbN9tPZu0ZFyu0=;
 b=Ah5khbTlnmF8UDKlkpfO0Fa+rF7Jype8lFYV2kq3O+gAHhOCXB9sbyFmYr4obA+C/A
 tstKy5yKHQYhBOm6IRWNQ95mq8rISh1TlcLDXaZFNqHk/06M9Cwx7sDXUc7QHJTZ/HD0
 U9AuFVcZpw19aVO8y4Bg0Rowbit2o/W7+6w99MlriCogO0SLCIJaDLMG0omR9lent3R6
 EL/eiDwnUf6Ha0HPal3aPfo8O50RZDOSu4akb/3gz3IyD0TVTfRo8nLzIseJq83yVtri
 0zMMI7Xefq1tYpkql9wEpT0T8l/OxYQ9VszxOBuLUfvgmElmbMyw1/n4EgBEuH+unK3E
 OQ9A==
X-Gm-Message-State: AFq9FYKmfuk1/91LaM6sQ1cT2jqfhiVMC1lTHVtVedSUYCTrs6a+2DIs
 j56C8HbUa13GS+HgG0jQ/Tne4A3kXknJQzRdV5lIm66zMDy2PA4WdjsEg14XZ5DGi1HFYgExgpW
 NGB1T3vc=
X-Gm-Gg: AYBFou178wIPeIc4Mn0uk1+WjI4Wo8n4s3w1ARkbBE4EpmLdv/FrlYDxw4QN7JAdLeD
 pNAY50pg2sl2VAAzCwHAm7Ftx4eY++b8ic36eqaI7INYGu5Kfhh/j8De6HzxV2NuZ7kv0vwM06K
 yDcztszbdGyaau2/+jr4q57wFJRG+5i/Yq8btfnWdA7gW246TsGkAy1pNt5Ttn6IMB1PTgRV+tI
 hX+wEUG9R87vIlQtsk72YMBXfJMB+gQZuUYbzsZ2C91iM3StkC+t+qMQmH7pg2IZFscbt1OjFRz
 ayWSGRkIEDIOQ1mZo6tdcJtaTedLJs2QB7kuZWId5/2sAGtTEmnsJgOIrmz45N3pa6g8s+NCunN
 m1riWYhi8zHBupNzs8P3GOz+4VaylHo1CcSgOyCVPClwnkUhi3o7/u5xtEg6PtXKg4K4FkZudKh
 HLytrifznYk+tP3FkjUYoBDp76N+5ZMavhQZaoZn7bu571yirfwq3CALzBi+XWvudAnu3ItP48q
 8pu2AFo4H45SvsKgz0loGmBTTwKlEHG8IOz64vAT+UkzvuyB4a+FUDlHHBmpWdDaEHaMCzuGyHI
 mfiITKPbhr/CBYTHAADy3dmFcSI=
X-Received: by 2002:a05:6000:617:b0:48d:fd0e:a117 with SMTP id
 ffacd0b85a97d-48e2642796cmr4268344f8f.5.1792592543720; 
 Wed, 21 Oct 2026 07:22:23 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 045/100] tcg: Generic expansion of tcg_gen_negsetcond_*
Date: Wed, 21 Oct 2026 16:15:57 +0200
Message-ID: <20261021141652.363109-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c7ca7a493d..923d6eadee 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
@@ -213,8 +211,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 92a35e83f8..1ab2c69cbe 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 94451fcfd9..40156e4113 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -518,6 +518,18 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi(type, dst, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi(type, dst, 0);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_negsetcond, type, dst, src1, src2, cond);
+    }
+}
+
 void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -707,18 +719,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2)
 {
@@ -1485,18 +1485,6 @@ void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
     tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
 }
 
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


