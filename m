Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A75606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oNAmWNyV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAB-0005fx-Qa; Wed, 21 Oct 2026 10:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX91-0004bw-1F
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8y-0001Zf-Px
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so3623525e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592295; x=1793197095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dm9elHlRHXBhzslvDw3mXUeRmQxtvtQTtCUPnQ5neXo=;
 b=oNAmWNyVUrAk61cX13O3kCoPDRgiihSLVOkPfR9Fy00ETPQdjYjUr3Jk2dNwjkOfAg
 U6TX2WIy0abyZmku/SDNjYoqhFiGZbzNIoMoH3r+CiR3gWPwuxvjgZmesjmiOQbKL6+B
 MC+MnzwAvJfumF79eiuykg9bfIQsY0UiQyi/tuRWFHbyp8EGIVSf5lJArG4bAcSWaFIJ
 uHkxZhyGOjnjlekuVgR3vgJfxjXbttiMuhuqZft/+YnUTa8qUAlkeX+BhwNFhj04hpLd
 V+hNLf0Sn2PsogMSblGVsBMLV/cEcTYZwE+pfF6gGS9I3HkcVIdQQ2r4G7S0e2nnboFA
 4WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592295; x=1793197095;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dm9elHlRHXBhzslvDw3mXUeRmQxtvtQTtCUPnQ5neXo=;
 b=zRibvSOQTy7OGkSsBzDcALW+JdCx6LK6odsWnPji2fLbnLLF26NIL98t5qwJZ5rmnp
 guK8nHF7QhSNRh1EA136aj8wy7jTFJRjO6Ae+Y7QbxvT86vpi/3/VdQOvU5yyLmgnIGU
 apuxSl+/EOpqqVkxDidtxPVlt/dDoVlz+MgyN7/LcRI3HQaq4lTJuv5ZBbL/s7h94pT8
 Y1aShWMWL86nzCT529A33pnyaFgtHaXW7X9F0SYoTmIWXcVdzmKyss11m7VUFmwOOV03
 a+QdgWz19MLIFOjLz/2Txnm3o4fL31iT41xVVVQ+u8y+htTw3X7nAMY49OpNZyvbhx7+
 OvWA==
X-Gm-Message-State: AFq9FYKANWDR6LA8bV4JYF50E38sHFYoQN17AiTHd+X7G4m0kI2jUqqK
 edkAiMBFZ82L57ycWKVgBXHvCZXsnl7by+Wuj5QSH76hQJfuEsGmw5T3zVVdILVkPLQx8g4KZG0
 r21Jlq/4=
X-Gm-Gg: AYBFou1JjJjQgZVnWQ+V0BDywOIGS88PQHK5KCwZZ4nFZ0/KZTB8hw4tliB6ZpT45Ko
 gkIrb7r8m91PgxZe9QoFV46aPBnpz6kZz+03wDb0D3SOBCQjdORdq4BOaRpTl5B2rt0aQruMrHV
 g1/xcs2nzHYB6GIrp3t7pcZF4Y26hpkskF0SV+k8dx53fHRNzNFZl1rCMxFmi+Khv1hHJdSFMhm
 RmKc3Lo39a12Japt7pt1n1OOJiemMNdirfYF5WxT7qALxIHlXOuEyjN2SHC8U32yeXpBAUdbyoB
 9OYNg0dNhil5XqbSJqLvFamJ/rXRvL9BFtp3FKLJCe7Ez6x2zAcyfD0XOrFjz6I1r6Fi4ylqYVQ
 9TQuHd6KSPLZLj2kAOHhYl5Na5lYm82KGgqlsfcIm7GGFtWlQdkm3rJmd66DrRwzbLaknLJqFyN
 Pz9LbbYXg/+LKj0lqT0rgNHYsJURM0KEhdRN+JkgO9piTLnflh+N13Z4RspoRjyPxQIFItzXKMa
 80HcZzPlojRx0vGPNHFsO8AHx1IP4VFgSdqY1YXyIBzgf++ZNUJ2kJBLlD90k2J9KCDuRnUNNS0
 Akv04LwX8+iTEONvXOLr9IaQRwA=
X-Received: by 2002:a05:600d:8652:10b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a1fdd26fe8mr34483305e9.21.1792592295114; 
 Wed, 21 Oct 2026 07:18:15 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 022/100] tcg: Generic expansion of tcg_gen_mul_*
Date: Wed, 21 Oct 2026 16:15:34 +0200
Message-ID: <20261021141652.363109-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 74cff518ce..76e67acab8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -311,7 +310,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 96bd6abd74..c1273a1019 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 07e7c83ffb..1e85ff545b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -601,11 +606,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


