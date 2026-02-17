Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A97E83831
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 02:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsAre-0004zJ-1G; Mon, 16 Feb 2026 21:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsArT-0004yR-0z
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 21:30:54 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsArQ-00035g-VD
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 21:30:50 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso1272231a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771295446; x=1771900246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQAeoFY9SWFCxeDdoRKnYNGH6f16eNdD6D3gkRi6ElI=;
 b=t5VLrLrrX2X6qdhyXA+eA3kBOJTc0UHbYebZ1vFj52QXRxOQ2jrvJWVoJS2kYqFmb3
 kR5KZJ5SnUtaj4ThFUTRth1mIRrRQ9DKS00OCw13k3kGAa1uCUxn2RKl5b67cneIOg9x
 YZQxK/L6ZI+p4al2vKer1s7WhDfGUtnzKAL67wUWrDWUmZ8qYk9BKRmeUaS6eMTVAe1H
 BrzLzdQfJ6CRL6IrahGK3KcdE2ztTrdNaiYmi+rtA2EEkDUf2Z3d2+dj0w+bIJuOZduY
 bSVVvAbbcPUqD0hUqqn2vfboIcCb1XeInLOZkc61ekM9mmdtH4nfxoBCdU06WGBm2Jb5
 g7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771295446; x=1771900246;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQAeoFY9SWFCxeDdoRKnYNGH6f16eNdD6D3gkRi6ElI=;
 b=TTcNq4ju8aUyXwaZBIyemZR5Yf5mxKnMOyzUlUbjJBROWkeekte0S7Q/xJPzUnpa9p
 KqQa5ECbGFEWsrdcGWZuE8gusjFHBoA+HR8eUkxdOf1YU5Ph/SAtkAht4J3uMhBlDdsh
 EUdjpr6ejhch9YwjgRou3n8BPztwbytbF26IYvy5ZR1DumFfUuJk4gpHvy3nnCeW4Fni
 oMeFcyNA0xpkcIProNfrceCOwl6aBuafRFllcCH6MPHiprRqr1KgRGAvPvpgl/2Misl3
 ySCZzt+Ju7MfyG7+2pVaj4QuOXRRaENvPnFhCx6Gl6BZTQu48PfgApYUgBmPnsCrubTK
 SG4Q==
X-Gm-Message-State: AOJu0YzGkhfPiFELmcHct+3d6BxdW5SYzT0YddnRBXlr2p9KKKE2NsSr
 d5USMWD3TuY82S2+ktjL34EndNaXEvmm6owBibf8RABJRCgWhwDAj1axbmRLrTmlQ1E=
X-Gm-Gg: AZuq6aJAWr6/K4WXmJELYgvKupiugpim9Gt0aWiLdIxC+AtgFXdkhPtG+73IUDEogxh
 DXVJx5WEh5Rhh3eZVk44sj5gvvkMeHU8BuK/+Gf008wrMFlDP0/VZSa9gG17FvQuJ2iNhCk3Wdt
 DKfyN/m2GASXgy8GvFhqGn7UffOwoPqYxrWCvbc2dlvQP+0Pqg+iq8y3ExFFxXlGdIn7G+i2BV/
 SqaF2hVGThrQc9qMVJ6kXWm6jaRczMZYM85niJsNJ1TuVBhyKr5Xvcw0xTXuv8toA2QzBql1oeh
 +iOLNE1N6hzh4jmu1r37RxxGrdFcLlsoek1xI15PixaGktt3vNw3DXhXUhm9Wc+bR+r1B/1jfCj
 cm1F7GCwj2TkKDi2Tl9yC42MBSXZ10NCoo1lmB42/ahQ1i47W5qKc3L/gaqEHRw6R7UHjY9i1kd
 OL4EAUVIvGT/PaMhvpzwVujeqHfyqEMIjU+VsDAtpS5Bd7MDCtHABUFmhpzKfrRskU8Kgf
X-Received: by 2002:a17:903:3d0b:b0:2a7:a9e4:babc with SMTP id
 d9443c01a7336-2ab50647207mr137122185ad.61.1771295445986; 
 Mon, 16 Feb 2026 18:30:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a9d5df0sm81563455ad.58.2026.02.16.18.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 18:30:45 -0800 (PST)
Message-ID: <d62e6f20-062c-4986-aa36-e89cb9bd6c05@linaro.org>
Date: Mon, 16 Feb 2026 18:30:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] plugins: add read-only property for registers
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
 <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch>
 <871pjcdt5q.fsf@draig.linaro.org> <87pl6wcda9.fsf@draig.linaro.org>
 <878883e5-7100-48b7-bb44-e0728c93ae72@epfl.ch>
 <7137a1e3-9f07-4a6b-8507-35bbfa5324e7@linaro.org>
 <7fc71343-095c-4dad-9cda-4267fc49b64c@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7fc71343-095c-4dad-9cda-4267fc49b64c@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

