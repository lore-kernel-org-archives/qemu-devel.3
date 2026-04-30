Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE729CD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYlP-0000nd-Fm; Thu, 30 Apr 2026 17:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIYlN-0000mn-J8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:17:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIYlL-0005bv-S6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:17:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so781855f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777583854; x=1778188654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBKrdmKjpca1pfd6EOXiMWXicvjqRCyVsZg1AbsN/uo=;
 b=KssDBmh3Nd7ytWr9PsFN3eMLEkCe7SBErtTumxY1xLx4rz5vZ+GW2ly5ipSgtHhDNv
 BA89CJsx/vlKQCVClxdSHrpXOSq+0xw8+PIIv/yebJ83fugN7Bxc5PXiFK2Gr49JzLEf
 zshMfxr0Oid12ZMwPUMVRVrCY7vxrWExCea0T0CUo+nVcvodt50XTdN5HgURwgJ6tmmH
 Gdt8kP702YzJx3AwAj/Pj9l7UD9nohvxJSZ6VuZOCNM34vsVuu0hjyHzN5Zm38hP5w+B
 hqHkThYSHuALge2ZRCIbNF9ApLbcgNnO6jvvBphf/EQg0+evIS+IYGbcw3iwTA0W7+3Y
 jz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777583854; x=1778188654;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBKrdmKjpca1pfd6EOXiMWXicvjqRCyVsZg1AbsN/uo=;
 b=RG2l9dgA2NcByCg6qfgfoTD91qTocXulkLjKKLCty0yyC0cm8nRC11ntpvxKdqwsrt
 CKE2rcY6Ws0biMlNQl7qNqjeI5EozhI6Ot8tNbLilkYYBGilOe9LRI8qj1+zM9PuxkhF
 fyfAJiqOVwGTj35d40lNIIhsDreegaT1xpBot9cZpBpXFHOyDjQRggHfu70Ty+Efkoyq
 Ab6qOrFt1o2UGPuCESjgeuvcrz8N9UjwtqlsYNUAJ6jfLVvrPWFL02kZBfP6FsxHtBG4
 eJynz6rfwwnUscufPaOvRvoauiBXk3y1PeC8j0oWqAcWqmKaJxO2WOCBev8+KQvSGyzZ
 mUwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RbZahcEWqwKxS57xe2z+Ez2hUfimOc6MYfusmQ9iHd1BLf5KRYL4P6lAnBaSk6PLOLc64oopbN9z/@nongnu.org
X-Gm-Message-State: AOJu0Yyl8DjqmDHPWGOdLDzxP4a1Vwy6CN8HBtzh9cMNugyreH0+njw9
 9CzNaNMc4GHG+md6q28R2ml/xMOdqYhXWZsYoa6AKy41euO7q9npWPs8vYBkWwT8W68=
X-Gm-Gg: AeBDiesDsBymtNZNXhKrZDzyRj91USATEgbwf6rPjBMx4VtRgIoX+CEipqxk1/PoQZ5
 D0H7nkdhVx7L4IBMyXysvNdSpTRHmSdR/EJmXjQw7DzJmyp+vWQE8TBlNDh2CbBJxKySHtsIuyy
 OV0Ug1dKY9dTgL7LHtXHc45nG2jJDPbw3wz2+1sp/6tvRVzwwuMrv4It6/xkuy8aRyDrA+Jd+y6
 wBb9hj6Ft7J+eVwbJkIcG+Kx/HFpdDS5sMUJnK+ERH9dhOsUHS9hDKAleBqPszon5q48SEgKzSa
 Cz0eRi1LmyIpU0ubyscol7m06oNtOx9dOFs8TcEv9FnxD8LZNZlO2ePdi5c4GS4K9W0gd+14mln
 zhusbQ3dPXGfrCPjRqM4mkPcNVEUlznIUPd7K6eFSGw5w3eqSmgakDXdGDi8IERvoPS7XxbgzoK
 lQRY3g/4TaTIm3sxb+xk7mNP6EFOIBs8Sy4wCa7INQpSI1hpK4xk4Ygb7B52vU2ch8kgyD5w7Bw
 JyCL9MORhIoe2M=
