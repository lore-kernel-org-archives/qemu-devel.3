Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89084C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwxS-0004uu-Ic; Wed, 02 Jul 2025 08:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnL-0000Gz-7v
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:36 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn4-0003Fm-Gv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:33 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2eff5d1c7efso2759398fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460134; x=1752064934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tpb9kBb9ePD/2rinqu5cFwKcI5GW7r9XMuKCQWyw0+Y=;
 b=Z2V/lDvX3kYc0fVsVgAftEmWA/V8qhC+/VwuoQvjKWuzkujitfKIqgDCwtMBvpSmWE
 7E3WLwygzibhLemPBGoL2Vf4oWIQBaZ7Uo1C0AG8S5WlnZWeq10yCdsd/lrHCdpgqC8R
 hmo4Sr3HSUFOVvApDeR4NeeTHb93SZnpvjtGyqPIaalSEMUaLEBmaAx7DO/+3lRav3hp
 jYSxvz16SLcS+tFEWseY1PNuVToYx+rR3O/6NHCKe1JRhVIYDTbjMrDI9WPqdM0lESmg
 x2i54QiyRc7AfxEjx6fFipWi30yPtAUn0ZdxumnzDJ/13Fn3e3JkOftw8+P8DIP50igk
 42vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460134; x=1752064934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tpb9kBb9ePD/2rinqu5cFwKcI5GW7r9XMuKCQWyw0+Y=;
 b=DyKi6BJS0idBQsnocF0S8Fsx8jx6kP+5V0lmZU4/7cr7U/4JR+PNRI+rmBDhnd+Y6y
 FPsY5k+P+QzptcrhWD8g6WY+193gq+ZKYftFw2Z1EzQ6IrE2/Y56FwVMmoyW5jhUrvNg
 M6CJ+7zAuHcgXoN2pqwblmGE+KKDau2WO70+2G0ShZKv64Ane3aaGNsfanuAhFi8r7gD
 polxcILqHme8teo9q2obw0N1mkydaefq6fiWjIPk/PT3/GSC9HmzMQXOlUQvDSoI8XsA
 mhGMuzcAMyaEnX6cZkVpDghIGXcPGDONCyZfn1Fj6V5XVy7Yb7Ja3E5BpD00uktE+JMj
 E/8Q==
X-Gm-Message-State: AOJu0Yzp6CF2CxkNKGzkssUFbMtiOMbXQ2cmKkUYYWrqhUTfKicMBJZf
 zRJlDAnnnqz7ZTs0iESHmbtkjnH8bvK6Oj6WdC4zyGTnXtnsi8GyWOvfQ01Y1yxa/OaPWmNOHbA
 3/0/IQok=
X-Gm-Gg: ASbGncsWfSSLyvucfE9SlJf2o4+MXzXtHOVWwhPnc3Gz3vy998pc3YSx/l2gloGAHIY
 RbayrLc6dF1PlV3q/LVn8pzZlYDaymAOn9m8BYyLoE2q0LG/wPoozxWWfPAdedXQuUdNg+udwYd
 1mH5/H5vWbDcU4ckgfdAKQrZf/0Kx8NdWB2JJMDcW1lLVQRpniVxqNa+mssUlR8bR3iygq6KOaZ
 7Vsv+maBkiSGd/aM3PLGcIvpzaOAWsp6HLt1rx7JJy+47uNdDWnZY8UAWKzyHCy0VOk/71xvrx2
 s5egnISfro1ethLyf+alFYzOr9FhkEyXQsNj537IiyLE2ouMsBP+OuLLiwMEFZik7g574NZDg1B
 Puhul
X-Google-Smtp-Source: AGHT+IF6RteR6a3LL7KdmQA4NshSdat6J+gpkKEZhX0J6yIntVFYhw5OWrdpD3KdpK/kZDJm/u2sbg==
X-Received: by 2002:a05:687c:3113:b0:2e9:9118:9ed1 with SMTP id
 586e51a60fabf-2f5a790bfb0mr2099839fac.3.1751460134045; 
 Wed, 02 Jul 2025 05:42:14 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 93/97] target/arm: Implement FMOPA (non-widening) for fp16
