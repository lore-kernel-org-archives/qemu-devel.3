Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF897C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTa-0002yZ-QF; Fri, 20 Jun 2025 09:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTZ-0002xR-7D
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTW-0004cd-SS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so1049733f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424889; x=1751029689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcjg3QhSmhnYtUxzgWM8ifLgGs9HqCTQt/fl8y8J7b4=;
 b=vWtHo9KFZk/tIqs0kCMqBjUliF2RrXyVUpFYG4ue5VBob3BPMMuvBjrcmAdfiZPVdx
 Q4P7UjKdD+lPju0mCfNyjIw6MPi31x0kLhcgIfYAY2maj+MtB5Q8RwfjRrDYnCJoMtxy
 MN+gZQ8QlSSMS38dSb7D8BpdPBNkhS8mR+9C9bxR5O/w/hu/YkEqaOV491RuB5r3qAr/
 AZdsro4yGKcxoxPXB+Lj8OUiDHg0XI9X9mvCzQojO/+Pu2JlGCG//t9K534y5pPUnsJ0
 7FSPwdyMDsWHEgsBnkovMyZ6A1mZq5UPt8KMKeeEn29Bb7csmtguFakgxV8mfBGB/opw
 WLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424889; x=1751029689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcjg3QhSmhnYtUxzgWM8ifLgGs9HqCTQt/fl8y8J7b4=;
 b=YvvdGpNPULQoU7NUSXvhZmPzo7L4DXYUBpJUob3z6DtR5Xg/GaWSxDVTJ79zkOfTSm
 EjF2n22TvntG4Mpj/fBIJS1ddL16WzHaZwx9MuCt4taGZofGHgReWrLUaEMZhHjkQIBO
 NUJ/IU1vYC0C1K4jesS9711GQXt5qInY+cIrJr1o2k4+CsRHSuWDyy9nTq9jKoHMf2K9
 DKpZ0juuXgoVo+FfG7t1XhK6EaQaJiCFTGecYjO7v54G7qbZDKEkapaWgheaxGItcLvU
 12jBMuqdnv5vzEpRCaVr8C0KxhuUBLz8vSk0A1/aQk/AtSjo9h8ri52Uwwd0IvRKT+57
 jANw==
X-Gm-Message-State: AOJu0YzTVmVDfmdf8iJbKrvA4wXEA7867t3jKgUtaRwoX6Ucp7mdpVBt
 BecNq1IryvHI/XiDH9ESikdDElZXu6iFTrYlq6tV4uoFHjGpWpQ2WSFrmirBV30dF/9jPF7dqjg
 6+ldcMGU=
X-Gm-Gg: ASbGncsppd1Rii7vK7Zt7dP6X8hwUC8VOo0H+npZVKnDDNxRWvXqbxCZQHIYwhe5dLE
 ZzHTYurdFfYMRhnVgcaQt5XVDGwDtiM5xkwFb0COG8zD+1Ljm2BL1lkCm+O0G1gOCHQ44V+3yLC
 kNWg0tTBhKUqFyo8gDB0+50IlUWqcZRbkeeO+nzeTxmJYjIGNlzPrLAMyws6dQaWZvd/Yp/WFVl
 ApI8+9CXeJJI5ZzlcN9jRLRwFuEunTaCM1trkGKkYwJmS1MSi4BAgcwO/DOKmaCqASelGKtPUpD
 blhSXNuDmKIUMy4mBNN+Z7Aq152nAFK6gAiz0YeNmbUSybWq9khRxZnHZRBgCNr+6rlo/2EokPQ
 tz35nbTVQVn8L7J/A1zodszRjb2UXVM3JUO5J
X-Google-Smtp-Source: AGHT+IGlMawwPYBTI6F+HQ5fZwO6wtFZQ3ofGqTbh9NR6Oep2MJV2fe7y9qs/PunxZNaedQy8sLILg==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f6ba:51da with SMTP id
 ffacd0b85a97d-3a6d12db6d0mr2328685f8f.15.1750424888138; 
 Fri, 20 Jun 2025 06:08:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190d13sm2038186f8f.90.2025.06.20.06.08.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 10/26] accel/hvf: Model PhysTimer register
Date: Fri, 20 Jun 2025 15:06:53 +0200
Message-ID: <20250620130709.31073-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Emulate PhysTimer dispatching to TCG, like we do with GIC registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bf59b17dcb9..5169bf6e23c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -187,6 +187,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
+#define SYSREG_CNTP_CVAL_EL0  SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -198,6 +199,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
+#define SYSREG_CNTP_TVAL_EL0  SYSREG(3, 3, 14, 2, 0)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -1326,16 +1328,15 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     }
 
     switch (reg) {
-    case SYSREG_CNTPCT_EL0:
-        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-              gt_cntfrq_period_ns(arm_cpu);
-        return 0;
     case SYSREG_OSLSR_EL1:
         *val = env->cp15.oslsr_el1;
         return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
+    case SYSREG_CNTPCT_EL0:
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1639,16 +1640,12 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSLAR_EL1:
         env->cp15.oslsr_el1 = val & 1;
         return 0;
-    case SYSREG_CNTP_CTL_EL0:
-        /*
-         * Guests should not rely on the physical counter, but macOS emits
-         * disable writes to it. Let it do so, but ignore the requests.
-         */
-        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
-        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+    case SYSREG_CNTP_CVAL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
-- 
2.49.0


