Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7BEA811C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAP-0002Gd-J6; Tue, 10 Feb 2026 08:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAN-0002FN-Ce
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAK-0006OY-OQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so12865285e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731551; x=1771336351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GgDAOb9kz7PXxXREyH/qdM2DkTVepbIG5XlZE6jyCCk=;
 b=vUIuzON0vegThJgtJIReirLzbG6t7jrszieT2YbLribSD8lKITi4tlfCqLX9WPKX3S
 51AYX64xfsnQOaNk4D2LMrdC5J0MZqeIW1mNg88LPRXNOXtXl+RrmGLCZvQuSeNDOVd/
 4u894uPnaMqPtU/FXzM6SfeypSoGMsOVyMju4bmLZkkTM1upDQJ3YlB7nAcTLqWI15Aq
 HjxkmQ5S4RGU4yiVZAJCvkbLmqsB9kQlAIYuMTXMJvWdfKi81cGxMRa5kt/HOR5mLSgD
 +s+Fcnbs75u9Pnk4/UnVJkxLlEdKAlkGkdRc2NVf4RywibCSvcLQWPMBRQDc50cnHOKZ
 4fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731551; x=1771336351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GgDAOb9kz7PXxXREyH/qdM2DkTVepbIG5XlZE6jyCCk=;
 b=HYbSQO/T3BRhSXzaLdByAa71NCG8VpkfkKcziogg45uBCn3/PBDIc/cYt3tqDwsG5d
 hbK7B6GD+s5qRE0BWR1H32Z1Xh9aXmcbNAqJdJGKyuuklr2Or7Q2IFxSorp8gQG3sPdi
 fOFUUYR1nlcHkDkTztyy6yxTrx3AWad2GL01qAiukP8sn+WA9ZXOqxRR+3g04nxWumCv
 kO2T4GZzwqa9CEdfheC8juyUz4GmQCKjlf87CZrs4ST2SENoTdJXwGMtKFl/2n83FEoG
 Fu04Za37D9Y1C//VPY4LRbHobfD7JFGWGqBoz6C6+Fh+8/3Nj0mBxgd7OveHe3ch+2XF
 mVUg==
X-Gm-Message-State: AOJu0YyDg0I3AuwT7s/O2/Qreuh/wanQKorxxpk1Q54HmaqPoYj+B7vI
 cmVjrnfQhOLqXCZRuPX0pu3zGSFcidIa0TIiryBS7EtofftezymsPQU5in+/QItd3Tkj+D/musN
 LaYA2
X-Gm-Gg: AZuq6aJTU/dQ0EbTnPpkick8oiIl7K9/a+XxwkjS0oqp9OPuJwt5xKjm6c/6IHk597f
 dU8+mP2/PkM/7ebbPz7vLEihW9tOwjshBTpxXTBLKnU5ImQ/P5L6CmUx9Nb36XQmaxml+KrPPSJ
 bNmaVHbxa4QCdSNVZCQfUXNoctCcpWOi5Uqu5lq1u0I/LvkWiKpfKygL6m5egN/VqkChAzEuOe4
 cyG4szB3LpEGu29PTepjB4jJyEQWARQT8jFHGdxne4PdEJQk1m9pSE4WhZxshB6I6X5iZmbpW1e
 6XTqk/GTlQYBBQwOCE0gfVD2NAYUE+lacBf8VM4+rm4V/tFJIdngkw5+DUyTimGhKyq6jd+m8YG
 jmVPE2LxYvZI+TF8JfH43Gm0X6zYWRPuM9BYws/oKJjbz+K/uQo3K1+bumFJlLXQukkYnTalE0L
 vLLsg+Xj2pZaEMIJ95ucrvLNqDdTq/0ED+0uMnaNzVrss6C0Px6L0vKnG7RFlKefFU7BR/+YGWc
 JiVp4Vt1mJNheB5EYetDwbbWDrM0MQ=
X-Received: by 2002:a05:600c:3590:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-48320236b01mr234506765e9.30.1770731551153; 
 Tue, 10 Feb 2026 05:52:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] target/arm: implement FEAT_E2H0
Date: Tue, 10 Feb 2026 13:52:06 +0000
Message-ID: <20260210135206.229528-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
being programmable to switch between EL2 host mode and the
"traditional" nVHE EL2 mode. This implies at some point we might want
to model CPUs without FEAT_E2H0 which will always have EL2 host mode
enabled.

There are two values to represent no E2H0 systems of which 0b1110 will
make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit is
always valid.

Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260205210231.888199-1-alex.bennee@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     | 15 +++++++++++++++
 target/arm/helper.c           | 21 +++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e0d5f9886e..7787691853 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -54,6 +54,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_E2H0 (Programming of HCR_EL2.E2H)
 - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EL0 (Support for execution at EL0)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f7b1437340..49c50e850a 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -347,6 +347,7 @@ FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
 FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+FIELD(ID_AA64MMFR4, E2H0, 24, 4)
 
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
@@ -1376,6 +1377,20 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
 }
 
+/*
+ * Note the E2H0 ID fields is signed, increasingly negative as more
+ * isn't implemented.
+ */
+static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
+{
+    return FIELD_SEX64_IDREG(id, ID_AA64MMFR4, E2H0) >= 0;
+}
+
+static inline bool isar_feature_aa64_nv1_res0(const ARMISARegisters *id)
+{
+    return FIELD_SEX64_IDREG(id, ID_AA64MMFR4, E2H0) <= -2;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e86ceb130c..8c5769477c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3776,7 +3776,8 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     }
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-        if (cpu_isar_feature(aa64_vh, cpu)) {
+        if (cpu_isar_feature(aa64_vh, cpu) &&
+            cpu_isar_feature(aa64_e2h0, cpu)) {
             valid_mask |= HCR_E2H;
         }
         if (cpu_isar_feature(aa64_ras, cpu)) {
@@ -3801,7 +3802,10 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
             valid_mask |= HCR_GPF;
         }
         if (cpu_isar_feature(aa64_nv, cpu)) {
-            valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
+            valid_mask |= HCR_NV | HCR_AT;
+            if (!cpu_isar_feature(aa64_nv1_res0, cpu)) {
+                valid_mask |= HCR_NV1;
+            }
         }
         if (cpu_isar_feature(aa64_nv2, cpu)) {
             valid_mask |= HCR_NV2;
@@ -3817,10 +3821,15 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
-    /* RW is RAO/WI if EL1 is AArch64 only */
-    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
-        !cpu_isar_feature(aa64_aa32_el1, cpu)) {
-        value |= HCR_RW;
+    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        /* RW is RAO/WI if EL1 is AArch64 only */
+        if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
+            value |= HCR_RW;
+        }
+        /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requirement */
+        if (!cpu_isar_feature(aa64_e2h0, cpu)) {
+            value |= HCR_E2H;
+        }
     }
 
     /*
-- 
2.43.0


