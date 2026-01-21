Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0DEC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viaE6-0003Il-Qg; Wed, 21 Jan 2026 10:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1viaDx-0003Fe-QA; Wed, 21 Jan 2026 10:34:26 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1viaDv-00052l-0o; Wed, 21 Jan 2026 10:34:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnjifx8XBpP1lHAw--.11878S2;
 Wed, 21 Jan 2026 23:34:09 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.118.47])
 by mail (Coremail) with SMTP id AQAAfwBXsO3d8XBpxX4VAA--.23264S2;
 Wed, 21 Jan 2026 23:34:04 +0800 (CST)
Message-ID: <31a168ba-3344-429c-918b-24481f8261f0@phytium.com.cn>
Date: Wed, 21 Jan 2026 23:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v9 2/8] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
 <20260119161112.3841386-3-tangtao1634@phytium.com.cn>
 <fa73ef10-4a1e-486d-9d80-550c91eef11f@linaro.org>
 <0e71fdee-3569-4f83-afc8-46e0cbe565d0@phytium.com.cn>
 <ad975568-9ff4-420f-9b98-725d0c3e7c64@linaro.org>
 <0d1ab48f-e537-49de-b5ae-f8ddcabdd8a0@phytium.com.cn>
 <595f75a4-7a85-4319-a8b2-8d5e10459068@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <595f75a4-7a85-4319-a8b2-8d5e10459068@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXsO3d8XBpxX4VAA--.23264S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQACBWlv4X8GvAAAsk
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ww43Cr1xJr18WF4DWF13XFb_yoW7WFWrp3
 WktF15CFZYgw1xCr1Iqw47CFyayw4kC3W0qry7WryxXrs0qr9Fqr4Iq3Z0gF1Uur4kXr1U
 uF4Sqa93uryayrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Philippe,

