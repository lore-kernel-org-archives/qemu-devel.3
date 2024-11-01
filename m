Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A916E6F077
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6w0j-0001Vt-JK; Fri, 01 Nov 2024 14:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6w0g-0001Un-Iq
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:04:34 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6w0d-0003Zz-UP
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:04:34 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso1798108b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730484269; x=1731089069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oIzATL/9JsqxhMX4vdPwlp1qefhu/D9fW96WkpR4xnI=;
 b=jcyptIKQe6wlkot7Vnbj3rGbwSMWgdA2hm3OmjEy8p3jk0j685f0HMMaoexAz4ntMF
 0Qfq+zB1PyoGvmYbKCfnCrYiO/NWkr66JqZfST1U5U2k4NO7xI9CinFyGJJ1WLFm1oTF
 WLE4rR9LdhUqyHzb99cVt1v8Ck7lY+DVL3IPYHeOt16+sFYFdRSdtmKztcY3n74fDe73
 /hXKHJYwxjaeb81oDABYY9z9TJu9JGIdu+rrK2DZIje5BiqAytMU95AspW/5tmnNFy79
 puoN4MwvsC0fG5LaJ8ItA2e+XryxtFHRhcQA9KX9l3TihB1l458KacrlI6ECRSZCZhY3
 hSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730484269; x=1731089069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oIzATL/9JsqxhMX4vdPwlp1qefhu/D9fW96WkpR4xnI=;
 b=XnaG/1VwF8hyFGmmlCQHDWFZ6/d82s/BL6jjChhO8pduyxbH9hYHisqu0klksfH9Yy
 tzu4hzmxe3div9TaZwGb1VlqyasOL1rIffJwYwAIPSMtNBP5ZmVTva+IeSS8RA+NZPWm
 ED3FNgCD5YYna0zlyYankirQL6r44nbmY8BpCIm8ERJgRoYW7DnGH6vjVdqJWR4UOFeT
 njTYlC2quNF2p0L6/wp/1UVQ+ts+Rcuq5NnGrQKzo9/snRuadoRqbn9kOh4wzWLohAwJ
 ZXyywiOxID+h35rqaoKoCflLMmnaQ1ExmcaCv0zhLC/Desudk01f6ZMgzp6uEMaexyOy
 2+mw==
X-Gm-Message-State: AOJu0Yx1uuq/nYGnM8asDxLRwPTwE8prxjSK7nTr1YuDMuSPikfGkRi3
 lDfEuab8/pRI7eO/6nUow+TPWir3F0Sz85FXdHzYYLoe1V3gTercFW+fG4XjNfc=
X-Google-Smtp-Source: AGHT+IGphlcDDKiGv9hSd3NPtFKK7sDsBunmcY+tMSTF+sN5+6/40motn6ow5OxEfSN4rC6+5SAFFQ==
X-Received: by 2002:a05:6a21:3a83:b0:1d9:1907:aa2b with SMTP id
 adf61e73a8af0-1dba5219098mr5943698637.1.1730484269280; 
 Fri, 01 Nov 2024 11:04:29 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc316a79sm2881728b3a.205.2024.11.01.11.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 11:04:28 -0700 (PDT)
Message-ID: <8dacb139-dc82-4fc4-8468-befb327884eb@linaro.org>
Date: Fri, 1 Nov 2024 11:04:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: fix build error with clang
To: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
 <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
 <CAFEAcA92CuvGUJQk5LFE1X3a8dH21ksE_QXETjVPnU3v1bVSzw@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA92CuvGUJQk5LFE1X3a8dH21ksE_QXETjVPnU3v1bVSzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/1/24 10:48, Peter Maydell wrote:
> On Fri, 1 Nov 2024 at 17:36, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 11/1/24 2:08 PM, Pierrick Bouvier wrote:
>>> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>>>
>>> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>>>
>>>     187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>>
>>>         |                 ^
>>>
>>> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
>>>
>>>     217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>>>
>>>         | ^
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    hw/riscv/riscv-iommu.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>>> index feb650549ac..f738570bac2 100644
>>> --- a/hw/riscv/riscv-iommu.c
>>> +++ b/hw/riscv/riscv-iommu.c
>>> @@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>>>    }
>>>
>>>    /* Portable implementation of pext_u64, bit-mask extraction. */
>>> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>> +static uint64_t pext_u64(uint64_t val, uint64_t ext)
>>
>> I suggest name it 'riscv_iommu_pext_u64' to be clear that this is a local scope function,
>> not to be mistaken with anything available in clang or any other compiler.
> 
> More generally, we should avoid using leading '_' in QEMU function
> names; those are reserved for the system.
> 
> Also, what does this function do? The comment assumes that
> the reader knows what a "pext_u64" function does, but if you
> don't then it's fairly inscrutable bit-twiddling.
> "bit-mask extraction" suggests maybe we should be using
> the bitops.h extract functions instead ?
> 

Adding Tomasz (author of this change) and Alistair, who might have an 
opinion on this.

> thanks
> -- PMM

