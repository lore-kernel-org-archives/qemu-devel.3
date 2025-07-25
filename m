Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA72C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOyo-00055o-8E; Fri, 25 Jul 2025 16:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOsy-0006lM-DT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:19:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOsu-0000w5-KB
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:19:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b31c978688dso1551452a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474755; x=1754079555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzMe8v8+D/ZJwDaUmFXie+iwsXeeiiuU9F5B/tUc6Sk=;
 b=TkrMmPyH76Pr1CTTKWv6NJTZLmoA3i2ruRA1kyeRL8VGBB5QJ9STkttKQGv8Uxkz1B
 eEHSvkLPZ5wmt7fVbfQCRSbqq9bLuaHlsn546e00uY8RCsK0MS5XowWgayVVqkZSUAzK
 BzpZoyJ4AxJtDnJZYaUZlJSzVH38gvgF/8aVu8x8O5QdJoW5imvlCnJ3DmChBFQPdkkx
 W9SR3aPGA6KlLATEF/4FeRzW7sJGqM5JJhcXw3HAdeLEdv2aDiGdOTFzzcjBBcJTJWBX
 dznqatsCj+pKbu2dhHrvo7uBUwCtfeCDKZBK6nz9bhp4JyZEXo54kdFUbnbOcgI3nFHx
 xuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474755; x=1754079555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzMe8v8+D/ZJwDaUmFXie+iwsXeeiiuU9F5B/tUc6Sk=;
 b=hZtf0t8VQ+yDA7/Xzm1/HklD3Ria19iZeIc0f2Ukf6n7jg1jvb73sZZv0A165nMqQI
 Pufzg/mYvayop9sB/UDpaS31cru03IPoXKD0nG3raZlMBhDzo9LxppO7SSs4doMCrRqc
 6GbUyImHlTGsd9LlYUgD3XAwqQp3slmZSklMI6G5c/z2m4rTemE2R9sHqwiuM8c2CK46
 kVFtzWHVNR+M+uXKs7uFMnJOSLgui7H9cg4kgj3E5mZqmA8S3ZaG9eLUjbcOEbc6ZGI1
 100pvQohQ9vt9Ojhr52bwEmtWYKl98EJNuYdF2shxDsbghlLuuTMqjp5dufTmCB3ZKQT
 Weng==
X-Gm-Message-State: AOJu0YyuMk7U4LoXnBenTTnj3z/Qkt6UHzC2cZ7eF9vp2Fv10wbnPBAZ
 TPr6RkOZ5ZAZpp95EKXWvPKDeNkgEk3OCnrecxLN7qHaM9X6SNig6YmFxoR+8WAGcrifffu6sAy
 M31eb
X-Gm-Gg: ASbGnct2vkTv2jFk6m3GukpFXXS+cx3i1on1kIRvOtwvHj6mcLstqDwJORmDmI5v+Yt
 lI+1qs6VByLwNCsC93YOzJJCyX3ElQE51YTTHz4EFYps9NeWhziNVStIuSXRtgjwu4MiMuf43/d
 kxjrGYaoxtOCebvUqq3Yd9TdEcu33+2dQt21wBxypUvZ+RGvbDx2XlBWoktM5LbHURVWDzXCDSq
 QNquCYcqJZ6bxniGLvU/GqOf/MvfoD7omDmbGZXt20RAcDh0fgTa4fJsRZNzDCJ8HSuecR0O7NL
 SkB2kBoxdn/e7ZHbKthyv47j/ECIGhJDa+s9fOHKT54iMinxqjBcmXZrR0xjZCnTsvK6yyaQShq
 dvGGG89XpUktHJLRSdjYzdw==
X-Google-Smtp-Source: AGHT+IGH/EuKqatNwjYkseoEwCr6nkLbARrg5AfrtW50R+rXb57JK3pceP27ZjJ5pWpuZq5kRFJQaA==
X-Received: by 2002:a17:90a:c886:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31e77a44dc7mr4180921a91.13.1753474755117; 
 Fri, 25 Jul 2025 13:19:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6635f0a0sm4143309a91.24.2025.07.25.13.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:19:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 3/3] hw/arm/armv7m_nvic: move to hw/arm and compile only once
