Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112C7CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GY5-0006Nr-EI; Mon, 29 Sep 2025 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3GXm-0006Bz-9w; Mon, 29 Sep 2025 12:16:11 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v3GXD-0005ut-OP; Mon, 29 Sep 2025 12:15:52 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnp5OWsNpomPAAAA--.1S2;
 Tue, 30 Sep 2025 00:15:18 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.232.83])
 by mail (Coremail) with SMTP id AQAAfwB32OWTsNpo55ovAA--.28987S2;
 Tue, 30 Sep 2025 00:15:16 +0800 (CST)
Message-ID: <e9b71efe-fb85-412a-b606-7f1af4f9ece9@phytium.com.cn>
Date: Tue, 30 Sep 2025 00:15:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] hw/arm/smmuv3: Add property to enable Secure
 SMMU support
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926032339.1089647-1-tangtao1634@phytium.com.cn>
 <512210c3-95cc-484e-b8aa-78ceb631264f@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <512210c3-95cc-484e-b8aa-78ceb631264f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwB32OWTsNpo55ovAA--.28987S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAIBWjZjscNtAAAsN
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFyxKF4xWw1xZr13CFy3Arb_yoWrJF4DpF
 Z3CFn8KF4DX3WxJa9rZw4xZFy2v3yIq3W3urZ5G3WruF1kCrykXr10krWrWa98CrnYy3WI
 gF48ur4kCa12vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=165.227.154.27;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmty1ljiyny4xntqumjca.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Eric,

On 2025/9/29 23:42, Eric Auger wrote:
>
> On 9/26/25 5:23 AM, Tao Tang wrote:
>> My apologies, resending patches 13-14/14 to fix a threading mistake from
>> my previous attempt.
>>
>> This commit completes the initial implementation of the Secure SMMUv3
>> model by making the feature user-configurable.
>>
>> A new boolean property, "secure-impl", is introduced to the device.
>> This property defaults to false, ensuring backward compatibility for
>> existing machine types that do not expect the secure programming
>> interface.
>>
>> When "secure-impl" is set to true, the smmuv3_init_regs function now
>> initializes the secure register bank (bank[SMMU_SEC_IDX_S]). Crucially,
>> the S_IDR1.SECURE_IMPL bit is set according to this property,
>> correctly advertising the presence of the secure functionality to the
>> guest.
>>
>> This patch ties together all the previous refactoring work. With this
>> property enabled, the banked registers, security-aware queues, and
>> other secure features become active, allowing a guest to probe and
>> configure the Secure SMMU.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index c92cc0f06a..80fbc25cf5 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -351,6 +351,16 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>       s->statusr = 0;
>>       s->bank[SMMU_SEC_IDX_NS].gbpa = SMMU_GBPA_RESET_VAL;
>>
>> +    /* Initialize Secure bank (SMMU_SEC_IDX_S) */
> same comment as before, use a local pointer to the secure bank.


Of course, I will fix the code style by using a local pointer for the 
secure bank access.

>> +    memset(s->bank[SMMU_SEC_IDX_S].idr, 0, sizeof(s->bank[SMMU_SEC_IDX_S].idr));
>> +    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(s->bank[SMMU_SEC_IDX_S].idr[1],
>> +                                                S_IDR1, SECURE_IMPL,
>> +                                                s->secure_impl);
>> +    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(
>> +        s->bank[SMMU_SEC_IDX_S].idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
>> +    s->bank[SMMU_SEC_IDX_S].gbpa = SMMU_GBPA_RESET_VAL;
>> +    s->bank[SMMU_SEC_IDX_S].cmdq.entry_size = sizeof(struct Cmd);
>> +    s->bank[SMMU_SEC_IDX_S].eventq.entry_size = sizeof(struct Evt);
>>   }
>>
>>   static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>> @@ -2505,6 +2515,12 @@ static const Property smmuv3_properties[] = {
>>        * Defaults to stage 1
>>        */
>>       DEFINE_PROP_STRING("stage", SMMUv3State, stage),
>> +    /*
>> +     * SECURE_IMPL field in S_IDR1 register.
>> +     * Indicates whether secure state is implemented.
>> +     * Defaults to false (0)
>> +     */
>> +    DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
>>   };
> I would introduce the secure-impl property at the very end of the series
> because at this point migration is not yet supported.
> By the way the secure_impl field can be introduced in the first which
> uses it. I don't think "hw/arm/smmuv3: Introduce banked registers for
> SMMUv3 state" does
>
> Thanks
>
> Eric


You are absolutely right. Introducing the "secure-impl" property before 
the migration support is complete would expose an unfinished feature and 
could lead to serious issues for users. It was a mistake to place it here.


And secure_impl field is only used once at init to set the SECURE_IMPL 
register bit. After that, all checks correctly use the register bit, not 
the field.

I understand this is inconsistent. In the next version, I will make the 
logic more direct to improve readability.


Thanks,

Tao

>>   static void smmuv3_instance_init(Object *obj)
>> --
>> 2.34.1
>>


