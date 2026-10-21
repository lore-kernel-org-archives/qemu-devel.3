Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE60606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oG5wFCBl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIJ-00081h-47; Wed, 21 Oct 2026 10:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGW-0006Cc-4B
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGU-0002X2-1W
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so703477f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592760; x=1793197560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oAbhOQMvXy20l0jVDChqnTZrotaScCS6HlunXhM7Zvo=;
 b=oG5wFCBlf/cxQZQbQLwZGLZXpt8MhtBjGXf8P1S8VJmmqgJa3Yr9RGjs+/Dnhk1qxH
 MMtC3uF3q9MEjSfC+RruW2VbsHojnS0ODmVhdW8Ad6mAc4IC96crYKTK7RLEy+LeqN5y
 ctPZZXYVBxHM04gwkCodJoKYmtaNg8e0+5T1cDdmJdlDkz0/FpsTjSNJGLDO7yS6lAuS
 +gPritLOAX9ckLkCgP0poR9ugDD+BSU3GsHpXkBha+7krjNS7mRNJNmAcR2UR2iDBHFE
 Nf9srr+L1d/PMLKUqovCsWbWfCpEb30BH8+JiWyo6H4Kcn9Si4qlfqqhktkjkrU3LmBW
 Y0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592760; x=1793197560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oAbhOQMvXy20l0jVDChqnTZrotaScCS6HlunXhM7Zvo=;
 b=Aow6Ao0Xz5VJ0PyHAGtoJjPuS3sd7PdNUTgvhrsS6Ct0SAQwAKk53qa5UxEffY5xaO
 2QWrzTz8/hQqjD/XzaiOGq4RCufynrqYrCg2lxRGv3ZPHstXk2fe4yJ27pu9tQUgkC2R
 YmUV86xuORY3I36E2N0UaseaeUH+x4z6MUea361UraLbQyMXKuxkc7/DPl2Xit89ghNo
 lb7VpfLLn+5cIG6IwgHRaCVdBspnExtHgBo2jAHhQ1gKE01mYz8MdUyw2WZq3lWuEuLw
 5k07tDwI8uXh7JdOD5HF1d23d4/qtCrVMgweJDhktuUOiJ5uOslatm1SrgSvFVbAUDWn
 YOhw==
X-Gm-Message-State: AFq9FYK02B7SvIiRYX09R7WDVLQzzVqEXRXM6VTSEQlh+6hn9r4Z7Mb5
 LjcvqhXvRHK3/2okSRvC2q2n9iht4uh38CKie+8kU5lPd4q4gtCU+2x6MEXmA1/E/CPW2C/VZ8N
 lwrfbbn0=
X-Gm-Gg: AYBFou0B97KMqnP5bG7w1yYdRnHxncW7C9U83K613LfYDn5TsYl0I2iojx0tlUzovvx
 zlhLrjnTCoOjl1Y0UnCucIAbQO4pduwmClF7bwPa10A4rVrezl8FfY3syI9wvW5fPoXwz46vHOI
 sLePbcYh+WqGugjwj4JL9GtHkp5hlfxaa7NwO/4GKP92yHjJV6MPIU/G/dtfOu1wnnhj/hkrOdj
 LfxcTN0DfBU1AFE21rjnM/+3jYu35z5PvwiA0Y3kcNdwi+Z7905HUVVZZyrUoaYw633mTTE8WbK
 AFubfFjms85aENtLQ2E+lpL6nTxrX/8rSIXvlGxVsvKNv2M83QVIVW+pyAOfA+xWyaSCvGapmqv
 UA54owKq0ABvyqEhyIhIIZwPqbvsC6FsEWUMLKo2SaWVQRDFz795AO75hKdn0ArJkDG+Jd1XK3f
 p/6eT4TUe55eTQ/AKvifoJtrKfEczDteVxCO22TV6buzLFJnQEZPZw86egm6IpHwZOrx/J3Ssht
 9pe5CL8QLxq0CrnQ/o6L20BmY/uQe6EQFwnk+5pYl4DWG4AtaLCZjPWapHizAUql/exShGMU/UU
 UyYoKLPpg/rOL/Q6J18HQBokGRq6lTinKHpcFsFDVqPVMEnc
X-Received: by 2002:a05:6000:3113:b0:48c:6756:dab3 with SMTP id
 ffacd0b85a97d-48e26421122mr5306764f8f.3.1792592760346; 
 Wed, 21 Oct 2026 07:26:00 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 080/100] tcg: Generic expansion of tcg_gen_sub2_*
Date: Wed, 21 Oct 2026 16:16:32 +0200
Message-ID: <20261021141652.363109-81-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 64 +++++++++++-------------------------
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 109cad57ea..036b3de920 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -158,8 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e9f0b971a2..14bdabb2f1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -63,6 +63,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ff4dc6c531..aaf18b58f7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1100,6 +1100,25 @@ void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_addi(type, dst, src1, -src2);
 }
 
+void tcg_gen_sub2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_subbi, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_subbo, type, t0, al, bl);
+        tcg_gen_op_ttt(INDEX_op_subbi, type, rh, ah, bh);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_sub(type, t0, al, bl);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, al, bl);
+        tcg_gen_sub(type, rh, ah, bh);
+        tcg_gen_sub(type, rh, rh, t1);
+    }
+    tcg_gen_mov(type, rl, t0);
+}
+
 void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
     if (src1 == 0) {
@@ -1164,28 +1183,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_sub_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i32(rh, ah, bh);
-        tcg_gen_sub_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
@@ -1693,29 +1690,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_sub_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i64(rh, ah, bh);
-        tcg_gen_sub_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


