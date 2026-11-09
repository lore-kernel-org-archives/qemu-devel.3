Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B0606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kOQZJhun
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu5-0005Jz-0E; Mon, 09 Nov 2026 17:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtj-0005Di-VW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:34 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXti-0003t2-7W
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:31 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8b612fd74e1so496916b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263489; x=1794868289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQYbIzhYybqZKpHEFkom106KOJMNZUoms04H7LpX2sA=;
 b=kOQZJhunLsaBYimhzL1spvYsVLGMNTNzr8BE3ZmxhB6MvhHIZ6CDU/gPRYIb6SHWad
 TpWZuSzQ927yJ7G8LLF3QXYNwsPoCDxlff5QEdDtEcHpRa9d7IT3dSL7UoP7BCC30G04
 BC6I4YntGWfvf+RQ2+W7uyishwdkoLzWcPMtlUovz4V/BB3wXw/2RjhVpT8Lrz+ygymY
 nqpWgktgV9yM6pxseDbPgxJIKnIQ7DNpuvFLFt+mLJIBchD3+0LSi50fvq3QhP6/tQfZ
 AOvhXq1Lqz8YaPpqukkglAtAmBVMXsB4doU9xN8T9ui5Vb8G+4arZ4LIC862SBfFZ912
 zPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263489; x=1794868289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sQYbIzhYybqZKpHEFkom106KOJMNZUoms04H7LpX2sA=;
 b=OIkDbwO25dEbSXcMKvOgIrBYxyZd0EeFaD3F+mjRo+oaHsKwxNHNtDyx1t5laJABuB
 8xk/i60CgSwVCLyXLVLdyUoRv3VILyDAt5rmuN9dsETbnlXZgzAwlg3kH5/m+aYv3wxR
 s306wjsTctBumrsGPL/cC2V/TlFazx6Vx84NypoLR08jLT3i9K5pmmvPrh9c5MWVFWl0
 R+fb3y38Aht7PdfuwTo8FIO1FQK5Oo4zhvEUPUqKfMskG+IbSMv9bAw44zpeM0FrB7v2
 WLUK8rMZ05U4JFLqAICvZUq3kdE8rNKdJJvRpy9gFT6bqf7ey/B6mDb242TNegPLDtgd
 JNQw==
X-Gm-Message-State: APuU4Z8drR6a2lIgjO/WobjRDUYNif9vjn8UdUr9vy2duEhVeXP9KVMP
 TDzZYD8azWhiRgV6gwvB17UqVEdVt7A/FpJdJDyAM9F3eULZGYfmfM1Xd4pb4n3Th4U=
X-Gm-Gg: AYBFou2Wf/Qeb44MTPR8Q7LYUiErNz5IcDc9zfrcFwz18ErIlqi6XXqzNkqa00TLTBk
 LOrnxiBYC/1Upr2anxvm41C5jsCqYYckW/sE6kbo9otYCZ7Ev63n8uLmlrHXUJncdECgiYMoHbr
 B7pG7l3GhDaQMJADsHV6GrnNvsXEtZZBzVHssvOnIk4DxF3zk5eix1ckkUnQ8I6mSzecD+ze5jy
 h2/DxyK9AFiDWAOd6XY55oTZ5aNGFOGynmtSdq0SkgeHD+95E+QONnU/UhuGk2LRwdxpqiZMD00
 VId1U8Rh6vfZZV8CuUApSNsBXfXBRzZVXnaqn5rpKzZF0hsM5fy0pq6JAi5OwqObFCA0OrvzSe7
 1+WV3Bey9ifuUEVIHLyXCNfrYhA15u+vFOoweVnWjTQzIL4ABE8XThwZ9CufDUPEW6PcEEzYPE6
 PRAQ2gHYzLYcFYVbAPp6MWKcLkTdCHNGU9owqHEsfrgHxzaM8jaMTJneyfjWuTVly4u0VMpyXwO
 kBt5AxQ9aEE5c/nDCGdKXCV3xFTRFTGfkHZRP0QTJpps8E/1hcRiEaRTiRsy1gHobzFI91TAghL
 GJmtVno3sixJRAhS/rp1tcVTEpFB+Vqz/ZYgaFsL6dM95nTpMdpJRw==
X-Received: by 2002:a05:6a00:812:b0:886:cae0:fb6f with SMTP id
 d2e1a72fcca58-8ba852368abmr890817b3a.14.1794263488778; 
 Mon, 09 Nov 2026 14:31:28 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:27 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 07/23] target/arm/kvm: Use kvm_vm_check_extension() where
 necessary
Date: Mon,  9 Nov 2026 16:30:54 -0600
Message-ID: <20261109223110.1619504-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42f.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The Arm KVM code can return different values from KVM_CHECK_EXTENSION
depending on the VM type. Use kvm_vm_check_extension() where necessary
to ensure we get the right response from KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 63a3e78efd53..dc1004785cb0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -384,7 +384,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf, Error **errp
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -695,7 +695,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -EINVAL;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
         } else {
@@ -726,11 +726,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
+    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
 
-    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
+    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
@@ -1978,7 +1978,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.53.0


