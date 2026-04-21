Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D61BEA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3S2-0008Lj-LR; Tue, 21 Apr 2026 01:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RZ-00082K-Nh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RU-0006VA-HF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso24886785ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748475; x=1777353275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V3cChxtG3x49nUgjSHcR9O7ZWwgxyibx9DFKFeEU6A=;
 b=vDdYnR2WQde9ryZWc2xdipl0CyYUhb0kdmUJHGlltcg91rVhJUWKGb0dhvrmdVIK/0
 ljwozi30gAvfimv3C5QOp2pMP46cwHwgukaEm91ezsy4/tKBlCcwqlb1H9vL71oMdRGx
 VDtYhHd4LuuZekplJjtRiganx6qS6udVVAhkTwpLCF/J3yWl3vZfeQgL/XCz2kzBpgjQ
 7S4ndjF0S+SR9aiLW6UmN2gXR4gBYL4IOdKt2ly5Nlv7W7/KcXbpx30DVCG4/aD7xsSJ
 ho5Y7Yn56uav2Y5kKa0TvGEuWTcEzQ86Fph14DaivHUBc44dHdmkO1h77rS3InVcyAln
 uDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748475; x=1777353275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7V3cChxtG3x49nUgjSHcR9O7ZWwgxyibx9DFKFeEU6A=;
 b=At6gnQJS6MecGecFYfElPbh+IpjHdoyX+HBwXCIDUTLpbVQQff05LveeEx6UNrHuGr
 lqZb6vsAa04Hy+wXv5pu7FC35jJMuL/TbolFLNI/+4Ah0U3S0Kx3snYFaa+kuJX3LfrY
 z2hKFxhAvCc7fY6vBX9gGq7ATEYzY7yWYVEZ+L+tkrTDnNqYBzPIgvw+ITu+1ntIvfNJ
 9CPVpX8fJI9uAqlRPjVARxpf2HOoFcE9eUO9QpzNP6b7/APhZRsiaxRv2HKGYe0ayjIA
 /wq8GiJb5OssFhZol2v+GNbfPo2twwDYJYY8c7ihFlORXR7YrcAXNrvoA2PjCn96NN2z
 4KpA==
X-Gm-Message-State: AOJu0YwngHgOA2AMqpYU/rjwx87FDvYYGhWH0TD0cMPTTuCE3Vk8VfF/
 oZgNlERjRl+v4BQZ2ucbmstj83Tw4SPu8bIfmpYqJGKQgh5Ik204ix23QfWJslh8Z+S/0Ql+6YC
 jxJStXi0=
X-Gm-Gg: AeBDiesN5e1lFVO+1IA+8dwqLQuUdqofu3f0Wtb0RwmAikiqeOVFBpXw8CZMNiR2Y1D
 YGhdsEhibX4ec3R+ch5V4Kgvcoql+MEbuEVmbn+wPUNOwuS5GDNjd6WEMg3CmA8OX3kOL97uJ7L
 d9z9god3j+KnWoaMISf4zrHF0hZdNNnKwLioLQ4HevmqbpVxGswrqA2ca/7yko43kDk1Qe87KD7
 uRZvJ6SuYnqOHSY4BH315NNc5hdfShewO9snzyhs1pzxQvhltCDuX8xua5x4k0/I5SMcSuGwFA7
 4Z1x21++Cwr5V4gt3dI4c0Je8TG7e9HArPkdMqqVZStit9nXQamz40bIRhVCF+TA34/ZJVYMuRN
 jGNJQGzw9UAJ2SmJIVaO0PQ4W2I+a+2gpwPyyR7mnsQDVPUY7MD+W1RUBMhkU1dTbQ4AiVXj5U2
 bCExjSx+SK/nVuTIkjVlj6WOnFaktly6Ona0DQmg6D
X-Received: by 2002:a17:903:1aaf:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2b5f9da4c95mr140202665ad.3.1776748474700; 
 Mon, 20 Apr 2026 22:14:34 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 18/37] target/arm: Implement FSCALE for SME
Date: Tue, 21 Apr 2026 15:13:27 +1000
Message-ID: <20260421051346.41106-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 15 +++++++++++++--
 target/arm/tcg/sme.decode      |  6 ++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 87d16b57dd..8a6e5d555b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1603,6 +1603,11 @@ static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool isar_feature_aa64_sme2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ca6b130cfe..c6a8eec32c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -706,9 +706,12 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
 {
     int esz = a->esz, n, dn, vsz, mofs;
     bool overlap = false;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     /* These insns use MO_8 to encode BFloat16. */
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
@@ -718,7 +721,6 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     mofs = vec_full_reg_offset(s, a->zm);
@@ -830,6 +832,15 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
 };
 TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
+    NULL,
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_z2z_n1_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_z2z_nn_fpst, a, f_vector_fscale)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9dec7318a4..ee874be1a6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -250,6 +250,9 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
 %zm_ax2         17:4 !function=times_2
@@ -291,6 +294,9 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
-- 
2.43.0


