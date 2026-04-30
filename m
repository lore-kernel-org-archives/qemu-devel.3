Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF4DCD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISyF-0001Tq-Qh; Thu, 30 Apr 2026 11:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISyD-0001TS-Rb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:06:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISyC-0001kh-1x
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:06:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so10173875e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777561586; x=1778166386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5gqjRPQR3cu8MiPxCpGzag6QUKQIqIv7pgW0GU3f8fA=;
 b=OZ2LqkRgrbmaPObqFzQrqYJlAFrUgESINcoWDb8dDyR5620wVzt3dG6uy3/6kvO1sD
 m22bYjJZLcAptmNckfvkKBFpFKyYPU0Fi0HPCFuctJgcwXQe7ZuEVUSORlKw62jZbUk8
 D5hgUXGQFSocZuf0ItKrY6xZ9Df6FmcWv9gabqthvSwxvj4Nk672o1+UVNIZwXq7Toim
 KsRai8fKr6kQq577I6xbIp5Yjkwxah+ESLZ9Z3Ns48Oj4dvtXStAsWsBOApFqNIP5WUr
 3O++Q5qkBw8GvvskHb6wmVU9O8XyYoc2topHWAaF2qYhIVriZoK3z7VUa72kGnwdPbh/
 t1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561586; x=1778166386;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5gqjRPQR3cu8MiPxCpGzag6QUKQIqIv7pgW0GU3f8fA=;
 b=nzM/EtoLeekJImd0XaQ0SJ9lwh5RYyJhPaVXxA0zllOOtcStzGTkkwMZ0aj4oYSvSw
 1j3btDs6NMJbnSO8r92EhPF4D01GbK6Ib3oRaw8ZpGtsoDyj/1K6p52cipJ3hvGuS5vz
 n5sSQ93kgzykWlHSf2ViFhArQZjGB/eDGMIzQruSf67VHB1DA9HwTtoZrKBD2B8Gc5sZ
 eTMC8qgf3Vkqb557okyfj0pSiBFvqu4GbhJB+nzT46WQIwFBnIFAj11Q+wRKXBTF/qPX
 m+buS3NzgDhShg7i8f+Zho0SuaqREeMP+L3+aOMjlv9xjhvaM1ZkmAixBzBynEgunTmP
 J7kQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mdKUbmZyE3AbY4LiM48b+YKZBNaE8c4C9FQJPP7spMLl3kEXEFTSkPRCqk1WjQABEize4bxl3y0/K@nongnu.org
X-Gm-Message-State: AOJu0Yw0AX7KUWqhiQbKZW/3QaByth/NAFhBquqvFb/Y0tHCuQhwm500
 JG2awtJ5wJlhyvKHxaCLZh48lwxYMju9l8vYpmorB90Rjq9J+LFDGvIs9JePuwBcLwA=
X-Gm-Gg: AeBDievX8bocw+/r5SYU0jhhE5J0Sp9SFZEmn884bEdVZjuDefTsyX6A1b+Uq/HnSZF
 yMT8Fy1BotNPcvyDowvv/7O7TA0P2/ft2mHbYdC5+hbLQPuDQjTG6gaP2UVoW+ozmjN/AokwsVx
 Z81rDk8x91Ohxy+ZrpxTm8NGm3NRWrYaNEUgDpMQ37KCapFiCWHtTYVwCNdLORIEW1MjlRA2Q6S
 0uNCGHh8CR5CeFaoZHMDY24Wg7ZoH0Y3alu/ZgQKs/CTBazOLIMIDzXEovHCZByXjAul8yelAJu
 swbHNwkueBvxSed/NLcjCaefZLajYs5+SCFL0Eir33JjSdGMae27kJ5dDnz7PmLDIunwfo5N45W
 SG85zUR88JxT/o2c/rkPzXnUHPNU6WSyjyisx20641qsBm5JvNxvYlB6E4tDQLYRGTNkdTJX6QB
 HIDzKBtbK6q6QcQi7jH/VtHGaGGhKDZxnL2J0NcV25pWIBwktxtIXUs9L8GEFDBoF0nchXa9j/j
 dYVdKaTDGNBRbk=
X-Received: by 2002:a05:600c:a40e:b0:488:fd7e:1063 with SMTP id
 5b1f17b1804b1-48a84468524mr47753795e9.29.1777561586022; 
 Thu, 30 Apr 2026 08:06:26 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b9493bsm63447385e9.0.2026.04.30.08.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 08:06:25 -0700 (PDT)
Message-ID: <c4ec559a-5451-45ad-8c85-2313912272a0@linaro.org>
Date: Thu, 30 Apr 2026 17:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/40] fpu: Return struct from parts{64,128}_muladd
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-27-richard.henderson@linaro.org>
 <9796771d-4d8f-44f9-ba8c-49f0c39a5a51@linaro.org>
In-Reply-To: <9796771d-4d8f-44f9-ba8c-49f0c39a5a51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 30/4/26 07:17, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 30/4/26 02:05, Richard Henderson wrote:
>> At the same time, export.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/fpu/softfloat-parts.h |  9 ++++
>>   fpu/softfloat.c               | 83 +++++++++++++++++------------------
>>   fpu/softfloat-parts.c.inc     | 38 ++++++++--------
>>   3 files changed, 69 insertions(+), 61 deletions(-)
> 
> 
>> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
>> index 77465cce6e..09b79f8d44 100644
>> --- a/fpu/softfloat-parts.c.inc
>> +++ b/fpu/softfloat-parts.c.inc
>> @@ -679,9 +679,8 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, 
>> FloatPartsN *b,
>>    * Requires A and C extracted into a double-sized structure to 
>> provide the
>>    * extra space for the widening multiply.
>>    */
>> -static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>> -                                   FloatPartsN *c,
>> -                                   int flags, float_status *s)
>> +FloatPartsN partsN(muladd)(const FloatPartsN *a, const FloatPartsN *b,
>> +                           const FloatPartsN *c, int flags, 
>> float_status *s)
>>   {
>>       int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
>>       int c_mask = float_cmask(c->cls);
>> @@ -719,10 +718,13 @@ static FloatPartsN *partsN(muladd)(FloatPartsN 
>> *a, FloatPartsN *b,
>>           }
>>           /* Narrow with sticky bit, for proper rounding later. */
>> -        fracN(truncjam)(a, &p_widen);
>> -        a->sign = p_widen.sign;
>> -        a->exp = p_widen.exp;
>> -        return a;
>> +        FloatPartsN r = {
>> +            .sign = p_widen.sign,
>> +            .exp = p_widen.exp,
>> +            .cls = float_class_normal,
> 
> It would be clearer if the float_class_normal change start appearing
> during previous reorganizative patch:
> 
>             a->cls = float_class_normal;

Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>> +        };
>> +        fracN(truncjam)(&r, &p_widen);
>> +        return r;
>>       }


