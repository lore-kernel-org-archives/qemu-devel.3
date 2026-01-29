Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB4BD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaJ-0008SD-7R; Thu, 29 Jan 2026 11:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaG-0008Qt-L9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:28 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaC-0006Ub-UB
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:27 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1042309f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702963; x=1770307763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tOHeTTSLqbsAURnZwmNj8yFq/wlmRq5J+W/kAsI1onY=;
 b=oriCjVY5uUeASIApWZXNjQHLWEDZQDaS7neR6PP6zj0m/JUzOx9XWC1SdFd6AftqmW
 eneF+009st2YaxzzPBLqWEB6rQE7tlgi5cEHM55Q4iqkh2tGPaJ3+2w/5+jiNAMs1/rf
 ls4PuxKuASmDZPO3a3Dh+kvkhelL2haVX4XiIWIZRyITuGvDVvXGgszUxwYGuatBdZPK
 vu9G2scRYczsX7dyJx7j7yGhIj0l/8q/ibGiWUaQmXXYieLviIE3H1msQbHA3E7f5Pp+
 VpWxp9kE63IPeio5XGtmyI/fB3x7dhdSCTNlaTpEBju1OVxFH7EUS2NoYn87L8tyAc1W
 SmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702963; x=1770307763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tOHeTTSLqbsAURnZwmNj8yFq/wlmRq5J+W/kAsI1onY=;
 b=SlHSBG6NGEU9C6cpyHFRDGbpddJzAc4/0kFWSuviM0JtN40BI7H/zJbbe05LrydTLu
 v53DryK1qfprDXzeyaCgkVF/AHYamGdOpJWVVanR4hz4q7CMfNKDwHaiNZedVoFx/eQV
 Pvli9/8Mo8qOhPDxkAoBFPzyvGKQxkahHTKr4nuNP6/Hpwy6jWjTU9tMC87Vb/keXu7m
 t6kOaPQ4ekdotvjECPHIisJN4SBjS9OBKb1TXsZXO4C+BQHvohvjJcnhrfyYeB5tIa9b
 ZKCuI69aeGsfJunYQTlRqW7znQjQIPod6g11Qd11JbqAZaTydS4H9EbhFeID90IXTBEG
 1EXg==
X-Gm-Message-State: AOJu0YwEftHWTar/IEdeAjqeSZJ6ENwYTj+JjTUTMtfXuVtFiD3Rku8n
 Arn0P3MFtNa/Z5XEORBH879ph+wmy0EwpIIRHCHf9z1iNi7H+9/RyhzjDbNlZA6hensoVDwCY+Z
 s2efeY6k=
X-Gm-Gg: AZuq6aLN8l6kMEoMkkJqvvqZllnO0sSpVKi5FUCAr6K9w0VG3Du9IJQr3XLDa9R+lTV
 jeGhwVsX37sc00oVBJr1v4+wZFPIH4oIkgjY/qEN0uJbuCAC0H1O3NiAyl+bWK2A8i0gCnOmroq
 Z8+bhGacJnLf2n6idTpnEfptjy++zpn+zkJR8XnrB/1UMyy4D+OJ1uR052ypC4ivsq7AYwGN3AX
 r/QdnInKMLXoaRG7qHznhdboU46wBbKU9RuF8HGeOC12Hh2UUYn+C0cZXCJt/sRWst8nkNVLLNh
 1VBD50gHvJqKZis9iUHRrCUNHVkusZUtcPvGls5JuEIXbPD1VQRdYKChPc0QA8H5AFs9147qjp7
 fg3DiYI9o/Zpnc0mifDGdvKQKDbPr32A7Bk3Knpk5Iy9dVTNBZq6iyPOJOLnhHV4AL89IYiMwSw
 4NDw5xlZCGTtMYxIS9JLzsZwIxFC3rgw==
X-Received: by 2002:a05:6000:1ac7:b0:42f:b707:56f0 with SMTP id
 ffacd0b85a97d-435f3aaa42fmr144381f8f.37.1769702963384; 
 Thu, 29 Jan 2026 08:09:23 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/43] hw/arm/smmu-common: Factor out common helper functions
 and export
Date: Thu, 29 Jan 2026 16:08:37 +0000
Message-ID: <20260129160917.1415092-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Factor out common helper functions and export. Subsequent patches for
smmuv3 accel support will make use of this.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-4-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c         | 44 +++++++++++++++++++++---------------
 include/hw/arm/smmu-common.h |  6 +++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index cdcfb1343d..1492d7dd95 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -847,12 +847,24 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
-static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
 {
-    SMMUState *s = opaque;
-    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
-    SMMUDevice *sdev;
     static unsigned int index;
+    g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
+                                            index++);
+    sdev->smmu = s;
+    sdev->bus = bus;
+    sdev->devfn = devfn;
+
+    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                             s->mrtypename, OBJECT(s), name, UINT64_MAX);
+    address_space_init(&sdev->as, MEMORY_REGION(&sdev->iommu), name);
+    trace_smmu_add_mr(name);
+}
+
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus)
+{
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
 
     if (!sbus) {
         sbus = g_malloc0(sizeof(SMMUPciBus) +
@@ -861,23 +873,19 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
         g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
     }
 
+    return sbus;
+}
+
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *s = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
+    SMMUDevice *sdev;
+
     sdev = sbus->pbdev[devfn];
     if (!sdev) {
-        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
-
         sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
-
-        sdev->smmu = s;
-        sdev->bus = bus;
-        sdev->devfn = devfn;
-
-        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
-                                 s->mrtypename,
-                                 OBJECT(s), name, UINT64_MAX);
-        address_space_init(&sdev->as,
-                           MEMORY_REGION(&sdev->iommu), name);
-        trace_smmu_add_mr(name);
-        g_free(name);
+        smmu_init_sdev(s, sdev, bus, devfn);
     }
 
     return &sdev->as;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b49b2f27fa..f5060cf36f 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -184,6 +184,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
+/* Return the SMMUPciBus handle associated to a PCI bus */
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
+
+/* Initialize SMMUDevice handle associated to a SMMUPciBus */
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
+
 /* Return the stream ID of an SMMU device */
 static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
-- 
2.43.0


