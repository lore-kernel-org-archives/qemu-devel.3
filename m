Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00B606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GRHM6rug
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWG-0006HM-Gs; Sun, 25 Oct 2026 03:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWD-0006G3-QW
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWB-0003iy-TZ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so1570553f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912786; x=1793517586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ox7FMY1NJd2bsuWKoexTmWgupO+TN584WQCJ/HqQcz4=;
 b=GRHM6rug+aJdngnbnQ+sohteDVrrbJNzH+/69TIrTTu29nAjlSjHiFFZjn0yEf2OrA
 sAFBg36WupqObLTxU+nCG0JTDbq1BfJsdGQ27WwEPhc05hPkLtcKTGlM8dRRT1+nV5t+
 pCUKA0WEL7uAcWcQgy/ouRPrUDzBxvxLSdMPY+MSYBixPmf7eULTgsPV8ymAzJQuIn6X
 +9DjU8kzWLG3bgp9Ov5tu2FrUxg6RbRyu+MiDWW4Q8QH0XVMyk/tNNsNDNbFjJyZgUAd
 fMc+XQ43f2DPRJrhU9CfTDvGiZAr3b/1YtpKYSvlloioBpJkF5eFNhXMt+/xN+W17FvL
 57ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912786; x=1793517586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ox7FMY1NJd2bsuWKoexTmWgupO+TN584WQCJ/HqQcz4=;
 b=lc1+GW0ZGduaUY9xx6oLDZfh2GMFBXrturPOQAghVpHxu25NNJdAiTQZ3JVLNUxxV/
 tYa6Gh6Ye5qfbAKGVDyYReOtjAzYApnho51Ax3BeNyvin15u1rhf+9DW8QjZA9bxBFKq
 ucbaO4f4EPdJLDmzJrXD4ZMQE7sP6QudQ3zFSJT+FoI5/5mSkjU7WJPyAwKjkug5SgIL
 EOooDG6GcPHXJ1RY26Dp7IDUoAnercOV/Pzd9rU1wvthiQlHJSlas3eQLfN7wWD09ZVq
 4c0i6MhKrUBAfqfPhJ10YXrDmCW55XTYikS1KPQ0nRHAeKLqeVEq+hZqdGKMCCmxCxsk
 hXuw==
X-Gm-Message-State: AFq9FYKB7/z0luWoMW7a9NGAc6zY2uf3M2z2gcCCxRbUHym8+f0cxXwl
 ZCX1VoYMKRHDkKBFtzAXvtLCyJaDSUDyafMtFvdwBICZYkIHn9m4/AEDd+m1HC5VIZO6JJ1Zc0e
 GO4g6ijI=
X-Gm-Gg: AYBFou0Aijg4GXBxRySxusM7NB1F58U1t9ufa5yvzWt6SXOZc10gMXsPKSEToBsuQye
 MX361A6VGUuHWzBMibvuU26BjIhcD5kqpY3AChiNRT1Uw2F8qTq9b527TheQyszI6h1++MsJtRi
 wNWC+pPoDkIqfs3aerHXyBIvid7+FFNC3JteUvrh7ABO2VwNWBpSSv0ysdkxgfmjxrlwaAWvSZf
 xsmSdYS/1pyf2Yelv0R/IHBok5ebSRxICn1/77pb/DuctjbsSwnItxR3cak6qfuKgPfuzGfMoWR
 JiFamBuT7jNpN28vQasV1MoYVz0eGFrpKfZmVNVh7d9UOfjNvo8lrXuNzsXVpMafWdIjAz+P5PV
 lIKkjPZ/5viF4wDV39TwYscLwjl6cdObFz6e3wjhRiDydJIOFwYCZJV6ebySGmKfO5Y46td9HIG
 MNXN2VttccgB+fc64f+7YTo509Qq1oT80vu/nrDovzAkL9Cr1WidFkbjT4gmA9N5m/juR03fu4y
 WbQheKhmhRAbqIeWJSjw/V67oeA9MHGiIRFuSJQdpog5bzuQScpwWliE8uIuKBAZULo3WsDzwVX
 SiY=
X-Received: by 2002:adf:fe8f:0:b0:48d:f852:c66b with SMTP id
 ffacd0b85a97d-48e3eb89d01mr4742588f8f.22.1792912786493; 
 Sun, 25 Oct 2026 00:19:46 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 025/100] tcg: Generic expansion of tcg_gen_sari_*
Date: Sun, 25 Oct 2026 08:18:00 +0100
Message-ID: <20261025071915.1123867-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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
index e0a93144cb..7ca448b922 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -215,7 +214,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ea641158ae..2108082ce6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
+DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b3f688228d..8c298ae79a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -419,6 +419,16 @@ void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
 }
 
+void tcg_gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_bits(type));
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_sar(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -540,16 +550,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


