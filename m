Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E20CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAh1-0008IS-KO; Mon, 29 Jun 2026 08:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg6-00074l-9e
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:30 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg4-0007d8-Du
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:30 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-697763eeafcso5361165a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734486; x=1783339286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gAYc4+uLY/IzSGngMpT62FfQRDrhQmlYIhYLudXkhX8=;
 b=SH0o0PN4Dcw3/8CNa+bDMi001t1dcKCUfqikPiooR+hmV4tf/L3tKZzmjszw3rC+f0
 1bAu9IHOM9hTOBwRdPAfUSy7NGyMZkFpQXMIg4LsRMhLZEKMSaAGJFYAKYkke2tzEvak
 tOASLNtRpfHHgEdQc8cpFhBQwB9D7AJmx+iB7Hz46Ocsksy/2MO3iRuIuK9GZig3hQuR
 T2C4bbu2oD2lZQCXALOouNKRkXowGQbP2k66yZTNlIjdaDOaZgLGVTXyfrMR4pDsmz6y
 +7P21dV6KxUgo/Cuu9ta6OFCC6eyfiypmtWuMGBKRQZR46+jQL7/PFC/fzsn8e4sKSKY
 ytQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734486; x=1783339286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gAYc4+uLY/IzSGngMpT62FfQRDrhQmlYIhYLudXkhX8=;
 b=hAFXOM4KSYXuJK8WriH8zds3WNeJJuGqvn0NMcQLVsxkgtGG51z5dMNGt1r+CTRZw7
 oR8HQ+v0ABHtTTwQGFqKY0zjnPAqnIv8XFYuihuJxJ78PHR1PboIiA/+u0XrmF6LH7oZ
 GEV1WFSAbtkzPd42BEX/PZD97ruCvZnycqoEhk8hHlHhutCDVR/ewNOdH18XTPhb8n5G
 jHx2acnVL9DVcuXMsq+kVQHYEcf4LV3iNe+NzRWrpFeh4+pTFoQwT0D5FqmRztx6FFXt
 GsmR4VIVuwo6itYTo/DyO/TV/gaMgE/ipYXqSf47RARro+jVPwln9U8JpG0IunW/wG8M
 Ngfw==
X-Gm-Message-State: AOJu0Yxb87Qt+sAP/iUUv7o63+8FHDeHZGUJ6/11OL9EpHW9NQV5t/Ih
 mQmaX/UeiBGhh3BxPQcWzZkbo3jTo7s/tg6vTvvl97Tv6pE1lrpsZSjCvPUAG5fZegafESybCDO
 UKqYn
X-Gm-Gg: AfdE7cnbuP5Jm5zyEjj6FMBaXVsiv/K/LPmFF0YS/xLqDzK/wdjf/SCskMuHY1992cY
 NIdifUrqHBrd4qZKWrKvPJcqzjoWraSxpWo1azRH1nCe108sS2qg1o8m5eOTjEAyp+mQfoaMFQB
 eal3PjJKpE4Buksd0FQYXBF4bEx+K7ntz3DJwWWLP9aD9rUKQrMzOtgnEqkNRezmW1xrTmVsZoK
 ZTSegZY7bOa3ZzpKR25qlROacfdXi5QMzqTAnOfvvKOrZZq6F0L6gqOS7/IQR6CZu0r6XCkakS+
 Fb4G/4WWXJA35Qtfo75ndm+zhKu9tnkY3789YusjPov/dWSThU4iJ9xSrPHKqNnwGMOhVArWs7G
 zjyGO479aKFZUrsJ5Yzoxq3Q55DBKluSpRKwJxclCVjeq0iySc+TS7Zx1fRRA/YHceC4yftAzzT
 V/A971F8qFE+uBRgT1pl0asYb3DRRL4ZVtLUu2+7zqTGjCoX1S1G7mSzS9yEqqXPeaLls1h3dVW
 gQ8UOoOAK+7EDDgWnLBfQ==
X-Received: by 2002:a17:907:1c84:b0:c12:6f47:1d30 with SMTP id
 a640c23a62f3a-c126f471e3bmr109047866b.65.1782734485978; 
 Mon, 29 Jun 2026 05:01:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/54] target/arm: Implement FMOPA (widening, 2-way,
 FP8 to FP16)
