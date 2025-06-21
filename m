Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CD8C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z4-00056F-FF; Sat, 21 Jun 2025 19:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z1-00053x-P5
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yz-0004Sk-0A
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so1747131b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549848; x=1751154648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yfWoDmMqg4SiYulb4TQLprO2zdsAlngjZxSl98TgkMU=;
 b=Ca9HfIDGlyXqKd7TDuwnOO6LoKFEigaXsycQ1JTTZAPLRlU3m8rcPKp/efpwpSomEn
 es3yr0/XA1SfMjDYkcqqXxkGlf3EeB/Kala75Hb+lSKhiiuJ7vklJ0TOYeNWvtvVz9Ad
 vjsfqYk+RAzjQAqhHwDcBecYOeYC3G3FsW0OkgG2q4hhSXMTlpcwlYdRpkHPuZm5UcU3
 oDtvbOuQiuEsT+E/+DavPA4EHg657U4sk/cUxxT0y7954LrcDrhvVGhZ5Ti8q97JBAdm
 HUoOB6GzbQMUyH0utlaoHHFbneDuBAFcjvubx8qcOK3nbg4OIsZAOj1FOW37x6ed/D3L
 msEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549848; x=1751154648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfWoDmMqg4SiYulb4TQLprO2zdsAlngjZxSl98TgkMU=;
 b=Q0O3Mk4u4yRPfVntGGxdfD2Y4ZrWVwlnaOz0mR3aZbDAljwAcMobqDE0VqA8k4HwMP
 oebOA9R0/eCVUtdUO79YzZUmSsPxbxwsY9GER7SLV7T42+JUpwLziOANrlL/v8fRbW9j
 TmGT5BhgjdUp6u62T2j6KLuH0iBrvdkkOZu4gDb+UOaut467l8KGXq60GoQa3t4jnZ29
 bdr+hNd3m5D97djOrs6w39ppQJDAd+L/uNrcG5RepQ7LYu3ViPFaRfeDmHN1X8wDf65B
 /QbBCtPrRCn1g58NvVkaE++tSrpPz9MRj11dSs8cp/gFMNeEhgvB6NoL75cIhlpdYRj+
 9p7A==
X-Gm-Message-State: AOJu0YwvM/E19MyEDFIfNoD+OgjW6Ui68pUZHS0++HSI/stc3Q/ZwjxG
 Twg8mjEsKOKmxiC/Lb9NWKH/ikWC+QfxV3cUvJ1JyHNqXjo5lHjgg9fvzDaj59hPpLsuPm0jJQR
 2ASk8
X-Gm-Gg: ASbGncuWXltvNKsP7BA9GyuflCvYFJC+thaWdePcQgg8RYUPprwtU+jmjoURrENhCvm
 Sqdjxb4xxJrMmvGMsZs0i68E1YHxF2ON8cWzVi8hx3II+uosu1tT38cbEFn40b13sQqmVds1/3z
 k/l5GA8dZXDvB7WFyAK1raC38jH/C8BmeyE6x/QDEpfDxE1u/SsEU5Wg8o2irs8rSrLTwO72cd2
 Av3wXcSA0YMwI79+oqt0Y1Zfo94YEdIGTTzwnek/db/gJgHsk0WMuWcsYsRT+86sDNFl1TdUFbR
 0dB37i878kio1ZkwoFRbZTLS1gf6ZozDmuxN4FEYoA5Bo8BJxUqpocSLvcu9cbovUNYzw2Xb0jh
 5L0/dE/G6e9e+vqyV6+yXu2c2uH9Qhqo=
X-Google-Smtp-Source: AGHT+IFl+L7CGRYTrFOAS4kTDG1/7lCetkKTUp9/5C1GwVrDRjDR9FsAusjSBJw7h/NBbqJDARgEbg==
X-Received: by 2002:a05:6a00:4b56:b0:748:3a1a:ba72 with SMTP id
 d2e1a72fcca58-7490d74c28dmr11548205b3a.20.1750549847601; 
 Sat, 21 Jun 2025 16:50:47 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 013/101] target/arm: Use FPST_ZA for sme_fmopa_[hsd]
