Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C38BCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5Wz-0008S4-Q2; Tue, 26 Mar 2024 08:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp5Wz-0008Rv-2F
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:03:53 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp5Ww-0001GM-OI
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:03:52 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56bc5a3aeb9so7067304a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711454629; x=1712059429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4TVpYxtgVcG3yOgWATcYlZHI6BaU2t/O3rvomFScpL4=;
 b=T0rDPevBRm6mF8/Azm+w8RouzSzY4iQMFcB4S4fOaks7C6Enugig4rBqnJd3VeAqLO
 gAu0onb/HlZBE750id55GGAnNPnGAyPZDrZNdb8BiZ0hGgQRRpbzXb63vpuQkjb5z3NZ
 VYkNGHKurYGVPE1oscb9p5C3dkXAslBAkqchucU2yXW8hO+ZOht4ErU+lLbv5uY292+P
 xA1/t64PeI8pMc8yxSz0lijswSr1a7tX7/SblPl/ZRtOABBV7l/tBDL5nwTkHwuSJ4M8
 jkEntQ+NMvFztUREZPTAjiqhwBLKGOg4oZzhYhOeaEx+bu94AahTKoJa9kO3Kqu5hfKF
 ULWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711454629; x=1712059429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4TVpYxtgVcG3yOgWATcYlZHI6BaU2t/O3rvomFScpL4=;
 b=qBCjvf4wrLjmRKUuMM8/F2PjBxsJxbZ5P7zE97OcCyWqC/kQkAR7Cx0I2tAZRL/S0C
 /b1zSu2S19W6briQ9MPGELwRZPvPsuNwxOCbaT/INRU4llQC7yCI64u/ZNh/fiv1FhA8
 PoIqsuDjhqMY31ycT06nsKgHpnA43y4Tq66Hw/HGo+oG9IkoqqVKkG0m037SE2QfjkNH
 Rr/HtBgsUvK/naTr4vYJSAiOZzki0wxF91mnsnWqxPyB3/YXluW2p7npeBL+fw1B8OEQ
 c2CiveH6+r0+t+TgxrRyAxFi+KrUSXPyoJ70HEBbciNAOZb9pw35brNzNeFV1PYzFLhB
 CrdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJYat5/dYRj9cWrmW0rokhV3/JIhu141+WQF0F20bDGG4YciT/IByGgqhb0jfJ/31XfQ2lhRTiM1iAvf6niYBWtso8mTs=
X-Gm-Message-State: AOJu0YwYCGs9os2PPC5u6JZ9DNc4BYyppA6vBIxHscmm6YrAXJVJlbYa
 9XJ7I/aqZsH0aMPMN6iecwGJw519byISzrN9wImrkFbbq7v8UMaZoUJsLZDfUX4=
X-Google-Smtp-Source: AGHT+IGThkxvDZFZ6Z05gGW4SMtUvTvaE1ncpL6Mje7dRaNolz971BGT8ShglhaT3UJiOUMvTWAg2g==
X-Received: by 2002:a50:cd4c:0:b0:566:13a2:3008 with SMTP id
 d12-20020a50cd4c000000b0056613a23008mr7094752edj.6.1711454625933; 
 Tue, 26 Mar 2024 05:03:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 cx10-20020a05640222aa00b0056bb1b017besm4065490edb.23.2024.03.26.05.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:03:45 -0700 (PDT)
Message-ID: <0a772baa-73fc-4095-88fb-1dca14d29463@linaro.org>
Date: Tue, 26 Mar 2024 13:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
 <9eb2194e-7efe-448a-a511-9d10e589943e@linaro.org>
 <c0bdb1f6-b456-4378-a2ee-b2355ad5bb42@linaro.org>
 <CAFEAcA_0j0HZ16MqR1QtPJPx7xFGJPbW7=Zgo-wHzhpZHRiMCg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_0j0HZ16MqR1QtPJPx7xFGJPbW7=Zgo-wHzhpZHRiMCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 26/3/24 11:33, Peter Maydell wrote:
