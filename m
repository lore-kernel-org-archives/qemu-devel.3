Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A34D41173
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLPB-0002Lx-HU; Thu, 15 Jan 2026 06:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vgLP9-0002Ks-43
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:20:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vgLP6-00076D-Ee
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:20:42 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so647237f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768476039; x=1769080839; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gxdv/yxf7Gc06BBnTyaRhxTtJwT1Uo1vV5jtTthLm+g=;
 b=qS7xQvlG09iPolSzKFa9wG+FO4M3svfLGuB7L7k2xfnFc6I9DJHJ4KzuN7dUrD88tC
 KuRUc6zFkLjS0CrPx5Ur9/mbnF2xCmTSeZ6YBuu7lwBMAT2ZB4zuoPEQHRi0hTOqFaeX
 AXKOMsWbiAanlVMMsD6wNY2S7iCx6RJFgQ2ozdqIW7YLP5yMT3KWgCHXsEqZcBEUuOad
 dkFcyGRPLAE/yXAn9cHr4KmEwVO7Jk2Wu7a2vLFLrcHvmv9FUKN5DpnNRcmYisVo326P
 RvLaxF+1caRAwfxNiwpXBZzdq2AzbDfBeXMoh8WKi087z8W1JcNwsm31JVlZ/ggvjyBP
 o67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476039; x=1769080839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gxdv/yxf7Gc06BBnTyaRhxTtJwT1Uo1vV5jtTthLm+g=;
 b=rrFGHAxrkPUPIAfkBFXAq2y43eB1juUxOYfNCb2ZXf6cO2VMACjhvXT9juGHyZQB0+
 7+zKT24qU5I9q0FXvsB0qvUPbubHsHyQAI/BTiAUec8Q0FEXr22jlu4BM9kD/9u90fyZ
 sbfHEGx9uxkJ5/lHYlUCww6gswSCl5bRqRnTmPS2VjEspGMqbiCULXXztewHSNYj9pEx
 9E4hdPpxvrTQA/qxvE/TyIhSkKll4hyKWgAURA4ZtdIvcBkoWeEr335Ry6Lt4+6XMQ9x
 iiy8Z75b+lLaM4UDd4CkevQMv05IxDJNgvZKbzqdCoJnRDrelmTNqbn8aYO5UyoF8x4C
 ap1w==
X-Gm-Message-State: AOJu0YwD5yUdXO+wr9AoU5kHNcqPCps1lpoq53SjGVROOhhC3KEStn+W
 yLG9N3y/yv8ICiLa01/cziKmMVVx9CD5Q20jBFzjKkS+L4wQoYl7lQmjWm0vL6MlGvk=
X-Gm-Gg: AY/fxX6+N5EiqdI60BuXZs/qOj5r9WGA0o1q4XFyBDDZKDjJS52HbRTvF4ZrOr4qPsG
 otw2LdeGuLCFfsmkSbuvjaCtTc2/CpnzfmeBbcGTw68Tj+jCvtIyIg1w/ZrHA9E75FJI/n2uqh/
 tpKuoWDYORiQ6WtDpmHV9FMZGes5AZFx0xo3ItViYjd/w5knvEAl8aFmkENbJkqnSBBKDBzlirW
 bE481CX5tGqyLEyZLYAfc6Ug45pFIOJ5vLU1cwcR19VZ4sS05F/0TTAg2m1GKhnq9Ztmf+wPd4N
 eN0bZRNTcJ+xWDoSsvWiouQntm8g6B1QcT4CfaWtRgjSTcAn/C9kPlaWIchjS51/lawoy5IsheM
 klVkETQnljsOF66FcwbO6DRBu6Mhrg1CaOZddaN3B5kt2zIMslp+eMIAPYZp5hUQ9bSC1FQM3YR
 bqiFpdcnjeETAq2VrkH0qiLM/OMkDxCB6hZp2RVhNJJTSlGkZRBkOJ4Cc429BKbeSwYfcaOOoU/
 luZ6FoB4D5O/jtxiD5/rQwF
