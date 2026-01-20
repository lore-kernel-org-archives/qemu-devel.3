Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3318D2ECFB
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 01:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi09K-0003j4-Rs; Mon, 19 Jan 2026 20:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vi09H-0003ha-Hq; Mon, 19 Jan 2026 20:03:11 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vi09F-0007DM-2V; Mon, 19 Jan 2026 20:03:11 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXeCVB1G5pz9E6Aw--.8787S2;
 Tue, 20 Jan 2026 09:02:57 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3Tes01G5ppwQVAA--.22218S2;
 Tue, 20 Jan 2026 09:02:45 +0800 (CST)
Message-ID: <0d1ab48f-e537-49de-b5ae-f8ddcabdd8a0@phytium.com.cn>
Date: Tue, 20 Jan 2026 09:02:44 +0800
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
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <ad975568-9ff4-420f-9b98-725d0c3e7c64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3Tes01G5ppwQVAA--.22218S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWltPrkFOAAEs+
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF4rAFy8Jr1fGFy3GF48Zwb_yoW8KF1rp3
 Z7tFn8GFZ3Jw1I9r1ftw47AFyakw4kA3W8tryxXrWxXw4qq342qr42q3s0gFy8urWkXr1U
 WFs2va93ury3K3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Philippe,

On 2026/1/20 01:22, Philippe Mathieu-Daudé wrote:
> On 19/1/26 17:51, Tao Tang wrote:
>> Hi Philippe,
>>
>> On 2026/1/20 00:38, Philippe Mathieu-Daudé wrote:
>>> On 19/1/26 17:11, Tao Tang wrote:
>>>> Switch STE/CD bitfield definitions and accessors to the
>>>> 'registerfields.h' REG/FIELD API.
>>>>
>>>> FOLLOW-UP: Fix CTXPTR_HI/S2TTB_HI/TTB0_HI/TTB1_HI high bits width
>>>> (should be 24 bits, not 16).
>>>
>>> Right, but ...
>>>
>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>   include/hw/arm/smmuv3-common.h | 169 
>>>> +++++++++++++++++++++++----------
>>>>   1 file changed, 120 insertions(+), 49 deletions(-)
>>>
>>>
>>>> -#define STE_VALID(x) extract32((x)->word[0], 0, 1)
>>>> +REG32(STE_0, 0)
>>>> +    FIELD(STE_0, VALID, 0, 1)
>>>> +    FIELD(STE_0, CONFIG, 1, 3)
>>>> +    FIELD(STE_0, S1FMT, 4, 2)
>>>> +    FIELD(STE_0, CTXPTR_LO, 6, 26)
>>>> +REG32(STE_1, 4)
>>>> +    FIELD(STE_1, CTXPTR_HI, 0, 16)
>>>
>>> ... not followed up?
>>
>>
>> Sorry, there's a typo here. What I was thinking at the time was that 
>> I would submit a separate patch follow this series.
>
> I squashed:
>
> --  >8 --
> diff --git a/include/hw/arm/smmuv3-common.h 
> b/include/hw/arm/smmuv3-common.h
> index 6b48b5414dd..db30331441a 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -43,7 +43,7 @@ REG32(STE_0, 0)
>      FIELD(STE_0, S1FMT, 4, 2)
>      FIELD(STE_0, CTXPTR_LO, 6, 26)
>  REG32(STE_1, 4)
> -    FIELD(STE_1, CTXPTR_HI, 0, 16)
> +    FIELD(STE_1, CTXPTR_HI, 0, 24)
>      FIELD(STE_1, S1CDMAX, 27, 5)
>  REG32(STE_2, 8)
>      FIELD(STE_2, S1STALLD, 27, 1)
> (1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? y
> @@ -66,7 +66,7 @@ REG32(STE_5, 20)
>  REG32(STE_6, 24)
>      FIELD(STE_6, S2TTB_LO, 4, 28)
>  REG32(STE_7, 28)
> -    FIELD(STE_7, S2TTB_HI, 0, 16)
> +    FIELD(STE_7, S2TTB_HI, 0, 24)
>
> ---
>
> Is that OK with you? Do TTB0_HI/TTB1_HI need update too?

Yes we should update TTB0_HI/TTB1_HI too. A total of four modifications 
are needed here:

CTXPTR_HI

S2TTB_HI

TTB0_HI

TTB1_HI


Thanks,

Tao


