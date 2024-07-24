Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CCDC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhEV-000519-5L; Wed, 24 Jul 2024 15:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sWhEP-0004zg-IN
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:01:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sWhEN-0001dc-96
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:00:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fa9ecfb321so804105ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721847652; x=1722452452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0A+/3HX3ILHD7unz0Lv65WDDd34JdR+DaG9xuaNMPE=;
 b=B01YVVEE4LZWgTOMU3Od12GFm/BAIx9FyoaWzT+9lhwg7OEDa4eCSvdpCaUYNgPCui
 TKsraWQqru42zpauEtKx9mn/hLuGkABVdRaLB7xEP1uFxO102mq4dO6ETRMCs2a5Uo9+
 qcOm8xYx0y8F9hTQFF+cTDa9XKxaZasUQIipQ2BN1Xvohyh5hL6XDV2NEVlsaCr902Kw
 zleZGN9i0sIYf4VuKBji/xAv3h89iWd98pHee0el+SckwrAHTIpH1y+TObALYz8Cez8p
 eSvIfwJLaEzLV8WRoBBKIjPtYaQL8UgDYXoBYGeJuiFrm3N/fFbS5DGbElz3vHhtpIE+
 CHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721847652; x=1722452452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0A+/3HX3ILHD7unz0Lv65WDDd34JdR+DaG9xuaNMPE=;
 b=GNymoRzElQV1bJwZ7JWpcpehIQP162B5UYdoYmzKFl+yVNd6hkf6CkpbCT/ekavB0y
 4wd0+3XhWeZ9wdEDKMdey2dsKE49128S4JQ5o9h41x5nLMK7OHpCOs3feqFnlivCCERE
 6nO9fGtFz0HLCssN4yE0GT54wp8/hQfJWcOVsWJ5tHqJEFG1olFM1HIeZ7DkaCjY2FJR
 tvIl/wpBKoQKG4Qw55z2quqXKz7NOq+29eu6e2qF4kWE0E3zkSwUi3kwfb3Q1616mDha
 PWeWQ6SxWEEbM6xjLdSg1jnsFUvfIPYLl0Au5Z+lNsersmqIyrmVcQuhwXeHFAkfVphF
 ewOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjwjtsAMaCXsP+6mkf5FTS+4fGROqLiGQMVkcNiV/D2lKEHNy/JzkH208RwlapnmfKUGm8hcawnfMQsOgtFDHTD7JJtVM=
X-Gm-Message-State: AOJu0YxJSYY6p2+CG0SUDakSOKJcBe9FLkA3uH0S5JvjZtY/pTD0LWLN
 VfsPCKeCWt5D4Eav1JR8+gdOfrJUshJPv0qfDEoI8OW6EW1RIHNmRIk9XqLqm3k=
X-Google-Smtp-Source: AGHT+IHlkNeIWNuRBfeuFEFu0sfL6fPn46pWbCKN6XCplOJyapckgr6zG9U1rwok4vz0XkWhKh1vzQ==
X-Received: by 2002:a17:902:d491:b0:1fc:6a13:a394 with SMTP id
 d9443c01a7336-1fed3846907mr5840545ad.23.1721847651979; 
 Wed, 24 Jul 2024 12:00:51 -0700 (PDT)
Received: from [192.168.68.110] ([179.193.8.144])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f48ca8csm97867175ad.302.2024.07.24.12.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 12:00:51 -0700 (PDT)
Message-ID: <c6aade3f-4320-4089-9c76-7054f9850274@ventanamicro.com>
Date: Wed, 24 Jul 2024 16:00:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Atish Kumar Patra <atishp@rivosinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-27-alistair.francis@wdc.com>
 <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
 <CAHBxVyHZ1_zgg-V2aKMcYsZjWHwcfndt-rbTa0h8mp_Ufe7hjw@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAHBxVyHZ1_zgg-V2aKMcYsZjWHwcfndt-rbTa0h8mp_Ufe7hjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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



On 7/22/24 8:33 PM, Atish Kumar Patra wrote:
> On Sat, Jul 20, 2024 at 8:19 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 18 Jul 2024 at 03:15, Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> From: Atish Patra <atishp@rivosinc.com>
>>>
>>> The timer is setup function is invoked in both hpmcounter
>>> write and mcountinhibit write path. If the OF bit set, the
>>> LCOFI interrupt is disabled. There is no benefitting in
>>> setting up the qemu timer until LCOFI is cleared to indicate
>>> that interrupts can be fired again.
>>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> Message-ID: <20240711-smcntrpmf_v7-v8-12-b7c38ae7b263@rivosinc.com>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>   target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
>>>   1 file changed, 44 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
>>> index a4729f6c53..3cc0b3648c 100644
>>> --- a/target/riscv/pmu.c
>>> +++ b/target/riscv/pmu.c
>>> @@ -416,14 +416,49 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>>>       return 0;
>>>   }
>>
>> Hi; I was looking at an issue Coverity flagged up with this code (CID
>> 1558461, 1558463):
>>
>>> +static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
>>> +{
>>> +    target_ulong mhpmevent_val;
>>> +    uint64_t of_bit_mask;
>>> +
>>> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
>>> +        mhpmevent_val = env->mhpmeventh_val[ctr_idx];
>>> +        of_bit_mask = MHPMEVENTH_BIT_OF;
>>> +     } else {
>>> +        mhpmevent_val = env->mhpmevent_val[ctr_idx];
>>> +        of_bit_mask = MHPMEVENT_BIT_OF;
>>
>> MHPMEVENT_BIT_OF is defined as BIT_ULL(63)...
>>
>>> +    }
>>> +
>>> +    return get_field(mhpmevent_val, of_bit_mask);
>>
>> ...but we pass it to get_field(), whose definition is:
>>
>> #define get_field(reg, mask) (((reg) & \
>>                   (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
>>
>> Notice that part of this expression is "(mask) << 1". So Coverity complains
>> that we took a constant value and shifted it right off the top.
>>
>> I think this is probably a false positive, but why is target/riscv
>> using its own ad-hoc macros for extracting bitfields? We have
>> a standard set of extract/deposit macros in bitops.h, and not
> 
> Thanks for pointing those out. I checked the get_field usage from the
> beginning of riscv support 6 years back.
> There are tons of users of get_field in a bunch of riscv sources. I
> guess it was just added once and everybody kept using it
> without switching to generic functions.

I'm not sure about which generic functions we're supposed to use in replace of
get_field/set_field, at least as far as bitops.h goes. extract64/deposit64 has a
different API (it uses start bit + length, not a mask) and it would require
a lot of RISC-V code to be adapted to this format.

Looking a little further I see that registerfields.h has the equivalent of what
we're using here: FIELD_EX64 / FIELD_SEX64. But these macros seems to be tied with
the abstractions used in the header, i.e. registers created with REG32/REG64 and
fields/masks created with the FIELD() macro. The header smmuv3-internal.h makes
use of them so we could use that as a base.

Hopefully Peter/Richard can correct me if I'm wrong and point to the right
direction. Thanks,


Daniel


> 
> @Alistair Francis : Are there any other reasons ?
> 
> If not, I can take a stab at fixing those if nobody is looking at them already.
> 
>> using them makes the riscv code harder to read for people who
>> are used to the rest of the codebase (e.g. to figure out if this
>> Coverity issue is a false positive I would need to look at these
>> macros to figure out what exactly they're doing).
>>
>> thanks
>> -- PMM

