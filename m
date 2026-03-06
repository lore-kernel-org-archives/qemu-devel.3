Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E342DFCB609
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfk-0005Dm-IB; Fri, 06 Mar 2026 10:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfN-0004nc-G9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfG-0002n2-OB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:33 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso138535205e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809229; x=1773414029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NYfcTASzTUjQga6ta8+6fIUOjAslm4LSCPa4gm5Bf28=;
 b=vb5AYnB3Ibnpr8amQjhpPX02+DP7+lF+Nh4nqRjuulZFZksY/7gDLeJRAIUs9U0JkM
 hVca/WeY+r6yhocznDav/1kksDcGIhzpQAaQQ/lDt1Wy1iqvftX3Jj2JGrVQeA9VFMz7
 8JX4ecBSgshHR3tRNYBUdZg3JhUGZm0ix3v4LsTE0zx8r4iFhmxfqI1WZMVLPIqCEOLF
 uBHeYRV++kAdsS+Ft0UhtMJiX2XNH24ZO4auC8asmJqFzjw4UPLNiu4bL46cUfVOz9g7
 WKLdRTp1gnGHwyiXqO9pHY1NWJ4xmyeiw9DTJfEXoqoN7sUm3TlwgkWhdguXUAvz4hjT
 uzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809229; x=1773414029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NYfcTASzTUjQga6ta8+6fIUOjAslm4LSCPa4gm5Bf28=;
 b=LvqoQBDhatqbRIBm9GghYxh8HuPnAxneE4uSA3KK2opkgMUABDNa8dxe3YIJThsOf7
 2QklvJDj4/F+oQqS/MDVQ9K5znh4PGIWE3DfHg0Ba3v3IUl64dW8+fhLA1snACklHfIL
 p2P4uhNJnQYXqgyylWc68NdPbEIfmSMkgK8lVGyfLzIEUaOLDOIOUCJH2NSO36BkkC6u
 QhQiQR5GLdRciLI6TDyfMURhn/rAeJQMs+U9a03tR2OVCkwG7Zn/VOkL4VurXbDx31tk
 aOklmon2rjfrZFypKJnSqrYjxPErBUWbohRsSowhLHZ+fypCwwpLT4UI71MrzLfRve2z
 uhGA==
X-Gm-Message-State: AOJu0YwOKDa4WMuVv8drW5dZE0szBcljpvifvnW4mLyyAhEUObVOAeOd
 xWrbjSmxmh3Mqtegs5fvwCmomGGJxQfsY1fMsu7OvydguJB41+Z3RppdmkgnncHO8KQDJ3Ud/x2
 u0oES
X-Gm-Gg: ATEYQzxgoiJTnUt3k2ooSnYuF85VPCEQ6ESfBTy2x0UN6EtYLGytQFNvpaoSEwUhjeY
 NGt5pmIagB81eR3sxYc4C+4CsL3rRnsgDd71vwDAMQH/ZMe9Wav5YkFoNxOx+UY53UkLlssq3wu
 ivnM3Tls2a2ahh1Hn9qT7/SZ4TtEh35EcDkyE+V4wmkfS7mJRN4n2NGwFGJe1X2Z5R3pXw/GF6n
 xR/BUmmya4zMuvdMRopZWIEcjC9R2cvWv+KBOmskCEII6nDB9uAj4yIgKkSveV01VbOTU4XvAFo
 2gEo2jyXFCd4WHdm2HL5/kxyVxelKoJNjhoCumFF7tp1cHedBUG6Nav7HOVbipm3Yv7Uvx0Mt0H
 60C0GuborDhw3XKCMb2NKfLMVPudTInrFLH0RQwvTdhpu84ofz5d3YCNETJZd6vbpu/7mXW7Qu5
 SWDNex3GqLVbZR4zlJZNwd8eXaPKYMY+xJCZqYJM0kQOpx8T3rrGdbcDWgDEx922j8fz02mKQQM
 pTZcud3AEvFx67oDuZ6JFoaKwy7Ryk=
X-Received: by 2002:a05:600c:468c:b0:483:4a95:66da with SMTP id
 5b1f17b1804b1-4852692438emr41404825e9.13.1772809228833; 
 Fri, 06 Mar 2026 07:00:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/49] hw/arm, target/arm: nested virtualisation on HVF
Date: Fri,  6 Mar 2026 14:59:31 +0000
Message-ID: <20260306145939.2162189-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-10-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c    |  1 +
 accel/stubs/hvf-stub.c |  1 +
 hw/arm/virt.c          |  5 +++++
 include/system/hvf.h   |  5 +++++
 target/arm/hvf/hvf.c   | 36 ++++++++++++++++++++++++++++++++++--
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index a296b108bc..1c1437b467 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -24,6 +24,7 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
 
 const char *hvf_return_string(hv_return_t ret)
 {
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index 6bd08759ba..cec1cbb056 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -11,3 +11,4 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a6fad1094..90769936d0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2661,6 +2661,11 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
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
index dc8da85979..0f0632f7ae 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -28,9 +28,14 @@ extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
 extern bool hvf_kernel_irqchip;
 #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
+extern bool hvf_nested_virt;
+#define hvf_nested_virt_enabled()  (hvf_nested_virt)
+#define hvf_nested_virt_enable(enable) hvf_nested_virt = enable
 #else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
 #define hvf_irqchip_in_kernel() 0
+#define hvf_nested_virt_enabled() 0
+#define hvf_nested_virt_enable(enable) 0
 #endif /* !CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1c45125036..35b2de7b7a 100644
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
@@ -1218,6 +1223,15 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
+static bool hvf_arm_el2_supported(void)
+{
+    bool is_nested_virt_supported;
+    hv_return_t ret = hv_vm_config_get_el2_supported(&is_nested_virt_supported);
+    assert_hvf_ok(ret);
+    return is_nested_virt_supported;
+}
+
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
@@ -1229,6 +1243,18 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    if (hvf_nested_virt_enabled()) {
+        if (!hvf_arm_el2_supported()) {
+            error_report("Nested virtualization not supported on this system.");
+            goto cleanup;
+        }
+        ret = hv_vm_config_set_el2_enabled(config, true);
+        if (ret != HV_SUCCESS) {
+            error_report("Failed to enable nested virtualization.");
+            goto cleanup;
+        }
+    }
+
     ret = hv_vm_create(config);
     if (hvf_irqchip_in_kernel()) {
         /*
@@ -1414,6 +1440,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
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
@@ -1435,7 +1468,6 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_arm_psci_call(param[0], param[1], param[2], param[3],
@@ -1489,7 +1521,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
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


