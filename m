Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60948C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJs-0001FO-VF; Wed, 16 Sep 2026 09:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJd-00012f-00
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:46 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJb-0000Jp-7J
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:44 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c6ed1de994so662114b6e.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563882; x=1790168682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+0AwflT075ewSE4Vk6dBtxknupuv8fypEdtdVnsEwKM=;
 b=IBTOR882cKGNwCv8LNBBp9L4niyfhUyybL6bMxFiYKpkbJXhT+C337BH5hg4Hni7SH
 SA9D8VUnJiL6Ynqk1TCf9foyWvTakXiYxO/EVmlxjOmP9HtiD6VQ5qg8jWCPitjE6GBs
 0jRgR9NsuRlOn/hHpRAMR2D5h/NkoYMrbXqS+isBzxrar/YlH40SAeMXB5gMpUWjRra0
 zFZLH5LBmip3756DiA3RmVEujFo0xk99JqmnGbF90JRwrkqpft8C0jlpKK7Lj+twhsFy
 8VYOamZ/9/a4bPk+tR65Q64NpuLOD3KQM6oEmnLR5VyQaazz/XTCgrTG394uLpLgref/
 kkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563882; x=1790168682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+0AwflT075ewSE4Vk6dBtxknupuv8fypEdtdVnsEwKM=;
 b=1MjYRa/3tnwf2z/N+2B4cpZ3wtzA3URqXbCE7SI2IFcrLZtI9RdnvR5aH2Z6g48dNk
 oou5o9jgiFNjo6/sTKtXL2T+ghdWN1dx4Y0fLBKNsdu+lXKI2RcRXJJXDSshFLlJwZpt
 FQqE5ofhMTz3QQdExn+zLa2O8wIfLThS4LwmGabdBdT9ubCYOWyGstAmDBXZhNKQ8af7
 k2V+DnBXGGrs1NXJ4T2LG4+O+yks6NpSlagi7Ka32TpNQGFSFWv7z1eh658e2cSDKn1r
 khj5x4/UWp+1qY07AW0jbEiP5om1XJVPSYEHemS2ZZ2Xnf1xXpPRVIGat7KY9lZKY7JN
 dloA==
X-Gm-Message-State: AFuF++lZ1CnEUuYWVUOItlRHiCCgbtRs8nPpvZFDq3s/z8/DsQQ6H2R6
 Y+l3Mm6K7SfAg/6vt+tbI+Bk/lK+DRvDgXisPV0MymT5KTmgjFC67NW5JTp4xb+WuAZSHtRaGqs
 gnHYbOUQ=
X-Gm-Gg: AYBFou1odeYLi4R+r1UepKvUA/VSceQuk0e5YaJCzCEc06hC2+OHSTLoaYCgTsTAWV1
 RKYco7ftDFAAo12HMZB3nzfjTqeYw1oIzvDvdw6nUQdPRjwnFCK5/vwY4znBSQQvZ1Aroe4Uaao
 m4fVF1GX9y43wLdPnEKj7V399ssdT7ZqciBnaXCjCawa73umy/wFhI2/+g/G3mcmQcw003Nf2JK
 m/pj8k9GWaNI3BY7G8yPFnMm5nNDq27aTMME8fMjCZCTeZl8G+i3RQbeq5NxaP2A9eTVzWdXWDr
 eW5OyuwM0RQEAIaxDXLwIwTI0KR8MGFalRi2ViaWoGWDPxbGt6a385omi+hp7isWJlLGeqtFrX0
 qWkb2lqnZ2NoAL71d324JxqiqWKGtlbqUMOKqmttEC6Ch4iLP4Iis97vtTABSwVpZKueLjfu48g
 s8Wj+ZlJJbAYAzhIKk1FdgEStjtfxX5wKiSFUzhoPtsKMyQpuQ9M3rGGBJTTua+BpxPjJnyHTyK
 I2EtpE=
X-Received: by 2002:a05:6820:4b82:b0:6c1:f832:9b42 with SMTP id
 006d021491bc7-6c7d3fe0f46mr2184409eaf.51.1789563881852; 
 Wed, 16 Sep 2026 06:04:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/92] tcg: Generic expansion of tcg_gen_shr_*
Date: Wed, 16 Sep 2026 03:02:54 -1000
Message-ID: <20260916130409.3382710-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index 5115b07ef22..9bb5dd22496 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -313,7 +312,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 15cbb6c341a..3f928d4cb8f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 19e2c6c713f..6f6ab0a0e5e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -448,6 +448,11 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -549,11 +554,6 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-- 
2.53.0


