Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82897606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ie7GkNI9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaN-0008K6-5U; Sun, 25 Oct 2026 03:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZf-0006XU-R3
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZd-00046q-Sm
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso15869245e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913000; x=1793517800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rpa/N73VqtKPxVa2FLraRQnA666swLVC92wZPw3qgps=;
 b=Ie7GkNI9Hu3iOjuGwVioovPVeQb0TNcVwE7avtkWpT71otG3nZ7p4szBJpkUQSBTsL
 70FXAxjJHk9WyuKqMVqWigo7wXSRslOOncrsEbMJCSF24YPUSdwRaaX31hcyHztpDZCS
 nHgINf4QoQEQyMoll8uXnVg1UvvtOlHvPxjCN8E5O26sm4Hx7r3zTSO5rAvF3lsM73uG
 VxqoFeEvVwhyTQMd+acU6zaHUjOWQTrl6ZCx09HdsRzssrC3AyaQ8qiC52Vbccev3YfJ
 sxYw63OMZg4fmHIqnkKrcWWcLGSDEiuWsNh+qdNSY8KYniWIAKcg0LbvywpuMSAgPlwD
 MGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913000; x=1793517800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rpa/N73VqtKPxVa2FLraRQnA666swLVC92wZPw3qgps=;
 b=xsafTtrXY0AZPzK3sPI83EfrN0IzCexehJJYWI133NElvGMKRdmXb9qJDJtDpeA3xh
 LDQQdbtzXuRVR/d06OwacfKaVAFKIppJyv1AvfxCx5iG4k3OMrsre2ZSlp0UIrH85e1d
 caij7zhfBhKY/1S0//Nf/hM6RDkN/eNPzoWkWItwL3sv+wKiGNMftTbEXfJcsn4qhlqB
 a5hMIrIFqhRZPWGxvj6nq55ppqGAjhQeygqyu4iUZAkgSkxgU/59rpHE62tIH5tWICxF
 3sBWqStLdD3C6/Yd4/D0UNQdN2eSLOUrT2CiXUiRJF7Mu+Es7Zdg1SCn+OH+NljJiAuL
 xIdg==
X-Gm-Message-State: AFq9FYL3Ulwc7IqoeT1k/tHRQD7MZX2ub9idNiXYCYe+ZVaAbQOngJ2J
 JUB1EfISseyMRrgvMdIBd88itMMiEOIo+LnsHjkb1P6zS6Py7xvPD9VrSB0KfLmaZStVfZ9mIhA
 E14B71kk=
X-Gm-Gg: AYBFou388JDvGd67OqhfQbuoSOACvGhHzlSKxtUsE1w1D8/dS2JdywwvsjWlfgNdOWf
 PTUVP6jZkC/3kSEUKNEG0HuPmGrh73YuHWHTDySGZaFxkcvdBKxq/tq0zaHL4KpX2ZtBiaI7NEv
 IqTnAgUMeuvgHHoengYtgB9X0JNB3fcFbM+wRPaqddng8ZzwSLB5JbhfWRUgAq54wIPRqOYOPrj
 PXs3kZaHj03oxi52LpWpaVt0OSiKtCKPkh4m9NhHo0vqsAPt9ZKC4GSCGpWp6KK0Rlbxym6vngO
 3OmNcO3OG09D+GT06WbUYrYkJ01VN1cwM7LYLO3WR0MABSDD+V35O0ZKOgoYtqC0CBulY7bj0Jo
 K4dQQjFZdh9TxoZuHT45YXdnBQhQFD/zJw1h7bXNsKVVq4lD3vIsBmm/b/nd0pTmZcVv8A0pVIO
 bUR9BeDWPUi7jLZw5oYKTM9ZXTiw4pUDtYRSl54UWc9R24+F3oYESc79bn7ETYw84dydKY7L6f7
 0hYaXOq2g8bgEu+sIK8afU0GEc42O2kyhhAP5PX7vnKp3m8jjoxwSXqtTy4FkksbZb3OPLI6+o0
 d1PB
X-Received: by 2002:a05:600c:1c2a:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4a35ac3a7d9mr77837305e9.4.1792912999595; 
 Sun, 25 Oct 2026 00:23:19 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 059/100] tcg: Generic expansion of tcg_gen_rotri_*
Date: Sun, 25 Oct 2026 08:18:34 +0100
Message-ID: <20261025071915.1123867-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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
 tcg/tcg-op.c                 | 49 ++++++++++++++----------------------
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2d05728a88..2d434ec8b5 100644
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
index 84ef1d5378..88a8001601 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -36,6 +36,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotr, TCGV, TCGV, TCGV)
+DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5a85dfbf70..0e294a2966 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -784,6 +784,25 @@ void tcg_gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_bits(type);
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotr, type, dst, src1,
+                       tcg_constant_internal(type, src2));
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                       tcg_constant_internal(type, width - src2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op_ttti(INDEX_op_extract2, type, dst, src1, src1, src2);
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -897,21 +916,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
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
@@ -1686,21 +1690,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
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


