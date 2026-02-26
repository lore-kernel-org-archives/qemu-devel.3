Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E81AFC5907
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVlB-0004oS-1U; Thu, 26 Feb 2026 02:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvVl9-0004nY-B9
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:26:07 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvVl7-0000eL-JB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:26:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4398ebdf520so1040064f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 23:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772090764; x=1772695564; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6cZQbmq6xeaLftKc/FQMET4SNtIjddGSeHeG2nCdrDQ=;
 b=c55KZLzsoKhkvP3fkjgJzJOOhPGnXKd9vRHfpth5jXGasZFpu7kWJA1sP9KnQFwRVq
 3wRZyoyH/5a1bfc8csZ/9xgQKd0Kr/ylX0yrzX95nDD0zIccPxNidWFRf5c9dqbCFodu
 B28udpMWi8NZZE2/ztghJWoCBz2CPEXiuikdpUWTxEuZ3gct+ibG+SFKR1yWUzFwU+Cn
 U4XwZEGtCCXok2aV0vpWp3xFN7xEawKVCJpcFwIvaq+rsS3ZiVJRmktKZiH97R5RsfzQ
 lPrrgBGhuu7jpsVKQkooqKwnCPuw6/lG7rIqKBBnfLzs9k+tlItCNis3hc2Yi1L48S1k
 yZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772090764; x=1772695564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6cZQbmq6xeaLftKc/FQMET4SNtIjddGSeHeG2nCdrDQ=;
 b=xQoskNFIUy20BR+YlAnqJYJ8bbJ4f/7Gl85PnDNSJAA3k7PZ6C1/1pBE73b65o5OEe
 KcT8239zERojDbr/Slz+2lbTvY+ReCb/3lRcaFx3jEFlyn3pyNMe4Q78gxQFQSQLRVfs
 OWQ2BsyQn3sMO0Bm1ABEM7Z7He7HzaR5AwpKPVeNWtumMo87IPHakbV9v3F/JliyR5fA
 DNOScfZTg2cZ6xSZ9OfHY3Pn036AKR3cW+cJ4EXsr2gxrBOfQSZ4FYOlaiaeZSzthvfz
 cgEbHNaYW8skEqX2tYb4VQktMDDvNSaYr5op2cy8YE6jcREhiV6G7+GMw0nJn63C9HJz
 f/0g==
X-Gm-Message-State: AOJu0Yz9Sc1MYkBb8TZTNg5GXaBftsfT1C/d0sqtmqTCZF28gqMkLu4B
 QHXhp1Dk/VgdPTrCypJFYAli6oyX4r+fEyDmfCV6FQsT2uukBsOZDLV76lqAR3zNsTk=
X-Gm-Gg: ATEYQzz+yp2gte013qZem9wbrj+MqRATosDHIlXtIC2L8QX3httk9oRtmCvN052Kkaz
 vf8DcoLN6YeG5J3hq5wKjQikHyCJPXY8QPG4Hq3Gr5u/g+sylgNPqBVF2JQfRzg8oOrsKeW1jLT
 e729QeQCjY3b3f+zO/WXvOngjZiM/YemkNLFtCSDdGf/jYGNF5ko/KHoBXXKulLhQVrA9AOo48R
 4r3FLAIoCwcyBPJ41vBkAgEVgj16kiwPN+nBdULof7/LIeg1KaGxczkMYx4QU6uvlSYUdxBT8Zi
 P+RjkG6YOZlNPKoL8NVk3CDgBMMeLVBt2X0apSNv7N0kOANcTZg+aSAQrwqNvyi5mA9JHN1EBAm
 IjBz1EuQoPIGbjF96811NTaH5uU0MGMuSlpw9XuRWXcl/hq8PbSwub47WvdC9m/UBISiqPu2Mdl
 3yUjcZHUEMEB0nsKwHsMoturRDLO03a+ZK8lXXICcUidAa4viaYTqUckVulubYQvB4dBaiU/Q0+
 9KM6scnXL1qJTOCnQXw0COppIxEjhK41A2V8kw=
