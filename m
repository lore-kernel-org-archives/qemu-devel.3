Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9FCCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkQk-0003YJ-Ax; Wed, 03 Sep 2025 06:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQh-0003OO-N9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQf-0008PF-O2
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45cb659e858so2754595e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894164; x=1757498964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAbnTqr7urlPKbd55OQGFVEMN5LG+0p4EnC3m2XGl0s=;
 b=Hc78KnHRwgGgFgRPFcrRTkBYMbKGymT240iHb38on5brbWQtD7liFHZzoRZYvHOfST
 sIJePLuc8qYljJvTDpTwmOm1cm5dIjXJSwVSiyvvDrpn3KcbvTvg6Ojfh9+iP/U5PlYe
 /y20ImUcGc8nIFlokKbQQumWGZQhRIQJOQU/JF4yqgUPPMu9cViuSMikY9gxeBgNY9QC
 of4T+NQa+eXQMpHxrB2/UvHOU8/faOLoJdayHLV0VVaPAbHDNdeDNPLo4EZ8V8j0rUAn
 5f555KlqTeXMJxgGQjuCFWmWfu/FKe+2gMvcNUwlC7EVOrMjRHP0+AJUO6jRtrDHb2GH
 8GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894164; x=1757498964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DAbnTqr7urlPKbd55OQGFVEMN5LG+0p4EnC3m2XGl0s=;
 b=gzKaQarbBdFKCPy6wev2IyjrF59gwIiCHx9572TjsrhJgw+GZlfBFYl6jswc/PH+rl
 R15MlseKL0aG40QBCh8kH3hVAwkNQYl+jIRNo6tyPAJdrSqfFH+0cmYtRIbFyu4tw15G
 4ODPJajcyGRK6irqMR6IoIC8C7Z7O3TTPIIjOSytLOCDzjL4rDLmLVEG42ReqYnBaIbX
 1LpOG3KA3gW7kzJY/QD9YGRa+FfQxRNCHXp0Se9Ggv9FtG6BX5c+Ygl0vFQW8i8/i38G
 iNFZYkPeBja3DSXX5wfzDxw17uxs+Z+zckC6JAWVFK8nL/DOsyrEd/xd/KMwayo27W9v
 Pl5g==
X-Gm-Message-State: AOJu0YwRTeivp+x2Y7aHMvrxoDQT4EwxlyQyk7c+4JNt2x9YXDYxE0wN
 tP9xPYP/sZ31AC7Fc7ukh44EwPexmD+/hQkCWPlKbnMKeukCbpAuwsBkVBBSeuUvcEC0SDU9QUG
 ChBmuLfIUww==
X-Gm-Gg: ASbGnctywV1sOgm+6hxA2c1RdGy8SEtmX9v8ur4LaNeH3tQglJIAxbLDezH6Wqe0Ppm
 Q/VTtWQL8yVzCTjBYnlagUL1f6A5ljhyHTlN02VQ5XY7TNOx3axr9yN1fC5rAoeg+wB6TnAQo4D
 mnzceJm/61voHxRvWOqZ0C+0CGjKm9unwxgZRpr/cax647vCVdSrXMfMJE5T+stFE0bxdckZiEd
 O7CDflCQUZkiy4aory3BqVjGHKu8X2U6KtQSSgcfR9f/P98M1lEC5iap6THwv3C8Yzk+gtkbqeN
 l8Elan6l8DxfhpFCG3N/t92KsWzLY+YycJ8eDDOY/7wy4uv3wKMZmzIZopdwei3L0rm6sPbzBGl
 aYfH8HWG7DsWJGLoPgiRdyG7IcuPICuZdaWGnE7ETiJk57hfvGNVlQONfw0npYEQZjyD8Yd4rzs
 14v0xXSP6EOXZPJMJb
X-Google-Smtp-Source: AGHT+IH9EBQxYGmAzbfNSc3Dm9S9kuoWybahIB8kswVh6cEh6kV9F4zeeG1tt3vK9CUL1Ju+NWB5TQ==
X-Received: by 2002:a05:600c:6308:b0:45b:8600:2bd5 with SMTP id
 5b1f17b1804b1-45b86002d22mr128754975e9.5.1756894161949; 
 Wed, 03 Sep 2025 03:09:21 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e886619sm230819655e9.15.2025.09.03.03.09.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:09:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 15/24] target/arm/hvf: switch hvf_arm_get_host_cpu_features to
 not create a vCPU
Date: Wed,  3 Sep 2025 12:06:51 +0200
Message-ID: <20250903100702.16726-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Creating a vCPU locks out APIs such as hv_gic_create().

As a result, switch to using the hv_vcpu_config_get_feature_reg interface.

Besides, all the following methods must be run on a vCPU thread:

  - hv_vcpu_create()
  - hv_vcpu_get_sys_reg()
  - hv_vcpu_destroy()

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250808070137.48716-3-mohamed@unpredictable.fr>
[PMD: Release config calling os_release()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3039c0987dc..fd209d23c1e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -869,24 +869,25 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     ARMISARegisters host_isar = {};
     const struct isar_regs {
-        int reg;
+        hv_feature_reg_t reg;
         uint64_t *val;
     } regs[] = {
-        { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64DFR0_EL1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64DFR1_EL1, &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
-        { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64MMFR0_EL1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64MMFR1_EL1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
+        { HV_FEATURE_REG_ID_AA64MMFR2_EL1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
         /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
+        { HV_FEATURE_REG_CTR_EL0, &host_isar.idregs[CTR_EL0_IDX] },
+        { HV_FEATURE_REG_CLIDR_EL1, &host_isar.idregs[CLIDR_EL1_IDX] },
     };
-    hv_vcpu_t fd;
     hv_return_t r = HV_SUCCESS;
-    hv_vcpu_exit_t *exit;
+    hv_vcpu_config_t config = hv_vcpu_config_create();
     uint64_t t;
     int i;
 
@@ -897,17 +898,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                      (1ULL << ARM_FEATURE_PMU) |
                      (1ULL << ARM_FEATURE_GENERIC_TIMER);
 
-    /* We set up a small vcpu to extract host registers */
-
-    if (hv_vcpu_create(&fd, &exit, NULL) != HV_SUCCESS) {
-        return false;
-    }
-
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
-        r |= hv_vcpu_get_sys_reg(fd, regs[i].reg, regs[i].val);
+        r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg, regs[i].val);
     }
-    r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
-    r |= hv_vcpu_destroy(fd);
+    os_release(config);
 
     /*
      * Hardcode MIDR because Apple deliberately doesn't expose a divergent
-- 
2.51.0


