Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBC606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXB5LfpH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cLnC3ruL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7G8-0000MU-EX; Wed, 28 Oct 2026 13:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fl-0007Io-Pb
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fg-0003ou-Nd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1DQqXuTAttK1hxHz4tjfw9z5GFQt6te77On/KRpYm8=;
 b=JXB5LfpHx/HxJxIlYjlNocO8ndEytag399LNMby8LyQb8MRAEANZk/4OkOcWFTiSDIg+z/
 DT9s6z9T15m/IYZbbZpW0BTL1i6SwDpjDLctFBYLLnh7ZCepuDMeWEZHf2lgJWlJgq4x/C
 gEEjHYuoNo1bh6bgF4gy98ph6S1TiLE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-XhmXTzq6MouI5X3wndvzqg-1; Wed, 28 Oct 2026 13:15:50 -0400
X-MC-Unique: XhmXTzq6MouI5X3wndvzqg-1
X-Mimecast-MFC-AGG-ID: XhmXTzq6MouI5X3wndvzqg_1793207749
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a210f93860so8591705e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207749; x=1793812549; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u1DQqXuTAttK1hxHz4tjfw9z5GFQt6te77On/KRpYm8=;
 b=cLnC3ruLy8IK7kRUJW6zAvfEXQVU2mmX9ZhTf0syqUKBVbaTyzt185YA1AIeXcQwSf
 3eJMrZ4T/5DfTsRcREtTn/v5d5x+vV2HbGXhFkwA6KvnBVZp2tvz2Ko38UoOnIwItCRS
 /E+wIKf0g5U+yrvtb6augWRWy1pYDeskYghO8FTzArZ5F0oePbCg5tvUFZx9L6b+ROmA
 GEEJAbyNCyl8+G1eBmtzgjwHyR02JM+x6opkm17Jmg1K3JIKqd5vOrIDymYbVTebeKDC
 V+RmEM81nf9Fdj702JwgmutGc1SLiEAF5Nfdt63coio37O/u5eXKITAL8eJye9i6SEpm
 MwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207749; x=1793812549;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u1DQqXuTAttK1hxHz4tjfw9z5GFQt6te77On/KRpYm8=;
 b=NVbSIUXtJbLzP4iRarHkDjM7r1uBu5h4yA55EG5zZcgykYJFVi5svW7Oqz5jInSDPd
 qHJ9KJJuCF+wsWdsQTLINcxG+sjrVrTY2qg+vcLm3u0G1BrPmEVd2MVzLGDcXMEbJKqY
 8eeDS72oVHixMPjKidQDlKQRXCkhpMGaOfMctcx5PEvlT8vDw9X/kL1TnPD2OgTmKrrG
 v7u3pqudtknO9UUztbp5e8b8icu+Wf8J9DxgfwcPExv9jRXLuzvuw12q8EPxclj592xC
 E7sq8iQhLHa4F0jM6FBDLbc9oQwjND4YDM8AV+Yk/hs9U2rpdVEUhY2zYiGBUH3tzaQx
 hDwQ==
X-Gm-Message-State: AFq9FYLeAVvyiGTV649pejxSnaFMDlZmqMNOpnZpKT4EKz1IiNRANdjd
 x9+lEhPk6GxUpmvAnlv1+jA8oFiXJiZPvTtd0td2/aOnPuezBvLo6Me+s+JBldFzfsaZmW6EqPr
 /wbBw7pUzVxnAxyDC+F0Fq9x9j/h+fP8Eip7ajbKOkeeOQotg0j4SjVIysLjE9H7wzjkwTGafdc
 1Q23QIxi/2rQ9CPiTPX7fvpSp9oJVFMLxAqQ==
X-Gm-Gg: AYBFou1xcJw9IIq8CYmpGP0ckd5xoSSPURHE3gdAQ2uA+haeFSVUMKikeIolSGyJpeo
 6eWeUaRYKDoCu7xZ40FJGeedkcsMJNA1XWAECYKC8XDTjQHwSeuirTiFGDH6Ws4+v+AGuTZeeug
 OkTo3/RYxxyBDKQ+VqIMnrN7u/yAz52UhMwWmL+rs4XucC/dovAhUZK72h3Kyyc63tR5WL5h4k5
 V39VwFB4GUae35SBp9Fhe8q4u2xEq9YvjBGjthNgckMlxF2V55NFBeTr0zQX8cIAYrQ1EJ+k1df
 QTkYwOY1Qxx/OudYUGKnhHaLcSIPMLs7DBQUPz2HhQc7eFYeH7G8RrRsMCLCw7RRZuDRkPdLgxy
 WK+qAvMIYfxyhJhDP6ySlLMFGcgKNMRKlsoK8Wzwh
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a9640f1fbdmr69952565e9.4.1793207748892; 
 Wed, 28 Oct 2026 10:15:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a9640f1fbdmr69951815e9.4.1793207748247; 
 Wed, 28 Oct 2026 10:15:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a930a63eb3sm56309415e9.1.2026.10.28.10.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:47 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Vrabel <david.vrabel@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 41/78] hw/pci-bridge: Add generic PCIe switch upstream and
 downstream ports
