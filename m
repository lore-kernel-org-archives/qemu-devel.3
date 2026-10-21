Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D08606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qPQ5t9FO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFw-0004rh-OH; Wed, 21 Oct 2026 10:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0001eA-FK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002A3-J1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so3653195e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592559; x=1793197359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jLUlQ1821/ECfDKKKpNscRg+RBPVIzkb8HlMtKrEQhU=;
 b=qPQ5t9FOn0y9Ti5Djy26DrgsYp1lsJKR3/enTg0wg6OBkcZoEbwFrt9iorCehSRqvG
 YcjW8AjJsEmwU3bzlbgfyRXs9qAfhre+Do4nIJBZ1BDmdG2j3zvWHLNiuNUyEoLNktts
 wjsOPxTh+x90hDXla70XrpAaCNFPf5joe0LGh/HtKvgpCjpMniUGTLHHRJkhPkF4sTjV
 KQw8SAhD6eLP7vHIN+HH4XJSeqi4wv2bMY8iMoJeVEcF7bzHD7+00jUZfxN2rAvP3S/z
 E9Up5W+eaxFa44IooyzULaOanaotlj2lpIjiH5kcH4I4BKnzWmmrIBgQzxsmKhKHmm6d
 Kd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592559; x=1793197359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jLUlQ1821/ECfDKKKpNscRg+RBPVIzkb8HlMtKrEQhU=;
 b=jsrFn/Sz5XEXSA6wtTcPAtv/jrI9EvHPUNJmqB0dH8EwWyOigZK+78Awb/ncMi7Baa
 soUK7xTtypiJX8tzYRTHQq2625eu0tnMYzUl7KiRnXOf0t5fSIU1BRRwmuym+88q3hpO
 Rww0LQ76npZAvrLz+50R6hQJHGfEE+jAmXl7jgrrfePJSD2WbcHAikKB3bM+D43iTcj2
 845Ly/qv3EildTrk4mPqwF46BzYoMIvhGXajUHuCHWXkICrcuj+SHvSC4nBW+3ogGQfL
 oieELxAaXLQboYT9+815KQ3aEER33C1USuV8JJZMoRvX+sWczyuspWfGOS0f0gFhbsBN
 UToQ==
X-Gm-Message-State: AFq9FYKtrQNsGs4eOSGc1gMMqlCcqmd97yxZ4KBc2JlkbEHd3T8Dij8T
 ATKhdeemvsNRBMEUQuuPWkmY/F541x9Phz++oGabxbJJaw8mkz1HLnRa58R1ormeMg5vj3HiZoe
 u8G5WsiA=
X-Gm-Gg: AYBFou1ur2JpQiQ1gHzAn9f0EH2d9h1My7LZ0oJrFXUQUu2KMxMCnKAQ2R4Gq8GiMEL
 RHik6BJRhe/z1rD8AdEOdB2h12TlzWi4fPqn0zBrGV9sSPCTbyQJ0zTvL0KTmbrahc0J1RdWnpI
 4q3tO53HokClm5Ej0ul3TdjxSTLOGPCf1Mp9IDvE3go3SIsSJbj7KRc4FhwVeRuHWa05qDlspPD
 /haBOCpqAgud/O3A6r/pZ0KuJNFDCT6yTnt62drwkAEcqXJWi0tI9dFLJFArk943X7c0S3UbgcD
 9ampRyeAm56ukbquqBrgcTtUIA1wJZ2EetuSiLtuHjxDiiorilAkhaMSsC1RuEZ3FgXF6KTjgoW
 Wj36BROoAb9TDPxWRgWKG2qLrZc1JPNFmtGwp3GgFp8JDg+VTU8b5oduJxX1QCH+m+wzIOxV7id
 p6WwsFepUwEgIMbcfALdam8kDQGGwn5P8DksqMH6sjilnQKDMhL+yBa5qVnWOMBLHnWsHt0GHdQ
 mbDBdOHDUADCQm6pZckFuKnwHcPg4RKM3w/mYSkDrApAthIftG3+g2nD7cxUKrztDjc+yp+HxVT
 MIn89DtjGCAZNAZ/Sp0W7uOdO/c=
X-Received: by 2002:a05:600c:4ecf:b0:4a1:e7ce:107b with SMTP id
 5b1f17b1804b1-4a1fd8a3fdemr52396235e9.2.1792592558679; 
 Wed, 21 Oct 2026 07:22:38 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 059/100] tcg: Generic expansion of tcg_gen_rotri_*
Date: Wed, 21 Oct 2026 16:16:11 +0200
Message-ID: <20261021141652.363109-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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


