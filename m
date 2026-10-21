Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C1606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fgpZflNz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXKA-0001eH-1X; Wed, 21 Oct 2026 10:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGa-0006Ji-8u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGY-0002XO-0P
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso636724f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592764; x=1793197564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fo5p+IzT1gODdkIbS4T9SsZ67uYhowJ7/G8d9ii16lA=;
 b=fgpZflNzMrVaORO5VRY1p2N2OHK/xQjnZiCFkM9wAZw5HGhmzAEUmYoQ1JoC5yY1vv
 owJ+ce1t+cihLaepaD2iSOmUXHPCbxheNwyWN65D0e/A1FegCUVRTfDar2y+EgGz9iv1
 haKPeXHXm7kNX+9EWCTKgtC1TPQ+EXDikJI02+eHbVf1nYKHUZ29b5b5NOkODNhJMnNt
 Tu3xbPWIPpFpnZo3iEuGF26F8rzr6mpU/ksD5opwb7FNOkSMu1r8p814nW38g8aLSPnS
 2LmPsp5lZozeUjSCEF0zPhlsuC1oDeRYF9E2Ov4NRBDYCvwgrLYjQhISr1TX7YGGvxv1
 hxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592764; x=1793197564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fo5p+IzT1gODdkIbS4T9SsZ67uYhowJ7/G8d9ii16lA=;
 b=e4Cns+mZAjiPdXx3C61qEV/q/eMmyfLJd7KlQMoaynImofpsTJWDw2cv5QC/r9M4Z6
 pSZINwZ+KZQRMmZx2sFjQPL9FX0iENR5kuQCMaTAZ+99K55Qu6z44VkIPwR4Dd69C+dP
 UYqa6YcdOYKd5JRAjp0UKiKA02/9fVV95hKr60UGVpYasjP8naNS0FwsPnt2DljZcInU
 JLgfhy0A68Wf5cIlbe8NsGLYxY3JOYILvAiSiQYeFQlIfHP1hgB/HxmSlcbd9i282ZPz
 N4ThHSHsFFNT5or4NFYa6iH8cmO2EkrOOB3d2D91V5dUvjYvLgRwZbKbrFftFievv3di
 iixw==
X-Gm-Message-State: AFq9FYJknxiM4AzpgzWFeGizw3YxaE2Fp3NrPvcaATLb6iQXo1yVDdX2
 iuP7iego8t85XZiTI/cKoro4p+KPVxKwZR7LSBi2cZzZzak3LpfyaX0xt9/Xpq+ip+ELExTUBUb
 2AljDo4Y=
X-Gm-Gg: AYBFou1RAZ27cDhh/P6CrzhdzE7g0SXcwAU2leyWsXsYlSmalqA5PMJ00TRIWNYScOz
 slTybpksoIDvwvEEkY3/LpZGQVVd70Az0HU9SjX3+TLLNTMYk1d/agTuI5WMNmx6JDCgu2Wplnu
 t19gakxGivzP5VagQPorHTWu4qP4BzXqEHD1Yw4xdRibEHGNsVCBIweXiBLPoy7MLW2hVn5I5kk
 ipCd2GaCUOOwD6jw0WATQZe3mqZpf51RhlfwRfqU+Ms9BIBM1DeLgSb2qvEfSAOqVoEKvf5yCyQ
 xfnz5mN3lQA4Elm93LGbbyOaRl/qlzz6Y1bSn8drUjOn6pAnU71BaR6NcfNrlUoWA7fi5lh5sRd
 GF6kJDMlFoRV750sWOZqVn2AH628By439CeWmdHDrXiahi3XrNeF2lD1cKKgiQqrWB8GBDelZEg
 jFkibNBZ038shRyxo+rJFVREwxQXWRh5b+KikCVf67g7KTvWrEInBcSI2rkCOLEMeROXCtMX59T
 vXuYmHJ+TvecB6vDv065WRjtw0wHwlMnDIFdjNXT2qke9sPf3EiPTid+kTyf4/E+2ZoNhSVRaLQ
 UcuuRk85YQLTOf6/cXk3Z5ooc6w=