Message-ID: <f90f7eb8d98298e2d8ab5e75cdd665becdbe536d.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Vrabel <david.vrabel@nutanix.com>

The TI XIO3130 PCIe switch is a vintage Gen1 device, so we add generic
PCIe upstream and downstream port devices that are Gen6.

In guests with pairs of passthrough PCIe devices (e.g, a GPU+NIC pair)
often need to place the devices behind a common (emulated) PCIe switch
so in-guest software (such as NCCL) can correctly determine that P2P
transactions between the devices is possible.

NCCL also needs to be able to determine the available PCIe
bandwidth. If such a guest sees the TI XIO3130 PCIe switch, then it
incorrectly calculates only 2.5 GT/s and x1 is available, but the real
hardware might be 32 GT/s and x16.

Instead of enhancing the existing switch and claiming it is more
capable than the real hardware we add additional generic PCIe upstream
and downstream port devices, which matches the existing generic PCIe
root port device.

The speed and width of the ports are configurable.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260928152431.310363-2-david.vrabel@nutanix.com>
---
 docs/pcie.txt                               |   6 +-
 docs/specs/pci-ids.rst                      |   4 +
 include/hw/pci/pci.h                        |   2 +
 hw/pci-bridge/gen_pcie_downstream_port.c    | 202 ++++++++++++++++++++
 hw/pci-bridge/gen_pcie_upstream_port.c      | 177 +++++++++++++++++
 hw/pci-bridge/meson.build                   |   3 +-
 tests/functional/x86_64/meson.build         |   1 +
 tests/functional/x86_64/test_pcie_switch.py |  98 ++++++++++
 8 files changed, 489 insertions(+), 4 deletions(-)
 create mode 100644 hw/pci-bridge/gen_pcie_downstream_port.c
 create mode 100644 hw/pci-bridge/gen_pcie_upstream_port.c
 create mode 100755 tests/functional/x86_64/test_pcie_switch.py

diff --git a/docs/pcie.txt b/docs/pcie.txt
index df49178311..f12a9daaad 100644
--- a/docs/pcie.txt
+++ b/docs/pcie.txt
@@ -85,7 +85,7 @@ number of PCI Express Root Ports per PCI Express Root Bus is 256.
 
 Prefer grouping PCI Express Root Ports into multi-function devices
 to keep a simple flat hierarchy that is enough for most scenarios.
-Only use PCI Express Switches (x3130-upstream, xio3130-downstream)
+Only use PCI Express Switches (pcie-upstream-port, pcie-downstream-port)
 if there is no more room for PCI Express Root Ports.
 Please see section 4. for further justifications.
 
@@ -120,8 +120,8 @@ Plug only PCI Express devices into PCI Express Ports.
       -device pcie-root-port,id=root_port3,chassis=x2,addr=z.2[,slot=y2][,bus=pcie.0] \
 2.2.3 Plugging a PCI Express device into a Switch:
       -device pcie-root-port,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]  \
-      -device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]          \
-      -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]] \
+      -device pcie-upstream-port,id=upstream_port1,bus=root_port1[,addr=x]          \
+      -device pcie-downstream-port,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]] \
       -device <dev>,bus=downstream_port1
 
 Notes:
diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 261b0f359f..60cb0f7db6 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -100,6 +100,10 @@ PCI devices (other than virtio):
   PCI UFS device (``-device ufs``)
 1b36:0014
   PCI RISC-V IOMMU device
