Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3A9FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKB3N-0000kc-1s; Tue, 05 May 2026 04:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKB3K-0000kG-V2
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:22:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKB3J-0001eg-E5
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:22:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso2541214f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777969367; x=1778574167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWArJXnjfOZ0xlGMfGo/BBYJ+DAHxE4dKD8cXaJkyjI=;
 b=GfW8Y2BF8ZrfM8BatLPBsZLZLo24v9eP8481FhZjEM+OQOamm3dozuLa7FtOjhmynQ
 aqWnugkcj8IVxB0pc6j1VCRGpAmxFMwjaYGKzM4fCTK6EuWARsLZqhgL2JLcElLh9F+/
 Cc+s008Yxkza28WtVLkvRXL9iylb/HeW3bHTjsUwz43oLF9zI6xE9Odmw8eOaII5FF1G
 1YXBrVe37HSmcz1o3uYpWL5qsPcguHOOZRHDamignjLYr5OK5d+3iFuK28Svb3WzsOIG
 o6ZeV0l0Bd8GX8n2n41BmuekRjfY77zwAnEEDWfxF+6kvkEQSWi6yXx6612ceSoZHV1f
 306w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777969367; x=1778574167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWArJXnjfOZ0xlGMfGo/BBYJ+DAHxE4dKD8cXaJkyjI=;
 b=mjqva1RpAezEN/yZM22CGGPKyhl0Mgu+WDH5xNeBsScPIlE/UKlYJGmn2HtKvP55+p
 LbSU6LPo8iYc4pNHygy/2MXyQZ2Q0VhQMuiwtdIK5QH6avyDDF+URtfKUG0XKYY9lGfa
 97hbBDSkvnDvd94ckAZPxzXHY+NsA/4yyDSxSl4vR+sjXdRpLFxbq1BDE8UbDEszeF7q
 SaRFZ8IN9KpAAEDKM7Mcf9gKHPQIbR6IRnmDqwRkDud84I889uFULXMhfrsVjk36lcof
 Sfer39NAgitooFUQh61LbDkUSkDvGYu2MdF3v8DGiNAqkH0PSHLpidEIroCG3Dxp0QF1
 heeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ95xe02TYoi0vvlZUh3y+BUALK4vHTu7hFeMOJtISvVCqTEuEFsKs0nH8IbpASXsGFbQKCpNS9Fnjc1@nongnu.org
X-Gm-Message-State: AOJu0YxkIyI/lFFZVuxz485GmgFNW/CTVqUL+LNoWwkR3vhSTo/IDcha
 evjMcApO5e4SIogbAoXBrMqI/HIsZxHDWG9koC+Vit63o9wD+rJm6N1kQQrE2uy5jcw=
X-Gm-Gg: AeBDiev55+sq9U/5UQOUurp2f6CK+OzdOrgcfudevcCkv75xrFk8PReB7hg/RS4S5Aa
 5dgckE+6v52coAOVOhG3E9uCVWvCgsS7HiKM6DJVQj++Tz5Cksgpb+gXkKU42/aTRtfVeFZfZiD
 Oei/gpIo8mIFFlU2LDGb7HqR3prWEMKWL7bH/w/AM2ej74Dm+etG0z+SCTI5Plk5//Tm6JtIXQK
 3Lm/Nx/tjTbv59wVM1+RbQMaileMUJJ3Sk9PdTI14Ikh6P4mRIFMv+poAbo25e7uZA5ZfzlViNO
 WDvRMwAsB1mEagQZxf/MpXzD0Z8/pM+9wELwYSziO3kiwnre1X6TOVVfjVTW73sPabEWRZ2d5ol
 ulDSJdmh/b94wZcZZDo5c+WRPhuppRw/YU5ZJt6Ub6N/q9hmDbhvv3qXIpX4jW3SIbxLuGR/yUQ
 lOENhcM3GUyaQkaEL1nWrZ3wzxZA4jF8rdjd71d+T6KUdjGFfDQiTmInCWTZf7EfAvIwZmFAg=
X-Received: by 2002:a05:6000:420c:b0:43d:7bc9:9b2c with SMTP id
 ffacd0b85a97d-44bb406ce60mr22379412f8f.17.1777969367461; 
 Tue, 05 May 2026 01:22:47 -0700 (PDT)
Received: from [10.115.35.66] (95.170.88.92.rev.sfr.net. [92.88.170.95])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2203csm2987963f8f.37.2026.05.05.01.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 01:22:46 -0700 (PDT)
Message-ID: <0a0be8c5-d9ea-4f8d-887d-9950aebdd19f@linaro.org>
Date: Tue, 5 May 2026 10:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/bcm2835_rng: Specify valid memory access sizes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260501162700.4092512-1-peter.maydell@linaro.org>
 <dac8ddbe-37c6-42b0-a6b7-8f42d96d24e6@linaro.org>
 <CAFEAcA_HyLZN_wk2cAotb=Hs6Di+DxPgV8jOAk7pHJ2f+tT4Zw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_HyLZN_wk2cAotb=Hs6Di+DxPgV8jOAk7pHJ2f+tT4Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/26 10:16, Peter Maydell wrote:
> On Mon, 4 May 2026 at 13:29, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 1/5/26 18:27, Peter Maydell wrote:
>>> The BCM2835 RNG has 32-bit registers only; specify this in
>>> the MemoryRegionOps so wrong-sized accesses are rejected rather
>>> than getting to the assertions in the read and write functions.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3394
>>> Fixes: 54a5ba13a9f ("target-arm: Implement BCM2835 hardware RNG")
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/misc/bcm2835_rng.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
>>> index e4d2c224c8..bd4acade5b 100644
>>> --- a/hw/misc/bcm2835_rng.c
>>> +++ b/hw/misc/bcm2835_rng.c
>>> @@ -93,6 +93,8 @@ static const MemoryRegionOps bcm2835_rng_ops = {
>>>        .read = bcm2835_rng_read,
>>>        .write = bcm2835_rng_write,
>>>        .endianness = DEVICE_NATIVE_ENDIAN,
>>> +    .valid.min_access_size = 4,
>>> +    .valid.max_access_size = 4,
>>
>> .impl is clearly 4 (why not set it? I tend to think the default
>> values -- where unset -- come from adapting pre-MemoryRegionOps models,
>> and today better be explicit and avoid implicit defaults here).
>>
>> What is the rationale for max_access_size=4, that the ARM core is
>> a 32-bit CPU? I guess remember these peripherals are on an AXI bus
>> accessible by the videocore as 64-bit accesses. But QEMU doesn't
>> model that, and other peripherals are also limited to 32-bit max.
>> So good enough for now I suppose.
> 
> The rationale is that the registers are all 32 bit, and we're
> already asserting that size == 4, so we know there's no code
> out there in the wild that's trying to do accesses at different
> sizes.

My worry is about someone extending the model, allowing different
access sizes.

> 
> Adding
> 
>   +    .impl.min_access_size = 4,
>   +    .impl.max_access_size = 4,
> 
> is probably a good idea here, I agree.

Thanks,

Phil.


