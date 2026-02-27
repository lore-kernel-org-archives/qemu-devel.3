Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50008FD530C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsn6-0006OT-CF; Fri, 27 Feb 2026 03:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvsn4-0006N9-PN
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:01:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvsn3-0001iv-4y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:01:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48069a48629so18559765e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 00:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772179295; x=1772784095; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XHV1zf0s+0F/5mphPCH44zJjAmeYKXQ8aD+6cz/7SxY=;
 b=VziIWz8CKdgzLN3W2gFILeHgEglpgusnVuQm//TxVNxddi5KCUdZjKobUX2gFH0M+D
 1iKPu5E6hRDbLL/ZE3DL01SRbq3qbjzflncB0N3ASUa9/GasgmbUlepmdycCFwH7lJ3Y
 whHojRqZExto9QX+MbhbwHVoxzLl90dojBQ+HfwqJcsSMZBH8VJLHVznYFrK6buQly+p
 5Ot7X5El0LRnY3U7IlHVUfngcYkgToqZk1FzX+Evq4sXrnuBWLUbHECFY5nPdqebGENE
 4OkV9gTXGF33A0Ta+A+8h2N5vN5qBbeT51EipXONOeQ6EH9ww9U2WU89R9yOXseZIaqo
 VAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772179296; x=1772784096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XHV1zf0s+0F/5mphPCH44zJjAmeYKXQ8aD+6cz/7SxY=;
 b=gGQrDwUeUom3RNkOToZSdHf/fdIX6qp0SV7evX4RQHKmX4wkBuVWZzPohJgJ8hIgaM
 IkZxHe/kOJEOoRoIjGQINB4MbX7Ek/8JIwHEBV6hJh9t+9q8T7/PE9Uu4F9lMT9cGOkt
 yazLVdbPrM+OJlrHKp6kVMZNsnZpPzxH0FJPEQIJhYxxQzq4W1gDa+J8IPlzJbzhjpip
 skDTgeIL7sAJck97vMs1jgFHR826kcd5jimb4RbBte2Ope5IQyDn8ODfdt/4RrxDn1ex
 30P6njyWCHt/dCBWSs7SWw0MksXr19gyjhRLA3aRwP0XWJLVGRIfcuXHVArTaFmnUph+
 U7BQ==
X-Gm-Message-State: AOJu0YyvD7/xS9XGnKWjTreW07+kd8XFr500CNj2glnPbAZ1hUT522sB
 D+XiVv2dtkYwSmQsfQlWy2OF/aczZwW+2Pcbh0wO2YqKG1o2qSK1HzCn+PGSZ8LzydU=
X-Gm-Gg: ATEYQzxkIe3I6G+dI/rRwNNqUNkLVegbVMB/otI7JJVZjbQh5kHGRtG+QJaJv+qjbV1
 d37PnH8ulaNpBpu+StN1jQdK7SYdv8Bru+Vnkisr87Sb728j6KCO4qnYGrsGQzFCl2AU/TQJqFd
 VIpO3MXACYiFznUasqCaniWMn/I1AMAmCdjMmr0ytoIHBj74byMOhpYwxi2IvdQVZ4riLNxlqXj
 TzMQE+6TOvpzKsF/O6H3hGJOteXnCX7c9u1LGdmTdetZ0EsEME1bj2VwJ2dRK3LMcWeIjjtI22L
 R3E4LyvLwPxF4Xj98bojOPV+rF/BrHZy3QLJBBFt1FUjFN9mblETFM54rvk1X9oYEypVY+xNBOr
 H6xTXB5YUqrXAsSl30+vvxHImKamqiJFtIjc2Vycx7UxPPNcdd+xR/PfGZVEfBN6Lm1zHKBCpeu
 Tl3xfTaNEl4yG2kZEdV13wQ/nzUuK04XDT9EOmk/R0IuvD9l+t1BFe/kyrQszFZzc/mx7ntFKBd
 FXBZko1FeXNVYWTZXiMvA0XLZCqjrW7b76Z8sTn7k7k+vD7Ww==
X-Received: by 2002:a05:600c:c490:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-483c9c204b0mr27321915e9.31.1772179295489; 
 Fri, 27 Feb 2026 00:01:35 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bffc17dasm98554765e9.2.2026.02.27.00.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 00:01:34 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 27 Feb 2026 10:01:28 +0200
