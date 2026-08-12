Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988FEC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t1-0004JD-RS; Wed, 12 Aug 2026 08:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7su-00046C-Kd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sr-0008U6-Oq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-495590dde14so10839145e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536995; x=1787141795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9djG1Ka3NLTx8Hzl6L0z6UqejgNgDrEWl9A/wGEIq2c=;
 b=UlsCX/HbGevy0mcv3y9IwqHn6su6ZTZ7pqSG4xCdYC6GqJTZkso+AcohUDRD1E0s2q
 t3sJfVPBVsCjgi/U6aKEFHHzJijXuSuTn3bk1zC9nVcfknmn3rDsBHElPacXf0MZuLBI
 ZMxTZ0iZAjttW7RBNCXF2I9/+jsjzVDMFh2NGCIhhem5YNMR7uhW2vmOOzzpDSl+RYb3
 ySDkc6bLWwlfba9vLALnAtGoF3HLdFCn9RAajkeN1Skud8vRxNrFy6PO8Y5dMOxIWLdB
 3iP2jJgi+LLc2Og6Z9HwamG1FdEjqWpmWkQ4w2wcQOPMoS7ed4sGr3RlPmfOgber1XuX
 32yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536995; x=1787141795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9djG1Ka3NLTx8Hzl6L0z6UqejgNgDrEWl9A/wGEIq2c=;
 b=Qgi6mougo9002AQiS48Uz3YymWSxFQQTFoGv1QFCKHXY7vieBiTNOZb9eXAc/aAdrL
 bn/sQtUf14YBZJ8iFAXdgqa52iE3gmMB3XH0GnV+F1kaExYO4OuxFxx1zhxvVdPx8m9X
 pB7SuXH4hHpN9z8A1M9rA3zWMqGpiyADyD+0mIZ26BLgmY2xiVXZd3fOKVtCYmczFh9P
 kzvDW4Poa13Qp77YSUh9IxJ7sSU56maP3zj9xQbe48ukIImPWKDZ5Z4aAqo+Y+rtXuKL
 bKTnu1XsZEz7L3NaleJ7O9bgy9uwS7HEfqYySjia82WpE5muPb1UaktUeH5vJBfOrwd9
 UmxQ==
X-Gm-Message-State: AOJu0Yw0iq1Wx9wHvjhL/f90uE3h1EiTjAGuAPl7xGBOlkNE52TQmsYA
 5QrE3UTLCpfB3GNZBNc4XqsT1qqqAD6v4Nv1hz7Xwe4N1iL5sJmbvNSFmJ227SbgzQ5Qii/mFpq
 BdLzb
X-Gm-Gg: AR+sD10etDGaCEzZXLUwNnyOkA4BHkR9jfm+GM4N65x6q4n2RORFUawOR2jbOPA4X7l
 nv9HkyWMKTaGXLVOeszDygjaygFswurzGjQ2FShpKSHddMXSW+TPDTBR54XgVspRKDYz5im78ms
 bkGtdvY+pPtB4/HDL9pzTBQFImf0n27NpbYcgYppukK8SKDviVC9zLqdQ+p0uYJL6qgEHgW5zHw
 C0i08yminiOzZJTlKjUoCbjlfzW3WgnOlqnXtmx45mbUF9g3vT5dXFR/kzgYM0kJohQSyhIgv35
 4FIBn0Z1e+1vpAwOvvs/QdpSO7aC7EDLMTg65+agbWSMzPLer5VBLsPH6W4XzSdmiu/D8Gx9w83
 GlTQt6+XPgoEYYxaGhDnyckfolfrnhbkmHV3Wirj3vJ0++mLvnLuaTWI7R6a3krf3voNYT582tQ
 Q+E+D2RTv+Y5v5DTX0B265T3GBuuCE6BOxDzGFvXI/i18i/+89TqmyojPDY4zWIL4N9XtADqCIB
 vAYAuUpLcnFa5qTGJxQbyPKduokiPMfXQeLcFsZz4j1vZ0f3hL8l7RIiZ/U1t7VevGryw==
