Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31F6CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYu2-0000G1-HJ; Fri, 19 Sep 2025 07:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uzYtt-0000EJ-Mh
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:03:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uzYto-0000qG-QU
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:03:37 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250919110325epoutp040a3a0f63bd3f8bfa68f2fec37a197c09~mqirtCm741637416374epoutp04T
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 11:03:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250919110325epoutp040a3a0f63bd3f8bfa68f2fec37a197c09~mqirtCm741637416374epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1758279805;
 bh=6kmVAHMIY5EUz8/oQT22z2+iEFOIcjXTLGTMM76hRUk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iZVQgNXoDO9MvNk92urbtwm/zG66OBoWtfD5BF7tSULsPsL3faIfLyK4tKhv8FfNh
 dH4lm+xFcTcJyu5s/n2LbFGV//PxIcwJmaavivJMz2GSyQVqH5mx8vfCjWXrqlhHuh
 zNNR8TEO0GPVW80UycKBxIIrYt1AaOxs5cExCza8=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20250919110324epcas5p205ecc138beaa8dca32cabc6905e1e101~mqiqq1-jQ1991019910epcas5p2s;
 Fri, 19 Sep 2025 11:03:24 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4cSqP75wwXz6B9m6; Fri, 19 Sep
 2025 11:03:23 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250919110323epcas5p38ea4211afa939c30510a8a0f9cff1c5f~mqipWW0x91372513725epcas5p35;
 Fri, 19 Sep 2025 11:03:23 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250919110321epsmtip1030d4158b8b7f48695c99043044221e9~mqin6tbwy0084900849epsmtip1g;
 Fri, 19 Sep 2025 11:03:21 +0000 (GMT)
Date: Fri, 19 Sep 2025 16:33:12 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, arpit.sysdev@gmail.com,
 cpgs@samsung.com
Subject: Re: [PATCH v4 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250919110312.naudjnvhsjmxaxjk@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250917165535.000021b1@huawei.com>
X-CMS-MailID: 20250919110323epcas5p38ea4211afa939c30510a8a0f9cff1c5f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250916080803epcas5p1cd11689108b259f21908d9779993cc0f
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
 <CGME20250916080803epcas5p1cd11689108b259f21908d9779993cc0f@epcas5p1.samsung.com>
 <20250916080736.1266083-2-arpit1.kumar@samsung.com>
 <20250917165535.000021b1@huawei.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/09/25 04:55PM, Jonathan Cameron wrote:
>On Tue, 16 Sep 2025 13:37:35 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> -Storing physical ports info during enumeration.
>> -Refactored changes using physical ports info for
>>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
>>  (Opcode 5101h) physical switch FM-API command set.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>
>Hi Arpit.  One question inline, and one comment on code I've moved
>around whilst queue this up.  I'll push out a tree to gitlab
>(probably tomorrow) and when I do please check I didn't mess that up!
>
>Jonathan
>

Hi Jonathan,
Thank you for the swift response and review comments.
Sure, will look into gitlab tree once up.

Thanks,
Arpit
>
>> +static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
>> +                                    CXLCCI *cci)
>> +{
>> +    uint8_t current_port_config_state;
>> +    uint8_t connected_device_type;
>> +    uint8_t supported_ld_count;
>> +    uint16_t lnkcap, lnkcap2, lnksta;
>> +    PCIBus *bus;
>> +    PCIDevice *port_dev;
>> +    PCIEPort *usp = PCIE_PORT(cci->d);
>> +
>> +    if (usp->port == pnum) {
>> +        port_dev = PCI_DEVICE(usp);
>> +        current_port_config_state = CXL_PORT_CONFIG_STATE_USP;
>> +        connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
>> +        supported_ld_count = 0;
>> +    } else {
>> +        bus = &PCI_BRIDGE(cci->d)->sec_bus;
>> +        port_dev = pcie_find_port_by_pn(bus, pnum);
>> +        if (port_dev) { /* DSP */
>> +            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
>> +                ->devices[0];
>> +            current_port_config_state = CXL_PORT_CONFIG_STATE_DSP;
>> +            if (ds_dev) {
>> +                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
>> +                    /* To-do: controllable */
>
>In what sense controllable?  It should always match what the downstream device
>is presenting as.  Do you ultimately mean if we mess with the alternate modes
>and reset the port to have it come up as a PCI only device?
>This will need to be more complex as we add different CXL type 3 device support
>of course, but I'd still expect to auto detect it rather that control it directly.
>

This is with respect to your review comment from v1 patch:
https://lore.kernel.org/qemu-devel/20250602135942.2773823-1-arpit1.kumar@samsung.com/T/
As per my understanding, controllable was identification of the specific type of 
CXL type 3 device and accordingly initializing connected_device_type. Since you 
mention auto-detect, does it mean using object_get_typename() to identify the type
of device and initiliaze it directly to connected_device_type rather than specifying
it explicitly. If yes, then this anyways rules out controllable part, hence the comment
can be removed.

>> +                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_3_SLD;
>> +                } else {
>> +                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
>> +                }
>> +            } else {
>> +                connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
>> +            }
>> +            supported_ld_count = 3;
>> +        } else {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +    }
>
>>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>>                                    DeviceState *d, size_t payload_max)
>>  {
>> @@ -4691,6 +4706,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>>      cci->d = d;
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>> +    cxl_set_phy_port_info(cci);
>>  }
>>
>>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>> @@ -4777,4 +4793,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>>      cci->d = d;
>>      cci->intf = intf;
>>      cxl_init_cci(cci, payload_max);
>> +    cxl_set_phy_port_info(cci);
>
>I'll shift this to a later patch whilst picking this up for my staging tree.
>I want this ahead of where we introduce cxl_initialize_usp_mctpcci.
>
Okay
>>  }

------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_
Content-Type: text/plain; charset="utf-8"


------.2eTkDb0Wtw7DpTqHNw2IdxlY1ZkgCZiGa8-Nl.IQwSrXKTD=_1d3f5_--

