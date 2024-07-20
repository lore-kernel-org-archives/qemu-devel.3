Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D3C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV6R0-0008SQ-5k; Sat, 20 Jul 2024 05:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6Qz-0008On-9L
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6Qx-00070c-RX
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d56so16514935ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721467878; x=1722072678;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uuvru8O1Lbu3d3+4LM3J/KSbEI4f7QyyvTpp+vjJrRQ=;
 b=DTW6cWRjBbUYf5kp13Lj7TfQaP349PQcy1ZQGchvj8ls+TPc/nT6SJtgtP4BbkRpWF
 7C+j3QNrhzLEo0EQuXUt0WYtDG27Rg42n9HEr/yLmAma1yXo29uU5u49kAOXUK7dIKF1
 /4ekceTvv8Q9AlK6w+91zcrpMXEnPP6OauW/oYaFHKW8DSU6WBMfED0+o+6E+XY9DB/1
 jMgC110bTy01z6hX1T8QGTX1aGzf67s84YW3ymCWyYX1/vBpGmnlrla1FkAxHSYRbRm9
 hCHUkYGpZDTEy2CjL2mRtk7Z0mgN8CR1MQh6T1u/ThivVGsGLIQhIfbc9i4axpPpk0Mw
 Zb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721467878; x=1722072678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuvru8O1Lbu3d3+4LM3J/KSbEI4f7QyyvTpp+vjJrRQ=;
 b=nGyPfPTog7ZDR9EXSS+gObP1FI8vcC9yrOmLAqCaUJdjAGatuyHAiR3TAw2DmPQDtr
 hW1P8cUUAVbpODr89PD4EWQyg5OMwq/HR1SxdFoAdaYPoMbMa2y2Ic1BQK978d7trF/M
 yGfbXGGNbZKcx+iW1jFr/rrzIcp2b+nrjCfUJSN2knqxs7K1IhAY6pN5bnyKuDV9hXeR
 ebDxLqeExEUJCOaej1w+/d4FWjsLR14OqqBFNJThyblUdCH2butNE9Pk5Ygc874yQibd
 xKOmswt2RSiYgrvitNszzIxeLaPaWaTN3FUrSFYgdJLmsVmFaOH61nspnsEcCBZbnR2i
 VsYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeLNw+itdtguxUJ+64bBZgla9g4qW/kN0Qfc1Ej4KKX1TBLAgfMpPAQQt0igGfbnYbOeyWD3Rf+YfW56pUEEHqbeq0Pqs=
X-Gm-Message-State: AOJu0YyO9K91VxIFYW6FH1Skk1rjjoAJgZvRkcw9DY3zqXSki8Grmthu
 EyEQ8R0+a3OArZdYeGFBFxgw4689EVubwD29eNcsjJE06We7kofqkldsY0lNQalCUesJOVwWwlg
 8aa4=
X-Google-Smtp-Source: AGHT+IGDxYBQ+UI3zCis37W9PvPyH5SIE5p+oC1cjVEarHMW9QkebJPnPHpAqlSz9NjhoUTUJSYbFQ==
X-Received: by 2002:a17:902:c405:b0:1fd:73e6:83b8 with SMTP id
 d9443c01a7336-1fd745977bamr21122635ad.14.1721467878255; 
 Sat, 20 Jul 2024 02:31:18 -0700 (PDT)
Received: from localhost ([157.82.204.122])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fd6f28f518sm18251415ad.69.2024.07.20.02.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 02:31:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 20 Jul 2024 18:30:50 +0900
Subject: [PATCH v4 2/6] target/arm/kvm: Do not silently remove PMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-pmu-v4-2-2a2b28f6b08f@daynix.com>
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

kvm_arch_init_vcpu() used to remove PMU when it is not available even
if the CPU model needs one. It is semantically incorrect, and may
continue execution on a misbehaving host that advertises a CPU model
while lacking its PMU. Keep the PMU when the CPU model needs one, and
let kvm_arm_vcpu_init() fail if the KVM implementation mismatches with
our expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/kvm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b20a35052f41..849e2e21b304 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
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


