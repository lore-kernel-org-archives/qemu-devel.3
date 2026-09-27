Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028F5C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksZ-00007W-NC; Sun, 27 Sep 2026 05:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrW-0002IN-6p
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:00 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrU-0008Ha-Hq
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:57 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso1120955a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500075; x=1791104875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=34GesCfJ41uXeINMySRlD+FbBtQ/i+nUzxw2l7ILNk4=;
 b=Lm9NKOBCkFRpXSw297A60NXpwdByK58hxJBgxPL9GLLSQQtbpW52J+M4xyNS+c7jwy
 jGmveY3bq6/RrVojPLhEqIhXvmXmElglyGB64LVap9eHJpntOwh5RkTE6Yg0uer18PMb
 /FpqlbbwVP6mUD43aqvq5uv7zrw9ppY9CTIEsQQRlccevcQjRY8Z2smKfrUpa6ybyg8X
 4fGFiFjDRHuotn2XgW3xw6r0nzgzg0muy0OR2tK1DsGIgZZUFfq40fE54oChzmke+KPv
 Y1ooYIxZT3OFri0IOROFAoOgxoGZGENIlHlX2AQDt0dRzKtWNOmSfoKQVPk8SP/o6EoP
 OfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500075; x=1791104875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=34GesCfJ41uXeINMySRlD+FbBtQ/i+nUzxw2l7ILNk4=;
 b=LCm8vEBJwbTe3z/GkkAE2Frv0p47OxwEJmdW/wuCXWOywO0n8C/hBUGeoGj8F9CJj0
 lKsxW5QBl+x/Bn6uDOouH7xp1NqEwpseAC2aDyDlrmnYs6QIG5e/fNQLYSQEJcRN/fsm
 ikaMPLJxHfLxnwL8V4+qGtoMqG9pZTvKVBclwP1alNli1yfIjOyKKrkELqIuD8ODs7eY
 qQjUfnXj4BD7s3ZO84D8cYfmcq6xGwPNg13caIwblOE+UVcrcziJ2T/H1NI/4gQFlYKy
 IxfokxTy+rxA/SEv05QDgDGB7+FXlAurXv2DbdyiQThUXjggMllWKRtvbl6k8SJrokSI
 GqGA==
X-Gm-Message-State: AFq9FYIv0p/bCyk/soZo6wyLxQb0FbEJEBGLLCCSqVTUr8sNBuB/9Nfq
 TSMgBq7TLuk9kiMFVIWqEla9npAydZftY/Lu9zDt1iLulwQPRg+hP9BHVChlAQ81Gm0nJP6613O
 N2ziF
X-Gm-Gg: AYBFou3SANbot6/daQ7YrIPB1wYyz5x+MmtmngNHbh8/zgW8/qFaki89307sfOjGmfD
 mPgeUMSv7iIP09QS5fto0TPV+1uCac72UmSJLmSx4WxaXHz92y8dodtbIFCuJLHi7y2ciTLcUlP
 QWzOlr04Dvr2SN8pyHuYLV0PR2+QOTPmFZiQlcJop3adERPWjqjJPn1gqGiBXE/xCbj44oANEwV
 YAhKTJKSgRH67aSHJkcKIBHOH7GzAiBd0QZ3NyCG7rIuo57U9zINF8m8ixzJtVS6iNq3fEB7Hk2
 G4m4jBmLWvBvUBw5ABh9yFmRCqAm4sxx4V5FRXN5ydtV+ZwxVu8YFZkzNzcwDaZaYRyb5mrFY09
 k/HOS+Wt0onE0ZyYy9yjf/nd9DWESlQulz+Nyl/OPzv5o5DxmElb22+RkZoUtaWGPRlw/G1ppFB
 R0ohqevxUaSPYccnpGHyQr26POMM6UHgc4TGXNT/FaAjiHo5jmzIT3jCxXaLG11XcSET5Rzfq+C
 bTz49wIFtx3K1NHYhVXmHHTN0zFBf0=
X-Received: by 2002:a17:90a:f94d:b0:3a0:becb:914a with SMTP id
 98e67ed59e1d1-3a0becb9310mr4066290a91.3.1790500074993; 
 Sun, 27 Sep 2026 02:07:54 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 092/101] tcg: Generic expansion of tcg_gen_ld16u_*
Date: Sun, 27 Sep 2026 02:00:02 -0700
Message-ID: <20260927090011.10724-93-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3782d1839fc..a2786b8bd55 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,8 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -166,7 +164,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 785c417a74e..98a07a70f09 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld16u, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index af28243cb73..647c7d1308b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -794,6 +794,12 @@ void tcg_gen_ld16s(TCGType type, TCGTemp *dst,
     tcg_gen_op_tti(INDEX_op_ld16s, type, dst, base, ofs);
 }
 
+void tcg_gen_ld16u(TCGType type, TCGTemp *dst,
+                   TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld16u, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1399,11 +1405,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1422,11 +1423,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 /* 64-bit ops */
 
-void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-}
-
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-- 
2.53.0


