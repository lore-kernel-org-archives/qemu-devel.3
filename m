Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB6606A32A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aNq2+oHV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUl3I-00018C-0Q; Sat, 21 Nov 2026 08:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUhpx-0000PG-FR
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 04:56:52 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUhpv-0001ZI-5B
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 04:56:49 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e47347279so953908f8f.1
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 01:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795255006; x=1795859806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KpSc8oFSWfDhChfwfvA3T6eA6YVTi/ttjYcDRRXG5D0=;
 b=aNq2+oHVEL05B226PfvbTmpDx7PRmQXHvGrppuciNIU+pocYXrZTeHNFgAs25ySkFj
 yYUGEUZuUWnmh8XzvkuftXxl6/jwC2s6fTOnmAEw0sCryYK83lxn8KksDC2iTUe3m3Lr
 kWowE3t1ICPZh7Z+z/jHmFtbQ46VWjpjGCYJ+RjqQM1rvr838q9r0u9ahGonNrd8tLi8
 k+1EcSz4vzpAZ44gXj6DTnZ/xs4CD5nW1Pb0henTmRrYFkDjLyED6emPCWsJRCJUV7IO
 VfB07Q8SXHR/4lSWMKu6onwkRkhg/K1we3Hr/1YHjn9I5IzGuF9iVFJh8nFEuNF2rnnF
 E8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795255006; x=1795859806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KpSc8oFSWfDhChfwfvA3T6eA6YVTi/ttjYcDRRXG5D0=;
 b=kSirIEAiYOSyUqsNNjnp61DDoPunls0QOs6WZCGRYZOfdZgVGkURud/+S8QY+akd9z
 GRclRDMyu5VgavxDDBzgJYfi2NuhopBoHu4apTGUsKCT9Y6XrLuVxc/ggN9e0cKH7kta
 u6/X3/OYKJt1b226vqLl4pDwJif008TacNQvqq89JrD/87n8n5oT89ooJu1YqIerSVDS
 iCHGTnLBgm2cK7oenkYGx6cdJayOdAHgawVta5jXkwCKOxKdIP0BpobsnoqN/fJcHPAi
 I5Sa6TfxOlBH714SoVwGHxC+OLLBPWAm0HJGPkrH08QCStVvPS1GIprOtmv1WQbtfQiR
 J5hw==
X-Forwarded-Encrypted: i=1;
 AL+hErEVX/oS50RmBmTpivlhLXDhNqXsks6sUpOQ+JcCM3xfHVhmS/t97L2LWUzeC4gg4M2I/dGvPQ1f8nGk@nongnu.org
X-Gm-Message-State: APuU4Z/yyroFJN7TTXLSUIuTtSmH1N9QJUis32VSkIqwBEERAuZr6MF/
 XgZ7maUijbIbIyAPCObP3PLev63wt5L5wu69bVuv8MAe3U2yHUNdGHDQ
X-Gm-Gg: AZFdTZcQ/s/nxdp12YcmArTuyCAFxOawJx8pZ+xa7luOHCw08Oj0cJ0G8UM49S9T2Gb
 40sD39lUDv5nKiG4qh6gZDbXPabmvaxCNeCzC6iQrBCV3Aw/0UevL2C8TFgHPlXtgX3NqJ/VPjL
 zsXyOcOptaD7X35M2mdC/YhcWO1wEEnqtqYyPp9Uo83smENh4loZ44yxah10tbxuMni0Fps767q
 94os4n5V3iTi98hWIL0NyGMuefAoRDzLXHJpaeX49Oly2VzAY3YHFxF9BLc6UlfRelO0gm8H/rj
 mVYyvwlbr2AOzjBytut1GolzWHhONVhuqdW986BPjCt8R8fsS6OTputWuuEjpSLOVCEUlqYluEI
 4WxdgjE9Fn18mcbtPnxDPU4qn+7ikh+oQeflAx3zAJoSpSwKudVMQl2pO0y1KKiLw4RtL4Tgten
 wb8jsiGaMnaiH2sMWabyslSRppFRiQIzg0jvQ+rVzSFm6+vyf9PbXe4RZCbNgfHXfk0+J7LUGCC
 LEEbEMMsOqXvMUCf1Dp7fYgb0QBofZXii4EzojRs3s5YZFsJIcCdZEB6cdAd6jZ9BUGDwm6faug
 zcFADmBY0ld0VLElEze3asm6iLQvoP+RriRBJFpiffRRknfF8T9U5mO96JaQjJP6kpqevpAquQY
 tKo4zce5nYr5blcfOYGE1j5ZisltBQNyNu/8BVM8mqDxt2w==
