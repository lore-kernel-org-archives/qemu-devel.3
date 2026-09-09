Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEDBC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4J9P-0004PN-Sa; Wed, 09 Sep 2026 10:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x4J9C-0004OP-F8; Wed, 09 Sep 2026 10:19:35 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x4J92-0006p5-Ts; Wed, 09 Sep 2026 10:19:30 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwA3P4flaqFqB_kEAA--.6145S2;
 Wed, 09 Sep 2026 22:19:17 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.116.243])
 by mail (Coremail) with SMTP id AQAAf8DwjHXjaqFqYQTSAA--.26877S2;
 Wed, 09 Sep 2026 22:19:15 +0800 (CST)
Message-ID: <4c80d8aa-8eaf-4154-8b1a-a7e85e73872d@phytium.com.cn>
Date: Wed, 9 Sep 2026 22:19:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 26/28] hw/arm/smmuv3: Initialize the secure register bank
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162624.2809349-5-tangtao1634@phytium.com.cn>
 <b4c5b401-ddf4-48db-bb4b-310baa0405e5@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <b4c5b401-ddf4-48db-bb4b-310baa0405e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwjHXjaqFqYQTSAA--.26877S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWqgYksHPwAAsS
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ary5tr15WFWrKw4ftr4Dtwb_yoW8Kw1fpF
 srCFs8KanrKrnxXF4avw48CFnxZrs3KrnrCrZrGF15Zw15urykJr1DGr1F9F9a9rn5Ca1I
 qF4Iga45uw45ArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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


On 8/31/2026 4:37 PM, Eric Auger wrote:
>
> On 8/13/26 6:26 PM, Tao Tang wrote:
>> Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
>> values during the SMMU's reset sequence.
>>
>> This change ensures that key fields, such as the secure ID registers,
>> GBPA reset value, and queue entry sizes, are set to a known-good state.
>> The SECURE_IMPL attribute of the S_IDR1 register will be introduced
>> later via device properties.
> what about SEL2 then? Do you eventually target this in this series?

Hi Eric,

We won't implement SEL2 in this series as mentioned in previous mail. 
The last patch is only a temporary one for Hafnium bring-up.


>> This is a necessary step to prevent undefined behavior when secure SMMU
>> features are subsequently enabled and used by software.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 2375b7a17a0..7e7376c65e2 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -293,6 +293,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>   static void smmuv3_init_id_regs(SMMUv3State *s)
>>   {
>>       SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
>> +    SMMUv3RegBank *sbank = smmuv3_bank(s, SMMU_SEC_SID_S);
>>   
>>       /* Based on sys property, the stages supported in smmu will be advertised.*/
>>       if (s->stage && !strcmp("2", s->stage)) {
>> @@ -339,7 +340,14 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>       bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN4K, 1);
>>       bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN16K, 1);
>>       bank->idr[5] = FIELD_DP32(bank->idr[5], IDR5, GRAN64K, 1);
>> -    s->aidr = 0x1;
>> +
>> +    /* Initialize Secure bank */
>> +    memset(sbank->idr, 0, sizeof(sbank->idr));
>> +    /* No stall */
>> +    sbank->idr[0] = FIELD_DP32(sbank->idr[0], S_IDR0, STALL_MODEL, 1);
>> +
>> +    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, S_SIDSIZE,
> what about S_IDR3.SAMS?


SAMS is already 0 through the memset. Since it is RES0 when ATS is not 
advertised, could we leave it as is in that configuration?


Best regards,

Tao

>> +                               SMMU_IDR1_SIDSIZE);
>>       smmuv3_accel_idr_override(s);
>>   }
>>   
>>


