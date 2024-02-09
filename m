Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45148C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMyu-0006r3-KU; Fri, 09 Feb 2024 04:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMys-0006qW-Ei
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:15:34 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMyq-00033x-Ff
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:15:34 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5116b540163so1136375e87.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707470130; x=1708074930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nNLpIx87pB0K/AvDr5H7oRXa+DzGtWVK8bg3cbWp7L8=;
 b=p1Eh/TGT3P7SzuKkwo2oH1gMnp9Lkb/7MXZVPQeJO6WyC6oIH0Mf4gyrsrJXiMXaA1
 M3IpTYM3dYUMYdyxZW4UwfNrC1/OjI122gxLlB09LOnTGXHiH0ogMCmOrERXirKaKdZk
 wbwWQqBhohhAuLccBMv8DvOtWJ0O+FsvtwTbYkJv7hIQ+wVBjsEQ6kt+3wmGBHOiaFSL
 /6+ypN8FywVT3YXMBtrV0jy6iNjtwC53Gm4UvqwRof50wdIoIOqiKUFuKZGxgtj6pLRa
 Z38zEiYYNigxay/r6d6AySW7PaLKW4k363qTWbhy/AOo4VJQZrWnXZRybNdF2EUE/i8W
 CikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707470130; x=1708074930;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nNLpIx87pB0K/AvDr5H7oRXa+DzGtWVK8bg3cbWp7L8=;
 b=cHrQZNqBNeSL7Wd7Nf5s0g/4YE+89Z3PX0FDFPLbELhbyZchOxUajFckmFj6V7JA/D
 2nR1OPM5wUlXQvtktFEC/jp+w+bwNsCEaavglEsWzpdTEprra0uEeuyoAu5CWF/8EVId
 nu8b1HeeaDtD4FhXIdm9htA126sabrCkbZqFbMnvniOu/uETivnSSEzVkDzHx/f1H5hF
 sjKZUEJnnk88u684AGkU1Vv/fTxIJfW5u6zbJflGOvPcGGYtE7qPI1XzLAphRa7eYaqu
 2lch7wJFi9vuDocE2aJZaVENRK5n+lbgkW0LmBeyhkpV4m4hgOF4SCUnVj/nVUK1CBQn
 +vEg==
X-Gm-Message-State: AOJu0YwYfqvFB3ehn+VaWmxI4YIAa9SbEs7TuUta6zX3kNh36zCGxqJZ
 5KYuisl42rv6XHp/FehXbONXjffqdLyzACjb3pq9KMnCxk3eTf0LpEoi7b7pYpc=
X-Google-Smtp-Source: AGHT+IGmwHnnKORxtBUZqjVaNSttBk4br7gqWc28lsfRX1CmgJDYzwmIcjvL/3fDSvZaFePI74vmFw==
X-Received: by 2002:a05:6512:2397:b0:511:60d9:dd47 with SMTP id
 c23-20020a056512239700b0051160d9dd47mr716823lfv.61.1707470130585; 
 Fri, 09 Feb 2024 01:15:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUgEMCkTCxn/LUkJtWe2rvqwnIUtLAHHmxEXbVBQwwqaUr8SqUeL7+/boTTFJ27GxfAQz0z26aKVct2jrt/BRPfzsWRMRaahWiCRm3AtlNQyIk3E69zB4fs8WHML8ffVsv/AeYws3CioYtlvlFXSB+xEuUKT68jVMPO
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 iv12-20020a05600c548c00b004100c0882fdsm1962301wmb.31.2024.02.09.01.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 01:15:30 -0800 (PST)
Message-ID: <9c40cbb8-c652-409f-a718-b6381b96ba89@linaro.org>
Date: Fri, 9 Feb 2024 10:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] mips: allow compiling out CONFIG_MIPS_ITU
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, shentey@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-8-pbonzini@redhat.com>
 <81d117a3-ed1d-4023-a9ce-128729ec2e73@linaro.org>
 <CABgObfaop4uLqpjt8bXaL6=WoAz+M-sLiU0U+F=gtHkZMTo8aw@mail.gmail.com>
 <75ede98a-db0d-4b8c-88ff-df2f46875466@linaro.org>
In-Reply-To: <75ede98a-db0d-4b8c-88ff-df2f46875466@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/2/24 08:22, Philippe Mathieu-Daudé wrote:
> On 8/2/24 09:26, Paolo Bonzini wrote:
>> On Wed, Feb 7, 2024 at 8:12 PM Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>>
>>> Hi Paolo,
>>>
>>> On 7/2/24 12:14, Paolo Bonzini wrote:
>>>> itc_reconfigure() is referenced from TCG, provide a stub if needed.
>>>> This makes it possible to build a QEMU binary that only includes
>>>> boards without a CPS device (only Malta and Boston create one).
>>>>
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>>>    hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
>>>>    hw/mips/meson.build     |  1 +
>>>>    2 files changed, 27 insertions(+)
>>>>    create mode 100644 hw/mips/mips_itu-stub.c
>>>>
>>>> diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
>>>> new file mode 100644
>>>> index 00000000000..4cc82b8461f
>>>> --- /dev/null
>>>> +++ b/hw/mips/mips_itu-stub.c
>>>> @@ -0,0 +1,26 @@
>>>> +/*
>>>> + * Inter-Thread Communication Unit emulation.
>>>> + *
>>>> + * Copyright (c) 2016 Imagination Technologies
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, see 
>>>> <http://www.gnu.org/licenses/>.
>>>
>>> This is your code addition, so "Inter-Thread Communication Unit stubs" /
>>> RH / SPDX GPLv2-or-later.
>>>
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/misc/mips_itu.h"
>>>> +
>>>> +void itc_reconfigure(MIPSITUState *tag)
>>>> +{
>>>> +    abort();
>>>
>>> As Zoltan suggested, g_assert_not_reached(). Indeed this path
>>> can't be reached without ITU, TCG won't emit anything and will
>>> call instead:
>>>
>>>       qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n",
>>>                     register_name, reg, sel);
>>>
>>> I'm reluctant to add stubs, but since it helps you (hoping we
>>> can figure a clean way to split architectural access to hw/ from
>>> tcg/ one day):
>>
>> Not sure how it's reached anyway, because the saar field of
>> DisasContext is never written...

Alternatively:
https://lore.kernel.org/qemu-devel/20240209090513.9401-3-philmd@linaro.org/

> Commit 5fb2dcd179 ("target/mips: Provide R/W access to SAARI
> and SAAR CP0 registers") is an incomplete frontport of
> https://github.com/MIPS/qemu/commit/c9340491cc.
> 
> Commit 043715d1e0 ("target/mips: Update ITU to utilize SAARI
> and SAAR CP0 registers") is an incomplete frontport of
> https://github.com/MIPS/qemu/commit/e03079c699.
> 
> So this feature is working in MIPS fork since 2017, and during
> 2019 mainstream only got part of it merged but never completed.
> 
> 5 years passed.


