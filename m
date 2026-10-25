Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD09606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sJjpSMSY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWA-0006Eh-KR; Sun, 25 Oct 2026 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW5-0006CS-9j
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW2-0003h7-Qa
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1159432f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912776; x=1793517576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qVAfmGIrta5f4Rt5snqh8R1Q4kWzKLo9X7jGLJbgU6s=;
 b=sJjpSMSYG/B5ypW7lMz6e63E+YoSiFD22ibSmRB+Hu+ZN+6aIbhVqv5zOPyWwtwbq/
 /9S27lsc7l4vc/7GvYq4SLFuyOV5l8zW6o/ppqFllEwNrLOLFQYMKEl/6mZy/T3u30RK
 0NWeiIb///ghp+BPqITrQ8RRU8DGYIPK5vGLDhq9avk+J6N+Pu++3e19QhbpdpBNn2zY
 1gAi0+JghMWYVq1FFWmVYcy1jBqjTL/Ql0DyfPFch+1d98tvThU9dPLZ8YxoVmNy4jkl
 Cf8WpDwvRMQMiRtSSp19119a/REzvn5B59A6pfC5fqVWWhzXfQ/z4nJFESwgc/+QtNKT
 CG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912776; x=1793517576;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qVAfmGIrta5f4Rt5snqh8R1Q4kWzKLo9X7jGLJbgU6s=;
 b=L7ATfrktvHWn+aJzvBdBXM0miI126CL71QEYRmBFLxdZK1dGQ7do/xpZDzSDitL7um
 WK2x491qOe3U1Ir10ZFb//lQaDGz0bulnI7HwvpPtIAFAFRv0SOwgadN3swZQsbcgPdT
 Osfae0M0PU1gG9fubHu3vkAUzFK8lYOmF6wnH+PUFTmyNSUX0dp+EduwgjMuvKsPCLS8
 cKJZn0LNLfSy9BhQ9aAQ56s85klLROSdR1IaE5CWwMMj7xH3Zlv/g8Z6V+AwpuzNMnWy
 69I3nWKPeC7GM4FcXeXuGiOW0AqQg1828jVa690WDwzGIuiqaFjBdzxdAFTha4Bcc4/5
 ymkQ==
X-Gm-Message-State: AFq9FYLeBbxss1SarmCtN1yTSxNAViLo4w+3DF6CjJBhqc1jJMuxmEND
 wOq1ZLiI8M5mn11kSpcZcRwConH1m4JS92WjF7qcCoBSYrzhaKI6JX8dkCqZ8nrezBidztM9nF5
 Wnswasco=
X-Gm-Gg: AYBFou0nx6m2SgsPHHEcK1kiBjfdSpql25LkrjJVmxc7u7HKxJd9mOyokqxdejRFZYO
 PHK5Ie9tMWfqy384x/+pWppIFxsKvWeLGb9CLdcyjS7XbyPwYXGIZCEck5VTEBvrDfuXn93J2gF
 r0PDaMaOhdNmm8/ohphlbcP0EFWAcptkByodKgc+B/H76Jb4kSOuc80CxtaT/lfcOAjQqUpf8f4
 2HFk1UZrPQENdrhu09kFt/HTvcsaWjsJJgcnHQ/sFrdiCyloQaX6+QDaH7vpMqbcOxOY+MwJ6EF
 H0AYuezobuqlR0WjVFhc0YSGPwNg9IHAVuLfJ4VoHqL6lCWhMgxkTpzGRozU4UNhkgdVP9LQtdH
 9A0wBq0OA6STqzQmdgrPdZLcqcb5+mPFUqrsfkLrefdi/L32IaUEinOaoQgEIOTnXJLso4I/4Hx
 b2Pv9j2dsxwzPQLmCcYhKy4+HMjsLltNWLWfzRL9N8pk5MgNKp8G2Cl6+bO/aDcxRhgoq93rhhc
 rR9WVwMJEnytsrqpZ6C9tVQFyqnrKkURYMF3S2hBIYb/SSfxMvqw+Dq6Q==
X-Received: by 2002:a05:600c:8108:b0:4a2:526b:d417 with SMTP id
 5b1f17b1804b1-4a35ac99c30mr46090615e9.7.1792912775958; 
 Sun, 25 Oct 2026 00:19:35 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 014/100] tcg: Generic expansion of tcg_gen_neg_*
Date: Sun, 25 Oct 2026 08:17:49 +0100
Message-ID: <20261025071915.1123867-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 372be70504..d7b40e6705 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -218,7 +218,6 @@ void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -327,8 +326,6 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg);
-
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 55249c4dd6..b5ede94511 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,5 +6,6 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4239219279..bb34f883e8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -394,6 +394,11 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -415,11 +420,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1537,11 +1537,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


