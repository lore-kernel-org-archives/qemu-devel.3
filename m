Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C04C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pK1-0001f9-I8; Wed, 16 Sep 2026 09:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJb-00012Q-S2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:44 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJZ-0000JX-D2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:43 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 46e09a7af769-7f4f0dd5507so427758a34.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563880; x=1790168680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZMzrrEL3HX7oRdMffSDqbnrF+w9NjI3ZykN767yq/3Y=;
 b=T84jOwD7Mpp7seoxLHXKkBPcW4AmmZfj5NI1NoDhQZSyW1nBVEqWZFNZWDYP4vKUJH
 D3p7iRKJMOuKOuF403X86XbNyuqLa8BdPVIVS9e9o/OpvGqvbUYCUwA03xn/sf94sD5K
 QH7+hFD/3HlD+BwwVcAICUy/bfSNgYdCkY+1w5+GUwC+LEkYsoNDe0QOJDZtWyDdDJRS
 XVU3T771cII1nSChu27nEqYthu6gqHdRRhZNsSR1ggTC4ds/W2WZTsPjLuG70h7n0uY5
 rADw+3DI3VtQRKRMTKC6/RfPkH226QyK7PuD5EGaZTvVVmzb87yRFkhYBuNfr4Ky+9r8
 BiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563880; x=1790168680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZMzrrEL3HX7oRdMffSDqbnrF+w9NjI3ZykN767yq/3Y=;
 b=L8ZTjYBC5jnPYqUb9DlkB4ucSXRDCO+TeSxyne8xLALKbNjaloit6QP7lykpVsx2YB
 VgndmBkocKe+SEt+gER8bCDGZdCUwZF2BSPWW4mMlUDAkVPKmuuspvlF3C2zDUhzgnZ6
 RBpCrnwnirPwsyHvovsprkuKDxhWO950hbs89MpyLaTAdCxVk2lNhboyEhAxY8pCANRL
 ULI5+XJXkuAzV4b2zcIgEYei7Q+q666twfqlF95ZteUdRPer9mo2opVccmSz0T7YEE1R
 1Fln1IKpMYSRQfC0aaokxjb69IyGp2TfSVsaGHvNmHpPBMApnQS0RwIlqpvcnw0DPZJB
 qKRA==
X-Gm-Message-State: AFuF++ki4qnP9vjUs80YSdtd43KEZgi3eAEvWuEazI/TQTGYxTiz2Cpt
 s/5AH4OMpOZhTT7wL5VzF7Flf7TV1zEooX4MUhda7O8GBE5jVC/z85OAXgfmo8/dBHrf5REyKui
 gZ9eRJXU=
X-Gm-Gg: AYBFou2/E0InJ11qjWVVVEOLmBa85I3jrosRxH9hzzZ5bGc32QU++40z7DDYfNs0uII
 jwkGFky7A00khXNbfGg/FgTuxiXiEQF3J8bbGNigR8cpensOifPov5O8dLOMv1bYv90ypcRGwYV
 h2wbFuBblMR+pPuHh4lQXgNHsmmDSPZtqEehdCTyePpNyhiuRqI4//w8x15SxS3cm5zojE3957X
 YKhG+Q2ePmjsdfkLc8lp132W6k1YAe5IFf9zcx8P9O/hZKrf6VgX3Sx3Xr50K8kxqvrqf4gFPFf
 Bv7/Ze0RCer4DbdrV5XDXX07XhqLhgVbTBVPXEbaB0G8+40DvTOiTH+G1IY61UOUO2er4JyDGpT
 KEy65m1m+fwIUYOq4GJUaw9tHSQOlSYDkgJ4Zus3kkXH9J6sNcKxO2iQf/y/Y2a5/TpuUpIGjYI
 VjSgum32p/zcR7C9He9HSA2Eu0GyIk1K1PKSTG8n+/mOm3Gfifr9OXFjLHSQWjIH2ewOutpA3eN
 xtsdsg=
X-Received: by 2002:a05:6820:218:b0:6aa:ed21:6c95 with SMTP id
 006d021491bc7-6c7ce252389mr2571183eaf.0.1789563880269; 
 Wed, 16 Sep 2026 06:04:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/92] tcg: Generic expansion of tcg_gen_shl_*
Date: Wed, 16 Sep 2026 03:02:53 -1000
Message-ID: <20260916130409.3382710-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0e.google.com
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
index 6365f67494e..5115b07ef22 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -314,7 +313,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 47d3e6f6990..15cbb6c341a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2b796f3cc62..19e2c6c713f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,6 +443,11 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -534,11 +539,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-- 
2.53.0


