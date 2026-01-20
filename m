Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C22CA5FD5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFzG-0003F1-Va; Tue, 20 Jan 2026 12:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viFzF-0003DQ-B3
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:57:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viFzD-0008KV-Fp
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:57:53 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-43590777e22so535210f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768931870; x=1769536670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zyNG9T6CxyJn1QssaX5e35tMUVXdK/wUfcLIas+BmYY=;
 b=mRhdKwA559G7AzLYCYDV7WTI6YimXm9feZDCEQH1NqRRWZRkcmO21P+cqbZRI1emnX
 HyyITys1pbVLye+iOq6e11t6bt1n7npkPlyIu2TqjxAR3pDflJifCyBYUoL+ahSpPvj0
 3hFg8by9wyiFcdHkigNcggZ9Mhru5uyCxBpkRRo5Z5JpQMKoT54AipyTQ/KPFExU+dx/
 yQ3766ZcFdvKLdVUWn4YpHtE1UzghzVQ7ZUL+wCPQNfxDR7FoUfQBHD7e+2sFM+y1Kx+
 cryS00yL+OCS+cSPKH1HPg0sZSZH2AwSjzUMijKn55U4Ow+t++2US2WP5eZS9BaybWOA
 J5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768931870; x=1769536670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zyNG9T6CxyJn1QssaX5e35tMUVXdK/wUfcLIas+BmYY=;
 b=Bqfj6a6K21bvuDgNjUMZd4DD++zdM1qS0hcc6mPc6If4n8+tIaoSPtzoDRRQ7FjZOZ
 nNWz+VkfgpeaHQ3lAeMxSjqABsYteC2+EXmCAhbc6Wzef92ZxwNDRPMyZKULeyY5i8kR
 Un5RXa76UOhe42iI0avkfz+46p9tVrNV3kXyCK0AP8JIFvWpg0sP0b5s30R37XOJ8JCw
 ydDycsb2x9RewU1SPu/TDl8FNgs9tTN3CeedZ12esBClsC5ATWM2fS1Uf+zJWr/hUhJc
 +c53/m49cQLZBRuISKRPwtMY7G3cRDeBpI3xlVrZvy5ZT73niOGSNbILNxNbc7uB9cRl
 PKsg==
X-Gm-Message-State: AOJu0Yy3I97+UqVX6mtH56j6SPz6qMO4/Tl5hCbtylzpMtuA4lnRhCAw
 KJCPLdJdJHmT4CxvwxiUdGH+8bGj5ofMA8ilIqZk7bfu3C8bdYYqDBtwoMP/2x6lIuA=
X-Gm-Gg: AZuq6aIHFQunY8hBme437namI3kj9NuAPltHEXCB/OCdxLyvBezRHMM5CmexanIXH2V
 VDq1MkbocS74vDOUx2ieTbmcswQdB71a2GdD4AMLfHzkdra5Z04CzopkznuZ8Ea7avRMQ03ZLOp
 7hw3YhFDq2MKXSZYMCxN7b9xgCWxOt1Eeuhca09s4Gg1kgGiNPAL978+mVL8oq3hWtsiyWHHQWg
 TsMSYVGLhnJSUhdBXrDCoktzuBiF5SoqFNDEZfgcH1bYyqo7lM+Ybn+QhyeM+CpEf44nv86psCh
 bTcVzsbJntGBKp7byHN6GHrT1IZ9Ad0IXX9rSxclLvcL+Jq35urlmZBVwQZCAvSikuObbB2xiTV
 EfgZVdaYeefyfVE9xXm6FOw2kvcNk+DjRkiZqOpLpfljFOQu+5v8bro50zK5KnpYD9lvzg0yJ21
 fFj1Odl+++4eJHGm5/0Zj4tudhZFY/lNMhKznJO3WletnawYVT5y1jfg==
X-Received: by 2002:a05:6000:ec2:b0:435:924e:3d73 with SMTP id
 ffacd0b85a97d-435924e3e7fmr3250528f8f.58.1768931869783; 
 Tue, 20 Jan 2026 09:57:49 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43596b62700sm1617505f8f.42.2026.01.20.09.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 09:57:49 -0800 (PST)
Message-ID: <595f75a4-7a85-4319-a8b2-8d5e10459068@linaro.org>
Date: Tue, 20 Jan 2026 18:57:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v9 2/8] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0d1ab48f-e537-49de-b5ae-f8ddcabdd8a0@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Tao,