X-Received: by 2002:a05:6000:438a:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-4342d5ced24mr7738335f8f.47.1768476038866; 
 Thu, 15 Jan 2026 03:20:38 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-214-23.home.otenet.gr. [2.86.214.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af64a778sm5302085f8f.3.2026.01.15.03.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:20:38 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 15 Jan 2026 13:20:29 +0200
Subject: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
In-Reply-To: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3824;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=X+YHhHK/0kmvaB/J4/1t1nqbn+MaGoCBFh2QSc+9wsw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBhTTJDVS84ZldCWkNBa0FnTy9qWTNyM25qYWxTCkozUS9xMFoxZWtoQWJvUVNS
 Nk9KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVdqTmdnQUt
 DUkIzS2Nkd2YzNEowQ2FBRUFDSkNma2FkNm1BYXFXZjFaZFYrdnhmZ20rMzRWSHVWMXJJUTNZNg
 pTSWRROE4wOWRycHN3Kzh6NXhnSUdwaE9EamloVEZLTHh5M1FOSnppMGZvTkY4dlIvdlRHMmRpc
 WVTYjJlZHN6ClhzL1cvRHM5SDczM2JxMVR3T0tCTlB5bWFMSTdqN1ZmWkF5VEdTeEFRUG9EVmRB
 YzFpWndHWnRWVXlSRllleUgKQ1NIYTBsVS9TTkxFYzNCb01UV3p1UWx1ZjB0OU1VRERSbUp0WER
 xRlNnRU5CcXpsMnJQQjQ1SWd2aStSeXpISQpwMDBUekxqcU02OXhodURjNExGNDhBTnhHc1NaT0
 crejhZSmFwRVA2ZDNOUlBxWkFMN09HNTA2OGJ4Y00xUFF2CjJUaDdtSFlTNlNnK3VTeUdaYkFET
 Dl2b2c1OWlnaXVLYWw4ZXAyc1JObEkxVzFsTFBEWk5vRTJPTU51T1EvdlAKeHpQWXliaTNwQ1lU
 cVc1dkpjN3ZEVTdyeE53RkVrME00UXZvZXlIWHNUL1FSWVBVWHZ1WmhMK1dCQTVVRUJNOQpIaWh
 EWVR3T2REOU14a0dRYkVHamNoc3BQcWpGZG8yNHRoRVZuZ0ZodnIwSE9NSjhmTjlZTzI4T2RRTy
 9IQ0JCClNFckxBdUdXUGxSbEdaVGt1cXpCL2lZMzU0S0JhNGk1ZGtud3QxbU9wN2plMkJZUEY5O
 HhXejVxNEV4REtIckEKWmYwQWhFRGZLTVBsU1VlZ21jQXRwcG8ybDRrbUV1Z1hyTVRUcXNKL28y
 RHJrQ2hESWdUUXd5anRUcmt5Tk03ZQpIOHJrcTdpWnBtZXpxRzZObWFkWm1CejgyVGpzUFRhdlN
 5TGZPdjFmZUNHaWxQejBWdkQwTU12OHM1bWFETW0vCjZYdURlQT09Cj1LU3dKCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_SME2.

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/cpu.c     |  4 +++-
 target/arm/cpu64.c   | 13 ++++++++++++-
 target/arm/hvf/hvf.c | 25 +++++++++++++------------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index caf7980b1fc5244c5c2f130e79ba869456c20c88..7f4ebfdf61217db6075495119c1b642bc2abf295 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1577,7 +1577,9 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
          * assumes it, so if the user asked for sve=off then turn off SME also.
          * (KVM doesn't currently support SME at all.)
          */
-        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
+        if (!hvf_enabled()
+            && cpu_isar_feature(aa64_sme, cpu)
+            && !cpu_isar_feature(aa64_sve, cpu)) {
             object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
         }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index bf303813701972648fa6751ffe352ba074ca6442..8dd9eb46c783a799a53891a6ddad40b930e95eb4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -329,9 +329,20 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 {
     uint32_t vq_map = cpu->sme_vq.map;
     uint32_t vq_init = cpu->sme_vq.init;
-    uint32_t vq_supported = cpu->sme_vq.supported;
+    uint32_t vq_supported;
     uint32_t vq;
 
+    if (hvf_enabled()) {
+        if (hvf_arm_sme2_supported()) {
+            vq_supported = hvf_arm_sme2_get_svl();
+        } else {
+            assert(!cpu_isar_feature(aa64_sme, cpu));
+            vq_supported = 0;
+        }
+    } else {
+        vq_supported = cpu->sme_vq.supported;
+    }
+
     if (vq_map == 0) {
         if (!cpu_isar_feature(aa64_sme, cpu)) {
             SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6c5061742862635ae394f764188114f939259703..01bbb90b962156885021da75a0d62ae3c39ff5b0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1043,18 +1043,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
-    /*
-     * Disable SME, which is not properly handled by QEMU hvf yet.
-     * To allow this through we would need to:
-     * - make sure that the SME state is correctly handled in the
-     *   get_registers/put_registers functions
-     * - get the SME-specific CPU properties to work with accelerators
-     *   other than TCG
-     * - fix any assumptions we made that SME implies SVE (since
-     *   on the M4 there is SME but not SVE)
-     */
-    SET_IDREG(&host_isar, ID_AA64PFR1,
-              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
+    if (hvf_arm_sme2_supported()) {
+        t = GET_IDREG(&host_isar, ID_AA64PFR1);
+        t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
+        SET_IDREG(&host_isar, ID_AA64PFR1, t);
+
+        t = GET_IDREG(&host_isar, ID_AA64SMFR0);
+        t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 1);   /* FEAT_SME2 */
+        SET_IDREG(&host_isar, ID_AA64SMFR0, t);
+    } else {
+        SET_IDREG(&host_isar, ID_AA64PFR1,
+                GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
+    }
 
     ahcf->isar = host_isar;
 
@@ -1252,6 +1252,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
 

-- 
2.47.3


