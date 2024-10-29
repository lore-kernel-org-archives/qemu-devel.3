Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D71D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ntx-0002z0-7K; Tue, 29 Oct 2024 11:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nsE-0000qM-0b
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns7-0007kR-2K
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so72966795e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214659; x=1730819459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uWF1bVue0jp3RIgvuBCykNspwtoTgYc0dfBnutz7ERk=;
 b=fLBQDEtvf44K4GlWtqJCpbBlCfW0Ln7nU5Rx2zN/lVmBKl5m4SvviMAkCnvZLakOH4
 yMfE/vuqtXI41RUU8k1NIs+RoFLjXFpHb2HxFWOY68fHtuaOl/XH+0XLJe+GOrbrMKpq
 qC621i0DMBmPGpSfw5Kssj+6tb5bWnzgXAUIAdpNQjR7crr35zeKzmfIwiJLfPRlgrcV
 oPZ9kwLyiqDKdNcY2Aax2lw2lONcI2zys4IitWodcGIJqeo9bp6cASLBGaKram9DwNIR
 LLjrf8bi/v99YEiezcuO2uohQdVX9MLgmJ8Jg9OI7dj4Xn8hRRxANcL/y0R3iCQywTz2
 fQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214659; x=1730819459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWF1bVue0jp3RIgvuBCykNspwtoTgYc0dfBnutz7ERk=;
 b=tmYR8yFEQrGo8V67HsAFTu1QKh7rTOE4octwHD+9QMVJTYvpVYeGqaXiAXLQPkjwwu
 6Gg+nIPmDX3mmNHzkGEA/4dONzaIILPT13ye0JC02eYyXHe30uE1Obyh31XunSLv5mw6
 LN9mR2eSMLXF8f7o7t/Z0YwpT3dxtTVCg9BC7ydGMEB4OPM8CEqI8LInOveLlRo8JIPy
 ZAeloge7FSTXYdXuGIRWnz0pcYDpIoSjZ7GZFoU4Mhl2OAdP0MQMm2aLjsfhJoKa/Z2T
 EA7549E8011NugUDg+w6S6RMz2izBVv9JGyk9hbF/26+y00KFicD8iA2GhgjSn1251bv
 p5gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ38+Ah4yiK0ZuQtVrqA1LBR7vAL65LyUUF7/IxdCD15MCPdPJdrqy6jlhu3U+9qhlbxqYa1l7QIsV@nongnu.org
X-Gm-Message-State: AOJu0YxIi6npE6cWyhaK5kc72HrcvrWQqGQz3YNh/Iv60hh26f52QLi0
 TajeM/VhmZdrX5GwTliF+ozbtayUM2mAYklZALJYom9iFA2M8PtAfmmyDBCC1PzCaNjuMgK69hR
 e
X-Google-Smtp-Source: AGHT+IHesOqiNZf7/muW4vtiOXktibG9kP49U+9Z2jLrofLw5/lMiFCNSHx3Ap2ta5sCucdyCl0QJg==
X-Received: by 2002:a05:6000:1ccc:b0:37d:4f69:c9b with SMTP id
 ffacd0b85a97d-380611e0c40mr10835699f8f.35.1730214659106; 
 Tue, 29 Oct 2024 08:10:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 18/18] target/arm: kvm: require KVM_CAP_DEVICE_CTRL
Date: Tue, 29 Oct 2024 15:10:48 +0000
Message-Id: <20241029151048.1047247-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

The device control API was added in 2013, assume that it is present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20241024113126.44343-1-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h  | 16 +++++++---------
 hw/intc/arm_gic_kvm.c |  9 +--------
 target/arm/kvm.c      | 17 +++++------------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 4d293618a78..2e6b49bf137 100644
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
index 000afa03631..7b6812c0de2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -42,6 +42,7 @@
 #include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
+    KVM_CAP_INFO(DEVICE_CTRL),
     KVM_CAP_LAST_INFO
 };
 
@@ -691,19 +692,11 @@ static void kvm_arm_set_device_addr(KVMDevice *kd)
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
2.34.1