X-Received: by 2002:a05:6000:40da:b0:449:9aee:4576 with SMTP id
 ffacd0b85a97d-44a8674246dmr501571f8f.10.1777583853576; 
 Thu, 30 Apr 2026 14:17:33 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a98b7721fsm220136f8f.36.2026.04.30.14.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 14:17:32 -0700 (PDT)
Message-ID: <097c020a-c067-4704-9372-ffaf0871f6c2@linaro.org>
Date: Thu, 30 Apr 2026 23:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/40] fpu: Return struct from parts{64,128}_silence_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-14-richard.henderson@linaro.org>
 <d4bcf6ae-f5bb-41fc-941e-4d43d3cf9e88@linaro.org>
 <35b14bcb-b0b6-459b-83c9-7269ea7fbdef@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <35b14bcb-b0b6-459b-83c9-7269ea7fbdef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 30/4/26 23:13, Richard Henderson wrote:
> On 4/30/26 15:55, Philippe Mathieu-Daudé wrote:
>> On 30/4/26 02:04, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   fpu/softfloat.c                | 10 +++++-----
>>>   fpu/softfloat-parts.c.inc      |  6 +++---
>>>   fpu/softfloat-specialize.c.inc | 20 ++++++++++++++------
>>>   3 files changed, 22 insertions(+), 14 deletions(-)
>>
>>
>>> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat- 
>>> specialize.c.inc
>>> index dd65432813..2723bf5e61 100644
>>> --- a/fpu/softfloat-specialize.c.inc
>>> +++ b/fpu/softfloat-specialize.c.inc
>>> @@ -179,16 +179,24 @@ static uint64_t parts_silence_nan_frac(uint64_t 
>>> frac, float_status *status)
>>>       return frac;
>>>   }
>>> -static void parts64_silence_nan(FloatParts64 *p, float_status *status)
>>> +static FloatParts64 parts64_silence_nan(const FloatParts64 *p,
>>> +                                        float_status *status)
>>>   {
>>> -    p->frac = parts_silence_nan_frac(p->frac, status);
>>> -    p->cls = float_class_qnan;
>>> +    FloatParts64 r = *p;
>>> +
>>> +    r.frac = parts_silence_nan_frac(r.frac, status);
>>> +    r.cls = float_class_qnan;
>>> +    return r;
>>>   }
>>> -static void parts128_silence_nan(FloatParts128 *p, float_status 
>>> *status)
>>> +static FloatParts128 parts128_silence_nan(const FloatParts128 *p,
>>> +                                          float_status *status)
>>>   {
>>> -    p->frac_hi = parts_silence_nan_frac(p->frac_hi, status);
>>> -    p->cls = float_class_qnan;
>>> +    FloatParts128 r = *p;
>>> +
>>> +    r.frac_hi = parts_silence_nan_frac(r.frac_hi, status);
>>> +    r.cls = float_class_qnan;
>>> +    return r;
>>>   }
>>
>> Why not use compound literal like the rest?
>>
>>      static FloatParts64 parts64_silence_nan(const FloatParts64 *p,
>>                                              float_status *status)
>>      {
>>          return (FloatParts64) {
>>              .frac = parts_silence_nan_frac(p->frac, status),
>>              .cls = float_class_qnan,
>>          };
>>      }
>>
>>      static FloatParts128 parts128_silence_nan(const FloatParts128 *p,
>>                                                float_status *status)
>>      {
>>          return (FloatParts128) {
>>              .frac_hi = parts_silence_nan_frac(p->frac_hi, status),
>>              .cls = float_class_qnan,
>>          };
>>      }
>>
> 
> We also need to copy the exponent, sign, and frac_lo for FloatParts128.  
> I thought it was easier to emulate the existing path and simply modify 
> the two fields.

Ah OK. We are good then!

