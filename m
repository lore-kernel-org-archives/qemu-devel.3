Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25E3C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WY6-0002VF-OP; Mon, 07 Sep 2026 06:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3WY4-0002Ut-KP; Mon, 07 Sep 2026 06:26:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3WY2-0002Y2-0E; Mon, 07 Sep 2026 06:26:00 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDXgMgvkZ5qKOY_AQ--.46099S2; 
 Mon, 07 Sep 2026 18:25:51 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwKXIikZ5qQ5jQAA--.28830S2;
 Mon, 07 Sep 2026 18:25:40 +0800 (CST)
Message-ID: <95e020f7-cb10-47d1-82b8-4bef59959141@phytium.com.cn>
Date: Mon, 7 Sep 2026 18:25:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 07/28] hw/arm/smmuv3: Reject secure STEs with stage-2
 enabled
To: Mostafa Saleh <smostafa@google.com>, Eric Auger <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-2-tangtao1634@phytium.com.cn>
 <apbanfZIyTlA5fvk@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <apbanfZIyTlA5fvk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwKXIikZ5qQ5jQAA--.28830S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWqdv0cF1wABsT
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr4UtFWDArWDWFW3AFW3GFg_yoW8trykpr
 WUG3Z0gFs5KFyxZrWSvw48ZF1DWa97tr97Crn7K34fAr4DAr1DtrnFkF1Y93s8Xr95tFW8
 Za4IqFn8XF4jyrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Mostafa, Eric,

On 2026/9/1 22:01, Mostafa Saleh wrote:
> On Fri, Aug 14, 2026 at 12:24:43AM +0800, Tao Tang wrote:
>> Pass sec_sid into decode_ste() and treat a secure STE that enables stage-2
>> translation as an illegal STE.
>>
>> The current model does not implement Secure stage-2 translation, so reject
>> Secure STE configurations that enable stage 2 and report BAD_STE. This
>> restriction can be relaxed when SEL2 and Secure stage-2 support are
>> implemented.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index b5dc67dcb01..3ff2f498a3b 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -597,7 +597,7 @@ static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
>>   
>>   /* Returns < 0 in case of invalid STE, 0 otherwise */
>>   static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>> -                      STE *ste, SMMUEventInfo *event)
>> +                      STE *ste, SMMUEventInfo *event, SMMUSecSID sec_sid)
>>   {
>>       uint32_t config;
>>       /* OAS field only presents on NS-IDR5 so we use hardcoded SMMU_SEC_SID_NS */
>> @@ -651,6 +651,14 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>>           if (ret) {
>>               goto bad_ste;
>>           }
>> +
>> +        /*
>> +         * It is ILLEGAL to set STE.Config == 0b11x according to (IHI 0070G.b)
>> +         * 5.2 STE, Stream Table Entry, Page 218.
>> +         */
> This is not the latest spec, and there is no need to mention the page.
> It might be more clear to mention that Qemu doesn’t support secure
> stage-2 rather than say it is ILLEGAL.

Agreed. I'll change the comment to say that the model does not support 
Secure stage 2 translation, and remove the spec version/page reference. 
I'll also clarify SMMU_S_IDR1.SEL2 in the commit message.

@Eric, I've replied to your questions about the S2 plumbing and the 
temporary SEL2 override in the threads for patches 6 [1] and 28 [2].

[1] 
https://lore.kernel.org/qemu-devel/2a6ae5cc-9e6e-4d5b-93f7-c2ecc0faa25c@phytium.com.cn/
[2] 
https://lore.kernel.org/qemu-devel/ba9005ea-5616-495f-b817-5d90b4ce1ca0@phytium.com.cn/

Best regards,
Tao


