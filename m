Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gdwnqzcz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWI-0006I8-4C; Sun, 25 Oct 2026 03:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWC-0006FX-PM
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWB-0003in-3K
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1092795f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912786; x=1793517586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5WNs0PsakE0gJeI4EuOxsjZHkAkssY88/LFotmkpso=;
 b=Gdwnqzczm4AaoiqYMgxMIrRSkzHcFe36W05Ea8NQyJHCZLJHa+IkBDdt1AgsgrfpZU
 QBnuzRS7TAIwAs2JtX4NIOW7SngcATjJinYbD6rwVXx7S+buw6gIJz6LuYG8vl6qpJTb
 h51ichaE9wrU3tL6uQTKR6Wi36HMqzpghCpiCFHPCCAkWVR6e2Bi4jcmbObIFz+agoWH
 NbZ/OWkWxdN0Id4EE9NbuHvSOVXz2Z1tkyDX4HYeAMxfG/94IXs2JvriqP+IxsXTy0oV
 Th/MXqiFm4Zq215k65lsuRGfylL2nbHQ/o7kaAZMVL0PTU4TFhQjX9aXEWupoDUfnLEq
 bruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912786; x=1793517586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5WNs0PsakE0gJeI4EuOxsjZHkAkssY88/LFotmkpso=;
 b=Mv8BCmPFWadGX9hLBZK6uy2boK+R7cQ28MDZvmDZqgBqebp46LCoWCDiyHb15axhnu
 CYhQAihY94xKifehQaIzMq9qR1Edq8CXmRzybKf+xVBFjORYoYcQluY3etOUsFTr612i
 ugd9RoCwekuF5ksu/ql/KYWLEteXxWTUcsXosuJfssi9wJCpLnSexZ0vNRZRRU5XN3aj
 fYWILjQ2k2QG9XyLM6Q6V8pcsWursRPf0lYpNWXjZPc+7Ep90C3psR0Hl161sPnHrW7x
 3pDsoAGHvVSnXMXLLxfMayVYTmVGfE5duiB4jKAJDFBRMT4MQcgSlA4kOfH2xUiZQ62o
 y4ug==
X-Gm-Message-State: AFq9FYJHoyQbHo2Ui8CBTF8i+naXaSZQc+HVHu2d6PXPnk5ZNTVzI3hB
 ESONRTJ8ZQrmrpsa/2vBtAUvYeuKlbQwW+71m81ZIjewBGU9iGgkYNhjJK0i01v/JnZYMSiNwJj
 K3r2owNk=
X-Gm-Gg: AYBFou2l5RciLGQPx6Mb86csfd964NoA0LXfh+J5U93cwHKBdUxeTDdJNLJN8K0UUFR
 1/ykjAC5AUwFrTzaHENFfyB5BxXXADVr5c9RwUJ6V5qM7SB8+4V9eFjbCmmRKdPm0GCEvwM/Ajv
 EpazSIX37/6ThWzuojs9apyTHe/1l//si/WZIZJX68phy+FdMrGskZlH93Ky7wqzr84YclZlos9
 B3s97W/YkfL+EVlVZg2KyAAIg1f93R/pwgOuVBfgu5dkBGPKV/yb3H01Lmq0lXCu6D2VNniBJnh
 txgQsgJpqnn1zDTqiIfrQB/wFd2sdM6FiqMnFyqCtAfCYjzCbokZiE6gFCmLJWFsBUU8NktP5WK
 HykfudoSchdgXxS72OCE+lMBqvHFvPOIZUXJjT7yQ0pFvneWbUOWuo9NUX1p2tyBy8CsnxyQcjb
 sMp5qwQ5qM8IMnWHQG+NVGujltQwHBpsSZASlcL/a2V425IOwiKd306h9cMeqBJiG/YBkhxme4M
 6GqqK512Vsd+2Dpln5hfR5nolSZ116tmywtJnMll1OCQrCzmQVe40UBbw==
X-Received: by 2002:a05:6000:2dc8:b0:48a:f073:336b with SMTP id
 ffacd0b85a97d-48e3eb88c9fmr6023143f8f.23.1792912785678; 
 Sun, 25 Oct 2026 00:19:45 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 024/100] tcg: Generic expansion of tcg_gen_shri_*
Date: Sun, 25 Oct 2026 08:17:59 +0100
Message-ID: <20261025071915.1123867-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dec1bb522c..e0a93144cb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +215,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c47de1a3a4..ea641158ae 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
+DEF3(shri, TCGV, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8fcbbef694..b3f688228d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -439,6 +439,16 @@ void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
 }
 
+void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_bits(type));
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_shr(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -530,16 +540,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


