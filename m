Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130E606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=F5QxnZfy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWN-0006PC-D1; Sun, 25 Oct 2026 03:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWI-0006Ip-V5
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWH-0003jp-0R
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso19371285e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912791; x=1793517591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T1BluVEmVHyU53ycn0qoIzXsbeNFgBit4RRPj0IbqM8=;
 b=F5QxnZfyAsfD+wn25bLEy3i01E5zKR5qT27cyF+qMbO22CDBErBArEwRFpbbdpplDR
 UTd4JQI2yhNQOD8RRZ0iqhj2fONTe8Te51w2iFy9aW7eVcWAHRYFtFY5NZfh3Zk8fyl4
 sW01BSpXydAhrJbVpvrV5ZhZN+otcMnr5vX/v6TVC30KFqbKmscqGxLZ8kdCSwRUag0c
 lWfLsOf2O9GLWh9kjrqChHNKKLbkVXpXGGR17/gBQvYQez1Dcl4Ih3FbmcZTFnCjscOJ
 gIH6x9Eug75RMabeERipo8sdKT+RJKfnI3Dm0LbeRxCvnGhhxHo2xZPjZsAUTye1XCWH
 kTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912791; x=1793517591;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T1BluVEmVHyU53ycn0qoIzXsbeNFgBit4RRPj0IbqM8=;
 b=a5Bn3GT8x5wGeOYcQv/NJQjqqosl/E7pwS8YgpMJnE7+3YOpiQsT0Kx/rQ6gKi1uls
 9F+M3Ajv6ni+TT3XqNo264hGjnAcBj7+YgHU99KIILCqD/a/gMbxDln9JjfSZtNwORw4
 9XNZ5hnRsSbNBrZ0a2ZI2i4VbaclCYNrp6v8IHiGqdD8X/ziYG1HeMk3Zjf+hs6rWXaR
 SA9zfxuNfWg9YbmRnL1SZlMeQfbQ2YyCBEWuTurLaeAWGwjlkekkv3ZADBe21sUrdCzO
 5r1CTRN89rU1YGsdpbSA8p3QQQElaAn28qZHnazxW7HXOf14U66n483pJ5Psq8Xd+W75
 g4LA==
X-Gm-Message-State: AFq9FYLQT50Ll8BzIUpuS9NIAbtal/0baJWHefqbEwAGwyxuRT+StS/4
 UKKxtWrw8OkSaZcK4xLqBpQSUa2G1qNUQW8xEGP6mpJOvR6QSWm3Sei2w4puhhYjjf//6Jbfl7x
 ojfAPpVA=
X-Gm-Gg: AYBFou2ttxQaUI+VqAI2CMmeOMBk9cTAeDJzapcd2pMt2ZGcePWYOvzc2tTGW6NyRJf
 34PFMdVyjIQYN1tsJDzY4OZyVXsp9MReUCUbvRZ1y3hZoJwnGh7t+zGT2OiIMrawqTozapguLUA
 ayD3SkBJDbeeCaY93Oawvz9Q8Lm/PChOd3PQVuer9xMkGXQbKyQweHmIOMvrHTNC2Tto3s0zNjU
 xGoKeO3VJ7QTqpTryfD6B0c+dHM/LV2xCwpv9dbBkUMRuqMRyY5GZVM+SES51+7x1isvOEEiD8w
 24qemG05n8V+vAiglaRtk9k/Vtyz63s8zFJ3wXtnDEbZkz7/Hc8KZNxi6cxtp3aFkhhyVFM6iv5
 0cUfH+zRLBldGhLJnMV1UX4XaIHONFIjrTgFE2Uuh46uHN2lW5inT1s6wCb+8xlUsW/3fQYc1xs
 wZ65u570uEZN6zydEklfWi76Je9ocwJXL5nPowzrkhDMHL0eqN1QZf5kpRrMtIJG4vofB2/ZV22
 tj4NI9CfFJz1NQAw5970JalgoAJP5smkYCB9qRsQvTwsugpc9V1e+6A/Q==
X-Received: by 2002:a05:600c:4f84:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4a575d2c6c7mr10781895e9.22.1792912791602; 
 Sun, 25 Oct 2026 00:19:51 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 030/100] tcg: Generic expansion of tcg_gen_not_*
Date: Sun, 25 Oct 2026 08:18:05 +0100
Message-ID: <20261025071915.1123867-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
 tcg/tcg-op.c                 | 28 ++++++++++------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2b2653d07c..df6563af9b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -203,8 +203,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
-
 /* 64 bit ops */
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -258,7 +256,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index abea00e7e0..8c9d3d99c4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 23aeea8026..9b3974fb8a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -444,6 +444,16 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_not, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_not, type, dst, src);
+    } else {
+        /* Do not recurse with gen_xori. */
+        tcg_gen_xor(type, dst, src, tcg_constant_internal(type, -1));
+    }
+}
+
 void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
@@ -543,15 +553,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i32(ret, arg, -1);
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1803,15 +1804,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
-    } else {
-        tcg_gen_xori_i64(ret, arg, -1);
-    }
-}
-
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