Date: Wed,  2 Jul 2025 06:34:06 -0600
Message-ID: <20250702123410.761208-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme_helper.c    | 51 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  4 +++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 63 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 2b22c6aee5..fac70a82b9 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -137,6 +137,8 @@ DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
@@ -146,6 +148,8 @@ DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_7(sme_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmops_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmops_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmops_d, TCG_CALL_NO_RWG,
@@ -155,6 +159,8 @@ DEF_HELPER_FLAGS_7(sme_bfmops_w, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_7(sme_ah_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_ah_fmops_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_fmops_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_fmops_d, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index cf7ac3eda0..3420685198 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -995,6 +995,57 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
     }
 }
 
+static void do_fmopa_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
+                       uint16_t *pm, float_status *fpst, uint32_t desc,
+                       uint16_t negx, int negf)
+{
+    intptr_t row, col, oprsz = simd_maxsz(desc);
+
+    for (row = 0; row < oprsz; ) {
+        uint16_t pa = pn[H2(row >> 4)];
+        do {
+            if (pa & 1) {
+                void *vza_row = vza + tile_vslice_offset(row);
+                uint16_t n = *(uint32_t *)(vzn + H1_2(row)) ^ negx;
+
+                for (col = 0; col < oprsz; ) {
+                    uint16_t pb = pm[H2(col >> 4)];
+                    do {
+                        if (pb & 1) {
+                            uint16_t *a = vza_row + H1_2(col);
+                            uint16_t *m = vzm + H1_2(col);
+                            *a = float16_muladd(n, *m, *a, negf, fpst);
+                        }
+                        col += 2;
+                        pb >>= 2;
+                    } while (col & 15);
+                }
+            }
+            row += 2;
+            pa >>= 2;
+        } while (row & 15);
+    }
+}
+
+void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 0, 0);
+}
+
+void HELPER(sme_fmops_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 1u << 15, 0);
+}
+
+void HELPER(sme_ah_fmops_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                            void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 0,
+               float_muladd_negate_product);
+}
+
 static void do_fmopa_s(void *vza, void *vzn, void *vzm, uint16_t *pn,
                        uint16_t *pm, float_status *fpst, uint32_t desc,
                        uint32_t negx, int negf)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 782f408061..119a5665e6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -569,6 +569,10 @@ TRANS_FEAT(FMOPA_w_h, aa64_sme, do_outprod_env, a, MO_32,
            !a->sub ? gen_helper_sme_fmopa_w_h
            : !s->fpcr_ah ? gen_helper_sme_fmops_w_h
            : gen_helper_sme_ah_fmops_w_h)
+TRANS_FEAT(FMOPA_h, aa64_sme_f16f16, do_outprod_fpst, a, MO_16, FPST_ZA_F16,
+           !a->sub ? gen_helper_sme_fmopa_h
+           : !s->fpcr_ah ? gen_helper_sme_fmops_h
+           : gen_helper_sme_ah_fmops_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a, MO_32, FPST_ZA,
            !a->sub ? gen_helper_sme_fmopa_s
            : !s->fpcr_ah ? gen_helper_sme_fmops_s
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 8ad86f707e..3c58fdd2a0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -183,9 +183,11 @@ ADDVA_d         11000000 11 01000 1 ... ... ..... 00 ...        @adda_64
 ### SME Outer Product
 
 &op             zad zn zm pm pn sub:bool
+@op_16          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 ... zad:1 &op
 @op_32          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 .. zad:2 &op
 @op_64          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 .  zad:3 &op
 
+FMOPA_h         10000001 100 ..... ... ... ..... . 100 .        @op_16
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
-- 
2.43.0


