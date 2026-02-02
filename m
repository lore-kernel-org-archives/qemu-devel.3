Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2099BE7316D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu49-0006qL-U3; Mon, 02 Feb 2026 08:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu47-0006o1-UC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:07 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu46-0002fU-BE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:07 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so42281505e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039245; x=1770644045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru5XJrKtZr7yAFEWv9O9zNrT2SKiQUCPS6FnhctwJEI=;
 b=KSMwjWhv5eeZse3GTzIuN5QeFp322rE8t3RMmdzB3xUt/W7Rge8kc81yUlNE1pOB0G
 Z5oPsT9EFcV4KJIf9Go/3rs+hxWahvE29Mu4aFM++DvckSTC3ncPAxDTo8qjEgVZhFOJ
 ytCgh0zj+b5uQB6d2HI/bq4efdftAZCF+AZiizFBLtkoFTkXYlbYc6/tdpqPgdnauPcG
 ii/zx9hVXK3f0/3dPg0lJtI5WBqfisV2ScUaTGdacBMey+g7oNn+ywRKUpdwYWq2dZ6u
 sEekDZF4z/rRM+WyAunYX7kjQ6YJiCVhMygyyNwILTa8rYWZ3hXFCnAHpBOZc/NKGPQ+
 +xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039245; x=1770644045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ru5XJrKtZr7yAFEWv9O9zNrT2SKiQUCPS6FnhctwJEI=;
 b=R/fhbvugUO5MxD0wI+RGytR1JuMe5grbdJBx7TrMKE+6ivZ9F8CF4WQDaxhYLfgAhk
 NYyb8Km4u7yRSqvsuQ9F7sFTVnv5SInlgx32kcwql7mgjDfTcfeM9VRIKaXesL3pOmh9
 I7CM0JYL9Uc6TeMqYM0U6iXAO7LHiNTBtCKCPkw76CvjIHl3LvZ6OjxAsIiocf4y0Sas
 Q1eFkDTbDs3W1sHV08FzGKg3gEm+7yRoGdMYzg+XacP2SYd2LyaJ+TJjpHZSvhXV+Oz9
 ku1ZwRBus0gu8b48gIrA6Jwu+4jDEEZPh/RoM2JjmrAah3v8ZA38BuQ0AfNu+6tFMMKB
 7TCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIPbRCT3L1r6FJBYmh5FUNaOv3EJUjRiKSYd8UKB2jbpkTuqn0oo7Wmc6QVRFmbk2mtlE1IkxN0Kpr@nongnu.org
X-Gm-Message-State: AOJu0Yxoc/anEfBODuAo6mrteDnqs741eZTUpS5bzBNgy+JBcXBPRGQl
 QKIcsQWcFqpXx32Sr0Ltg/fWqzXsNOmwrLA2e0k7jdp7EbyikkehnQ4uJ4ul8PxzSPc=
X-Gm-Gg: AZuq6aIsp7yA+aroy4bHLMN65jLhiA9pIIDh+ZmN/uUt/jwCEGPj5CHv3oeKtfTith4
 lpbzJR1vfnxtle5h/rD2E8XB62EnTcs1Z55MX9S3S7kO6AK1CA5+rDbIG5FKBhiNIyRsKN6Z8a3
 PmqZNGWJv+8BKwFtfAfTmdcVjhbYiHKd9xKapu/qw+OAP756FLoVNh79kAG55EOQV+rs2ZTAoXA
 96eHhgaJPChNLNHpynanBs/s6StY3VJUzi29Br3jkBPNXvUAuhXP7tTg4NZdiByNVHV0a4jUc7X
 4YaZ5U21rBlJJILacDVR0lZSTDyceqlUthwa0KToxiPYkcfo6U4IN5qK8Mn/7I5ps44XV8rM7pb
 2HIxMslsmJQ7m1LRmQhA0dTC3cilnnlkAqrARIoJtKvZZCkW/dI62dDFPfaLnATxIWZXfVkZq8S
 g+p0YljzqpNJCQqAeXBKrPHkmSPSbvfg==
X-Received: by 2002:a05:600c:1d0b:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-482db49414bmr146339695e9.1.1770039244897; 
 Mon, 02 Feb 2026 05:34:04 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 08/15] target/arm: Add aa64_sme_or_sve,
 aa64_sme_or_sve2 features
Date: Mon,  2 Feb 2026 13:33:46 +0000
Message-ID: <20260202133353.2231685-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

With FEAT_SME, even a CPU which does not implement FEAT_SVE is
allowed to execute the subset of SVE instructions which are permitted
in streaming SVE mode.  We correctly handle this when the emulated
CPU has both FEAT_SVE and FEAT_SME, because sve_access_check()
includes the logic for this, matching the pseudocode
CheckSVEEnabled().  However if the emulated CPU only implement
FEAT_SME, it will fail the initial dc_isar_feature(aa64_sve, s)
feature check, because this doesn't match the check in the
per-instruction decode pseudocode, which is typically:

 !IsFeatureImplemented(FEAT_SVE) && !IsFeatureImplemented(FEAT_SME)

Add a new aa64_sme_or_sve feature function that we can use
to update the relevant uses of aa64_sve, and similarly
aa64_sme_or_sve2 for where we need to check FEAT_SVE2 || FEAT_SME.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a7ca410dcb..40393d88f0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1507,6 +1507,16 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
+static inline bool isar_feature_aa64_sme_or_sve(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme(id) || isar_feature_aa64_sve(id);
+}
+
+static inline bool isar_feature_aa64_sme_or_sve2(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2(id);
+}
+
 static inline bool isar_feature_aa64_sme_or_sve2p1(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2p1(id);
-- 
2.43.0


