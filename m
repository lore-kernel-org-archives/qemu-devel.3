Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E57EC7115A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 10:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRTSY-0000Um-E6; Tue, 17 Jun 2025 06:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uRTSU-0000U1-Rs
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:22:26 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uRTSD-0004Jl-Gr
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:22:17 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250617102141epoutp04305cec719b6b4487299c20e597fbb5c7~JzVZzsUyo1057610576epoutp047
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 10:21:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250617102141epoutp04305cec719b6b4487299c20e597fbb5c7~JzVZzsUyo1057610576epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1750155701;
 bh=RHnfMDcnjkCpNXmxxzs/C20X71OBG3mUzj26FeqODOk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=izlujs3LCKUBIg49nVzC6FCeUhl+kIF4XNlDjpa26bxGBYGuei461kAtoTZCbrRcA
 P4YS/jNcatxuKjZbTsUVotoFy7GNj5N5FwYk+TRR8vbVgPZ/8/3c5ckDxYrXUVRCY8
 p6/TqPOYtRQ12RiqHgNoCrwOXQpMx80Lda+HpwcA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20250617102141epcas5p3630447b43bcedd87c29009961428e537~JzVZeEtoT1868018680epcas5p3G;
 Tue, 17 Jun 2025 10:21:41 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.178]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4bM2wM2x7cz2SSKY; Tue, 17 Jun
 2025 10:21:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250617100204epcas5p2a5516d83ce61909c730901772fe90ae8~JzERge6Dn0477404774epcas5p2m;
 Tue, 17 Jun 2025 10:02:04 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250617100202epsmtip120c42834f6a8f3ac4e6cc9f3427f716e~JzEQPyDP91516415164epsmtip1a;
 Tue, 17 Jun 2025 10:02:02 +0000 (GMT)
Date: Tue, 17 Jun 2025 15:31:56 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 2/3] hw/cxl: Simplified Identify Switch Device & Get
 Physical Port State
Message-ID: <20250617100156.nllspip2jcykteid@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250610152906.00002c4b@huawei.com>
X-CMS-MailID: 20250617100204epcas5p2a5516d83ce61909c730901772fe90ae8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
 <CGME20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b@epcas5p1.samsung.com>
 <20250602135942.2773823-3-arpit1.kumar@samsung.com>
 <20250610152906.00002c4b@huawei.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 10/06/25 03:29PM, Jonathan Cameron wrote:
>On Mon,  2 Jun 2025 19:29:41 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> Modified Identify Switch Device (Opcode 5100h)
>> & Get Physical Port State(Opcode 5101h)
>> using physical ports info stored during enumeration
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>A few additional comments in here.
>
>J
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 133 +++++++------------------------------
>>  1 file changed, 24 insertions(+), 109 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 680055c6c0..b2fa79a721 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -558,17 +558,7 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> -static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
>> -                                  void *private)
>> -{
>> -    uint8_t *bm = private;
>> -    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
>> -        uint8_t port = PCIE_PORT(d)->port;
>> -        bm[port / 8] |= 1 << (port % 8);
>> -    }
>> -}
>> -
>> -/* CXL r3.1 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
>> +/* CXL r3.2 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
>
>I'd prefer the spec reference updates in a separate patch. They are noise here
>and kind of suggest there are real changes rather than just refactoring.
>
okay
>
>> @@ -611,16 +599,14 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
>>          out->ingress_port_id = 0;
>>      }
>>
>> -    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
>> -                                  out->active_port_bitmask);
>> -    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
>
>Ah. With this in front of me the reason for the sizeing is much clearer
>than in previous patch on it's own. Combining the two will make it all more obvious.
>
right, will do the same in next iteration(V2) of the patch series.
>> -
>> +    memcpy(out->active_port_bitmask, cci->pports.active_port_bitmask,
>> +           sizeof(cci->pports.active_port_bitmask));
>>      *len_out = sizeof(*out);
>>
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> -/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
>> +/* CXL r3.2 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
>>  static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>                                                uint8_t *payload_in,
>>                                                size_t len_in,
>> @@ -628,44 +614,21 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>                                                size_t *len_out,
>>                                                CXLCCI *cci)
>>  {
>
>>
>>      in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
>>      out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
>> @@ -673,72 +636,24 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>>      if (len_in < sizeof(*in)) {
>>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>>      }
>> -    /* Check if what was requested can fit */
>> +
>
>The check is still here... So why remove the comment?
thanks for pointing this out, will add the comment back.
>
>>      if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
>>          return CXL_MBOX_INVALID_INPUT;
>>      }
>>
>> -    /* For success there should be a match for each requested */
>> -    out->num_ports = in->num_ports;
>> +    if (in->num_ports > cci->pports.num_ports) {
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
>> +        int pn = in->ports[i];
>> +        for (int j = 0; j < PCI_DEVFN_MAX; j++) {
>> +            if (pn == cci->pports.pport_info[j].port_id) {
>
>Given port id is 0-255 and your port_info has 256 elements, why not index
>by port_id when storing them in the first place? That should reduce
>complexity of this look up.  I don't think we ever actually look up
>by devfn?
okay
>
>> +                memcpy(&out->ports[i], &(cci->pports.pport_info[pn]),
>> +                       sizeof(struct cxl_phy_port_info));

------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_
Content-Type: text/plain; charset="utf-8"


------K5ZVV-zrPS8y8iJelFUsagW7KEVVNg7wn3oh2ZJRPRpX678s=_a58ee_--

