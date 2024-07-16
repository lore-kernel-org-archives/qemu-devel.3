Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1E6C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThdy-0002io-P5; Tue, 16 Jul 2024 08:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdv-0002fm-Qh
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThdu-0004tQ-3F
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:50:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fbc3a9d23bso38729145ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721134252; x=1721739052;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JQOKrG52Y2enmmfF+L80VMku0KsDSGPKvaWKbQs8/U8=;
 b=m2yrH7AToaaQYMk4fmqkPFq51mJZG4TbSXdbUnpVZWxlY5zPP6+YkQDwyaTOnbl6mJ
 Opdp+BBEuvkHivyh3fDlotFK72DvTwpbxfataVrQQH7K7cNB4A/fOu9lqHAwQGkfpIW2
 /Tld4BsOgtPB81djnErmb1Gt9OOqEFQwpFW4hKjcbjTydv+uSH3h8B2VpNvICPmfBQRf
 eDcIs/2z/EJjlaDy8qFiczbZXhEEDrQLCLI4gjsZc5PdYaaM/MWHN7MreFXj1OQ2/b6h
 IZcVpYo5edovVSKNo/g0wZc6Hs9xt1ObZ+sIGmEtnruOZBMP8vmeRni+xc5GQ0L99ouL
 Zs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134252; x=1721739052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQOKrG52Y2enmmfF+L80VMku0KsDSGPKvaWKbQs8/U8=;
 b=eFAovTuzR/CFm1/2l375ZkNmi3c14+U/i7NeS+H6PQELM0poGDMwNieCOfz/anw+AU
 cu0RHejQ1WGlh41R1Cc0OXjcLV2MRl4gbuMIipNhiBLZ+Tq0KMgU26fFL/pDwStfZqD8
 QNlyZTMl3qNUgSxkMIyJoW8HHB+wyxrY7gUFc1oNI6tCH1fZaUBh4+gkZOF6TioEO3Jz
 8nSFNCWEAEsAMPa3T2XUIfoAFO71zQB5Z04mxIPrDVt+p+e5jOeXIGH9Kdm4YWZP+LLg
 BXbm7uikyS13Iqv4DfqjMnsWsSekDdzeenxtKTNcdNNAC6duHWexUgcB41YNcVHQeWPc
 JTqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxNVS+Y6T6xffxjuQdzsLMERoacSYt0DGJDXKmjRxGGoS51tIUl/Dmpx7JU3Wp7JCp/Q3m4W5mdrxf/DepeLbEbeDr1sw=
X-Gm-Message-State: AOJu0Yw4fYe6fH2LR1aYW/UFXfGqVGlWSkoIaT4c1ZI0Gk3dU9poTVAE
 mEOXmOKG00nH8tyH3IEQZa5tSsCrms9pnOybk3jWmfHA66CV5hF+ECKaCOoZQlU=
X-Google-Smtp-Source: AGHT+IEMWtqXVNzll+cDTZQ2V/r1p60YjN5JuNoyF806T14A3/IAKFSdJwa9M9vuTjedOixfKkqgIg==
X-Received: by 2002:a17:903:1c9:b0:1fb:6794:b47d with SMTP id
 d9443c01a7336-1fc3cc6a2b5mr19748855ad.52.1721134252576; 
 Tue, 16 Jul 2024 05:50:52 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc270f0sm57678555ad.131.2024.07.16.05.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:50:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 21:50:31 +0900
Subject: [PATCH v3 2/5] target/arm/kvm: Fix PMU feature bit early
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v3-2-8c7c1858a227@daynix.com>
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

kvm_arm_get_host_cpu_features() used to add the PMU feature
unconditionally, and kvm_arch_init_vcpu() removed it when it is actually
not available. Conditionally add the PMU feature in
kvm_arm_get_host_cpu_features() to save code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/kvm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 70f79eda33cd..849e2e21b304 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (kvm_arm_pmu_supported()) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
+        features |= 1ULL << ARM_FEATURE_PMU;
     }
 
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
@@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     features |= 1ULL << ARM_FEATURE_V8;
     features |= 1ULL << ARM_FEATURE_NEON;
     features |= 1ULL << ARM_FEATURE_AARCH64;
-    features |= 1ULL << ARM_FEATURE_PMU;
     features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
 
     ahcf->features = features;
@@ -1888,13 +1888,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
     }
-    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
-        cpu->has_pmu = false;
-    }
     if (cpu->has_pmu) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
-    } else {
-        env->features &= ~(1ULL << ARM_FEATURE_PMU);
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
         assert(kvm_arm_sve_supported());

-- 
2.45.2


