Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542D8E6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnEh-0003Qn-Jh; Fri, 30 Jan 2026 07:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1vlnEZ-00037g-7V
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:04:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1vlnEU-0007zz-30
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:04:18 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260130120401epoutp03484654bc66680ae4facf82a91e7e54a5~PgKjxzH-a0037100371epoutp03A
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 12:04:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260130120401epoutp03484654bc66680ae4facf82a91e7e54a5~PgKjxzH-a0037100371epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1769774641;
 bh=MKrBUGbeKRATPluPj1AkGiFEVONs0F6ddzMBHBgA+KY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kd1dx7J9TVZ0hj1+Skj5hrwDfullf/TaOnf2KVAemE7yoEygf2RedmhrNRL0FkVdm
 iytoibgydQyRH0zY7AHZhVW6Wqg14WIWKLFQCnwWcB7l6dC3za3ibBZ2+p0Yj1/D9t
 yOSvicG/FmsL00LhXnHDl1iOB8nJdg4VW13mAp18=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260130120401epcas5p430c865ce35f3c376b7be8c1f484693c1~PgKjXr4nd2155821558epcas5p47;
 Fri, 30 Jan 2026 12:04:01 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4f2ZRh24zmz3hhT4; Fri, 30 Jan
 2026 12:04:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260130120358epcas5p4622fdf1162ebb644c172176217386995~PgKhHsApb1821218212epcas5p4Y;
 Fri, 30 Jan 2026 12:03:58 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260130120357epsmtip27510a9eb5f5890a2c6b27cec832ef1e1~PgKfnAJN70909909099epsmtip2V;
 Fri, 30 Jan 2026 12:03:57 +0000 (GMT)
Date: Fri, 30 Jan 2026 17:33:50 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, arpit.sysdev@gmail.com,
 cpgs@samsung.com
