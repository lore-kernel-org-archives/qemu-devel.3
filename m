Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6D1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHBL-0004Br-OU; Mon, 14 Jul 2025 07:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0Q-0001Na-JY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0N-0001y3-JG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgTX+tIVcOOQ2a4srBk8j3hWHo73bhiEyasy0Vw94Pc=;
 b=J9PSiIkS3+kJmtzjaCEWBEJaUdRBg5o504aGIMLrrMny2Wp+WekgmmZ7DhTe9DPRimLX36
 ZI8J3eb8N23I73OQWsqNHPp+0/G5091JXZPA462H+R1s6hpcvYoEqnxyDhsKGki9J97ksb
 aPTjykTcjSn5zUdqRhxBqodH0lZoK1c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-sGPERiTyOmqhDieHR96ZIg-1; Mon, 14 Jul 2025 07:05:49 -0400
X-MC-Unique: sGPERiTyOmqhDieHR96ZIg-1
X-Mimecast-MFC-AGG-ID: sGPERiTyOmqhDieHR96ZIg_1752491148
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-453a5d50b81so30307925e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491148; x=1753095948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgTX+tIVcOOQ2a4srBk8j3hWHo73bhiEyasy0Vw94Pc=;
 b=TrGE969CpUV2//3wUnr2EMUqTlNbNE7xjVWeo0HiGYVogSk+fI3iBhGWJAsBUZcXlx
 alc62K7a0kxLnyT90H1DGM8eu3vqWbakqkMr0kIltBoU+Vv7avA8XpceDUXfXwhSKpVF
 P7Bsu7i7F/iBg6INLGAwm2f0Ht1Jv2a9w7a1utIqjeXM1IeymglXxP2shpNqNsi3j20u
 lNhA98mpkWCx3XBL5a++aKHABhi0CQNrZ2aKIXHM/HFrl3gnPKYnnWExOlK2gtxpDbZ5
 PaHXynVJvpeSTmZgkvh4qaO3hgFETYcBatmui63xXJONia5rg9BbTNT+XHpziAZWGST/
 LVKA==
X-Gm-Message-State: AOJu0YwnooPcQdxT5eeh4O1N6cotnt09YYFsBlVrN1gCNPOdb2q02hRX
 Vw0q70HhqpCzyFWu367paLghNBdADChcGeIGKnSMJwWzcxSQiNxWDNDdpquBCIv2+L+ULAKpW0s
 yJl261EIWg/2HNaDpIhmxBvkQV08XNa5FT5t5VE1btqjVBy/+GNBDEPBKAceJaHh04opn972FzC
 HQlEVqAacPUAllvjgAyfZw266srMQxZ7tCGXilr4Dg
X-Gm-Gg: ASbGncvDXkAYOGzpPHNx+AoCB9jUFCDP1EuMiG7K+FIZ2eBNBmsEqkENOIKd5/nj8OA
 vJyC/+OwJkp2BBtWElDaJtf87DuqY83HkB2J8cZMHW8O8OsGmIrYbmH+nSyf4zJJBP8+nqnvOTY
 XUBHi1ZMA8MyRCRFH6rKhqZ8N0g5pLowHiq8/hxV1C1KRcclFpQ16rtduJ7T3QZSNyWt6NRhVqi
 Kk64dYbUpsbzheOu9x0hnmprFTpws9gQV1MgzKBd6vdfwWnB7GDQuOCRJkNckgBLXqjvO9cYtoQ
 6ZwBViIGQTTzK8XQ2TmwXduHuAMcOsqWskY+iiXse/U=
X-Received: by 2002:a05:600c:37c4:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-456030271bemr65063365e9.26.1752491147413; 
 Mon, 14 Jul 2025 04:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy4dLgqm1Dk8YPznbMSHiqIweOBKgO0JdPQG+paLDIK3/W0uLMBr4L67oA3QjedLZaMCMKMg==
X-Received: by 2002:a05:600c:37c4:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-456030271bemr65063125e9.26.1752491146908; 
 Mon, 14 Jul 2025 04:05:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456030270f8sm73345715e9.22.2025.07.14.04.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 37/77] i386/cpu: Unify family,
 model and stepping calculation for x86 CPU