X-Received: by 2002:a05:600c:3f0c:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-4997c10aebbmr70356695e9.7.1786536995573; 
 Wed, 12 Aug 2026 05:16:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] target/arm: Implement FTMOPA (widening, 2-way,
 FP8 to FP16)
Date: Wed, 12 Aug 2026 13:16:02 +0100
Message-ID: <20260812121622.649730-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/fp8_helper.c      | 43 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/sme.decode        |  2 ++
 target/arm/tcg/translate-sme.c   | 12 +++++++++
 5 files changed, 64 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index d3bf0746cb..1ab6c90b8c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1852,6 +1852,11 @@ static inline bool isar_feature_aa64_sme_tmop_f16f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f16f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_tmop_f8f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f8f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 4b046f5f26..305cafdc9b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -1005,3 +1005,46 @@ void HELPER(sme_fmop4a_hb)(void *vza, void *vzn, void *vzm,
     FP8MulContext ctx = fp8_mul_start(env, 0xf);
     sme_mop4(vza, vzn, vzm, &ctx, desc, sizeof(float16), inner_fmop4a_hb);
 }
+
+void HELPER(sme_ftmopa_hb)(void *vza, void *vzn, void *vzm, void *vzk,
+                           CPUArchState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t dim = oprsz >> MO_16;
+    intptr_t index = simd_data(desc);
+    intptr_t ctrl_base = (index * oprsz) >> 1;
+    uint8_t *zn0 = vzn, *zn1 = vzn + sizeof(ARMVectorReg);
+    uint16_t *za = vza, *zm = vzm;
+    uint64_t *zk = vzk;
+
+    for (intptr_t row = 0; row < dim; row++) {
+        uint16_t *za_row = za + tile_vslice_offset(row);
+
+        for (intptr_t col = 0; col < dim; col++) {
+            uint16_t e2 = zm[H2(col)];
+            uint16_t *e3 = za_row + H2(col);
+            uint16_t e1 = 0;
+
+            /*
+             * Four control bits select two elements.  The two elements
+             * may be non-contiguous, so assemble them locally into e1.
+             * Pseudo-code has a double loop running forward, with a
+             * test for (i < 2) to limit construction to 2 elements.
+             * Easier to run a single loop backward, shifting extra
+             * elements off the top of our uint16_t.
+             */
+            uint64_t this_ctrl = extractn(zk, ctrl_base + col * 4, 4);
+            for (int i = 3; i >= 0; i--) {
+                if (this_ctrl & (1 << i)) {
+                    bool e = i & 1;
+                    bool r = i & 2;
+                    uint8_t *p = (r ? zn1 : zn0) + H1(2 * row + e);
+                    e1 = (e1 << 8) | *p;
+                }
+            }
+
+            *e3 = f8dotadd_h(e1, e2, 2, *e3, &ctx);
+        }
+    }
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index dedbd8541c..13be62aa15 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -47,3 +47,5 @@ DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4a_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_6(sme_ftmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5c453ea729..da6f4686d3 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1148,3 +1148,5 @@ FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 BFTMOPA_sh      1000 0001 010 ..... 000 ... .... .. 00 ..       @tmop_o2
 FTMOPA_sh       1000 0001 011 ..... 000 ... .... .. 00 ..       @tmop_o2
+
+FTMOPA_hb       1000 0000 011 ..... 000 ... .... .. 100 .       @tmop_o1
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8a55b79727..206f078bfb 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2167,3 +2167,15 @@ TRANS_FEAT(BFTMOPA_sh, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ENV, gen_helper_sme_bftmopa_sh)
 TRANS_FEAT(FTMOPA_sh, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ENV, gen_helper_sme_ftmopa_sh)
+
+static bool do_tmop_fp8(DisasContext *s, arg_tmop *a, MemOp esz,
+                        gen_helper_gvec_4_ptr *fn)
+{
+    if (!fpmr_access_check(s)) {
+        return true;
+    }
+    return do_tmop_fp(s, a, esz, FPST_ENV, fn);
+}
+
+TRANS_FEAT(FTMOPA_hb, aa64_sme_tmop_f8f16, do_tmop_fp8,
+           a, MO_16, gen_helper_sme_ftmopa_hb)
-- 
2.43.0