Subject: Re: [PATCH v4 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20260130120350.n7ngrvla5mfkwllo@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20260127152350.00006447@huawei.com>
X-CMS-MailID: 20260130120358epcas5p4622fdf1162ebb644c172176217386995
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_13d05c_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4
References: <CGME20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4@epcas5p2.samsung.com>
 <20250916080736.1266083-1-arpit1.kumar@samsung.com>
 <20260127152350.00006447@huawei.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_13d05c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 27/01/26 03:23PM, Jonathan Cameron wrote:
>On Tue, 16 Sep 2025 13:37:34 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> This patch series refactor existing support for Identify Switch Device
>> and Get Physical Port State by utilizing physical ports (USP & DSP)
>> information stored during enumeration.
>
>Hi Arpit.
>
>So I came back to this series to try and tweak it into being in a state
>for upstreaming.  I made some fairly heavy changes (to push the
>data down to the individual ports where to me it more logically sits)
>but it became apparent to me during this that there is a fundamental
>problem.  This stuff isn't static because it needs to reflect port
>retraining and hotplug events etc.  If we want to store cached
>data we are going to have to deal with updating it from a significant
>number of different places. The perst one you have covered in patch 2
>is an example but there are others.
>
>Now we definitely can do the generation in a neater way, but I've
>come to the conclusion that caching it really doesn't make sense.
>
>Maybe we can do that for the USP, but definitely not DSPs.
>
>Given I did a bunch of refactoring I might as well share it even though
>I'm currently thinking it might not be worth doing:
>
>From 40a8a36f22a6eb053c965231a698c8054d417049 Mon Sep 17 00:00:00 2001
>From: Arpit Kumar <arpit1.kumar@samsung.com>
>Date: Tue, 16 Sep 2025 13:37:35 +0530
>Subject: [PATCH] hw/cxl: Refactored Identify Switch Device & Get Physical Port
> State
>
>Store the physical port info for the USP on reset but refresh
>it on demand for the DSPs as they are hotplug capable.
>
>Enables common data to be used for both of:
>* Identify Switch Device (Opcode 5100h)
>* Get Physical Port State (Opcode 5101h) physical switch FM-API command set.
>
>Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>Co-developed: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>---
>Added a Co-dev as I have modified this a lot from Arpit's v4.
>v5:
>- Create a new header to avoid importing all of cxl_device.h into
>the upstream port emulation.
>- Move the call that caches state to the cxl_upstream_port reset
>  to ensure downstream ports are in place before it is called.
>  Also will make it available from whatever CCI.  If we ever support
>  multiple VCS switches this will need to move an appropriate structure
>  representing whole switch information. With only one USP that is
>  a reasonable place to put full switch info.
>- Downstream ports have more dynamic state (as devices can be
>  hotplugged below them).  As such, only fill in the data at time
>  of request.

Hi Jonathan,
Thanks for the update! The changes look good to me. I do concede that
it requires more dynamic approach. This would help in future command 
support like multiple VCS, MLD etc. I intially refrained from making changes
to individual ports but it does logically fits there and would
optimize the command support.

>---
> include/hw/cxl/cxl_port.h                   |  87 ++++++++
> include/hw/pci-bridge/cxl_downstream_port.h |  11 +
> include/hw/pci-bridge/cxl_upstream_port.h   |   5 +
> hw/cxl/cxl-mailbox-utils.c                  | 210 ++++++++++----------
> hw/pci-bridge/cxl_downstream.c              |  27 +++
> hw/pci-bridge/cxl_upstream.c                |   5 +
> 6 files changed, 245 insertions(+), 100 deletions(-)
> create mode 100644 include/hw/cxl/cxl_port.h
> create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h
>
>diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
>new file mode 100644
>index 000000000000..15960f8b5778
>--- /dev/null
>+++ b/include/hw/cxl/cxl_port.h
>@@ -0,0 +1,87 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+
>+#ifndef CXL_PORT_H
>+#define CXL_PORT_H
>+
>+#include "hw/pci/pci.h"
>+
>+/* Port related commands */
>+#define CXL_MAX_PHY_PORTS 256
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
>+typedef struct CXLPhyPortInfo {
>+    uint8_t port_id;
>+    uint8_t current_port_config_state;
>+    uint8_t connected_device_mode;
>+    uint8_t rsv1;
>+    uint8_t connected_device_type;
>+    uint8_t supported_cxl_modes;
>+    uint8_t max_link_width;
>+    uint8_t negotiated_link_width;
>+    uint8_t supported_link_speeds_vector;
>+    uint8_t max_link_speed;
>+    uint8_t current_link_speed;
>+    uint8_t ltssm_state;
>+    uint8_t first_negotiated_lane_num;
>+    uint16_t link_state_flags;
>+    uint8_t supported_ld_count;
>+} QEMU_PACKED CXLPhyPortInfo;
>+
>+void cxl_init_physical_port_info(PCIDevice *port_dev, CXLPhyPortInfo *info,
>+                                 uint8_t pn,
>+                                 uint8_t current_port_config_state,
>+                                 uint8_t connected_device_type,
>+                                 uint8_t supported_ld_count);
>+
>+/* Common data for CXL USP and DSP */
>+typedef struct CXLSwitchPortData {
>+    CXLPhyPortInfo info;
>+} CXLSwitchPortData;
>+
>+#endif /* CXL_PORT_H */
>diff --git a/include/hw/pci-bridge/cxl_downstream_port.h b/include/hw/pci-bridge/cxl_downstream_port.h
>new file mode 100644
>index 000000000000..c3f058365283
>--- /dev/null
>+++ b/include/hw/pci-bridge/cxl_downstream_port.h
>@@ -0,0 +1,11 @@
>+#ifndef CXL_DOWNSTREAM_PORT_H
>+#define CXL_DOWNSTREAM_PORT_H
>+#include "hw/pci/pcie.h"
>+#include "hw/pci/pcie_port.h"
>+#include "hw/cxl/cxl.h"
>+#include "include/hw/cxl/cxl_port.h"
>+
>+typedef struct CXLDownstreamPort CXLDownstreamPort;
>+CXLPhyPortInfo *cxl_dsp_get_physical_port_info(CXLDownstreamPort *dsp);
>+
>+#endif
>diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
>index e3d6a27acc86..fe367fb66f0c 100644
>--- a/include/hw/pci-bridge/cxl_upstream_port.h
>+++ b/include/hw/pci-bridge/cxl_upstream_port.h
>@@ -4,6 +4,7 @@
> #include "hw/pci/pcie.h"
> #include "hw/pci/pcie_port.h"
> #include "hw/cxl/cxl.h"
>+#include "include/hw/cxl/cxl_port.h"
>
> typedef struct CXLUpstreamPort {
>     /*< private >*/
>@@ -19,6 +20,10 @@ typedef struct CXLUpstreamPort {
>
>     DOECap doe_cdat;
>     uint64_t sn;
>+
>+    CXLSwitchPortData swport_data;
> } CXLUpstreamPort;
>
>+void cxl_set_physical_port_info(CXLUpstreamPort *cxl_usp);
>+
> #endif /* CXL_SUP_H */
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index 2f449980cdc0..f7aa56b0d385 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -13,9 +13,11 @@
> #include "hw/pci/msi.h"
> #include "hw/pci/msix.h"
> #include "hw/cxl/cxl.h"
>+#include "hw/cxl/cxl_port.h"
> #include "hw/cxl/cxl_events.h"
> #include "hw/cxl/cxl_mailbox.h"
> #include "hw/pci/pci.h"
>+#include "hw/pci-bridge/cxl_downstream_port.h"
> #include "hw/pci-bridge/cxl_upstream_port.h"
> #include "qemu/cutils.h"
> #include "qemu/host-utils.h"
>@@ -488,13 +490,21 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
>     return CXL_MBOX_SUCCESS;
> }
>
>-static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
>-                                  void *private)
>+static uint8_t cxl_num_switch_ports(CXLUpstreamPort *usp)
> {
>-    uint8_t *bm = private;
>-    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
>-        uint8_t port = PCIE_PORT(d)->port;
>-        bm[port / 8] |= 1 << (port % 8);
>+    PCIBus *bus = &PCI_BRIDGE(usp)->sec_bus;
>+
>+    return pcie_count_ds_ports(bus) + 1;
>+}
>+
>+static void cxl_mark_dsp_active(PCIBus *bus, PCIDevice *dev, void *opaque)
>+{
>+    uint8_t *bitmask = opaque;
>+
>+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
>+        uint8_t pn = PCIE_PORT(dev)->port;
>+
>+        bitmask[pn / 8] |= (1 << (pn % 8));
>     }
> }
>
>@@ -506,9 +516,9 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
>                                              size_t *len_out,
>                                              CXLCCI *cci)
> {
>-    PCIEPort *usp = PCIE_PORT(cci->d);
>-    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
>-    int num_phys_ports = pcie_count_ds_ports(bus);
>+    CXLUpstreamPort *pp = CXL_USP(cci->d);
>+    uint8_t num_phys_ports = cxl_num_switch_ports(pp);
>+    uint8_t pn;
>
>     struct cxl_fmapi_ident_switch_dev_resp_pl {
>         uint8_t ingress_port_id;
>@@ -525,11 +535,11 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
>
>     out = (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
>     *out = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
>-        .num_physical_ports = num_phys_ports + 1, /* 1 USP */
>+        .num_physical_ports = num_phys_ports,
>         .num_vcss = 1, /* Not yet support multiple VCS - potentially tricky */
>         .active_vcs_bitmask[0] = 0x1,
>-        .total_vppbs = num_phys_ports + 1,
>-        .bound_vppbs = num_phys_ports + 1,
>+        .total_vppbs = num_phys_ports,
>+        .bound_vppbs = num_phys_ports,
>         .num_hdm_decoders_per_usp = 4,
>     };
>
>@@ -541,16 +551,46 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
>         out->ingress_port_id = 0;
>     }
>
>-    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
>+    pn = PCIE_PORT(pp)->port;
>+    out->active_port_bitmask[pn / 8] |= (1 << pn % 8);
>+    pci_for_each_device_under_bus(&PCI_BRIDGE(pp)->sec_bus,
>+                                  cxl_mark_dsp_active,
>                                   out->active_port_bitmask);
>-    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
>
>     *len_out = sizeof(*out);
>
>     return CXL_MBOX_SUCCESS;
> }
>
>-/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
>+static CXLDownstreamPort *cxl_find_dsp_on_bus(PCIBus *bus, uint8_t pn)
>+{
>+
>+    PCIDevice *port_dev = pcie_find_port_by_pn(bus, pn);
>+
>+    if (object_dynamic_cast(OBJECT(port_dev), TYPE_CXL_DSP)) {
>+        return CXL_DSP(port_dev);
>+    }
>+
>+    return NULL;
>+}
>+
>+static CXLPhyPortInfo *cxl_get_phyport_info(CXLUpstreamPort *usp, uint8_t pn)
>+{
>+    CXLDownstreamPort *dsp;
>+
>+    if (usp->swport_data.info.port_id == pn) {
>+        return &usp->swport_data.info;
>+    }
>+
>+    dsp = cxl_find_dsp_on_bus(&PCI_BRIDGE(usp)->sec_bus, pn);
>+    if (dsp) {
>+        return cxl_dsp_get_physical_port_info(dsp);
>+    }
>+
>+    return NULL;
>+}
>+
>+/* CXL r3.2 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
> static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
>                                               size_t len_in,
>@@ -558,44 +598,22 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>                                               size_t *len_out,
>                                               CXLCCI *cci)
> {
>-    /* CXL r3.1 Table 7-17: Get Physical Port State Request Payload */
>+    CXLUpstreamPort *pp = CXL_USP(cci->d);
>+    size_t pl_size;
>+    int i;
>+
>+    /* CXL r3.2 Table 7-17: Get Physical Port State Request Payload */
>     struct cxl_fmapi_get_phys_port_state_req_pl {
>         uint8_t num_ports;
>         uint8_t ports[];
>     } QEMU_PACKED *in;
>
>-    /*
>-     * CXL r3.1 Table 7-19: Get Physical Port State Port Information Block
>-     * Format
>-     */
>-    struct cxl_fmapi_port_state_info_block {
>-        uint8_t port_id;
>-        uint8_t config_state;
>-        uint8_t connected_device_cxl_version;
>-        uint8_t rsv1;
>-        uint8_t connected_device_type;
>-        uint8_t port_cxl_version_bitmask;
>-        uint8_t max_link_width;
>-        uint8_t negotiated_link_width;
>-        uint8_t supported_link_speeds_vector;
>-        uint8_t max_link_speed;
>-        uint8_t current_link_speed;
>-        uint8_t ltssm_state;
>-        uint8_t first_lane_num;
>-        uint16_t link_state;
>-        uint8_t supported_ld_count;
>-    } QEMU_PACKED;
>-
>-    /* CXL r3.1 Table 7-18: Get Physical Port State Response Payload */
>+    /* CXL r3.2 Table 7-18: Get Physical Port State Response Payload */
>     struct cxl_fmapi_get_phys_port_state_resp_pl {
>         uint8_t num_ports;
>         uint8_t rsv1[3];
>-        struct cxl_fmapi_port_state_info_block ports[];
>+        CXLPhyPortInfo ports[];
>     } QEMU_PACKED *out;
>-    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
>-    PCIEPort *usp = PCIE_PORT(cci->d);
>-    size_t pl_size;
>-    int i;
>
>     in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
>     out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
>@@ -608,69 +626,22 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>         return CXL_MBOX_INVALID_INPUT;
>     }
>
>-    /* For success there should be a match for each requested */
>-    out->num_ports = in->num_ports;
>+    if (in->num_ports > cxl_num_switch_ports(pp)) {
>+        return CXL_MBOX_INVALID_INPUT;
>+    }
>
>     for (i = 0; i < in->num_ports; i++) {
>-        struct cxl_fmapi_port_state_info_block *port;
>-        /* First try to match on downstream port */
>-        PCIDevice *port_dev;
>-        uint16_t lnkcap, lnkcap2, lnksta;
>-
>-        port = &out->ports[i];
>-
>-        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
>-        if (port_dev) { /* DSP */
>-            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>-                ->devices[0];
>-            port->config_state = 3;
>-            if (ds_dev) {
>-                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>-                    port->connected_device_type = 5; /* Assume MLD for now */
>-                } else {
>-                    port->connected_device_type = 1;
>-                }
>-            } else {
>-                port->connected_device_type = 0;
>-            }
>-            port->supported_ld_count = 3;
>-        } else if (usp->port == in->ports[i]) { /* USP */
>-            port_dev = PCI_DEVICE(usp);
>-            port->config_state = 4;
>-            port->connected_device_type = 0;
>-        } else {
>+        int pn = in->ports[i];
>+        CXLPhyPortInfo *info = cxl_get_phyport_info(pp, pn);
>+
>+        if (!info) {
>             return CXL_MBOX_INVALID_INPUT;
>         }
>
>-        port->port_id = in->ports[i];
>-        /* Information on status of this port in lnksta, lnkcap */
>-        if (!port_dev->exp.exp_cap) {
>-            return CXL_MBOX_INTERNAL_ERROR;
>-        }
>-        lnksta = port_dev->config_read(port_dev,
>-                                       port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
>-                                       sizeof(lnksta));
>-        lnkcap = port_dev->config_read(port_dev,
>-                                       port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
>-                                       sizeof(lnkcap));
>-        lnkcap2 = port_dev->config_read(port_dev,
>-                                        port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
>-                                        sizeof(lnkcap2));
>-
>-        port->max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>-        port->negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>-        /* No definition for SLS field in linux/pci_regs.h */
>-        port->supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
>-        port->max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>-        port->current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>-        /* TODO: Track down if we can get the rest of the info */
>-        port->ltssm_state = 0x7;
>-        port->first_lane_num = 0;
>-        port->link_state = 0;
>-        port->port_cxl_version_bitmask = 0x2;
>-        port->connected_device_cxl_version = 0x2;
>+        memcpy(&out->ports[i], info, sizeof(*info));
>     }
>
>+    out->num_ports = in->num_ports;
>     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
>     *len_out = pl_size;
>
>@@ -4633,6 +4604,45 @@ void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
>     cxl_rebuild_cel(cci);
> }
>
>+void cxl_init_physical_port_info(PCIDevice *port_dev, CXLPhyPortInfo *info,
>+                                 uint8_t pn,
>+                                 uint8_t current_port_config_state,
>+                                 uint8_t connected_device_type,
>+                                 uint8_t supported_ld_count)
>+{
>+    uint16_t lnkcap, lnkcap2, lnksta;
>+
>+    if (!port_dev->exp.exp_cap) {
>+        return;
>+    }
>+    lnksta = port_dev->config_read(port_dev,
>+                                   port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
>+                                   sizeof(lnksta));
>+    lnkcap = port_dev->config_read(port_dev,
>+                                   port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
>+                                   sizeof(lnkcap));
>+    lnkcap2 = port_dev->config_read(port_dev,
>+                                    port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
>+                                    sizeof(lnkcap2));
>+
>+    *info = (CXLPhyPortInfo) {
>+        .port_id = pn,
>+        .current_port_config_state = current_port_config_state,
>+        .connected_device_mode = CXL_PORT_CONNECTED_DEV_MODE_256B,
>+        .connected_device_type = connected_device_type,
>+        .supported_cxl_modes = CXL_PORT_SUPPORTS_256B,
>+        .max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4,
>+        .negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4,
>+        .supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1,
>+        .max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS,
>+        .current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS,
>+        .ltssm_state = CXL_PORT_LTSSM_L2,
>+        .first_negotiated_lane_num = 0,
>+        .link_state_flags = 0,
>+        .supported_ld_count = supported_ld_count,
>+    };
>+}
>+
> void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                   DeviceState *d, size_t payload_max)
> {
>diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
>index 320818a8f1ce..8611f54ebd0c 100644
>--- a/hw/pci-bridge/cxl_downstream.c
>+++ b/hw/pci-bridge/cxl_downstream.c
>@@ -13,6 +13,7 @@
> #include "hw/pci/msi.h"
> #include "hw/pci/pcie.h"
> #include "hw/pci/pcie_port.h"
>+#include "hw/pci-bridge/cxl_downstream_port.h"
> #include "hw/core/qdev-properties.h"
> #include "hw/core/qdev-properties-system.h"
> #include "hw/cxl/cxl.h"
>@@ -24,6 +25,7 @@ typedef struct CXLDownstreamPort {
>
>     /*< public >*/
>     CXLComponentState cxl_cstate;
>+    CXLSwitchPortData swport_data;
> } CXLDownstreamPort;
>
> #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
>@@ -81,6 +83,31 @@ static void cxl_dsp_config_write(PCIDevice *d, uint32_t address,
>     cxl_dsp_dvsec_write_config(d, address, val, len);
> }
>
>+CXLPhyPortInfo *cxl_dsp_get_physical_port_info(CXLDownstreamPort *dsp)
>+{
>+    CXLPhyPortInfo *info = &dsp->swport_data.info;
>+    uint8_t connected_device_type;
>+    PCIDevice *port_dev = PCI_DEVICE(dsp);
>+    PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(dsp))
>+        ->devices[0];
>+
>+    if (ds_dev) {
>+        if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>+            connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_3_SLD;
>+        } else {
>+            connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
>+        }
>+    } else {
>+        connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
>+    }
>+
>+    cxl_init_physical_port_info(port_dev, info, PCIE_PORT(dsp)->port,
>+                                CXL_PORT_CONFIG_STATE_DSP,
>+                                connected_device_type, 3);
>+
>+    return info;
>+}
>+
> static void cxl_dsp_reset(DeviceState *qdev)
> {
>     PCIDevice *d = PCI_DEVICE(qdev);
>diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
>index fb8d19539c9f..64f31110ff2c 100644
>--- a/hw/pci-bridge/cxl_upstream.c
>+++ b/hw/pci-bridge/cxl_upstream.c
>@@ -103,6 +103,11 @@ static void cxl_usp_reset(DeviceState *qdev)
>     pcie_cap_deverr_reset(d);
>     pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
>     latch_registers(usp);
>+
>+    /* Assume that the info about the upstream link only changes on reset. */
>+    cxl_init_physical_port_info(PCI_DEVICE(usp), &usp->swport_data.info,
>+                                PCIE_PORT(usp)->port, CXL_PORT_CONFIG_STATE_USP,
>+                                CXL_PORT_CONNECTED_DEV_TYPE_NONE, 0);
> }
>
> static void build_dvsecs(CXLUpstreamPort *usp)
>-- 
>2.48.1
>
>
>
>>
>> Additionally, it introduces new support for Physical Port Control
>> of Physical Switch Command Set as per CXL spec r3.2 Section 7.6.7.1.3.
>> It primarily constitutes two logic:
>>     -Assert-Deassert PERST: Assert PERST involves physical port to be in
>>      hold reset phase for minimum 100ms. No other physical port control
>>      request are entertained until Deassert PERST command for the given
>>      port is issued.
>>     -Reset PPB: cold reset of physical port (completing enter->hold->exit
>>      phases).
>>
>> Tested using libcxl-mi interface[1]:
>> All active ports and all opcodes per active port is tested. Also, tested
>> against possible edge cases manually since the interface currently dosen't
>> support run time input.
>>
>> Typical Qemu topology
>> (1 USP + 3 DSP's in a switch with 2 CXLType3 devices connected to the 2 DSP's):
>> FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
>>     -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
>>     -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
>>     -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
>>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>>     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>>     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>>     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>>     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>>     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>>     -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
>>     -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>>     -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
>>     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
>>     -device virtio-rng-pci,bus=swport1"
>>
>> Tested multiple Qemu topologies:
>>         -without any devices connected to downstream ports.
>>         -with virtio-rng-pci devices connected to downstream ports.
>>         -with CXLType3 devices connected to downstream ports.
>>         -with different unique values of ports (both upstream and downstream).
>>
>> Changes from v3 (https://lore.kernel.org/qemu-devel/20250909160316.00000190@huawei.com/T/):
>>         -Namespaced the defines with cleaner prefix for Get Physical Port State
>>          Port Information Block members.
>>         -switch CCI implementation instead of switch FM interface as per
>>          Jonathan's review comments, hence moved perst members initializations
>>          from: cxl_initialize_usp_mctpcci() -> cxl_initialize_mailbox_swcci().
>>
>> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
>>
>> The patches are generated against the Johnathan's tree
>> https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>>
>> Arpit Kumar (2):
>>   hw/cxl: Refactored Identify Switch Device & Get Physical Port State
>>   hw/cxl: Add Physical Port Control (Opcode 5102h)
>>
>>  hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
>>  include/hw/cxl/cxl_device.h               |  76 +++++
>>  include/hw/cxl/cxl_mailbox.h              |   1 +
>>  include/hw/pci-bridge/cxl_upstream_port.h |   9 +
>>  4 files changed, 348 insertions(+), 106 deletions(-)
>>
>

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_13d05c_
Content-Type: text/plain; charset="utf-8"


------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_13d05c_--

