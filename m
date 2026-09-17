Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F73CC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pL-0006Mr-JO; Thu, 17 Sep 2026 00:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ni-0001qu-I2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:48 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ng-0007Js-Ap
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:45 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea48edcso284702a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619563; x=1790224363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GMDEws37EjR6tKrxev+50mHmkCwPdCjk+P2bgnPStRU=;
 b=kZ+biLytEIrIxdBX9UBfPvnUz96bsQ/TXp1hiBGK4+H/u6qn4BSzENjew3hL2vxdsw
 /lHBp4LrRUhUw1PYWv3dsifyaTcaH7GLEMGsbw6sYMbqR/G8fuYqBuD9fOq9iJkn+cQ7
 XCHrH4aicGsxCPjPx3rqQKjpEzPTO3GxsoyrgsZX0rcJUyJqFe9y8q9JTtn+gCuAlLB3
 /H0ijRVEfer5k/ldh4YJ1CCLpzh008HP0qzj7zVcIda/yIu7tCprQv79t+ty2tYNCe4j
 +GDAp7Qh1fclqa6rpYUXnCsWm9LOKo6Yf5yGn2IerP4A09SbBubRCi6ejG3dxQqI8EAB
 QruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619563; x=1790224363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GMDEws37EjR6tKrxev+50mHmkCwPdCjk+P2bgnPStRU=;
 b=lDE4g5gK7eNxAnXWXzfZivhzulP1mYidd9BdMan80L3j/0D4DLabdl9qpDsWrlyQhh
 ltEtAL8RzC6WKj4mb/xY7HoJQCskHZ1Qns5dV+4QagiBGVQWqFqHW6zS+7X6bXk6yXYq
 oyVcXe/DtbmtAsqu/v6dlw3ScQuyyF5M4zKHbbZsqLhLSgSOXJUV+prExSB568VCIhwp
 2/db/+w/9qN3JJB0kmO/47FinBiNzu2UdV2YgK/dL3khRFbbSED9QZnfv8WrmCilftP3
 u3l7Ayrf2Poa7s0mKVjBaoKnDOkWC1LNl2s77m150NyG8C9tkgXWFSiWUvFoD7ddzLFL
 0hAA==
X-Gm-Message-State: AFuF++ms31hVtaKWVLJ72Wc50xNSGjChoJ+q+bqR1xNG9ytR4b/VYlJi
 ZCeyHu9BFBZm4IxGALZIBwv3z/m1kepbQ8t6DzWnjTffFhZyatUFcj0LRqbKL02n8dEC6K2NB8w
 Pq+7tP48=
X-Gm-Gg: AYBFou3N1dmSbpl3bMxlPX9RSi+dKqv+wo1szwgQD5gB0TNStcWgDcLeGPbV7sbsrij
 7niwVOfTsNaPRICFZzb2dBb0GzQHb6InqrDlZNQekAkEnW5R21IJ/JR1YdUae6wPtBqjsIfEPB3
 y8b3NoZs6Pl1oSG7m6CT+t0MZHyJmgrVUjmpVjR8g6phV3AkTnc6AZX9vTj2bgC/S3/OmZAyw+o
 9rqc/jo9XkQmfFQ6J5PnVFSVrmcY3CHXDy+dDK1zv2l5tNBtgur/7Hvnxg62a37TmhJYk+LW7Gr
 /j2B5dLlbExN6WvDWIdt8of6OkGFZfBnTBfMArXIBVXR2HMhvFKHTchH0PrN/4W4kuTYr5ym4Pl
 XvNsf3Hc9n5H+aQ/JoyX7eKfBsKL9dD5eOf/Ca0fiAZoAuCeVJSCXqP/RPxh5SUX0KC58w5jBs3
 i60fp0trsv8GBY/Q+pJVCRva2cxIhSIHQwGl1PIiNgzuArKlys4V2dLBeZE7om+auaRf3ahwr4U
 vxmL0WYCi1eM3wq9A==
X-Received: by 2002:a05:6a20:a11d:b0:3cc:f008:8125 with SMTP id
 adf61e73a8af0-3dd5f3c1ac9mr12195645637.1.1789619562775; 
 Wed, 16 Sep 2026 21:32:42 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 073/101] tcg: Generic expansion of tcg_gen_ext_*
Date: Wed, 16 Sep 2026 18:27:55 -1000
Message-ID: <20260917042823.542588-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Move from tcg-op-ldst.c and compute the width of the
extract instead of using a switch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-ldst.c            | 54 ------------------------------------
 tcg/tcg-op.c                 | 13 +++++++++
 4 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3d01609810a..84902f5ef72 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index dfad7288bb4..c31c819ebdc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(ext, TCGV, TCGV, MemOp)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 22211ccb452..031c5ce926b 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -760,60 +760,6 @@ void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_st_i128_int(val, addr, idx, memop);
 }
 
-void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i32(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i32(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i32(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i32(ret, val);
-        break;
-    case MO_UL:
-    case MO_SL:
-        tcg_gen_mov_i32(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i64(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i64(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i64(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i64(ret, val);
-        break;
-    case MO_SL:
-        tcg_gen_ext32s_i64(ret, val);
-        break;
-    case MO_UL:
-        tcg_gen_ext32u_i64(ret, val);
-        break;
-    case MO_UQ:
-    case MO_SQ:
-        tcg_gen_mov_i64(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 typedef void (*gen_atomic_cx_i32)(TCGv_i32, TCGv_env, TCGv_i64,
                                   TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void (*gen_atomic_cx_i64)(TCGv_i64, TCGv_env, TCGv_i64,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 31122a5950d..f9cf4675821 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -361,6 +361,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
 #define C_int64_t
+#define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
 #define C_unsigned
@@ -391,6 +392,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_TCGv_i64
 #undef C_int32_t
 #undef C_int64_t
+#undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
 #undef C_unsigned
@@ -684,6 +686,17 @@ static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ext(TCGType type, TCGTemp *dst, TCGTemp *src, MemOp mop)
+{
+    unsigned width = memop_size(mop) * 8;
+
+    if (mop & MO_SIGN) {
+        gen_sextract(type, dst, src, 0, width);
+    } else {
+        gen_extract(type, dst, src, 0, width);
+    }
+}
+
 static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_sextract(type, dst, src, 0, 8);
-- 
2.53.0


