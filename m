Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4A7C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOE-0008SP-Jn; Wed, 16 Sep 2026 09:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNR-0006od-4O
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:44 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNO-0001T8-7g
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:40 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so1095766fac.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564117; x=1790168917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LDTwxOw5jm7KSHZ01q6+YyZ1336mHY86wJnX1AW8yUM=;
 b=E6ubywWjGuKAxwJcopuTFDVZBWSKi2ASEedVYJeTF7qce+XylfiISHg+Yz9Qd0rbbY
 K9CCDSGy0L4emhvl7AFo/5hqWh/iho08ObIivhTMdLCKSK54HYbOXOR24kzvj3oMU1b9
 ndpBnn9q5O26g10WMPsC5W8q0IcdhjgsbqebNbXByu/rZREIIHCbMhK2cJivI9zaY6ZL
 eD7FNRFUoF+pIMN7hp1KdvvJo2I0WL++9mufxyXFqKbjApF9+mBfyjENs8qYsQDf8Op1
 UPd5V7Ol4J1/krSe/7FB2hmRBjQOhTE/HbAZC5tQ0M2Nl8FCu3HhcVP/imSJavTOzfme
 68cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564117; x=1790168917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LDTwxOw5jm7KSHZ01q6+YyZ1336mHY86wJnX1AW8yUM=;
 b=SwH564Ej1g71ATSxf+oL/q8fZsNhjMBsyx2A1yVhutaAzcqTRZV1KTv+iuHZWB6D95
 R3I6lXA/wh89ieuC5xjuTl4zcVZYWpiQWFCMw4ni5AaTWwbp4XLxfv4t7JcsWrMQczgv
 BBeuoLTL84PPQzxgz9N2RzNCJb/JQJpmO6T9msdsmVhW4zpzNkSTVJC9jUh8ItaFjfEu
 6hHQ15nEMoRmApoUYpJ/k//apMRStAEbW5lNhV2bAUY26VcoMdSpi0z7+QgyZqu3xVBo
 mHhZb7iU3fZE2+12FKLXg5epsUxcRx5nvIEXPpVpohibyhgAXddHFjKd0a56cHj7kjNl
 V8yQ==
X-Gm-Message-State: AFuF++lTBNPS7g0wth7xqKgMhwql6Y0Qd8slnaqHtg36FYeC9Df6AqtB
 +pK4BLktBHMWr8lSioHEPuPBqbb3NZwIQMRcUM5jddSJsEpGmsR9kTKZL/N4l2054IweKeT2Q22
 +nSbBUMc=
X-Gm-Gg: AYBFou3ofDr29c4VwHwo36ebjzxAx+rvpku0zExa/ikPhw0Cs1VWsgmC0DyIi0v1VSf
 cyDzBRjipCIFif8t4GJAWJIRLaH44u0Zck+dXGZX/cTY84aiCO3fJEfR1XLOEqtIiuObwsuZbmK
 0rS+ld5osy0CkvTxvZiGQENzt4eQZ52JaZwyA5ywUsc4opc8oEEfH/VsYuO+4D2m3Ee3Ra6F5Fo
 cKpoe314oIyeJ0TYxsp/4TIY5ae4MNUhYQ9/T+G6bM7Qn83DhjOsA1R18PGXRO/cOgwBoFnbo4v
 sPE2mtLhqLI7leBmz7M9tBHknSXwr+yiWlJPHXcvz5RI6KZDYJkxg4iFy+ngf18DJHeDRxZ+7fY
 S9XLQEV3lPmmo5NGm2PdBc7vtSVS8IW7pZblGEWyswz8cfVIwgzMHTE3q4I/GYUYPHOfUHLoIT3
 9YFyYmjwPr2dfkrojPnwqBQlgM8EIpq8rjHgSeOZoIHCRXGk3PAt3sdbThELLj3llZ0itEYI83x
 1vA9bo=
X-Received: by 2002:a05:6820:4b0f:b0:6ac:8e23:3078 with SMTP id
 006d021491bc7-6c7d15d084emr2528142eaf.5.1789564116374; 
 Wed, 16 Sep 2026 06:08:36 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 63/92] tcg: Generic expansion of tcg_gen_extract_*
Date: Wed, 16 Sep 2026 03:03:38 -1000
Message-ID: <20260916130409.3382710-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 ++++++++++++-----------------------
 3 files changed, 46 insertions(+), 90 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b9118a6df08..7973738331a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -134,8 +134,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
@@ -183,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a2244bedeb2..856338aa0d4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4cda5496077..1f40f121239 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -702,6 +702,51 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                        unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+    uint64_t mask;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        gen_shri(type, dst, src, ofs);
+        return;
+    }
+
+    if (TCG_TARGET_extract_valid(type, ofs, len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_extract_valid(type, 0, ofs + len)) {
+        gen_op_ttii(INDEX_op_extract, type, dst, src, 0, ofs + len);
+        gen_shri(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_extract_valid(type, 0, len)) {
+        gen_shri(type, dst, src, ofs);
+        gen_op_ttii(INDEX_op_extract, type, dst, dst, 0, len);
+        return;
+    }
+
+    mask = MAKE_64BIT_MASK(0, len);
+    if (tcg_op_imm_match(INDEX_op_and, type, mask)) {
+        gen_shri(type, dst, src, ofs);
+        /* Do not recurse with gen_andi. */
+        gen_and(type, dst, dst, tcg_constant_internal(type, mask));
+    } else {
+        gen_shli(type, dst, src, width - len - ofs);
+        gen_shri(type, dst, dst, width - len);
+    }
+}
+
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
@@ -1082,49 +1127,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint32_t mask;
-
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_shri_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1u << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i32(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-        tcg_gen_shri_i32(ret, ret, 32 - len);
-    }
-}
-
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len)
 {
@@ -1829,49 +1831,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint64_t mask;
-
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_shri_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1ull << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i64(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-        tcg_gen_shri_i64(ret, ret, 64 - len);
-    }
-}
-
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


