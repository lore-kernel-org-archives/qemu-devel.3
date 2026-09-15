Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044ACC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Uj5-0007ye-Iu; Tue, 15 Sep 2026 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6Uil-0007xG-VY; Tue, 15 Sep 2026 11:05:22 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6Uid-00075Z-Vk; Tue, 15 Sep 2026 11:05:19 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDHy6SYXqlqr4UqAA--.58412S2; 
 Tue, 15 Sep 2026 23:04:56 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.118.246])
 by mail (Coremail) with SMTP id AQAAf8Dwr3SWXqlqZXbWAA--.39496S2;
 Tue, 15 Sep 2026 23:04:55 +0800 (CST)
Message-ID: <fd1f4d1b-e676-47fb-b063-5440e29825c4@phytium.com.cn>
Date: Tue, 15 Sep 2026 23:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v5 16/28] hw/arm/smmuv3: Add access checks for
 GERROR_IRQ_CFG registers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-1-tangtao1634@phytium.com.cn>
 <7b5f99bb-891f-4184-9278-207664b02fb0@redhat.com>
In-Reply-To: <7b5f99bb-891f-4184-9278-207664b02fb0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dwr3SWXqlqZXbWAA--.39496S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWqoS0kibQAAsY
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKr1UZF4xWrWktw4fXFykuFg_yoW7GrW8pr
 48Gr4aqr4DtF4Iqw4Svw4jv3Z5urZ5tr13Gr13KF17Cw4DurySyryj9Fs8GayUurn5Wa1I
 qa1SgrZ3Ww45ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Eric, Mostafa,

I'm replying to both reviews here.


On 8/28/2026 5:47 PM, Eric Auger wrote:
> Hi Tao,
>
> On 8/13/26 6:25 PM, Tao Tang wrote:
> Please directly explain what is the problem we want to fix before what
> is actually done in the patch.
>
> Spec says: "SMMU_GERROR_IRQ_CFG0 is Guarded by
> SMMU_IRQ_CTRL.GERROR_IRQEN and must only be modified
> when SMMU_IRQ_CTRL.GERROR_IRQEN == 0." This check is currently not
> performed
>
> In SMMUv3.2 and later, a write while SMMU_IRQ_CTRL.GERROR_IRQEN == 1 is
> IGNORED.
> Accesses to this register use the following encodings:
> Accessible at offset 0x0068 from SMMUv3_PAGE_0
> • When SMMU_IRQ_CTRL.GERROR_IRQEN == 0 and SMMU_IRQ_CTRLACK.GERROR_IRQEN
> == 0,
> accesses to this register are RW.
> • Otherwise, accesses to this register are RO.
> "
>
> By the way you are not checking  SMMU_IRQ_CTRLACK.GERROR_IRQEN

IRQ_CTRL and IRQ_CTRLACK currently read the same bank->irq_ctrl field, 
so the existing check covers both in this synchronous model. Would you 
prefer a separate irq_ctrlack field to represent the acknowledged state 
explicitly?

> Nevertheless our emulation does not support MSI, right? So why don't we
> hardcode this behavior on SMMU_GERROR_IRQ_CFG0 access, ie.
>
> "This register is present only when SMMU_IDR0.MSI == 1.
> SMMU_GERROR_IRQ_CFG0 are RES 0."
>
> That would be simpler.

...

>> Add helpers that separate IRQ_CFG register presence from the runtime
>> IRQ enable guard. The Non-secure and Secure GERROR_IRQ_CFG register sets
>> both use SMMU_IDR0.MSI for presence, while writability additionally
>> requires GERROR_IRQEN to be clear. IRQ_CTRL and IRQ_CTRLACK share one
>> synchronous backing field in the current model.
>>
>> Reads return RES0 when the register set is absent. Writes are ignored
>> when it is absent or GERROR_IRQEN is set. Apply the same checks to all
>> three GERROR_IRQ_CFG registers and mask reserved bits in CFG0 and CFG2.
>>
>> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
> above is enought I think
...
>> Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 116 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 47f0d575817..628911d3f21 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1428,6 +1428,62 @@ smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
>>       return true;
>>   }
>>   
>> +/* Check whether the selected IRQ_CFG register set is present. */
> Remove the final "."
> Besides worth to add, check if MSI are supported. Even I would rather
> rename the helper to reflect what is pratcically does, even if your
> eventual interest is to know if SMMU_PRIQ_IRQ_CFGn and
> SMMU_GERROR_IRQ_CFGn are not RES 0. By the way IRQ_CFG is always present
> ;-)

...

>> +static bool smmu_irq_cfg_present(SMMUv3State *s, SMMUSecSID sec_sid,
>> +                                 SMMUIrq irq)
>> +{
>> +    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
>> +
>> +    switch (irq) {
>> +    case SMMU_IRQ_GERROR:
>> +        switch (sec_sid) {
>> +        case SMMU_SEC_SID_NS:
>> +        case SMMU_SEC_SID_S:
>> +            return FIELD_EX32(bank->idr[0], IDR0, MSI);

> I am a bit confused about this, there is no configuration where this
> is true?
>
> Thanks,
> Mostafa

The SMMUv3 model does not advertise MSI support. In v6 I'll make the 
Non-secure and Secure GERROR_IRQ_CFG0/1/2 registers explicitly RES0 and 
remove the generic helpers. I'll make EVENTQ_IRQ_CFG0/1/2 RES0 in patch 
18 as well because of unsupport MSI.

I'll also explain the old MSI=0 write/readback bug first in the commit 
message and keep only Fixes: fae4be38b35d.

>> +        case SMMU_SEC_SID_NUM:
>> +            g_assert_not_reached();
>> +        }
>> +        break;
>> +    case SMMU_IRQ_EVTQ:
> why do you pass irq if everything besides
>
> SMMU_IRQ_GERROR is unexpected?

The irq argument was intended for the EVENTQ handling added in patch 18. 
I'll remove the shared helpers as part of the RES0 simplification.

>
>> +    case SMMU_IRQ_PRIQ:
>> +    case SMMU_IRQ_CMD_SYNC:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    g_assert_not_reached();
>> +}
>> +
>> +/* Check whether the selected IRQ_CFG register set is writable. */
>> +static bool smmu_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid,
>> +                                  SMMUIrq irq)
>> +{
>> +    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>> +    uint32_t irqen;
>> +
>> +    if (!smmu_irq_cfg_present(s, sec_sid, irq)) {
>> +        return false;
>> +    }
>> +
>> +    switch (irq) {
>> +    case SMMU_IRQ_GERROR:
>> +        irqen = FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
> again the name of the helper does not reflect what it does.
> GERROR_IRQENMeaning
> 0b0 interrupts are disabled.
> 0b1 Interrupts are enabled.

This helper will be removed as part of the RES0 simplification.


Best regards,

Tao