Date: Sat, 21 Jun 2025 16:49:09 -0700
Message-ID: <20250621235037.74091-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c    | 37 ++++++++--------------------------
 target/arm/tcg/translate-sme.c |  4 ++--
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index de0c6e54d4..e3ed03a294 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -904,20 +904,11 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
 }
 
 void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, float_status *fpst_in, uint32_t desc)
+                         void *vpm, float_status *fpst, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) << 31;
     uint16_t *pn = vpn, *pm = vpm;
-    float_status fpst;
-
-    /*
-     * Make a copy of float_status because this operation does not
-     * update the cumulative fp exception status.  It also produces
-     * default nans.
-     */
-    fpst = *fpst_in;
-    set_default_nan_mode(true, &fpst);
 
     for (row = 0; row < oprsz; ) {
         uint16_t pa = pn[H2(row >> 4)];
@@ -932,7 +923,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
                         if (pb & 1) {
                             uint32_t *a = vza_row + H1_4(col);
                             uint32_t *m = vzm + H1_4(col);
-                            *a = float32_muladd(n, *m, *a, 0, &fpst);
+                            *a = float32_muladd(n, *m, *a, 0, fpst);
                         }
                         col += 4;
                         pb >>= 4;
@@ -946,15 +937,12 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
 }
 
 void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, float_status *fpst_in, uint32_t desc)
+                         void *vpm, float_status *fpst, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
     uint64_t neg = (uint64_t)simd_data(desc) << 63;
     uint64_t *za = vza, *zn = vzn, *zm = vzm;
     uint8_t *pn = vpn, *pm = vpm;
-    float_status fpst = *fpst_in;
-
-    set_default_nan_mode(true, &fpst);
 
     for (row = 0; row < oprsz; ++row) {
         if (pn[H1(row)] & 1) {
@@ -964,7 +952,7 @@ void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
             for (col = 0; col < oprsz; ++col) {
                 if (pm[H1(col)] & 1) {
                     uint64_t *a = &za_row[col];
-                    *a = float64_muladd(n, zm[col], *a, 0, &fpst);
+                    *a = float64_muladd(n, zm[col], *a, 0, fpst);
                 }
             }
         }
@@ -1035,19 +1023,8 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
     uint16_t *pn = vpn, *pm = vpm;
-    float_status fpst_odd, fpst_std, fpst_f16;
+    float_status fpst_odd = env->vfp.fp_status[FPST_ZA];
 
-    /*
-     * Make copies of the fp status fields we use, because this operation
-     * does not update the cumulative fp exception status.  It also
-     * produces default NaNs. We also need a second copy of fp_status with
-     * round-to-odd -- see above.
-     */
-    fpst_f16 = env->vfp.fp_status[FPST_A64_F16];
-    fpst_std = env->vfp.fp_status[FPST_A64];
-    set_default_nan_mode(true, &fpst_std);
-    set_default_nan_mode(true, &fpst_f16);
-    fpst_odd = fpst_std;
     set_float_rounding_mode(float_round_to_odd, &fpst_odd);
 
     for (row = 0; row < oprsz; ) {
@@ -1067,7 +1044,9 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
 
                         m = f16mop_adj_pair(m, pcol, 0);
                         *a = f16_dotadd(*a, n, m,
-                                        &fpst_f16, &fpst_std, &fpst_odd);
+                                        &env->vfp.fp_status[FPST_ZA_F16],
+                                        &env->vfp.fp_status[FPST_ZA],
+                                        &fpst_odd);
                     }
                     col += 4;
                     pcol >>= 4;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index fcbb350016..51175c923e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -358,9 +358,9 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
 TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
            MO_32, gen_helper_sme_fmopa_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
-           MO_32, FPST_A64, gen_helper_sme_fmopa_s)
+           MO_32, FPST_ZA, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-           MO_64, FPST_A64, gen_helper_sme_fmopa_d)
+           MO_64, FPST_ZA, gen_helper_sme_fmopa_d)
 
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
-- 
2.43.0


