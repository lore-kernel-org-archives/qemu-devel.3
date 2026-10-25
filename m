Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1B606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V/+2BDY9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWv-0007jr-1i; Sun, 25 Oct 2026 03:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWR-0006aW-TL
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWP-0003lG-RX
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1551198f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912800; x=1793517600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XWTtHCywZUMh+ZGL8dRI9iz3fGxQCCS7fo8G7EJFW84=;
 b=V/+2BDY9D3PPyBYrn39vLKnoKhlShhYksZFtxuFenFeA7JIOyDqxTNqeuLaZlgzZ2C
 N7fPzJ+4V59dAMhhN06aK2dlOFxM6CQZ849FQofn0TVZRusS3oAVfav1Y85qvm0WGkKa
 FxGDe4GDZPiS/hn6SB1wBRLbQLn7D5PLi/ZvXY9r6NoFNqy+TX7Q62WlTnUr7G4W1VID
 DNrBGzlB3q6CbxTKDTlNIJoGJmSquSy09B/A1GQNhKrfOP6H8HO1cYTGZr94J8+06Qo1
 OMJ7aAuRBWBpL6CemBbD7DDlnRzHJ9gxRjPe1L+YezY4t74I05h7f7GSf1Y6/Dd5sg2N
 bIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912800; x=1793517600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XWTtHCywZUMh+ZGL8dRI9iz3fGxQCCS7fo8G7EJFW84=;
 b=ZHZ63UsxV6gIlUHR27HjVTm45jK98svuWwfqw0nsmSyw22148pzkGuYuozbR+x8vDd
 XoMlJTPEPv49LGbiB6pC/5/nsHNSWoyUBVsxkiJXv7eLwJFms2umRXPr9CGMatMuSQXm
 dl3tNEs0t1uBI3U/MhavLYZydvxDmJF9Z3YlmoYuhrNcfoNt+UX71BYvr6APHrCjJ7Rt
 T8Qux0pnbFswBxQCdYrwtkVeZjFwXmY8ugzXDfw7Jj5jttT5x+p5fvGTY7w/QeP8WWcO
 qmrpuYeiRbFJdCahTq9VieUKQ4EIalj1sjiLVuGijZNkY4kCpd0xrcg2mWUGT/NxtHCz
 Knhw==
X-Gm-Message-State: AFq9FYLpZ15yzBvUnwGtfDuYWnyr1Ya4GQurS9qDO+i8KDZTLQ7sO8gu
 PMXvJ/jQLZKFaP+V+CT+9QeyBUzF59iAUIVB5Q3vmOALFLXROprfXaYw/1jPbMlktZmuGzlMyLz
 jVaHTW+8=
X-Gm-Gg: AYBFou0Q2P2p+Kt9PYtXZjiqRtbItpi8+s9jWJp0Y9WRMbP9hCaXAkXfgsGW7I8puFw
 TeJiZIDRKl+tGn0h8PsIeqoQ8obD4HSU/AlGECMj8Sz7BwJq21k6R4nrwHL3yzVEzefMBXPRieK
 ijSChQTB3fPQBrnMWgtJwwL/Zx4+HQqpb6on8r/8A5rlmiJk4eCjlj3wLWdXdTI6RBspiuZI5ho
 6o0IM3TyRfyDGMyK7a98nThqtp6BFFrPTop3uUN9RHPl/2q8DWJhYY4uWJdLboIETdEcok2OqKO
 eu4ltgoyrNjujc5xYJAiaz/r7vJa3ka0JtzQRGKf2nm1qJBoVwDnee4Ibei1qK4gSMwBcTBXrpS
 LQiBaa7FFjfnRwRPZ4ngmr5nzpYNLrGQEZsur9RoY9JDP1VyhB2PZdzBrsIi4YCmulMMKmcmVsA
 dDRLMBePRp/Rh2rxdXRh0Lvrc/1SZK4XfbetAIm58ulaT9g511IwVHlC8Py1R77uCr7zQ/cp/6n
 iDhgk9KyQO8BFSJ2wjBc6+t44q/aD8tTvGiRxPkn32AYmXH9ZJtGfraWg==
X-Received: by 2002:a05:6000:4187:b0:48d:f69e:9cfd with SMTP id
 ffacd0b85a97d-48e3eb851f7mr3887408f8f.27.1792912800108; 
 Sun, 25 Oct 2026 00:20:00 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 039/100] tcg: Generic expansion of tcg_gen_nor_*
Date: Sun, 25 Oct 2026 08:18:14 +0100
Message-ID: <20261025071915.1123867-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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
index 2d9b0704a0..f959f82e08 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index fc40bca553..7d94e0cdfe 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -16,6 +16,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 587fe0d280..1ec1cc1e97 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -490,6 +490,16 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nor, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_nor, type, dst, src1, src2);
+    } else {
+        tcg_gen_or(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -695,16 +705,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
@@ -1722,16 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


