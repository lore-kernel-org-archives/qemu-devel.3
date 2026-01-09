Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65158D26D9E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJyX-0005EW-EU; Fri, 09 Jan 2026 16:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veJxz-00057r-Td
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:24:20 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veJxx-0000dM-Ls
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:24:19 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so640285b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767993856; x=1768598656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ch3XQMXvtmaJOSkZAI0oWyBW1NzCvQKqRz7ePVprClU=;
 b=Injzs66T/mAT8RRG/Cv/si+qH7FJpCDSq5GfxJ0/nAzmhlaxysDP1HcPkoLptBtmux
 q1i6s2kn/D5/nzaNZwYOCwRCjuHtwKaosz04zfPIfGRxqVyYv0joOQ7hgpZVCDhdfhzo
 yEtIiLDXjW5u6hLlxDC15Q45WsvmxFYpciK8UcE63YakXPgjgy3+Wb854iP5KjwMJZ7l
 mqCdjtCn9njHZKyQhk2xbSfW1EuRnJXlXDDw35D3KQmAdAtmqDQ8wP+mQPVBq6ZNuU3V
 EjKmbYJL8EPdDxmrFucESNKeUcCBRWzBqrL18atPKmgsdKfg8urr8y0Xabo8Lh9gKwR6
 fccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767993856; x=1768598656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ch3XQMXvtmaJOSkZAI0oWyBW1NzCvQKqRz7ePVprClU=;
 b=pw62y70emq22X15eDp4xfzThh2kmUBiUGz80tOnYrLZ1wvw77fays+MF3leh3qWn1I
 wE9hKtYK4sfe+Bddt6SEizR0UdVt1/8PsS2+Wa6Z0nMamksKMNsuySVQW4Gs5PlUSELh
 hTC8Ha3axzOpCQdPxcAKgNTBROXS+IOuwjKc72FRrlCDWLh+iv6eeGLF02zk5vU5AVHh
 HokrUoIjU2lxJl0AnoJCwx7DMKttDyN6Ldg76HHkDUAvjS0F88ejTazR3ye9YCpA79pR
 UbfntXKTGezKh3AycmYK+eqyVMbdxS0rLLlcgvxTLRFx6GpDEoXgn3/k16q5jw1gOVIO
 NpPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG6c4MvDgF0LaCUN3F6l+29o7qI9svHDvbNBp0q96mwG7/xWxboMcopV2kEuK2EDHvfBWXgw6Hn92x@nongnu.org
X-Gm-Message-State: AOJu0Yw4IC4eatrLjwxnZwMBONShOjm0/NnPP7e758DW3pNwfyn+KnoJ
 mzCytQX6VU0WAjQG73rqxTEP3x7FqKC24PWLEU7/7RbJxwvV2xPzrn3lrjcWQzxOGyc=
X-Gm-Gg: AY/fxX4lTTHvr5mkcMIMM/lmTng9R9+2DiODq4P11Ge9nIR/XF2As8S3JTBcAsrNbEc
 Idg/pDnYKhQ62uzndug18NabzaYlOY9FIPrR9mVj1HbzS++/ALdyAGFfVqIuf6csrdggiKPsGzE
 2oM4LCgFRQ1ZgxevjXW7zK0H8KGaePCntEirB4NczIOQdh1ZFWNf7We21uChpuOCbrcLs68dBDc
 U02vBfZzoJM5kdQmlLjzb5Bwg+APJkqmsWKohRbH5Njd95/yjNYebLpRGacpIx7kS7xb+OWu/pK
 WC/+l84QAtAwJdDKmYWKr8qmyBn+wFc22o9lwzaEiR2sUaLaAI+TjcyQrD2bldSII7yDCfdgjEO
 vsxtSSD4O1OpVVW9SrPsQeI+LMqRzMgst/QMRv8m6xuFz1AOzaBIQ6wCuVHmjWkvCpWv0oims7d
 xjmgsLX35LBPROIpWA/JKNsGPtkG8Pwnfv5blRaTn9FNJkRbWFFQQZnJi+
X-Google-Smtp-Source: AGHT+IE6b5SFxM7hPauceu2OHiBmr2I/qURuZEELlf8IxRm9xcIc81mrXGcJzQqx2gg+99oOu8bn/w==
X-Received: by 2002:a05:6a00:ad06:b0:81a:857b:f944 with SMTP id
 d2e1a72fcca58-81b7dc5b474mr10231277b3a.26.1767993855990; 
 Fri, 09 Jan 2026 13:24:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81efe4a95c7sm1014353b3a.37.2026.01.09.13.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:24:15 -0800 (PST)
