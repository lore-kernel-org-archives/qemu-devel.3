Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FA6C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoX-00061X-UC; Sun, 27 Sep 2026 05:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko1-0004of-5u
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:21 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknz-0007fL-8Y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:20 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so1200275a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499858; x=1791104658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/kG7KGHZ8vpvulHnGfTtdd9Grzai//q09XPrURF4x0E=;
 b=VZzXtPSikstVCY6g/CwP0W9GP1tygAfIRzGr5xQq5seFZaeNMjVeTEUiJTKwgW5kxH
 5A0DtGxDUC6xDhct1R7pvE3NakwO3+eVoZ2iSVEfeWsS5OgSoVv4YiEKH6lhWG3GHFv6
 PrAflfXNKBXo0eOF2GIrXmj8ebpIBHAG5X7VUz2Wwklan5eK+78VZZMGAyJXFWFQhYhU
 RBa1QqvNN5kN9QympKYcij+In6FDU1yrxiTNta0306s/61cO68aRvWq3pZ5PwYzjfpy3
 d/ApAtsHK0UA0ELQ/F2AR1cPzmCbWlI/oRiT2TdvF63wvNozEv248ZEndzT/tS7xyAZe
 eu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499858; x=1791104658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/kG7KGHZ8vpvulHnGfTtdd9Grzai//q09XPrURF4x0E=;
 b=woGWPiNTBfzpETdUjBeDGgNXXd9kI8RQCMVylWpY0VBHeh3FtyzWIEsnz44B6iXPQf
 0FfRcYurEQL7hSz6hlb8BoWom+RAS4UiUlwI8YRpvLzrTDx5LZ2hbgcMWcVu2QcD5I2d
 C17cavGF/gQCEhXvOIhqTN3wHSHDqw1m00jrK3aTUx1KUZmwhsrR4lPdmzRWc1wZuoh3
 7dZEJbYXS4qgCJ2RwMFkO9i9ZHEL/UUPKRWLxRYc7OxDFlsEoQSdM4ovvToxTzlT2qK7
 2U51raifsmMr1QP8L0JoK2mGG9RDsPHVseRALQgyDt9SmfxebLuYGQxismTwv/dTmAhL
 qWvA==
X-Gm-Message-State: AFq9FYJZQ00/eFx8WzjdnPpeLK0h5KM6cwinpPnF00o+nX906AUEqPaA
 BKltgHkY79PBxBrfMcYJD1+kq9XFnLKpj3db5ADGahjkrVL8nRCXXP8u76XA9F2tjk4hfvJBnVa
 WGaxZ
X-Gm-Gg: AYBFou1ynCHm+/EEg5xOnRiExzn0BcRobxLiwJW16JZkIONhI7C0x3mrINZmCVCalG6
 H9tN6HI0Oo9fff4zGkIKXz5L1jtUTa1O0GCIRNbJs6B3Q9mEWnP5c4zqy2m2iKFi6vSsTF7JF0v
 gMh6R+BYSpXlFL+wxm7hmeJTqkBAFYqak3dYvmputX41wFztQ8Cb31uPxam4L1tcP55z1mZF8te
 XZ3OvX6mhWYpEktkuIzDHLzE+v3hmofSmafw32ECyBiuTEeC0R/7zIlFBLZxYolHihacSTkhUUn
 6xRWBRWPI0hIE3erHdR7WyZD49J5WWWm8/9vaJspU6xkXmXK3jgwqI5g/UrMYi+d98ULp3Mv2Hx
 7z7sGN09LM090JanYoC6m90Lwsq61xKFuNEX7GHKcjzL8fx4k2WKLDq46aicEFmF25H3VLYuYXg
 q7vK8akkSZh8mjE9oAUz4UGdahoTwdPWqmepfArZLupuwerUBcBkbJgZX6aaDXQOBUqKcr6JtMg
 moWlOz6DYfseNIhlTvvO9Ve7R49TQ==
X-Received: by 2002:a17:90a:1689:b0:3a0:b809:b9ed with SMTP id
 98e67ed59e1d1-3a0b809bb33mr3403573a91.8.1790499857762; 
 Sun, 27 Sep 2026 02:04:17 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 061/101] tcg: Generic expansion of tcg_gen_rotli_*
Date: Sun, 27 Sep 2026 01:59:31 -0700
Message-ID: <20260927090011.10724-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                 | 39 ++++++++++++++----------------------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b27d6c7975a..3eed9e6c2ed 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -181,7 +180,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 88a8001601d..9b88373ff23 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4c51428f935..dc6079a9e45 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -766,6 +766,21 @@ void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                       tcg_constant_internal(type, src2));
+    } else {
+        tcg_gen_rotri(type, dst, src1, width - src2);
+    }
+}
+
 void tcg_gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
@@ -906,18 +921,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
-    } else {
-        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1680,18 +1683,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
-    } else {
-        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


