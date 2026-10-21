Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CE606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o401NxqL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXKO-00021T-3a; Wed, 21 Oct 2026 10:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGc-0006Ob-B7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGa-0002Xr-5r
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so509588f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592767; x=1793197567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uDWghHyOGU8lSxUQ2Lkf846sJIbWq3EndeBV+dYuxpY=;
 b=o401NxqLAz3/399hgk6Zurx1B8TIABnbDX/1NCG5xwMFA4LRxG+eJyov0+tGfIEu5l
 rKSRP8PpxCZG56fXss9RHRpdL5LX5zE4xiGM0hhN8wTHkoTVY4UPOjJxhf5W9KEdSJ4V
 gNE+Z5l+UuEXJVyVYaMl2KNYrXdqQbIYXN9t+B2Hw17LeKCc8i6W5Vj3Uitmqx7+28Ds
 nau9Mxms1vJaHQDCPcKvMsFHOPCCIQRIRl+IyyznKNxh1nTNNDq/G1nI0U4fyUVbjV0a
 c27QgYjG60Q90VxwLAv3mdgcA+kQp0xnaLhGbg5+IJHJWp+v0vWJss9bNOiTv66wdj5o
 bPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592767; x=1793197567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uDWghHyOGU8lSxUQ2Lkf846sJIbWq3EndeBV+dYuxpY=;
 b=EO6dRiJM2Z03a5CyfEOOzZzubNCoEmnqeMDzX9q05Y5x3XSiyfyQR/3vEr0idpz1T0
 s8OWzNGa7nTPg2ojHUZnt8vTWAmHT60Bz6w+kqf/jgrl614pTwigCwSUu+USEg+oWjWz
 aoLjQlkKuo1OXWhNOwPL7uskg5ccPt/uNimPEqmRtpAU/5jMPfYpZApYwRn6Dd4hWoW0
 /7V3RavznwTK9ghcMpVmpxBY6b/7qX4AgnovFmS1+epa6O/O76CbZrNz32gzbmt1CRfX
 UeUnG/maAAwfN9cvgvHQZoBzEouLnBy0yK2MPvPkW3SFDoKjAu9Ixfs47zQzps3ZYN3P
 3U8A==
X-Gm-Message-State: AFq9FYLrBAfM5/PlNraXkntW72bPgoMKvQEczLToR4ACt8xmomS1eFcj
 uDfEo3F4rLdMwze+q8a7vHmGfEjU8AiLn+bkSsic+RkZpGPMtpb/IGoVnyjU91ybfvuFJZDeora
 z3zjz3sQ=
X-Gm-Gg: AYBFou1Q4ExLewd8IXlYTeqs5t69Pzb0oYEjlk9GdMEEJ4TOEZ9E16yaiEpSx+LaApn
 HBim2URlIcRhOehLDG2QVoXstIalp0/DtbQWAObL9LII7wC4Jg04eYkQoXo3zDzepZF2LVL3P2l
 04v+IFMa1glLhPnaDWrCj2U1DRXSjXfIlbjpOFs8yrvIQNZt2jCnDg3iydEC95ZrXG8/sHmD+/n
 fCOfX4cZf+Z/Xa+0d2HgEoCsVuTLQCpt2Q9zaDzTNXNyWYSud+U/Ovl1HsFYe7K0AUCgAMJeu+7
 6ScVGWcrEPtfVRC9VpbWEdaaePbFNnFn0dBXehZD06/EDlhX64yyaRoLGPcMjhRqKSD5hGefA5a
 0i+rQHGNCMud735g5yIsZMVmslWB/P2gxXFu6h1XgJa7l6mgri7YvqrvePLFeJyKlffuMhgDTiN
 4bfKbRfSvXfbMhcHzdgw8n1b/rDh82M7LpAH0G6KbBGZu4i3bsftg6+90mcMcM2nl4HkMGBpHXF
 GHwFsxii+lfZUS63xIwZOrzi1S7EWHEsLLP0ZsBwnFQwD9hAQjGX/EWBsefYqTMiBnzqe8/ekIS
 NXR/6w4IRWQnNCx0wkBfOWB12vMS4sZS+o3jj9Cb4IvLU56nVw==
X-Received: by 2002:a05:6000:2884:b0:48c:4f6f:62e3 with SMTP id
 ffacd0b85a97d-48e26493de0mr4392390f8f.18.1792592766574; 
 Wed, 21 Oct 2026 07:26:06 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 086/100] tcg: Generic expansion of tcg_gen_revbit8_*
Date: Wed, 21 Oct 2026 16:16:38 +0200
Message-ID: <20261021141652.363109-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
index 2d24e21f3c..7bb0bceaef 100644
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
@@ -1013,6 +1008,24 @@ void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -1346,20 +1359,6 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1580,20 +1579,6 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
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


