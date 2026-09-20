Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF89C982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Jjq-0004hb-3B; Sun, 20 Sep 2026 11:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x8Jjm-0004hL-Rm; Sun, 20 Sep 2026 11:45:55 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x8Jjk-0003pn-Je; Sun, 20 Sep 2026 11:45:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBHT1uq_69qJo4PAA--.6654S2;
 Sun, 20 Sep 2026 23:45:46 +0800 (CST)
Received: from [192.168.2.11] (unknown [113.246.117.227])
 by mail (Coremail) with SMTP id AQAAf8Dw5HKo_69q5OTYAA--.36591S2;
 Sun, 20 Sep 2026 23:45:44 +0800 (CST)
Message-ID: <81c3cac2-60b1-4f0b-b67f-e15c55e2120f@phytium.com.cn>
Date: Sun, 20 Sep 2026 23:45:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 27/28] hw/arm/smmuv3: Add secure bank migration and
 secure-impl property
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Jim MacArthur
 <jim.macarthur@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162644.2810021-1-tangtao1634@phytium.com.cn>
 <f0dc00d6-c49b-4dc1-b6de-706142856089@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <f0dc00d6-c49b-4dc1-b6de-706142856089@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw5HKo_69q5OTYAA--.36591S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWqu4t8GyQACs0
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFyfGrWxZw4fWryrXFy7Jrb_yoW5ZrWrpa
 18GFn8KFWjgF13Jr1aqw1xuFyFk3yrWa1DArsrJw15Z3WUAr15Xw17C3yY9FWkur48Ja1I
 van7ua93Cr4jgFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

On 2026/8/31 16:51, Eric Auger wrote:
> Hi Tao,
> On 8/13/26 6:26 PM, Tao Tang wrote:
>> Add a secure-impl device property and advertise it through
>> S_IDR1.SECURE_IMPL. Reject secure-impl=on unless Secure memory is available
>> and stage-1 translation is supported.
> please document why the auto mode is needed (dependency on virt secure
> option)
>
> May make sense to document it in system/arm/virt.rst too as it has a
> dependency on the secure setup of the machine
I'll document auto in the commit message and virt.rst.
>> Usage:
>>      -M virt,secure=on,iommu=smmuv3 \
>>      -global arm-smmuv3.secure-impl=on
> does it work with arm-smmuv3 device too?

Yes, it also works with user-created arm-smmuv3 devices. It'll be like:


-M virt,secure=on
-device arm-smmuv3,primary-bus=pcie.0,secure-impl=on
>> Add the smmuv3/bank_s migration subsection for the secure register bank.
>> Serialize secure bank state including GBPA, IRQ config, stream table and
>> queue state.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3.c         | 93 +++++++++++++++++++++++++++++++++++++++++
>>   include/hw/arm/smmuv3.h |  2 +
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 7e7376c65e2..8e1de94fd17 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -348,6 +348,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>   
>>       sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, S_SIDSIZE,
>>                                  SMMU_IDR1_SIDSIZE);
>> +    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, SECURE_IMPL,
>> +                               s->secure_impl == ON_OFF_AUTO_ON);
>>       smmuv3_accel_idr_override(s);
>>   }
>>   
>> @@ -2752,6 +2754,37 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>       return true;
>>   }
>>   
>> +static bool smmuv3_resolve_secure_impl(SMMUv3State *s, Error **errp)
>> +{
>> +    SMMUState *bs = ARM_SMMU(s);
>> +    bool secure_as_available = bs->secure_memory &&
>> +                               bs->secure_memory_as.root != NULL;
>> +
>> +    if (s->secure_impl == ON_OFF_AUTO_AUTO) {
>> +        s->secure_impl = secure_as_available ? ON_OFF_AUTO_ON
>> +                                             : ON_OFF_AUTO_OFF;
>> +    }
>> +
>> +    if (s->secure_impl == ON_OFF_AUTO_ON && !secure_as_available) {
>> +        error_setg(errp,
>> +                   "secure-impl=on requires a secure-memory address space");
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * When SECURE_IMPL == 1, stage 1 must be supported according to
>> +     * (IHI 0070G.b) 6.3.53 SMMU_S_IDR1, Page 442.
>> +     */
>> +    if (s->secure_impl == ON_OFF_AUTO_ON &&
>> +        s->stage && !strcmp(s->stage, "2")) {
> we already have smmu_validate_property(). Would be better located there
> if possible. Otherwise please justify it.
>
> Please split this patch into 2. The migration support on one end, which
> only depends on OnOffAuto secure_impl;
> and the rest

Yes moving this checking code  into smmu_validate_property is a better 
choice. I'll handle it in V6. Also this patch will be splitted as your 
description.


Thanks to everyone for your time and effort in reviewing this series. 
I’ll send v6 in a few days.

Best Regards,

Tao


