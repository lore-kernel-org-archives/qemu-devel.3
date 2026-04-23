Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3178F589D2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFu44-0003kB-EY; Thu, 23 Apr 2026 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFu3x-0003jh-Br
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:25:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFu3v-0007vk-Rj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:25:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso29054435e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776950745; x=1777555545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GBQJ37pdj0iO3MirJTdDqgAoD6wwc1j7rJJtObYB5gk=;
 b=kwScoyv+OrZCOE/5HD3V/CS+3YGuFD0AtLPie+PVwGFfqTipGCZVHnN2pa3iIRTq+e
 pY9frlXxPuMh15nY5OBCXm1aWrkAR40dhjsQfBHE22rL7B52TEABPYs1acWx1NgXyKkg
 B6PY2IpmXBUMLf266yCR9FXcZN0j+YHND9J3bCaHnyxshhIWeLvgq5FUboc42xjzkXf8
 CLgnHYA20EdHbt1x9TdfeYUE0WPURN0lQVBdA71t5m37HYNgGW80jiOJusQwTZmeb6h0
 5D6nVMWX5CBztss9VgAodM1qMY7sKmMTJ8pnR8Weg1ctku6Qwvh2E+UQ++XyWVpPsyjo
 T4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776950745; x=1777555545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBQJ37pdj0iO3MirJTdDqgAoD6wwc1j7rJJtObYB5gk=;
 b=UoMQXQnCMs5IBFwYttUgiBirQ2tnL423WO8Z0a7EC4ElgwA9LGkjyVoOH7BxkPm8id
 alzFTMx2Vbzj3RaDZSNNpBPNvm8F1yoemUPamU6oLkJhbn4N41d6FE8n15xkfd6Koyxd
 ww9sqtVcWTP+aiSQpuvdzbLYQK4HRfrQ7N8/dNr6Kfc/Z44q/eT1FlPJpNyAcwsaneze
 w783BCNtSKwWCF7R1saVhW7ocTi0m7F4kq/EeChBH91HjqxrLWvmDSl084YMDuEGo1/X
 9jg2FZHALBorPnUBeIV1azIgs0cmyYlHl4rJ+xG+0wvRj/tT2UtZz/iagQdhiSxqhlNw
 oswg==
X-Gm-Message-State: AOJu0Yz/vqUGcCANX1Ge+OguSKO/YB64St6Y0Fh+B9LcBx4Mu8RRBOxF
 9q+B2LpAET1E9YmbaXwxLrwVWyja26Y2sFUz4vKgq/1hMxjlCdy5WGzYa9/qEh+ovc73IeZ5MNh
 Pl32DSJA=
X-Gm-Gg: AeBDieucZ/VFMJw48w/YBkNT+ZacLT8I/WRAiyYi3K2pPN1y9gVffLnZ8sUh0n5hn8q
 D/4t+h9Imgq/3jKVqBtqB5lCUQmBeCLDNNmVMOO3j8XVbjl7IG8TGILmarIoRabnOrCoaEFZqpT
 5X9z0dxjmFIwSnAF+1ejvBPDenzixZ8k9u3pllQ/aAr345xkgdAmxwCHL6yL5kShh/IRzwF0ln9
 GUvnWTJiOGI8D1CMrO62tEHIBU9jUuNvw2Sn6rPUxCIBlxvbDB/Kduuz0E7ImZ3vGJANt0TuWbU
 53gVdN0DO2rzcA+lDvOTXoXLEr30cyGtLMPqKruEz0+sC0+RZxa705CzFU8bigHPsjk40Xj9aNR
 0VZQoQbULT7Q3d3bWcEQLyK5FxjTqvBn9kGptbNHLHuRX6ZEjAyJGmyKIKJWWZdYfVgFivo/bLK
 zRm6FBkQ/VnN6285UAFEWLeF54D+zes8BltD63ODgXoeCdf+RATkoRj3Rq8i1dAvmXHnYn81eiZ
 tdy
X-Received: by 2002:a05:600c:8284:b0:489:1f3e:5f69 with SMTP id
 5b1f17b1804b1-4891f3e629bmr236254325e9.18.1776950744995; 
 Thu, 23 Apr 2026 06:25:44 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm231037915e9.12.2026.04.23.06.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 06:25:43 -0700 (PDT)
Message-ID: <1f824470-4144-4212-a34c-2cc70684b411@linaro.org>
Date: Thu, 23 Apr 2026 15:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/59] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
 <20260423100229.2941820-11-peter.maydell@linaro.org>
 <51498985-6742-4d9d-b924-07ce873cd531@linaro.org>
 <CAFEAcA90md66h-73qDBX=jX4jvD9j4z5F1puv4awho3gCUQ9nQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA90md66h-73qDBX=jX4jvD9j4z5F1puv4awho3gCUQ9nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 23/4/26 14:52, Peter Maydell wrote:
> On Thu, 23 Apr 2026 at 13:35, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 23/4/26 12:01, Peter Maydell wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> This new header defines a new type for target virtual address,
>>> independent from TCGv and is parameterized by a new define
>>> TCG_ADDRESS_BITS (name was suggested by Paolo instead of
>>> TARGET_ADDRESS_BITS).
>>>
>>> By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
>>> it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
>>> set TCG_ADDRESS_BITS manually, which is what next commits will do.
> 
>>
>> Missing:
>>
>> -- >8 --
>> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
>> index 36931d1dd57..ea35a02fb40 100644
>> --- a/include/tcg/tcg-op-mem.h
>> +++ b/include/tcg/tcg-op-mem.h
>> @@ -12,6 +12,8 @@
>>    #error TCG_ADDRESS_BITS must be defined
>>    #endif
>>
>> +#include "tcg/tcg-op-common.h"
>> +
>>    #if TCG_ADDRESS_BITS == 32
>>    typedef TCGv_i32 TCGv_va;
>>    #define TCG_TYPE_VA TCG_TYPE_I32
>> ---
>>
>> "tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h"
> 
> Yes, but all two of the places that include tcg-op-mem.h
> include tcg-op-common.h (directly or indirectly) first.
> 
> I agree that it would be nicer for the header to explicitly
> include what it uses, but do we really need to mess around
> re-rolling the pullreq just for this? I would rather not...

Right, there is no build issue as of this commit, no objection
on my side!

