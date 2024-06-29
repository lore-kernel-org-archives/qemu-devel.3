Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEDBC30659
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNXXt-0003kB-Op; Sat, 29 Jun 2024 08:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXs-0003jY-Jz
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:12 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNXXr-00076j-3H
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:51:12 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7163489149eso1048141a12.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719665468; x=1720270268;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BLXk3fVoBHrMXW9NOMmJn9sejRtpsd5b8rXX3PkXa4Y=;
 b=AJx8zbOllNUQOXTJ4PkEug7fGAKBFzhckgNJ3XvBvGv129FjGjXawDnakpuMK0LDLN
 yq2sLXdmMuEm7MUfdFeK36LKaFewQoW834mlyEgvNkJ7cGQNtkWqv0mKZJGA3bgiIw+D
 MRFnAz3YTDzK45S2eE/kvdMnKk1TD8ATAPyzdMT14nwmRAGL+i5K9guTMBY0GecFi/9m
 Br6xZbkVXrOtk7IRKuCgcOoAcICeviJYgeMUvSphK7v6RlUvq0njnNkXdCn0lL+BhA4W
 MgoHvrQKXcEbWGBdDGp6snICUImYwa0CrQBGhRlHO+hu/EirukyGsInfYhG+xClEvdzy
 Vzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719665468; x=1720270268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLXk3fVoBHrMXW9NOMmJn9sejRtpsd5b8rXX3PkXa4Y=;
 b=FcqW4f7bieJsI6yJNu4ZySA2h8tfzbt+B1SMyhVd5Rmne5IAXvnBLk0puQ2OYppoMT
 OSeefn3chHAwYus4kyk9wP67cC4puEFYVSiTF4Qes8Vqmsz51DDT57B18oG86GAQw7lP
 /GhjtJTlst94fcULKlICO+QjGN6JvoA2ManEnIFb11qwHp4kJvLQRW6vImGscEeSagnm
 HcE/wI5vIP7WHBzkYAehnOydHRHSpoqMFp32TLuE5+5cE8BsnxDZ1kO7JP6TgTJHqo3e
 3cgPoKFi9Jg/8E8QTtarguillskepmfBCsbgUA1SR7ME1Hlq3MH/013y58INZtglb6Ud
 O3Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgxuOehpzlPQS7rvtRyWQEra+B+k2r3zVuay9qqZ5YmdH7Tz5HGII2BWW4KeyjLZcx9ngCzW/jwtTCSmspwicKk8wjbEE=
X-Gm-Message-State: AOJu0YzlTGS2biM6UOTbVh3kItcVKD7q4y4GQppBjXE78iYRlQryCyyz
 IPOdApxVz1JYGrS8g4jE1KqK4eQFMsY9cBHztZ885TtJPVQRXH0xbQK2OLr6Pvk=
X-Google-Smtp-Source: AGHT+IG7G8Ijr8L2HKdiqhp40sGsy6gKftpsugRXAdDH+909J0VbPSV3RAHeQhyAI/SMsNkSSEd/nA==
X-Received: by 2002:a05:6a20:1590:b0:1b5:ae2c:c729 with SMTP id
 adf61e73a8af0-1bef611bcf7mr1506320637.19.1719665468263; 
 Sat, 29 Jun 2024 05:51:08 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac10c8b3fsm31589815ad.5.2024.06.29.05.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 05:51:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 21:50:34 +0900
Subject: [PATCH 3/3] target/arm/kvm: Report PMU unavailability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-pmu-v1-3-7269123b88a4@daynix.com>
References: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
In-Reply-To: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

target/arm/kvm.c checked PMU availability but claimed PMU is
available even if it is not. In fact, Asahi Linux supports KVM but lacks
PMU support. Only advertise PMU availability only when it is really
available.

Fixes: dc40d45ebd8e ("target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7cf5cf31dec4..6bb72c09be10 100644
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

-- 
2.45.2