On 2026/1/21 01:57, Philippe Mathieu-Daudé wrote:
> Hi Tao,
>
> On 20/1/26 02:02, Tao Tang wrote:
>> On 2026/1/20 01:22, Philippe Mathieu-Daudé wrote:
>>> On 19/1/26 17:51, Tao Tang wrote:
>>>> Hi Philippe,
>>>>
>>>> On 2026/1/20 00:38, Philippe Mathieu-Daudé wrote:
>>>>> On 19/1/26 17:11, Tao Tang wrote:
>>>>>> Switch STE/CD bitfield definitions and accessors to the
>>>>>> 'registerfields.h' REG/FIELD API.
>>>>>>
>>>>>> FOLLOW-UP: Fix CTXPTR_HI/S2TTB_HI/TTB0_HI/TTB1_HI high bits width
>>>>>> (should be 24 bits, not 16).
>>>>>
>>>>> Right, but ...
>>>>>
>>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>>> ---
>>>>>>   include/hw/arm/smmuv3-common.h | 169 ++++++++++++++++++++++ 
>>>>>> +----------
>>>>>>   1 file changed, 120 insertions(+), 49 deletions(-)
>>>>>
>>>>>
>>>>>> -#define STE_VALID(x) extract32((x)->word[0], 0, 1)
>>>>>> +REG32(STE_0, 0)
>>>>>> +    FIELD(STE_0, VALID, 0, 1)
>>>>>> +    FIELD(STE_0, CONFIG, 1, 3)
>>>>>> +    FIELD(STE_0, S1FMT, 4, 2)
>>>>>> +    FIELD(STE_0, CTXPTR_LO, 6, 26)
>>>>>> +REG32(STE_1, 4)
>>>>>> +    FIELD(STE_1, CTXPTR_HI, 0, 16)
>>>>>
>>>>> ... not followed up?
>>>>
>>>>
>>>> Sorry, there's a typo here. What I was thinking at the time was 
>>>> that I would submit a separate patch follow this series.
>>>
>>> I squashed:
>>>
>>> --  >8 --
>>> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3- 
>>> common.h
>>> index 6b48b5414dd..db30331441a 100644
>>> --- a/include/hw/arm/smmuv3-common.h
>>> +++ b/include/hw/arm/smmuv3-common.h
>>> @@ -43,7 +43,7 @@ REG32(STE_0, 0)
>>>      FIELD(STE_0, S1FMT, 4, 2)
>>>      FIELD(STE_0, CTXPTR_LO, 6, 26)
>>>  REG32(STE_1, 4)
>>> -    FIELD(STE_1, CTXPTR_HI, 0, 16)
>>> +    FIELD(STE_1, CTXPTR_HI, 0, 24)
>>>      FIELD(STE_1, S1CDMAX, 27, 5)
>>>  REG32(STE_2, 8)
>>>      FIELD(STE_2, S1STALLD, 27, 1)
>>> (1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? y
>>> @@ -66,7 +66,7 @@ REG32(STE_5, 20)
>>>  REG32(STE_6, 24)
>>>      FIELD(STE_6, S2TTB_LO, 4, 28)
>>>  REG32(STE_7, 28)
>>> -    FIELD(STE_7, S2TTB_HI, 0, 16)
>>> +    FIELD(STE_7, S2TTB_HI, 0, 24)
>>>
>>> ---
>>>
>>> Is that OK with you? Do TTB0_HI/TTB1_HI need update too?
>>
>> Yes we should update TTB0_HI/TTB1_HI too. A total of four 
>> modifications are needed here:
>>
>> CTXPTR_HI
>>
>> S2TTB_HI
>>
>> TTB0_HI
>>
>> TTB1_HI
>
> I am just trying to help you getting your series merged. I know this is
> v9 and you might be frustrated, but simply providing the correct 4
> values would have helped both of us and save further exchanges.
>
> In v8 Eric said to change 16 -> 24 for 4 fields and you confirmed:
> https://lore.kernel.org/qemu-devel/2255d30c-cc58-4a45-974c-f7fd89694c26@phytium.com.cn/ 
>
>
> Looking at ARM IHI 0070G.b this is only valid for CTXPTR_HI, for the
> rest only 20 bits remains, 4 are RES0 (SMMUv3.1).
>
> It would have saved me some hours checking the spec if you had
> provided the correct values beforehand. I'm going to squash the
> following instead:
>
> -- >8 --
> diff --git a/include/hw/arm/smmuv3-common.h 
> b/include/hw/arm/smmuv3-common.h
> index 6b48b5414dd..f0e1dd85715 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -45,3 +45,3 @@ REG32(STE_0, 0)
>  REG32(STE_1, 4)
> -    FIELD(STE_1, CTXPTR_HI, 0, 16)
> +    FIELD(STE_1, CTXPTR_HI, 0, 24)
>      FIELD(STE_1, S1CDMAX, 27, 5)
> @@ -68,3 +68,3 @@ REG32(STE_6, 24)
>  REG32(STE_7, 28)
> -    FIELD(STE_7, S2TTB_HI, 0, 16)
> +    FIELD(STE_7, S2TTB_HI, 0, 20)
>
> @@ -128,3 +128,3 @@ REG32(CD_2, 8)
>  REG32(CD_3, 12)
> -    FIELD(CD_3, TTB0_HI, 0, 19)
> +    FIELD(CD_3, TTB0_HI, 0, 20)
>  REG32(CD_4, 16)
> @@ -133,3 +133,3 @@ REG32(CD_4, 16)
>  REG32(CD_5, 20)
> -    FIELD(CD_5, TTB1_HI, 0, 19)
> +    FIELD(CD_5, TTB1_HI, 0, 20)
>
> ---
>
> If you disagree, please post a patch on top to correct.
>
> Regards,
>
> Phil.


Sorry I wasn’t clear earlier and didn’t provide the exact values and 
reasoning — that wasted your time.

Regarding the spec versions, F.b and earlier used narrower ranges (e.g. 
CD.TTB0 [115:68]), while from G.a onward these base-pointer fields are 
shown with the widened ranges (e.g. CD.TTB0 [119:68]). For clarity, the 
main layout changes I was referring to from F.b to G.a are:

STE.S1ContextPtr  [51:6] -> [55:6]

STE.S2TTB            [243:196] -> [247:196]

CD.TTB0              [115:68] -> [119:68]

CD.TTB1              [179:132] -> [183:132]


(Where my earlier [115:68] example was specifically for TTB0.)

- G.a: https://developer.arm.com/documentation/ihi0070/ga/?lang=en

- F.b: https://developer.arm.com/documentation/ihi0070/fb/?lang=en


I initially looked only at the layout/bit ranges (5.4 CD) and missed 
that the top 4 bits are only meaningful when AA64 selects VMSAv9-128; 
otherwise they are RES0. With that in mind, I agree with your updated 
widths and I’m OK with you squashing the changes as proposed.

Best regards,
Tao


