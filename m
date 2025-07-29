Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0B5C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugjw0-0002c7-Aw; Tue, 29 Jul 2025 09:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1ugjvP-0002KZ-GG
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:59:34 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1ugjvH-0006kQ-ED
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:59:21 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250729125900epoutp021ea98cea94ee44d953b64cb07db6ca71~WukvnnWrg2952829528epoutp02i
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 12:59:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250729125900epoutp021ea98cea94ee44d953b64cb07db6ca71~WukvnnWrg2952829528epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1753793940;
 bh=LE+1fYAzEgV3ymBKJYgz9b6QcmY1r9yLG6Sag1PwHPE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HAvWJ24dUyr+2tfNFWZoSS4ebA1CxDwbJrtdMzYnr6IHpP4HUBw6dgbU6i0IV6wum
 zF9ijx2HhD/WKcQPZHVVcKphpL8nhytcvO61U+8JHFuzZy9P7ibbxnxQiC7E4Gjrog
 bZfow05QUHDzabTnn/6WUEHe30R/pKGurYT+sCdw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20250729125859epcas5p4069ee7d166e74d04db5736ed9f4143d2~WukvM7C2g1970619706epcas5p4_;
 Tue, 29 Jul 2025 12:58:59 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4brwQV4kXNz6B9m7; Tue, 29 Jul
 2025 12:58:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20250729125818epcas5p497fce55ca7eb844c087bb45cf972e363~WukJWYdAP1436014360epcas5p4C;
 Tue, 29 Jul 2025 12:58:18 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250729125817epsmtip1a3de0af173178a9ca6a4f3e4918fffed~WukH9V_Vf2938729387epsmtip1d;
 Tue, 29 Jul 2025 12:58:17 +0000 (GMT)
Date: Tue, 29 Jul 2025 18:28:08 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
 cpgs@samsung.com
