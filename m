Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB4C79FAF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpFc-00078K-NQ; Mon, 05 Jan 2026 13:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcpFZ-000781-Sh
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:24:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcpFX-0004GX-1u
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:24:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso1251485e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767637453; x=1768242253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eraO+DVSM3kX29lfo9PzVTCqOnfAgOhe9g52SBxmcIE=;
 b=P1YTDWQoqnKwm/ttbvgDWlzlj+7lrjz+sNq0iravbVffM3xUYckLThCcB3B/8/NDLk
 umNdH5vHrlibMBSTs8GSD2sX64tFaczDjx5bSYLONgyS7kk2JUmeur+2NAiZkE8jAvhk
 G6xw1iD2Q9h3SXIw61ts5aL0XS0NS/juwbittMEpema6umdbIXHALsEpPMD1kttyFj/M
 XDqAC2841CFrNKcernaplBFcsqTwUQvEKTormfYQdd9JpsGfjDvtXn/zNilTz+VzYkOb
 PKyP/FCFw8PdaCzpW6cClYgimweOdsmM+xMkAyt2lkDXX6O2G4HAhIHIqpDuuzUg20SM
 dm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767637453; x=1768242253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eraO+DVSM3kX29lfo9PzVTCqOnfAgOhe9g52SBxmcIE=;
 b=DJA25d7PTPcfDw11Wh20nVTAMX8Zx0IrwwLnOs/8y6+OVhpNe5FzmdcNeSKOBjnmP7
 4t1l0s8SDE/sjy4/7DQ725HOjA7xbKvE68LoNiXaAEcq8XnwN3pJDKz//29x5ujYgsJx
 AyDtGhyrV9dr96fuPgT6qlqMd4H3+02Lgyg8M/sX4W4h4276tLS3hqxBA+FdCQo+LUKg
 DJ7TLphoMKArk3dOxfjEh3gpyD3dscqK0PuwW8Vg60yJWyGpINykyosa8gPDLEF0hO41
 lG9ISV7hp20i58eRs+o2w0LOkhmzoR2HcguKCKoAFFp5RY075Q9ysWrmBKu98fgHKKJa
 JB3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoGl80nV2R8Yy1rR61+Zp6KXja0TV/SXQSETQEeIjse1CAMjWlLyG+Dhef3JLwie4ijA561cnYkfMZ@nongnu.org
X-Gm-Message-State: AOJu0YwckJgggTcJqW+xQzz0AcPkoAcLFxIgKiA/h3tjElg7EWPdl+5W
 g1/eCaFpafi0+wYoAFA+2zpB3JzNESm32S63QqLdaZ4MrXlk2dmoQCXbeWaeK5+k/VU=
X-Gm-Gg: AY/fxX7JJlB9IzgFbzRHWnemMGv+pSSr+nETaIXLQ2B9Wr2vVNGZKtwDink3iVpz5+l
 GLFu4tXo9DfitE2CUaTK+VU+YmSOS3nQBzmVrB4FwaGi2dQe+ojPBfCZ6ox7fbjUHkUEMZyjhT0
 QTarCSkxALO99GPjfFVyfpzr3MK9dFHqoA5WqrrKowhXI3aNfPfEh4NBR1WxdwPWfBoszXei0Ab
 xH0hb6/vGBSQRg/e7WBlF6vsBt6UoVt1fxrUhrK5wRmXIi3T8kEk82EWz5f7i4bv5sit7NFAOzh
 mAfjeOjjSPXJahfmpa2Pn2gsPsFuzMCMmzI4+ZBT3uqHQF7uUxUriVx+ef+vXmZGH7V22ZHoG8P
 P8KmdQFeFS0MuIiFmiUhprlgYMM3rBGaBG4uYeIq/VJht4VXq5C6fxHnk3TDwP964TFdG1FbAjw
 ztI8449LhRrI/+A09x6NWVZ66kqddQNXpE6obl4VgiySYaFZ1Qi8n5MsBdPA==
X-Google-Smtp-Source: AGHT+IEqBRAR/hdDBjP5GgMGZUI2NEZZdXUjk6gFAYTUo+yx5KmMdi7WU7CGYWrBrkZLlSceRfrkfg==
X-Received: by 2002:a05:6000:4011:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-432bca1679fmr854382f8f.3.1767637453013; 
 Mon, 05 Jan 2026 10:24:13 -0800 (PST)
Received: from [10.247.174.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca56a24sm846592f8f.33.2026.01.05.10.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 10:24:12 -0800 (PST)
Message-ID: <5584951e-2eb0-4b4f-b946-0c89482eebf0@linaro.org>
Date: Mon, 5 Jan 2026 19:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-9-philmd@linaro.org>
 <a48503cb-0a62-4cc7-83ff-393945dace0d@linaro.org>
 <854a4169-0f9b-4f10-a519-0410b799cb4e@linaro.org>
 <0a04dfd8-1c8c-4d87-99b8-d0e3cb9329d6@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0a04dfd8-1c8c-4d87-99b8-d0e3cb9329d6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/1/26 12:45, Richard Henderson wrote:
> On 1/5/26 21:56, Philippe Mathieu-Daudé wrote:
>> On 5/1/26 01:37, Richard Henderson wrote:
>>> On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
>>>> Rather than ldtul_p() which uses the underlying 'unsigned
>>>> long' size, use the ldn() variant, passing the access size
>>>> as argument (evaluating TARGET_LONG_BITS / 8).
>>>>
>>>> No need to use #ifdef'ry to check for TARGET_ABI32, since
>>>> it is 64-bit:
>>>>
>>>>    $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
>>>>    configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=32
>>>>    configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=32
>>>>    configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
>>>>    configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=64
>>>>    configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=64
>>>>    configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=64
>>>>
>>>> Directly expand to the big-endian variant (with the '_be' suffix)
>>>> since we only build the SPARC targets as big-endian.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   target/sparc/gdbstub.c | 12 ++----------
>>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
>>>> index 134617fb232..d265681f6d2 100644
>>>> --- a/target/sparc/gdbstub.c
>>>> +++ b/target/sparc/gdbstub.c
>>>> @@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, 
>>>> uint8_t *mem_buf, int n)
>>>>   {
>>>>       SPARCCPU *cpu = SPARC_CPU(cs);
>>>>       CPUSPARCState *env = &cpu->env;
>>>> -#if defined(TARGET_ABI32)
>>>> -    uint32_t tmp;
>>>> -
>>>> -    tmp = ldl_p(mem_buf);
>>>> -#else
>>>> -    target_ulong tmp;
>>>> -
>>>> -    tmp = ldtul_p(mem_buf);
>>>> -#endif
>>>> +    uint64_t tmp = ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);
>>>
>>> No, this changes the behaviour of sparc32plus.
>>
>> $ git grep TARGET_ABI32 configs/targets/sparc*
>> configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
>>
>> $ cat configs/targets/sparc32plus-linux-user.mak
>> TARGET_ABI32=y
>> TARGET_BIG_ENDIAN=y
>> TARGET_LONG_BITS=64
>>
>> Isn't it the same?
> 
> No.  ABI32 uses uint32_t, not uint64_t, even with 64-bit registers.

Oh right, I missed that.

> Which is probably functionally broken, because, history.

And still we maintain it...

