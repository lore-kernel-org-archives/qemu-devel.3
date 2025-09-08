Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02BBCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcFJ-0005NG-Le; Mon, 08 Sep 2025 09:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uvcFG-0005Mb-17
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:49:22 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uvcF7-0004Tl-75
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:49:21 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250908134904epoutp026ac59d9272c6aafe5e44692dc36f84c6~jUtKx68QG3199931999epoutp02M
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 13:49:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250908134904epoutp026ac59d9272c6aafe5e44692dc36f84c6~jUtKx68QG3199931999epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1757339344;
 bh=sGaPDS2saH3X9SUECYQvX+J9nCjPEyLvWL59wxpiopQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OIgM9WTlCEtgrS/v97uzpOJ5EOGltD6q674uPSpj7cGWYx3nLKRr1HhESiWSuMIEO
 c0nRvn5CMaLY1bu0b9by+mMFu9ruSqErYqWLqiBV12fFFCrk9FkntpznqEtOrNWo+U
 p9Cn63fVU5ZZz53CqXl8vRa9XcR0cFKzK7oaMx+s=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20250908134904epcas5p13c52d6244a611233d93b91563f041e1d~jUtKYMkBD2056020560epcas5p1e;
 Mon,  8 Sep 2025 13:49:04 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.93]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4cL7bM0x2Vz6B9m4; Mon,  8 Sep
 2025 13:49:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250908134902epcas5p3ec8288410f5944964dacec054d73c4a7~jUtIuwC_y3064530645epcas5p3b;
 Mon,  8 Sep 2025 13:49:02 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250908134900epsmtip16f7bffee4fccbc987844e1805ef4ca09~jUtHZkDCt0547905479epsmtip1L;
 Mon,  8 Sep 2025 13:49:00 +0000 (GMT)
Date: Mon, 8 Sep 2025 19:18:56 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH v3 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250908134856.2fexpkb2m4ztxwcn@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250905165953.00006c3c@huawei.com>
X-CMS-MailID: 20250908134902epcas5p3ec8288410f5944964dacec054d73c4a7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f82f6_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904131933epcas5p2ab29fa060d8a7df32a222aad740fedc6
References: <20250904131904.725758-1-arpit1.kumar@samsung.com>
 <CGME20250904131933epcas5p2ab29fa060d8a7df32a222aad740fedc6@epcas5p2.samsung.com>
 <20250904131904.725758-2-arpit1.kumar@samsung.com>
 <20250905165953.00006c3c@huawei.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f82f6_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/09/25 04:59PM, Jonathan Cameron wrote:
