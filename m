Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06142C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 17:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reI9d-0005jY-Vc; Sun, 25 Feb 2024 12:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI9b-0005id-Mo
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:19:07 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI9Z-0004B4-Op
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:19:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d066f8239so1687753f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 09:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708881544; x=1709486344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eBjHDPpbo2Skfn069Sezk8eP0YQf1maW3U1BptZ4kZA=;
 b=VJfA/gQspJfp/QIeJQ06zPb9HAgbeLnY2R/Oy0fDyFKrmHpBm4PCrgeJ8237c4nLwM
 /HxKlL1d7PLTKUJiMh1+xwCx7IZ46QiVtg3E0/F3TH4DB8SAcZ+zQ+41KIUiwAbyPWEQ
 oeKNveMoLjvXioPIrd9w088Of+8Jf07IhMmyXsHdLD0i9Nfhtvhn8N1ehsUnqYEDr4OZ
 Cs8WmxjvwJehtRRZfzDUabxZ2xqcG03jvCg39NR4c5HOvTgJ0xH8dC8iSOGQGFziqk9z
 ROnPlg3OouojolC0s9ZRH4t3Ed5JOADs+Vc+ElhtNxSNhqTQeX87hf5xhewKLgnM4spr
 XtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708881544; x=1709486344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eBjHDPpbo2Skfn069Sezk8eP0YQf1maW3U1BptZ4kZA=;
 b=V1ZEtVAJiNxEuZymDyDgPWqLrmV01JeRpRYjTXbD5S08tYDMLYflynCJL/b39tz+yu
 iSYa+SOZ3bjgYizj1QWPjIa8wa9RHHqAGyR/cSghY6ZXg4Qro0UO1cIqqt2BQG5W1evJ
 G0ZujgXyYY+NuK5JgDxAn5nyiq4BKym3MyAmLUHeMe1Gph+pCm4iID3yD9F8LEw8u/+b
 dZvl05+A57rQ1gUkEYH5F+jmUqWshfvJoUv1ZqnHpK5H2wvVLeOKycqGbJ5dwyGOokNQ
 VtGy3gDt7fr+BRfeR5l7OA0WnJmInufwP/KffZifiFrLhWLJRlJuICJSCL+DqhkI4Hmx
 vAyg==
X-Gm-Message-State: AOJu0Ywb/6WxlLDuw9KiKKl0q57ygBXAoRUGrRpIc+Fs5scgHABR9Lkk
 PAUEoNMLSyu8B9EBzlo7mNyWmz3QVJeyM3gf17DMZzGxSWB9dcNxlq9b7+yJgZ8=
X-Google-Smtp-Source: AGHT+IEplBDtxVdn6mdS2GOIJ8jg5sDVBBLAX9XyQouPHvi/66aNBxmwTQqVASBQBuS092i8DfbQww==
X-Received: by 2002:a5d:54c1:0:b0:33d:7385:d929 with SMTP id
 x1-20020a5d54c1000000b0033d7385d929mr2795047wrv.0.1708881543650; 
 Sun, 25 Feb 2024 09:19:03 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a5d5702000000b0033ce5b3390esm5592256wrv.38.2024.02.25.09.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 09:19:03 -0800 (PST)
Message-ID: <6219ba73-b433-44d0-8ed6-f710559af2d0@linaro.org>
Date: Sun, 25 Feb 2024 18:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: Remove last two uses of ide/internal.h outside of
 hw/ide
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow
 <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240223142633.933694E6004@zero.eik.bme.hu>
 <bcffda64-6805-4322-bfc2-888d246cc554@linaro.org>
 <3e576d33-1973-3f44-afd1-9224609f89a6@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3e576d33-1973-3f44-afd1-9224609f89a6@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 25/2/24 18:08, BALATON Zoltan wrote:
> On Sun, 25 Feb 2024, Philippe Mathieu-Daudé wrote:
>> On 23/2/24 15:26, BALATON Zoltan wrote:
>>> Remove last two includes of hw/ide/intarnal.h outside of hw/ide and
>>> replace them with newly added public header to allow moving internal.h
>>> into hw/ide to really stop exposing it.
>>>
>>> Fixes: a11f439a0e (hw/ide: Stop exposing internal.h to non-IDE files)
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/arm/sbsa-ref.c                 | 2 +-
>>>   {include/hw => hw}/ide/internal.h | 0
>>>   include/hw/misc/macio/macio.h     | 2 +-
>>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>>   rename {include/hw => hw}/ide/internal.h (100%)
>>>
>>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>>> index 5d3a574664..f027622a75 100644
>>> --- a/hw/arm/sbsa-ref.c
>>> +++ b/hw/arm/sbsa-ref.c
>>> @@ -36,7 +36,7 @@
>>>   #include "hw/arm/smmuv3.h"
>>>   #include "hw/block/flash.h"
>>>   #include "hw/boards.h"
>>> -#include "hw/ide/internal.h"
>>> +#include "hw/ide/ide-bus.h"
>>>   #include "hw/ide/ahci_internal.h"
>>
>> Unrelated, but what about this one ^?
> 
> The ahci_internal.h is in hw/ide not in include/hw/ide so how does that 
> even work? I don't care about AHCI so not interested to anything about 
> that personally.

No worries, done:
https://lore.kernel.org/qemu-devel/20240225171637.4709-2-philmd@linaro.org/

> 
> Regards,
> BALATON Zoltan


