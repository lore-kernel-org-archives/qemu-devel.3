Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E2F46127
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4g36-00009l-1Q; Mon, 23 Mar 2026 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4g33-00009K-Qs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:14:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4g31-0000gB-OQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:14:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48374014a77so41536055e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774275266; x=1774880066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C0XhHrI7fbEP0cGWas3W12G0hVEC6xRXVjWQ0TdOuhw=;
 b=HKGKqv6LNZblAWoZT2a54hTPxbpOaSJdfVLNKvjMQEXoboR9sPdJeIhGH9yMQQNv+a
 YGLAvstz8tDH7zRBmWpr0DMFpwnPfenFyI8Ey8GzqjgKPTrnciuk5b2BYhXf8+qJZtW7
 qehMrd3nHPyJA5wSlqcZWT7OTC17S25yBwAUfsvIFppVLLbVFxR00pcagjpv7J7fXk0e
 ef4qUZrSZAs8YIjBibl8uo7vQX8PEt+O97sBEqM07QULbfOr3RmQfqVZB8Ta8nepLJ47
 djuAKEgqGI2JMmSnZV6uV14GU1WiOKMvRqbW/T5hRLSFkkZ25WuIsWB6z65c0Ie5gQpg
 +pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774275266; x=1774880066;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C0XhHrI7fbEP0cGWas3W12G0hVEC6xRXVjWQ0TdOuhw=;
 b=cZZjLwNNBmYMU11rRAisxkmzsv64rsU2/1a/iuML4m4W6j1T9gTM5LVTvAp56FlkHj
 JVgd6QOhwp7YFZ2pUqh+7p1y/zqt6VnxnLII75grGdQ9dIERdGlWcs6Sv0WzyHBKTZKs
 +h7pyUNzfvozIUT2/Z6lJiwQsFmA0VlJNX4nf1ESA5N/TNIeFCO6+nPNeD/Je/thE0ch
 vr2o4SRVvc9x3NXyZx53hh3km2gzPCHtHXBB51K9zfn+G89o9tB1JGWS0pVYzc3gABEz
 iz2l4Tg7R6u6PG1H/Saos2VPafJT+V78RSP7/eSuz3vrchbWSUQMIs0QtcXM/yRoumxl
 0HAw==
X-Gm-Message-State: AOJu0Yx/UomrjWUqj+yIp1gt8C2IktHOnNaMl5yycHbDXSVZN4MV+eJi
 x4KQX4XgI5tKrO23LOcxF1jIOVWzCenyjtC3MctYUN+WN95ms8I+joM9ZHk5csaffuWVR3BSL4m
 0Vf+K7LA=
X-Gm-Gg: ATEYQzzQQnD7klU+kH452rfZkn6eXzc8CfFB+TtuKiuWlrMvgQBRvpy5BdJeW94qLn9
 PBwofgnLW/ATVHtUYEdqdXFXleLSTmycrwT5RmRG+FCmDFFM5H+FvlEuMOjtzzKFnMwDw2xRWuI
 sRanZYoLZxSgVKc2QQoUoT6MVkX1KNeM+13YPnZzgmEqPxu7449YlDbPxqL+EdY8I5XWiMItnCl
 VaKzLvM8Z42plmDbWn00iyb0FfjqrrDdZOCd7vUm4fIimnxmpAbrLWYfOpPKNg01y9xsvX8UdVw
 kHQBCQCoEwtMc5lj7kV0hgTEW2gNd2HShFcNJM4zKc9PXc2R142fUqC6xWG8grHz6KBim71PF1x
 txjLFT8vmrRodn5gVnDTfKOU7d1YalqubrPuibjldzTZYAN/Hel/Qk+Vf2+Cz7fqQlPcDjCuq1k
 l59aMSq6NwnoJR7N0t7TI/XfRTdt7+yg4d5dH774GOSjCFdTycrkafgh/XjRT35W6tOg==
X-Received: by 2002:a05:600c:35c4:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-486fedb2551mr203667075e9.9.1774275265929; 
 Mon, 23 Mar 2026 07:14:25 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7d6c54sm657918375e9.4.2026.03.23.07.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 07:14:25 -0700 (PDT)
