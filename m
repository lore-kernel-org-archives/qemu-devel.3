Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3B9C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDus-0006K7-II; Fri, 11 Jul 2025 09:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu7-0004XX-8O
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu4-0003Bg-Gi
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:06 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4537fdec33bso12537725e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240902; x=1752845702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WR2J2zJH+rNDC6JrmtA+Lka4FOQFLeYlEicPF+0JcK4=;
 b=HCwaW2OU7MtVB1CerE3usBaZE6dmScQpZ9/OcNHEcWwp2JdwDFcNoLQbeDSBMBg+wx
 aKfeAUJfXRqL+IXrKOIXkD0CGHo3EIJ4EbUWJu+JkeH64JX1Di9OHHExFxrJuAVOm2n6
 N0bAyRjwwaJXZITejaW+qUiL+qfZDI4FKk33GCxsrrN+uYa3XZG2i7Ff3My4tIY9fK8V
 a9wBWDGoc5JmnQLa+yrCfPKp35ja7lUzKA9TjcoUW301cLCzlgvWVuLIBZShmcVuNjNp
 k/ukxU1B9WQ89DkODGo5WH7ZKmmjo4jlI3dYTkVHJBurrHYSk+t3OJvOCNFKDEs6bn2/
 PS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240902; x=1752845702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WR2J2zJH+rNDC6JrmtA+Lka4FOQFLeYlEicPF+0JcK4=;
 b=ixGs78aqy+ehGPbIXU4R/RGuI4ODroKwJfUomq/xHkIypvABkF8Ccg2blcCjnRtFbI
 bvg2UJmHER0SDB6UkPdmLOK1fZl7l8Io9qVeYeaLZTlkDyZMfCi6bH1hz40SHtNpP0xW
 BHjxlQCmA8HuIDtPLNHbn5CCLpxC4pm39YPgWP0r530VPUWabAqwE62nidx76o6HfU/M
 CBZcu9s5z6ecaSvX7I3acYFXFF2oPy625vNrsEHqS+r1nkLf7O+2WzdAYFF0GilJXjxl
 vMdopNEWMLdrPm4EDrW3o58mDK1OzBvUxF3jLWp53PCN00Z8RU9Eu6oChSf5Yvo1OZOz
 ymsg==
X-Gm-Message-State: AOJu0YwEOslK9P4XIMVbirMX7dfGsdfQoYdRl3dg2BV0S7foJpJXeP08
 /GTtOQSN2XDfTMRQWAlcZwavDTFvHUTgf5erJxiyYtmkWNldOPfYEPJwd9OLm5jgBdddIa3KspA
 cgbJj
X-Gm-Gg: ASbGncsEAHgRnKTqONTlMwOnQiQwAr1ARg1bCqER2QVg16Js4FNgZhaqTo4QVgpWssc
 gkg5DQDShryGoj9y7+WaRymMhLi1CeUGsWzUuRGBGyiZL1K9k6wOqLV1s1v4bxhkWfDD/2uCMbY
 LKz0QEOfBnj97WtxzG1JkHGkYIS92/k4LX8rsZ8wjWELBCnP+chAD0O1QSkINMn3eaH6XzTFUOk
 +C0jZj1inExqyVQSv3/hZSObs15s8cAgVooVsx1ECe81sI8+xIuypn+1xR8Ia0KLV0AFCjaF6BB
 4V4DmNrCFPLNnuOlIauWN8Ot6dV21HJBE//Dn0haNrTpZQzpIgKV93mKsII/KWB5L8dKRtbtlcS
 RWlgm+4EM/FAVfTIEu5D0IsKJgPBQ
X-Google-Smtp-Source: AGHT+IGnwClQrp9HmS4pVkheSS6sfKP5A9/hta470XaTJ/KxWYdes0Zzgwbkkw4buiSvfdxqJjjBzA==
X-Received: by 2002:a05:600c:1c21:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-454ec1342c8mr29682005e9.15.1752240901817; 
 Fri, 11 Jul 2025 06:35:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/36] target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is
 supported
Date: Fri, 11 Jul 2025 14:34:22 +0100
Message-ID: <20250711133429.1423030-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Haibo Xu <haibo.xu@linaro.org>

KVM_CAP_ARM_EL2 must be supported by the cpu to enable ARM_FEATURE_EL2.
In case the host does support NV, expose the feature.

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250707164129.1167837-4-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9fdf354f3bc..66723448554 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -251,6 +251,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     int fdarray[3];
     bool sve_supported;
+    bool el2_supported;
     bool pmu_supported = false;
     uint64_t features = 0;
     int err;
@@ -270,6 +271,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
     }
 
+    /*
+     * Ask for EL2 if supported.
+     */
+    el2_supported = kvm_arm_el2_supported();
+    if (el2_supported) {
+        init.features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
+    }
+
     /*
      * Ask for Pointer Authentication if supported, so that we get
      * the unsanitized field values for AA64ISAR1_EL1.
@@ -423,6 +432,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     features |= 1ULL << ARM_FEATURE_AARCH64;
     features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
 
+    if (el2_supported) {
+        features |= 1ULL << ARM_FEATURE_EL2;
+    }
+
     ahcf->features = features;
 
     return true;
@@ -1888,6 +1901,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
                                       1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
+    if (cpu->has_el2 && kvm_arm_el2_supported()) {
+        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
+    }
 
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
-- 
2.43.0


