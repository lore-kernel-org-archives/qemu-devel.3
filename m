Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA00C982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOA-0008EW-OO; Wed, 16 Sep 2026 09:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNV-0006sZ-Kn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:46 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNS-0001Un-Ne
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:45 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc88a9d1so501532fac.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564121; x=1790168921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N/lRvRtzfXec1REjTTMLt2p9CVJCr5BwD560QR4opcg=;
 b=rIICU6hH+WqQZhoiI5gDU8s7Z6wI3LwTa+df6WHjAkMToxtdUm+5UVR7JkwK2VhUOg
 1VdIJYusAvMqeybgPq+TPj5BSpWrShaG98BfiH8lqqACiLRd+6m+vHKNZZNObDoRF06k
 x+iqJ+RmHIGsGgGNydsY+mGoOn1xXDQIflbklAzIac5kk9UTAtxyM6NqPp7it8142ny2
 w3oZDExmwblfeEOkuxwtmglgz2kuCxBZRtK7Gwx87XgWlL9CTv6fFnr6HPyhDMRb0oX7
 CRU25xHqU2Tbyz3c4FHNbUPE6or2xJaHP+ncf3wZDHNZV7sPBlb65EJ4Eo+WVwHm+uvM
 WgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564121; x=1790168921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N/lRvRtzfXec1REjTTMLt2p9CVJCr5BwD560QR4opcg=;
 b=P08kaMolmQ2X6BxIu6XnP4I0wCL4YVZ82emhaIykCX0k8tokVg8MekY7SClE2jCBcQ
 A3caFOS+nCySdhMSH+K08dTgKRclg6USnTf8vYShK/VG0m8G6OXP50HE15Fhxgf+zedI
 iaTwjFYuGfjEFBoMlwjbWKi+xBXmFIvkwaIhovMmawTgbFGJ1o3SqPtkPCbbRVI4eVcJ
 k2c5LmaUHQF20Wqjmh1VgRgVU5hdAs8HiZ0oNZ8UmpDV0x7GN0DvGq/tD7dQZ47SNh1f
 ioIbAvc7IvLacKLSgacm71HHvxik9IF99hxVAJWOIy8OwSasYENBXa8/O7gNFxGyOzJi
 JOUA==
X-Gm-Message-State: AFuF++kpPECEMXUQyQ0qGwtjnkrXkFUU0s5tW5+MhXecutrP1+F+IiVI
 E1T2bJzzGV1ei4jktZ4jOSjqdrTq4mtejNkcvpChomQKf05RseTrubKFP+FWxMZV1OMgCyT1XL6
 +va1GNsI=
X-Gm-Gg: AYBFou1R6vpkQJbJWE6V0/7QRAhGJxIH73HLIoe1Xk+u0uhTRJJADY5FrYwfoBmDiZy
 OCmkqL3UXFmkmZP9Ag2WKx3fXhP7Hwq0eZA/Xylh5cg7h9YRt84rYBPk6cHSpZWtizh3ZdZMzzF
 zzpI6S7Jg3tRt1iYoFKT3qTONJ846sd4pXeBRrsZz2oKhhch36Edbg42T+H51GqKJr2BXt7hBXs
 XcyRJplrgjphDEIS6DR2WHrNjmXLFoM1OmL7SODzSShmb+aIybkNcEU617Pwyyrv4E2lSwt/SRg
 OkitFMMrUmNnNF14Nfzva8tnhhnBY9Pd9Q8Y5wRwVBOXHlV97PCcu39vsEjVwHnzwURxUX9OdzL
 jrj2cBrmk/U9P6k/OCLNfaEUZQPtOGL+qRu4ZR0J+0Xe+Ac1K+7lASeduBmcq+XXtGeepg16HCV
 ciBv5Cwo97PRDy3qHLUr+u480N58mbxJRVEHr/VPzAmdkSjl26oKbdOnUksntXr8ZkboDuzuc3w
 8lchJ0=
X-Received: by 2002:a05:6820:198e:b0:6bd:a88f:c8c7 with SMTP id
 006d021491bc7-6c7d2df70a0mr2421158eaf.45.1789564113643; 
 Wed, 16 Sep 2026 06:08:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 60/92] tcg: Generic expansion of tcg_gen_rotri_*
Date: Wed, 16 Sep 2026 03:03:35 -1000
Message-ID: <20260916130409.3382710-61-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 49 ++++++++++++++----------------------
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a1c32214723..aa5257d9e31 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -183,7 +182,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 35542e003ef..383a13aa1e9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotr, TCGV, TCGV, TCGV)
+DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 66beb4a07cb..1d31a1a3f1d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -893,6 +893,25 @@ static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, width - src2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        gen_op_ttti(INDEX_op_extract2, type, dst, src1, src1, src2);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -1006,21 +1025,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1795,21 +1799,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


