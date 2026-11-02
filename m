Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93360A3808
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cumkbECG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDT-0004Hd-MC; Mon, 02 Nov 2026 08:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDA-0003Ms-AH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:34 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD8-0002Jz-8B
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:32 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1655275f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626589; x=1794231389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aAtq2+DRw/kNlpvv8Go3OvNCyJm7o7aDW7YY9zZnYGU=;
 b=cumkbECGgM+RiAIOam8cE7qprjFt3DcZ5veWGyWbUb3Fv7+999+MMkc8ihFxlevjO+
 n4VNNgFu9SN/0MNyJV2RB2wpNTDnoU+8JtOtgRPl+IBKc3/wPY7XbZuboacRg+yGqywk
 jjLu4ThGL+Ruf3lmOkqn0xBamwzPzHwWu+D1GBVXaZjdUiOZYR1gyuazWAz9WMlFrxWZ
 DyHvSmAkNtDnRr2aRbHpBysIOlMx8SuVIdm1EA5jfIi9AEfYo3qdBAvAWu/1u2uezD62
 w6ZG10eHWP+WtqN4A4Y2XKhT1H1CX+KE3qkBkShC4RDx9pmAcsWvmcYOmPqArw5svxWV
 8/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626589; x=1794231389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aAtq2+DRw/kNlpvv8Go3OvNCyJm7o7aDW7YY9zZnYGU=;
 b=plQptGC/hnVMplEaRGJyIV1aA6XyH6HE0PJH4Lf+U+CPKBNbgCKAn5c5LzJNFWF1gq
 Akjg17tvW0UEm+8JscgrJr0rhjnFlkjgSxGWoGx3O9y0zKA7Mi906nXk52HuLbNOQh67
 tFoQvUJ0i2jrqKJDoASI8R37scBav2xeLZiKxN3zhTPWbMidZD3A/MInmvCjpfc0CNSU
 TBUYFFCeRS/+o5ckgb91ZjChwMrjOBtIvD4/CUCzxhXHi04XmQa2PkFAtFrYD/tfGwi/
 Lzi1ciehB3vlYwKXolCspv/29C56929hc0yl8F9UnTo6oe6ey0m+XCheo7G0egW8wXUR
 0esg==
X-Gm-Message-State: APuU4Z+KHq71Nofvx93L7JKgteFNeox1N9elzYxatNUmFF9x5+F2k0T0
 GfFElwczCdei0+ZwW+KuNiunmK+ql2KWg9A3XQdnRpi1RO/su4VPWzyVVUwjOke5pAoHgCxT+XM
 tB0qtIMc=
X-Gm-Gg: AYBFou0a1rzILcrJRtijo6FJYmwAwmbBb8219Cr7p1+OY/Pt0sqsUvyR2TcDu2clsmz
 0svw49WPZGn5qmDLqbzK7ND3QXwgUQxW13TtYDs2ifPTeg9HPvwfKd+mc/nA3Yul+/9987CZyTn
 PEqd865HL8J8FSCemoY7ZKXajM7HvU5oNdKWC7AcN7rCk3pATPb8VsZvCFZ87KUbvQLsrK/2eP8
 KJY7ewT1EiUrJRZx73UXMam1q6T9fddTp+yBx0fKrH3pyFO2Np2G6x/0d+w8gQNOgJJtdmt1OB4
 AZi58M7mK3OObR4fKMQHTrQlMaJNPq9riKgwRt+ITTL9lFtUd+FvkMX6gEOpV/ebrY8U61VTaK9
 XwJQiUYhL+LrKgfvI5FaB7gyOJzmtMhw+lO7pF9DgMj2Co115TqBcQkqLejBNxExUZ9XbxE0BrT
 alPuHt6mcc2gtrKrpLyQPdQoNIduM0LxQyrjhaG7yWCKNCCJdRqfI/dJYuJ92kwe3catJvoRMjK
 r1Q4e/Dg10orRJQrhUSfrS8ZhGN2zzvs488LClyZrTzsy+hkWmDmEWReirWJV5HEU3qoCE8XSiD
 asC9ZU0OIXJIKKweBWVE5iVbnoLpOsBgOLH0W0CMSeSpSTZCIED9imSSXTQG1fdQdiWy4XTp6Tg
 gMzu8RXDbDJPeNG/DWswKpT2eusXJb7nUgHfs/bPXSRfLX9Q9td3+haw=
X-Received: by 2002:a05:6000:2311:b0:48a:f320:dba0 with SMTP id
 ffacd0b85a97d-48e6e4ffa7bmr22635399f8f.45.1793626588864; 
 Mon, 02 Nov 2026 05:36:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/47] target/arm/kvm: Improve error handling on scratch vcpu
 probe
Date: Mon,  2 Nov 2026 13:35:35 +0000
Message-ID: <20261102133547.1375701-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

