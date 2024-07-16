Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262BBC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdYD-0006S6-Nf; Tue, 16 Jul 2024 04:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdYB-0006GN-0e
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTdY9-00022B-DL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:28:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fb70169c23so40829995ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721118519; x=1721723319;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1KxAC9/Pxe3NsDzOqPZpbEql5jfhTTEPjoaJwE6M8sE=;
 b=cuJiZasr5IZIIJxFtqh6PnNU875JUyI5Hkn5H94PaMFvxcK/9Tgl8kd+Dq36ZIU9l7
 lMyVCmEmBDKMSsj2wSpyJiMqK/QZ4qF6rzapdqnA0RyRYfd1lnxx5vD6ZCmOfta0btUC
 CeCoG6RM80DP7u0VbPbyEgSrEmlayeM8BSmEso5o8aI9AfV8X+IZunRqqXjp8pSa/lBJ
 lsHP30FheeGwMbiZfVGSU1eOKjEz7lYzdDbQtm8Gw3DxLG3SSIq3IGzJs3VBfLXeSi4r
 s5QenjPx7uEbURg6YGuEczFf5h+wRB5wvMh2lzRqOF0zc5hfyFYzhVpyQkBjzTRkPvpd
 vLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118519; x=1721723319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KxAC9/Pxe3NsDzOqPZpbEql5jfhTTEPjoaJwE6M8sE=;
 b=vCXNdB47n82j7shFpXI+TBAPyxQ+ghwr1O3ANIjwj5i8jY8wQo8SSCVl+dijzlUWKt
 Y6JG5UZVn0WtGfd216n8FKH8ZCSaU3LH8EFM7+P55xBNgyRzf+owJcPtJqXeJtY4pbV4
 eeZf6ZOsyzNpz74XCVIIdtQORYQmVaETWfouPLe9AHl/uQiQxSJIfba011z2wSXnzrp+
 aDBSqmRJU4ZBXE2CJtyfEcVO/k3XLyyl+6g9vEu1IfFJ4Ar9AwbHxdGvf9Fjfv0oCxEl
 fg2A4IKWSm4xz5KU0uJQpjlfwEEPUDLWNvkdosRfgKg/ZHbwJ3pWIwkusxQhZymHZ+qA
 V0yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe/5hwTTor5hiHXh8dppMS9fO6I9PdHDUONpmmcXr+xt+OrELN6SXZiaU8LESPI1kZshVXaZ3BC79Uhb4qkrMSeG52LCk=
X-Gm-Message-State: AOJu0YxDTplmvVYPCxHkulxQtsc23UcMbhq+4VBOa2LKtBbWaU8o+3Or
 vFtQ+1dakoh1i6DZpN94C9JiDI+PGCazGajeuAq4W3p5z9fY1vkFHS9Oxume5LJ3rxHM26VLbx2
 QkMo=
X-Google-Smtp-Source: AGHT+IFrqJjHfkW1n1U+uCFdO309idp+NxLuzCYnpw8ARqcXhMW5rN8oEf3Ut488eOfutxc39v5t2g==
X-Received: by 2002:a17:903:234e:b0:1fb:b35:2fcb with SMTP id
 d9443c01a7336-1fc3d92d0c7mr11461215ad.2.1721118519582; 
 Tue, 16 Jul 2024 01:28:39 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bb6ffdesm54720525ad.53.2024.07.16.01.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:28:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 17:28:17 +0900
Subject: [PATCH v2 5/5] target/arm/kvm: Report PMU unavailability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-pmu-v2-5-f3e3e4b2d3d5@daynix.com>
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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
index 70f79eda33cd..b20a35052f41 100644
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