X-Received: by 2002:a05:6000:470b:b0:4a6:ac28:eb57 with SMTP id
 ffacd0b85a97d-4abb3678d7cmr12718027f8f.17.1795255005571; 
 Sat, 21 Nov 2026 01:56:45 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2e6dsm10741748f8f.6.2026.11.21.01.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 01:56:45 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <volodymyr.babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH 1/1] hw/arm/virt: add vhe option for nested virtualization
Date: Sat, 21 Nov 2026 14:56:36 +0500
Message-ID: <20261121095636.289814-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121095636.289814-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 21 Nov 2026 08:22:46 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Add a vhe machine property for the virt board. When virtualization=on,
VHE remains enabled by default, but vhe=off allows nVHE/type-1 guest
hypervisors to run without VHE.

Propagate the setting to the ARM CPU, limit TCG to nVHE mode, and request
the KVM_ARM_VCPU_HAS_EL2_E2H0 vCPU initialization flag when VHE is
disabled. Reject vhe=off when the selected accelerator cannot provide
the requested behavior. The option has no effect unless
virtualization=on is also set.

Document the option, and make the nested virtualization functional test
pass a vhe setting matching the kernel mode.

Tested nested virtualization with KVM on arm64 hosts using L0 kernel
versions 6.18.29 and 7.2.11. A Linux 6.12.67 guest initialized KVM in
nVHE mode with vhe=off and VHE mode with vhe=on. QNX Hypervisor 8.0.5
detected EL1 host hypervisor support with vhe=off and EL2 host
hypervisor support with vhe=on. Xen booted dom0 to the login prompt with
vhe=off, but did not boot with vhe=on.

Tested with TCG on an AmpereOne A192-32X host. QNX Hypervisor 8.0.5
boots with both vhe settings, and Xen boots its dom0 with vhe=off.

Suggested-by: Volodymyr Babchuk <volodymyr.babchuk@epam.com>
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 docs/system/arm/virt.rst             | 10 ++++++++
 hw/arm/virt.c                        | 37 ++++++++++++++++++++++++++++
 include/hw/arm/virt.h                |  1 +
 target/arm/cpu.c                     | 15 +++++++++++
 target/arm/cpu.h                     |  2 ++
 target/arm/kvm-stub.c                |  5 ++++
 target/arm/kvm.c                     |  8 ++++++
 target/arm/kvm_arm.h                 | 12 +++++++++
 tests/functional/aarch64/test_kvm.py | 10 +++++---
 9 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd17978..31f0878788 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -116,6 +116,16 @@ virtualization
   Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
   Arm Virtualization Extensions. The default is ``off``.
 
+vhe
+  Set ``on``/``off`` to allow/disallow a guest hypervisor to use the Arm
+  Virtualization Host Extensions (``FEAT_VHE``) when ``virtualization`` is
+  ``on``. The default is ``on``, which places no restriction on the selected
+  CPU model (it does not add VHE to a CPU model which lacks it). ``off``
+  exposes EL2 in nVHE mode for a type-1 guest hypervisor: with TCG this hides
+  ``FEAT_VHE``, with KVM it requires host ``E2H0`` support, and it is not
+  supported with HVF. This option has no effect when ``virtualization`` is
+  ``off``.
+
 mte
   Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
   Arm Memory Tagging Extensions. The default is ``off``.
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b11f7e328..1a987faa19 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3025,6 +3025,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->virt && !vms->vhe && hvf_enabled()) {
+        error_report("mach-virt: %s does not support disabling VHE",
+                     current_accel_name());
+        exit(1);
+    }
+
     if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
@@ -3069,6 +3075,10 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
+        if (vms->virt && object_property_find(cpuobj, "has_vhe")) {
+            object_property_set_bool(cpuobj, "has_vhe", vms->vhe, NULL);
+        }
+
         if (vmc->no_kvm_steal_time &&
             object_property_find(cpuobj, "kvm-steal-time")) {
             object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
@@ -3308,6 +3318,20 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
     hvf_nested_virt_enable(value);
 }
 