>On Thu,  4 Sep 2025 18:49:03 +0530
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
>A few minor things inline.   Biggest one is making sure
>to namespace the defines which is quite challenging to do
>here without a really long name.
>
>Jonathan
>
Hi Jonathan,
Thanks for the review! Will update the changes in next 
iteration v4 of the patch-set.
>> ---
>>  hw/cxl/cxl-mailbox-utils.c                | 230 ++++++++++++----------
>>  include/hw/cxl/cxl_device.h               |  67 +++++++
>>  include/hw/pci-bridge/cxl_upstream_port.h |   8 +
>>  3 files changed, 198 insertions(+), 107 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index c5177dfd92..cb36880f0b 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -435,16 +435,6 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>
>> @@ -555,69 +520,20 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
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
>> +        int pn = in->ports[i];
>>
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
>> +        if (pp->pports.pport_info[pn].port_id != pn) {
>>              return CXL_MBOX_INVALID_INPUT;
>>          }
>> -
>> -        port->port_id = in->ports[i];
>> -        /* Information on status of this port in lnksta, lnkcap */
>> -        if (!port_dev->exp.exp_cap) {
>> -            return CXL_MBOX_INTERNAL_ERROR;
>> -        }
>> -        lnksta = port_dev->config_read(port_dev,
>> -                                       port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
>> -                                       sizeof(lnksta));
>> -        lnkcap = port_dev->config_read(port_dev,
>> -                                       port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
>> -                                       sizeof(lnkcap));
>> -        lnkcap2 = port_dev->config_read(port_dev,
>> -                                        port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
>> -                                        sizeof(lnkcap2));
>> -
>> -        port->max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>> -        port->negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>> -        /* No definition for SLS field in linux/pci_regs.h */
>> -        port->supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
>> -        port->max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>> -        port->current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>> -        /* TODO: Track down if we can get the rest of the info */
>> -        port->ltssm_state = 0x7;
>> -        port->first_lane_num = 0;
>> -        port->link_state = 0;
>> -        port->port_cxl_version_bitmask = 0x2;
>> -        port->connected_device_cxl_version = 0x2;
>> +        memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
>> +               sizeof(CXLPhyPortInfo));
>>      }
>> -
>
>That's a stray change that shouldn't be here.
>
Correct me if I am wrong but the current initializations for the ports are
moved to cxl_set_port_type(), hence this might appear stray in this case due
to eliminations but this is with respect to the response payload of
cmd_get_physical_port_state() so seems apt.
However, one change required would be to move: out->num_ports = in->num_ports; after
the below for loop as it validates the port_id's:
     for (i = 0; i < in->num_ports; i++) {
         int pn = in->ports[i];

         if (pp->pports.pport_info[pn].port_id != pn) {
             return CXL_MBOX_INVALID_INPUT;
         }
         memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
                sizeof(CXLPhyPortInfo));
     }

