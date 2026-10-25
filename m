Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1A606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=siu3xiM2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsad-000197-B5; Sun, 25 Oct 2026 03:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZc-0006Ur-OY
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZa-00046W-Si
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so4572025e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912997; x=1793517797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=buJTXW33M9pogk+9JpS8Ad0+vm8uXgh+bTuisr9io7w=;
 b=siu3xiM2ILE9Pd+r5MXZ20o7Vt1voP0iX8dTECg3k4BJjO0/w6lB5i4eq1wXH3/Xok
 wx8x0GmeGqIOAcqyFkfSpYiVdplGTxPD5lvc4P4ReLs0mCL3dvKOnjiggvggMiHo2cFC
 Epe1azH3CvynjwGpnJHQgNyvz5VZyxiZ1WlDG24qRdSt/1NcJxfwta87yQ62oxfZxOKL
 LTfEGV1rHekvFbBp9/jAxqId+kE67D/kTsK6PVWxHzJanvXRI387ZZew2IkDc3EHPK1H
 eIemGF3TLoEkMmxGdsTninppylppO+dyYKTCqED3MbIhPf2hU4Ren8Zn7bileyG/H5a5
 zEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912997; x=1793517797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=buJTXW33M9pogk+9JpS8Ad0+vm8uXgh+bTuisr9io7w=;
 b=QYIWyrzVqS3zBK9mZZtpITiyAcwM6UpBy/gN6gGSW4Xh5WbxFKybi3SBU9Z2j0xKMu
 PglpYfYZnUWQBvlDhMBAbQwi94C9SpGnIOVcVvixg2oTQMKdjiI2S0YdhI8JWsWC9hjk
 8mqA9J22cagVBafb3HP3QdVeKbT+fnOpH7B+evvzFQ4XKHsxOeIVHQl8WnPhZDLyZ64v
 7U3/iETlGd9YfzElpsiT+ygH3Thdwy89VLBP+FmfhbuoDqM1UaypEWDKdmLcV+VEASfe
 UhIi41ODSS5lGkrx2+4syKtqZn3nP6ImvNILmG31sIm1VFZGP4BXyTYu0qQF/Jhm3X68
 z4rw==
X-Gm-Message-State: AFq9FYK4H/LY9WGI5dMpFawTWR8ZOud+tz2a3yxKOY3B9afud8tapdFx
 24A8ttUfNPnCNgq//55RASRoxvbxmH6x3tWLf/ACfxlzf5aPJZjykwKW9j8NZhVzMIik0ZpZ9Zn
 Jo3AjsMA=
X-Gm-Gg: AYBFou2BgpODzlfGAas/9PFn22tnZ76B7I0zWZddZG9Onw+v5aDlN8XLhXKGeOA1RdL
 JHffyA3swYK7LHKWzbUUktg3RutF8RqnSP0SLey6ABERjX1WyqnCNOM0r5MFnaCRKcV3JPOUIHf
 BSovhVfAzh5+87mJFU2ul0oc7Sr3+HPtZz0T/mezQvTD38SGKlHPAblCtZDAFh10K9HmZpNyD+u
 RBlprckOBOtW/Fap1YOChhEi6c/oV6wt3sFBd4o9UYLT5C6ffYemQexkyBB9O/0MOY0e7zZy3k5
 LL2BMsvnKjtVfPxXkseznjtLgJ9F2wC7mw25v5qEMsqt/I3Jf7FyFunUqOWaThvXqNW/NHfn1Rr
 bFJoJXeIjK8kuD1O/Yfi0YlhD2aMqXV3OAyfDNu7djN7Dz4aiJNWLqI8dRJ+IBldH5M5qboDl8Z
 fYTjBeGgQWuz68QDWt0APSL/Blh2syAEF06hRu2V6SzarKGAe6oJxvStgD1vB3+jc3wY7g8IDuR
 FxFbKdF4RiHSwoJoeI9QDlPTbwA5U7GXzICzR7JlD+me7tt+TbVTLAKhRc5
X-Received: by 2002:a05:600c:37c4:b0:4a2:ebb:397b with SMTP id
 5b1f17b1804b1-4a35ac7f0e8mr59347435e9.11.1792912997092; 
 Sun, 25 Oct 2026 00:23:17 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 056/100] tcg: Generic expansion of tcg_gen_clrsb_*
Date: Sun, 25 Oct 2026 08:18:31 +0100
Message-ID: <20261025071915.1123867-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
 tcg/tcg-op.c                 | 45 ++++++++++++++----------------------
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b1a66149b5..b1448f8c08 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -185,7 +184,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7ee00c9d53..ef0ac5aece 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 476b8bbdfa..97673524d1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -422,6 +422,23 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+        int width = tcg_type_bits(type);
+
+        tcg_gen_sari(type, tmp, src, width - 1);
+        tcg_gen_xor(type, tmp, tmp, src);
+        tcg_gen_clzi(type, tmp, tmp, width);
+        tcg_gen_addi(type, dst, tmp, -1);
+    } else if (type == TCG_TYPE_I32) {
+        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    } else {
+        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    }
+}
+
 void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_clz, type, 0)) {
@@ -828,20 +845,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t, arg, 31);
-        tcg_gen_xor_i32(t, t, arg);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_subi_i32(ret, t, 1);
-        tcg_temp_free_i32(t);
-    } else {
-        gen_helper_clrsb_i32(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1673,20 +1676,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t, arg, 63);
-        tcg_gen_xor_i64(t, t, arg);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_subi_i64(ret, t, 1);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_clrsb_i64(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