On 20/1/26 02:02, Tao Tang wrote:
> On 2026/1/20 01:22, Philippe Mathieu-Daudé wrote:
>> On 19/1/26 17:51, Tao Tang wrote:
>>> Hi Philippe,
>>>
>>> On 2026/1/20 00:38, Philippe Mathieu-Daudé wrote:
>>>> On 19/1/26 17:11, Tao Tang wrote:
>>>>> Switch STE/CD bitfield definitions and accessors to the
>>>>> 'registerfields.h' REG/FIELD API.
>>>>>
>>>>> FOLLOW-UP: Fix CTXPTR_HI/S2TTB_HI/TTB0_HI/TTB1_HI high bits width
>>>>> (should be 24 bits, not 16).
>>>>
>>>> Right, but ...
>>>>
>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>> ---
>>>>>   include/hw/arm/smmuv3-common.h | 169 ++++++++++++++++++++++ 
>>>>> +----------
>>>>>   1 file changed, 120 insertions(+), 49 deletions(-)
>>>>
>>>>
>>>>> -#define STE_VALID(x) extract32((x)->word[0], 0, 1)
>>>>> +REG32(STE_0, 0)
>>>>> +    FIELD(STE_0, VALID, 0, 1)
>>>>> +    FIELD(STE_0, CONFIG, 1, 3)
>>>>> +    FIELD(STE_0, S1FMT, 4, 2)
>>>>> +    FIELD(STE_0, CTXPTR_LO, 6, 26)
>>>>> +REG32(STE_1, 4)
>>>>> +    FIELD(STE_1, CTXPTR_HI, 0, 16)
>>>>
>>>> ... not followed up?
>>>
>>>
>>> Sorry, there's a typo here. What I was thinking at the time was that 
>>> I would submit a separate patch follow this series.
>>
>> I squashed:
>>
>> --  >8 --
>> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3- 
>> common.h
>> index 6b48b5414dd..db30331441a 100644
>> --- a/include/hw/arm/smmuv3-common.h
>> +++ b/include/hw/arm/smmuv3-common.h
>> @@ -43,7 +43,7 @@ REG32(STE_0, 0)
>>      FIELD(STE_0, S1FMT, 4, 2)
>>      FIELD(STE_0, CTXPTR_LO, 6, 26)
>>  REG32(STE_1, 4)
>> -    FIELD(STE_1, CTXPTR_HI, 0, 16)
>> +    FIELD(STE_1, CTXPTR_HI, 0, 24)
>>      FIELD(STE_1, S1CDMAX, 27, 5)
>>  REG32(STE_2, 8)
>>      FIELD(STE_2, S1STALLD, 27, 1)
>> (1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? y
>> @@ -66,7 +66,7 @@ REG32(STE_5, 20)
>>  REG32(STE_6, 24)
>>      FIELD(STE_6, S2TTB_LO, 4, 28)
>>  REG32(STE_7, 28)
>> -    FIELD(STE_7, S2TTB_HI, 0, 16)
>> +    FIELD(STE_7, S2TTB_HI, 0, 24)
>>
>> ---
>>
>> Is that OK with you? Do TTB0_HI/TTB1_HI need update too?
> 
> Yes we should update TTB0_HI/TTB1_HI too. A total of four modifications 
> are needed here:
> 
> CTXPTR_HI
> 
> S2TTB_HI
> 
> TTB0_HI
> 
> TTB1_HI

I am just trying to help you getting your series merged. I know this is
v9 and you might be frustrated, but simply providing the correct 4
values would have helped both of us and save further exchanges.

In v8 Eric said to change 16 -> 24 for 4 fields and you confirmed:
https://lore.kernel.org/qemu-devel/2255d30c-cc58-4a45-974c-f7fd89694c26@phytium.com.cn/

Looking at ARM IHI 0070G.b this is only valid for CTXPTR_HI, for the
rest only 20 bits remains, 4 are RES0 (SMMUv3.1).

It would have saved me some hours checking the spec if you had
provided the correct values beforehand. I'm going to squash the
following instead:

-- >8 --
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 6b48b5414dd..f0e1dd85715 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -45,3 +45,3 @@ REG32(STE_0, 0)
  REG32(STE_1, 4)
-    FIELD(STE_1, CTXPTR_HI, 0, 16)
+    FIELD(STE_1, CTXPTR_HI, 0, 24)
      FIELD(STE_1, S1CDMAX, 27, 5)
@@ -68,3 +68,3 @@ REG32(STE_6, 24)
  REG32(STE_7, 28)
-    FIELD(STE_7, S2TTB_HI, 0, 16)
+    FIELD(STE_7, S2TTB_HI, 0, 20)

@@ -128,3 +128,3 @@ REG32(CD_2, 8)
  REG32(CD_3, 12)
-    FIELD(CD_3, TTB0_HI, 0, 19)
+    FIELD(CD_3, TTB0_HI, 0, 20)
  REG32(CD_4, 16)
@@ -133,3 +133,3 @@ REG32(CD_4, 16)
  REG32(CD_5, 20)
-    FIELD(CD_5, TTB1_HI, 0, 19)
+    FIELD(CD_5, TTB1_HI, 0, 20)

---

If you disagree, please post a patch on top to correct.

Regards,

Phil.

