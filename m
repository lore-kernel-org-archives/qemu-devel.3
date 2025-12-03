Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B0BD15DA1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQp63-0004qp-Al; Wed, 03 Dec 2025 10:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQp5g-0004pA-4D; Wed, 03 Dec 2025 10:48:30 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQp5e-0001f4-9K; Wed, 03 Dec 2025 10:48:27 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnbyfAWzBphgcsAQ--.57476S2;
 Wed, 03 Dec 2025 23:48:16 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwAXcO2_WzBp51QJAA--.18499S2;
 Wed, 03 Dec 2025 23:48:15 +0800 (CST)
Message-ID: <8ee83b18-9121-43df-b7e7-94be172cf511@phytium.com.cn>
Date: Wed, 3 Dec 2025 23:48:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 20/21] hw/arm/smmuv3: Initialize the secure register bank
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151542.4131398-1-tangtao1634@phytium.com.cn>
 <a63b3689-ef46-48b1-ae28-34976ab34d0b@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <a63b3689-ef46-48b1-ae28-34976ab34d0b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXcO2_WzBp51QJAA--.18499S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQAGsu
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrW3JFy8JF1ktFykuFWfKrg_yoW8Aw17pa
 n7G3Z0ka4UG3W8WrZFqr1rAF1Iq3ySqr1UCrW5KF15Aw15Arn5JryUKayYgFZakrZ8CF40
 9F4j9aykZrsxZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
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

On 2025/12/3 00:36, Eric Auger wrote:
> Hi Tao,
>
> On 10/12/25 5:15 PM, Tao Tang wrote:
>> Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
>> values during the SMMU's reset sequence.
>>
>> This change ensures that key fields, such as the secure ID registers,
>> GBPA reset value, and queue entry sizes, are set to a known-good state.
>> The SECURE_IMPL attribute of the S_IDR1 register will be introduced
>> later via device properties.
>>
>> This is a necessary step to prevent undefined behavior when secure SMMU
>> features are subsequently enabled and used by software.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index b44859540f..0b366895ec 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -331,6 +331,15 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>       bk->gerrorn = 0;
>>       s->statusr = 0;
>>       bk->gbpa = SMMU_GBPA_RESET_VAL;
>> +
>> +    /* Initialize Secure bank */
>> +    SMMUv3RegBank *sbk = &s->bank[SMMU_SEC_SID_S];
>> +
>> +    memset(sbk->idr, 0, sizeof(sbk->idr));
>> +    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, SMMU_IDR1_SIDSIZE);
>> +    sbk->gbpa = SMMU_GBPA_RESET_VAL;
>> +    sbk->cmdq.entry_size = sizeof(struct Cmd);
>> +    sbk->eventq.entry_size = sizeof(struct Evt);
> what about prod, cons, base? Don't they need to initialized as for NS.
>
> Also I am surprised only one IDR field is set. No need for some others?
>
> Eric


I’ll add the missing initializations in the next version, and will try 
to keep the secure and non-secure banks as close to mirrored as 
possible, and only diverging where a field doesn’t exist on one side.


Thanks,

Tao


