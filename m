Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C185AC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpwQ-0006rm-Pm; Fri, 01 Aug 2025 09:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUU-0004x2-0i; Fri, 01 Aug 2025 03:47:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shameerkolothum@gmail.com>)
 id 1uhkUS-0007mD-1r; Fri, 01 Aug 2025 03:47:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b785a69454so282335f8f.2; 
 Fri, 01 Aug 2025 00:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754034462; x=1754639262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McuX8ddB1qy3M8rDtLBmAXapnNFyt1WXwwwCGHWX4bI=;
 b=faIvZt14Z+CmHUqjTbCK96J2UrQtXzQe4VsfffcuEBKVs3nGBXT+yJAHmuMgo2YXc3
 Mxm9XxMogz4speJziNiAZQWBkNPGVTCzddR8/O/TgrxdWlGGFhq9whsjC/LMiE+wvp7j
 ZdukxBY+urhzaa4et8yYctjxD8Ua88cHlxplf3EVg+1bpXcgoUACjfy9TZgeU+NTwxWd
 H+2aPoh1X4i7EGtwgOox/EvDRUzn9JZs4xLpj9mCA9qTGohYlSoBARgqi+wb/vOhRjR2
 lJBW/Z0+Qcz3WPUhPeUyY6/6RRZuHYUeTtsqQt0IdcYU92PZ35BiS4VbfwwaHoAFlX1i
 KGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754034462; x=1754639262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McuX8ddB1qy3M8rDtLBmAXapnNFyt1WXwwwCGHWX4bI=;
 b=fqbk0K/HReaU8MoABpKV6Ga2KFsNDQIeJFzTxsZhwlNiRXTOr7TdBLroc6d490/1eB
 zPTBGhPf1lLaoSjveoO4J0b8ugwhuBpGQOf/lrO2m28OHJwt9s8+HqzH7JLdkPVOWtQM
 22r/SkLU1IY/WxMN70FUmqJpxkZKlKoanj+a1i9mq7zEKGbhKswKHuNxVFbtHcx6kn+J
 xtKVs+C3TDu0Z8+Rxp0fw5aw9vHBItdoYuhDja/u0clQsSATzYG7/bNe/a2mBydk84o6
 XtX5cMudd3JQ0O6saMpoIJu3KXaGsly23JxZKAD4z5VWs812mWcECXqbpIFM6NXiLG7T
 GMtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqYLTvjZ7LfgujPdMWcVrc6CExDk758ocd/glPv8g84RCra+Cs9OX4/xT8WKgoghEfJjGCGlhah/Nv@nongnu.org
X-Gm-Message-State: AOJu0Yx26MuP76qX7E2pCZ2nOhdWQ1YSQ7RRJ1u5U/YshC8CsQjkJNWX
 xjo0FLCbiobzklz9Q7p5LXFBftMVkoUbPVQ/SH7a+WxiPWxRwCaFwF3c/T5Rug==
X-Gm-Gg: ASbGncvSQeJlxytWzBmA8SBqu+W89xb5FaeH99NxvomQ7CQRRx2eqWDPY1wvR2vP/D3
 Bm4UHL7paJBD+O40BdeP7Q1A7vdujODgqnMv6azvQ3PoO7AeeVCptzp2tVaw6NMmaDZUruXNGeq
 E8i/jRnNmNf2DcoTxu04CCBy1p7s0dURIcKpFzivp6+swBxdoK64NLI8h96VpQt/xQhZCzWFbPD
 opRlfYDMRIzBoqtSJJMVejt5pJD3myYsbUL2v+71IRvUg9cPNVr5wRcecwF+IjCkpx3zSwncaqt
 PboRQL5DirCZKZIAfBX1r5Lg4opW/5JXMTy6xcYjBiO/byyUWMh5U3e0qK4yIlVJM8tfS6imI2x
 qN3ryzPuabpoWLQLEfe4n1fY+hnbXl8Z8dA==
