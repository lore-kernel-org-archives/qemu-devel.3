Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5009FC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyo-0005ve-Hn; Fri, 30 May 2025 03:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxU-0003ix-Gu
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxS-0007E0-Jr
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvks4Nng1J1od24AputbkRlHaoOQCBsdzfvCXnt7Xks=;
 b=A6R67xE+Q/ZTsfX2bLdTfJreXFFiL2hUmDiNyqrH1uQI5JjtxWyg0nsyNpod1OeaAtB3ql
 kNJM9Z2LQZg/ybdbha8zL+aNTO7wDqjXMWGzyQNqJ6m/Qafa1XL5LsB05uPZpxk7aeMsBr
 HmOKX0Fo6y698OJmEgz72Idh+ogNI/E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Y2oWfNuWMA-Y1FR2uy7Vkg-1; Fri, 30 May 2025 03:15:12 -0400
X-MC-Unique: Y2oWfNuWMA-Y1FR2uy7Vkg-1
X-Mimecast-MFC-AGG-ID: Y2oWfNuWMA-Y1FR2uy7Vkg_1748589311
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso158778166b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589310; x=1749194110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvks4Nng1J1od24AputbkRlHaoOQCBsdzfvCXnt7Xks=;
 b=mJHsFKXodNN9r/UdcFWjTh0Dhh1HiU5BFgNKWNt9aERX0fFAHPDkGkAnTUSRKhpoj5
 GOaBvO3HvQbWzNGMBd/vZA89Xofcun8SE3YJ73OL2cyUnUwV/pAF3kzt1pi+izoIPDk2
 sGw0Z4jkoJHdXqWBvZBQCJPKHhxLA5peqpSf7ngemDPB6ak/W84x42oFM3MxzMqSO+Wq
 VvrBeKFQJIXaupSb8BwW4fAWIzWvhnSXvJC3elhkrEZ3TAo88z1WTiEWjivN0pAuuK4L
 OVieEEKYFqqvPJJo+7ng5X5OfZ8L9bjvvtKPWg2tC9rluiRe0JJIRGiUEnoKQfJcCP3m
 voIA==
X-Gm-Message-State: AOJu0Yyv6t4AvxJYYx6okmnx2sTqm6zwMm2CBtqcjv/8xFNELRcCfF+B
 eBDCfxKBhn2SmBHWl3DrRJJOz+HOgwbwgFGkDKUdU+ifKOvRoSyNbp9+hj2QDr2O6eH77Dp287b
 GrtZSRFzAKp9VUQsFG0jBvRi4FlCmmfhV2YCVRb6kf8Cf3W+/puT7YSWR23PSGTKG65uVP+tg4V
 xhQIo+eMLiK7fEbLvZf9diGPOHFBHTlm6U1Nc//xXM
X-Gm-Gg: ASbGnctBETsaHXDb8hVaq1chUCd3A+oPQ6FkwG4C0sWgRbJXC8l5Mhy3ynI2aWgkIA2
 hvmbNvUH7b5knPNK6/EGz1XnvXKe3r0XKUbOtEzLEQpyUdCTah7sz8lbAIerNKOxFJVqmopvmq3
 KS7iYyDxfLIIS7RbAPzP/oaoI7RYM7cG9u7DN3ML3lRBAmV61x8fw0RT8rmrIkurSMV+xjwjdiR
 6NB9Oi3KRD+ITU8TYkIOBIteNSgbzaoZhD0zVJJE+7pe/iyN+lW4lIBViXt+Zn+gdLQnPEnowgG
 Ms+EsmFwIybwh6J/PB4uARvA
X-Received: by 2002:a17:907:2d91:b0:ad8:9257:5728 with SMTP id
 a640c23a62f3a-adb36b567femr99503966b.27.1748589310566; 
 Fri, 30 May 2025 00:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs6PO7Wp1hD0Z4LgwEASQXC1N/WorQVkh+pS+pHLqsnyPFG7NlhL5W+jtOAfYffpGMxxJvEg==
X-Received: by 2002:a17:907:2d91:b0:ad8:9257:5728 with SMTP id
 a640c23a62f3a-adb36b567femr99501466b.27.1748589310145; 
 Fri, 30 May 2025 00:15:10 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82e838sm275358666b.72.2025.05.30.00.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 55/77] i386/cgs: Rename *mask_cpuid_features() to
 *adjust_cpuid_features()
Date: Fri, 30 May 2025 09:12:25 +0200
Message-ID: <20250530071250.2050910-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

Because for TDX case, there are also fixed-1 bits that enforced by TDX
module.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-44-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 20 ++++++++++----------
 target/i386/kvm/kvm.c            |  2 +-
 target/i386/sev.c                |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index a86c42a4755..777d43cc968 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -40,8 +40,8 @@ struct X86ConfidentialGuestClass {
     /* <public> */
     int (*kvm_type)(X86ConfidentialGuest *cg);
     void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
-    uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
-                                    int reg, uint32_t value);
+    uint32_t (*adjust_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature,
+                                      uint32_t index, int reg, uint32_t value);
 };
 
 /**
@@ -71,21 +71,21 @@ static inline void x86_confidential_guest_cpu_instance_init(X86ConfidentialGuest
 }
 
 /**
- * x86_confidential_guest_mask_cpuid_features:
+ * x86_confidential_guest_adjust_cpuid_features:
  *
- * Removes unsupported features from a confidential guest's CPUID values, returns
- * the value with the bits removed.  The bits removed should be those that KVM
- * provides independent of host-supported CPUID features, but are not supported by
- * the confidential computing firmware.
+ * Adjust the supported features from a confidential guest's CPUID values,
+ * returns the adjusted value.  There are bits being removed that are not
+ * supported by the confidential computing firmware or bits being added that
+ * are forcibly exposed to guest by the confidential computing firmware.
  */
-static inline int x86_confidential_guest_mask_cpuid_features(X86ConfidentialGuest *cg,
+static inline int x86_confidential_guest_adjust_cpuid_features(X86ConfidentialGuest *cg,
                                                              uint32_t feature, uint32_t index,
                                                              int reg, uint32_t value)
 {
     X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
 
-    if (klass->mask_cpuid_features) {
-        return klass->mask_cpuid_features(cg, feature, index, reg, value);
+    if (klass->adjust_cpuid_features) {
+        return klass->adjust_cpuid_features(cg, feature, index, reg, value);
     } else {
         return value;
     }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 90a0dac4a1e..0d474634312 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -574,7 +574,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     }
 
     if (current_machine->cgs) {
-        ret = x86_confidential_guest_mask_cpuid_features(
+        ret = x86_confidential_guest_adjust_cpuid_features(
             X86_CONFIDENTIAL_GUEST(current_machine->cgs),
             function, index, reg, ret);
     }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7ee700d6a35..8b87b7cdec3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -947,7 +947,7 @@ out:
 }
 
 static uint32_t
-sev_snp_mask_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
+sev_snp_adjust_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
                             int reg, uint32_t value)
 {
     switch (feature) {
@@ -2405,7 +2405,7 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     klass->launch_finish = sev_snp_launch_finish;
     klass->launch_update_data = sev_snp_launch_update_data;
     klass->kvm_init = sev_snp_kvm_init;
-    x86_klass->mask_cpuid_features = sev_snp_mask_cpuid_features;
+    x86_klass->adjust_cpuid_features = sev_snp_adjust_cpuid_features;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
     object_class_property_add(oc, "policy", "uint64",
-- 
2.49.0


