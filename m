Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5E3C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqDz-0000VN-KX; Wed, 21 Feb 2024 12:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3IjDWZQwKChE4rszyv9Avwr4x55x2v.t537v3B-uvCv2454x4B.58x@flex--nabihestefan.bounces.google.com>)
 id 1rcqDy-0000V8-4C
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:17:38 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3IjDWZQwKChE4rszyv9Avwr4x55x2v.t537v3B-uvCv2454x4B.58x@flex--nabihestefan.bounces.google.com>)
 id 1rcqDj-0007iu-Ck
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:17:37 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc64e0fc7c8so9572231276.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708535842; x=1709140642; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7LpRySPaP0CHOH79hBVtR1tsWRZD/BKE7TKJiIenQ5A=;
 b=EaR/Jenplj9N9FDsmbKtqww0IcMUblXUHo0vdW47/hqHAeP9tFzGj/szxoashm3Xdg
 3f4LED0Wt/eiKrd06x1A+jGYhAGoYyu3dUsX2zOxS1/h9HTOx+lzO8UFzt8dfaDiTobr
 QJpFZy+ihpz+JbH6kNMvuiK9bQESySra52Une+lm2g6w05XWw3pIdzfyBZTvuGRed4Ej
 LDQoR6Eb7kMAd3hglvFOnytpYExIyaF7XemnuDUy/p9WIz09oKPWw976F61DEU6vhOn/
 8URjgM/RvK1wcSw3rX0T/du/nOWGa8Foa0HHgizPAx0GdBZ/j3FK3TfszqI6DDIsft2i
 0esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708535842; x=1709140642;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7LpRySPaP0CHOH79hBVtR1tsWRZD/BKE7TKJiIenQ5A=;
 b=fY5d4MpCNcsFmZsel4yKbIdLWUM7WaZDFmaUkzWGXc5RaI7JbDP+xoZjI4pxMYx624
 VAyrWqEibkxw3wC1HbelZ7TJO7C0Tufd8mLyitJBi8YuK/FfaRaFQTfhzAV1W6bFCNNN
 4ra3O0lQGTuhMmVDbl9ckcs+5pDi1ai7NhQqZszTdUkuKbIxc2OIwl9B0z1WMr1bDZ1G
 H1SRSFuLBAEzJxCcqjm3l4AoMGmnO7Hr6+S1BsJrW3o3hIhZPsIlr+igqNkad8XfhUGz
 OyTm/H0cvsNaoie43zB+fpxNgb1iSu5Os9w0U6zg4xes4/iN/cnAP1aKj4NqaVpUD5EI
 XhmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8W1JbEcisBqD+07pXpiOvZ4otowPZNydzDS7B54h7fumcxcI0Ya+WxqqjWaiYTK3DXNsjaCVRtC3J5ZLzk1xqmt6z6Tg=
X-Gm-Message-State: AOJu0YxqXueC8j2aBw6N8GfITCYRQAtF75szyv9meP/YzYkQ48wd2+ru
 9jKUV6vcL+aKJzwvZxlne8MGhSNCa49zYQtl+AyRNJPXRIGi4H3Olb7rZyOSm16f2hmQTsdKtjZ
 8cEF6u9m3AtV/4o2JJYq4wCuWQw==
X-Google-Smtp-Source: AGHT+IFq05j1ZDpzfKSBRyL0w7k2B6acgaENYw7bFsnKtGNTF3koo0OHtMD+T3OvgaYx4KwOs4IFD5Xe88DNY4IjC4E=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with
 SMTP id w1-20020a056902100100b00dcc79abe522mr778978ybt.11.1708535842359; Wed,
 21 Feb 2024 09:17:22 -0800 (PST)
Date: Wed, 21 Feb 2024 17:17:16 +0000
In-Reply-To: <20240221171716.1260192-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240221171716.1260192-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221171716.1260192-3-nabihestefan@google.com>
Subject: [PATCH 2/2] hw/arm/smmu-common: Create virtual function for
 implementation defined StreamID
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, eric.auger@redhat.com, 
 roqueh@google.com, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3IjDWZQwKChE4rszyv9Avwr4x55x2v.t537v3B-uvCv2454x4B.58x@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Roque Arcudia Hernandez <roqueh@google.com>

According to the SMMU specification the StreamID construction and size is
IMPLEMENTATION DEFINED, the size being between 0 and 32 bits.

This patch creates virtual functions get_sid and get_iommu_mr to allow different
implementations of how the StreamID is constructed via inheritance. The default
implementation of these functions will match the current ones where the BDF is
used directly as StreamID.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/arm/smmu-common.c         | 12 ++++++++++++
 include/hw/arm/smmu-common.h | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 4caedb4998..14b3240a88 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -621,6 +621,11 @@ static const PCIIOMMUOps smmu_ops = {
 };
 
 IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
+{
+    return ARM_SMMU_GET_CLASS(s)->get_iommu_mr(s, sid);
+}
+
+static IOMMUMemoryRegion *smmu_base_iommu_mr(SMMUState *s, uint32_t sid)
 {
     uint8_t bus_n, devfn;
     SMMUPciBus *smmu_bus;
@@ -659,6 +664,11 @@ void smmu_inv_notifiers_all(SMMUState *s)
     }
 }
 
+static uint32_t smmu_base_get_sid(SMMUDevice *sdev)
+{
+    return PCI_BUILD_BDF(pci_bus_num(sdev->bus), sdev->devfn);
+}
+
 static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
     SMMUState *s = ARM_SMMU(dev);
@@ -709,6 +719,8 @@ static void smmu_base_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_realize(dc, smmu_base_realize,
                                     &sbc->parent_realize);
     rc->phases.hold = smmu_base_reset_hold;
+    sbc->get_sid = smmu_base_get_sid;
+    sbc->get_iommu_mr = smmu_base_iommu_mr;
 }
 
 static const TypeInfo smmu_base_info = {
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5ec2e6c1a4..d53121fe37 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -131,6 +131,9 @@ typedef struct SMMUIOTLBKey {
     uint8_t level;
 } SMMUIOTLBKey;
 
+#define TYPE_ARM_SMMU "arm-smmu"
+OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
+
 struct SMMUState {
     /* <private> */
     SysBusDevice  dev;
@@ -147,6 +150,9 @@ struct SMMUState {
     PCIBus *primary_bus;
 };
 
+typedef uint32_t GetSidFunc(SMMUDevice *obj);
+typedef IOMMUMemoryRegion *GetIommuMr(SMMUState *s, uint32_t sid);
+
 struct SMMUBaseClass {
     /* <private> */
     SysBusDeviceClass parent_class;
@@ -154,19 +160,19 @@ struct SMMUBaseClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
+    GetSidFunc *get_sid;
+    GetIommuMr *get_iommu_mr;
 
 };
 
-#define TYPE_ARM_SMMU "arm-smmu"
-OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
-
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
 /* Return the stream ID of an SMMU device */
-static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
+static inline uint32_t smmu_get_sid(SMMUDevice *sdev)
 {
-    return PCI_BUILD_BDF(pci_bus_num(sdev->bus), sdev->devfn);
+    SMMUState *s = sdev->smmu;
+    return ARM_SMMU_GET_CLASS(s)->get_sid(sdev);
 }
 
 /**
-- 
2.44.0.rc0.258.g7320e95886-goog