>>      pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
>>      *len_out = pl_size;
>>
>
>> +static void cxl_set_dsp_port(PCIBus *bus, PCIDevice *dev, void *opaque)
>> +{
>> +    CXLCCI *cci = (CXLCCI *)opaque;
>
>That cast isn't needed.  You can always implicitly cast from a void *
>to another pointer type (and the other way).
>
okay, thanks!
>> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
>> +
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
>> +        cxl_set_port_type(pp, PCIE_PORT(dev)->port, cci);
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
>
>Don't mix and match declarations and non declarations.
>
Sure, I'll keep note of it.
>> +    uint8_t phy_port_num = usp->port;
>> +
>> +    cxl_set_port_type(pp, phy_port_num, cci); /* USP */
>> +    pci_for_each_device_under_bus(bus, cxl_set_dsp_port, cci); /* DSP */
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index 068c20d61e..9fc720ec10 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -129,6 +129,73 @@
>>                    CXL_NUM_CPMU_INSTANCES * (1 << 16),                   \
>>                    (1 << 16))
>>
>> +#define CXL_MAX_PHY_PORTS 256
>> +
>> +/* physical port control info - CXL r3.2 table 7-19 */
>Stick to local style. That makes this
>/* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
>
>
thanks for pointing out!
>> +#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
>> +#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
>> +#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
>> +#define CXL_PORT_CONFIG_STATE_DSP                0x3
>> +#define CXL_PORT_CONFIG_STATE_USP                0x4
>> +#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
>> +#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
>> +
>> +#define NOT_CXL_OR_DISCONNECTED              0x00
>These need a clean prefix like the you have for CONFIG_STATE
>Some of these names are tricky to put concisely.
>
>#define CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN 0x0
>#define CXL_PORT_CONNECTED_DEV_MODE_RCD                0x1
>#define CXL_PORT_CONNECTED_DEV_MODE_68B_VH             0x2
>#define CXL_PORT_CONNECTED_DEV_MODE_256B               0x3
>#define CXL_PORT_CONNECTED_DEV_MODE_LO_256B            0x4
>#define CXL_PORT_CONNECTED_DEV_MODE_PBR                0x5
>
>Is about the shortest that covers what these are.
>Kind of need to retain these are about the device down the
>other end of the wires.  Only one bibblee so can use just 1 character.
>
okay
>> +#define RCD_MODE                             0x01
>> +#define CXL_68B_FLIT_AND_VH_MODE             0x02
>> +#define STANDARD_256B_FLIT_MODE              0x03
>> +#define CXL_LATENCY_OPTIMIZED_256B_FLIT_MODE 0x04
>> +#define PBR_MODE                             0x05
>> +
>> +#define NO_DEVICE_DETECTED              0
>Similar here - also keep to hex to match spec and 2 digits as this one is byte.
>#define CXL_PORT_CONNECTED_DEV_TYPE_NONE       0x00
>#define CXL_PORT_CONNECTED_DEV_TYPE_PCIE       0x01
>etc
>
got it
>> +#define PCIE_DEVICE                     1
>> +#define CXL_TYPE_1_DEVICE               2
>> +#define CXL_TYPE_2_DEVICE_OR_HBR_SWITCH 3
>> +#define CXL_TYPE_3_SLD                  4
>> +#define CXL_TYPE_3_MLD                  5
>> +#define PBR_COMPONENT                   6
>> +
>> +#define CXL_RCD_MODE                    0x00
>> +#define CXL_68B_FLIT_AND_VH_CAPABLE     0x01
>> +#define CXL_256B_FLIT_CAPABLE           0x02
>> +#define CXL_LATENCY_OPTIMIZED_256B_FLIT 0x03
>> +#define CXL_PBR_CAPABLE                 0x04
>This lot are confusing as they are a bits in a bitmap. I'd express them as
>#define CXL_PORT_SUPPORTS_RCD             BIT(0)
>#define CXL_PORT_SUPPORTS_68B_VH          BIT(1)
>etc, matching names with above suggestion on short forms.
>
okay
>> +
>> +#define CXL_LTSSM_DETECT        0x00
>I'd call out the PORT bit for these as they aren't generic
>and that this is the current state.
>
>CXL_PORT_LTSSM_STATE_DETECT  etc
>
>
okay
>> +#define CXL_LTSSM_POLLING       0x01
>> +#define CXL_LTSSM_CONFIGURATION 0x02
>> +#define CXL_LTSSM_RECOVERY      0x03
>> +#define CXL_LTSSM_L0            0x04
>> +#define CXL_LTSSM_L0S           0x05
>> +#define CXL_LTSSM_L1            0x06
>> +#define CXL_LTSSM_L2            0x07
>> +#define CXL_LTSSM_DISABLED      0x08
>> +#define CXL_LTSSM_LOOPBACK      0x09
>> +#define CXL_LTSSM_HOT_RESET     0x0A
>> +
>> +#define LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
>
>Probably stick CXL_PORT_ as prefix for these as well.
>
okay, will update these namespace defines in v4
>> +#define LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
>> +#define LINK_STATE_FLAG_PRSNT            BIT(2)
>> +#define LINK_STATE_FLAG_POWER_OFF        BIT(3)
>> +
>> +typedef struct CXLPhyPortInfo {
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
>> +} QEMU_PACKED CXLPhyPortInfo;
>> +
>>  /* CXL r3.1 Table 8-34: Command Return Codes */
>>  typedef enum {
>>      CXL_MBOX_SUCCESS = 0x0,
>> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
>> index db1dfb6afd..3b7e72bfe0 100644
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
>> @@ -23,6 +24,13 @@ typedef struct CXLUpstreamPort {
>>
>>      DOECap doe_cdat;
>>      uint64_t sn;
>> +
>> +    /*< physical ports information >*/
>
>I believe the magic /*< private >*/ syntax with the <> is special for public/private.
>There are a few other comments marked like that in qemu, but very very few.
>So this probably just wants to be
>
>  /* Physical ports information */
>
got it, thanks for the info!
>> +    struct {
>> +        uint8_t num_ports;
>> +        uint8_t active_port_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
>> +        CXLPhyPortInfo pport_info[CXL_MAX_PHY_PORTS];
>> +    } pports;
>>  } CXLUpstreamPort;
>>
>>  #endif /* CXL_SUP_H */
>

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f82f6_
Content-Type: text/plain; charset="utf-8"


------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f82f6_--