Subject: [PATCH v4 2/2] hvf/arm: expose FEAT_SME2 to guest if available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-sme2-hvf-v4-2-3dae31a1876d@linaro.org>
References: <20260227-sme2-hvf-v4-0-3dae31a1876d@linaro.org>
In-Reply-To: <20260227-sme2-hvf-v4-0-3dae31a1876d@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=e/vsNryygBBM3ClV3NdyZUVw3FsFJZH7OZZmrgohHKc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBvVTliMnJnNG55RjJMZHRDYUhsMjNHUzdVMk0zCjZqNUMzQTJIK0d4QmN3Smc5
 ZENKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWFGUFd3QUt
 DUkIzS2Nkd2YzNEowQ3BvRC8wY25iQ014NElEdGF1dSthZldmVlJ1ZkMrOE8wZDQ4RTR2Rk4xbg
 p4bjNhL3A1Z0huUi92MjhBQmlKSkxTajdxYm9SZERZdnRlZjBWVnpXdk1halBaWVROZjlKOFRsU
 2FrL2tiNzA3ClVsTE5hZGgwWmhvbHptMEJNV3lCdERRaFFHV05CeStHdUc4ZVNFZVFaTithei9V
 T24yQ1c5eHpnOXI2U3ZQcTEKMHV4ZDYycHBaOWIyeHpXbUpONjVuUTlidTVSZWtWcS9FcGRjT0x
 Ub3FrN1dJdzJVMThiWGlsNHkrUUJVdTY2VAowZFpFdU9mN2J0NThRSVRIVWN6SE12YS9Ld1N1Tn
 NqZnh4c3VUYjZpMy8vTW1JclU3b2VTWlExUGVtNW1pQnVxCm1kOWluTEs0Zytvd1V3M1gvajJMY
 2VpT25yeWhXa016QjNDd0MwZ2RtVDFRYlNPeHRvQXQ2M2VWbmQzWlZscFUKUTZmZW54NHhDRTJ5
 RDdtdkdHV0V0UW9lUnRQZGJ1V1JXdGpBZUtIQlpYOVVxcWFzMDR6OWNBM0MvTGlxekpCRgpuTWs
 2anJmOVVqcDdYcFovMno0eVp5ZXlVbzNkMHlkUmFxOGFzRkEwcXlBbnROYjNtK0ZjV2xqbFpvMk
 pkTGZuCnJlTHVhaEVXTDFHZ2JIUHk1RFBKN0psK0ExQ1o1bW1zNTdqNWhFSWVoMVl3MisvSkgwc
 1AzcEpGM0xtSkswL1UKTURUdkd3U2sxalU5VnZ3cVg5Vk5ZRC9sczZXbmgyanhEd0hlbzF6ekVl
 S3A2clNGNXJPKy9YQ1dCMVVFYnkwagpMMWx3Z24vYlpUem0vVE9XZ0sxYmVWUWx1M2R0eGdXOUk
 zZG1DL1RXdTBnQU5Xa3Z6b2dlRHd0RW1NUjZidVlBCjZKSjlFdz09Cj1sMzBJCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/hvf/hvf.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ce62f8c97876e3fd948fad96df631f1b53db5e67..23e6de223e2ca63dc952e24889a9326d3bba3985 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -315,6 +315,7 @@ typedef struct ARMHostCPUFeatures {
     uint64_t features;
     uint64_t midr;
     uint32_t reset_sctlr;
+    uint32_t sme_vq_supported;
     const char *dtb_compatible;
 } ARMHostCPUFeatures;
 
@@ -1117,18 +1118,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
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
 
@@ -1144,6 +1145,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     ahcf->reset_sctlr |= 0x00800000;
 
+    ahcf->sme_vq_supported = hvf_arm_sme2_supported() ? hvf_arm_sme2_get_svl() : 0;
+
     /* Make sure we don't advertise AArch32 support for EL0/EL1 */
     if ((GET_IDREG(&host_isar, ID_AA64PFR0) & 0xff) != 0x11) {
         return false;
@@ -1195,6 +1198,7 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->env.features = arm_host_cpu_features.features;
     cpu->midr = arm_host_cpu_features.midr;
     cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
+    cpu->sme_vq.supported = arm_host_cpu_features.sme_vq_supported;
 }
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
@@ -1335,6 +1339,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
 

-- 
2.47.3


