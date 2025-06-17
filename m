Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3B7C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 10:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRTSc-0000W8-HT; Tue, 17 Jun 2025 06:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uRTSU-0000U5-SZ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:22:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uRTSD-0004JV-Gj
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:22:25 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250617102136epoutp02135c9642f78c044349de81f7cf453540~JzVU9Yu5u1444614446epoutp02o
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 10:21:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250617102136epoutp02135c9642f78c044349de81f7cf453540~JzVU9Yu5u1444614446epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1750155696;
 bh=CG3+H2O+UZYPqjsOzInsfUIOTMBP6kA1rkcUY/+fCeM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UyTM4IBNw6RAxjKlkD9NtH2Hxa90mHLlHaLQufY+cEHU/fUOHx6ii39hg9+9iK76+
 YP5GEifq2npzQMK+7541/z69GJJ8xWI45ZgxeW5jYn+YoFeNn7/+lAkbz9sXqZW4I1
 7/i60C/SX/Y9muOl1GDilnabVxsvTlCt7kjxUjIU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20250617102135epcas5p341f90ed97b9d0998a223ecd6f910551d~JzVUmTzf21188511885epcas5p3e;
 Tue, 17 Jun 2025 10:21:35 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.176]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4bM2wG2NDPz2SSKg; Tue, 17 Jun
 2025 10:21:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20250617094638epcas5p4631d6264ffcdc4e97f70f6e6c19171c4~Jy2zUlhnz2240422404epcas5p4g;
 Tue, 17 Jun 2025 09:46:38 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250617094637epsmtip186267f2606d5eab7dd41e77f4df3ba9e~Jy2yBTd-N0484804848epsmtip1F;
 Tue, 17 Jun 2025 09:46:36 +0000 (GMT)
Date: Tue, 17 Jun 2025 15:16:25 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 1/3] hw/cxl: Storing physical ports info during enumeration
Message-ID: <20250617094625.i2j7ewin7fy2b2nj@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250610152121.00004dda@huawei.com>
X-CMS-MailID: 20250617094638epcas5p4631d6264ffcdc4e97f70f6e6c19171c4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a598b_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
 <CGME20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac@epcas5p2.samsung.com>
 <20250602135942.2773823-2-arpit1.kumar@samsung.com>
 <20250610152121.00004dda@huawei.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a598b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 10/06/25 03:21PM, Jonathan Cameron wrote:
>On Mon,  2 Jun 2025 19:29:40 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> Physical ports info is stored for both mailbox cci &
>> mctp based cci type as per spec CXL r3.2 Table 8-230: Physical Switch
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>Hi Arpit,
>
>Sorry for slow response. I got behind on reviews in general and missed
>this in the backlog!
>
>Anyhow, main comment is that this is mostly a refactor that only makes
>sense in a single patch with what you have in patch 2.
>
>Don't introduce duplicate infrastructure for so few usecases.  It means
>we can't just look at he diff and see what was added vs what was removed.
>Much cleaner to just have a single refactoring patch.

