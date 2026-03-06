Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26BEFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfp-0005tJ-GA; Fri, 06 Mar 2026 10:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfT-0004ql-Ro
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfR-0002pB-I7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4833115090dso96362195e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809240; x=1773414040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3L9keBAgygnmQFdbbQgwX9U1zoCpckZ2GX7ejdHIGUs=;
 b=Kue5OOMzq9SB6dgU3lJNMiS7lfmGJiBA/FQCfwnDgwWgPEJ0j6qmCwwDWQLAAJelcs
 toDeur1gsoTjQmbcg9EKGM90+SgjSVgNVPYyJXO+yU5l4lB3z0WrRoYAOeV+nwBFMSzs
 L1DO7aCSLpmjD5QnQ51H94D7FXj8bGgh/RnR6reaY8SAniY8xsngbWIs+5nn2Hi5UZ+5
 OHAvNt+jQ/XCAPviiifHidtj9fvAj41tFm0qzXFjbSXqbsnMWwcH87LhvpMQElBnGsmq
 XR/IQdeGxIyPSngRWa2kVofrzsFiGERLJfif2j/VpY7gD0GTQpjpUgihYLazzs5wmgqC
 FBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809240; x=1773414040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3L9keBAgygnmQFdbbQgwX9U1zoCpckZ2GX7ejdHIGUs=;
 b=AGY38NHWyWJadxN3oBEJrr96nrqSydV6ZTG22mM47LFoWMduLsxWouJjJaNwPFwHlP
 hjimsIOyqmvGfTcD4naxBQT3lZnY0VYMbvve0XMHvASeKgJ60V4kmqMTwVahlBNnIcwy
 3E1mRmvYAgsvIyHvnxTDZ5coiLQAEMgBtCy4vRoW3wzwMvrgz9suWN6nQAQTAVOR3U6H
 ot0JhJU23GIwcdTDbQ1Wglu18iqws/g2TcTJtgsM8XCZB8wiTj3Txt+q9yQ4Odmz7+2F
 Dn5R46kVLOZMSld+G+ozwquzN8qVF9pH6K8LNzMVuT4Y7+mNsFd5DbFlWz3U250PQ/Ed
 gsOg==
X-Gm-Message-State: AOJu0Yzt6T4LlSGU7wpfF426CkzEJxSxS7/wOJmVJKbt+MNuymDXYJLB
 69ztZGm+dhXrvKQLAIDmS7ZabwON+KYsArUTvvxcPpwMYHai5lDTTXotuCXxIfYIeV+94frZvRP
 SO2mA
X-Gm-Gg: ATEYQzytX36qJ6hwCqeRyzq3kSQr83/KTCpTr7fzK050lUY9vHjU96BTrSk/VGbOcK8
 wtCgSsuaqmq6WfHAGH+R1sAMvwKfIxJWCF1f5ljBbQkMMTMWCH9Rif//mIg9HzYYSmkteCoMfwV
 9VpidQyjEm5jKxeLDInJ+UiZdyDqHFkGGBSOJ5FLCAhPrU9oyBqvmdo5s1anTnUq6Qbn1n2qSia
 dMGQaqfNe288Hp8n+tpN3emJEfSb7jHUdeu04GCffkAqHODtiQs1kpguMaFc+Uu98Wu5S+ui+tR
 uNq/EPcW6abBXUfbDsZhHcPD9UaC9HAMj0XFUy+pso8US0ULSbunc/WFwMv9D8n7PcbnL7KiFvm
 wEeBLJ0MTywOzudpTG0JASfTzSIqQmtxMPly2bvXD1E+ltXSRM981jRTi9VTY52NHbRQFKAt8bx
 Plg5MaiPUaLfSli0yK274XlpeXI1aRwHDQTuOPs8ptAs6lD34IuJgv0bY/OWvIvObSpI0eR9K1i
 SVLqtZF1YpfLskQexmzRDz+ZlwVq1g=
X-Received: by 2002:a05:600c:3acf:b0:483:b505:9db4 with SMTP id
 5b1f17b1804b1-48526978d8fmr38235955e9.31.1772809239758; 
 Fri, 06 Mar 2026 07:00:39 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/49] hvf: arm: disable SME when nested virt is active
Date: Fri,  6 Mar 2026 14:59:38 +0000
Message-ID: <20260306145939.2162189-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Currently, Apple doesn't support the nested virtualisation + SME combination.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260306130107.35359-17-mohamed@unpredictable.fr
[PMM: use FIELD_DP64_IDREG()]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 2 ++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0183dd8a60..e22a4d16f8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1181,6 +1181,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     if (hvf_nested_virt_enabled()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+        /* SME is not implemented with nested virt on the Apple side */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
 
     ahcf->isar = host_isar;
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 6b1c3b9792..9cb58ad9ab 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
+#include "system/hvf.h"
 #include "target/arm/cpu-qom.h"
 
 /**
@@ -35,6 +36,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
         if (__builtin_available(macOS 15.2, *)) {
             size_t svl_bytes;
             hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            /* Nested virt not supported together with SME right now. */
+            if (hvf_nested_virt_enabled()) {
+                return false;
+            }
             if (result == HV_UNSUPPORTED) {
                 return false;
             }
-- 
2.43.0


