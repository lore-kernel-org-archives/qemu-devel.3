Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B881FC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklH-0003At-LW; Sun, 27 Sep 2026 05:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkM-0002TY-4q
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:35 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkJ-0007Qu-JV
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:33 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso1777202a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499630; x=1791104430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6AiUnqi9/pJ1kWKmol4hzAxNfpM2fbsmEm31C0pMERE=;
 b=T3GocSU7KjKdQ0GsAp1Q+oO1NzCKl20XnDDiutNVkrucYn+39d9I2QJ+XTSb8ezodT
 TDc5jqtdFfF+Kf9Rago8l8Z5CiQrC0xSk0QXAiMB+LMSNNTHct20Ln/cpkNzKOkiL2vR
 1x7e4i08tGCHEQl8+7zu7NaI6sk7IwsJf6IzZ16OsQ79Wle6KDwjwoTqe5fmQ6dpfBxd
 JEK2qySNBsM+e/Q1PPGMFlDgocAnCVyIh69Bq4F4YrCTqYYwsusTSbH9KsAyc8OIHsS1
 RmZDdcHXo82Zo6/O/3KkI4xqN3bKo1nw7udFx3K1r6qJqCp8q+PAdWRLuCr3IamfoIbZ
 qp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499630; x=1791104430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6AiUnqi9/pJ1kWKmol4hzAxNfpM2fbsmEm31C0pMERE=;
 b=Y9/0dWVwRx5DYu9tMGmutgEyGZ4GyR2VAer4Cw98kQWEFQfPovA4WuHlHsvaii1vlD
 Dq8UuscrDRmTo3VBV/HMmJsALSY1WS4agaf6NjufaCerSVKIrTm50N8CbgZXwceEuQPV
 T6zDEzRUGwHMWNZRV3c+Jg+BfdzZNPfPx2zZwOQPSnJ1kq/rlzAlrKYgcBKShhCXF8O+
 iLo+me+G5hyon4fp71cpP4H/1BbwbdREeQFRfCoZ2T6Cmv9I5SSmqLaGJlxtPgiP5pPq
 KOrjHcuLcVENzEjzH1GxE6EZwosG+AP3fCZo9hoLnXQdaiBXdNnLjfJZfKtRPDYp3DWd
 LDJA==
X-Gm-Message-State: AFq9FYK5rFon8qgPFNVaZQqRXck+nkroGhguu2px2HV5bKHib+lDGaqz
 RGGT543wTwrcwhDo6346mozCIM6H5Ej/tlbWMpv8LZaMHZn1QYnBBZXzdnUdqCx/tIuO8kuoaKn
 /BCVI
X-Gm-Gg: AYBFou3t/+YbrYpZhHeZAfCo20jABOty2SmRHvA7CGVl/MXnoN+ihFoxmQz2dA2nxiw
 WDuYts6fo/I2w1qlPpW73oGvq86OJb2R4820nfEOwZq36P136L7ZnyW2g9ESbKy8kpaoQtBRWEu
 ZUX9fPLLNrFy+ujZbUblYbWSDLDJcdpkYa0ByhC3Ivq7CNe6jXaz+U1QOozveLiJroMGbS61SgG
 TaiMlqh0XeDZQBKm8hok4UjAEqbLygKoEGDMxJ1TwM4CjdB863/P3p6qH3wy7ZwrOfCvKPGfUDV
 VAGaFNU+hK0+7Kqx3JA9IhzIohoaraCNiFQNuNDfYs6d+OkwxPmxhME9qq319jSrA7LMCG9QZ5E
 Hv1xYlkGL7GFKyGIE2EKUL0eYV/Zr28pu5bt+1Xrjg84zsWT/jquBEbdJWSFA6Ao6MktTYFH1G+
 ZjGZiJkDGxmpQkcSJnoNdwwIX1xlnOYv4G8Pm/ggg5ExBTiSMKUErmICBTbpUH/sJfOOIdwHw/d
 tuVHSbM1sfPwVvBGabbQ+bmP4Zd3A==
X-Received: by 2002:a17:90b:4c03:b0:39e:6a82:afd6 with SMTP id
 98e67ed59e1d1-3a098feb5abmr8561252a91.40.1790499630132; 
 Sun, 27 Sep 2026 02:00:30 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 019/101] tcg: Generic expansion of tcg_gen_or_*
Date: Sun, 27 Sep 2026 01:58:49 -0700
Message-ID: <20260927090011.10724-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 0c4513ffb80..ba333d83958 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -316,7 +315,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index d6b45004a2f..8dd39290609 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f76e01310af..5fc7f1d02af 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -404,6 +404,11 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -455,11 +460,6 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-- 
2.53.0


