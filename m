Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD6EE63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpRN-0000yW-8k; Sun, 15 Feb 2026 22:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1vrpRC-0000xD-9g
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:38:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1vrpR7-0001F9-QH
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:38:17 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260216033803epoutp03e6cb27a92b0d385e4f0d025e16a37fcc~UnOpQhJL-0938909389epoutp032
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 03:38:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260216033803epoutp03e6cb27a92b0d385e4f0d025e16a37fcc~UnOpQhJL-0938909389epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1771213083;
 bh=uKS3ZjwCAeZALlQxtmh2UH0cstUqJgCmy1WJqNXpiO8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ghmk4uxoSMFNoq0TL3TzIsT64OBJ/Cqdtwd/Fg6qXm6YiJJW2zPp69O29sp34sPF4
 r/gJoXwt9LHx1kClD20DmshKdjo1d/7PJt5tgkg/XhfNXCQbUBHx7cEGJGFLYUshbU
 2aOA2RgF2C2W0AaibCz+TnO81f1vknxz1OvW36D4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260216033803epcas5p194036e94f18aa3b381d5398664750046~UnOoz779-2067920679epcas5p1L;
 Mon, 16 Feb 2026 03:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4fDpQ30zBfz3hhT3; Mon, 16 Feb
 2026 03:38:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260212152250epcas5p1d68095a3e829d839587ee10a09f16935~TiQ3JktZp0152301523epcas5p1X;
 Thu, 12 Feb 2026 15:22:50 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260212152249epsmtip21f7b94afb98f90e6233367a3a3881ec6~TiQ12Tv_B2335723357epsmtip2k;
 Thu, 12 Feb 2026 15:22:49 +0000 (GMT)
Date: Thu, 12 Feb 2026 20:52:34 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, Ravi Shankar
 <venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Arpit Kumar <arpit.sysdev@gmail.com>,
 cpgs@samsung.com
Subject: Re: [PATCH qemu v5 1/3] hw/cxl: Physical Port Info FMAPI - update
 to current spec and add defines.
Message-ID: <1296674576.21771213083134.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <20260204173223.44122-2-Jonathan.Cameron@huawei.com>
X-CMS-MailID: 20260212152250epcas5p1d68095a3e829d839587ee10a09f16935
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e096_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260212152250epcas5p1d68095a3e829d839587ee10a09f16935
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
 <20260204173223.44122-2-Jonathan.Cameron@huawei.com>
 <CGME20260212152250epcas5p1d68095a3e829d839587ee10a09f16935@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e096_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/26 05:32PM, Jonathan Cameron wrote:
>From: Arpit Kumar <arpit1.kumar@samsung.com>
>
>Add a new cxl/cxl_ports.h header for field definitions related only to port
>commands. Bring field naming up to date with spec as 'version' bitmasks
>have been replaced with bitmasks of the specific features.
>
>Fix a small issue where a reserved value for USP was set to 2 rather
>than 0.
>
>Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>---
>This is effectively lifted out of Arpit's orginal rework.
>Arpit please confirm you are fine with keeping authorship on this one.
>---

Hi Jonathan,
I'm fine with keeping the authorship on this patch and the split looks
good to me. I only noticed a minor extra line, but nothing functional.

Thanks,
Arpit

