Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FA5C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 07:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYLDs-0003Rd-OC; Fri, 09 Feb 2024 02:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYLDp-0003Qo-Ug
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 02:22:55 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYLDn-0003RW-FP
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 02:22:53 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5600d950442so804155a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 23:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707463370; x=1708068170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SW8pE2JaCK2X1qHeG7h578dg+YGa3qZmdJXtVuaDQtk=;
 b=PIrvSuNzo8bABxjsmbn8u1ULpevu0WY/Rkkx0iHT9jskCEbER/eYDFqzBTmy4yRn47
 dK/87C/ETOrwECvyr8cA5w29LbQkTnQjKsmPhCL1HoTekDBSeEZJFg+3JlouhzJHMJ3f
 Uddp0Qru4EpyEYTDbuLryvJ8r740q30d0PjXUcf0flTpA6g/hLBGm0Cp32K2zGCIVCm0
 XUpwn9PbhROocQnSFPSPBpS/TVgY3L2fY4aS18KUZ6VawUdevRMRNitsPVpDJuXfyOET
 PIPm8YRzHBJMG+3AywW6UBicaz4aZ9sJXOcP2gXpYBYMwaiwwNiDpSUcM3eJq4oAmOOk
 NfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707463370; x=1708068170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SW8pE2JaCK2X1qHeG7h578dg+YGa3qZmdJXtVuaDQtk=;
 b=lNMrU31rKTiJ7QHdbtxdIBmUpODsqADsv/mp+2kzTH8MXvf6KAlzeY09Z36b+d7vhg
 1MCAWSZ3WpyjHr6jA5UiSfzoZcx1DJQD/D2W4R+ab/Ho2tgfr1wEFnLQNdCGVAeXCo3x
 KCnfG8gz2o6VfiyA9FYatym7dJHWkm1ltgDUa0mHg8d0Y1ewM7rd48rz3Q8KJP0Hnkho
 MF0ajrj15+1wpVcPdlx7kben4gy5QKpSmKp3s8O+4eE3Xag3RlNez084XEPNALhzlq7G
 x/DDTyqKXjb0xwFc7O3X9luhJjJMRZHsKX5TZEaxoaLvGBdkJuARo7HnAt85Z1zIM/7Q
 q4Ow==
X-Gm-Message-State: AOJu0YwN5V4uC2tSnB6uETsFunMKtTcgy0uEyedtCf/MsgRLJCcnIKUc
 bNIIedRnTdbnLqrLeze5PoVQo+eobGbkJl+xi3mrBaYWEa4RrGF8gZMer1LrroA=
X-Google-Smtp-Source: AGHT+IHKf4c30TZPrNXaazKL0Ig4LkxyabPg9VTNRFBomSbzF5HH19+IjuN1vmXhbqbjLMgJtoWRDQ==
X-Received: by 2002:aa7:c994:0:b0:561:2094:a7c5 with SMTP id
 c20-20020aa7c994000000b005612094a7c5mr691998edt.39.1707463369790; 
 Thu, 08 Feb 2024 23:22:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUtlhAs8WB7HQUGkRlObdUESZOZqu+rCktI74FfUXXGfB9pukVSVkKTaCKzscCxt495d73iDy1waMmx642J4tu1VD70VTkisWUCBUSNFN8tu8u4FR3gj6tB2Bns6A+Da8CEIO65ZBhBMzt8Z/D3rMF90rLHkO21ngQC
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 i8-20020aa7dd08000000b0056010210438sm515345edv.32.2024.02.08.23.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 23:22:49 -0800 (PST)
Message-ID: <75ede98a-db0d-4b8c-88ff-df2f46875466@linaro.org>
Date: Fri, 9 Feb 2024 08:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] mips: allow compiling out CONFIG_MIPS_ITU
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, shentey@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-8-pbonzini@redhat.com>
 <81d117a3-ed1d-4023-a9ce-128729ec2e73@linaro.org>
 <CABgObfaop4uLqpjt8bXaL6=WoAz+M-sLiU0U+F=gtHkZMTo8aw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfaop4uLqpjt8bXaL6=WoAz+M-sLiU0U+F=gtHkZMTo8aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 8/2/24 09:26, Paolo Bonzini wrote:
> On Wed, Feb 7, 2024 at 8:12 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Paolo,
>>
>> On 7/2/24 12:14, Paolo Bonzini wrote:
>>> itc_reconfigure() is referenced from TCG, provide a stub if needed.
>>> This makes it possible to build a QEMU binary that only includes
>>> boards without a CPS device (only Malta and Boston create one).
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
>>>    hw/mips/meson.build     |  1 +
>>>    2 files changed, 27 insertions(+)
>>>    create mode 100644 hw/mips/mips_itu-stub.c
>>>
>>> diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
>>> new file mode 100644
>>> index 00000000000..4cc82b8461f
>>> --- /dev/null
>>> +++ b/hw/mips/mips_itu-stub.c
>>> @@ -0,0 +1,26 @@
>>> +/*
>>> + * Inter-Thread Communication Unit emulation.
>>> + *
>>> + * Copyright (c) 2016 Imagination Technologies
>>> + *
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Lesser General Public
>>> + * License as published by the Free Software Foundation; either
>>> + * version 2.1 of the License, or (at your option) any later version.
>>> + *
>>> + * This library is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * Lesser General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU Lesser General Public
>>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>>
>> This is your code addition, so "Inter-Thread Communication Unit stubs" /
>> RH / SPDX GPLv2-or-later.
>>
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/misc/mips_itu.h"
>>> +
>>> +void itc_reconfigure(MIPSITUState *tag)
>>> +{
>>> +    abort();
>>
>> As Zoltan suggested, g_assert_not_reached(). Indeed this path
>> can't be reached without ITU, TCG won't emit anything and will
>> call instead:
>>
>>       qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n",
>>                     register_name, reg, sel);
>>
>> I'm reluctant to add stubs, but since it helps you (hoping we
>> can figure a clean way to split architectural access to hw/ from
>> tcg/ one day):
> 
> Not sure how it's reached anyway, because the saar field of
> DisasContext is never written...

Commit 5fb2dcd179 ("target/mips: Provide R/W access to SAARI
and SAAR CP0 registers") is an incomplete frontport of
https://github.com/MIPS/qemu/commit/c9340491cc.

Commit 043715d1e0 ("target/mips: Update ITU to utilize SAARI
and SAAR CP0 registers") is an incomplete frontport of
https://github.com/MIPS/qemu/commit/e03079c699.

So this feature is working in MIPS fork since 2017, and during
2019 mainstream only got part of it merged but never completed.

5 years passed.