Date: Fri, 25 Jul 2025 13:19:06 -0700
Message-ID: <20250725201906.19533-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

This file needs definition of ARMCPU, and thus, belongs to hw/arm.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/{intc => arm}/armv7m_nvic.c |  0
 hw/arm/meson.build             |  1 +
 hw/arm/trace-events            | 17 +++++++++++++++++
 hw/intc/meson.build            |  1 -
 hw/intc/trace-events           | 17 -----------------
 5 files changed, 18 insertions(+), 18 deletions(-)
 rename hw/{intc => arm}/armv7m_nvic.c (100%)

diff --git a/hw/intc/armv7m_nvic.c b/hw/arm/armv7m_nvic.c
similarity index 100%
rename from hw/intc/armv7m_nvic.c
rename to hw/arm/armv7m_nvic.c
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 25b6bb438a2..68dbdd3e913 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -84,6 +84,7 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 arm_common_ss.add(files('boot.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 
 hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 250ad116186..e25fa32668c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -62,6 +62,23 @@ gicv3_cpuif_virt_update(uint32_t cpuid, int idx, int hppvlpi, int grp, int prio)
 gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f 0x%x virt HPPI update: setting FIQ %d IRQ %d"
 gicv3_cpuif_virt_set_maint_irq(uint32_t cpuid, int maintlevel) "GICv3 CPU i/f 0x%x virt HPPI update: setting maintenance-irq %d"
 
+# armv7m_nvic.c
+nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
+nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
+nvic_set_prio(int irq, bool secure, uint8_t prio) "NVIC set irq %d secure-bank %d priority %d"
+nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
+nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
+nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
+nvic_set_pending(int irq, bool secure, bool targets_secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d targets_secure %d derived %d (enabled: %d priority %d)"
+nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
+nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
+nvic_get_pending_irq_info(int irq, bool secure) "NVIC next IRQ %d: targets_secure: %d"
+nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
+nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
+nvic_set_nmi_level(int level) "NVIC external NMI level set to %d"
+nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+
 # omap1.c
 omap1_pwl_clocking_scheme(const char *scheme) "omap1 CLKM: clocking scheme set to %s"
 omap1_pwl_backlight(int output) "omap1 PWL: backlight now at %d/256"
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 22814893cbe..dc857833dcb 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -40,7 +40,6 @@ endif
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
-specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 4d6c886b794..aa9d65fdc25 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -165,23 +165,6 @@ gicv3_its_vte_read(uint32_t vpeid, int valid, uint32_t vptsize, uint64_t vptaddr
 gicv3_its_vte_read_fault(uint32_t vpeid) "GICv3 ITS: vPE Table read for vPEID 0x%x: faulted"
 gicv3_its_vte_write(uint32_t vpeid, int valid, uint32_t vptsize, uint64_t vptaddr, uint32_t rdbase) "GICv3 ITS: vPE Table write for vPEID 0x%x: valid %d VPTsize 0x%x VPTaddr 0x%" PRIx64 " RDbase 0x%x"
 
-# armv7m_nvic.c
-nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
-nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
-nvic_set_prio(int irq, bool secure, uint8_t prio) "NVIC set irq %d secure-bank %d priority %d"
-nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
-nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
-nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
-nvic_set_pending(int irq, bool secure, bool targets_secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d targets_secure %d derived %d (enabled: %d priority %d)"
-nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
-nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
-nvic_get_pending_irq_info(int irq, bool secure) "NVIC next IRQ %d: targets_secure: %d"
-nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
-nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
-nvic_set_nmi_level(int level) "NVIC external NMI level set to %d"
-nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-
 # heathrow_pic.c
 heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
-- 
2.47.2


