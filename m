Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEFAC982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQo-0007Hs-1I; Wed, 16 Sep 2026 09:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQg-0006T2-Pu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:03 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQe-0001zV-Lq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:02 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6beed321ad9so628247eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564319; x=1790169119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fgyuZJ5ITSZRqw6wTAZbkIoAXNAs9Q1TJauabNvEQak=;
 b=HGi0Mhi3qOwFl00eqPBuBYbi+MTzMLGwoiAlLBeVJNHUToCSNRdhahXBCTTspjm2No
 iEWuzChMBkWg0EXrDApAlw83oTVBg+h3i3jSyG5Z8wv5sfuysG0NCkIHxT3G87q6XhNV
 bXmlYjgBBEBFIzAWG5HWj2AoXrZOetrgcf55KWC/ujIPKYGfwvW9w31tjB0Nfv/T1SCk
 hRxfncN8Qbrpd6Ej/2yu18c6ioBCcTwux6nDQrqxl/hQNu9DU70frASAFuQmEJIfB+95
 sH1iBNs0kcVrunUhSRpfZu0fkW2PtAowFYjJLXviQu2vRH95VN1tidiBW4+KhPFTbLUV
 pdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564319; x=1790169119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fgyuZJ5ITSZRqw6wTAZbkIoAXNAs9Q1TJauabNvEQak=;
 b=JMilxcXP8ZRLzuYeb0iT1o76Q8pnY2/tBnoXILL2MI4JdohtWDY6LymKpOJgqictVe
 2IBdtKJEW15rls+x5IlpeB3t4Vpwck5/jawmoW58SbgRN9UXM9OhDcU3go77J7bskDuf
 DV+kSubyun5xU2dFnMUXjXKm6MnEDDkw66uzL7GV9STflf3iHFZy9PpENZkRHluKlwhH
 NLYTSoXNMsvNIHy9nmA5H33WWZVKvrGUXSNoOOsgCQBxojyTInfyF5TXQZznJF+371l7
 HuAcpwczMkvtRA0lW5vPnnXAURDzzBdi3jmeRenej8fXIkCxdsGxAJIsrU5jMX6047kS
 VGWg==
X-Gm-Message-State: AFuF++krW8UT0kkrzVnPyb1nshDEWIvHRGSNgPV3bp9D/Nk83P8K7k0i
 ZBm+27mtw9ksClMEnsyqc8tPQiA2fnuh+ZYPXsVSiwCTxreTnI3EkzYJnWsRfc0/f56r53Arbo5
 lSe6Ropc=
X-Gm-Gg: AYBFou1zatQKa3Qr3XpBxOImhPmpWmWvfBPy6Gb/Cqdj2kkBTiOMbJ2qjUihbMOOOeZ
 VqC4HqC84Rac00YNyu8RVclM7uEiosDC2t3PcQXMeOmdHOVoCouoSQcFkuSeZERVhj8o7apdYkl
 qSZpxdk2sTydfT9zWxFrH/X1WBori0LboAeTzjRNlBf5tNYYevJsmLGwV8smDqvl6/1gln3ah+W
 LSDKU/xe7j0Uk2J2RAuZDRo/iPJ9T1rmifHTzHYR9O8FRfVGSjEbnx58b69cv7j5hNtcYhCUO9V
 Qf6/6F2+i9fOndGPcnV+CqKIkmCJjSfHPD/BVpHp5ssjXyTdc9XuLfGyDC2B42oKQdL0f0E20cr
 67dcXK4roAJS7rtaSnxVXcFISEbT6bcgG2EmQ+iwuhbfCbP94fctY1fqTwNMJP5Y9KLvgGiq4KL
 dYxEdAJnqV10+MjUnA6iOhm7netGaKyDRQhLFkfbZG6nRqiHVuoiXw5+v4N5MV5zZX8nbQecb0s
 BhMxUI=
X-Received: by 2002:a05:6820:2085:b0:6a3:c6f8:4caa with SMTP id
 006d021491bc7-6c7d15cebaemr2480105eaf.2.1789564319234; 
 Wed, 16 Sep 2026 06:11:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.11.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:11:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 83/92] tcg: Generic expansion of tcg_gen_mulu2_*
Date: Wed, 16 Sep 2026 03:03:58 -1000
Message-ID: <20260916130409.3382710-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 86 +++++++++++++++++++-----------------
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e5282af98d..3ad966b72c1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -157,7 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5a472a910c6..75ada0d0473 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a38a4a3aeae..dbdb3bfbe20 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -135,6 +135,13 @@ static TCGOp *gen_op_tttii(TCGOpcode opc, TCGType type,
                        temp_arg(t2), a3, a4);
 }
 
+static TCGOp *gen_op_tttt(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                          TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), temp_arg(t3));
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -899,6 +906,44 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                      TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
+        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+        TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_mul(type, t, src1, src2);
+        gen_op_ttt(INDEX_op_muluh, type, rh, src1, src2);
+        gen_mov(type, rl, t);
+
+        tcg_temp_free_internal(t);
+    } else if (type == TCG_TYPE_I32) {
+        TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        /* Simply extend and use host 64-bit multiply. */
+        gen_extu_i32_i64(t0, src1);
+        gen_extu_i32_i64(t1, src2);
+        gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        gen_extrl_i64_i32(rl, t0);
+        gen_extrh_i64_i32(rh, t0);
+
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    } else {
+        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        gen_mov(TCG_TYPE_I64, rl, t);
+
+        tcg_temp_free_internal(t);
+    }
+}
+
 static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nand, type, 0)) {
@@ -1311,28 +1356,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t0, arg1);
-        tcg_gen_extu_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
@@ -1818,25 +1841,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_muluh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