On 2/16/26 4:54 AM, Florian Hofhammer wrote:
> On 13/02/2026 19:36, Pierrick Bouvier wrote:
>> On 2/13/26 5:38 AM, Florian Hofhammer wrote:
>>> On 26/01/2026 21:46, Alex Bennée wrote:> Alex Bennée <alex.bennee@linaro.org> writes:
>>>>
>>>>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>>>>
>>>>>> Some registers should be marked as read-only from a plugin API
>>>>>> perspective, as writing to them via qemu_plugin_write_register has no
>>>>>> effect. This includes the program counter, and we expose this fact to
>>>>>> the plugins with this patch.
>>>>>>
>>>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>>>> ---
>>>>>>    include/qemu/qemu-plugin.h |  2 ++
>>>>>>    plugins/api.c              | 17 +++++++++++++++++
>>>>>>    2 files changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>>>>> index f976b62030..1f25fb2b40 100644
>>>>>> --- a/include/qemu/qemu-plugin.h
>>>>>> +++ b/include/qemu/qemu-plugin.h
>>>>>> @@ -942,11 +942,13 @@ struct qemu_plugin_register;
>>>>>>     *          writing value with qemu_plugin_write_register
>>>>>>     * @name: register name
>>>>>>     * @feature: optional feature descriptor, can be NULL
>>>>>> + * @is_readonly: true if the register cannot be written via qemu_plugin_write_register
>>>>>>     */
>>>>>>    typedef struct {
>>>>>>        struct qemu_plugin_register *handle;
>>>>>>        const char *name;
>>>>>>        const char *feature;
>>>>>> +    bool is_readonly;
>>>>>>    } qemu_plugin_reg_descriptor;
>>>>>>      /**
>>>>>> diff --git a/plugins/api.c b/plugins/api.c
>>>>>> index fc19bdb40b..de8c32db50 100644
>>>>>> --- a/plugins/api.c
>>>>>> +++ b/plugins/api.c
>>>>>> @@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
>>>>>>     * ancillary data the plugin might find useful.
>>>>>>     */
>>>>>>    +static const char pc_str[] = "pc"; // generic name for program counter
>>>>>> +static const char eip_str[] = "eip"; // x86 specific name for program counter
>>>>>> +static const char rip_str[] = "rip"; // x86_64 specific name for program counter
>>>>>> +static const char pswa_str[] = "pswa"; // s390x specific name for program counter
>>>>>> +static const char iaoq_str[] = "iaoq"; // HP/PA specific name for program counter
>>>>>> +static const char rpc_str[] = "rpc"; // microblaze specific name for
>>>>>> program counter
>>>>>
>>>>> It's ugly but I can't think of anything better as you say in the commit message.
>>>>>
>>>>>>    static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>>>    {
>>>>>>        GArray *find_data = g_array_new(true, true,
>>>>>> @@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>>>                continue;
>>>>>>            }
>>>>>>    +        gint plugin_ro_bit = 0;
>>>>>>            /* Create a record for the plugin */
>>>>>>            desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
>>>>>>            desc.name = g_intern_string(grd->name);
>>>>>
>>>>> Lets just set desc.is_readonly to false here.
>>>>>
>>>>>> +        if (!strcmp(desc.name, pc_str)
>>>>>> +            || !strcmp(desc.name, eip_str)
>>>>>> +            || !strcmp(desc.name, rip_str)
>>>>>> +            || !strcmp(desc.name, pswa_str)
>>>>>> +            || !strcmp(desc.name, iaoq_str)
>>>>>> +            || !strcmp(desc.name, rpc_str)
>>>>>> +           ) {
>>>>>> +            plugin_ro_bit = 1;
>>>>>> +        }
>>>>>> +        desc.is_readonly = plugin_ro_bit == 1 ? true : false;
>>>>>
>>>>> And fold setting it to true into the if statement. I have a marginal
>>>>> preference for g_strcmp0(desc.name, eip_str) == 0 style tests.
>>>>
>>>> The option of course would be to skip the register all together. Do we
>>>> have code which will have multiple vaddr's for the same TB where using
>>>> the TB data wouldn't be sufficient?
>>>
>>> Skipping the register altogether would basically make it invisible to
>>> plugins and therefore remove functionality. A plugin might want to get a
>>> list of all registers (which would not be complete anymore), or get the
>>> current PC value. If I didn't miss anything, the latter might not
>>> necessarily be possible anymore, as a callback (especially the simple
>>> callback type) doesn't have access to the current TB data and can't
>>> necessarily pass userdata to the callback, so it wouldn't be able to get
>>> the PC from there anymore.
>>>
>>>>>
>>>>>>            desc.feature = g_intern_string(grd->feature_name);
>>>>>>            g_array_append_val(find_data, desc);
>>>>>>        }
>>>>>
>>>>> Otherwise:
>>>>>
>>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> Seeing there are some questions around this, I have another one.
>>
>> Does it really matter if a user can read/write pc register?
> 
> The idea of blocking writes to the PC via the register write API came up
> in https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg01671.html.
> As it stands, writes to the PC are silently swallowed, and preventing
> that could reduce confusion for plugin authors. It makes it clear why
> there would be a special API for setting the PC instead of using the
> generic register write API.
> 
>> It seems to bring a lot of complexity to prevent this (especially the string per arch approach, even though that's the best we can do), and I'm not sure what's the actual benefit. If someone tries something QEMU plugins don't support in general, they can always send a bug report, or even a patch.
>> I'm not really sure to why someone would have a bad idea mixing register writes and pc diversion. And if they do, it would not be surprising it breaks things.
> 
> Alternatively, I could add a remark to the documentation for the
> register write API that the PC can only be modified via the dedicated
> API and not change the implementation at all. But I think I'll have to
> defer that decision to you and Alex as the plugin subsystem maintainers.
>

My original message was for Alex, in case it was not clear, or too implicit.

I don't want to hijack this thread since he explicitely asked for this, 
but since it starts to go in a complicated direction, I just felt asking 
again "Is it really what we want?".

On my side, it's definitely ok with just a comment in documentation. If 
we have a problem later, we can still change things.

>> So maybe we can just extend API with PC diversion, and not overthink too much about potential consequences on registers.
>>
>> Regards,
>> Pierrick
> 
> Best,
> Florian