Pass an error handle to both kvm_arm_create_scratch_host_vcpu()
and kvm_arm_get_host_cpu_features(). This allows to improve the
error reporting on kvm_arm_set_cpu_features_from_host().

If any, the error is stored in the new cpu->host_cpu_probe_err
field and further propagated on realize().

In arm_gic_cap_kvm_probe() call path we just pass a NULL error handle
to kvm_arm_create_scratch_host_vcpu because we don't care about the
failure nature and just want to revert to emulated versions if it
fails.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261030131406.461599-11-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  3 ++-
 target/arm/kvm.c     | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003e..9c7e7f654a0 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -105,6 +105,7 @@ struct kvm_vcpu_init;
  * @init: filled in with the necessary values for creating a host
  * vcpu. If NULL is provided, will not init the vCPU (though the cpufd
  * will still be set up).
+ * @errp: Error handle
  *
  * Create a scratch vcpu in its own VM of the type preferred by the host
  * kernel (as would be used for '-cpu host'), for purposes of probing it
@@ -114,7 +115,7 @@ struct kvm_vcpu_init;
  * false on failure (and fdarray and init are not valid).
  */
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
-                                      struct kvm_vcpu_init *init);
+                                      struct kvm_vcpu_init *init, Error **errp);
 
 /**
  * kvm_arm_destroy_scratch_host_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f9c75774605..b66eb4f6c24 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -62,6 +62,7 @@ typedef struct ARMHostCPUFeatures {
     uint32_t target;
     uint32_t sve_vq_supported;
     const char *dtb_compatible;
+    Error *probe_err;
 } ARMHostCPUFeatures;
 
 static ARMHostCPUFeatures arm_host_cpu_features;
@@ -104,13 +105,14 @@ static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
 }
 
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
-                                      struct kvm_vcpu_init *init)
+                                      struct kvm_vcpu_init *init, Error **errp)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
     int max_vm_pa_size;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
+        error_setg_errno(errp, errno, "Failed to open /dev/kvm");
         goto err;
     }
     max_vm_pa_size = ioctl(kvmfd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_IPA_SIZE);
@@ -121,6 +123,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
         vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
+        error_setg_errno(errp, errno, "Failed to create the scratch VM");
         goto err;
     }
 
@@ -140,6 +143,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 
     cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
     if (cpufd < 0) {
+        error_setg_errno(errp, errno, "Failed to create the scratch VCPU");
         goto err;
     }
 
@@ -153,12 +157,16 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 
         ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
         if (ret < 0) {
+            error_setg_errno(errp, errno,
+                             "Failed to get the preferred KVM target");
             goto err;
         }
         init->target = preferred.target;
     }
     ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
     if (ret < 0) {
+        error_setg_errno(errp, errno,
+                         "Failed to initialize the scratch VCPU");
         goto err;
     }
 
@@ -312,13 +320,19 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
 }
 
-static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+/**
+ * kvm_arm_get_host_cpu_features:
+ * @ahcf: host CPU feature struct to populate
+ * @errp: error handle
+ *
+ * Identify the feature bits corresponding to the host CPU by creating a
+ * scratch VM/vCPU and querying its ID registers.
+ *
+ * On failure, @ahcf->target is QEMU_KVM_ARM_TARGET_NONE and *errp is set
+ * On success, @ahcf->target is set to a valid KVM target.
+ */
+static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf, Error **errp)
 {
-    /* Identify the feature bits corresponding to the host CPU, and
-     * fill out the ARMHostCPUClass fields accordingly. To do this
-     * we have to create a scratch VM, create a single CPU inside it,
-     * and then query that CPU for the relevant ID registers.
-     */
     int fdarray[3];
     bool sve_supported;
     bool el2_supported;
@@ -330,6 +344,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->dtb_compatible = "arm,armv8";
 
     if (!kvm_enabled()) {
+        error_setg(errp, "KVM is not enabled");
         return;
     }
 
@@ -371,7 +386,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         features |= 1ULL << ARM_FEATURE_PMU;
     }
 
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, errp)) {
         return;
     }
 
@@ -502,6 +517,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
     if (err < 0) {
+        error_setg(errp, "Failed to read some host CPU ID registers");
         return;
     }
 
@@ -528,7 +544,8 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
 
     if (!arm_host_cpu_features.dtb_compatible) {
-        kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
+        kvm_arm_get_host_cpu_features(&arm_host_cpu_features,
+                                      &arm_host_cpu_features.probe_err);
     }
 
     cpu->kvm_target = arm_host_cpu_features.target;
@@ -538,8 +555,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
          * We can't report this error yet, so flag that we need to
          * in arm_cpu_realizefn().
          */
-        error_setg(&cpu->host_cpu_probe_err,
-                   "failed to retrieve host CPU features");
+        cpu->host_cpu_probe_err = error_copy(arm_host_cpu_features.probe_err);
         return;
     }
 
@@ -2674,7 +2690,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 {
     int fdarray[3];
 
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL, NULL)) {
         return;
     }
 
-- 
2.43.0