X-Received: by 2002:a05:600c:3b22:b0:4a1:dbdc:b2f1 with SMTP id
 5b1f17b1804b1-4a1fdd141f5mr47419535e9.14.1792592764460; 
 Wed, 21 Oct 2026 07:26:04 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 084/100] tcg: Generic expansion of tcg_gen_bswap16_*
Date: Wed, 21 Oct 2026 16:16:36 +0200
Message-ID: <20261021141652.363109-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 tcg/tcg-internal.h           |   6 ++
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 120 ++++++++++-------------------------
 4 files changed, 41 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9f5cae36c5..8f8560023a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,7 +157,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 09899cb309..d6ea11d8fc 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -108,6 +108,12 @@ static inline void tcg_gen_op_tt(TCGOpcode opc, TCGType type,
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static inline void tcg_gen_op_tti(TCGOpcode opc, TCGType type,
+                                  TCGTemp *t0, TCGTemp *t1, TCGArg a2)
+{
+    tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), a2);
+}
+
 static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
                                   TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
 {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b606aaab12..2ebcf4a066 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(bswap16, TCGV, TCGV, unsigned)
 DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c3a8a04a4d..f1a79dc921 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -425,6 +425,40 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_bswap16(TCGType type, TCGTemp *dst, TCGTemp *src, unsigned flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    if (tcg_op_supported(INDEX_op_bswap16, type, 0)) {
+        tcg_gen_op_tti(INDEX_op_bswap16, type, dst, src, flags);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+        int width = tcg_type_bits(type);
+
+        if (flags & TCG_BSWAP_IZ) {                     /* t0 = ...a */
+            tcg_gen_shri(type, t0, src, 8);
+        } else {
+            tcg_gen_extract(type, t0, src, 8, 8);
+        }
+
+        if (flags & TCG_BSWAP_OS) {
+            tcg_gen_shli(type, t1, src, width - 8);     /* t1 = b... */
+            tcg_gen_sari(type, t1, t1, width - 16);     /* t1 = ssb. */
+        } else if (flags & TCG_BSWAP_OZ) {
+            tcg_gen_ext8u(type, t1, src);               /* t1 = ...b */
+            tcg_gen_shli(type, t1, t1, 8);              /* t1 = ..b. */
+        } else {
+            tcg_gen_shli(type, t1, src, 8);             /* t1 = xab. */
+        }
+
+        tcg_gen_or(type, dst, t0, t1);                  /* ret = ..ba (OZ) */
+                                                        /*     = ssba (OS) */
+                                                        /*     = xaba (0)  */
+    }
+}
+
 void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1294,49 +1328,6 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
     tcg_temp_free_i64(t1);
 }
 
-/*
- * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
- *
- * Byte pattern: xxab -> yyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-
-                                            /* arg = ..ab (IZ) xxab (!IZ) */
-        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = ...a (IZ) .xxa (!IZ) */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
-            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
-            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
-        } else {
-            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. */
-        }
-
-        tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (OZ) */
-                                            /*     = ssba (OS) */
-                                            /*     = xaba (no flag) */
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 /*
  * bswap32_i32: 32-bit byte swap on a 32-bit value.
  *
@@ -1495,49 +1486,6 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_extract_i64(ret, arg, 0, 32);
 }
 
-/*
- * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
- *
- * Byte pattern: xxxxxxxxab -> yyyyyyyyba
- *
- * With TCG_BSWAP_IZ, x == zero, else undefined.
- * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
- */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
-{
-    /* Only one extension flag may be present. */
-    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-
-    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-                                            /* arg = ......ab or xxxxxxab */
-        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .......a or .xxxxxxa */
-        if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i64(t0, t0);      /*  t0 = .......a */
-        }
-
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i64(t1, arg, 56);  /*  t1 = b....... */
-            tcg_gen_sari_i64(t1, t1, 48);   /*  t1 = ssssssb. */
-        } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i64(t1, arg);     /*  t1 = .......b */
-            tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = ......b. */
-        } else {
-            tcg_gen_shli_i64(t1, arg, 8);   /*  t1 = xxxxxab. */
-        }
-
-        tcg_gen_or_i64(ret, t0, t1);        /* ret = ......ba (OZ) */
-                                            /*       ssssssba (OS) */
-                                            /*       xxxxxaba (no flag) */
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 /*
  * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
  *
-- 
2.53.0