Thanks Jonathan for the review. Will combine the first 2 patches and
apply changes as suggested in the next iteration(V2) of the patch
series.
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++++++++++++++++++++++++
>>  include/hw/cxl/cxl_device.h |  28 ++++++
>>  2 files changed, 194 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index a02d130926..680055c6c0 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -124,6 +124,64 @@ enum {
>>          #define GET_MHD_INFO 0x0
>>  };
>>
>> +/* link state flags */
>Naming makes that clear (which is great) so I'd drop the comment.
>
okay
>> +#define LINK_STATE_FLAG_LANE_REVERSED    (1 << 0)
>
>BIT(0) from qemu/bitops.h
>
got it
>> +#define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
>> +#define LINK_STATE_FLAG_PRSNT            (1 << 2)
>> +#define LINK_STATE_FLAG_POWER_OFF        (1 << 3)
>> +
>> +/* physical port control info - CXL r3.2 table 7-19 */
>> +typedef enum {
>> +    PORT_DISABLED = 0,
>> +    BIND_IN_PROGRESS = 1,
>> +    UNBIND_IN_PROGRESS = 2,
>> +    DSP = 3,
>> +    USP = 4,
>> +    FABRIC_PORT = 5,
>> +    INVALID_PORT_ID = 15
>> +} current_port_config_state;
>
>These aren't used as types really but more as defines.
>Hence I'd be tempted to make them defines. Also provide
>defines for the masks.
>
>Namespace the defines so it is obvious which field
>they are in.
>
Will the below changes be the right way to proceed?
#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1 etc.

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
>> +
>>  /* CCI Message Format CXL r3.1 Figure 7-19 */
>>  typedef struct CXLCCIMessage {
>>      uint8_t category;
>> @@ -3686,6 +3744,112 @@ void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
>>      cxl_rebuild_cel(cci);
>>  }
>>
>> +static CXLRetCode cxl_set_port_type(struct phy_port *ports, int pnum,
>> +                                    CXLCCI *cci)
>> +{
>> +    PCIDevice *port_dev;
>> +    uint16_t lnkcap, lnkcap2, lnksta;
>> +    int i = pnum;
>I'd just use pnum for all the indexes.  This local variable doesn't add
>much readability.
>
okay
>> +    if (!cci) {
>
>As below. No need to defend against bugs so only check if there is a
>chance cci might not be set.
>
right, thanks for pointing out.
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>
>Don't interleave declarations and cod.e
>
got it
>> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +    PCIEPort *usp = PCIE_PORT(cci->d);
>
>blank line after declarations - of include this
>in the declarations as
>    PCIEDevice *port_dev = pcie_find_port_by_pn(bus, i);
>
>However that is reasonable expensive, so maybe do the usp case first?
>
got it
>
>> +    port_dev = pcie_find_port_by_pn(bus, i);
>> +
>> +    if (port_dev) { /* DSP */
>> +        PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>> +            ->devices[0];
>> +        ports->pport_info[i].port_id = i;
>
>This is not affected by USP or DSP, so drop it out of this if / else.
>
okay
>> +        ports->pport_info[i].current_port_config_state = DSP;
>> +        ports->active_port_bitmask[i / 8] |= (1 << i % 8);
>
>As below - this is currently set but not read, so I'd bring it in as part of
>the patch that uses it.
>
>Independent of port type, so doesn't belong in the if/else.
>
okay
>
>> +        if (ds_dev) {
>> +            if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>> +                ports->pport_info[i].connected_device_type = CXL_TYPE_3_MLD;
>
>Hmm. We should make this controllable (vs SLD).  I made this up in the existing
>code and probably shouldn't have done :(
>
got it, will currently change it to CXL_TYPE_3_SLD in next iteration of
patch series. However, once we add support for MLD, will make this
controllable as suggested.
>> +            } else {
>> +                ports->pport_info[i].connected_device_type = PCIE_DEVICE;
>> +            }
>> +        } else {
>> +            ports->pport_info[i].connected_device_type = NO_DEVICE_DETECTED;
>> +        }
>> +        ports->pport_info[i].supported_ld_count = 3;
>> +    } else if (usp->port == i) { /* USP */
>> +        port_dev = PCI_DEVICE(usp);
>> +        ports->pport_info[i].port_id = i;
>> +        ports->pport_info[i].current_port_config_state = USP;
>> +        ports->pport_info[i].connected_device_type = NO_DEVICE_DETECTED;
>> +        ports->active_port_bitmask[i / 8] |= (1 << i % 8);
>> +    } else {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    if (!port_dev->exp.exp_cap) {
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
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
>> +    ports->pport_info[i].max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
>> +    ports->pport_info[i].negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
>> +    ports->pport_info[i].supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
>> +    ports->pport_info[i].max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
>> +    ports->pport_info[i].current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
>> +
>> +    ports->pport_info[i].ltssm_state = LTSSM_L2;
>> +    ports->pport_info[i].first_negotiated_lane_num = 0;
>> +    ports->pport_info[i].link_state_flags = 0;
>> +    ports->pport_info[i].supported_cxl_modes = CXL_256B_FLIT_CAPABLE;
>> +    ports->pport_info[i].connected_device_mode = STANDARD_256B_FLIT_MODE;
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
>> +{
>> +    uint8_t phy_port_num;
>> +    if (!cci) {
>
>What is this defending against?  At least for now the cci
>is definitely not null where this function is used.
>
got it
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>> +    PCIEPort *usp = PCIE_PORT(cci->d);
>
>Don't mix declarations and code.  Declarations still typically
>go at the top.
>
got it
>> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +    struct phy_port *ports = &cci->pports;
>> +    int num_phys_ports = pcie_count_ds_ports(bus) + 1;
>> +    if (num_phys_ports < 0) {
>
>Given add 1 this is always false and the check serve no
>purpose.
>
right, thanks for pointing this out
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>> +    ports->num_ports = num_phys_ports;
>> +    phy_port_num =  usp->port;
>> +
>> +    cxl_set_port_type(ports, phy_port_num, cci); /* usp */
>
>USP for comment given it's an acronym.
>
okay
>> +
>> +    for (int devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
>
>Maybe use pci_for_each_device_under_bus() ?
>
okay
>> +        PCIDevice *dev = bus->devices[devfn];
>> +
>> +        if (dev) {
>> +            phy_port_num = PCIE_PORT(dev)->port;
>> +            const char *typename = object_get_typename(OBJECT(dev));
>
>Normally in qemu we just use a dynamic cast to identify types rather than
>matching on names.  I'd prefer that approach here.
>
>if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)
>
>
got it
>> +
>> +            if ((strcmp(typename, "cxl-downstream") == 0)) {
>> +                cxl_set_port_type(ports, phy_port_num, cci);
>> +            } else {
>> +                return CXL_MBOX_INTERNAL_ERROR;
>> +            }
>> +        }
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>>                                    DeviceState *d, size_t payload_max)
>>  {
>> @@ -3693,6 +3857,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>>      cci->d = d;
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>> +    cxl_set_phy_port_info(cci); /* store port info */
>>  }
>>
>>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>> @@ -3797,4 +3962,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>>      cci->d = d;
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>> +    cxl_set_phy_port_info(cci); /* store port info */
>
>I'd not bother with the comment.  The naming of the function is clear enough.
>
okay
>>  }
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index ca515cab13..9eb128a1e8 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -127,6 +127,31 @@
>>                    CXL_NUM_CHMU_INSTANCES * (1 << 16),                   \
>>                    (1 << 16))
>>
>> +/* CXL r3.2 Table 7-19: Port Info */
>> +struct cxl_phy_port_info {
>
>There is one of these in cxl-mailbox-utils.c already.  Pull it out
>as part of this patch.  That may mean combining patches 1 and 2.
>
>
>> +    uint8_t port_id;
>> +    uint8_t current_port_config_state;
>
>I'd pull the field defines and masks etc alongside the structure
>definition.
>
okay
>
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
>> +    uint8_t num_ports;
>> +    uint8_t active_port_bitmask[0x20];
>
>Why that size?  Also not used yet - so maybe bring this in where
>you need it?
>
>> +    struct cxl_phy_port_info pport_info[PCI_DEVFN_MAX];
>
>I think there are lower limits than that on how many ports
>we can have on a given bus + does this actually care about
>the limits from one bus?  Request is per switch, not per
>virtual heirarchy.  So we might be limited by number of unique
>port numbers.
>
>Today we only have one VCH so maybe this is fine for now.
>
>
Right, the request is per switch and not per virtual heirarchy.
According to CXL r3.2 Table 7-16, length of number of physical ports
is 1 byte which accounts for 256 physical ports. So, will
#define CXL_MAX_PHY_PORTS 256 and change the length of pport_info[] to
it.

>> +};
>> +
>>  /* CXL r3.1 Table 8-34: Command Return Codes */
>>  typedef enum {
>>      CXL_MBOX_SUCCESS = 0x0,
>> @@ -223,6 +248,9 @@ typedef struct CXLCCI {
>>      /* get log capabilities */
>>      const CXLLogCapabilities *supported_log_cap;
>>
>> +    /*physical ports information */
>
>Space after /*
>
>Run checkpatch.pl over qemu patches. I 'think' it would have
>caught this trivial thing.
>
I did run checkpatch.pl but it didn't catch this. will recheck for such
trivial things moving forward.

>> +    struct phy_port pports;
>Storing this in the CCI is a little odd seeing (as opposed to
>in the USP - maybe DSP) as there is only one answer to this query whichever
>CCI we come in on.
>
>For similar things we do have firmware update in there which
>is a mixture of device side stuff and CCI specific handling.
>That might ideally be split up.  Obviously not something for
>this patch, but maybe we can avoid making CCI more bloated?
>
>To me it seems reasonable to store this in the port and set
>it up whether or not the cci is connected.
>
got it, will try the implementation accordingly. It will be helpful if could share some
reference on handling the same.
>> +
>>      /* background command handling (times in ms) */
>>      struct {
>>          uint16_t opcode;
>

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a598b_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a598b_--