Message-ID: <7ecfc1be-7cc8-4f85-b10e-e1c3d43bd22f@linaro.org>
Date: Mon, 23 Mar 2026 15:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] monitor: Correctly display virtual addresses
 while dumping memory
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260323095020.66658-1-philmd@linaro.org>
 <d0a6376c-dcb5-a12a-3b32-8a2c81f32b0e@eik.bme.hu>
 <26785143-4574-411c-8985-951ae0da0570@linaro.org>
 <55136018-65af-8e46-2ba1-794dc2f4114e@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <55136018-65af-8e46-2ba1-794dc2f4114e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/3/26 14:45, BALATON Zoltan wrote:
> On Mon, 23 Mar 2026, Philippe Mathieu-Daudé wrote:
>> On 23/3/26 12:51, BALATON Zoltan wrote:
>>> On Mon, 23 Mar 2026, Philippe Mathieu-Daudé wrote:
>>>> While reworking the address format width in commit 6ad593a75a8 we
>>>> introduce a bug, leading to addresses being displayed with too many
>>>> zeroes:
>>>>
>>>>  $ qemu-system-ppc -monitor stdio -S
>>>>  QEMU 10.2.90 monitor - type 'help' for more information
>>>>  (qemu) x/x 0
>>>>  0000000000000000000000000000000000000000000000000000000000000000: 
>>>> 0x00000000
>>>>  (qemu) x/x 0xfff00000
>>>>  00000000000000000000000000000000000000000000000000000000fff00000: 
>>>> 0x60000000
>>>>
>>>>  $ qemu-system-ppc64 -monitor stdio -S
>>>>  QEMU 10.2.90 monitor - type 'help' for more information
>>>>  (qemu) x/x 0
>>>>  00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000: 0x00000000
>>>>
>>>> Correct the format width to restore the previous behavior:
>>>>
>>>>  $ qemu-system-ppc -monitor stdio -S
>>>>  QEMU 10.2.90 monitor - type 'help' for more information
>>>>  (qemu) x/x 0
>>>>  00000000: 0x00000000
>>>>
>>>>  $ qemu-system-ppc64 -monitor stdio -S
>>>>  QEMU 10.2.90 monitor - type 'help' for more information
>>>>  (qemu) x/x 0
>>>>  0000000000000000: 0x00000000
>>>>
>>>> Fixes: 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr argument 
>>>> in memory_dump()")
>>>> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> monitor/hmp-cmds.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>>>> index bad034937a9..bc26b39d708 100644
>>>> --- a/monitor/hmp-cmds.c
>>>> +++ b/monitor/hmp-cmds.c
>>>> @@ -537,7 +537,7 @@ static void memory_dump(Monitor *mon, int count, 
>>>> int format, int wsize,
>>>>     uint8_t buf[16];
>>>>     uint64_t v;
>>>>     CPUState *cs = mon_get_cpu(mon);
>>>> -    const unsigned int addr_width = is_physical ? 8 : 
>>>> (target_long_bits() * 2);
>>>> +    const unsigned int addr_width = is_physical ? 8 : 
>>>> (target_long_bits() / 4);
>>>
>>> Thanks, that should help, haven't tried yet. But is_physical used 
>>> HWADDR_FMT_plx before which is "%016" PRIx64 so should that be 16 
>>> here to preserve previous behaviour? (Both 8 or 16 seem arbitrary, it 
>>> should really depend on the physical address width of target but 64 
>>> bits for physical seems better as even 32 bit CPUs might have larger 
>>> phys addresses.)
>>
>> This patch only fixes the virtual path, restoring the
>> behavior prior commit 6ad593a75a8.
>>
>> For physical path previous format indeed used 16 chars,
>> overkill IMHO, still I neglected to comment I reduced
>> 16 -> 8 in commit 6ad593a75a8. Nobody complained so far
>> but if you rather I can restore that too, as a "fix".
> 
> Considering that e.g. PPC440 or i386 with PAE could have larger physical 
> addresses even if target long bits is 32 (and 64 bit CPUs surely have 
> larger physical addresses) I don't think just 8 chars would be enough. 
> Even if nobody complained yet maybe it's safest to match the original 
> output for the freeze now and try to rewrite it for next version.

The physical address isn't trucated at 8 chars, it is just not
zero-expanded.
So for example 0000000100000000 is displayed as 100000000.

