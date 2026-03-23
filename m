Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14456F483ED
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4lRo-0005eL-Fs; Mon, 23 Mar 2026 16:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4lRj-0005dY-Dm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 16:00:20 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4lRf-0007ZI-Tu
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 16:00:18 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35b97ed057cso1949155a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774296014; x=1774900814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=faybZzLh6YY9dmLNXfG9qYTZlVqHu8hU9KRd1rRespI=;
 b=EDIqpNgqeBSc8/6YDrdRdvHhVa/lZxfOzKackKaZXTX1vaMBl600ELLEppGBI2E3J+
 XQ//VmN4L1ROUDf0/c4ImJQ6ik+WF+5FjFTXclWde56tYlrPqUp9sfvXz+GbUgPUkZ+B
 Pju7GGbHp6CwnJtD/cHe6mK6AvqVxbLSB5TVYHUTw0GJfe3DMG+Y5DNsfRmOqZhyVx5v
 3S8jSRVgAlQonDrnaNjsEtsezTChfsO9XBKt6H8nlp+nggNNZCj4QpUIgtwJxd4hPL+a
 3AXva/pjyrsS1c+RcjdZ97zx096HXx41v+muRfLg5wWNYYgHTOeOrsvv3hjf5ZlBHeYL
 1p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296014; x=1774900814;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=faybZzLh6YY9dmLNXfG9qYTZlVqHu8hU9KRd1rRespI=;
 b=mOVL/DDa2U5ATw4ZhoKO9AcCJ/kt/M2NbteuEGOXSqZwzvV2GKw/9mul1x9h/FuZiP
 yhaAX/VHwe8bEDtg0JJC/VB9XISBwfUU1F9ZLxQ4VUwfld2h+IhV60jOaZLAiC+qZsdb
 dotNpb3Zx0HrwouWtCRQQNHb9ywRcZwXedL5XPeIW8Z227WXkd8ewir3vBJO9RVVJzDc
 sgDOWWeYrjxiZXYpEwLdjc7BhgpdXovx+o6qOalu74bY/HEhRzME3H/BUTHF9Mc27+NQ
 QybmPZrWgKItzDSaBQtrdbowthx6FtJQjIQ4dTfhoB99zxSXNShl/ou1gbcdna+0Rllk
 xD8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhJqiz46Uw8UnpBp0ramK+1mAbcNHIl//Q9DsIYGU6YFt9F8gF8EQQLdcyAqLOnY16YzmQb7yKc8E4@nongnu.org
X-Gm-Message-State: AOJu0YwnaoJujm9NPrl1t0/Zo1NfrRDhrYiEO2qP7NnZHGj2cKsT8Y/c
 XaOXN9G23fL4bosHPAZppA0lAge1MKjL5nmKj/D7y7Bha7nOdgXm0d4MLjhogyhc5M4=
X-Gm-Gg: ATEYQzzoPmVQ+EO5k07oucltc2L6xL4aLeRqUjG0ZpHvoX5iM0IY4QsXfr2jgIW6ZAw
 zv1gxJqbqaGYpXlRQUU/m2EsFWGJ315ODV0cREAnYV1ICDjXLR9lFqBY658oCh4HQ1dcfIfFh5c
 V8sQUXuHtZ6HqG8ILQh0EkOVfktmbLCKlxCLu5vVnwmBRYPVVj+NqE9f9g/XSPY0zPL3Qq2qp+i
 AwaY8mfrdvM3u+Zk9n9hrIxM3qTw6C3ItZd9gL0t4G6VEJl2WVD8nG9neTtamwURqZ9oesHQJeF
 Dpxhj1/+E4fQ1IzJ7+znOxyQIOj69LVIZanvfA3F6htoOlGpus9CcNYHAL+UbF/tiB65coomEBB
 zQedcjZU5tJBmUmfjF6kkP8+tNhYIJax3Irzbpmn1zc+iwvpCjZVn7ZYlzdiSq2Of50e4eOOkca
 P3ycCiA6tsVMM0RbJXcI3s+tfLZ+7AVdoye96HxURH0+UuYKD4wCkZkHVti62hVGpIq4d7DLwEU
 j5u8XI=
