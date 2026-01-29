Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A14D6B088
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb0-0001KS-5o; Thu, 29 Jan 2026 11:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUar-0000i0-Kl
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:07 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUap-0006rD-FD
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so12226455e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703002; x=1770307802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pWS8UbYXRtwCE4I3yw4CO/HHOucmFzMniAylHRoWl7w=;
 b=OZfDxyKlTT98jLOx/OkSZfAGmfsxVmFuY8S92t1Rp17W6imzUNL7CDSQYNafp+KNH3
 77PCqfsARi4O9awQ/4+tKpnAzbh2jXbtgmGcLXFZsI/DSI8t8GbVsSSxVRAw/7i39x1a
 CtrFtQnLhvy5DI5tOmGT8/b+KIHPEaiitKlg4KPP9V9wkxrkg3hNriiH9Y4EWv1jnGez
 YPMDKsahqxCcEzzQz4fk7AouIVPZ3CADgYgdzOv12FJHIV+siHPm8OBfozVcv1uJc73u
 gb6QahYlWttqbxWOto5iZY6rgMji21fMf7B5t9TsOBooQEKCaqe/0o/1o1VNDpRemmc4
 BYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703002; x=1770307802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pWS8UbYXRtwCE4I3yw4CO/HHOucmFzMniAylHRoWl7w=;
 b=IRTYBDqCgPAfqsiPDH/EKZYIxsYlrVdjmH05L0Uo9xC0fPkNFJBMGZVmxj4VTXYJDB
 qMedYcQy8hziGOKiBAMUmqN9FpDxNK8Qj2TgN/gb8ApBsLIji6i7kKtbih556MEPb9B5
 aD/f4nGVRUMqWVU2SqTcBgqn+lqCqVnMjI1T9bgQT1l8SkpuwaB4FbQDkCoPyhStg5bX
 MrOVAiJxshZ+kXXNT7vXO9vB/ZTfKULKXt4LgMYfGOraYktROQFd+AIMR63v3eQH9AxP
 C3MD5yc7TeM1gfhTe2QR/ShWK7W7ZhFZPUMfYCfkRxwAW/CgCVG/VtbP1fvFz8SyDXYP
 +KqA==
X-Gm-Message-State: AOJu0YxiYtuK0mNzUm0fZhdSk+kpdA9SQmHk8FQwBV3rTL/Gl9fmXZBQ
 GtwATssv3FxqNP59uzU7LrVDA6IzEONpZm4Hg1B9LFGOTicLT3Oe2Nrc9EuB9zxDFIiFIlGbGsP
 MkNEde0Q=
X-Gm-Gg: AZuq6aKg9xyWLJNL01y/8LXwu3OGIyXowmeFE/TdAVmeDNQ2I+wSQhGaApZ9nIOT0zV
 8FmpBYc842Ba0Y/1wVLBKojw3JnDhfVk7PKssPYK66DxIJtudJxBy50m7P4RfX9J4v70p4D3kta
 5s2EZAZemZP1FfPhQSznEIgVCY1YMHOgjgq7tsWXRO252gQy3IAXGTEdObyUbXJ7kkuli/R+k6l
 A2bkBOEOg3s6Am8A9bSWHH8dzT3+WPVxygBc0MhJvhbc5gOQC8OYacaK/H+XWigB1Xk1MA3As9/
 Vaec+6iAEn5F+wKrBecU8tsEgrhuQfPP0I7JZZQdReVRo7ZAabAkxaqArk7RVX+pSgQLuFYT6Oa
 MoouOP2bmyhw0OneBdz2Vl5RQW4az6+TrJHZF3k2MTK8GSEqE3Uet6ZHtjnHnQ2zHwMFoj0g1Fo
 friGC+SQAR/GqQsYHK2PM7xcB4KI9S9A==
X-Received: by 2002:a05:600c:4e94:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-48069c0e146mr121154135e9.4.1769703001777; 
 Thu, 29 Jan 2026 08:10:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/43] hw/vfio/pci: Synthesize PASID capability for vfio-pci
 devices
Date: Thu, 29 Jan 2026 16:09:10 +0000
Message-ID: <20260129160917.1415092-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Add support for synthesizing a PCIe PASID extended capability for
vfio-pci devices when PASID is enabled via a vIOMMU and supported by
the host IOMMU backend.

