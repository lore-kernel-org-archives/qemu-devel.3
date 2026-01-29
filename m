Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB34D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUav-0000x0-0M; Thu, 29 Jan 2026 11:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaV-000096-S8
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaU-0006dA-4n
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so972533f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702980; x=1770307780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g7u4vFyrJCbAlZ8RKPYksrp2vL/fqFoBrZQZKiBf15A=;
 b=veu4X71E374WXEvR1FyrvPyjKNZUT45/dMAZGGqic7TakcPdIOMZobzDr2Sr3HW79f
 5aeGCy4yvZYwX9g01OOdBTCr26EYzyNBd9/EJ0zZyd6N1/DX15euUIInPbuzcXYD8AxB
 8VbgmTcE0KTOlXUYTlVGkKICat5+EwkiPxVM4WdH4avlUHvQQW0VrUnGJrcoLLl+6hTa
 4lTuV9n3nKUeVAmm8kyQD1nbfxjcW+4xzo69cQkHMfYN9nKwarg7NC5dLlj0M+ZBzOU0
 474L+uQWFEnKBEU25auH8c2XkDFI1HhJWkqbPyvYHUbzyZ3UaqvC2s9MF09Zq+r6gHtA
 A7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702980; x=1770307780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g7u4vFyrJCbAlZ8RKPYksrp2vL/fqFoBrZQZKiBf15A=;
 b=ShivfiklzsNoxFyqh/OOgimAGmcAO7gi3g72eXlnDVQAMOit088o+IAH0mInJrtAjp
 zynqzeOhzGc1LgYnsn5TfaxgAFCIiXlv6kZgpFgvam8ND0tk1MjShrGC/JL7gfvHMHff
 rEzAxcF7xlA5cq90Hs2LNCuJOw5ki3EEqjhY4Ck0r2A9kkD+6/VRXUGX1RGQNvJlLfHr
 +AnuLKa/3lXDWFQbzv5VKV5BQaPcHQ7NuySKTSkKZG1quB/at7EIMUUf09XUMA8V14zR
 1hUfuaW3AJYXdNBrxjynq3ha9cG7thxNz1P5Kl1Up2TCuO/uoSfrJYp6Pt1S2BrIE35F
 MlZw==
X-Gm-Message-State: AOJu0YwfFN7Tgarg/H6vMY3X4SLvH5NjRn5na9UlZRto+SspvPToueLJ
 ORDbfT+LCRC1dwdjEo6bBv5/Z7GFhZP9z4WC1CUII+9Yd1sWVOO8K+JVQ7F7hV5oOWNp4PdogLo
 3sJgbQmE=
X-Gm-Gg: AZuq6aK1jPJWr+ChFNL8QRxDmnHsCCwOY5ODV5Bp3tR9Gri0bSeShL5v9AaARvF8h9i
 hCjyR414GPJj6s2VKOzYdq9bt4UsSmhPCc0Q8FrUPq6UnpTvc7CNqUsYjDYZl6Mf7PwL2gyOfYo
 eCkDtdyoXs4vzb1QHt9YKGAhKRzC3uqQ+XaIndmOZgqy/I/R8AKiEFvamjxNKsohh+E7yK4q3W1
 jVOdHhiY6UNgyID4dAaL1AnHlm6XajVXUy+FrH9WybhFqNH61gGzq1XEvBpUISKpGqHFCjUZZI/
 t/GPdBeePH7uupHBSZeWBVxnyYX406A7BpLYizMpjrSwBNnkLJhk/sF0qCduybGoar3c8Jxaq/0
 pm1VHX0uAM73U7G0ET5iT1d/ybwWxPEq9/j2WB3HNNQNO50aCH/L/yI9z4f+cxrRd2izRPlv4Ib
 MZX7Kv3mZpqc1F/7szxLtZIjo1xEhBaw==
X-Received: by 2002:a5d:5e01:0:b0:435:95c9:687a with SMTP id
 ffacd0b85a97d-435f3a6b95fmr178387f8f.4.1769702980220; 
 Thu, 29 Jan 2026 08:09:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/43] hw/arm/smmuv3-accel: Implement get_msi_direct_gpa
 callback
Date: Thu, 29 Jan 2026 16:08:51 +0000
Message-ID: <20260129160917.1415092-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
translation (guest Stage-1, host Stage-2). In this mode, the guest Stage-1
tables are programmed directly into hardware, and QEMU must not attempt to
walk them for translation, as doing so is not reliably safe. For vfio-pci
endpoints behind such a vSMMU, the only translation QEMU needs to perform
is for the MSI doorbell used during KVM MSI setup.

Implement the callback so that kvm_arch_fixup_msi_route() can retrieve the
MSI doorbell GPA directly, instead of attempting a software walk of the
guest translation tables.

Also introduce an SMMUv3 device property to carry the MSI doorbell GPA.
This property will be set by the virt machine in a subsequent patch.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-18-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c   | 10 ++++++++++
 hw/arm/smmuv3.c         |  2 ++
 include/hw/arm/smmuv3.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c125974d12..c6ee123cdf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -393,6 +393,15 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_msi_gpa(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    g_assert(s->msi_gpa);
+    return s->msi_gpa;
+}
+
 /*
  * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
  * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
@@ -497,6 +506,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_viommu_flags = smmuv3_accel_get_viommu_flags,
     .set_iommu_device = smmuv3_accel_set_iommu_device,
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
+    .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7a32afd800..6ed9914b1e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1998,6 +1998,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* GPA of MSI doorbell, for SMMUv3 accel use. */
+    DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e54ece2d38..5616a8a2be 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -67,6 +67,7 @@ struct SMMUv3State {
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
     struct SMMUv3AccelState *s_accel;
+    uint64_t msi_gpa;
 };
 
 typedef enum {
-- 
2.43.0


