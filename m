Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1AAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxr8C-0002QZ-IK; Fri, 19 Apr 2024 12:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxr85-0002QL-3u
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:30:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxr83-0006EW-D4
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:30:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-419c8c314d4so3100515e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713544222; x=1714149022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nCV+UzM0xbOmBxccOrPxUm9ajzGExXGUgTS+1dvHMnE=;
 b=P3SGxPKP/ZEJnqqXj/rXKePuagbGcLSL/5DN3I20aVVmN7DNydP1XDWLrw+uYB9ghD
 hDPuQpJTul4cZsdr0fShVE+lhoG4QSKXcaemz3kpThNcQh4BbT/bDdOwu5Y8bgoX7E2D
 Z8yqQLHwhf8y73nJ7cDGkYs2GMqwo09wyVXpLuLD1+EP8zPNvpC6Z2ijTnByfQebLQIk
 fq6j4m8EqITi+oAQMEIanzDCYHHZJD2ZlTWjUyrxcZeD+1Jc/Z73OaEKpZLA/UoQ3ESf
 qMWgKF0JXrHcCpsN9gyWrOd0OshhN49TK+syFYwXOUAJSN+1VF1M1TtGQJFuQ5bjeS58
 /FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544222; x=1714149022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nCV+UzM0xbOmBxccOrPxUm9ajzGExXGUgTS+1dvHMnE=;
 b=GpF7enoB+QpYSE9n6OPjmeDJrr9AL/4ObfwngHEBU61eC1Y8alvj+hQ9Inaa38impm
 ORu0XEoz+Q5wHdW1LHypx1O+fLEDIYJo9yg9JHl4vADqIjdD4DA/q7T7hHvhwcO1wGrP
 2GvPRyHFizK/DbXvsfyGEs4Gbyot2EtyGJlK6XReh5D5Z6XFN8zTd01KHRJU5oqz1X3T
 +8FaOZso2TP+LJpiY01FAGyeoWhe+KXnkP3y26oaz6MUyHBR5J4buU8DaZBC1fEno6Xo
 S0IN9/OTM+2ESdDACLzPGMtro+EHS97wct0ygYnC5sreNytDGBTwmX/O8C2Jm+vzh0Wu
 nwXA==
X-Gm-Message-State: AOJu0YzlSG+TZ72wvzICUq64zoXHdgS3Z59CK+kqjyq5tdsTljwDws0q
 CT+99l7w6xu8QWbzLBYORdmsYzIhPYP4sYObe9phi2tDFELqnuogeJT3Zmxh/KYa1aKMMfc+b4b
 5VY8=
X-Google-Smtp-Source: AGHT+IGfQMjgDPWb6USlfdMxeshsjilgcRJ+3c/V2V98eNLEHU1S0Hg5S8SIDmdkGNRpYZJawk2Vbg==
X-Received: by 2002:a5d:4a81:0:b0:343:8d1b:b12d with SMTP id
 o1-20020a5d4a81000000b003438d1bb12dmr1510021wrq.46.1713544221590; 
 Fri, 19 Apr 2024 09:30:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.199.54])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a5d5481000000b003437a76565asm4816235wrv.25.2024.04.19.09.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:30:21 -0700 (PDT)
Message-ID: <acd540fc-8198-4b02-bd35-24c53891f667@linaro.org>
Date: Fri, 19 Apr 2024 18:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/clock: always iterate through childs in
 clock_propagate_period
To: Raphael Poggi <raphael.poggi@lynxleap.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, luc@lmichel.fr, damien.hedde@dahe.fr
References: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
 <5b8ce05b-62c6-4362-aa16-a9e845eb4df7@linaro.org>
 <CACqcpZCubN0Bnmht03TRCWdtYUd4aOpitcx31J+NiMEe2vWhSA@mail.gmail.com>
 <CAFEAcA9wcaptrL5LHWah0MeKP1CV-WbfwsS65kibLwJ4TpvjTg@mail.gmail.com>
 <CACqcpZDv8gjKhMygmAWkyfYqPH-NVz4RpPb8Q0tBTege_Gro4Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CACqcpZDv8gjKhMygmAWkyfYqPH-NVz4RpPb8Q0tBTege_Gro4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 19/4/24 18:08, Raphael Poggi wrote:
> Hi Peter,
> 
> Le ven. 19 avr. 2024 à 16:08, Peter Maydell <peter.maydell@linaro.org> a écrit :
>>
>> On Thu, 18 Apr 2024 at 21:39, Raphael Poggi
>> <raphael.poggi@lynxleap.co.uk> wrote:
>>>
>>> Hi Philippe,
>>>
>>> Le jeu. 18 avr. 2024 à 20:43, Philippe Mathieu-Daudé
>>> <philmd@linaro.org> a écrit :
>>>>
>>>> Hi Raphael,
>>>>
>>>> On 18/4/24 21:16, Raphael Poggi wrote:
>>>>> When dealing with few clocks depending with each others, sometimes
>>>>> we might only want to update the multiplier/diviser on a specific clock
>>>>> (cf clockB in drawing below) and call "clock_propagate(clockA)" to
>>>>> update the childs period according to the potential new multiplier/diviser values.
>>>>>
>>>>> +--------+     +--------+      +--------+
>>>>> | clockA | --> | clockB |  --> | clockC |
>>>>> +--------+     +--------+      +--------+
>>>>>
>>>>> The actual code would not allow that because, since we cannot call
>>>>> "clock_propagate" directly on a child, it would exit on the
>>>>> first child has the period has not changed for clockB, only clockC is
>>>>
>>>> Typo "as the period has not changed"?
>>>
>>> That's a typo indeed, thanks!
>>>
>>>>
>>>> Why can't you call clock_propagate() on a child?
>>>
>>> There is an assert "assert(clk->source == NULL);" in clock_propagate().
>>> If I am not wrong, clk->source is set when the clock has a parent.
>>
>> I think that assertion is probably there because we didn't
>> originally have the idea of a clock having a multiplier/divider
>> setting. So the idea was that calling clock_propagate() on a
>> clock with a parent would always be wrong, because the only
>> reason for its period to change would be if the parent had
>> changed, and if the parent changes then clock_propagate()
>> should be called on the parent.
>>
>> We added mul/div later, and we (I) didn't think through all
>> the consequences. If you change the mul/div settings on
>> clockB in this example then you need to call clock_propagate()
>> on it, so we should remove that assert(). Then when you change
>> the mul/div on clockB you can directly clock_propagate(clockB),
>> and I don't think you need this patch at that point.
> 
> Alright, that makes sense, is that OK if I send a patch removing the assert ?

Sure, that is welcomed :)

Regards,

Phil.