PASID capability parameters are retrieved via IOMMUFD APIs and the
capability is inserted into the PCIe extended capability list using
the insertion helper. A new x-vpasid-cap-offset property allows
explicit control over the placement; by default the capability is
placed at the end of the PCIe extended configuration space.

If the kernel does not expose PASID information or insertion fails,
the device continues without PASID support.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-37-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/vfio/pci.c           | 75 +++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h           |  1 +
 hw/vfio/trace-events    |  1 +
 include/hw/core/iommu.h |  1 +
 4 files changed, 78 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c734472721..36d8fbe872 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 
 #include "hw/core/hw-error.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
@@ -2498,9 +2499,62 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
     return 0;
 }
 
+/*
+ * Try to retrieve PASID capability information via IOMMUFD APIs and,
+ * if supported, synthesize a PASID PCIe extended capability for the
+ * VFIO device.
+ *
+ * Use user-specified PASID capability offset if provided, otherwise
+ * place it at the end of the PCIe extended configuration space.
+ */
+static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    PasidInfo pasid_info;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint16_t pasid_offset;
+
+    if (!hiod) {
+        return true;
+    }
+
+    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc || !hiodc->get_pasid_info ||
+        !hiodc->get_pasid_info(hiod, &pasid_info) ||
+        !(pci_device_get_viommu_flags(pdev) & VIOMMU_FLAG_PASID_SUPPORTED)) {
+        return true;
+    }
+
+    /* Use user-specified offset if set, otherwise place PASID at the end. */
+    if (vdev->vpasid_cap_offset) {
+        pasid_offset = vdev->vpasid_cap_offset;
+    } else {
+        pasid_offset = PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF;
+    }
+
+    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER,
+                                pasid_offset, PCI_EXT_CAP_PASID_SIZEOF)) {
+        error_setg(errp, "vfio: Placing PASID capability at offset 0x%x failed",
+                   pasid_offset);
+        return false;
+    }
+    trace_vfio_pci_synthesize_pasid_cap(vdev->vbasedev.name, pasid_offset);
+
+    pcie_pasid_common_init(pdev, pasid_offset, pasid_info.max_pasid_log2,
+                           pasid_info.exec_perm, pasid_info.priv_mod);
+
+    /* PASID capability is fully emulated by QEMU */
+    memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,
+           PCI_EXT_CAP_PASID_SIZEOF);
+    return true;
+}
+
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    bool pasid_cap_added = false;
+    Error *err = NULL;
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2578,12 +2632,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                 pcie_add_capability(pdev, cap_id, cap_ver, next, size);
             }
             break;
+        /*
+         * VFIO kernel does not expose the PASID CAP today. We may synthesize
+         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
+         * record its presence here so we do not create a duplicate CAP.
+         */
+        case PCI_EXT_CAP_ID_PASID:
+            pasid_cap_added = true;
+            /* fallthrough */
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
 
     }
 
+    if (!pasid_cap_added && !vfio_pci_synthesize_pasid_cap(vdev, &err)) {
+        error_report_err(err);
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
@@ -3756,6 +3822,8 @@ static const Property vfio_pci_properties[] = {
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
+    DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
+                       vpasid_cap_offset, 0),
 };
 
 #ifdef CONFIG_IOMMUFD
@@ -3913,6 +3981,13 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "destination when doing live "
                                           "migration of device state via "
                                           "multifd channels");
+   object_class_property_set_description(klass, /* 11.0 */
+                                          "x-vpasid-cap-offset",
+                                          "PCIe extended configuration space offset at which to place a "
+                                          "synthetic PASID extended capability when PASID is enabled via "
+                                          "a vIOMMU. A value of 0 (default) places the capability at the "
+                                          "end of the extended configuration space. The offset must be "
+                                          "4-byte aligned and within the PCIe extended configuration space");
 }
 
 static const TypeInfo vfio_pci_info = {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 0f78cf9cdb..d6495d7f29 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -187,6 +187,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    uint16_t vpasid_cap_offset;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 466695507b..846e3625c5 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -40,6 +40,7 @@ vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %
 vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
+vfio_pci_synthesize_pasid_cap(const char *name,  uint16_t offset)  "%s offset: 0x%x"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
 vfio_pci_reset_flr(const char *name) "%s FLR/VFIO_DEVICE_RESET"
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index d5401a397b..86af315c15 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -20,6 +20,7 @@
 enum viommu_flags {
     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
 };
 
 /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
-- 
2.43.0