X-Received: by 2002:a05:600c:540f:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-483c33e04c4mr27901955e9.17.1772090764019; 
 Wed, 25 Feb 2026 23:26:04 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c35910f1sm26281405e9.2.2026.02.25.23.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 23:26:03 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 26 Feb 2026 09:25:54 +0200
Subject: [PATCH v3 2/2] hvf/arm: expose FEAT_SME2 to guest if available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-sme2-hvf-v3-2-ea5763dbeba2@linaro.org>
References: <20260226-sme2-hvf-v3-0-ea5763dbeba2@linaro.org>
In-Reply-To: <20260226-sme2-hvf-v3-0-ea5763dbeba2@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3050;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=yynwLuMlI65jA+CnILLyvUd1k8YKp9KEyPdyWSME5oQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBuL1dJcG40dkZ5ZmtTSGJ1RFBza2h3aWszbytsClM5TmlrbnJLc3RWeXQzM2pm
 bk9KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVovMWlBQUt
 DUkIzS2Nkd2YzNEowQlQvRC85WUdtSVYyUUNEcVVOZEtjdFNiZ1RIcUEzTklPYzljV2VRT2Y1dQ
 pvaXdFTVFUdTU2anFIamxuVzIwMy91QWxJK0l5YXNNTm14bWJzMkQ0NllYeHExelYrS0ZjQWxLN
 C9RU3ZveXpECnp4enQ3M3JDM0c5UFlmcE1ub05xL3VUN0V0eFJlekxJU0thcjA0YzQ2eEVKcWJ0
 SjdoOHZTQ0xHOTZMazIrTSsKU09IekZnWFNNUExrc2tORS9sMGkyUUFOSnZXeWF0MFhVb1pEUG1
 HR1BSU05pdnVBQkNvUDB1dWExd3N5NW90SAphaFAzdXZUY2tkU1R0eVJ1OENjMVQrUzhsdlFKYm
 tla3prdmFDQmhkMS9aVWExZkpIeHlEb3dvcS8ydVczazFqCjEwSlBxYlNKRVhObkVtTmJyWjdKN
 VJZT1RvQmxKc2NJZTBlMUY1VElrMWN4VWdjL1dVMjdjWTBFSENtNVp6WDUKNXUwUWxPZ1NhK3M3
 UXBZZnVYMEdmMncxd3hUMFFXRmdmOWNRWmVVaFRZWDhzbEdhSlhCKyt1OVlHTHNqV3RFZApPTHh
 JaFgvSG90M0tFYmZFdmk3eEZublFLYUQwU05OZmtvNG5QSVd6NDBabzhUNTc0WEN6dkVWUkJPYz
 NSTTVhCm5Ea3I0by9MenJtWUhTbk15T0c2dDZmMDRTQVRzRFh6NVZvOUx1aWw1cFNKUmdnaVloY
 WVZQ0pJRCtqVzZqcFkKVUY4NEpRQVRraTBtcm5jR3g4WGdUL2MzUC9HY1FsM2J0eWJHOEFSUERY
 RDN6M2xpRkdnNFZOTUdQci83WVVleQoybExMenlRS29CcWx5ajZ1TnNmbXF5bHNYK0VRWlVoSGF
 RaVBoQUc3akMzVjduSXpYcU9ZUW5KemdGdi9rUVQyClRYQzhlUT09Cj1HTThNCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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
 target/arm/cpu64.c   | 13 ++++++++++++-
 target/arm/hvf/hvf.c | 25 +++++++++++++------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dec430c48b92a8bf6bb8a9d247c23d5e7edb9c2b..c9991881f2e6cc39c9f3884efafae11bd210ed61 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -340,9 +340,20 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
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
index 7d80c8b30aeedde8b81ac8fafc70f61532141dad..58c817e4965e8cbeb55734fd101c290a51be6bda 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1141,18 +1141,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
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
 
@@ -1359,6 +1359,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
     assert_hvf_ok(ret);
 
+    aarch64_add_sme_properties(OBJECT(cpu));
     return 0;
 }
 

-- 
2.47.3


