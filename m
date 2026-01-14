Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307A3D31A28
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwLs-000080-Le; Wed, 14 Jan 2026 03:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfwLf-0008VN-W5
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:35:28 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfwLd-0000WD-Pw
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:35:27 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432da746749so2542286f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768379724; x=1768984524; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1F8dCjujQUOds7Tjuv0RkAfG1TY3N3l+JRmSQjFDw0k=;
 b=p+bFBDApr7u9l3hmO8ERYGDXvvmngQVBlN3WTpmIEGLy78/d2D3/6at6raRSZC7n4e
 2eFstZxoZFkJJhuR0UYG5Ue8MFqe0VkM6Aa0qkWpcwr+NRbbzQ4wfF02ac7JbE23oMmT
 hqz3R5mYi0Hut6g49mkoRa1azOM4GZcrYfhzJz7m8Fd0aqgTSiPReUpZEWljzlc4X+2v
 iQOH/L3lq8h6tyCQIFPxTuIM0V4EFRM2NKQ0zvavf1VXOyL6zi8frdQAl8ka+HDUXu8S
 71fQApW0LBmQPmskCz6PfiwuZFLKEcmb1iQldbd2y6HbkpEmmjdVK/1ir0ylxDnHQGB9
 GF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379724; x=1768984524;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1F8dCjujQUOds7Tjuv0RkAfG1TY3N3l+JRmSQjFDw0k=;
 b=IH7QmADvSMGhPL0gSNcOE6oltM0s1FfyCm4Y7EpbplqHxcuifRGQSrgDiALwG8vt6V
 EoA/L8Ee9v588kglygRGueYAQG8bryVtncKTnz89OWe4X+PVIDhAcv4lCQR6g2LSHA02
 sQbTesA3Vu0c2XoEw+GvkllgsjlZ56qNsCOUwf73cWee5BDV5hGtuqHaYp6lwt49Z78W
 673rmU5s75KVwLdgBbIqZZYa6zCMG8ck/Qz27yscJch82gxPhqc9JW7jjowkFEk8IfRO
 dBCGMa+YgB0jSGIOV/QT+McrZEqM1w+0ndEHJZEAFt/pVbY+e7lC2pHzluVz/BLNSGy+
 peeg==
X-Gm-Message-State: AOJu0Yxll70Yzo6scpREskeISqOYf+ldUo3FtWjHCuOGYZUgsl2owbUd
 LJlvRzCHamzbMwl+Bo/34Qp2kCWGuvqdUZYcW2SYd0COPTvc6o5I7YdaLKTMVbAPZgA=
X-Gm-Gg: AY/fxX5SB5m5AK+BWFCQars8N+SOx9yMeuBTk1Qg9tWI+gs9gfBcgrOQOzLL61nlt3/
 DQyxN546kuTEjcwwC3YfxjGMHNrtqPWtMO5W4xLjYB4SjfhuPnDy3xB44pvVZ2oyKCYbGuaNfy3
 oKpBNC5UtxR0Sq8F3NGoXUkKkZpPDYnnKskZ8BznlDqX8MiW3QVcbgqzAG120GKVscolBli+VyR
 tvBwHtI1G+mq4m13daHKI0ZWfFQOOQNW+OOKMpa8C19l7ZJpEmextLdrroChyKiZ5jhv1fZy2NU
 +lPm7o9RoLCZYD/QSnW60B/p2JJ4HT6ZzlbP4bWw2RJfXIC0jGhS3DScXYRiVIrqk2Cg9VCVvqT
 bNY9pk/VuPQJbX99oK9L3R3NaqH9VREjpeCN2M/XodvhJzbNUUBa6JpG2eFb0I9Bl0jT8JAchty
 oaLeeLepLNWCCDaBFu483YMOwKxGPsVeTs6rUUmkeKF4rSArd4nmqTyflLU4Zm0cr4MYr3pisa/
 YYqL68A080GMR6CPkBvFb92HTtGdBnrjOM=
X-Received: by 2002:a05:6000:1acf:b0:432:c17c:3076 with SMTP id
 ffacd0b85a97d-4342c4ff132mr1841473f8f.14.1768379724282; 
 Wed, 14 Jan 2026 00:35:24 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-214-23.home.otenet.gr. [2.86.214.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm50121053f8f.22.2026.01.14.00.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:35:23 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 14 Jan 2026 10:35:04 +0200
Subject: [PATCH 2/2] hvf/arm: expose FEAT_SME2 to guest if available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-sme2-hvf-v1-2-ce9599596736@linaro.org>
References: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
In-Reply-To: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3766;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=+Ifjo7l7CBODQ3juYZTHP5EYl1Mvfgv3FFkePf3tySo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBaMVZJaTM0M0FxRzl4YTNrSHlnd0RqbXBHZ3ZPCm1TMEZkc3lIeGpiMWNFcGVt
 M3FKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVdkVlNBQUt
 DUkIzS2Nkd2YzNEowTktaRC80OGc4aUdPUy85VlZUTXlwYk1NaDVhd0hYQXJlRWlUS1ZDb0lRSA
 pEdW1DVCtyOGdhdjlFZklmMStiY2czdmd5MXF2dlBkRXlXV2l0WmkvNU95NXhrWVBQVEtOUEdKe
 TVBQkVWb0VqCmtDVlJPelZqMTlpRUNLdzZuZzJHRklUWmFFWTY3bnAvOG54cWdVblNiWHZNWjUy
 WG5WTS9Ud0tLM0FYWC9DcXQKK3dhRnh2RzkxY0RoZlZLbExybnhOeTlLTHIrem4yWFF4K3RMN3F
 tZ1dYeTY0T2xSRkFSdmRmVUg3bUprVDVwMgorRDFxY0xFbXhUR2FuRkxQZDNvZ25VNHQ2R0FwQk
 lxQWU2WWhoRkJDOXVVQTlPRzZITFB1M1kwV1MveWpIK2c1CmxINTBlTFczK0J5YzZkTEE1YWhFY
 mQwMjhsMExoNmJDS2t2RjFqYzB6Q3gxTUVGUkdTeU5HYlRCeW1xbGxvUkoKYitjRmVscUNEU3kx
 aFVTYzRLS0VoYXhhd0VRejIyVmVIYnNuZzZ2U2dGN2Fxa21hTmpHdm1VOEhwY3hPMVlzNQp0cEs
 ra3d6L0dPOUVmbktydXBNR3QvaGE0WWZqa0d2cFo0dGVXZ3V6Wk9SSWlhQ0NuaDgwbDRFdmpzZn
 N0Zjg1CkFpWHhYaXcvd0ZWRmV6eEQ2YVZTSkN3MVhsYndXWEZZZE5HejN5cHUrRnhqMUlhWEkva
 0ozOHE1NVlvN2RGQjkKNEIyZ3RKSEk5WDNrV1lNMlRvaDBkM291K3Bjc3F6cGRDcHlqRXBpU3R6
 clRLdEdlaXhsTmwxdHBWRE1UNWpjMwpCR3RpcnlaeEJMenYweEFwMGxwSm9GMzhDeTFvRUNzaVd
 GZ0NIWmN3ZUhWK1RlRzlPRW5ENVdqbmloblZnQnNWCm00SVRxUT09Cj1JNVNDCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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
index 42547b175c30c01c2b7e060dcc01d1e11efb0d1b..b51eb9bb6a1b416af3b2cbac1aac81457c2b4cb2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1051,18 +1051,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
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
 
@@ -1260,6 +1260,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
 

-- 
2.47.3


