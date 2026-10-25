Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XujYsUFj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKscp-00087Z-KS; Sun, 25 Oct 2026 03:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZf-0006XT-Ot
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZe-000472-1G
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so11767075e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913000; x=1793517800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMajQisvBGz2QxgxpoZ4nMVXkISLTkbADFPBdBElFPc=;
 b=XujYsUFjqEJPRJATMkypMq2CHDITi4JkSUaMtnAX7p496L3N9JMRVtLY7IbCn1ejBI
 WJHE7Vf0/5xKMpgAk31SkFYa9ohTR1pm+5XPGzW8zCyKWS8WvIMvJZovZwQUaHJtREH+
 v824AEVDYJwe7Ox6hFdZ8xyBk6SHF4rf8iVI6xSuLMYytPVSxM0Rw9LMojkt+DtrVoSE
 MfnOrskXDBR54KW8KqtskJ18HVS+aw6nUZZi1eobM2bBMsjV0X04m77biSWOQoerz4v1
 Ht/h00SaF/h9ppm3gm/8QUyKUsX+3S+39oW0SbZJlp5C0TzD0/Oc7npcjX/wgL4u9vWZ
 htxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913000; x=1793517800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMajQisvBGz2QxgxpoZ4nMVXkISLTkbADFPBdBElFPc=;
 b=02b6BZkihrAJb0GKPT1EakpG2T6o7QHwK2pcG7QjL+N15p68lioH0Qt2Wpq6u+kofy
 eZvJc/V5W1sCRa0ANFw3UQMJ5KbSw31GVDxNA7jR1c4BUx7rkFQpYISsGFpemSgivCXk
 pQzjcLnqw2PdMK8R4o1V9KrEdkk1IFIO8mp17J3HRXNML9T9EUvuha7+5jJIF0Lopi86
 F3xrZiaTeSZdgs/11971SFktn5V/yhp1xBb33CQRHR9GjTjz4UPa78dvCVW2i93BcJcs
 5MzoQVERBGyqVGQReU+Ua8uQQ7wmv/e9QRFHfnERf6Wq+2PgPYPDkgNjRxC5cpALgRvR
 FYUg==
X-Gm-Message-State: AFq9FYJSGjcVQfruWVuRdkscV9BkK2LOg596Lx/Ij2tWG8kGY0xrR/ae
 imQ1FFwXNXYzoezWSSXopYghw6JNXSCGxbtTMAG8wJubL2WQJ0FDq2qwjtNuoS+Ww7AHX3uA8HP
 EX3nOD9I=
X-Gm-Gg: AYBFou0hQ6FdZDv3keIr0pJM2Wc08ytpfrDHsKm0zbHcDvuX6HI1Xjvpjm19aEnhe5P
 3kuiiFs43GUXqo6H+xLChsiGcsEgT7XWOrYJNkFBfyb9fwL2BmqkiwyEPZoZ2oIxOlm3QKXAGPn
 0kAWLUeADQXErhdTTKqIFSTJhu2xXFYHY31WDQqoW8AJefIjh6ODZuuqtp9CZSNCwnYdHQUpptJ
 KhihahY+MD+dbiZPg+Tf353gSulJDh0tvAFllaRRymzFJaYnai96QHxEE5HUV0Z5oaIusW0oV/3
 RekiCfLqB8sI5RchLxwHdhGfH6qiELF3xs8itm2R5JIYznyrNU0n+AUP5tvrAasY9+6InN2xac4
 bM974yTqU/tiec9Go6DiMJ6Fp1ocIwG3nPaw/8NAxn/V6w36n/A3eONGnJOmIMc14D/pslufOHz
 f3JHx5qcK/xuOYhNIxxB9EQqhKmIM/iEIhVfZxbVMulwqjo8S3ngSudGr7lEuMYUgbAhcGnJ0dX
 7RmkBGrvoqllxzWtBqw/ycic+xsD0T9zuBoGrUPHYB+gVd4fJiAxDwgK+8=
X-Received: by 2002:a05:600c:3e8c:b0:4a1:d2b5:38e0 with SMTP id
 5b1f17b1804b1-4a35acbcc9cmr50987105e9.25.1792913000518; 
 Sun, 25 Oct 2026 00:23:20 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 060/100] tcg: Generic expansion of tcg_gen_rotli_*
Date: Sun, 25 Oct 2026 08:18:35 +0100
Message-ID: <20261025071915.1123867-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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
 tcg/tcg-op.c                 | 39 ++++++++++++++----------------------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2d434ec8b5..d20ac150e4 100644
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
index 88a8001601..9b88373ff2 100644
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
index 0e294a2966..536095683f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -764,6 +764,21 @@ void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_bits(type);
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
@@ -904,18 +919,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1678,18 +1681,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