X-Received: by 2002:a17:90b:35c3:b0:35b:8d89:719a with SMTP id
 98e67ed59e1d1-35bd2bf6ce7mr10589773a91.15.1774296014052; 
 Mon, 23 Mar 2026 13:00:14 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc6017492sm13884139a91.5.2026.03.23.13.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 13:00:13 -0700 (PDT)
Message-ID: <9f6d106a-878f-4fdf-ba30-1af86a2a0500@linaro.org>
Date: Mon, 23 Mar 2026 13:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 03/10] cpus: Introduce
 CPUClass::legacy_monitor_defs hook
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>
References: <20260320160811.28611-1-philmd@linaro.org>
 <20260320160811.28611-4-philmd@linaro.org>
 <7c54cfcf-fef6-41db-a1a8-382857371d3a@linaro.org>
 <9ed408a5-6b25-4d4e-aefc-59b413058ca6@linaro.org>
 <ada320b4-4204-43eb-a2da-5730641535de@linaro.org>
 <7c724cf7-c0d8-4e8b-8c74-8a78ace9f4d2@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7c724cf7-c0d8-4e8b-8c74-8a78ace9f4d2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/23/26 2:19 AM, Philippe Mathieu-Daudé wrote:
> On 21/3/26 20:51, Pierrick Bouvier wrote:
>> On 3/21/26 8:19 AM, Philippe Mathieu-Daudé wrote:
>>> On 20/3/26 23:01, Pierrick Bouvier wrote:
>>>> On 3/20/26 9:08 AM, Philippe Mathieu-Daudé wrote:
>>>>> Allow targets to register their legacy target_monitor_defs()
>>>>> in CPUClass; check it first in get_monitor_def() otherwise
>>>>> fall back to previous per-target helper.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>     include/hw/core/cpu.h | 3 +++
>>>>>     monitor/hmp.c         | 3 ++-
>>>>>     2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>>>> index 04e1f970caf..072f58bead5 100644
>>>>> --- a/include/hw/core/cpu.h
>>>>> +++ b/include/hw/core/cpu.h
>>>>> @@ -148,6 +148,8 @@ struct SysemuCPUOps;
>>>>>      * @max_as: Maximum valid index used to refer to the address spaces
>>>>> supported by
>>>>>      *          the architecture, i.e., to refer to CPUAddressSpaces in
>>>>>      *          CPUState::cpu_ases.
>>>>> + * @legacy_monitor_defs: Array of MonitorDef entries. This field is
>>>>> legacy,
>>>>> + *                       use @gdb_core_xml_file to dump registers
>>>>> instead.
>>>>>      *
>>>>>      * Represents a CPU family or model.
>>>>>      */
>>>>> @@ -174,6 +176,7 @@ struct CPUClass {
>>>>>         const char *gdb_core_xml_file;
>>>>>         const char * (*gdb_arch_name)(CPUState *cpu);
>>>>>         const char * (*gdb_get_core_xml_file)(CPUState *cpu);
>>>>> +    const MonitorDef *legacy_monitor_defs;
>>>>>         void (*disas_set_info)(const CPUState *cpu, disassemble_info
>>>>> *info);
>>>>> diff --git a/monitor/hmp.c b/monitor/hmp.c
>>>>> index c63da13e310..a2b6269d0ff 100644
>>>>> --- a/monitor/hmp.c
>>>>> +++ b/monitor/hmp.c
>>>>> @@ -24,6 +24,7 @@
>>>>>     #include "qemu/osdep.h"
>>>>>     #include <dirent.h>
>>>>> +#include "hw/core/cpu.h"
>>>>>     #include "hw/core/qdev.h"
>>>>>     #include "monitor-internal.h"
>>>>>     #include "monitor/hmp.h"
>>>>> @@ -1603,8 +1604,8 @@ void monitor_register_hmp_info_hrt(const char
>>>>> *name,
>>>>>      */
>>>>>     int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>>>>>     {
>>>>> -    const MonitorDef *md = target_monitor_defs();
>>>>>         CPUState *cs = mon_get_cpu(mon);
>>>>> +    const MonitorDef *md = cs->cc->legacy_monitor_defs ?:
>>>>> target_monitor_defs();
>>>>>         void *ptr;
>>>>>         uint64_t tmp = 0;
>>>>>         int ret;
>>>>
>>>> I'm not very fond of the "keep legacy callback for the N targets that
>>>> might require it". Either set it for every target, using a default
>>>> implementation if needed, or...
>>>>
>>>> As an alternative, we could use a dispatch function like:
>>>>
>>>> const MonitorDef *target_monitor_defs()
>>>> {
>>>>      switch (target_arch()) {
>>>>      case
>>>>        SYS_EMU_TARGET_X:
>>>>          return X_target_monitor_defs();
>>>>        SYS_EMU_TARGET_Y:
>>>>          return Y_target_monitor_defs();
>>>>      default:
>>>>        return default_target_monitor_defs();
>>>>      }
>>>> }
>>>>
>>>> Personally, I prefer the dispatch approach, as it's very clear to see
>>>> what happens per target. This solves the symbol duplication by manually
>>>> name them differently.
>>>>
>>>> It's just a suggestion though, and I'm ok to have a per target field, as
>>>> long as we enforce it to be set for all targets, and not using a
>>>> 'legacy' callback for a few of them only.
>>>>
>>>> Pick the one you prefer :)
>>>
>>> My preference would be to remove this legacy code altogether, as
>>> I'm pretty sure it isn't used anymore (see for the example the
>>> issues RISC-V folks had with it before giving up).
>>
>> I'm not sure what you mean.
>>
>> If it's not used, then we simply remove it.
>> If it's used, then let's keep it, but just make it consistent with all
>> targets without having a special case named "legacy". If it's here to
>> stay, it's not legacy.
>>
>> Do you have something else in mind?
> 
> As a software engineer I prefer to deal with code. Unfortunately in my
> experience with QEMU development, removing legacy code means endless
> bikesheeding debates. I'm not judging they are bad, just they drain my
> time and energy. I agree legacy code should be removed, but again this
> is the QEMU project here, where we have bad habbits of adding new APIs
> with the promise of removing the previous one but never finish API
> conversions, not even marking legacy one. With that in mind, I think
> mentioning "legacy" is still a good first step.
>

I agree, and it's *not* your responsibility to refactor any piece of 
code you have to touch for another purpose. In this case, I was just 
suggesting to make the callback consistent between all targets (i.e. 
force all them to implement it) instead of having a conditional legacy 
callback.

All the rest of the series (symbol renaming, etc) stays intact.

> Anyway, I suppose what you are asking is me starting a poll for each
> target array and ask "Who is still using this SPARC 'canrestore' monitor
> command?" etc., wait 2 months for replies, then if possible deprecate
> them, wait 2 more releases, and eventually remove. Then we'll be able
> to link this file in single binary. As of today I'm not motivated enough
> for that so I'm looking for alternatives. Looking at mailing list
> archives I apparently started to tackle this 9 weeks ago, long enough to
> keep working on the single binary with HMP code disable until we get
> a working proof of concept; then revisit.

I was just curious about your mention "My preference would be to remove 
this legacy code altogether", but no one expects you to do it.
I think having consistent callbacks through all targets is a very 
acceptable solution. The only difference with your series is to rename 
"legacy*" and set a default callback for all other targets.

If it's creating too much friction, I can also hear it and accept your 
current series as it is.

Regards,
Pierrick

