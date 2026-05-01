Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FB8CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuO-000468-Ps; Fri, 01 May 2026 06:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuF-000417-Cj
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuC-0000CM-C0
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so26212475e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630531; x=1778235331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lb+Hv2gpBFCMBdugccmdMigUPrnD4ShbuSoaq16Of18=;
 b=EHPjQVOXc0lhVi//RRcY6I0UNkISzQxGzSAqhe55eeYiP5cwyv3PfgKj7IhMevkalG
 YT90vqAcHYq+OSc4j27+O+xe7v+IbICGHb1ZyeLE02QcKRCpqAoeTR/bAmh8kd7Dbans
 JYglRBJB+XeuJJOmCcowfUpEFnaKThiWj9EooEALvX8ozNKPWNB4cipBJvZzoKRGrL0u
 wvVABi9YnKx9Dnd2/wefHHYylTgxSm21L2tnaH+NES9R/3mz5ldbvsPWHbjhYHw6B1yV
 xvV+V6qX+94P9mrO1l7SJMwJwuzN/nA60UYr5E7XWWuPFgO7cDEwb2FPK5GkWhmTEg+O
 N9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630531; x=1778235331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lb+Hv2gpBFCMBdugccmdMigUPrnD4ShbuSoaq16Of18=;
 b=Nvftv1WGCbK3Y9OxxqWAo3OLK9whRvT3FqE8QA9bkUqJoTQjjvcjk4nvejrh+eTViE
 fcvjLdX4G4QVvLGoMlOjDkVxh2myJ4M6NAWkO/D1uU2C2nu7tutRarJJvOpw4bgaaJKS
 aGpKCpanUh2WXIpeEvcdWkRb4YsYjV89cxZx4Srmabs+2ROg6wElWDsIxb6L+tV7cFiX
 mqEKK7XBuvIf7yqX+bbVywFs176S5kfQLXhwIwqx8ctGQ2i4AW6XyEw6neVlgU344t3T
 P67KeqGad0Ke5EIOyytxkEbuDHirlUkoDeRG8hRmXmILJ+4HyPA0cy8ItHwvQHT69jDg
 6TFg==
X-Gm-Message-State: AOJu0YxH7SAgUnkOPflqLT685jiCzQi0T+GxAag/HF41rmv59gh8Hv4I
 HrFECTZOIjmDQ8c56kFNDKXPn+vpPOvG+jTYcGDkgeRV+RwqAftKuM2BnEbsKMr/syfGU+9fDhP
 OPasU
X-Gm-Gg: AeBDietSLYH/HONXSf0tarajmYco1O7zik3bjDzEN/06juhmFuOahGbPdT/WjEf8ZSy
 ggxLHe3Xt2PzUhl6bWqy5UtZ0tkROPUv7U9O2vDwPJ+UvuNQy6H3QD0l8WacPJkUcuzNupddzBq
 MqctBUmvv+OTRUrf2BZ4akkSYL+ClK65Q+k22qDkrCCNvKGucfdoake1MduQmbZ+7d/mgW4k/x6
 x7EyWFhmLGi+9851YRb9jYRHaa2BG260NHUoj6yESdxRBz6WRD5xFyJd+uXgm6OyuoRPR/OmN7T
 Lz1PpBMprY6qCxyz8lRgziZYANvNjWcASkprCTpN+stk0Pr1Yv0YvcOjRfLdxvTFLSKP1rNczA0
 QrquEjTlVju1/FTtn5sfuqeydVZaTmu/Y5tw4Lq0BCdfju5LwTCJ/FwU19epcUoffOZmpX4ixJJ
 Fg41Hit1effc4vzlBqh7VS8JcYMoogUoa8lW6gQHSym0sstG4s/vPqMfZ3VDqOXjVRAXJchk1d+
 RRsC9HrhfPMWz88n7SStaTRSACOMiXiT/ZeRSTRyQ==
X-Received: by 2002:a05:600c:1907:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-48a83d6ee9dmr110383975e9.9.1777630530969; 
 Fri, 01 May 2026 03:15:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/28] hw/arm, target/arm: nested virtualisation on HVF
Date: Fri,  1 May 2026 11:14:55 +0100
Message-ID: <20260501101505.3485916-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Add hvf_arm_el2_supported for querying EL2 availability.
An hvf_nested_virt_enable workaround is added as nested virt has
to be enabled early on HVF.

