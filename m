Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69913C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCuv-0006qe-DY; Wed, 16 Jul 2025 20:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ucCul-0006f1-Di; Wed, 16 Jul 2025 20:56:01 -0400
Received: from [115.124.28.122] (helo=out28-122.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ucCug-0006sr-2R; Wed, 16 Jul 2025 20:55:58 -0400
Received: from 172.38.29.107(mailfrom:zhangzhijie@bosc.ac.cn
 fp:SMTPD_---.dpKB4az_1752713489 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 17 Jul 2025 08:51:30 +0800
Message-ID: <0029ad6d-c25e-46d3-be2f-5d23087df287@bosc.ac.cn>
Date: Thu, 17 Jul 2025 08:51:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCIE-Host Support 64Bit resource for DesignwarePCIEHost
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 wangran@bosc.ac.cn, zhangjian@bosc.ac.cn, peter.maydell@linaro.org,
 andrew.smirnov@gmail.com, qemu-arm@nongnu.org
References: <20250715064400.2289152-1-zhangzhijie@bosc.ac.cn>
 <631BA6B2-268F-4DDC-9DA6-77697373A5DF@gmail.com>
From: zhangzhijie <zhangzhijie@bosc.ac.cn>
In-Reply-To: <631BA6B2-268F-4DDC-9DA6-77697373A5DF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.122 (deferred)
Received-SPF: pass client-ip=115.124.28.122;
 envelope-from=zhangzhijie@bosc.ac.cn; helo=out28-122.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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



在 2025/7/17 1:53, Bernhard Beschow 写道:
> 
> 
> Am 15. Juli 2025 06:44:00 UTC schrieb zhangzhijie <zhangzhijie@bosc.ac.cn>:
>> 0. DW pcie support 64bit resource
>> 1. DW version type using Linux kernel
> 
> Which machines in QEMU require this change?
> 
after support 64bit resource, will support on riscv
>>
>> Signed-off-by: zhangzhijie <zhangzhijie@bosc.ac.cn>
>> ---
>> hw/pci-host/designware.c         | 12 +++++++++---
>> include/hw/pci-host/designware.h |  2 +-
>> 2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>> index f6e49ce9b8..99d791c0a7 100644
>> --- a/hw/pci-host/designware.c
>> +++ b/hw/pci-host/designware.c
>> @@ -41,6 +41,8 @@
>> #define DESIGNWARE_PCIE_MSI_INTR0_ENABLE           0x828
>> #define DESIGNWARE_PCIE_MSI_INTR0_MASK             0x82C
>> #define DESIGNWARE_PCIE_MSI_INTR0_STATUS           0x830
>> +#define PCIE_VERSION_NUMBER                        0x8F8
>> +#define PCIE_VERSION_TYPE                          0x8FC
>> #define DESIGNWARE_PCIE_ATU_VIEWPORT               0x900
>> #define DESIGNWARE_PCIE_ATU_REGION_INBOUND         BIT(31)
>> #define DESIGNWARE_PCIE_ATU_CR1                    0x904
>> @@ -144,6 +146,10 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
>>      uint32_t val;
>>
>>      switch (address) {
>> +    case PCIE_VERSION_NUMBER:
>> +    case PCIE_VERSION_TYPE:
>> +        val = 0x3534302a;
>> +        break;
>>      case DESIGNWARE_PCIE_PORT_LINK_CONTROL:
>>          /*
>>           * Linux guest uses this register only to configure number of
>> @@ -427,7 +433,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>          viewport->inbound = true;
>>          viewport->base    = 0x0000000000000000ULL;
>>          viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = UINT64_MAX;
>>          viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>
>>          source      = &host->pci.address_space_root;
>> @@ -451,7 +457,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>          viewport->inbound = false;
>>          viewport->base    = 0x0000000000000000ULL;
>>          viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = UINT64_MAX;
>>          viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>
>>          destination = &host->pci.memory;
>> @@ -558,7 +564,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
>>      .fields = (const VMStateField[]) {
>>          VMSTATE_UINT64(base, DesignwarePCIEViewport),
>>          VMSTATE_UINT64(target, DesignwarePCIEViewport),
>> -        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
>> +        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
>>          VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
>>          VMSTATE_END_OF_LIST()
>>      }
>> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
>> index a35a3bd06c..6e06f54801 100644
>> --- a/include/hw/pci-host/designware.h
>> +++ b/include/hw/pci-host/designware.h
>> @@ -46,7 +46,7 @@ typedef struct DesignwarePCIEViewport {
>>
>>      uint64_t base;
>>      uint64_t target;
>> -    uint32_t limit;
>> +    uint64_t limit;
>>      uint32_t cr[2];
>>
>>      bool inbound;