Date: Mon, 29 Jun 2026 13:00:28 +0100
Message-ID: <20260629120032.1645265-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
Message-id: 20260625015159.719300-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 35 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/sme.decode        |  1 +
 target/arm/tcg/translate-sme.c   | 24 +++++++++++++---------
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 3c2d959099..5606f0fd8e 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -893,6 +893,41 @@ void HELPER(sme_fmopa_sb)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
+void HELPER(sme_fmopa_hb)(void *vza, void *vzn, void *vzm, void *vpn,
+                          void *vpm, CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    intptr_t oprsz = simd_maxsz(desc);
+    uint16_t *pn = vpn, *pm = vpm;
+
+    for (intptr_t row = 0; row < oprsz; ) {
+        uint16_t prow = pn[H2(row >> 4)];
+        do {
+            void *vza_row = vza + tile_vslice_offset(row);
+            uint16_t n = *(uint16_t *)(vzn + H1_2(row));
+
+            n &= expand_pred_b(prow & 3);
+
+            for (intptr_t col = 0; col < oprsz; ) {
+                uint16_t pcol = pm[H2(col >> 4)];
+                do {
+                    if (prow & pcol & 0x3) {
+                        uint16_t *a = vza_row + H1_2(col);
+                        uint16_t m = *(uint16_t *)(vzm + H1_2(col));
+
+                        m &= expand_pred_b(pcol & 3);
+                        *a = f8dotadd_h(n, m, 2, *a, &ctx);
+                    }
+                    col += 2;
+                    pcol >>= 2;
+                } while (col & 15);
+            }
+            row += 2;
+            prow >>= 2;
+        } while (row & 15);
+    }
+}
+
 void HELPER(sme_fvdot_idx_sb)(void *vd, void *vn, void *vm,
                               CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index ef1375fea7..05bf8dbdc2 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -40,5 +40,6 @@ DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32
 DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 1dd3b7c8b2..755d5f00d0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -199,6 +199,7 @@ BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
 FMOPA_sb        10000000 101 zm:5 pm:3 pn:3 zn:5 0 00 zad:2     &op sub=0
+FMOPA_hb        10000000 101 zm:5 pm:3 pn:3 zn:5 0100 zad:1     &op sub=0
 
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
 SUMOPA_s        1010000 0 10 1 ..... ... ... ..... . 00 ..      @op_32
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 197274d00e..7eeac28480 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -616,25 +616,29 @@ TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32,
            : !s->fpcr_ah ? gen_helper_sme_bfmops_w
            : gen_helper_sme_ah_bfmops_w)
 
-static bool trans_FMOPA_sb(DisasContext *s, arg_op *a)
+static bool do_outprod_fp8(DisasContext *s, arg_op *a, MemOp esz,
+                           gen_helper_gvec_5_ptr *fn)
 {
-    if (!dc_isar_feature(aa64_sme_f8f32, s)) {
-        return false;
-    }
     if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
         int svl = streaming_vec_reg_size(s);
         uint32_t desc = simd_desc(svl, svl, 0);
 
-        gen_helper_sme_fmopa_sb(get_tile(s, MO_32, a->zad),
-                                vec_full_reg_ptr(s, a->zn),
-                                vec_full_reg_ptr(s, a->zm),
-                                pred_full_reg_ptr(s, a->pn),
-                                pred_full_reg_ptr(s, a->pm),
-                                tcg_env, tcg_constant_i32(desc));
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr pn = pred_full_reg_ptr(s, a->pn);
+        TCGv_ptr pm = pred_full_reg_ptr(s, a->pm);
+
+        fn(za, zn, zm, pn, pm, tcg_env, tcg_constant_i32(desc));
     }
     return true;
 }
 
+TRANS_FEAT(FMOPA_sb, aa64_sme_f8f32, do_outprod_fp8,
+           a, MO_32, gen_helper_sme_fmopa_sb)
+TRANS_FEAT(FMOPA_hb, aa64_sme_f8f16, do_outprod_fp8,
+           a, MO_16, gen_helper_sme_fmopa_hb)
+
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
 TRANS_FEAT(SUMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_sumopa_s)
-- 
2.43.0


