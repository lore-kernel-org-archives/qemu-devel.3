Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB78606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kt+VQkak
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAT-0007T0-Cv; Wed, 21 Oct 2026 10:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9n-00059H-Ie
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9l-0001gX-GP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso484325f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592344; x=1793197144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zff17J5W8bYeqNO+JrV1N0+tXpixwnpmICO6Bor6d5A=;
 b=kt+VQkakaPIs9/ZjIX6BCXPRPPtK4rrIXvKbWkSl8UOPbb8DVNB4CWLCf9VpPtt9ix
 f6Ga0k/zVcqfrqgRkS292Sa6oaxR8+a08w9gxnu+X2bKH2tcUr+ECD5tkkVrKXvY1ttR
 4oBs8VtZ+Zv+x2KVtNrZ+n0SL59M50rRmfpEhsgfu6RZDoh4xVnsIZ3/RmyUqa5eH6ct
 6nSniIro3CckzIp5lc7xxdJfPM007wibJUvOZr05NmHz5mmUXvEFyomzgU8xHThD+3is
 bZd+DefrHBi6zr8Z1UhMHjeoS3emmfFgBPkg5rVI/svt8N5/TxDrQgdQYtpLk7uBBtdo
 K97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592344; x=1793197144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zff17J5W8bYeqNO+JrV1N0+tXpixwnpmICO6Bor6d5A=;
 b=Rf0VOsWU2ExtEaoLMrbm1wytaS/SARVBWAZw9wPGz2qbG0Pdq0IJu0EarN+HhYx6BE
 uTx2ep3Fvc7npYLDoEO+PkWXTvvNEoYDaAJ3Iw8c2yTvR8flAQRLhHEgutewm/Njd+8v
 4flvkNqNXU1jsZqvye4z4+j5kPpJAF9T3lRnlTBcDqQ0WzHfiuwPJ17rq0G1hEdpA6OG
 WfmoNQmwnNvUTqfmOLGPEVxsPMwKeQgWBa91z+hNjYApk1YWi/BGxz20YUKUnWJpmro+
 TpPzg54SlItadC7G5cyyvKBrKMHoixc7cCQXrRh2xVzIPkkJdYCygoMxa8TYsNkMxtcZ
 5nnw==
X-Gm-Message-State: AFq9FYIO2rrw+Phgk759KJEADEDyAgHMluCMKVLyxI6bApPjTS1+RaX6
 kib66wtf2VtLWepS/kbEVdBLGXbNHkfDTVY0TGQM/DE/k5FRnIn+JC7PKDMA3YFdPdMyUBFCEmL
 hqI1AwjA=
X-Gm-Gg: AYBFou2g10gAb8At85eak/MIoLa3PMVt+7wsq7zUvE3ff+dfaApvjyfOxtB9q/aopoi
 vf7KPHIEFzDdFzzdfzzr+ogfpAKd0ZYylkv28VgugrIUDuH0lOe4f6RD9WDtjTYQPHxEtryYsVA
 yFj8rvcj+jLJJZ/7X3RD/HQOdwbyVEDQvB4u2GiHsdGpMiJCEbLUtK4Ew0vbMHvzI/JUip9Bh3o
 w/fJASnJz+bH4f6ZnQyf+l898N4iv+CqKwzFRk8I9uSAo64FnYr1KtwoNUQcPngy3FGxFdT05ur
 KkomB+GFij0npE/+D/VKFvBHh9Fu0P7Kb6GnMjeH77CvkRwEX9ZsMfw++k1aU1Zd8xoSmGwbrmy
 e5+fE0eolYFutqOPQMISyWn8vc+ACDY1HTeL0HNwtetSgYYph/3ku6xAHepHM+S/uewkFvQjbcU
 F9x5ypytG0JIj8skC5uBTEaQJNUgDq3Gs5v8PuG/m+hrmXZV2G+poHOstzsCtVBsuCDBv2f+EBc
 QDf5vmFRi4BJ+dHd/vsjdbAAlpKm1XVrGMnaAJ8uN+3k2f2Xe3i6HOxVbbQlPidbjRJyyw/Nin4
 oj67lobdsWdI97CBUc108AiGrA8=
X-Received: by 2002:a05:600c:3e19:b0:4a0:8b1:f5c with SMTP id
 5b1f17b1804b1-4a1fdd26e3fmr44526965e9.22.1792592343754; 
 Wed, 21 Oct 2026 07:19:03 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 029/100] tcg: Generic expansion of tcg_gen_muli_*
Date: Wed, 21 Oct 2026 16:15:41 +0200
Message-ID: <20261021141652.363109-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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
 tcg/tcg-op.c                 | 33 +++++++++++----------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dd4e7f6686..2b2653d07c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -208,7 +207,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b38969478a..abea00e7e0 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
+DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cc34e0f31f..23aeea8026 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,17 @@ void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
 }
 
+void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_movi(type, dst, 0);
+    } else if (is_power_of_2(src2)) {
+        tcg_gen_shli(type, dst, src1, ctz64(src2));
+    } else {
+        tcg_gen_mul(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -597,17 +608,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i32(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
-    } else {
-        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
@@ -1536,17 +1536,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i64(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
-    } else {
-        tcg_gen_mul_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-- 
2.53.0


