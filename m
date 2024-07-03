Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C032AC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxkM-0000y1-MW; Wed, 03 Jul 2024 07:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxkL-0000xn-AA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxkE-0003yW-6q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720004508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJXfkX2FVeuW09rGLHMQl8eKx+VVtzqs987bhwWwkiQ=;
 b=QYzhgARENW5c6HJ2RH3mkmWriS7MMdi+m4Ew46DeltkN3uEDOwWTcZ3MOGFmH2w8rEWvkP
 C7voO0Lbxk8O4DM0qsTB3xQh+9t7FPP4zF913+govIlZpNyknGB8BAzO3Xa0dXQbhqETtX
 U3toaxNakwaLQCTGp5IKy5xOhkY+x04=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-dHv8xbUYOqKrOuZTprH6hg-1; Wed, 03 Jul 2024 07:01:46 -0400
X-MC-Unique: dHv8xbUYOqKrOuZTprH6hg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42566e8a9efso47991685e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 04:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720004503; x=1720609303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJXfkX2FVeuW09rGLHMQl8eKx+VVtzqs987bhwWwkiQ=;
 b=thYRFZB2bh6Ezb7l/deTlaJbn0SAlckrCNA1xTPlHiHE1AUtFmIvr70d9jWHlD+Jlp
 BkPOvh2GbHbUePiZYYVAWIgeK5dVSAHgeaRiGZR229OawslOmISbK84mt6su2KZsVRgS
 91mzYXYNSewgteqpyjScx5ryFmeIUS9xnbRX8MzNFxWRx/ZbjgBMRRANDbAMxhc2Y/TB
 Ci7kR4hsJZht/VSYab675JqsuzonaM+FIjNVRMSxOkHumdBrPgbkWbM6bTggh8Jl8PDl
 nFsjRGnyw2eVwDy/x2mVzsZw6ZG3XYy271WruJskTU0LvfLeQGoqaPSKizEiccJgF8Wq
 X/mg==
X-Gm-Message-State: AOJu0Yw2nICA7lEStNUIq1x2jhuw/nTOmHEAMtgLwfY/Z7hMDj1q7Q29
 4Al0QV4iyuDMRrlqKE89wRs4zVKhfqitAKZWj8FMGzFSkrAxCjc26dtUsMe7atQ/ntcrbx6iFnb
 7AKHJxh5/cHdDlTcyIfTM6pw+z3NnBFNW6LGi9T0f6Cl2NFsw+Z7bRZRpflAeeXrHBRTAY+jAmj
 vNeeyuhp7XstNt9BbG2db6VHRsadznNGo1ulmT
X-Received: by 2002:a05:600c:291:b0:425:641c:5f40 with SMTP id
 5b1f17b1804b1-4257a027077mr87748045e9.39.1720004503570; 
 Wed, 03 Jul 2024 04:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlQf9oE25QGcbnA3VpzOI0PgFwfWC+U1jiauh9etXVXjtyuBzmohs8+ZWksv+fO9Qw2qN7/A==
X-Received: by 2002:a05:600c:291:b0:425:641c:5f40 with SMTP id
 5b1f17b1804b1-4257a027077mr87747835e9.39.1720004503243; 
 Wed, 03 Jul 2024 04:01:43 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42581bd5e4bsm128365765e9.10.2024.07.03.04.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 04:01:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	zixchen@redhat.com
Subject: [RFC PATCH 2/2] target/i386/SEV: implement mask_cpuid_features
Date: Wed,  3 Jul 2024 13:01:34 +0200
Message-ID: <20240703110134.1645979-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703110134.1645979-1-pbonzini@redhat.com>
References: <20240703110134.1645979-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SNP firmware rejects several features that KVM implements without needing
hardware support.  If these are specified, for example with "-cpu host",
the guest will fail to start.

I am marking this as RFC because it's not future proof.  If in the future
AMD processors do provide any of these bits, this is going to break
(tsc_deadline and tsc_adjust are the most likely one).  Including the
bits if they are present in host CPUID is not super safe either, since
the firmware might not be updated to follow suit.

Reported-by: Zixi Chen <zixchen@redhat.com>
Not-quite-signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  4 ++++
 target/i386/sev.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9bea7142bf4..31c9b43849e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -812,6 +812,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* Support RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE */
 #define CPUID_7_0_EBX_FSGSBASE          (1U << 0)
+/* Support TSC adjust MSR */
+#define CPUID_7_0_EBX_TSC_ADJUST        (1U << 1)
 /* Support SGX */
 #define CPUID_7_0_EBX_SGX               (1U << 2)
 /* 1st Group of Advanced Bit Manipulation Extensions */
@@ -1002,6 +1004,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0008_EBX_STIBP_ALWAYS_ON    (1U << 17)
 /* Speculative Store Bypass Disable */
 #define CPUID_8000_0008_EBX_AMD_SSBD    (1U << 24)
+/* Paravirtualized Speculative Store Bypass Disable MSR */
+#define CPUID_8000_0008_EBX_VIRT_SSBD   (1U << 25)
 /* Predictive Store Forwarding Disable */
 #define CPUID_8000_0008_EBX_AMD_PSFD    (1U << 28)
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2a0f94d390d..280eaef8723 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -945,6 +945,38 @@ out:
     return ret;
 }
 
+static uint32_t
+sev_snp_mask_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
+                            int reg, uint32_t value)
+{
+    switch (feature) {
+    case 1:
+        if (reg == R_ECX) {
+            return value & ~CPUID_EXT_TSC_DEADLINE_TIMER;
+        }
+        break;
+    case 7:
+        if (index == 0 && reg == R_EBX) {
+            return value & ~CPUID_7_0_EBX_TSC_ADJUST;
+        }
+        if (index == 0 && reg == R_EDX) {
+            return value & ~(CPUID_7_0_EDX_SPEC_CTRL |
+                             CPUID_7_0_EDX_STIBP |
+                             CPUID_7_0_EDX_FLUSH_L1D |
+                             CPUID_7_0_EDX_ARCH_CAPABILITIES |
+                             CPUID_7_0_EDX_CORE_CAPABILITY |
+                             CPUID_7_0_EDX_SPEC_CTRL_SSBD);
+        }
+        break;
+    case 0x80000008:
+        if (reg == R_EBX) {
+            return value & ~CPUID_8000_0008_EBX_VIRT_SSBD;
+        }
+        break;
+    }
+    return value;
+}
+
 static int
 sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
                        uint8_t *addr, size_t len)
@@ -2315,6 +2347,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     klass->launch_finish = sev_snp_launch_finish;
     klass->launch_update_data = sev_snp_launch_update_data;
     klass->kvm_init = sev_snp_kvm_init;
+    x86_klass->mask_cpuid_features = sev_snp_mask_cpuid_features;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
     object_class_property_add(oc, "policy", "uint64",
-- 
2.45.2