> include/hw/cxl/cxl_port.h  | 53 ++++++++++++++++++++++++++++++++++++++
> hw/cxl/cxl-mailbox-utils.c | 31 ++++++++++++++--------
> 2 files changed, 73 insertions(+), 11 deletions(-)
>
>diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
>new file mode 100644
>index 000000000000..04db60f7bc23
>--- /dev/null
>+++ b/include/hw/cxl/cxl_port.h
>@@ -0,0 +1,53 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+
>+#ifndef CXL_PORT_H
>+#define CXL_PORT_H
>+
>+/* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
>+#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
>+#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
>+#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
>+#define CXL_PORT_CONFIG_STATE_DSP                0x3
>+#define CXL_PORT_CONFIG_STATE_USP                0x4
>+#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
>+#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
>+
>+#define CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN 0x00
>+#define CXL_PORT_CONNECTED_DEV_MODE_RCD                0x01
>+#define CXL_PORT_CONNECTED_DEV_MODE_68B_VH             0x02
>+#define CXL_PORT_CONNECTED_DEV_MODE_256B               0x03
>+#define CXL_PORT_CONNECTED_DEV_MODE_LO_256B            0x04
>+#define CXL_PORT_CONNECTED_DEV_MODE_PBR                0x05
>+
>+#define CXL_PORT_CONNECTED_DEV_TYPE_NONE            0x00
>+#define CXL_PORT_CONNECTED_DEV_TYPE_PCIE            0x01
>+#define CXL_PORT_CONNECTED_DEV_TYPE_1               0x02
>+#define CXL_PORT_CONNECTED_DEV_TYPE_2_OR_HBR_SWITCH 0x03
>+#define CXL_PORT_CONNECTED_DEV_TYPE_3_SLD           0x04
>+#define CXL_PORT_CONNECTED_DEV_TYPE_3_MLD           0x05
>+#define CXL_PORT_CONNECTED_DEV_PBR_COMPONENT        0x06
>+
>+#define CXL_PORT_SUPPORTS_RCD        BIT(0)
>+#define CXL_PORT_SUPPORTS_68B_VH     BIT(1)
>+#define CXL_PORT_SUPPORTS_256B       BIT(2)
>+#define CXL_PORT_SUPPORTS_LO_256B    BIT(3)
>+#define CXL_PORT_SUPPORTS_PBR        BIT(4)
>+
>+#define CXL_PORT_LTSSM_DETECT        0x00
>+#define CXL_PORT_LTSSM_POLLING       0x01
>+#define CXL_PORT_LTSSM_CONFIGURATION 0x02
>+#define CXL_PORT_LTSSM_RECOVERY      0x03
>+#define CXL_PORT_LTSSM_L0            0x04
>+#define CXL_PORT_LTSSM_L0S           0x05
>+#define CXL_PORT_LTSSM_L1            0x06
>+#define CXL_PORT_LTSSM_L2            0x07
>+#define CXL_PORT_LTSSM_DISABLED      0x08
>+#define CXL_PORT_LTSSM_LOOPBACK      0x09
>+#define CXL_PORT_LTSSM_HOT_RESET     0x0A
>+
>+#define CXL_PORT_LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
>+#define CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
>+#define CXL_PORT_LINK_STATE_FLAG_PRSNT            BIT(2)
>+#define CXL_PORT_LINK_STATE_FLAG_POWER_OFF        BIT(3)
>+
>+#endif /* CXL_PORT_H */
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index 2f449980cdc0..1c8cbe0f682d 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -15,6 +15,7 @@
> #include "hw/cxl/cxl.h"
> #include "hw/cxl/cxl_events.h"
> #include "hw/cxl/cxl_mailbox.h"
>+#include "hw/cxl/cxl_port.h"
> #include "hw/pci/pci.h"
> #include "hw/pci-bridge/cxl_upstream_port.h"
> #include "qemu/cutils.h"
>@@ -565,16 +566,16 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>     } QEMU_PACKED *in;
>
>     /*
>-     * CXL r3.1 Table 7-19: Get Physical Port State Port Information Block
>+     * CXL r3.2 Table 7-19: Get Physical Port State Port Information Block
>      * Format
>      */
>     struct cxl_fmapi_port_state_info_block {
>         uint8_t port_id;
>         uint8_t config_state;
>-        uint8_t connected_device_cxl_version;
>+        uint8_t connected_device_mode;
>         uint8_t rsv1;
>         uint8_t connected_device_type;
>-        uint8_t port_cxl_version_bitmask;
>+        uint8_t supported_cxl_mode_bitmask;
>         uint8_t max_link_width;
>         uint8_t negotiated_link_width;
>         uint8_t supported_link_speeds_vector;
>@@ -623,21 +624,30 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>         if (port_dev) { /* DSP */
>             PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>                 ->devices[0];
>-            port->config_state = 3;
>+            port->config_state = CXL_PORT_CONFIG_STATE_DSP;
>             if (ds_dev) {
>                 if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>-                    port->connected_device_type = 5; /* Assume MLD for now */
>+                    /* Assume MLD for now */
>+                    port->connected_device_type =
>+                        CXL_PORT_CONNECTED_DEV_TYPE_3_MLD;
>                 } else {
>-                    port->connected_device_type = 1;
>+                    port->connected_device_type =
>+                        CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
>+                    port->connected_device_mode =
>+                        CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
>+
I believe this extra line can be removed here.
>                 }
>             } else {
>-                port->connected_device_type = 0;
>+                port->connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
>+                port->connected_device_mode =
>+                    CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
>             }
>             port->supported_ld_count = 3;
>         } else if (usp->port == in->ports[i]) { /* USP */
>             port_dev = PCI_DEVICE(usp);
>-            port->config_state = 4;
>-            port->connected_device_type = 0;
>+            port->config_state = CXL_PORT_CONFIG_STATE_USP;
>+            port->connected_device_type = 0; /* Reserved for USP */
>+            port->connected_device_mode = 0; /* Reserved for USP */
>         } else {
>             return CXL_MBOX_INVALID_INPUT;
>         }
>@@ -667,8 +677,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>         port->ltssm_state = 0x7;
>         port->first_lane_num = 0;
>         port->link_state = 0;
>-        port->port_cxl_version_bitmask = 0x2;
>-        port->connected_device_cxl_version = 0x2;
>+        port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH;
>     }
>
>     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
>-- 
>2.51.0
>

------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e096_
Content-Type: text/plain; charset="utf-8"


------f7ViTShqWaH4cwb2QsCnImCOZYtOsWzJ0r_VhhicrZgGstIh=_1e096_--


