Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77460A2635
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hjBeh/zf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDt-0004zK-DH; Mon, 02 Nov 2026 08:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCz-0003Cn-Go
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:21 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCx-0002I7-Tr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:21 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1266688f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626578; x=1794231378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4kwwaqJxjuVwg1OFAjh08fpY/P+95fDa3sgZEYeQYWo=;
 b=hjBeh/zf4mmZ7svkfM333YVf4NXaQka0FouYLF00UDCqKOpJqfy0l4WKVj0Cmb2vvO
 V4Hmcehmpe+P6tWzTwkitNjFuQ6CLLptHKWDE0N1wkcpXOSVF2PWUhF32UTeHUtTBsfi
 PjK9zs3XJxZVGEAD1J85xJJwCQZowrY1/N+IDKY8T6cnR/Dws0IhISv2+CxgToSf8DEI
 yuwyH4K5zn8dOW21Cjrti4hVYoXthcqXSPA5tpDlqvUvQ+StRPVD2HZ0Q7nNMkYsZ1K1
 hJec7g46j6bkb83rS19gDglsTLA3C4n8FGOSHaW5ys3Zgm2IID8LS/E2kox03l7G1L/6
 JTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626578; x=1794231378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4kwwaqJxjuVwg1OFAjh08fpY/P+95fDa3sgZEYeQYWo=;
 b=mOAntMIYduFLXJr+jtsvWrWZuQdP04Qi5GNEtMcWELG8vlo8/iacgRwwb3KqYJ6E7S
 TG0n8MCufBTdtihE9i1HFBZgXxhdwTPgASHB2Oxpt5tIfmJ3JnlIvrQTQxvvybSNd534
 8UlTJ0QyAROrSbjyyNZOZp50LIMDqYSoUUHsER4zBC4HKbU7bmhoQVssmlMpo5WeVEF9
 OYqEamKmM9rOUoOGPyqUn7aXbdwcfJNLhkUvFRfPZP3nQnZ7ZdDyHo5NHncDBMmewXPw
 IEmgZLPaJdUzLW5u87BgOnU+jkfDTGq+zyxyemvqvv859mh1WAapv51EDqt9/NAarEF3
 sX+g==
X-Gm-Message-State: APuU4Z+3DAj7E6M+sdy0cHhokfoL6peYdGL5f3+cOclj0ySSM7bHkRW4
 Ukj6OthyxsPj3xTQenff2vrm6yGPmhkOBKsc61SFPo5FudywSktIgXrjFMJLiZq0TENBS5DcTnB
 JvaiLrpA=
X-Gm-Gg: AYBFou2VDVHngT0nzHF1qVtFpzcwEp+mnZuq27/U/uIQ/65E95atWlzADHnSj4tNqAW
 /nv8UU6qy9AlkbGtIIK0TG9dGS9J08yqrlTyTP5UeYOKbuQhg8aUjJB078RhBVmnx6z18S5U4YX
 BYPIYZRRA5MfiFukrQaWjc7/00uDIljI1tzAUw+9utBjRBumIKzwzAOAHtN1ruUlaknPpgs2NCZ
 FIKeUI1eK/vv0Uzf3u8yD6UxGU+aX2jvhU3HBhkAMpKZbYIWYqNSCd6mRSYuFA8oRBTTtcQ+CQD
 wNoqc8bhwobNa24b9o9v70OYoPl2fdjPH86VdK2N97oHHEJbwxQ3FePtfRqb2Hzr6FFbd+AgMI7
 zX+DcRrClNKORoZBhUHOmEMuzHclTTUqHvlA3pN04VXrX9i6SA6kCiD5aJhg7Szx1EltsGbJBGz
 SJRYI3+CLVXn2vdu15gmRC0zzQFISggjGSHF6Uq+2zh3kUNRc1WH2RfqKy9XvsOmlfISE5uOFFO
 pvI7zEhJisjqkxmQrzLwiMr4jYPmO084FOpWaQrCbHWFYYC+rHy1gMQ8Z3a/0fjVKg+3dnjVQO6
 z7vBvjz8E7dnhsKlrM7xeNLTMHZDlmfRRU1A6I19LgN86XJG54Iy0lhI9lnlvjwfMm8+UhKpphr
 FJoZmYTHeTXbD/VLDuMblopLd0AbUxUb1hg==
X-Received: by 2002:a05:6000:144f:b0:48d:de0f:b79 with SMTP id
 ffacd0b85a97d-48e6e264067mr26275725f8f.0.1793626578322; 
 Mon, 02 Nov 2026 05:36:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/47] hvf: arm: fetch more features
Date: Mon,  2 Nov 2026 13:35:25 +0000
Message-ID: <20261102133547.1375701-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohamed Mediouni <mohamed@unpredictable.fr>

macOS 27.0 has some more feature registers available. Fetch them (but not using the values yet).

Also fetch DCZID_EL0 at the same time.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027120135.53048-5-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index acbc257091f..e1ddfe14c7a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1142,16 +1142,14 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     } regs[] = {
         { HV_FEATURE_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_IDX },
-        /* Add ID_AA64PFR2_EL1 here when HVF supports it */
         { HV_FEATURE_REG_ID_AA64DFR0_EL1, ID_AA64DFR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64DFR1_EL1, ID_AA64DFR1_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
-        /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
         { HV_FEATURE_REG_ID_AA64MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
         { HV_FEATURE_REG_ID_AA64MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
-        /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
+        { HV_FEATURE_REG_DCZID_EL0, DCZID_EL0_IDX},
     };
     hv_return_t r = HV_SUCCESS;
     hv_vcpu_config_t config = hv_vcpu_config_create();
@@ -1191,6 +1189,22 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         }
     }
 
+    if (__builtin_available(macOS 27.0, *)) {
+        static const struct isar_regs {
+            hv_feature_reg_t reg;
+            ARMIDRegisterIdx index;
+        } new_regs[] = {
+        { HV_FEATURE_REG_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64MMFR3_EL1, ID_AA64MMFR3_EL1_IDX },
+        { HV_FEATURE_REG_ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_IDX },
+        };
+        for (i = 0; i < ARRAY_SIZE(new_regs); i++) {
+            r |= hv_vcpu_config_get_feature_reg(config, new_regs[i].reg,
+                                            &host_isar.idregs[new_regs[i].index]);
+        }
+    }
+
     os_release(config);
 
     /*
-- 
2.43.0


