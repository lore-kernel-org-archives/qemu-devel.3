Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CA606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uWxFF8xp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKseK-0002TU-VR; Sun, 25 Oct 2026 03:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscw-0008Nu-Aw
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscu-0004aM-Hq
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so12547795e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913203; x=1793518003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J4y6XH+Lqn3Cuu6JRCOt269N6yd34jWR2i3BrGYpPKo=;
 b=uWxFF8xpZ8/ePHS6RGLbWv1qjIQ9pPLwuAvDl4YLT7Z2bI2GfPSUccxA7trJg/0/JK
 2/f6eG5un9YnFN3mPQDkROVZhLaAk650xS1Rvivss3w4SX7BIBwWKg3grl+2E4TDmYhg
 4J0uHCNYyWpXHcWfyK1V9uHwd9/pHWpbb6CQgVttaO3/ALxwonqawXZUD5HvlPsmJnUO
 hmxQSJ+zGCzQrr6iHGcLLQylSPriGpVzH53ArsDNm8ZP2OIHAMkIrJwzBQ5W1YbkdWC/
 RFtqhTDyA+lghrxXPc0zpXt9QUKdzXyz1RD779H7H7fXKkN1Zqx85IP0GoqER8A7ZzRd
 lNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913203; x=1793518003;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J4y6XH+Lqn3Cuu6JRCOt269N6yd34jWR2i3BrGYpPKo=;
 b=UCWFqOnk5mYTTo21ZB89OGwTlpKu20ydqM3KSrh89s+qTHff+LH7JQhBIeshfWVVL8
 5ChiRoAYtP28TmDgzEqfCAouq1k4E9NhVed4CuKc6qjSaZnWLKtR1kLcbolYLnw8eiJd
 /TOKRmpeGQIfvqiX1d0n4XjkcqiW407fmrx5091KQXoaPYJ68wVnyc06IdKpq5wj8W09
 thN6RWSvkJB5uj2Xre8o2aBwfqJDAoA1iiTvLd3j3tfAnaELIX2vjvX+npqry1nD3CYg
 kTsqF2UGtD742CvyOyuKfEnMHgFsLg17AEXJ1ZuBrcbOgbM9YwgLw9lSdEdIaEp04E+J
 EqSw==
X-Gm-Message-State: AFq9FYKOsjc62s7STWrlAuTOXmVb2T3ltjVJxF9TG0t41AY8WaqxKYcP
 /EDI7WpgWd+07IVsKXMIAPtIrmJe2H/sM/kH+kJ+Nc9UQWDC7Nnoiw5XQRJ/vOKKMx+OrHvCTys
 gRzdZMsA=
X-Gm-Gg: AYBFou0m/dWHHMjE9V0o9mLslTL6P5NLEup8ZJjMGhDfuM+MImpG7E8sZm5btCEYPi6
 msydpLuLr8NGQdOQKgS+BW7dKG/kLvR23pvJE2lco8iCM4DjaFnQVKKt/tMbDt6EQUm3/TBEJqM
 UVaqs/TMxxDsyxgxdpN+4I8rCICSyLWIMg/y+0N0qEm583fZlTjkTr4QLAF4vtRzi/WcGYKDWWs
 FL2hlT1KMXG3sPA0JXPQAzGO6yKquqwZTXZ9setVYQcF2XTRdnYs9n3u+1tNFn2v2kjBC+DFAGc
 WRpWo88HmPZRlihIEwtuIlefBzb5XGct/pv93EWt+uG6J/wX4usBWko868HnLTliwvUvyL4LKGA
 +qJfANPeEv5XeN9fQohyB/+J3dqib55JVmFe6WteIq72vR3FxhLE9CeAOwPdIe7QUzxGQVhw6jL
 wZRobAOP6Dn1OdSwBOoqdGjgwpJr1SzochMBliJDy/3KGWDRize6DI0wf4OlaP+/gOzpCpYDNdA
 o3JCesg3q51P0bJRWxw73F5zpZAm4E1dAlPyQtheKSJb85psBvtq49N0ev7gYVbawNiTE4seSK7
 j1nU
X-Received: by 2002:a05:600c:6749:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a35ad01261mr55604975e9.2.1792913203013; 
 Sun, 25 Oct 2026 00:26:43 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 083/100] tcg: Use unsigned for flags for bswap and revbit
 operations
Date: Sun, 25 Oct 2026 08:18:58 +0100
Message-ID: <20261025071915.1123867-84-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h | 8 ++++----
 tcg/tcg-op.c                | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d3271c5a66..9f5cae36c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,13 +158,13 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index be86788297..d4c15b39d4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1303,7 +1303,7 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1504,7 +1504,7 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1547,7 +1547,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1614,7 +1614,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-- 
2.53.0