Date: Mon, 14 Jul 2025 13:03:26 +0200
Message-ID: <20250714110406.117772-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

There are multiple places where CPUID family/model/stepping info
are retrieved from env->cpuid_version.

Besides, the calculation of family and model inside host_cpu_vendor_fms()
doesn't comply to what Intel and AMD define. For family, both Intel
and AMD define that Extended Family ID needs to be counted only when
(base) Family is 0xF. For model, Intel counts Extended Model when
(base) Family is 0x6 or 0xF, while AMD counts EXtended MOdel when
(base) Family is 0xF.

Introduce generic helper functions to get family, model and stepping
from the EAX value of CPUID leaf 1, with the correct calculation
formula.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250630080610.3151956-5-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h      | 30 ++++++++++++++++++++++++++++++
 target/i386/cpu.c      | 12 ++++--------
 target/i386/host-cpu.c |  6 +++---
 target/i386/kvm/kvm.c  |  2 +-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b3bb9888579..a580562b3dc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2678,6 +2678,36 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
     }
 }
 
+static inline uint32_t x86_cpu_family(uint32_t eax)
+{
+    uint32_t family = (eax >> 8) & 0xf;
+
+    if (family == 0xf) {
+        family += (eax >> 20) & 0xff;
+    }
+
+    return family;
+}
+
+static inline uint32_t x86_cpu_model(uint32_t eax)
+{
+    uint32_t family, model;
+
+    family = x86_cpu_family(eax);
+    model = (eax >> 4) & 0xf;
+
+    if (family >= 0x6) {
+        model += ((eax >> 16) & 0xf) << 4;
+    }
+
+    return model;
+}
+
+static inline uint32_t x86_cpu_stepping(uint32_t eax)
+{
+    return eax & 0xf;
+}
+
 static inline bool cpu_has_vmx(CPUX86State *env)
 {
     return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d3d13b14726..b768838b100 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6325,10 +6325,7 @@ static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     uint64_t value;
 
-    value = (env->cpuid_version >> 8) & 0xf;
-    if (value == 0xf) {
-        value += (env->cpuid_version >> 20) & 0xff;
-    }
+    value = x86_cpu_family(env->cpuid_version);
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -6366,8 +6363,7 @@ static void x86_cpuid_version_get_model(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     uint64_t value;
 
-    value = (env->cpuid_version >> 4) & 0xf;
-    value |= ((env->cpuid_version >> 16) & 0xf) << 4;
+    value = x86_cpu_model(env->cpuid_version);
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -6401,7 +6397,7 @@ static void x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     uint64_t value;
 
-    value = env->cpuid_version & 0xf;
+    value = x86_cpu_stepping(env->cpuid_version);
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -8155,7 +8151,7 @@ static void mce_init(X86CPU *cpu)
     CPUX86State *cenv = &cpu->env;
     unsigned int bank;
 
-    if (((cenv->cpuid_version >> 8) & 0xf) >= 6
+    if (x86_cpu_family(cenv->cpuid_version) >= 6
         && (cenv->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
             (CPUID_MCE | CPUID_MCA)) {
         cenv->mcg_cap = MCE_CAP_DEF | MCE_BANKS_DEF |
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index b1fb6d68161..d5e2bb5e187 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -117,13 +117,13 @@ void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
 
     host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
     if (family) {
-        *family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
+        *family = x86_cpu_family(eax);
     }
     if (model) {
-        *model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
+        *model = x86_cpu_model(eax);
     }
     if (stepping) {
-        *stepping = eax & 0x0F;
+        *stepping = x86_cpu_stepping(eax);
     }
 }
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fc58a23b30d..e8c8be09bae 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2259,7 +2259,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
-    if (((env->cpuid_version >> 8)&0xF) >= 6
+    if (x86_cpu_family(env->cpuid_version) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
            (CPUID_MCE | CPUID_MCA)) {
         uint64_t mcg_cap, unsupported_caps;
-- 
2.50.0


