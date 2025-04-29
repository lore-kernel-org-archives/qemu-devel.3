Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790FFC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kvb-0005LF-8a; Tue, 29 Apr 2025 09:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kuj-00056e-Ca
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kud-0005en-DO
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so3072579f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745932927; x=1746537727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjSG1O4sqyvihfU4YBjpfGe20pFEFSZo62gLO5k4z4k=;
 b=SzhdpLNC6SAe0ElUdfmQ95kcWMsf8FDCdDMn49VDIgUimOAHm8ZlBLba4lrwgaza/H
 Zsips9aPT25RyZfcN/WrNE9tXeh5SEMmzWfoclzehm2SzcIadUe0s9b6t/EYuI2HFqJx
 FbN17u71Pa1YF30QmKVKablDASzB24wTAuA6z+pvg6t4EFoxk/Gi4jYLXAfONkUubDo4
 FK4BO7HmcksA2tEvqIeYCeHLr5xcO7o/lre/yiiqFR6eoVlrRTT0ruIVXW3UFbIXekfo
 wk0Nc6aDTSCOXHc7r6i2DAVm+AA580bxhScrN7ol2SNP2yWhavaB7XyvKU0EAy8GGCrV
 uTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932927; x=1746537727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjSG1O4sqyvihfU4YBjpfGe20pFEFSZo62gLO5k4z4k=;
 b=Smig3Z6egvSvi7V7hmmiLunb37nr8f6wKNzflt43+ofHlgZ9SQsBBJ9710Z2H9ng1L
 SxxLPUJmBKy6IRZmoOmORSVlJ7NOxZGfBdkn0x1mgxPhpd2tkcBitOVAoloYpm5EiQy+
 +TEjqZCQD8zRpJc1kVJjcZk2HaDtvQrnWSOW9hervM0p16fUfuAINKB5KJ8GujzjLOS+
 AuFYftKTRILFvr5VWJRNucOO6ogHwsvu8AVtqMyRwEWbAs0Gma0GlDzmHBpvYkEceH27
 dQzqWSdQp0alPmZ+vHKcadFWAV7OTKqQZyuY64Myhw4WvzYuVkeqyFA2RMp32Oe8v4uY
 36uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXIItWbZN6dYv0oX6PY6RhhN3KjMEcS/ihS7Y/WCoJd7S8NRiGncHtQASpbb0sBgT1rtkk1LR63eZ3@nongnu.org
X-Gm-Message-State: AOJu0YzYSoJmqCMTKGEqqL01XIq3pTBx9JdJyTn33F3npTc7KvL+Frqp
 rpNpGylJF0XSC7gsfIX656b8WFzCTE8pypSwVD17VkeYbeQdOouC2g5TgYjG8TwGoPwP8zpG0CN
 d
X-Gm-Gg: ASbGncvy0UcBPbbcc63YtPF+mjARqj4/7Vo6a9le1gydFm8sM8jzGXZh0ScmlK1okUZ
 uvK3Z+6wCXiKoaO1csEw6rmJTom7cWJv8kS67UxOt49XOA2CH7rJ2wRwt5SP0Zpx7VTMzukgp/l
 paCJon3ApIg/rEPc+oqT3LwN8+jP/3eXzPESh2cK09WxmS2dVsjfi1hisOJCDpvQHQH6hKVyslp
 vpuZbg64D5/GM0ELBWYTku+Y9BlVH3qrI9OF8g9HfmTSRb64MMUcRXU/+M9VeXmbTrlojR2aVA6
 AsR3Cxztc1R45jadhJVH9au2/P5/q9hhabQAU+kNge7YU8a0aORb6Fyd9A==
X-Google-Smtp-Source: AGHT+IHUqSXUoZjCPqu+mXZN8fT//UMxUYpYLWKP+euiVEBY5su0iLgY6sEzdYbwjQlJ7z6rVEFmIQ==
X-Received: by 2002:adf:efd0:0:b0:39c:1159:fe1f with SMTP id
 ffacd0b85a97d-3a0891ac019mr2454018f8f.32.1745932927612; 
 Tue, 29 Apr 2025 06:22:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm13729371f8f.27.2025.04.29.06.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 5/7] target/arm: Move aarch64 CPU property code to
 TYPE_ARM_CPU
Date: Tue, 29 Apr 2025 14:21:58 +0100
Message-ID: <20250429132200.605611-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132200.605611-1-peter.maydell@linaro.org>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The only thing we have left in the TYPE_AARCH64_CPU class that makes
it different to TYPE_ARM_CPU is that we register the handling of the
"aarch64" property there.

Move the handling of this property to the base class, where we make
it a property of the object rather than of the class, and add it
to the CPU if it has the ARM_FEATURE_AARCH64 property present at
init.  This is in line with how we handle other Arm CPU properties,
and should not change which CPUs it's visible for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c   | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c | 33 ---------------------------------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5e951675c60..73a2a197667 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1610,6 +1610,35 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     cpu->has_pmu = value;
 }
 
+static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
+}
+
+static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    /*
+     * At this time, this property is only allowed if KVM is enabled.  This
+     * restriction allows us to avoid fixing up functionality that assumes a
+     * uniform execution state like do_interrupt.
+     */
+    if (value == false) {
+        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
+            error_setg(errp, "'aarch64' feature cannot be disabled "
+                             "unless KVM is enabled and 32-bit EL1 "
+                             "is supported");
+            return;
+        }
+        unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    } else {
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    }
+}
+
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
     /*
@@ -1737,6 +1766,13 @@ void arm_cpu_post_init(Object *obj)
      */
     arm_cpu_propagate_feature_implications(cpu);
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        object_property_add_bool(obj, "aarch64", aarch64_cpu_get_aarch64,
+                                       aarch64_cpu_set_aarch64);
+        object_property_set_description(obj, "aarch64",
+                                        "Set on/off to enable/disable aarch64 "
+                                        "execution state ");
+    }
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 00629a5d1d1..e527465a3ca 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -781,45 +781,12 @@ static const ARMCPUInfo aarch64_cpus[] = {
 #endif
 };
 
-static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
-}
-
-static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    /* At this time, this property is only allowed if KVM is enabled.  This
-     * restriction allows us to avoid fixing up functionality that assumes a
-     * uniform execution state like do_interrupt.
-     */
-    if (value == false) {
-        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
-            error_setg(errp, "'aarch64' feature cannot be disabled "
-                             "unless KVM is enabled and 32-bit EL1 "
-                             "is supported");
-            return;
-        }
-        unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    } else {
-        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    }
-}
-
 static void aarch64_cpu_finalizefn(Object *obj)
 {
 }
 
 static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
 {
-    object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
-                                   aarch64_cpu_set_aarch64);
-    object_class_property_set_description(oc, "aarch64",
-                                          "Set on/off to enable/disable aarch64 "
-                                          "execution state ");
 }
 
 static void aarch64_cpu_instance_init(Object *obj)
-- 
2.43.0