Message-ID: <b78cec6f-7cab-4325-b7f5-722f0fcbf2b3@linaro.org>
Date: Fri, 9 Jan 2026 13:24:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] include/tcg/tcg-op.h: eradicate
 TARGET_INSN_START_EXTRA_WORDS
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-14-pierrick.bouvier@linaro.org>
 <06933b3a-dc90-4332-ba26-66faf2831229@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <06933b3a-dc90-4332-ba26-66faf2831229@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 1/9/26 12:00 AM, Philippe Mathieu-Daudé wrote:
> On 9/1/26 06:31, Pierrick Bouvier wrote:
>> We simply define the 3 variants and call the correct one per arch.
>> Since all arch have a single call site (in translate.c), this is as
>> good documentation as having a single define.
> 
> Just wondering, if we define a per-target @inst_start_words
> constant in TCGCPUOps instead of the INSN_START_WORDS definition,
> could we 1/ ensure we call the correct tcg_gen_insn_start()
> in cpu_restore_state_from_tb() and 2/ "optimize" the loop in
> cpu_unwind_data_from_tb()? Surely not worth it =)
>

I'm not sure. The point of INSN_START_WORDS was to have a constant 
definition, not target specific.
Now, could we poke the constant at runtime and optimize. Maybe, but I'm 
not sure there is a real performance benefit, and surely more complexity 
since we would need to reflect this through all targets.

As said in commit description, it's not really possible to call the 
wrong tcg_gen_insn_start() because there is a single call site anyway. 
Making it a constant or a function call with a specific name has the 
same benefit, so I would stick to the simpler (latter) solution.

>> The notable exception is target/arm, which has two different translate
>> files for 32/64 bits. Since it's the only one, we accept to have two
>> call sites for this.
>>
>> This is much simpler and safer than trying to define a common functions
>> with variadic or unused parameters. The only risk is calling two
>> different variants for a single arch, but as mentioned in first
>> paragraph, there is no real reason for this to happen.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/tcg/tcg-op.h             | 16 ++++++----------
>>    target/alpha/cpu-param.h         |  2 --
>>    target/arm/cpu-param.h           |  7 -------
>>    target/avr/cpu-param.h           |  2 --
>>    target/hexagon/cpu-param.h       |  2 --
>>    target/hppa/cpu-param.h          |  2 --
>>    target/i386/cpu-param.h          |  2 --
>>    target/loongarch/cpu-param.h     |  2 --
>>    target/m68k/cpu-param.h          |  2 --
>>    target/microblaze/cpu-param.h    |  2 --
>>    target/mips/cpu-param.h          |  2 --
>>    target/openrisc/cpu-param.h      |  2 --
>>    target/ppc/cpu-param.h           |  2 --
>>    target/riscv/cpu-param.h         |  7 -------
>>    target/rx/cpu-param.h            |  2 --
>>    target/s390x/cpu-param.h         |  2 --
>>    target/sh4/cpu-param.h           |  2 --
>>    target/sparc/cpu-param.h         |  2 --
>>    target/tricore/cpu-param.h       |  2 --
>>    target/xtensa/cpu-param.h        |  2 --
>>    target/alpha/translate.c         |  4 ++--
>>    target/arm/tcg/translate-a64.c   |  2 +-
>>    target/arm/tcg/translate.c       |  2 +-
>>    target/avr/translate.c           |  2 +-
>>    target/hexagon/translate.c       |  2 +-
>>    target/hppa/translate.c          |  2 +-
>>    target/i386/tcg/translate.c      |  2 +-
>>    target/loongarch/tcg/translate.c |  2 +-
>>    target/m68k/translate.c          |  2 +-
>>    target/microblaze/translate.c    |  2 +-
>>    target/mips/tcg/translate.c      |  4 ++--
>>    target/openrisc/translate.c      |  4 ++--
>>    target/ppc/translate.c           |  2 +-
>>    target/riscv/translate.c         |  2 +-
>>    target/rx/translate.c            |  2 +-
>>    target/s390x/tcg/translate.c     |  2 +-
>>    target/sh4/translate.c           |  4 ++--
>>    target/sparc/translate.c         |  2 +-
>>    target/tricore/translate.c       |  2 +-
>>    target/xtensa/translate.c        |  2 +-
>>    40 files changed, 30 insertions(+), 82 deletions(-)
> 