> On Tue, 26 Mar 2024 at 09:54, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 26/3/24 04:33, Pierrick Bouvier wrote:
>>> On 3/26/24 05:52, Yao Xingtao wrote:
>>>> 1. The g_pattern_match_string() is deprecated when glib2 version >= 2.70.
>>>>      Use g_pattern_spec_match_string() instead to avoid this problem.
>>>>
>>>> 2. The type of second parameter in g_ptr_array_add() is
>>>>      'gpointer' {aka 'void *'}, but the type of reg->name is 'const
>>>> char*'.
>>>>      Cast the type of reg->name to 'gpointer' to avoid this problem.
>>>>
>>>> compiler warning message:
>>>> /root/qemu/contrib/plugins/execlog.c:330:17: warning:
>>>> ‘g_pattern_match_string’
>>>> is deprecated: Use 'g_pattern_spec_match_string'
>>>> instead [-Wdeprecated-declarations]
>>>>     330 |                 if (g_pattern_match_string(pat, rd->name) ||
>>>>         |                 ^~
>>>> In file included from /usr/include/glib-2.0/glib.h:67,
>>>>                    from /root/qemu/contrib/plugins/execlog.c:9:
>>>> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
>>>>      57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>>>>         |               ^~~~~~~~~~~~~~~~~~~~~~
>>>> /root/qemu/contrib/plugins/execlog.c:331:21: warning:
>>>> ‘g_pattern_match_string’
>>>> is deprecated: Use 'g_pattern_spec_match_string'
>>>> instead [-Wdeprecated-declarations]
>>>>     331 |                     g_pattern_match_string(pat, rd_lower)) {
>>>>         |                     ^~~~~~~~~~~~~~~~~~~~~~
>>>> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
>>>>      57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>>>>         |               ^~~~~~~~~~~~~~~~~~~~~~
>>>> /root/qemu/contrib/plugins/execlog.c:339:63: warning: passing argument
>>>> 2 of
>>>> ‘g_ptr_array_add’ discards ‘const’ qualifier from pointer target type
>>>> [-Wdiscarded-qualifiers]
>>>>     339 |                             g_ptr_array_add(all_reg_names,
>>>> reg->name);
>>>>         |
>>>> ~~~^~~~~~
>>>> In file included from /usr/include/glib-2.0/glib.h:33:
>>>> /usr/include/glib-2.0/glib/garray.h:198:62: note: expected
>>>> ‘gpointer’ {aka ‘void *’} but argument is of type ‘const char *’
>>>>     198 |                                            gpointer
>>>> data);
>>>>         |
>>>> ~~~~~~~~~~~~~~~~~~^~~~
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2210
>>>> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>>>> ---
>>>>    contrib/plugins/execlog.c | 24 +++++++++++++++++++++---
>>>>    1 file changed, 21 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>>>> index a1dfd59ab7..fab18113d4 100644
>>>> --- a/contrib/plugins/execlog.c
>>>> +++ b/contrib/plugins/execlog.c
>>>> @@ -311,6 +311,24 @@ static Register
>>>> *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
>>>>        return reg;
>>>>    }
>>>> +/*
>>>> + * g_pattern_match_string has been deprecated in Glib since 2.70 and
>>>> + * will complain about it if you try to use it. Fortunately the
>>>> + * signature of both functions is the same making it easy to work
>>>> + * around.
>>>> + */
>>>> +static inline
>>>> +gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
>>>> +                                          const gchar *string)
>>>> +{
>>>> +#if GLIB_CHECK_VERSION(2, 70, 0)
>>>> +    return g_pattern_spec_match_string(pspec, string);
>>>> +#else
>>>> +    return g_pattern_match_string(pspec, string);
>>>> +#endif
>>>> +};
>>>> +#define g_pattern_spec_match_string(p, s)
>>>> g_pattern_spec_match_string_qemu(p, s)
>>>> +
>>>>    static GPtrArray *registers_init(int vcpu_index)
>>>>    {
>>>>        g_autoptr(GPtrArray) registers = g_ptr_array_new();
>>>> @@ -327,8 +345,8 @@ static GPtrArray *registers_init(int vcpu_index)
>>>>                for (int p = 0; p < rmatches->len; p++) {
>>>>                    g_autoptr(GPatternSpec) pat =
>>>> g_pattern_spec_new(rmatches->pdata[p]);
>>>>                    g_autofree gchar *rd_lower =
>>>> g_utf8_strdown(rd->name, -1);
>>>> -                if (g_pattern_match_string(pat, rd->name) ||
>>>> -                    g_pattern_match_string(pat, rd_lower)) {
>>>> +                if (g_pattern_spec_match_string(pat, rd->name) ||
>>>> +                    g_pattern_spec_match_string(pat, rd_lower)) {
>>>>                        Register *reg = init_vcpu_register(rd);
>>>>                        g_ptr_array_add(registers, reg);
>>>> @@ -336,7 +354,7 @@ static GPtrArray *registers_init(int vcpu_index)
>>>>                        if (disas_assist) {
>>>>                            g_mutex_lock(&add_reg_name_lock);
>>>>                            if (!g_ptr_array_find(all_reg_names,
>>>> reg->name, NULL)) {
>>>> -                            g_ptr_array_add(all_reg_names, reg->name);
>>>> +                            g_ptr_array_add(all_reg_names,
>>>> (gpointer)reg->name);
>>>>                            }
>>>>                            g_mutex_unlock(&add_reg_name_lock);
>>>>                        }
>>>
>>> Would be nice if it's still possible to merge this in 9.0 Peter.
>>
>> I will post a small PR later today, so until Peter has something
>> else planned, I can take it, since the patch LGTM now.
> 
> That would be great (I don't have any more patches I wanted
> to put in a PR).
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

OK, patch queued then.

Yao, for your future contributions, please post patch iterations
as new thread rather than replying to previous versions. You can
see tips here:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches
in particular:

   Patches are easier to find if they start a new top-level thread,
   rather than being buried in-reply-to another existing thread.

Regards,

Phil.