X-Google-Smtp-Source: AGHT+IEBuNTbMQISMk/N4fyUKZXFcqvac6MHhDlVk8lfoOD/EB+WgDT2kLJ8nLpzu3Bnv9gJd84LOQ==
X-Received: by 2002:a05:6000:3108:b0:3b8:d115:e6c7 with SMTP id
 ffacd0b85a97d-3b8d115e95amr2686077f8f.33.1754034461570; 
 Fri, 01 Aug 2025 00:47:41 -0700 (PDT)
Received: from shameer-ubuntu ([195.11.233.227])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm5049185f8f.44.2025.08.01.00.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 00:47:41 -0700 (PDT)
From: Shameer Kolothum <shameerkolothum@gmail.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, berrange@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, armbru@redhat.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com,
 yangjinqian1@huawei.com, shameerkolothum@gmail.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [RFC PATCH RESEND 1/4] target/arm/kvm: Introduce helper to check
 target impl CPU support
Date: Fri,  1 Aug 2025 08:47:27 +0100
Message-ID: <20250801074730.28329-2-shameerkolothum@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801074730.28329-1-shameerkolothum@gmail.com>
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shameerkolothum@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 01 Aug 2025 09:35:51 -0400
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

The helper function will try to set the SMCCC filters for KVM vendor
hypercalls related to target implementation CPU support. It also
checks the kernel support for writable implementation ID registers
(MIDR/REVIDR/AIDR) and enables it.

Subsequent patches for Target Impl CPU support will make use of this
helper.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 target/arm/kvm.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 12 ++++++++
 2 files changed, 84 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3f41f99e23..eb04640b50 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2072,6 +2072,78 @@ bool kvm_arm_mte_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
 }
 
+static bool kvm_arm_set_vm_attr(struct kvm_device_attr *attr, const char *name)
+{
+    int err;
+
+    err = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    err = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    return true;
+}
+
+static bool kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
+{
+    struct kvm_smccc_filter filter = {
+        .base = func,
+        .nr_functions = 1,
+        .action = faction,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VM_SMCCC_CTRL,
+        .attr = KVM_ARM_VM_SMCCC_FILTER,
+        .flags = 0,
+        .addr = (uintptr_t)&filter,
+    };
+
+    if (!kvm_arm_set_vm_attr(&attr, "SMCCC Filter")) {
+        error_report("failed to set SMCCC filter in KVM Host");
+        return false;
+    }
+
+    return true;
+}
+
+bool kvm_arm_target_impl_cpus_supported(void)
+{
+    if (!kvm_arm_set_smccc_filter(
+        ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID,
+        KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_VER fwd filter "
+                     "install failed");
+        return false;
+    }
+
+    if (!kvm_arm_set_smccc_filter(
+        ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID,
+        KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_CPUS fwd filter "
+                     "install failed");
+        return false;
+    }
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS)) {
+        error_report("KVM_CAP_ARM_WRITABLE_IMP_ID_REGS not supported");
+        return false;
+    }
+
+    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS, 0)) {
+        error_report("Failed to enable KVM_CAP_ARM_WRITABLE_IMP_ID_REGS cap");
+        return false;
+    }
+
+    return true;
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ba5de45f86..3cd6447901 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -207,6 +207,13 @@ bool kvm_arm_sve_supported(void);
  */
 bool kvm_arm_mte_supported(void);
 
+/**
+ * kvm_arm_target_impl_cpus_supported:
+ *
+ * Returns: true if KVM can enable target impl CPUs, and false otherwise.
+ */
+bool kvm_arm_target_impl_cpus_supported(void);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
@@ -263,6 +270,11 @@ static inline bool kvm_arm_mte_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_target_impl_cpus_supported(void)
+{
+    return false;
+}
+
 static inline int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap)
 {
     return -ENOSYS;
-- 
2.34.1