And adds hvf_nested_virt_enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260429190532.26538-6-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c    |  6 ++++++
 accel/stubs/hvf-stub.c | 11 +++++++++++
 hw/arm/virt.c          |  5 +++++
 include/system/hvf.h   |  5 +++++
 target/arm/hvf/hvf.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index add265e0c8..da29aa3aa3 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -24,6 +24,12 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
+
+void hvf_nested_virt_enable(bool nested_virt)
+{
+    hvf_nested_virt = nested_virt;
+}
 
 const char *hvf_return_string(hv_return_t ret)
 {
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index 6bd08759ba..7643e8c5f5 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -11,3 +11,14 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
+
+void hvf_nested_virt_enable(bool nested_virt)
+{
+    /*
+     * This is called unconditionally from hw/arm/virt.c
+     * because we don't know if HVF is going to be used
+     * as that step of initialisation happens later.
+     * As such, do nothing here instead of marking as unreachable.
+     */
+}
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 47400214a2..ca50411020 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2987,6 +2987,11 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     vms->virt = value;
+    /*
+     * At this point, HVF is not initialised yet.
+     * However, it needs to know if nested virt is enabled at init time.
+     */
+    hvf_nested_virt_enable(value);
 }
 
 static bool virt_get_highmem(Object *obj, Error **errp)
diff --git a/include/system/hvf.h b/include/system/hvf.h
index dc8da85979..a961df8b95 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -28,11 +28,16 @@ extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
 extern bool hvf_kernel_irqchip;
 #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
+extern bool hvf_nested_virt;
+#define hvf_nested_virt_enabled()  (hvf_nested_virt)
 #else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
 #define hvf_irqchip_in_kernel() 0
+#define hvf_nested_virt_enabled() 0
 #endif /* !CONFIG_HVF_IS_POSSIBLE */
 
+void hvf_nested_virt_enable(bool nested_virt);
+
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
 typedef struct HVFState HVFState;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a028c99e24..09f41094e5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -27,6 +27,7 @@
 #include "system/memory.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
+#include "hw/arm/virt.h"
 #include "qemu/main-loop.h"
 #include "system/cpus.h"
 #include "arm-powerctl.h"
@@ -1103,6 +1104,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                      (1ULL << ARM_FEATURE_PMU) |
                      (1ULL << ARM_FEATURE_GENERIC_TIMER);
 
+    if (hvf_nested_virt_enabled()) {
+        ahcf->features |= 1ULL << ARM_FEATURE_EL2;
+    }
+
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
@@ -1218,6 +1223,19 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
+static bool hvf_arm_el2_supported(void)
+{
+    bool is_nested_virt_supported;
+    if (__builtin_available(macOS 15.0, *)) {
+        hv_return_t ret = hv_vm_config_get_el2_supported(&is_nested_virt_supported);
+        assert_hvf_ok(ret);
+    } else {
+        return false;
+    }
+    return is_nested_virt_supported;
+}
+
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
@@ -1229,6 +1247,20 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    if (__builtin_available(macOS 15.0, *)) {
+        if (hvf_nested_virt_enabled()) {
+            if (!hvf_arm_el2_supported()) {
+                error_report("Nested virtualization not supported on this system.");
+                goto cleanup;
+            }
+            ret = hv_vm_config_set_el2_enabled(config, true);
+            if (ret != HV_SUCCESS) {
+                error_report("Failed to enable nested virtualization.");
+                goto cleanup;
+            }
+        }
+    }
+
     ret = hv_vm_create(config);
     if (hvf_irqchip_in_kernel()) {
         if (__builtin_available(macOS 15.0, *)) {
@@ -1420,6 +1452,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
     assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
 }
 
+static int hvf_psci_get_target_el(void)
+{
+    if (hvf_nested_virt_enabled()) {
+        return 2;
+    }
+    return 1;
+}
 /*
  * Handle a PSCI call.
  *
@@ -1441,7 +1480,6 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     uint64_t entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_arm_psci_call(param[0], param[1], param[2], param[3],
@@ -1495,7 +1533,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
         entry = param[2];
         context_id = param[3];
         ret = arm_set_cpu_on(mpidr, entry, context_id,
-                             target_el, target_aarch64);
+                             hvf_psci_get_target_el(), target_aarch64);
         break;
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
-- 
2.43.0