+1b36:0015
+  PCIe Upstream Switch Port (``-device pcie-upstream-port``)
+1b36:0016
+  PCIe Downstream Switch Port (``-device pcie-downstream-port``)
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a..6520886855 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -121,6 +121,8 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
+#define PCI_DEVICE_ID_REDHAT_PCIE_USP    0x0015
+#define PCI_DEVICE_ID_REDHAT_PCIE_DSP    0x0016
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_pcie_downstream_port.c
new file mode 100644
index 0000000000..d9c182e881
--- /dev/null
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c
@@ -0,0 +1,202 @@
+/*
+ * Generic PCI Express Downstream Port emulation
+ *
+ * Copyright (C) 2026 Nutanix, Inc.
+ *
+ * Derived from gen_pcie_root_port.c:
+ *   Copyright (C) 2017 Red Hat Inc
+ *
+ * Derived from xio3130_downstream.c:
+ *   Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>
+ *                       VA Linux Systems Japan K.K.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "qom/object.h"
+
+#define TYPE_GEN_PCIE_DOWNSTREAM_PORT            "pcie-downstream-port"
+OBJECT_DECLARE_SIMPLE_TYPE(GenPCIEDownstreamPort, GEN_PCIE_DOWNSTREAM_PORT)
+
+struct GenPCIEDownstreamPort {
+    PCIESlot parent_obj;
+};
+
+#define GEN_PCIE_DOWNSTREAM_PORT_AER_OFFSET      0x100
+#define GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET \
+    (GEN_PCIE_DOWNSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define GEN_PCIE_DOWNSTREAM_PORT_MSIX_NR_VECTOR  1
+
+
+static int gen_downstream_interrupts_init(PCIDevice *d, Error **errp)
+{
+    int rc;
+
+    rc = msix_init_exclusive_bar(d, GEN_PCIE_DOWNSTREAM_PORT_MSIX_NR_VECTOR,
+                                 0, errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+    } else {
+        msix_vector_use(d, 0);
+    }
+
+    return rc;
+}
+
+static void gen_downstream_interrupts_uninit(PCIDevice *d)
+{
+    msix_uninit_exclusive_bar(d);
+}
+
+static void gen_downstream_write_config(PCIDevice *d, uint32_t address,
+                                        uint32_t val, int len)
+{
+    uint16_t slt_ctl, slt_sta;
+
+    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+}
+
+static void gen_downstream_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+
+    pcie_cap_deverr_reset(d);
+    pcie_cap_slot_reset(d);
+    pcie_cap_arifwd_reset(d);
+    pci_bridge_reset(qdev);
+}
+
+static void gen_downstream_realize(PCIDevice *d, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(d);
+    PCIESlot *s = PCIE_SLOT(d);
+    int rc;
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc = gen_downstream_interrupts_init(d, errp);
+    if (rc < 0) {
+        goto err_bridge;
+    }
+
+    rc = pcie_cap_init(d, 0x90, PCI_EXP_TYPE_DOWNSTREAM, p->port, errp);
+    if (rc < 0) {
+        goto err_int;
+    }
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+    pcie_cap_slot_init(d, s);
+    pcie_cap_arifwd_init(d);
+
+    pcie_chassis_create(s->chassis);
+    rc = pcie_chassis_add_slot(s);
+    if (rc < 0) {
+        error_setg(errp, "Can't add chassis slot, error %d", rc);
+        goto err_cap;
+    }
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, GEN_PCIE_DOWNSTREAM_PORT_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err_chassis;
+    }
+
+    pcie_acs_init(d, GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET);
+
+    return;
+
+err_chassis:
+    pcie_chassis_del_slot(s);
+err_cap:
+    pcie_cap_exit(d);
+err_int:
+    gen_downstream_interrupts_uninit(d);
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void gen_downstream_exitfn(PCIDevice *d)
+{
+    PCIESlot *s = PCIE_SLOT(d);
+
+    pcie_aer_exit(d);
+    pcie_chassis_del_slot(s);
+    pcie_cap_exit(d);
+    gen_downstream_interrupts_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static const VMStateDescription vmstate_gen_pcie_downstream_port = {
+    .name = "pcie-downstream-port",
+    .priority = MIG_PRI_PCI_BUS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pcie_cap_slot_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
+                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
+                     GenPCIEDownstreamPort),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property gen_pcie_downstream_port_props[] = {
+    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
+                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_64),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_32),
+};
+
+static void gen_pcie_downstream_port_class_init(ObjectClass *klass,
+                                                const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->config_write = gen_downstream_write_config;
+    k->realize = gen_downstream_realize;
+    k->exit = gen_downstream_exitfn;
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_DSP;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc = "PCI Express Downstream Port";
+    device_class_set_legacy_reset(dc, gen_downstream_reset);
+    dc->vmsd = &vmstate_gen_pcie_downstream_port;
+    device_class_set_props(dc, gen_pcie_downstream_port_props);
+}
+
+static const TypeInfo gen_pcie_downstream_port_info = {
+    .name          = TYPE_GEN_PCIE_DOWNSTREAM_PORT,
+    .parent        = TYPE_PCIE_SLOT,
+    .instance_size = sizeof(GenPCIEDownstreamPort),
+    .class_init    = gen_pcie_downstream_port_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void gen_pcie_downstream_port_register_types(void)
+{
+    type_register_static(&gen_pcie_downstream_port_info);
+}
+
+type_init(gen_pcie_downstream_port_register_types)
diff --git a/hw/pci-bridge/gen_pcie_upstream_port.c b/hw/pci-bridge/gen_pcie_upstream_port.c
new file mode 100644
index 0000000000..e86eff099f
--- /dev/null
+++ b/hw/pci-bridge/gen_pcie_upstream_port.c
@@ -0,0 +1,177 @@
+/*
+ * Generic PCI Express Upstream Port emulation
+ *
+ * Copyright (C) 2026 Nutanix, Inc.
+ *
+ * Derived from gen_pcie_root_port.c:
+ *   Copyright (C) 2017 Red Hat Inc
+ *
+ * Derived from xio3130_upstream.c:
+ *   Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>
+ *                       VA Linux Systems Japan K.K.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "qom/object.h"
+
+#define TYPE_GEN_PCIE_UPSTREAM_PORT              "pcie-upstream-port"
+OBJECT_DECLARE_SIMPLE_TYPE(GenPCIEUpstreamPort, GEN_PCIE_UPSTREAM_PORT)
+
+struct GenPCIEUpstreamPort {
+    PCIEPort parent_obj;
+
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+};
+
+#define GEN_PCIE_UPSTREAM_PORT_AER_OFFSET        0x100
+#define GEN_PCIE_UPSTREAM_PORT_MSIX_NR_VECTOR    1
+
+static int gen_upstream_interrupts_init(PCIDevice *d, Error **errp)
+{
+    int rc;
+
+    rc = msix_init_exclusive_bar(d, GEN_PCIE_UPSTREAM_PORT_MSIX_NR_VECTOR,
+                                 0, errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+    } else {
+        msix_vector_use(d, 0);
+    }
+
+    return rc;
+}
+
+static void gen_upstream_interrupts_uninit(PCIDevice *d)
+{
+    msix_uninit_exclusive_bar(d);
+}
+
+static void gen_upstream_write_config(PCIDevice *d, uint32_t address,
+                                      uint32_t val, int len)
+{
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+}
+
+static void gen_upstream_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+    GenPCIEUpstreamPort *usp = GEN_PCIE_UPSTREAM_PORT(d);
+
+    pci_bridge_reset(qdev);
+    pcie_cap_deverr_reset(d);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, false);
+}
+
+static void gen_upstream_realize(PCIDevice *d, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(d);
+    int rc;
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc = gen_upstream_interrupts_init(d, errp);
+    if (rc < 0) {
+        goto err_bridge;
+    }
+
+    rc = pcie_cap_init(d, 0x90, PCI_EXP_TYPE_UPSTREAM, p->port, errp);
+    if (rc < 0) {
+        goto err_int;
+    }
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, GEN_PCIE_UPSTREAM_PORT_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err_cap;
+    }
+
+    return;
+
+err_cap:
+    pcie_cap_exit(d);
+err_int:
+    gen_upstream_interrupts_uninit(d);
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void gen_upstream_exitfn(PCIDevice *d)
+{
+    pcie_aer_exit(d);
+    pcie_cap_exit(d);
+    gen_upstream_interrupts_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static const VMStateDescription vmstate_gen_pcie_upstream_port = {
+    .name = "pcie-upstream-port",
+    .priority = MIG_PRI_PCI_BUS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
+        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,
+                       vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj, GenPCIEUpstreamPort),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property gen_pcie_upstream_port_props[] = {
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", GenPCIEUpstreamPort,
+                                speed, PCIE_LINK_SPEED_64),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", GenPCIEUpstreamPort,
+                                width, PCIE_LINK_WIDTH_32),
+};
+
+static void gen_pcie_upstream_port_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->config_write = gen_upstream_write_config;
+    k->realize = gen_upstream_realize;
+    k->exit = gen_upstream_exitfn;
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_USP;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc = "PCI Express Upstream Port";
+    device_class_set_legacy_reset(dc, gen_upstream_reset);
+    dc->vmsd = &vmstate_gen_pcie_upstream_port;
+    device_class_set_props(dc, gen_pcie_upstream_port_props);
+}
+
+static const TypeInfo gen_pcie_upstream_port_info = {
+    .name          = TYPE_GEN_PCIE_UPSTREAM_PORT,
+    .parent        = TYPE_PCIE_PORT,
+    .instance_size = sizeof(GenPCIEUpstreamPort),
+    .class_init    = gen_pcie_upstream_port_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void gen_pcie_upstream_port_register_types(void)
+{
+    type_register_static(&gen_pcie_upstream_port_info);
+}
+
+type_init(gen_pcie_upstream_port_register_types)
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 073aeacf7f..aa9959df04 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -2,7 +2,8 @@ pci_ss = ss.source_set()
 pci_ss.add(when: 'CONFIG_PCI_BRIDGE', if_true: files('pci_bridge_dev.c'))
 pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
-pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c',
+                                                    'gen_pcie_upstream_port.c', 'gen_pcie_downstream_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
 stub_ss.add(files('pci_expander_bridge_stubs.c'))
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index bcdb1ee558..893214e8bb 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -44,6 +44,7 @@ tests_x86_64_system_thorough = [
   'multiprocess',
   'netdev_ethtool',
   'nvme_migration',
+  'pcie_switch',
   'replay',
   'reverse_debug',
   'tuxrun',
diff --git a/tests/functional/x86_64/test_pcie_switch.py b/tests/functional/x86_64/test_pcie_switch.py
new file mode 100755
index 0000000000..7088b85059
--- /dev/null
+++ b/tests/functional/x86_64/test_pcie_switch.py
@@ -0,0 +1,98 @@
+#!/usr/bin/env python3
+#
+# Functional test for generic PCIe switch upstream and downstream ports
+#
+# Copyright (C) 2026 Nutanix, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+
+
+class PCIeSwitchPort(LinuxKernelTest):
+
+    timeout = 120
+
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
+
+    USP_VENDOR_ID = '0x1b36'
+    USP_DEVICE_ID = '0x0015'
+    DSP_VENDOR_ID = '0x1b36'
+    DSP_DEVICE_ID = '0x0016'
+    CLASS_BRIDGE_PCI_PCI = '0x060400'
+
+    def command(self, command: str, expected_result: int = 0):
+        command = f'echo __begin ; {command} ; D="done" ; echo "$?/__$D"'
+        output = exec_command_and_wait_for_pattern(self, command, '__done')
+        lines = output.decode().splitlines()
+        for s, line in enumerate(lines):
+            if line == '__begin':
+                break
+        result = int(lines[-1].split("/")[0])
+        assert result == expected_result
+        return "\n".join(lines[s+1:-1])
+
+    def test_pcie_switch_ports(self):
+        """Boot a q35 VM with a PCIe switch (USP + DSP) and verify topology."""
+        self.require_accelerator('kvm')
+        self.set_machine('q35')
+
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-m', '1G')
+        self.vm.add_args('-device',
+                         'pcie-root-port,id=rp0,slot=0,chassis=0,bus=pcie.0')
+        self.vm.add_args('-device',
+                         'pcie-upstream-port,id=sw-usp,bus=rp0')
+        self.vm.add_args('-device',
+                         'pcie-downstream-port,id=sw-dsp,bus=sw-usp,'
+                         'chassis=1')
+        self.vm.add_args('-append', 'console=ttyS0 rd.rescue')
+
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),
+                           self.ASSET_INITRD.fetch(),
+                           wait_for='Entering emergency mode.')
+        self.wait_for_console_pattern('# ')
+
+        # Capture lspci output, to diagnose failures.
+        #
+        # [0000:00]-+-00.0  8086:29c0
+        #           +-01.0  8086:10d3
+        #           +-02.0-[01-03]----00.0-[02-03]----00.0-[03]--
+        #           +-1f.0  8086:2918
+        #           +-1f.2  8086:2922
+        #           \-1f.3  8086:2930
+        self.command("lspci -vtn")
+        self.command("lspci -vvv")
+        self.command("ls -R /sys/devices/")
+
+        usp_path = "/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0"
+        dsp_path = usp_path + "/0000:02:00.0"
+
+        # Upstream port is expected model.
+        vendor_id = self.command(f'cat {usp_path}/vendor')
+        assert vendor_id == self.USP_VENDOR_ID
+
+        device_id = self.command(f'cat {usp_path}/device')
+        assert device_id == self.USP_DEVICE_ID
+
+        class_code = self.command(f'cat {usp_path}/class')
+        assert class_code == self.CLASS_BRIDGE_PCI_PCI
+
+        # Downstream port is expected model.
+        vendor_id = self.command(f'cat {dsp_path}/vendor')
+        assert vendor_id == self.DSP_VENDOR_ID
+
+        device_id = self.command(f'cat {dsp_path}/device')
+        assert device_id == self.DSP_DEVICE_ID
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
MST


