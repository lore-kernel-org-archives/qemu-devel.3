Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F0606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=orPK69dk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWC-0006F2-0R; Sun, 25 Oct 2026 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW8-0006D4-Oo
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW7-0003i8-46
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1092788f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912782; x=1793517582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G1DaoMRtUfHjSHvH7OzRWzLTJ6Oxx9Cl0JFC9kWmsbM=;
 b=orPK69dkY8AVQiiQwbZghkvWD3O4H3sJe4rFJQotKPhKtrN/zPh1TS1VXxzo1RWQtI
 hX51qWQjiLw1nDRU86or85CI2hmidpm26XKmsKNAQY/tPEgUP6/q5jsQrdfUKYibD/8F
 fjgcMsqbV1Z2cmkWeEGwYupReIfpJbmFaz8i+TWphIQBTwHu0vIp3CNwlKVJ8O2Si7WQ
 BoP3yQyu4E2Gx5Dr83VSRSYhqb8RgJsEnX9OTv9VLyb2kN/5TADHqQS2ju26B57rVNAa
 2VhuWVusiiFKFMD3YldS5mBZ2yjXbXN3bVKc+UeGV3zDiKUrleX/tPn6eyCr0vryjYpK
 vgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912782; x=1793517582;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G1DaoMRtUfHjSHvH7OzRWzLTJ6Oxx9Cl0JFC9kWmsbM=;
 b=WA2urufuPKrCOb1PTZuERy2olWpjMb0EcEXOaGo8bHv5w27iy++1a20W08yklGsrWh
 NE1+nabDqNUHaN7wgEiO/IW6GCd3JRUbQuuyWjMKongBvmDlTc1TYm2AK7LLToCHtVmH
 B8Xxde3XrGH9tzsmJfEujqqWC1TCv+8LReT/a7Xbt4slsccsrhvts1rimzOshgb9B9B/
 ncC0Yv2b5HIO5KJgAt7ukETDZ+62EHbxmkQS4i9OBiA9Jc7qp4/9GRDWubc58U0hsM1l
 AwF2dGi581Xs+dNP/C49k5MrH5UF8nRHq/h3sAHNypIQ59NoGp3DI5VocAiXA3kgvnMl
 2aAA==
X-Gm-Message-State: AFq9FYKJ4WCU9MDLK1brgd8yhUgmWAzOshluh81fu/3CGC68azQtu+ij
 M8ttbTdrGgDLT0b2Qtm5I1QQNWAJGu7V9f/9tYD9Bd48DRFm+hCB69HW61AYfumRh/Kf251Hvyn
 5lMWoXcI=
X-Gm-Gg: AYBFou0sGwQxdS3x+r2adNTBLHTr4YI2aglgH+Y0ryTBEns5NWqwAW+IVxT9KQoWV+K
 AOADNfE/l9HQSNHGwXeN6Q8U99po4edIhROJ6AYnbAqFJdp8PEOvEGnwnV0AEK7LnGv6qUM4aYu
 1UGhrsmuYA4xQcA3nKSsm5gDeeww/PW5VPiDY9YiXT7eP8cewZ9utBm4Dz9UkfJwnUo03qhYEv9
 ohq5NoQV2c/vUmY+xdlfSISIjjHnfEaoXbYSHmYJFALZJvYVV89fwYha2m75EhktU1mbJ4ww+U2
 DEOH2LqnMP0qIMMypCILs81qEuR9xAZwWRuV/xoLVBNLuH6Jam+5soN5DBoGPigY7+ZXWxHym16
 3g1xNSB7OoAOknlVSieRnd2W1tVhAiz3JwtEUbA6PznuC4poqauzF4NAZFN1qnmIu28jFzd4bTl
 UInbX7m1PTdmyvVjuRyKUGUVlnArarljR2ouP5EDLNyHlycDPigs8TPtZWENuk0Yj/MiN2In7FO
 OhrZX7UL8os4Aae3Y59c4ThXRESfYeb0guVPvRZIkUSruG+kCJ1YlB4CQ==
X-Received: by 2002:a05:6000:186b:b0:48d:f9a4:bd68 with SMTP id
 ffacd0b85a97d-48e3eb89ce7mr5753477f8f.27.1792912781707; 
 Sun, 25 Oct 2026 00:19:41 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 020/100] tcg: Generic expansion of tcg_gen_shr_*
Date: Sun, 25 Oct 2026 08:17:55 +0100
Message-ID: <20261025071915.1123867-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e1c59b1915..96d351e634 100644
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
index 3e6dd1eaf9..573a4963b4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7cbfcad24a..3c98d204d4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -414,6 +414,11 @@ void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -515,11 +520,6 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
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
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


