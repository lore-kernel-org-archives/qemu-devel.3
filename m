Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E3CCD18E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpM-0006LN-Uy; Fri, 10 Oct 2025 09:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpJ-0006K6-BC
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cor-0003sZ-3Z
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so1429204f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101555; x=1760706355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lxhn2hVQLgClGRWrodtHBnz1RoXtS5LamITBr0kvSJc=;
 b=uXfO8pLJDj3h1l9JeKm4Aaje1Cx8NoWeZj/tE/7fLkZy1hA0gUEQKMtq9DeqSk7k9W
 dr/hgIxQvX3LPwXRfZHN1w8iwSpYROl98ZwxAlCdp+JufiEbfQSygMEUq5IZT4l+K6/N
 xqkzP/ILmyOahp7Hv6f01A1yDjANvKXIcOV14j9uWzqQpJg32wsvTGZqHBaZ/vOPjMuU
 Afh80nq0ksbzBgxpWcmEDBwNXgb3RFQKT0zLYFqIITPzZ2BVnBxL256vs5nGAg1X1A6k
 h0HlJdqUh9bE9/jVQsj6gaITYSeRlTSWs3pi6KNpnZoViiw4jGJ6yPxoeytZZIyzCRE0
 yIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101555; x=1760706355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxhn2hVQLgClGRWrodtHBnz1RoXtS5LamITBr0kvSJc=;
 b=m8LtPAG1X6RriOtxifgywfH4k9cOgIcnT0jd6JZLzOFrIlrWiGORId9YaVrJyZOlFd
 gi23mZoBoo0j9yWuAMu08wab94Nsj0jG34e4wmwnDgZ7kwWQCxV6lcDUTJ/LLPsAf4XI
 6ZR4fB46ge308oWsjMyORpMj5Jiz0SvcCO6MatmMrYkXWYfcMD+tyAUC4V2ZEhqIDJOa
 OHJ4oOwGpx0VHKcFXX1iIrsw8aN4DELNZvY6knt+4fa7smqRi36VRluJ1n2hqPO61HGN
 mdmi5OtmdB/I4JoiyA6MXRX9ng3+2qspLJuH9ghFoRGvSAv3iGRXy8K9AYEZdayJqkA7
 hp4g==
X-Gm-Message-State: AOJu0YyvSA9XseYI1s4AyJYAfwVWNiR4XG0rQhSKt+IQ/GOjjlup4fsF
 23H3+rnImyReFt5LAlKkj+Zcla4VmhkZHWe21cok7+ziw1ztTtNDmB+D+vDQF+gQfvipOt3Eah1
 hb5r8
X-Gm-Gg: ASbGncuYYvUa/DIc/Ci2flvThCrtFmEL29eRn5jAP9S1QyohiP7TQ7iy3qQPXUvyiq3
 Kn7FujBZPLEEidqWL27mPDBr4WwLP4LPGNRYCuYABhoyafEo23ppgjA1HHJzonHcp7CYYYEiEX8
 6xHsCcBVCZuJDm27JGi/4Xem1y21UVnw36y03bgQ2TC0f2pILrSi/cPA5gJhjo2wqLPYcnYsh2J
 4VLglfnzSy1KQC4ocMFjamoByP/cwgNoN/dqfV0SsiemMhERxCBh16VSIfNvOy/4D2BB/7jQMaV
 0sKA+q0/VJ/n54Qel5nt2I1hQvTpxoRPy4qBk+DKWbwav/GCbBDMUWfdFR7JyJHNCV4EC2vrlpx
 WEB8NFlDiivMYc/8YJb1G/eKzIqBvaYumTkM7Guala/cbUTdn5ioAnXJ58NpJcQ==
X-Google-Smtp-Source: AGHT+IEP6fwpuZDsHhrqbKLuD55cQlDT6Fy9bw1G6khYi1BCiBciaPiLWSqwKXnyWxdHiXK4U+k5qw==
X-Received: by 2002:a05:6000:4212:b0:406:87ba:99a3 with SMTP id
 ffacd0b85a97d-4266e8d8a8bmr6283442f8f.30.1760101555420; 
 Fri, 10 Oct 2025 06:05:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/76] target/arm: Convert regime_is_pan from switch to table
Date: Fri, 10 Oct 2025 14:04:33 +0100
Message-ID: <20251010130527.3921602-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h       | 13 -------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  9 +++++----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index cb2ffeff59c..819ada7a5dd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,19 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_E30_3_PAN:
-        return true;
-    default:
-        return false;
-    }
-}
-
 static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
 {
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index f03a2ab94c2..41baf1a003c 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -16,6 +16,7 @@ FIELD(MMUIDXINFO, ELVALID, 2, 1)
 FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
+FIELD(MMUIDXINFO, PAN, 7, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -56,4 +57,11 @@ static inline bool regime_has_2_ranges(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, 2RANGES);
 }
 
+/* Return true if Privileged Access Never is enabled for this mmu index. */
+static inline bool regime_is_pan(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, PAN);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index f880d216067..98db02b8e54 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -10,6 +10,7 @@
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
 #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 #define R2     R_MMUIDXINFO_2RANGES_MASK
+#define PAN    R_MMUIDXINFO_PAN_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -17,24 +18,24 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
      */
     [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2,
     [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2,
-    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2,
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2 | PAN,
 
     [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2,
     [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2,
-    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2,
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2 | PAN,
 
     [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
     [ARMMMUIdx_E3]              = EL(3) | REL(3),
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
-    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3),
+    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
 
     /*
      * M-profile.
-- 
2.43.0