+static bool virt_get_vhe(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->vhe;
+}
+
+static void virt_set_vhe(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->vhe = value;
+}
+
 static bool virt_get_highmem(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -4235,6 +4259,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Virtualization Extensions");
 
+    object_class_property_add_bool(oc, "vhe", virt_get_vhe,
+                                   virt_set_vhe);
+    object_class_property_set_description(oc, "vhe",
+                                          "Set on/off to enable/disable the ARM "
+                                          "Virtualization Host Extensions (applicable "
+                                          "only when virtualization=on)");
+
     object_class_property_add_bool(oc, "highmem", virt_get_highmem,
                                    virt_set_highmem);
     object_class_property_set_description(oc, "highmem",
@@ -4375,6 +4406,12 @@ static void virt_instance_init(Object *obj)
     /* EL2 is also disabled by default, for similar reasons */
     vms->virt = false;
 
+    /*
+     * VHE is unrestricted by default when virtualization=on is set.
+     * With vhe=off, EL2 is limited to nVHE mode.
+     */
+    vms->vhe = true;
+
     /* High memory is enabled by default */
     vms->highmem = true;
     vms->highmem_compact = !vmc->no_highmem_compact;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a11..bd0065efb1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -174,6 +174,7 @@ struct VirtMachineState {
     bool highmem_redists;
     bool tcg_its;
     bool virt;
+    bool vhe;
     bool ras;
     bool mte;
     bool dtb_randomness;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dde03ffdd6..4d272b5388 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1326,6 +1326,9 @@ static const Property arm_cpu_reset_hivecs_property =
 static const Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
+static const Property arm_cpu_has_vhe_property =
+            DEFINE_PROP_BOOL("has_vhe", ARMCPU, has_vhe, true);
+
 static const Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
 
@@ -1622,6 +1625,7 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vhe_property);
     }
 #endif
 
@@ -1872,6 +1876,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (cpu->has_el2 && !cpu->has_vhe && kvm_enabled() &&
+        !kvm_arm_el2_e2h0_supported()) {
+        error_setg(errp, "KVM does not support disabling VHE (E2H0 "
+                   "unavailable)");
+        return;
+    }
+
 #ifndef CONFIG_USER_ONLY
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
@@ -2246,6 +2257,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         unset_feature(env, ARM_FEATURE_EL2);
     }
 
+    if (cpu->has_el2 && !cpu->has_vhe && tcg_enabled()) {
+        FIELD_DP64_IDREG(isar, ID_AA64MMFR1, VH, 0);
+    }
+
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
     }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b2f393f501..2f94fdae7b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1022,6 +1022,8 @@ struct ArchCPU {
     bool has_el2;
     /* CPU has security extension */
     bool has_el3;
+    /* CPU has virtualization host extensions */
+    bool has_vhe;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
     /* CPU has VFP */
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c..6eb9e1366a 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,11 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index df86ad387c..6b95ed1da8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2003,6 +2003,11 @@ bool kvm_arm_el2_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
+}
+
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
@@ -2060,6 +2065,9 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
     }
     if (cpu->has_el2 && kvm_arm_el2_supported()) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
+        if (!cpu->has_vhe) {
+            cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2_E2H0;
+        }
     }
 }
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9c7e7f654a..24828e9c07 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -182,6 +182,13 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+
+/**
+ * kvm_arm_el2_e2h0_supported:
+ *
+ * Returns true if KVM supports limiting EL2 to E2H=0, and false otherwise.
+ */
+bool kvm_arm_el2_e2h0_supported(void);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -198,6 +205,11 @@ static inline bool kvm_arm_el2_supported(void)
 {
     return false;
 }
+
+static inline bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
 #endif
 
 /**
diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index c977e8c6d2..502060a109 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -40,7 +40,9 @@ def _launch_guest(self, kvm_mode="nvhe"):
                                f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
 
         self.vm.add_args("-cpu", "max")
-        self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
+        vhe = "on" if kvm_mode == "vhe" else "off"
+        self.vm.add_args("-machine",
+                         f"virt,gic-version=3,virtualization=on,vhe={vhe}",
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.add_args("-smp", "2", "-m", "320")
@@ -48,8 +50,10 @@ def _launch_guest(self, kvm_mode="nvhe"):
         try:
             self.vm.launch()
         except VMLaunchFailure as excp:
-            if "does not support providing Virtualization" in excp.output:
-                self.skipTest("accelerator has no virtualization support")
+            if ("does not support providing Virtualization" in excp.output or
+                    "does not support disabling VHE" in excp.output):
+                self.skipTest("accelerator lacks the required virtualization "
+                              "support")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
-- 
2.34.1


