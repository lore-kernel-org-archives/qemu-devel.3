Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDEC606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oSaMkM7r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAN-0006rQ-G0; Wed, 21 Oct 2026 10:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9u-0005Es-FJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9r-0001hA-2E
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so5630055e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592348; x=1793197148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6qq+zlaCx+QtEAY4r9Lxb0XcKsbfG9X1t9phMRvUjN4=;
 b=oSaMkM7ryrbpRJsVwQomtCiLrdoMVFXI2K2+/iqsSxen4inweWJqwgeLYHUrhO7YES
 4W1sNeieVuUjlsRBdIUwo0nXXKPZKX6TiGrm3tj5Wz/4YUI44Nsr271QDZzsWiCUn+/j
 cMYqYOcOq2IO2cpfozv80YEEC0mf4RozzHSqRQrA8Ycbq6MPqAsEBa2yEV7JRVDC9KzA
 ITkccV/BmnExSdEXFZ6QBk/yQwup9PFtmRoSB6kEeujANZMqVzgJS/U+RAM8Mxv9Pyi2
 OVmof1Yu9NC9mJvnnGu11pACNd4f8u4iKKCgm7NN/A3RfM/T5+MOj9vbUFHZpGwaX278
 tsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592348; x=1793197148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6qq+zlaCx+QtEAY4r9Lxb0XcKsbfG9X1t9phMRvUjN4=;
 b=Tg231zE16kdZZtf72nyxhVVRZdO0r9/vrviuDfG9yJ5G1katNWtTUH+QxCIB6tMuie
 ebSLAtZhx4mMPTEJNkiw4jwVg1GRwiZRKk5yuYz0OO++LAS+NO/CqvG5UnUNP9uYcerX
 ojntvnP+OhVpq8Adb3YWD0ZDfos/zRkasYJPo3T3r5i1LgIjLioBmAwl1o82NodjdyPB
 GlUiyFqeie6jsB/y9a1SZijyqFGVPXD4hPQL39+DyzTvS7qNzTW2qxm7fvmPpShfA2mG
 dmJ9s8gDseKB8q98W8daWNAzR1Fsf8UPco+8J4rIsTSQPuR8ryur2dfKgbK2JgkfL2EK
 E53w==
X-Gm-Message-State: AFq9FYJ6mxbJENHRoSnX2TUJil4saZHtnS3eEWaC6GfZQZjaz5w3Zb4G
 SNbhtSfXPlY+5NtCRjd8Ic6tbL6Zg3QN8O5M1MwzpmGP3XcN9GHdLHtCO2iTUjtUv8Q5scq7Dv5
 8G0rgJs4=
X-Gm-Gg: AYBFou0jg8zf6qZAiqHhVC+pzHOkps1x04ArW7jlfuFImZ3bYuXgoFpYj4eUNDKYoMc
 oA/ETIv/QA61Bg+xmY3WxnVMGQ5ZMBYQpAp0+u4/5ByIK3IC6bEXOb4ITwXxmbIA5dRCimALQZE
 A8XoIPcE3GoVNPxZdOsrJ0t524hD3vMK0DsH7fmQ8qgktUm+sKNOyPtqfmrhvPmviBHnpY4OvIm
 t1szCRMA/Gro/3PxwmDkc3KwUBYZBOR9+ZLwCdghm+vxtL8HWbmVoBspHmWoWUtRLirW3KeWm84
 jOI4HFHgacwAJEMC08ikSq1ZHuDpE1bd7gsWm7UFmo8qQPbKB4L+neKrvKdGjJBSWEe5WOgPEoP
 w5hzyAuUQvAdGOxhFiI1nOYxtkPhMfb+n26jbALmVulQtmRAXmignkbjt07D/YZjNeuyLXaw3JO
 vsmzhwuPFOPNwp+MvasYZdno2W/KS6ySV27Cx2PS9a1MALGuLqYxMNE7fCq651C5oJdn98v9iF+
 YOCniR1JEDLvqMxF+KSoqjO4EvMBgNxJEVD70eo+RPxtPkRojKr/eWQOIJB/03LQ1w8xVFIMyyV
 OklTqbzFCP7BgHTXoppuCJdVd6g=
X-Received: by 2002:a7b:cbd0:0:b0:4a1:f9e6:f418 with SMTP id
 5b1f17b1804b1-4a1fdd22fb0mr32949495e9.34.1792592348513; 
 Wed, 21 Oct 2026 07:19:08 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 033/100] tcg: Generic expansion of tcg_gen_rem_*
Date: Wed, 21 Oct 2026 16:15:45 +0200
Message-ID: <20261021141652.363109-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
 tcg/tcg-op.c                 | 60 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b0c5a1f5cf..eb090984e9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -204,7 +203,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 778854286c..50d725b72c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8854006022..e194c33eb7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -484,6 +484,26 @@ void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rems, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rems, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+            tcg_gen_op_ttt(INDEX_op_divs, type, tmp, src1, src2);
+            tcg_gen_mul(type, tmp, tmp, src2);
+            tcg_gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+            tcg_gen_sari(type, tmp, src1, tcg_type_bits(type) - 1);
+            tcg_gen_op_ttttt(INDEX_op_divs2, type, tmp, dst, src1, tmp, src2);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -623,26 +643,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
@@ -1537,26 +1537,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


