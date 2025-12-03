Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7546DD12D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpBe-00071p-CK; Wed, 03 Dec 2025 10:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQpBc-00071b-5W; Wed, 03 Dec 2025 10:54:36 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQpBZ-0004uF-EU; Wed, 03 Dec 2025 10:54:35 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB3WCUyXTBpvgwsAQ--.57818S2;
 Wed, 03 Dec 2025 23:54:26 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwB3zeoxXTBpDFUJAA--.3558S2;
 Wed, 03 Dec 2025 23:54:25 +0800 (CST)
Message-ID: <dd874033-0294-4b6b-9ab1-6a2c32f60e3c@phytium.com.cn>
Date: Wed, 3 Dec 2025 23:54:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 21/21] hw/arm/smmuv3: Add secure migration and enable
 secure state
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151611.4131627-1-tangtao1634@phytium.com.cn>
 <2ba17310-e032-44f6-a17f-a8f5b9dec003@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <2ba17310-e032-44f6-a17f-a8f5b9dec003@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3zeoxXTBpDFUJAA--.3558S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQAHsv
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFyDWw1xJF4DXw1xCr4kWFg_yoW7XrW8pr
 Z8G3W5Kr1DGF17ZrWfJw4rZFsYkrWSvr45CrZrKFWayan5Grs3twn2kry5W34kurWUJa1I
 vF4jka9rWrnxArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2025/12/3 00:39, Eric Auger wrote:
>
> On 10/12/25 5:16 PM, Tao Tang wrote:
>> Introduce a bool secure_impl field to SMMUv3State and expose it as
>> a secure-impl device property. The introduction of this property is the
>> culminating step that activates the entire secure access data path,
>> tying together all previously merged logic to provide full support for
>> secure state accesses.
>>
>> Add live migration support for the SMMUv3 secure register bank.
>>
>> To correctly migrate the secure state, the migration logic must know
>> if the secure functionality is enabled. To facilitate this, a bool
>> secure_impl field is introduced and exposed as the secure-impl device
>> property. This property is introduced at the point it is first
>> required—for migration—and serves as the final piece of the series.
>>
>> The introduction of this property also completes and activates the
>> entire secure access data path, tying together all previously merged
>> logic to provide full support for secure state accesses.
>>
>> Usage:
>>      -global arm-smmuv3,secure-impl=true
>>
>> When this property is enabled, the capability is advertised to the
>> guest via the S_IDR1.SECURE_IMPL bit.
>>
>> The migration is implemented as follows:
>>
>> - A new vmstate_smmuv3_secure_bank, referenced by the smmuv3/bank_s
>> subsection, serializes the secure bank's registers and queues.
>>
>> - A companion smmuv3/gbpa_secure subsection mirrors the non-secure
>> GBPA handling, migrating the register only if its value diverges
>> from the reset default.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c         | 75 +++++++++++++++++++++++++++++++++++++++++
>>   include/hw/arm/smmuv3.h |  1 +
>>   2 files changed, 76 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 0b366895ec..ce41a12a36 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -337,6 +337,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>   
>>       memset(sbk->idr, 0, sizeof(sbk->idr));
>>       sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, SMMU_IDR1_SIDSIZE);
>> +    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, SECURE_IMPL, s->secure_impl);
>>       sbk->gbpa = SMMU_GBPA_RESET_VAL;
>>       sbk->cmdq.entry_size = sizeof(struct Cmd);
>>       sbk->eventq.entry_size = sizeof(struct Evt);
>> @@ -2452,6 +2453,53 @@ static const VMStateDescription vmstate_smmuv3_queue = {
>>       },
>>   };
>>   
>> +static const VMStateDescription vmstate_smmuv3_secure_bank = {
>> +    .name = "smmuv3_secure_bank",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32(features, SMMUv3RegBank),
>> +        VMSTATE_UINT8(sid_split, SMMUv3RegBank),
>> +        VMSTATE_UINT32_ARRAY(cr, SMMUv3RegBank, 3),
>> +        VMSTATE_UINT32(cr0ack, SMMUv3RegBank),
>> +        VMSTATE_UINT32(irq_ctrl, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerror, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerrorn, SMMUv3RegBank),
>> +        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3RegBank),
>> +        VMSTATE_UINT64(strtab_base, SMMUv3RegBank),
>> +        VMSTATE_UINT32(strtab_base_cfg, SMMUv3RegBank),
>> +        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3RegBank),
>> +        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3RegBank),
>> +        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3RegBank),
>> +        VMSTATE_STRUCT(cmdq, SMMUv3RegBank, 0,
>> +                       vmstate_smmuv3_queue, SMMUQueue),
>> +        VMSTATE_STRUCT(eventq, SMMUv3RegBank, 0,
>> +                       vmstate_smmuv3_queue, SMMUQueue),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>> +static bool smmuv3_secure_bank_needed(void *opaque)
>> +{
>> +    SMMUv3State *s = opaque;
>> +
>> +    return s->secure_impl;
>> +}
>> +
>> +static const VMStateDescription vmstate_smmuv3_bank_s = {
>> +    .name = "smmuv3/bank_s",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = smmuv3_secure_bank_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_STRUCT(bank[SMMU_SEC_SID_S], SMMUv3State, 0,
>> +                       vmstate_smmuv3_secure_bank, SMMUv3RegBank),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>>   static bool smmuv3_gbpa_needed(void *opaque)
>>   {
>>       SMMUv3State *s = opaque;
>> @@ -2472,6 +2520,25 @@ static const VMStateDescription vmstate_gbpa = {
>>       }
>>   };
>>   
>> +static bool smmuv3_gbpa_secure_needed(void *opaque)
> I don't think you need that subsection. You can directly put this in the
> secure subsection one. This was needed for NS to avoid breaking
> migration but here you shall not need it.
>
> Thanks
>
> Eric


Thanks for the clarification. I'll drop the smmuv3/gbpa_secure 
subsection and just migrate the secure GBPA as part of the smmuv3/bank_s 
secure subsection, since we don't have any existing migration ABI to 
preserve for the secure state.


Also, many thanks for all your review work on this series. I'll prepare 
and send a v4 shortly, and if you have some time to look at it as well, 
that would be greatly appreciated.


Yours,

Tao


