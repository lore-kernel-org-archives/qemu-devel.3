Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67024606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lUuU1nta
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWE-0006Gn-MP; Sun, 25 Oct 2026 03:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWC-0006FH-6P
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWA-0003ij-FV
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so385999f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912785; x=1793517585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6fDeRxy27b1LJ+tlJajpQmIlspS+2p/nRA0XVLa9pZM=;
 b=lUuU1ntab/bw7hybkhOnY9xL3mboFvRlLd8mLC7AU2cO6qOhHHUhny+/KD7SgUJkel
 0t9PR8Z1CbYZi5kckH105NVrSCLGrc1ZXvv9I/e97auRUyVeb/Rqau6pUVq+MJJ/krId
 2x+IhwkFiJh/5F4awtEbFOD2bxlcEv0AMM9o7rsbTIpFpSeSaEJHgiIk37EFu3veyjgx
 6T9Nor0wBKVnvxqMP1Ye9Onjbe8kpwarLssHy2l1pUdulE2HHSBX0jXgs5jOYyCW2VSA
 9O7u5PzjM4PRa/4qOYGBcQDGNDp1J480qqmGsTQB/KmLwMx7n5clpv9OKKmCt830T4Jh
 EorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912785; x=1793517585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6fDeRxy27b1LJ+tlJajpQmIlspS+2p/nRA0XVLa9pZM=;
 b=nQPic5nCLWQdBNovgVqUoN68kke06vWfI2Pp+O+G9p37j3tJuDTPiUzg+Ol5ImHJ2B
 FpF2n0CxATNn/whpv2pYvsQtpccvBMTJXY+phBTNYMwycarB73FfUAlE+GVEaQ7CX4zI
 X95hXuUp234f5W7Bb5FImAV0nVuqCW7TYTuFG2rR4cX1kSf6ZGVUpn+H5LK3Dqq1ttI4
 Cbi9JHQ4j/Fm7CGQgNV1m1gOPpEVcAMVSoGqBI8Ze2svsvJQ4e1JrhHamWm0wUcG0nxR
 f1hxeaFgb+JWrVZeVRRTWDM7LkuNs17D5KdcEcJENSeFM+ZVMZMe7BmcZaCZs8zMKG+t
 vhJg==
X-Gm-Message-State: AFq9FYL2T/R+10q3Pirv+MiDRahMaabpkdhY2H3rcUMbN4PVCMMvMbPD
 ++Zy3ehBiQYAKcWG4Q1v4SYh+8VY7kRwZVKJboJvyN1bDOkJZnRODInvfyxR5NhaAerU5+okdv3
 oKUbAilU=
X-Gm-Gg: AYBFou2Nde562LP3IAD2GCuee08FBjcb3RSzNL7Sl0yGety/buQy6z1DfKcWq3zPn3I
 131qwMQzHXmg17b3I4qyvx0tcTnM4O7qQPj+8hKwFmMpg7UE6Bs5fggSz6BjfAmKgarcugOS4f3
 9UCwiQx8iZnITyvyaqTm99gnJboraPeN4El/qPBKt0CAZo7yBpxLXYFoVav93Y1IOIo9SLAC0H2
 oxFvovF9kgY2YaB8dnowPZvzpm05/keDUfxB4cFp/c5XRUSbmrL7vtHwANEv4oVUX4PHOyEufTV
 G5aD5ypb48L/vZFigPBcD3eAuXduJSgWHnd6reOF/9SvX9djjAVyiRyCdpNpn5fChXXujVRpEqs
 /84W9eStcyUGZ54lrbRC7k23L/8fMX7gcjqktPG76PzOTgnXlcNsjgdY+Z11Gzt+PRCF0onWy65
 QHk2vaOZdWXJUDzkwhVqdp9PshlnmHVo+tS2FIGEOsoC8a04lm+UzYfb+rAAPOMzg6UWWjHAAxt
 MFq6nLMTUsYzRZcrrOe1fBesCGlPVWwSzZ6sGg3XlYOp4z9fUs6F0nSzw==
X-Received: by 2002:a05:6000:2404:b0:48e:314:f9f2 with SMTP id
 ffacd0b85a97d-48e3eb2bdcdmr5684787f8f.8.1792912785027; 
 Sun, 25 Oct 2026 00:19:45 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 023/100] tcg: Generic expansion of tcg_gen_shli_*
Date: Sun, 25 Oct 2026 08:17:58 +0100
Message-ID: <20261025071915.1123867-24-richard.henderson@linaro.org>
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
index 76e67acab8..dec1bb522c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -217,7 +216,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c1273a1019..c47de1a3a4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,6 +12,7 @@ DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1e85ff545b..8fcbbef694 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -424,6 +424,16 @@ void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+void tcg_gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_bits(type));
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
@@ -520,16 +530,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


