Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA94CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYf-0003L5-HI; Wed, 10 Jun 2026 12:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYZ-0002tp-Hs
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:31 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYX-0006Mq-9p
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:31 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so5012536f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108008; x=1781712808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XKLxLve8zPvoh+sexVzr4TS9/scp2nbCv7t2TIIxmQs=;
 b=v5EgBm0323DzLj0I3H0H69iyanJo3parJx6c3AU26Gya4vKtRtpSLcmKsxUH6jm3lS
 XEMCeVZvkaKKPyPZ+3waLi1IWHVxLKp3QWR1cd5LRGBysVH3wEXdyLBRdV59HUBF4SXP
 lm1+CGA9pXfBgOHgBW0i6qPKIL8Rsv/j2M9KRFfUjHTek8PYREpbb0C4z3U+XT8biPT+
 TDkEMVq2YaoX/n8NA7zMoPatzW1pJ6fG7bUmhmcHFuVkSaKKo872ZqF9+KN/YhanQb0J
 nP0fIRz/hsKCnnx+t4BLxDTZu2uH+wZNXrX76BsA3efGoFSyjXrlvdKYmrOa5fHczzQF
 INPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108008; x=1781712808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XKLxLve8zPvoh+sexVzr4TS9/scp2nbCv7t2TIIxmQs=;
 b=QNBDJ3X+T3vw76PJT4gBcD0btEXRC20+06RqPDPAvPsdX+7xs3AV5sfmEqMhX88Lpq
 /r0rj9HfBvgmJjKS+xE/hYixfk8pC3sSrlvtjmfTzRQDC89JV2vJxw1QtIe04nEIzIFx
 An+ZGWiiNfLy7OkXtpcuOvDjgdIn4G136QWh0ubjN++UzNGF5jnv3dfV4fcFSULoVT6u
 EbvocI4irASL8a8bSQuxiujufuIQ0qc66xqYl2HBo6A6ouEaOEWbubhpDSG+Gm3EjQBk
 BvUHFcOnAmyE92PfqTv2aBWZqP6KNGaQS9O4MbnuUnaUrp6SBGPatkUtCFHOTFv+yGiE
 QOpQ==
X-Gm-Message-State: AOJu0YwkAXLaNXu93djwruqPcL7sWY5GN1cwxlNZxV+iFOynJ/LM9R8z
 KiR8AOv1wtToWdQnZxmDgoGO3EErOkI4WnJpkc/RPRIYOfWbnv2P1yo0xkyZstBVBY+QeQocws3
 9PhFw
X-Gm-Gg: Acq92OGOYwIfRRrTrCexGzf3U7MqJUeHjQ9KVlmdbcuheBaBHxUS2O49ocrB2DeMwDA
 zJ7b4+Ic5At0r5ludJIMXSK7UpCCAKuJL68HJOHi8hGovRPsGGq10WmLJMIFZJOZNS645awLQ9F
 c6QX90pfTnFCyUbdKDqEqVQLjwAIVKOfAdtVusxNx9fMoDFWEriJcJ1DxJ0D2eXANHOEdpgbqHK
 RUSBzbxVtsra1fUPTetHwMJvImTKcxUIzXsGH5+hmh8Ty+VMjIQ2tIW6Wzriai5eN+uqPEsJjyb
 kWEtcGL42TBmr2ef/wtR67SwRFTkvSiFmNR10F6BwISC1Pwg+Zcog+Uyj6PAuL3OOdIPwUPiVDU
 bGuRl0xz9ojaFnYRsRnt8QcdxuTa4LWtMADWyYhX3A+BSAcQPcA9FP7Nb+uQaM1WY4CKukgyq3Z
 AciMTzuFY0sF2FognjNDSCckeRcOAMQitwbVcs/qwo5cXDgbCkPnKe0STivV6LkcvNEVCIP5Mty
 P9nCdEcQoskfHlstR5gEOiWBZ2MBNMKgYhogBEb68k=
X-Received: by 2002:a05:6000:4708:b0:455:7d77:1d25 with SMTP id
 ffacd0b85a97d-460305124cfmr43196471f8f.27.1781108007810; 
 Wed, 10 Jun 2026 09:13:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/71] target/arm: Implement FDOT (FP8 to FP32) for SVE
Date: Wed, 10 Jun 2026 17:11:52 +0100
Message-ID: <20260610161202.2235298-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-36-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/sve.decode      |  4 ++++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index cea1c56cd3..911819bbb0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1575,6 +1575,11 @@ static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
 }
 
+static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP4);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 06bbd7fa63..c49e992f10 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1874,6 +1874,8 @@ FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
+FDOT_sb         01100100 01 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 floating-point multiply-add long (indexed)
 
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
@@ -1897,6 +1899,8 @@ FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
+FDOT_idx_sb     01100100 01 1 ..... 010001 ..... .....     @rrxr_2 esz=2
+
 ### SVE broadcast predicate element
 
 &psel           esz pd pn pm rv imm
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9f207a32b9..582471b380 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8391,3 +8391,38 @@ TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
 TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
 TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
+
+static bool do_f8dp4(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                     int rd, int rn, int rm, int index)
+{
+    bool fp8dp4 = dc_isar_feature(aa64_f8dp4, s);
+    bool ssve_fp8dp4 = dc_isar_feature(aa64_ssve_f8dp4, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8dp4 || (fp8dp4 && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8dp4) {
+            s->is_nonstreaming = !ssve_fp8dp4;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm),
+                           tcg_env, vsz, vsz,
+                           index, fn);
+    }
+    return true;
+}
+
+TRANS(FDOT_sb, do_f8dp4, gen_helper_gvec_fdot_sb, a->rd, a->rn, a->rm, 0)
+TRANS(FDOT_idx_sb, do_f8dp4, gen_helper_gvec_fdot_idx_sb,
+      a->rd, a->rn, a->rm, a->index)
-- 
2.43.0


