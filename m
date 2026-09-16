Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E992EC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rEb-0003R3-4M; Wed, 16 Sep 2026 11:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6rEY-0003QV-VS; Wed, 16 Sep 2026 11:07:38 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6rEU-0003LK-W1; Wed, 16 Sep 2026 11:07:38 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAHD1uosKpqLAEHAA--.230S2;
 Wed, 16 Sep 2026 23:07:20 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.119.91])
 by mail (Coremail) with SMTP id AQAAf8Dw0HWmsKpqulDXAA--.40918S2;
 Wed, 16 Sep 2026 23:07:19 +0800 (CST)
Message-ID: <b7530aa3-a009-4aac-950a-9276638a3da5@phytium.com.cn>
Date: Wed, 16 Sep 2026 23:07:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 19/28] hw/arm/smmuv3: Determine register bank from MMIO
 offset
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-4-tangtao1634@phytium.com.cn>
 <apbgonXpyX3ehO5i@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <apbgonXpyX3ehO5i@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw0HWmsKpqulDXAA--.40918S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWqpnMkH+AAAst
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtr1kAF4kJr15Ary5Cr17KFg_yoW7WrWfpr
 Z5JF15KrWDKa1SgF43Ja1DZFyUAwn7Kw15Ar1UKF1UC34UAw1vqrWUWr1S9r1DurWrZr4D
 trWrJr43ur1YyrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Mostafa,

On 9/1/2026 10:26 PM, Mostafa Saleh wrote:
> On Fri, Aug 14, 2026 at 12:25:57AM +0800, Tao Tang wrote:
>> Modify the main MMIO handlers to select the target register bank from the
>> memory-mapped offset.
>>
>> Offsets in the Secure register window select SMMU_SEC_SID_S and are
>> normalized by subtracting SMMU_SECURE_REG_START. Other offsets select the
>> Non-secure bank. Pass the selected SEC_SID to the register access helpers,
>> where the normalized bank-local offset identifies the register.
>>
>> Keep bank-specific differences explicit, such as S_IDR5 being unimplemented.
>> This patch implements Non-secure and Secure bank dispatch and prepares for
>> later access checks; Realm and Root programming interfaces are not modeled.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3.c | 44 ++++++++++++++++++++++++++++++++------------
>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index efa78869251..b36bc4a54e0 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1889,9 +1889,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>>   }
>>   
>>   static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>> -                               uint64_t data, MemTxAttrs attrs)
>> +                                uint64_t data, MemTxAttrs attrs,
>> +                                SMMUSecSID reg_sec_sid)
>>   {
>> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
>>   
>>       switch (offset) {
>> @@ -1959,10 +1959,10 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>>   }
>>   
>>   static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>> -                               uint64_t data, MemTxAttrs attrs)
>> +                               uint64_t data, MemTxAttrs attrs,
>> +                               SMMUSecSID reg_sec_sid)
>>   {
>>       Error *local_err = NULL;
>> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
>>   
>>       switch (offset) {
>> @@ -2223,16 +2223,26 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>>       SMMUState *sys = opaque;
>>       SMMUv3State *s = ARM_SMMUV3(sys);
>>       MemTxResult r;
>> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>   
>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>>       offset &= ~0x10000;
>>   
>> +    /*
>> +     * Dispatch the Non-secure window directly. After access validation,
>> +     * translate the Secure window to its bank-local register offsets.
>> +     */
>> +    if (offset >= SMMU_SECURE_REG_START) {
>> +        reg_sec_sid = SMMU_SEC_SID_S;
>> +        offset -= SMMU_SECURE_REG_START;
> It's not that simple, both banks aren't identical.
>
> Beyond the IDR5 handled here, AFAICT the following doesn't also exist
> in the secure bank:
> - 0x0018 SMMU_IIDR
> - 0x001C SMMU_AIDR
> - 0x0040 SMMU_STATUSR

You're right. I prepare to centralize these register-layout differences 
in a helper:


```

static bool smmuv3_reg_is_raz_wi(hwaddr offset,
                                SMMUSecSID reg_sec_sid)
{
     switch (offset) {
     case A_IDR5:
     case A_IIDR:
     case A_STATUSR:
     case A_IDREGS ... A_IDREGS + 0x2f:
         return reg_sec_sid != SMMU_SEC_SID_NS;
     case A_AIDR:
         return reg_sec_sid == SMMU_SEC_SID_S;
     default:
         /* Leave other offsets to the register handlers */
         return false;
     }
}

static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
                               uint64_t *data, MemTxAttrs attrs,
                               SMMUSecSID reg_sec_sid)
{
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);

     if (smmuv3_reg_is_raz_wi(offset, reg_sec_sid)) {

         *data = 0;

         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: read from undefined register: bank=%d "
                       "offset=0x%" PRIx64 " (RAZ)\n",
                       __func__, reg_sec_sid, offset);

         return MEMTX_OK;
     }

     switch (offset) {

     case A_AIDR:
         if (reg_sec_sid == SMMU_SEC_SID_R) {  // For the future Realm 
support
             /* RME architecture revision 0.0. */
             *data = 0;
         } else {
             *data = s->aidr;
         }
         return MEMTX_OK;
......

     default:
     unhandled:
         *data = 0;
         qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 32-bit access at 0x%"PRIx64" (RAZ)\n",
                       __func__, offset);
         return MEMTX_OK;
     }
}

```


The shared handlers will return zero or ignore writes when this helper 
returns true. Also there is a code piece(` case A_AIDR `) to show how we 
handle with same relative offset but with different meanings.

How do you think about this?

> Also, A_GBPA seems to call smmuv3_accel_attach_gbpa_hwpt() irrelevant
> of security state.

I'll add an if (reg_sec_sid == SMMU_SEC_SID_NS) guard before the 
accelerator call.


>
> Finally, the first patch introduced SMMU_S_CR0_RESERVED for the secure
> register, but SMMU_CR0_RESERVED is still used here.
I'll fix it in V6.
>
> Thanks,
> Mostafa

Thanks,

Tao


