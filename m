Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5623606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rYN6htbn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWC-0006FW-WE; Sun, 25 Oct 2026 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW6-0006Cv-Nj
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW5-0003ha-0M
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so7876905e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912779; x=1793517579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vmjNfkKwfExbxIkCyDHPKnI6gvFtZpjg6M21jdzCrg0=;
 b=rYN6htbnh7cWfF8y3oPmuPp8tx4XQGWcZDe07j2XUbvBZtgvg9ou6/l/pY+XZd2bu8
 TprmOgPTcfdmSFQ5+Ip58kuHVW/+9MfoRA9P8G0uqfAKhyqL55q+U5z7e944qeQBK3Yi
 0HfiXV53R88wfNPQuct3+jlVfJfD93w9vqvJrkDrmGfnrBCM/bOrow0Ap80yPOlG0Ufx
 vlU5KiXNCIZBLNkSXIjtt3zC0fzEJx/byFFZRn4zQCs8VLH18fKLeGlfY8xoPEsRMAoU
 v4fmSthBbugja4dCrQI4xHuGSH1W+DmK1oyO7+EI0i3oGoU8oy57Vr+3O7Un8kukTHoB
 jAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912779; x=1793517579;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vmjNfkKwfExbxIkCyDHPKnI6gvFtZpjg6M21jdzCrg0=;
 b=H/r+bKekvGZf4hInD4otRF2kugejgoUOAd+ks3JqDMcoFVW04bP8eRQN7eT3tkBg97
 t33R1YyJpnIDbpdkIozcdp3b8p3vdL9GTkyr9FOCfGd4JDvHiLRBq7CRc/K4F52bB1Oo
 a2uy8xyWmEQ73Zh17Xi6bir6h43HcuG4HXZEGQ6v8HBdYdbZa+9mzxPyBoRp807AEbbB
 WVSS1i46rCR3a+fs7EQnM27NamdiegDgYxEaxAA5BY5mlcTvc+jPkdyHOmIfGrZyXefn
 UShNPmnWbbRK5AZy655m2rPDHHeEzAGZPLiUDOqwRdMMzEfYzg85VB7gBRa650O9p9mS
 uTLw==
X-Gm-Message-State: AFq9FYI4ZeLOn2O+NkR/JiaVWKYh3O/xkY8AS/hkyZALTOAKjYU118ad
 oGqqFoTTMrSk8JJVxEF6yTRgVeZEzJ55ltLikEsoeLZssxDavUvYf2+3CRLlrnWOvlYSlZ5O9U/
 ZKZJl39k=
X-Gm-Gg: AYBFou2v2S8dmZcKSP+CgogZJC7Fqbt1Q/UezwSCHL7G4AgAdrWwzbBTVzuhhkZ8tDi
 XAa2nmikJDYSmBBct/XwBzglrxscAJmLay+B9NHn5nuA9brk86f37qh7SZNQJeEEJe7Qe2VaGDE
 /KnuUgmbFEEo2Q2Lcn1j/ViN2tA5aPG77wOdgN7D8ab3r5w1uRiAPdNGTPoYmZPIs5paTNExhIs
 U96UMfczbk5MmAc0XEIav8p5MkchA2jSUC1y0l2elhfxNQcqlU+a7zyC2tQNd0hgM3uOFsLYRq0
 PtmdnY0WKmXvEBCnlTmLYkX5m1AkRjg86Ib8i03Ss/VN24R0CYyZ+wCt5ImGz56QvghhO4xXKuO
 qMYdnqrBwOyatDzWo6oC8loY3GZW2NQPRE3+q8vJR7PiWA/ZzIxL2yHTDSrK4OVMhKYBsYXr69W
 Nu/AdapYT7jbOEe05imuC2142wNY5klCwo68MluJHdHcWZJbH4kcCkRvsv5umG2DelFDV1x3NSH
 +iapMGZTX9xGzw3T2llL2b8hwBI3OY5SLU0iGHSIKMD01elxvNVyvtivg==
X-Received: by 2002:a05:600c:34c9:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4a35acebc28mr57172525e9.33.1792912778832; 
 Sun, 25 Oct 2026 00:19:38 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 017/100] tcg: Generic expansion of tcg_gen_or_*
Date: Sun, 25 Oct 2026 08:17:52 +0100
Message-ID: <20261025071915.1123867-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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
index 54ed9c9f6e..9cb9089a90 100644
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
index d6b45004a2..8dd3929060 100644
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
index 4e7ff03b34..b330d0fdb5 100644
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


