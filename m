Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0C9CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmg-0000iR-S0; Tue, 26 May 2026 10:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmf-0000gS-ML
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmd-0001Mj-GW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so78344815e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805766; x=1780410566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3IOAQk6KbulfhANL9WnNqNGOvA2dsDEB/htNxscxGVU=;
 b=z0l3i3aJ42X9tADZ1iX2KLV78Ra8TbJqkUHJdtEtM/F4jbJAyC6cbvUpUr82aqbkz8
 ND/7+ViUpfTTTwzuLeZA+4QmbrgQnqleNwKUwUqLfjOwRtBHQK9hzZi6LXwPzJY1Zx28
 ruDhb/1Lnlrf3scKQ/I6V1JelAM9AZB2yimrcxPTbbhgH2+KeykyGWa+sE2j/d7rJXwA
 eYi/z9sooVfPRPc21BIEdDAoR/e/FTXgnh3jnU4hFOsYf2X74tcSfChoDbUMYh5XLt2f
 5cPAb14UK+ngLJJh25xvZ/H4FlWpjn2LfmH8gdXTiC/fE+t+PSsY1nQnB66lQIv37sPq
 lK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805766; x=1780410566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3IOAQk6KbulfhANL9WnNqNGOvA2dsDEB/htNxscxGVU=;
 b=USj2EWibQ1rbjWe94TgMiv81/sBEKSyGw5TlcIH/iF6OLQg/MXrnImqXmEU1VnACfb
 v85WPhH8YS83HWAzHhoZfsjL/Fh3NGe21aUjCo2EoGn/wU2jmY7V8lRlxlwo4+kROzSv
 2Cv58UObP+jUmHr51n83RJv/o+n1meoJx1+zILMUXzZH3pXNDiRA8cY3vO7mhFgK8nhf
 Qu8oNwwCgUzkvZb6DCHCh6YdOxfpF+7/t8UYB78II0gmj/CMsg8iK9SEa8lWziSoEFsA
 lxvpcHAM2JFJ6U108ydAB+AVhCzNtTtn2RbSfTVrsVhPfxhHfwl01j9CodETT5xNl2Z8
 MCwQ==
X-Gm-Message-State: AOJu0YwK2xAfMA5iGzIzCeo4YNW6nP1+rL8ZjPU+R2KNwXnq8FBnewpG
 zLTApg5t8aqoR88R8DyneZPeO+tJljDInv/ysxdnCL6bhfHCltbKGPKpywjgA8mtgLgy8QmFTuD
 JGNTo
X-Gm-Gg: Acq92OFHxDbLaReaP6YL1gM2UzRlZVv8LsbBgAB4TZgz7X/tK7XdQF4G7E8gzbeqAYL
 DKSJSZEjCpvummcvl0mQ9eh4z2UmgLwsfg7FmiiitTx74hg4xKNsPSzAJ5r6iT0XeY3fB+Royae
 THclTOUzmVyCjUChaMQiak8n182x8zKMZps6A//3//E8MwkPI5l5YXkD6zxK8PRXwqPDX69Yh18
 1khng4aXPq3IKiPHsyJxBVjI9fkFVwLhVPsWIBpBxDxXMAtucsZJACU4aqUhR8bQAOTxzqDm16Q
 NJBm1CVbD+omQvl+nBOl4CrD9G+UB5chpow0ErIyAn8vi6MbziCaaC5Aobxekqb+iMwdEsmtRiQ
 7Tojgqcg5xJ34K9S8xjVNwfCwu1me2eUPxPBskwv/LiZtYPFLXTTFWlEDFNynPg2qDVPlgIK7DE
 J7EhaTyxv4KhjKzor+3N/bT0s8t7xAzwWGkS0my6lxSz2FlthXbZnfBlrBQ05mC4fmuyhEF/XeU
 jgC76jpYLatf0EcmudlP4LhA5nCbjQ=
X-Received: by 2002:a05:600c:8b84:b0:490:5466:8576 with SMTP id
 5b1f17b1804b1-490546689a7mr274166605e9.1.1779805766028; 
 Tue, 26 May 2026 07:29:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/54] target/arm: Implement FEAT_FAMINMAX for SME
Date: Tue, 26 May 2026 15:28:30 +0100
Message-ID: <20260526142850.2326589-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Since there is no bfloat16 variant of FAMINMAX,
check for missing function pointer in do_z2z_nn_fpst.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/sme.decode      |  5 +++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 21a1f941dd..21b91b1503 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1593,6 +1593,11 @@ static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 6bb9aa2a90..9dec7318a4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -286,6 +286,11 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
 
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_2x2
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 08254b088e..a67501226f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
@@ -742,9 +743,12 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
     int esz = a->esz, n, dn, dm, vsz;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
     }
@@ -753,7 +757,6 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     dm = a->zm;
@@ -812,6 +815,22 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
 
+static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
+    NULL,
+    gen_helper_gvec_famax_h,
+    gen_helper_gvec_famax_s,
+    gen_helper_gvec_famax_d,
+};
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famax)
+
+static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
+    NULL,
+    gen_helper_gvec_famin_h,
+    gen_helper_gvec_famin_s,
+    gen_helper_gvec_famin_d,
+};
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
-- 
2.43.0


