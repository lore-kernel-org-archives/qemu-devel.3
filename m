Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A29AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEa-0001Ki-8F; Thu, 03 Sep 2026 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DET-0001Fw-FT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:23 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEP-00045x-Hl
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:20 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso158763a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464175; x=1789068975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f32IWeVjFPoScpLFlx02pOBXGIUqQvqEdKcNhwp+k0w=;
 b=tCYxKihtpSwybewlAo5OAxjiNscJ8OT41dVNpzcQeplsBt6pOD1YOPLrpfK5xFOB4L
 /yQUviDfIOPm77JZC6ygHF/440AQGDfDD09u0+AjDe0qvRMXrDxrv7FrAY0B/xjfVQW6
 0BPoWWJKYlA7pLSnNa20/sgV1ujD4dUtYFthun4SEAHHYl38vKriz4vDMxI492sfAgq7
 fThlRCmTlvY5gCj9r3duetjp7PWVZ5zXwM17UqirAgr59potypgHANUaG3azziNThaX3
 sTeBRQMsoI807t/xarvp6KMRHU9yAyGWzEaFcV78ZysjoUhn587LmjhMKkGj3uQXNt+9
 JX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464175; x=1789068975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f32IWeVjFPoScpLFlx02pOBXGIUqQvqEdKcNhwp+k0w=;
 b=RzIhB0lpDsrHFLqwE6jI+FhbCOrlsiRXZPvd2Y2B+YOMI/WyTCyvoGpHmSmyotP7jT
 UGuQxT811mtT97Exi/G2Qp9MLfVapGvb+wa0s/46kLRY/JJziqWtG/v2iBZPR6JDFYvc
 mDQG1oN5g7Ubchln4HGE1+4zBMLz19ImqMJ4GzTp31lhBhYDNeJECPLcjQ0XTOTED1t2
 OHesmnqH11O0J81iJxjVeq2YdVHFfBuNOiv2fxfziPuuXYPSoAoUo5HAou2ojjq+OY2P
 AzB87DCUb/WBpjiD/hmouvQaiZQk7Hjxj4p80eviEYCxgAzpm6uRBzFuxSSRQ+M7FjDe
 xn1Q==
X-Gm-Message-State: AFuF++ldOOL6nJ72b4Ip1J1BZQXonfDbuz2uvx4/pmXPDFh8bx1ZNtfx
 FPo37vlq6cJVGPVbju8NLo6lZSAvTd/zpHnKs7cHRh4JzYv0oJU4ZZefO082GyYNtSk=
X-Gm-Gg: AYBFou1HB+AW3P+1ppondrhZQkStkv2emPQg8hkEzX8LCxjSp0RZR2y1S8swyqSBJIX
 4P5RnZ6LKEd4P74OQ4zkuCyC/mGsxhElfTYRf75LpZmm0UL/NV505kC5eMO9o/qDlKKU2y1GxZz
 R3fXMLHeVtgr/xHBClgSnaGmBZ/6D7En/L4Ioy/F80RJ4s5olegWK0+2QgJhBjQK94+ulu3s/AI
 tawC0MImCBwMxf5RY4jlsLRavdQeQlsDdItoKzosfv3eUjTdaZL21yLZsU/MW4jveuqUOFrpDx9
 JoYGMIbwoERLLYeOQAqCmkN78XqQqUkv/swtORPUvmhCGzJole3AUVQjlWXlor/U5qRxl7tVpnb
 A6eFU1BEgZTkcqwRVpPQaM7K+PfP/Cfphydiyr79LyVdACj8AFil0SnOPp7TUY3hmR0G/jgPPPc
 zzSZ3fDCh387vTTUpxJaD274FWeqv17SpWRxbPUFcKj4WHpkQl4rKFbOZPAZN0SIEJeSkAtwkgX
 se95jOWqxhL0Z9UEqw0+bI9qg==
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39b25eeeef9mr1274489a91.0.1788464175209; 
 Thu, 03 Sep 2026 12:36:15 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:14 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 01/24] linux-headers: Add RME related definitions
Date: Thu,  3 Sep 2026 13:35:48 -0600
Message-ID: <20260903193611.1058589-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a temporary patch intended for testing purposes only. It provides
definitions related to supporting Realms by the QEMU-VMM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 linux-headers/asm-arm64/kvm.h |  9 +++++++++
 linux-headers/linux/kvm.h     | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 6aefe7973814..4c08631ec7d2 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
 	__u64 reserved;
 };
 
+#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
+struct kvm_arm_rmi_populate {
+	__u64 base;
+	__u64 size;
+	__u64 source_uaddr;
+	__u32 flags;
+	__u32 reserved;
+};
+
 #define KVM_ARM_TAGS_TO_GUEST		0
 #define KVM_ARM_TAGS_FROM_GUEST		1
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 29f81c05aca2..8b7627f11447 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -689,14 +689,19 @@ struct kvm_enable_cap {
  * address size for the VM. Bits[7-0] are reserved for the guest
  * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
  * value 0 implies the default IPA size, 40bits.
+ *
+ * Bits[30-31] are reserved for the VM type
  */
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 
+#define KVM_VM_TYPE_ARM_NORMAL		0
+#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
 #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
 #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
-					 KVM_VM_TYPE_ARM_PROTECTED)
+					 KVM_VM_TYPE_ARM_PROTECTED | \
+					 KVM_VM_TYPE_ARM_REALM)
 
 /*
  * ioctls for /dev/kvm fds:
@@ -719,6 +724,8 @@ struct kvm_enable_cap {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
+
 /*
  * Extension capability list.
  */
@@ -988,6 +995,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
+#define KVM_CAP_ARM_RMI 252
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0


