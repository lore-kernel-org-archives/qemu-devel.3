Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31DDEF99C8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy1f-0002CX-7K; Fri, 13 Feb 2026 13:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy1c-0002C3-MB
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:36:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy1a-000185-65
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:36:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so5747005ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007775; x=1771612575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mUXOv6WCOIKTDSjUv7qJelSyBMJw7DhHaS8ostDtpKI=;
 b=qaELCHYejygMjtlA2V2UAzWlyYt5lZEbS38LTAhv25zrR6O87wV8dshyQiL945Pts7
 /PrFrF490WXky5XT3TVDh21B7YhjAjG+xwfqmDJfN3s8ORAjXRRcSQKnciOhbe2tE6Gf
 hB9q2Nv93FmHoEg8hcJTAUcfR7WDHQxwY9+aq2FJv3zE9p/t0bd6U1jP9bywZCMMFDse
 4mB+f7+6lbDgVEagcXROQMJdVbwTpTcPvGptOAdEj5/a2/MmdnPaHM+sLDSijMELBNLM
 wuw8OUoWY1VrDwOhD382Cb8xI6PLTzLOr8ziT9WmMtlGDpjzP+SRvNKORd6trWD+ohTT
 Hb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007775; x=1771612575;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUXOv6WCOIKTDSjUv7qJelSyBMJw7DhHaS8ostDtpKI=;
 b=RN6IdsGVd2mISHeB37q2G5tKFp8uK0E/lOgoJGwJ0qV1A8N0jc+uJ7J8sGfEysgMN1
 zSCVNT08EfQRNprCshTbPy6JJi22PPRmWa85lxswx0aMbEOVJIuzJKdOlawMnUDiBf36
 MgSYJzWm+jkLbwd/8iw3t34VOagwcASH+aiU3GwDWES91vTwqiMr9WNhPH3k5woUflGj
 FpsBk702CUnkMElTboJHBh/Gq+DTeXqQBTO92ApCqiHy6dLoToM7V4q/W9sxAL/kVBWj
 JC/dPXszWK3BupBXJdIC9D4+Q8DCIeapWvc1Gk0Ap7tp/F/E+pdg5lcUEQHR3Ek64l6V
 c3ug==
X-Gm-Message-State: AOJu0YzIeDonQjOgN5aCCWy0JAGxWfuHPKPN6BBR/oXmxgyaFuyrFhSL
 e0ZTrVjR1sM8dd/V67h7x+6VJLleTzKSQGH9tf1d+4TX4PkzIDoM4+yJC3QGpHTt2ZQ=
X-Gm-Gg: AZuq6aL5tqr1JXm+W5qKPDYIsE26IBoTG+mbQrkGot6+y0uRqlUiD/6RcxRmyU+Dpp3
 XHkIICbCF4jf7/jzKv4RtzgBUKF3ManDsYqd197mltZyNmI4nbRvIwCSP8HE3/U9mmpUS2Hurp3
 4/1LZ5AeYd96nSeOsD8b9isy9+iWrK7VDvSKrwQgEY/jDVbB7na0R1T60NeldLCXfWmQvQctIy/
 NgMEUZHPoc0O1nJ63pyQjRLtYcjo67soJ5vW5P/YUr3KGcicCIW32Lxte1yZndA81my50qX2RFb
 GFbflGtd7lhU4hKhaSNHxVK8bVpmC7vaGrdEiduBv5iME4L+KWfiYdJhr8YBlBcD0p+/h4KCVGc
 IbaY7gtWet8Un1jPqSlmVEpMZCLVTGCA/1XAIeLw5E8Vj1IRggPlkc88uNFUQwAjZDfVjjMNzw9
 yCzHNARIu7H/P8EF0dSDVLafhIurID74LJ7Y0e4g3KVMiciW7EWpV8rXfDPBtEt7kGePnstnvZZ
 vju02I=
X-Received: by 2002:a17:902:ec82:b0:295:ceaf:8d76 with SMTP id
 d9443c01a7336-2ad1752516amr2879345ad.47.1771007774954; 
 Fri, 13 Feb 2026 10:36:14 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2997b3d8sm91374755ad.68.2026.02.13.10.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:36:14 -0800 (PST)
