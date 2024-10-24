Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B687BCE8E65
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 11:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3w48-000071-83; Thu, 24 Oct 2024 07:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3w3z-00005X-Lx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 07:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3w3x-00005t-Vb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 07:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729769492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O2iFcR4SX9ynzITICOZtbgrj/56PGjOqmbE9bYK0m4M=;
 b=ZZJ8wsaJ6eSXaUHcc6P2aRUIZCUwzCvBJ752iV5ehYbafC2FpRnE9VbBzqSUbzRa6czG49
 rgqyArEtZ1sWjEzjHxdfeX/K8vZXxL9+Ac35hkC8t/N62KpQY1a75PHKcs1gT96tQzXwI4
 GjgJamN2NpsxjedzPSf+lfk0rcL5itk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-GUcAF9uaMJy8ydDYJ7ddFg-1; Thu, 24 Oct 2024 07:31:29 -0400
X-MC-Unique: GUcAF9uaMJy8ydDYJ7ddFg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d56061a4cso439487f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 04:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769488; x=1730374288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O2iFcR4SX9ynzITICOZtbgrj/56PGjOqmbE9bYK0m4M=;
 b=ahwtShKf7SRP6LIX2AqPsbLFOIKb8zrwATsg6yEZh4V/5iC4l3+Ky49EFuTjlYffCg
 aCHda4r54zY1nhyC+ZtPz7RFN9GLK3VKO3WvEXNWTiv+hz5YoKOj76bk4fxcT6X1Hd2y
 VspvhuOx8ewId+RHm0UzAIf1Z6CqpuVtWT6AYKmqYDtyN9zhCwX1N1ttBqfYfgascdi4
 F3A7onS5Kt8ld2etBh1IMjSrYmnTbK2SSfJRlU1Wn6ZKGRzjYrVeH2JWp+GheD/ftymL
 AtoO9YVwvdgc1JdHBR4nE5Kr8FOUeqlWBFMBtEpAUtoJ1I8o7N0mcHCQDE51B3d9V+Ir
 tG+g==
X-Gm-Message-State: AOJu0Yw5t0UGkYMuwMYfihqrrk7TrRiHCTi955lGaSgs81nRJuMmz9Yj
 0lYr89P9HYCWgCqnEFJ6ZQ6i7wPBlyKwip7gt2folEZf/WMmIIukGA+RH/EcfQnmQqUA/9glUMj
 RNop/HI+X7+m2/YbfwaE9X6CNQpWh6ijG7RO2AoRSLnU/im7TmMyrqChAQEP0yV427cq+0c8r1O
 AnPtykFAkNCftti8Ef7dNiofvFFLg1fZFuRHFFgMc=
X-Received: by 2002:adf:e60e:0:b0:37d:33a3:de1c with SMTP id
 ffacd0b85a97d-37efcf848f4mr3473312f8f.38.1729769487997; 
 Thu, 24 Oct 2024 04:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAE6V5Aw5WD/EMddm8SuvO0URgz1xzxvhrlemT6EJ5866/TLuoI7N4htqdAeVTHIGAtv/V/g==
X-Received: by 2002:adf:e60e:0:b0:37d:33a3:de1c with SMTP id
 ffacd0b85a97d-37efcf848f4mr3473291f8f.38.1729769487501; 
 Thu, 24 Oct 2024 04:31:27 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a4ad48sm11055823f8f.42.2024.10.24.04.31.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:31:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: kvm: require KVM_CAP_DEVICE_CTRL
Date: Thu, 24 Oct 2024 13:31:26 +0200
Message-ID: <20241024113126.44343-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The device control API was added in 2013, assume that it is present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/kvm_arm.h  | 16 +++++++---------
 hw/intc/arm_gic_kvm.c |  9 +--------
 target/arm/kvm.c      | 17 +++++------------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfaa0d9bc71..02b02b4cd20 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -22,17 +22,15 @@
  * @devid: the KVM device ID
  * @group: device control API group for setting addresses
  * @attr: device control API address type
- * @dev_fd: device control device file descriptor (or -1 if not supported)
+ * @dev_fd: device control device file descriptor
  * @addr_ormask: value to be OR'ed with resolved address
  *
- * Remember the memory region @mr, and when it is mapped by the
- * machine model, tell the kernel that base address using the
- * KVM_ARM_SET_DEVICE_ADDRESS ioctl or the newer device control API.  @devid
- * should be the ID of the device as defined by KVM_ARM_SET_DEVICE_ADDRESS or
- * the arm-vgic device in the device control API.
- * The machine model may map
- * and unmap the device multiple times; the kernel will only be told the final
- * address at the point where machine init is complete.
+ * Remember the memory region @mr, and when it is mapped by the machine
+ * model, tell the kernel that base address using the device control API.
+ * @devid should be the ID of the device as defined by  the arm-vgic device
+ * in the device control API.  The machine model may map and unmap the device
+ * multiple times; the kernel will only be told the final address at the
+ * point where machine init is complete.
  */
 void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
                              uint64_t attr, int dev_fd, uint64_t addr_ormask);
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 53defee7d59..e2a73337b1e 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -547,17 +547,10 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
                               KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true,
                               &error_abort);
         }
-    } else if (kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
+    } else {
         error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
         error_append_hint(errp,
                           "Perhaps the host CPU does not support GICv2?\n");
-    } else if (ret != -ENODEV && ret != -ENOTSUP) {
-        /*
-         * Very ancient kernel without KVM_CAP_DEVICE_CTRL: assume that
-         * ENODEV or ENOTSUP mean "can't create GICv2 with KVM_CREATE_DEVICE",
-         * and that we will get a GICv2 via KVM_CREATE_IRQCHIP.
-         */
-        error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
         return;
     }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f1f1b5b375a..7d0dee2e3bb 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -41,6 +41,7 @@
 #include "target/arm/gtimer.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
+    KVM_CAP_INFO(DEVICE_CTRL),
     KVM_CAP_LAST_INFO
 };
 
@@ -675,19 +676,11 @@ static void kvm_arm_set_device_addr(KVMDevice *kd)
 {
     struct kvm_device_attr *attr = &kd->kdattr;
     int ret;
+    uint64_t addr = kd->kda.addr;
 
-    /* If the device control API is available and we have a device fd on the
-     * KVMDevice struct, let's use the newer API
-     */
-    if (kd->dev_fd >= 0) {
-        uint64_t addr = kd->kda.addr;
-
-        addr |= kd->kda_addr_ormask;
-        attr->addr = (uintptr_t)&addr;
-        ret = kvm_device_ioctl(kd->dev_fd, KVM_SET_DEVICE_ATTR, attr);
-    } else {
-        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_SET_DEVICE_ADDR, &kd->kda);
-    }
+    addr |= kd->kda_addr_ormask;
+    attr->addr = (uintptr_t)&addr;
+    ret = kvm_device_ioctl(kd->dev_fd, KVM_SET_DEVICE_ATTR, attr);
 
     if (ret < 0) {
         fprintf(stderr, "Failed to set device address: %s\n",
-- 
2.47.0


