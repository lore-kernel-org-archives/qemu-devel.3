Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7669CA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkf-0007V4-KM; Fri, 02 Oct 2026 16:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkM-0007Fn-9U
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:47 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkI-0005ll-RK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:44 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2e2bfc2540cso22323555ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972441; x=1791577241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfHTpgqhpSdXDZKkZsFnRcwEmJHGyPGoGiJFvPu1kmg=;
 b=NroO9UxOW8jT7/w+CmpD6nNoO+6RlG1WAWe2aF05S3u/dyJKWF0BC8+9pWe/jDY/qX
 HGRF6+PB1KkHNB6as9WBeDA1Eq9BGhy2e9WuPnN/Q/OhVesaw6DPp60l0MhZHjEYqGUO
 7RKFfU18dZGipdQ5EkKLIiR036XXNTEipMUatq5H6GW9kyuEnvenaRnW60//iCbrjnpj
 bV2Q23AVbEoLNdoxu29us21PS8H+DFoJp9iQ3tylRsMT7e9FhQmXSB67izpLq8FBJwTj
 X9HueLH33y/xQzOxE7uGAh7Y3gDHOQDbbcXm99nzyzw7OeGraBJ9NKGvEleJTrGTfiya
 3Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972441; x=1791577241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EfHTpgqhpSdXDZKkZsFnRcwEmJHGyPGoGiJFvPu1kmg=;
 b=a2rT2ieiJJhYlJ844Uh8rIUVm6daq8YP7jlU4230EJkz1jCCO6gGnTMV9CNZbVcIcL
 KwDJpKM+P50mfH8Ux0utdhXUrVSvEi0MYCXeC7eCMUZLCw/ljND/8ngXLu+8h+iMxlOo
 /wONF5kL8qwkq/C+asnwRs20y6xd3jce/j3FuO2WkYkWBbAlAObg4Xm5K7vzrfpJICbG
 AH+lfHTNX6JsEqZaWYvmeK3dTh7Dv80c5j8rHdHFlBwAGafJiOafJKDvdZqkSm8bPALk
 8piBAP39I9KtBu92XDWeiQpuBVkootROMLb9BLlQhyjxUGsLlOu+Y0A6OQX1ku4JVW9L
 JAbA==
X-Gm-Message-State: AFq9FYJI2nFdr8QdmOE8h66BPgBJOtZTU9XptYo3KMhv250GeF6id3mJ
 IGqWnWiu2mVqjK6RKNzPQdSMPyC1x2c65ZAzAw1QGNmqr4UQe26tRdA5wEDlzUe9FNI=
X-Gm-Gg: AYBFou0abOy7Mv02+J6edqaCUw7D7qOb2uUT6hGZPxgBwruBqy/zsNPpUAr7tGt3MsN
 TQeWT+6SdCCEWGGPwFw4NwWWBYKlmLBIDeWPcHpSSGkvE61zVauWroXglua3Wd4Bqu0n0XLfJ0f
 Qx+6blEaGPXrGLVzj+v8ppj0+whLz99kdtcajlQEoSFvD8RkoggO31vnTYV/a46U05x1KAxGNJt
 xLZkj7gj/OUrdKhnWa4jObKSuSNFXjKLhcJPjVVoiWTahtogjTel29ay6s+ji2Cf3b9Sa+EQaGm
 j2m3QmENEyoHgDIi/X/NlJjSGIe7yLbagqHr5rNAZ/fdGEGLnrD/Ou5GePqyUGVTczNlnzWJPT6
 CLpnz4DBoPvqBy3ptvhYL9Vi99kNW7ZHy1r/7bUbQS2iRiMMPqW5KU2ZKLRM8v5m6zCruSuon7H
 vMGsLiiNF9WkZXW7bM3NVkCs/38lxK8OBZ0maxyPh3w6B45IMAuElAQhZFcJ0xt08ILW8xoBm2G
 0RSENHVZbdEVKCpaCgLUBmh
X-Received: by 2002:a17:902:d987:b0:2dd:c100:4b80 with SMTP id
 d9443c01a7336-2e49b6d9f9fmr32764805ad.55.1790972441200; 
 Fri, 02 Oct 2026 13:20:41 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:40 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 07/22] target/arm/kvm: Use kvm_vm_check_extension() where
 necessary
Date: Fri,  2 Oct 2026 14:20:11 -0600
Message-ID: <20261002202026.1204110-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x0f.google.com
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
index 8c74785998c2..10d911a56b0b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -370,7 +370,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -679,7 +679,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -EINVAL;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
         } else {
@@ -710,11 +710,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
 
@@ -1956,7 +1956,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0


