Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B2606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x5qJtIMF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDu-00052v-CD; Mon, 02 Nov 2026 08:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD7-0003KU-8A
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:32 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD5-0002JP-HA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:28 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so3176872f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626586; x=1794231386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c40oTYCHBPAU/0H7nxE4+WKzLNjvPCTvo3lBvrt5mww=;
 b=x5qJtIMFa6UDJhFaJS4P02tfzAcOSEiiuHTsFUERpPna6rC5/Sh66dbh/tYlHIkml/
 8oVt9A+SUEeFkjWzNdVHWXTpJQA6nsu2xcSG0kKqPKXYrdPAVBKwqXK4DQ09hiHxbe27
 v046VlfsK67zc1EelOtkU+Qe/LQdLN8WN0OWXOUsSV3z1r0X4+9yoh2CDzbkWd+Q4L6y
 ATgy2Z4Otlj0mHP3EH+PPKBEdco0+F1WD6xjS9+UZ0Xe6ADlQiyCcBddX7YLPmBdCuhr
 XlzAxr5xa6VW5w/Vy4UGOD9s8Y0Uwd6AhGAaSoniNTCpSFpcXrWskffOFWZ5olPtA3Uh
 WbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626586; x=1794231386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c40oTYCHBPAU/0H7nxE4+WKzLNjvPCTvo3lBvrt5mww=;
 b=Pu0hIMYMbB32wNHdHx6G4CjKQJ95n81UZjnP382r3MYfLzz4SSu3LU90add62vaSZ7
 qV/sgwSpKY0pGlYRk38It64BmWHMJY6oNSnl6G45KnCsKRHFsQlYnzTT4/DVC/5XjQ17
 Borcsn2sL2VlEVvl+IrOQIDufPA+ZxsyNBnYMzUWjQIL9VCJ92/xp+9pKBjMZlrXoTXk
 H/CW5B/J/vZyye0w++emaCDqGnzwHfee7vHGFiniHwS/mKkKKw+pZLC4zFRxC1UnuLWy
 g9j/87n0ZidzUnRECc6f5mYpHuaUHV7N8Zp6sKIFpYCQN7UwWlzhKus/0SRUM6Kowynq
 EXDw==
X-Gm-Message-State: APuU4Z8CZ+KVlh7yKNjEog5QxkimQ0TqWwA9mgq5q0pkfJs4G3AxF1UG
 IjhxGB9Hx0NaFIXnUQ0V003OBUig4FcaNTKFJ2SuyjcOG/bZ3+1QxnUpo1k5RQn0SWWrvnhxELg
 B5R7j19s=
X-Gm-Gg: AYBFou3BI228lph/AzwLGfd1zV5+Y7cBMsQ88SutK3ArL5zeL4l4HRaSyCUZlYOQBci
 i4m/4jh259z+PT/C66qQuTZ2t33nORFrueW5zuF2QOcKRvM+fFJ7oludw9RIrQLiSygIHYgrs2s
 zI0Z0PrmsRTBc1e6P5FlRuo4+tjyLqj4dUsUMTQs+znVRQI4Os4TtI/oGzmHkFtzA56v2fShSwU
 7JyyexfiMDcIHRYLV++zsIkkenneIqRuu9J0w63peeKV+IlPaoLArN4PwExsxXkgPA9+zHG6BCk
 xbo4gn5Xfw4afQC8nDhBN5n/Ta6TCkFYo4U3QV4ZJzpyXXrseQaHF1ZlIMtcOpIPhW+8Fjdn6rg
 LOnesNxUXyL6A/yu8856ViQL1qzz+ptQ1BjG6kAvgGF1hhUtY50T52Sv2gvWg+UopykY4dn8B8M
 kbuO+1hThoz1YlZ+s8DBSaX8UhjTvRC0kmwG8IJNzTOTQWlES1jhi+S+kBGAuOyD9w9jPgN2ixE
 tv2Rrs8o1M1T7u8ntrlfN2lzISlNqJYQKVil2MJ7VXS+mOiVrMCpb3J6lH8HpOQEPAzyuOIjLF6
 0HkaZ296RXtCbDVjzJ9OY+xD1SuzDflkstEBId3TctsD8d5CxVmgP4qNynrlG9kGWVzd6a7bSku
 g8QUPrBHdn18CwW7OMTTeWEJRiV/7mnVDtg==
X-Received: by 2002:a5d:6d02:0:b0:48e:5fde:8437 with SMTP id
 ffacd0b85a97d-48e6e50e4f1mr19030339f8f.56.1793626585878; 
 Mon, 02 Nov 2026 05:36:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/47] target/arm/kvm: Introduce
 kvm_arm_vcpu_prepare_init_features helper
Date: Mon,  2 Nov 2026 13:35:32 +0000
Message-ID: <20261102133547.1375701-33-peter.maydell@linaro.org>
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

Factorize the code that initializes the kvm init features from the
cpu settings in a helper. Use it in kvm_arch_init_vcpu(). Soon it will
be used by another function.

The only change in the code relates to the check of kvm_state. The
future caller won't have the VM created when calling the helper and
for this caller it is OK ignoring PSCI version setting.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Message-id: 20261030131406.461599-8-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 50 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 86a4d2a6b1c..b4b20c5dc27 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2008,34 +2008,18 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
-int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
+/* Determine init features for this CPU */
+static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
 {
-    int ret;
-    uint64_t mpidr;
-    ARMCPU *cpu = ARM_CPU(cs);
+    CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
-    uint64_t psciver;
 
-    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
-        error_setg(errp, "KVM is not supported for this guest CPU type");
-        return -EINVAL;
-    }
-
-    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
-        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
-        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
-                         "with KVM is deprecated. Use the max or host CPU "
-                         "types instead.");
-    }
-
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
-
-    /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
+
     if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
-    if (cpu->psci_version != QEMU_PSCI_VERSION_0_1 &&
+    if (cpu->psci_version != QEMU_PSCI_VERSION_0_1 && cs->kvm_state &&
         kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
         /*
          * Versions >= v0.2 are backward compatible with v0.2
@@ -2059,6 +2043,30 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
     if (cpu->has_el2 && kvm_arm_el2_supported()) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
+}
+
+int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
+{
+    int ret;
+    uint64_t mpidr;
+    ARMCPU *cpu = ARM_CPU(cs);
+    uint64_t psciver;
+
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
+        error_setg(errp, "KVM is not supported for this guest CPU type");
+        return -EINVAL;
+    }
+
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
+        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
+        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
+                         "with KVM is deprecated. Use the max or host CPU "
+                         "types instead.");
+    }
+
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
+
+    kvm_arm_vcpu_prepare_init_features(cpu);
 
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
-- 
2.43.0