Message-ID: <7137a1e3-9f07-4a6b-8507-35bbfa5324e7@linaro.org>
Date: Fri, 13 Feb 2026 10:36:14 -0800
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <878883e5-7100-48b7-bb44-e0728c93ae72@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/13/26 5:38 AM, Florian Hofhammer wrote:
> On 26/01/2026 21:46, Alex Bennée wrote:> Alex Bennée <alex.bennee@linaro.org> writes:
>>
>>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>>
>>>> Some registers should be marked as read-only from a plugin API
>>>> perspective, as writing to them via qemu_plugin_write_register has no
>>>> effect. This includes the program counter, and we expose this fact to
>>>> the plugins with this patch.
>>>>
>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>> ---
>>>>   include/qemu/qemu-plugin.h |  2 ++
>>>>   plugins/api.c              | 17 +++++++++++++++++
>>>>   2 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>>> index f976b62030..1f25fb2b40 100644
>>>> --- a/include/qemu/qemu-plugin.h
>>>> +++ b/include/qemu/qemu-plugin.h
>>>> @@ -942,11 +942,13 @@ struct qemu_plugin_register;
>>>>    *          writing value with qemu_plugin_write_register
>>>>    * @name: register name
>>>>    * @feature: optional feature descriptor, can be NULL
>>>> + * @is_readonly: true if the register cannot be written via qemu_plugin_write_register
>>>>    */
>>>>   typedef struct {
>>>>       struct qemu_plugin_register *handle;
>>>>       const char *name;
>>>>       const char *feature;
>>>> +    bool is_readonly;
>>>>   } qemu_plugin_reg_descriptor;
>>>>   
>>>>   /**
>>>> diff --git a/plugins/api.c b/plugins/api.c
>>>> index fc19bdb40b..de8c32db50 100644
>>>> --- a/plugins/api.c
>>>> +++ b/plugins/api.c
>>>> @@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
>>>>    * ancillary data the plugin might find useful.
>>>>    */
>>>>   
>>>> +static const char pc_str[] = "pc"; // generic name for program counter
>>>> +static const char eip_str[] = "eip"; // x86 specific name for program counter
>>>> +static const char rip_str[] = "rip"; // x86_64 specific name for program counter
>>>> +static const char pswa_str[] = "pswa"; // s390x specific name for program counter
>>>> +static const char iaoq_str[] = "iaoq"; // HP/PA specific name for program counter
>>>> +static const char rpc_str[] = "rpc"; // microblaze specific name for
>>>> program counter
>>>
>>> It's ugly but I can't think of anything better as you say in the commit message.
>>>
>>>>   static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>   {
>>>>       GArray *find_data = g_array_new(true, true,
>>>> @@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>>>>               continue;
>>>>           }
>>>>   
>>>> +        gint plugin_ro_bit = 0;
>>>>           /* Create a record for the plugin */
>>>>           desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
>>>>           desc.name = g_intern_string(grd->name);
>>>
>>> Lets just set desc.is_readonly to false here.
>>>
>>>> +        if (!strcmp(desc.name, pc_str)
>>>> +            || !strcmp(desc.name, eip_str)
>>>> +            || !strcmp(desc.name, rip_str)
>>>> +            || !strcmp(desc.name, pswa_str)
>>>> +            || !strcmp(desc.name, iaoq_str)
>>>> +            || !strcmp(desc.name, rpc_str)
>>>> +           ) {
>>>> +            plugin_ro_bit = 1;
>>>> +        }
>>>> +        desc.is_readonly = plugin_ro_bit == 1 ? true : false;
>>>
>>> And fold setting it to true into the if statement. I have a marginal
>>> preference for g_strcmp0(desc.name, eip_str) == 0 style tests.
>>
>> The option of course would be to skip the register all together. Do we
>> have code which will have multiple vaddr's for the same TB where using
>> the TB data wouldn't be sufficient?
> 
> Skipping the register altogether would basically make it invisible to
> plugins and therefore remove functionality. A plugin might want to get a
> list of all registers (which would not be complete anymore), or get the
> current PC value. If I didn't miss anything, the latter might not
> necessarily be possible anymore, as a callback (especially the simple
> callback type) doesn't have access to the current TB data and can't
> necessarily pass userdata to the callback, so it wouldn't be able to get
> the PC from there anymore.
> 
>>>
>>>>           desc.feature = g_intern_string(grd->feature_name);
>>>>           g_array_append_val(find_data, desc);
>>>>       }
>>>
>>> Otherwise:
>>>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Seeing there are some questions around this, I have another one.

Does it really matter if a user can read/write pc register?

It seems to bring a lot of complexity to prevent this (especially the 
string per arch approach, even though that's the best we can do), and 
I'm not sure what's the actual benefit. If someone tries something QEMU 
plugins don't support in general, they can always send a bug report, or 
even a patch.
I'm not really sure to why someone would have a bad idea mixing register 
writes and pc diversion. And if they do, it would not be surprising it 
breaks things.

So maybe we can just extend API with PC diversion, and not overthink too 
much about potential consequences on registers.

Regards,
Pierrick

