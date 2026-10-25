Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3E606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KqhcsCKD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsef-0003D2-7W; Sun, 25 Oct 2026 03:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscz-0008RW-V2
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscy-0004ax-5p
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so7904055e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913207; x=1793518007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7JJOUrGnIkEoTytcmJVvhI04A9HyoksQ6V3geLiy0QE=;
 b=KqhcsCKDP4J54kYNGVaLyrhVuVz37Cg/P6DxYZBeiUwX5o99YHWbmPmFG0wlxx80eH
 Auu80wQ87gTZIuP20ZRgd+gGaJOdqrNZ9H11D8FkXp0gR9wpfTKPtX8pTHDSEn3Xy0yE
 DcTc2pEV7816383w35hqxtLL/ab4UCAOHAG6a2vu9TjsuWflg/qVE7joxN7cAgKPNoXn
 wsT5KRxDo7lmSUHy9pTO54DESBHgSTQaHP8VF2m89OoTiLHar1MENes1nImCvZzhSi62
 4cSLuROyyQvNWDXf3AJmETpKw2D+xLnLdwx547vgEiz4LTpvwJITrO5MyxFkyRziYru+
 mNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913207; x=1793518007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7JJOUrGnIkEoTytcmJVvhI04A9HyoksQ6V3geLiy0QE=;
 b=Zyzn9NdJh+WSzHl3YNDSYaClrsOzO2/ATIablNXD9CCzlCaFu8R3SUUsfHEkyHKqLx
 CFxbAuFJh8mXTHISHcTsMPYbV1gS02bS7YUlvz16cL9ktRUTZ7XuFGIJz95EM41wIcva
 V9fwOaRB2E25SBf4vONZxzxZbnUa9fdNzU0FZM4bEe6fHK38x2TpWXLIot5KJ7NHrexr
 8OwdjTWfdmeSLAxo1Pzh3m0O+9cGd9csUS02aR74QmoGr9MgtmMV9YTcSnAnNkCSYrhs
 yTX3nGMAR2Igj2FiiRrG0sZmjzZg8HPBXCevwSocj9w6uE83yFATCOzzhs233dBLwZA5
 n/AQ==
X-Gm-Message-State: AFq9FYIp8qKtffDWdf99aRPkO8uNeFfVOJ2XHjU8/nRcx2TZIhjlk/WZ
 p09Mmn32ZugHdDP5M/t+BTTLrRkCIQ05tPPmY3t8QqbWY0m3LWwt5vt8zP+BCKb0Mj7r5plIXQ/
 KP8gHopE=
X-Gm-Gg: AYBFou3xVhb9pL3C6bvk4YuOO8Wl7agaw1cywO/rhjWAnwcvGKMNLQAiVhoUC1jpXbS
 3i39HjYxWXBV9gNXzhpgBGC3pJOG7Lp4hFY2ag8HNcHYQrOKygmaAsBGoAXtKw2MltyJlOqRYAq
 ntTisabbhB7+rns/VJlC4tXyW/fg1IVYRaiG2HkoAv6ntHGB/JYmrDwZagF1sr+sRP66xfGnwwb
 gfcjp1CakQR9OnGFhY8fcCvZoZxktN0kX1g8wo64yMuvzqCGzHqGpgLNHNk1GJQElIpi0H/CoZC
 GtXeqIXJbwC/pzyqqXLrnK/DOMG6MBuCYFgsCKTWgee2WOIYnUXcFF+rExvIBPR1h2oLx9u42BQ
 qeoGjx7hA2pce+Cq8RbRnfXxI3JB4KWNcSTzXkt6LO++ExFjVSyrhYKyJpukTOhlM3B2R1rngeP
 mL+QqJgOYJkP+7MYl/iNHj+iSVEuApcSERGqZktedrrQnx2y5UwTjy/Rg/HHXx/9Hb4s1qJuohl
 W5aW5KqkDgZUmu8Ev80U+BzXkk+/f3zKjKNZP7x+qx6WrtDCMpaCE/zCTAA
X-Received: by 2002:a05:600c:8518:b0:4a1:a49e:a925 with SMTP id
 5b1f17b1804b1-4a35acebf0bmr58013405e9.35.1792913206570; 
 Sun, 25 Oct 2026 00:26:46 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 086/100] tcg: Generic expansion of tcg_gen_revbit8_*
Date: Sun, 25 Oct 2026 08:19:01 +0100
Message-ID: <20261025071915.1123867-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 tcg/tcg-op.c                 | 51 +++++++++++++-----------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8f8560023a..3a577beef4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -135,7 +135,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
@@ -161,7 +160,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2ebcf4a066..ab1bf25929 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -49,6 +49,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF2(revbit8, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0d33313517..15a7d49baf 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -119,11 +119,6 @@ static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
     return tcg_gen_op1(opc, type, a1);
 }
 
-static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
-{
-    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
-}
-
 static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
@@ -1014,6 +1009,24 @@ void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_revbit8(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    static const TCGOpcode revw[2] = { INDEX_op_revbit32, INDEX_op_revbit64 };
+    static const TCGOpcode bswapw[2] = { INDEX_op_bswap32, INDEX_op_bswap64 };
+
+    if (tcg_op_supported(INDEX_op_revbit8, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_revbit8, type, dst, src);
+    } else if (tcg_op_supported(revw[type], type, 0) &&
+               tcg_op_supported(bswapw[type], type, 0)) {
+        tcg_gen_op_tt(revw[type], type, dst, src);
+        tcg_gen_op_tti(bswapw[type], type, dst, dst, 0);
+    } else {
+        tcg_gen_bitswap(type, dst, src, 0x5555555555555555ull);
+        tcg_gen_bitswap(type, dst, dst, 0x3333333333333333ull);
+        tcg_gen_bitswap(type, dst, dst, 0x0f0f0f0f0f0f0f0full);
+    }
+}
+
 void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
@@ -1347,20 +1360,6 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit32, ret, arg);
-        tcg_gen_bswap32_i32(ret, ret);
-    } else {
-        gen_bitswap_i32(ret, arg, 0x55555555u);
-        gen_bitswap_i32(ret, ret, 0x33333333u);
-        gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
-    }
-}
-
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
@@ -1581,20 +1580,6 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
     }
 }
 
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
-        tcg_gen_bswap64_i64(ret, ret);
-    } else {
-        gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
-        gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
-        gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
-    }
-}
-
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-- 
2.53.0


