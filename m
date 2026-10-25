Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A1606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DK3NKdwj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsad-0001Ge-Ej; Sun, 25 Oct 2026 03:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZn-0006f9-Oy
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZi-00047q-1B
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so3118165e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913004; x=1793517804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wtsn/3Lg57ZzZyvsHwcaSNEXLV55bMqaAuDHgFuhoNI=;
 b=DK3NKdwjDOB0J3rY41WU45kM7mcY7H0FYOtNccnP80DqQwTKZVDmlVSKZTseeNpg8O
 mvgmJltvh4gfBHN55qiygL08XizTUWbFUq4TND1fmWT9cboXav4bvYKxIjBGdHmnO/7c
 Sw8kXptFZTYbQxzbVreQKi+okYYWuMePgGL6dofDknF1GunG3xYz1Gb+EKmgA6gmRHmU
 Z8jPMWzn0GfIczIPKz1RthIbAl6e9v5d0jy09Ts8tVyOSlUnT1G36pumVf3AUkc+Fykk
 qy9JuPBEBwk1SjcVPkVQd0x5zmzqiO0xRH/dZMUkyX3we0BilMliZV5HXm96cOIXlAnX
 pb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913004; x=1793517804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wtsn/3Lg57ZzZyvsHwcaSNEXLV55bMqaAuDHgFuhoNI=;
 b=n/o+ZYnvGC0ZH4xLRo7HtUEbLfRl2Hpj7kzIu82XZ1w9w3vpLfto/KAxFdzF0PgoNc
 o2G+yx7zIGtJMc+ZdFD5vSflyaNp9igXjIpbnNeeLlUVisR7H/2p+HNih25NknHSr0bX
 MX4sPGO6hobOa6mJX1+wbLfUNZGrYd194PK/wtM2yZLKDpe5bZ3diNZTUHv+nZNJ50u2
 KPl054z2W4RBE7744efm/AQPDbZZ/84L3o1drySj4IhxYzUr5dI7ElEZ0vbdt9I4aASG
 1zkIR3IQkumXYZGLi5/gQYaeiag7Wi6Mr/v8+uD6czSG6dgXwAjuX3Ostta2ooyRw1uC
 jBsQ==
X-Gm-Message-State: AFq9FYLcxsqExYAvzuYdAGJh35UCsocEJjJxipK0gPcraijQe1P3zhiE
 z16X2day56+XyXt/NzTq8v8kem5bKWt0J1f9dDq7PKTLBMm1iJbIi5RFrAxrMuOl5oyilK7fbRm
 2GMprXIE=
X-Gm-Gg: AYBFou0t/DjQ+8QzBW1HcqS1kP67BHzmUpzxnUI2F3uAPSR2aajCiO07fn2IFADu0hi
 Y8T28eBfHfXWEhXEtbs3DBWTHmeMvXtK6HefBbBQj2GsK22l87b6bZbctOSvGOIrw8SyOg4QN1v
 DVYk4Cd04bcnf+Y+kVOX68RBJL4dAIGcRC6yrLSH1B7ov41G9IbSOPifJEnl8S4JLnM4Gr2XYJJ
 8LZNOgPMyCthVblWdWOeCIvUiTt2hvZa4ClE6YgNKES7XDx62j4Ef5/GtxNZNOuEuN+WS2ouWwA
 nGuA45Y5nTf0MKabAPTkb0NSuSWqdJuox1VXQd7XarPClF7v+WDIPrZhDy+eDDLnHaPu5OKgCW/
 nsapsPVyP5X9vGyXaEZNOVPpRxyw+AHUJV4T8VCS8gxhJCFTnKMb1Ra5Am1Ppuv1eyWUZRRIuYh
 9J8XA2rqly4lxybIM0PFA/qmRy7FyF2cdLS0bVZhGaofSzUoTBdTdf2nIuZ/psOi+O4xn31gBYl
 qmR2brVXDnsFoYQ1OB8wBoEzzh2Cv48y/GfgirBsOSTvebXqsnlsUt8uNE=
X-Received: by 2002:a05:600c:8b72:b0:4a1:bd69:526f with SMTP id
 5b1f17b1804b1-4a35ac38ac9mr57409365e9.4.1792913003720; 
 Sun, 25 Oct 2026 00:23:23 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 064/100] tcg: Generic expansion of tcg_gen_deposit_z_*
Date: Sun, 25 Oct 2026 08:18:39 +0100
Message-ID: <20261025071915.1123867-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 70 +++++++++++-------------------------
 3 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 34a79c5818..85af0d4b6c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -177,8 +175,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 338ecce6fc..88e87ebc2f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
 DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
+DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f2928ae8e7..1d154fc12d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -197,20 +197,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGv_i32 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4, a5);
-}
-
-static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                  TCGv_i64 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4, a5);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -550,6 +536,26 @@ void tcg_gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
     }
 }
 
+void tcg_gen_deposit_z(TCGType type, TCGTemp *dst, TCGTemp *src,
+                       unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_bits(type);
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (ofs + len == width) {
+        tcg_gen_shli(type, dst, src, ofs);
+    } else if (ofs == 0) {
+        tcg_gen_extract(type, dst, src, 0, len);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        tcg_gen_op_tttii(INDEX_op_deposit, type, dst, zero, src, ofs, len);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1012,24 +1018,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (ofs + len == 32) {
-        tcg_gen_shli_i32(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_extract_i32(ret, arg, 0, len);
-    } else {
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1681,24 +1669,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
-                           unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (ofs + len == 64) {
-        tcg_gen_shli_i64(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else {
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
-    }
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0


