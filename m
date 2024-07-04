Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7F6C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJF0-0007Eh-8w; Thu, 04 Jul 2024 05:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEy-0007Dj-SQ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEp-00089b-5o
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84KwKQf/6CUqIB9ra91r9/AV4OKX4iDYobaOtPDgsqk=;
 b=Wj1TCngQYFsXr1wWzXvjH25OF3jNXw4QTfsEvpBkcL9QGqEr6Ej8645ghpmJeB2M3jKXbZ
 dChK3rkRROYCyIb+361VOwTpf3o6UtctiaH7Pal9ziUdaOVI/Vj//xlHLiir+Fq9NHom6V
 cVDwDr/m+licVfdwYCyvtt8Gul7Gt3M=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-xDBNFXTpPlmShGKNrlMPCg-1; Thu, 04 Jul 2024 05:58:48 -0400
X-MC-Unique: xDBNFXTpPlmShGKNrlMPCg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ce324c204so539399e87.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087126; x=1720691926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84KwKQf/6CUqIB9ra91r9/AV4OKX4iDYobaOtPDgsqk=;
 b=BXDi8rxMZnXNA3JtGrZMadY/7/rXg4UCt2aoT/n4sgm1dMfog38NjQCcgJSq1UV5+F
 HPlCRqZFE+5OMUriiaooXqQHb/3l8xRqezWBkP9g5HHYztmriZNd+UbGYC/a41MHiCKa
 TC70xF/9OKZ1VyeXyIXORAb1L7raqXMvHd2arYxr0KtljY2jv/92a82GEMCVHuBBpMFn
 HiCKMhlH1q4eWNlONA6Od7eeyK0tQDAP1V6RoEY0CiArDiu2+8uRhCwEcALK3HMRjI47
 IYBCZiYGRKLYGtnGlClkiZerEnVgOmtf4ths1FE9pIinsHZuYU1+z9yGcnoMJfG1YzBo
 dPEQ==
X-Gm-Message-State: AOJu0YzPeOM692i1GZBoQXGlwxibsEW4x55jmKb4Ki5anFtRTRyjChJj
 DjmGbj00u8mCRWwaMc9bVEx1WsneaaNsDdbZPiiD3xymBqKckiuMiAluqZu9lakbG0enZaq6RO5
 DaPqUy7sfxWZIo9UphH2LyN4jmAVOQdmgJ5Mln/kPhoAzaSyx4ZhjYeWoHTsBlzElUN7rgT3PtL
 tUhMh1JQTyRf48g3QYplhphM9IXcC9mdThylb/
X-Received: by 2002:a19:3852:0:b0:516:d692:5e0b with SMTP id
 2adb3069b0e04-52ea06e5636mr724470e87.54.1720087126476; 
 Thu, 04 Jul 2024 02:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgDvPk1J+c+TOk+u7128hSIdj6H4a7q1b5JRuEIQm+hzhDJ6MbsVr+3hQ6ZdG3pLAWIk0sEA==
X-Received: by 2002:a19:3852:0:b0:516:d692:5e0b with SMTP id
 2adb3069b0e04-52ea06e5636mr724461e87.54.1720087126096; 
 Thu, 04 Jul 2024 02:58:46 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367958d8966sm3379604f8f.91.2024.07.04.02.58.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] target/i386/SEV: implement mask_cpuid_features
Date: Thu,  4 Jul 2024 11:58:06 +0200
Message-ID: <20240704095806.1780273-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Drop features that are listed as "BitMask" in the PPR and currently
not supported by AMD processors.  The only ones that may become useful
in the future are TSC deadline timer and x2APIC, everything else is
not needed for SEV-SNP guests (e.g. VIRT_SSBD) or would require
processor support (e.g. TSC_ADJUST).

This allows running SEV-SNP guests with "-cpu host".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  4 ++++
 target/i386/sev.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0d5624355e4..c43ac01c794 100644
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
index 2f3dbe289f4..2ba5f517228 100644
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