Subject: Re: [PATCH v2 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250729125808.2xgrmv4yqkpxnl53@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250725155408.000053db@huawei.com>
X-CMS-MailID: 20250729125818epcas5p497fce55ca7eb844c087bb45cf972e363
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_501a3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710144354epcas5p46a083b743de04f5849e3449a4d9dfe87
References: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
 <CGME20250710144354epcas5p46a083b743de04f5849e3449a4d9dfe87@epcas5p4.samsung.com>
 <20250710144338.2839512-2-arpit1.kumar@samsung.com>
 <20250725155408.000053db@huawei.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_501a3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 25/07/25 03:54PM, Jonathan Cameron wrote:
>On Thu, 10 Jul 2025 20:13:37 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> -Storing physical ports info during enumeration.
>> -Refactored changes using physical ports info for
>>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
>>  (Opcode 5101h) physical switch FM-API command set.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>Hi Arpit,
>
>Sorry it took me a while to get to this. I've pretty much forgotten
>the v1, so taking a full fresh look.
>
>
>Various minor comments inline.
>
>Jonathan
>
Hi Jonathan,

Thanks for the review. Will append the changes as suggested in the next
iteration (V3) of the patch series.

Thanks,
Arpit
>> ---
>>  hw/cxl/cxl-mailbox-utils.c                | 229 ++++++++++++----------
>>  include/hw/cxl/cxl_device.h               |  82 ++++++++
>>  include/hw/pci-bridge/cxl_upstream_port.h |   4 +
>>  3 files changed, 207 insertions(+), 108 deletions(-)
>>
>
>
>> @@ -620,69 +585,20 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>          return CXL_MBOX_INVALID_INPUT;
>>      }
>>
>> -    /* For success there should be a match for each requested */
>> -    out->num_ports = in->num_ports;
>> +    if (in->num_ports > pp->pports.num_ports) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>>
>> +    out->num_ports = in->num_ports;
>>      for (i = 0; i < in->num_ports; i++) {
>> -        struct cxl_fmapi_port_state_info_block *port;
>> -        /* First try to match on downstream port */
>> -        PCIDevice *port_dev;
>> -        uint16_t lnkcap, lnkcap2, lnksta;
>> -
>> -        port = &out->ports[i];
>> -
>> -        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
>> -        if (port_dev) { /* DSP */
>> -            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>> -                ->devices[0];
>> -            port->config_state = 3;
>> -            if (ds_dev) {
>> -                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>> -                    port->connected_device_type = 5; /* Assume MLD for now */
>> -                } else {
>> -                    port->connected_device_type = 1;
>> -                }
>> -            } else {
>> -                port->connected_device_type = 0;
>> -            }
>> -            port->supported_ld_count = 3;
>> -        } else if (usp->port == in->ports[i]) { /* USP */
>> -            port_dev = PCI_DEVICE(usp);
>> -            port->config_state = 4;
>> -            port->connected_device_type = 0;
>> -        } else {
>> +        int pn = in->ports[i];
>
>Blank line after declarations.
>
>> +        if (pp->pports.pport_info[pn].port_id != pn) {
>>              return CXL_MBOX_INVALID_INPUT;
>> +        } else {
>
>Returned in the if, so no need for an else here.
>
Thanks for pointing out.
>> +            memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
>> +                   sizeof(struct cxl_phy_port_info));
>>          }
>
>>
>> +static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
>> +                                    CXLCCI *cci)
>> +{
>> +    uint16_t lnkcap, lnkcap2, lnksta;
>> +    PCIBus *bus;
>> +    PCIDevice *port_dev;
>> +    PCIEPort *usp = PCIE_PORT(cci->d);
>> +
>> +    if (usp->port == pnum) {
>> +        port_dev = PCI_DEVICE(usp);
>> +        ports->pports.pport_info[pnum].current_port_config_state =
>> +            CXL_PORT_CONFIG_STATE_USP;
>> +        ports->pports.pport_info[pnum].connected_device_type = NO_DEVICE_DETECTED;
>
>Use local variables for connected_device_type and supported_ld_count;
>Then...
>

>> +    } else {
>> +        bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +        port_dev = pcie_find_port_by_pn(bus, pnum);
>> +        if (port_dev) { /* DSP */
>> +            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>> +                ->devices[0];
>> +            ports->pports.pport_info[pnum].current_port_config_state =
>> +               CXL_PORT_CONFIG_STATE_DSP;
>> +            if (ds_dev) {
>> +                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>> +                    /* To-do: controllable */
>> +                    ports->pports.pport_info[pnum].connected_device_type =
>> +                        CXL_TYPE_3_SLD;
>> +                } else {
>> +                    ports->pports.pport_info[pnum].connected_device_type = PCIE_DEVICE;
>> +                }
>> +            } else {
>> +                ports->pports.pport_info[pnum].connected_device_type = NO_DEVICE_DETECTED;
>> +            }
>> +            ports->pports.pport_info[pnum].supported_ld_count = 3;
>> +        } else {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +    }
>> +
>> +    if (!port_dev->exp.exp_cap) {
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +    lnksta = port_dev->config_read(port_dev,
>> +                                   port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
>> +                                   sizeof(lnksta));
>> +    lnkcap = port_dev->config_read(port_dev,
>> +                                   port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
>> +                                   sizeof(lnkcap));
>> +    lnkcap2 = port_dev->config_read(port_dev,
>> +                                    port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
>> +                                    sizeof(lnkcap2));
>> +
>Can fill this whole thing with
>    ports->pports.pport_info[pnum] = (CXLPhysicalPortInfo) {
>       .connected_device_type = connected_device_type,
>       .supported_ld_count = supported_ld_count,
>       .max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4,
>etc.
>   };
got it.
>> +    ports->pports.pport_info[pnum].max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>> +    ports->pports.pport_info[pnum].negotiated_link_width =
>> +        (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>> +    ports->pports.pport_info[pnum].supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
>> +    ports->pports.pport_info[pnum].max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>> +    ports->pports.pport_info[pnum].current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>> +
>> +    ports->pports.pport_info[pnum].port_id = pnum;
>> +    ports->pports.active_port_bitmask[pnum / 8] |= (1 << pnum % 8);
>> +    ports->pports.pport_info[pnum].ltssm_state = LTSSM_L2;
>> +    ports->pports.pport_info[pnum].first_negotiated_lane_num = 0;
>> +    ports->pports.pport_info[pnum].link_state_flags = 0;
>> +    ports->pports.pport_info[pnum].supported_cxl_modes = CXL_256B_FLIT_CAPABLE;
>> +    ports->pports.pport_info[pnum].connected_device_mode = STANDARD_256B_FLIT_MODE;
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +static void cxl_set_dsp_port(PCIBus *bus, PCIDevice *dev, void *opaque)
>> +{
>> +    CXLCCI *cci = (CXLCCI *)opaque;
>> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
>> +
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
>> +        uint8_t phy_port_num = PCIE_PORT(dev)->port;
>
>Does the local variable add anything over
>
>        cxl_set_port_type(pp, PCIE_PORT(dev)->port, cci);
>
got it.
>> +        cxl_set_port_type(pp, phy_port_num, cci);
>> +    }
>> +}
>> +
>> +static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
>> +{
>> +    PCIEPort *usp = PCIE_PORT(cci->d);
>> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
>> +    int num_phys_ports = pcie_count_ds_ports(bus) + 1;
>> +    pp->pports.num_ports = num_phys_ports;
>> +    uint8_t phy_port_num =  usp->port;
>
>Seems to be an extra space after =
>
thanks for pointing out.
>> +
>> +    cxl_set_port_type(pp, phy_port_num, cci); /* USP */
>> +    pci_for_each_device_under_bus(bus, cxl_set_dsp_port, cci); /* DSP */
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index ca515cab13..1fa6cf7536 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -127,6 +127,88 @@
>>                    CXL_NUM_CHMU_INSTANCES * (1 << 16),                   \
>>                    (1 << 16))
>>
>> +#define CXL_MAX_PHY_PORTS 256
>> +
>> +#define LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
>> +#define LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
>> +#define LINK_STATE_FLAG_PRSNT            BIT(2)
>> +#define LINK_STATE_FLAG_POWER_OFF        BIT(3)
>> +
>> +/* physical port control info - CXL r3.2 table 7-19 */
>> +#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
>> +#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
>> +#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
>> +#define CXL_PORT_CONFIG_STATE_DSP                0x3
>> +#define CXL_PORT_CONFIG_STATE_USP                0x4
>> +#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
>> +#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
>> +
>> +typedef enum {
>> +    NOT_CXL_OR_DISCONNECTED = 0x00,
>> +    RCD_MODE = 0x01,
>> +    CXL_68B_FLIT_AND_VH_MODE = 0x02,
>> +    STANDARD_256B_FLIT_MODE = 0x03,
>> +    CXL_LATENCY_OPTIMIZED_256B_FLIT_MODE = 0x04,
>> +    PBR_MODE = 0x05
>> +} connected_device_mode;
>> +
>> +typedef enum {
>> +    NO_DEVICE_DETECTED = 0,
>> +    PCIE_DEVICE = 1,
>> +    CXL_TYPE_1_DEVICE = 2,
>> +    CXL_TYPE_2_DEVICE_OR_HBR_SWITCH = 3,
>> +    CXL_TYPE_3_SLD = 4,
>> +    CXL_TYPE_3_MLD = 5,
>> +    PBR_COMPONENT = 6
>> +} connected_device_type;
>> +
>> +typedef enum {
>> +    CXL_RCD_MODE = 0x00,
>> +    CXL_68B_FLIT_AND_VH_CAPABLE = 0x01,
>> +    CXL_256B_FLIT_CAPABLE = 0x02,
>> +    CXL_LATENCY_OPTIMIZED_256B_FLIT = 0x03,
>> +    CXL_PBR_CAPABLE = 0x04
>> +} supported_cxl_modes;
>
>Similar to below. Enums make sense when we actually
>use the type.  Apply this comment to all the others above.
>
>
okay, got it.
>> +
>> +typedef enum {
>> +    LTSSM_DETECT = 0x00,
>> +    LTSSM_POLLING = 0x01,
>> +    LTSSM_CONFIGURATION = 0x02,
>> +    LTSSM_RECOVERY = 0x03,
>> +    LTSSM_L0 = 0x04,
>> +    LTSSM_L0S = 0x05,
>> +    LTSSM_L1 = 0x06,
>> +    LTSSM_L2 = 0x07,
>> +    LTSSM_DISABLED = 0x08,
>> +    LTSSM_LOOPBACK = 0x09,
>> +    LTSSM_HOT_RESET = 0x0A
>> +} LTSSM_State;
>
>No Underscore.  Qemu enum type naming is CammelCase
>However I'm not a fan of an enum for this stuff unless we
>actually use that type to enforce something.
>
>I'd just use a set of defines.  However they'll want
>some suitable prefix.  They are PCI terms but I can't
>find a similar assignment of values in the PCI spec, so
>CXL_LTSMM_x I think.
>
>
>
got it, thanks for the info.
>> +
>> +/* CXL r3.2 Table 7-19: Port Info */
>> +struct cxl_phy_port_info {
>typedef CXLPhyPortInfo {
>} CXLPhyPortInfo;
>See comment on QEMU use of typedefs below.
>
>We aren't always doing this right in the CXL code, but lets not make it worse!
>> +    uint8_t port_id;
>> +    uint8_t current_port_config_state;
>> +    uint8_t connected_device_mode;
>> +    uint8_t rsv1;
>> +    uint8_t connected_device_type;
>> +    uint8_t supported_cxl_modes;
>> +    uint8_t max_link_width;
>> +    uint8_t negotiated_link_width;
>> +    uint8_t supported_link_speeds_vector;
>> +    uint8_t max_link_speed;
>> +    uint8_t current_link_speed;
>> +    uint8_t ltssm_state;
>> +    uint8_t first_negotiated_lane_num;
>> +    uint16_t link_state_flags;
>> +    uint8_t supported_ld_count;
>> +} QEMU_PACKED;
>> +
>> +struct phy_port {
>
>Should prefix this I think and it looks to be plural so
>struct cxl_phy_ports maybe?
>
okay.
>Actually given it's exposed outside one file we should follow
>QEMU naming style and a typedef.
>https://qemu-project.gitlab.io/qemu/devel/style.html#typedefs
>
>CXLPhysicalPorts perhaps?
>
>Or thinking more, do we need this definition at all as it
>only gets instantiated in CXLUpstreamPort
>See below.
>
Thanks for the reference.
>> +    uint8_t num_ports;
>> +    uint8_t active_port_bitmask[0x20];
>
>Can we derive that 0x20 ?  I'm guessing it's CXL_MAX_PHY_PORTS / BITS_PER_BYTE
>
got it.
>> +    struct cxl_phy_port_info pport_info[CXL_MAX_PHY_PORTS];
>> +};
>> +
>>  /* CXL r3.1 Table 8-34: Command Return Codes */
>>  typedef enum {
>>      CXL_MBOX_SUCCESS = 0x0,
>> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
>> index db1dfb6afd..bcd3002cf8 100644
>> --- a/include/hw/pci-bridge/cxl_upstream_port.h
>> +++ b/include/hw/pci-bridge/cxl_upstream_port.h
>> @@ -4,6 +4,7 @@
>>  #include "hw/pci/pcie.h"
>>  #include "hw/pci/pcie_port.h"
>>  #include "hw/cxl/cxl.h"
>> +#include "include/hw/cxl/cxl_device.h"
>>
>>  typedef struct CXLUpstreamPort {
>>      /*< private >*/
>> @@ -23,6 +24,9 @@ typedef struct CXLUpstreamPort {
>>
>>      DOECap doe_cdat;
>>      uint64_t sn;
>> +
>> +    /*< physical ports information >*/
>> +    struct phy_port pports;
>
>No need for type I think.
>    struct {
>        uint8_t num;
>        uint8_t active_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
>        CXLPhyPortInto info;
>    } pports;
>
>As they all only exists as part of pports, no need say they are phy
>ports related in the parameter names.
>
got it.
>>  } CXLUpstreamPort;
>>
>>  #endif /* CXL_SUP_H */
>

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_501a3_
Content-Type: text/plain; charset="utf-8"


------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_501a3_--

