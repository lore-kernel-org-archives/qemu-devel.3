Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB98C982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 13:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8HWu-0005cK-Rt; Sun, 20 Sep 2026 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x8HWq-0005c0-Tf; Sun, 20 Sep 2026 09:24:26 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x8HWo-0003xK-Jm; Sun, 20 Sep 2026 09:24:24 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDHzp573q9qBB2VAA--.4816S2;
 Sun, 20 Sep 2026 21:24:11 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.117.227])
 by mail (Coremail) with SMTP id AQAAf8DwBnN53q9qdePYAA--.36293S2;
 Sun, 20 Sep 2026 21:24:09 +0800 (CST)
Message-ID: <e9d5cd10-2a43-4867-9735-d836155e15cf@phytium.com.cn>
Date: Sun, 20 Sep 2026 21:24:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 24/28] hw/arm/smmuv3: Select sec-sid from PCI property
 and validate SECURE_IMPL
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162624.2809349-3-tangtao1634@phytium.com.cn>
 <33586975-6707-42d9-8744-d3cc70a38fb2@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <33586975-6707-42d9-8744-d3cc70a38fb2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBnN53q9qdePYAA--.36293S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWqu4t8GyQABs3
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AFyxAFWfXFWktr47WF4rKrg_yoW7Kw1xpa
 9xJF9xtF4UGry2kanaqw4293WYqw4xGF15GrW3KFyrur1qyrn7tr4jkr1F9ryDWrZ8Aw47
 u3W2grs5ur1qyrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi Eric,

On 8/31/2026 4:22 PM, Eric Auger wrote:
> Hi Tao,
>
> On 8/13/26 6:26 PM, Tao Tang wrote:
>> Parse each PCI device's sec-sid property during SMMU device initialization
>> and cache it in SMMUDevice::sec_sid. Support "non-secure" and "secure",
>> default to non-secure when unspecified, and reject invalid values with an
>> explicit error. Use sdev->sec_sid in smmuv3_translate() to select the
>> register bank instead of hardcoding the non-secure context.
>>
>> Keep sec-sid parsing in smmu-common, and add a SMMUv3-specific validation
>> hook to enforce architectural constraints: fail fast when sec-sid=secure
>> while SMMU_S_IDR1.SECURE_IMPL is 0 or secure AS is not available.
>>
>> Typically, SEC_SID is a system-defined attribute (e.g. sideband or tied-off)
>> rather than something a PCIe endpoint can freely toggle in pre-RME scenario.
>> So this PCI sec-sid property is used as a static platform/testing knob to
>> drive the SMMU bank selection.
>>
>> For future RME-DA and TDISP support, this static property will need to be
>> replaced by runtime platform plumbing that derives the effective SEC_SID
>> from the device security assignment.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++
>>   hw/arm/smmuv3.c              | 61 +++++++++++++++++++++++++++++++++++-
>>   include/hw/arm/smmu-common.h |  2 ++
>>   3 files changed, 99 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index e8a1ed65c19..4a94799fb0d 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -21,6 +21,7 @@
>>   #include "exec/target_page.h"
>>   #include "hw/core/cpu.h"
>>   #include "hw/pci/pci_bridge.h"
>> +#include "hw/pci/pci_device.h"
>>   #include "hw/core/qdev-properties.h"
>>   #include "qapi/error.h"
>>   #include "qemu/jhash.h"
>> @@ -1100,14 +1101,50 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
>>       return NULL;
>>   }
>>   
>> +static SMMUSecSID smmu_parse_pci_sec_sid(PCIDevice *pdev, int bus_num,
>> +                                         int devfn)
>> +{
>> +    const char *sec_sid;
>> +
>> +    if (!pdev || !pdev->sec_sid) {
>> +        return SMMU_SEC_SID_NS;
>> +    }
>> +
>> +    sec_sid = pdev->sec_sid;
>> +    if (!strcmp(sec_sid, "non-secure")) {
>> +        return SMMU_SEC_SID_NS;
>> +    }
> else if?
>> +    if (!strcmp(sec_sid, "secure")) {
>> +        return SMMU_SEC_SID_S;
>> +    }
>> +
>> +    error_report("Invalid sec-sid value '%s' for PCI device %02x:%02x.%x; "
>> +                 "allowed values: non-secure or secure (case-sensitive)",
> To me this is not the place where pci property validation should happen.
> This should happen in the pcie device instead, on property setting.
I've moved sec-sid value validation to the PCI property setter and 
simplified the SMMU-side conversion.
>> +                 sec_sid, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn));
>> +    exit(EXIT_FAILURE);
>> +}
>> +
>>   void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
>>   {
>>       static unsigned int index;
>>       g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
>>                                               index++);
>> +    SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(s);
>> +    PCIDevice *pdev;
>> +    int bus_num;
>> +
>>       sdev->smmu = s;
>>       sdev->bus = bus;
>>       sdev->devfn = devfn;
>> +    sdev->sec_sid = SMMU_SEC_SID_NS;
> do we need this init? smmu_parse_pci_sec_sid() already implements the
> default.
Yes this should be removed.
>> +
>> +    bus_num = pci_bus_num(bus);
>> +    pdev = pci_find_device(bus, bus_num, devfn);
>> +    sdev->sec_sid = smmu_parse_pci_sec_sid(pdev, bus_num, devfn);
>> +    if (sbc->validate_sec_sid &&
>> +        !sbc->validate_sec_sid(s, sdev, bus_num)) {
>> +        exit(EXIT_FAILURE);
> The problem is any attempt to hotplu a secure device will exit QEMU.
> I wonder if we shouldn't implement a PCIIOMMUOps that detects the
> incompatibility.
> Maybe supports_address_space() could do that. At the moment it is used
> to check accel mode only but another implementation could check secure
> compatibility I think. The advantage is this callback passes an errp.
Thanks for the advice. I'll add a new smmu_supports_address_space() 
callback to smmu_ops to check Secure compatibility and propagate errors 
through errp, so incompatible hotplug requests won't terminate QEMU.

static const PCIIOMMUOps smmu_ops = {
     .supports_address_space = smmu_supports_address_space,
     .get_address_space = smmu_find_add_as,
};
>> +    }
>>   
>>       memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
>>                                s->mrtypename, OBJECT(s), name, UINT64_MAX);
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index e5f0bc18415..a755f1ebd69 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -43,6 +43,12 @@
>>                                           ((ptw_info).stage == SMMU_STAGE_2 && \
>>                                           (cfg)->s2cfg.record_faults))
>>   
>> +enum {
>> +    SMMU_IOMMU_IDX_NS,
>> +    SMMU_IOMMU_IDX_S,
>> +    SMMU_IOMMU_IDX_NUM,
>> +};
> why do we need another enum, can't we reuse SMMUSecSID?
......
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>>       object_class_property_set_description(klass, "accel",
>>           "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>> @@ -2905,6 +2962,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>>   
>>       imrc->translate = smmuv3_translate;
>>       imrc->notify_flag_changed = smmuv3_notify_flag_changed;
>> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
>> +    imrc->num_indexes = smmuv3_num_indexes;
> Why do we need the above ops? Isn't it generic enough to stay in smmu
> base code?

In v6, I'll drop SMMU_IOMMU_IDX_* and reuse the SMMU_SEC_SID_* 
constants. I'll also move the attrs_to_index() and num_indexes() 
implementations to smmu-common.c/.h with function renamed to smmu_*.


Best regards,

Tao


