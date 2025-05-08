Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A00C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7ll-0007C2-6D; Thu, 08 May 2025 16:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7lk-0007Bg-1X
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:23:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7lh-0005Sz-VB
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:22:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74019695377so1151481b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746735776; x=1747340576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h/Fpz5iRvnV2shypmS9afxZR4b5uhoMhJf/Iz4E4tlE=;
 b=cFORUN+PAMJAzKxskp1W2hJ34xj+ykVPvQE7ad2GyYoMfBGUtzi02bUagNZAGuPR6e
 DQ1G7cBW4TvpORZYPJ5r8+2IZPxZcYS4DaMBkb3gylosQL7CRS99K5VxJIivd+zgWFia
 EwdfLiJ2UVtj3hvqbtJ17jFurW6fj2dSuhtaSvjJAY0iAEZRQwsTWx32DXB6v/bs1tRi
 5AFTlP1VjNI87ZXq6qSvGkIrHNvWmTmUUmwrq5AN0Vs21SdmSgk9JP/PPAL1W6F2CP1e
 sHeJAElqFJPKeWlwAv6ad547kH0h3QDZuCfiXEhCFTSt1fjUpERs+D97oeFNxolg6r1H
 T/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746735776; x=1747340576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h/Fpz5iRvnV2shypmS9afxZR4b5uhoMhJf/Iz4E4tlE=;
 b=G0JOH+lv1+j5QM4Ak8l4umICEFIXtvYRcxgRSf8mIol1url5Y7UUk0btg3AHS7CYIW
 SnPZMDgXWmyrBAfqtlruUw9jSU91sxXHC/DXMdXEqUdcY+6gYco5ocT7tD71+4IlAbSM
 baJx4YQ3C+yNC4nxkTHaRinCtUVa7vVS5BX7v2WHrKchwsj4DyPMibIwCfhRRfzEtVu4
 Fq9YNb560anUEAD62gLlMBKReinpK1lbO6C6ARvZEC47hKt60Nf8pcrL/7a6yzNmX7So
 AOhoNDE2nKjVLJTUonjq05LJW1EISn+/u5wP5SzBtPXeegRiVfhq+T0H/kYEnDC8KcEu
 /Hpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuykVmt79YoFvPJzdUOT4JNPW7SWEFoeJ5LjOdl47iq1q5WPBJbe+V1YfOhh6aQkpwqWXpLz4kSRcJ@nongnu.org
X-Gm-Message-State: AOJu0YwtT7rwEJpgvh6HeRFD0IOWAX0vsvwyOpk7G8ffkgZFImIK81TC
 G7gubckVlfSQ8asiWPx+nJfw++SbMKBEiBA3fGXQ9iyznidrwOqk5IxTpf8n0tE=
X-Gm-Gg: ASbGncsq7GFd+QIXDshbBjqkRVIMvMVFSKtJNEfPn6L7YixtqtU7YqHV1986tdNdEtZ
 VqJCLQJ2EcdWWhRSwKJOwBH8UfnNBxHuHX1tIXg0NDDmT7FKj5+foZIE7+ScsIzF+Pzgv5/XKO+
 4TsXoD1IdOZB6ezCEDR1FZFNv+IBl+KeX/3Vs1V5PiyJdRsi38D1PquEkzv5qpR7gKC60WNDr8Q
 WANXcccsESqKGq7ELrDT5LkoVU7mvV8DAMAiSbhDwxS+m25b+ZAo3X21ZH0YJlpyRhQgc1PZAqd
 85MtKr9DNS0f3bszPtGH4gdDm579PSgF17jDFY7GUIzKDhTeN++TBg==
X-Google-Smtp-Source: AGHT+IF4EKvleeghSQQohUhXvMRcTWasa8XlmE/AVw9klUg7Kb4PEoZXawRAaFDghsVG/G7Ccj/jDg==
X-Received: by 2002:a05:6a00:1491:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-7423c054173mr914666b3a.20.1746735776303; 
 Thu, 08 May 2025 13:22:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7423772832csm466068b3a.59.2025.05.08.13.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 13:22:55 -0700 (PDT)
Message-ID: <06c8edb6-ce97-40a4-9124-7b7134cbb3b7@linaro.org>
Date: Thu, 8 May 2025 13:22:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qapi: introduce 'runtime_if' for QAPI json
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-2-pierrick.bouvier@linaro.org>
 <5fe18831-d9b8-4c64-883d-17b9c600ca61@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5fe18831-d9b8-4c64-883d-17b9c600ca61@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/7/25 11:53 PM, Philippe Mathieu-Daudé wrote:
> On 8/5/25 01:14, Pierrick Bouvier wrote:
>> This new entry can be used in QAPI json to specify a runtime conditional
>> to expose any entry, similar to existing 'if', that applies at compile
>> time, thanks to ifdef. The element is always defined in C, but not
>> exposed through the schema and visit functions, thus being hidden for a
>> QMP consumer.
>>
>> QAPISchemaIfCond is extended to parse this information. A first version
>> was tried duplicating this, but this proved to be much more boilerplate
>> than needed to pass information through all function calls.
>>
>> 'if' and 'runtime_if' can be combined elegantly on a single item,
>> allowing to restrict an element to be present based on compile time
>> defines, and runtime checks at the same time.
>>
>> Note: This commit only adds parsing of runtime_if, and does not hide
>> anything yet.
>>
>> For review:
>>
>> - I don't really like "runtime_if" name.
>>     What would make sense, IMHO, is to rename existing 'if' to 'ifdef',
>>     and reuse 'if' for 'runtime_if'. Since it requires invasive changes, I
>>     would prefer to get agreement before wasting time in case you prefer
>>     any other naming convention. Let me know what you'd like.
> 
> Or rename 'if' as 'buildtime_if'. /s!
> 

I'll let Markus do the bikeshed as he's the maintainer and the one who 
may finally (or not) merge this.

>>
>> - As mentioned in second paragraph, I think our best implementation
>>     would be to extend existing QAPISchemaIfCond, as it's really
>>     complicated to extend all call sites if we have another new object.
>>
>> - No tests/doc added at this time, as I prefer to wait that we decide
>>     about naming and proposed approach first.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    scripts/qapi/common.py | 16 +++++++++++-
>>    scripts/qapi/expr.py   |  9 ++++---
>>    scripts/qapi/gen.py    | 56 +++++++++++++++++++++++++++++++++++++++++-
>>    scripts/qapi/schema.py | 44 ++++++++++++++++++++++++---------
>>    4 files changed, 107 insertions(+), 18 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index d7c8aa3365c..0e8e2abeb58 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -229,6 +229,8 @@ def gen_infix(operator: str, operands: Sequence[Any]) -> str:
>>    def cgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
>>        return gen_ifcond(ifcond, 'defined(%s)', '!%s', ' && ', ' || ')
>>    
>> +def cgen_runtime_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
>> +    return gen_ifcond(ifcond, '%s', '!%s', ' && ', ' || ')
>>    
>>    def docgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
>>        # TODO Doc generated for conditions needs polish
>> @@ -242,7 +244,6 @@ def gen_if(cond: str) -> str:
>>    #if %(cond)s
>>    ''', cond=cond)
>>    
>> -
>>    def gen_endif(cond: str) -> str:
>>        if not cond:
>>            return ''
>> @@ -250,6 +251,19 @@ def gen_endif(cond: str) -> str:
>>    #endif /* %(cond)s */
>>    ''', cond=cond)
>>    
>> +def gen_runtime_if(cond: str) -> str:
>> +    if not cond:
>> +        return ''
>> +    return mcgen('''
>> +if (%(cond)s) {
>> +''', cond=cond)
>> +
>> +def gen_runtime_endif(cond: str) -> str:
>> +    if not cond:
>> +        return ''
>> +    return mcgen('''
>> +} /* (%(cond)s) */
> 
> No need for extra parenthesis in comment:
> 
>     +} /* %(cond)s */
> 
>> +''', cond=cond)
>>    
>>    def must_match(pattern: str, string: str) -> Match[str]:
>>        match = re.match(pattern, string)
>> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
>> index cae0a083591..5ae26395964 100644
>> --- a/scripts/qapi/expr.py
>> +++ b/scripts/qapi/expr.py
>> @@ -392,7 +392,8 @@ def check_type_implicit(value: Optional[object],
>>                             permit_underscore=permissive)
>>            if c_name(key, False) == 'u' or c_name(key, False).startswith('has_'):
>>                raise QAPISemError(info, "%s uses reserved name" % key_source)
>> -        check_keys(arg, info, key_source, ['type'], ['if', 'features'])
>> +        check_keys(arg, info, key_source, ['type'], ['if', 'features',
>> +                                                     'runtime_if'])
>>            check_if(arg, info, key_source)
>>            check_features(arg.get('features'), info)
>>            check_type_name_or_array(arg['type'], info, key_source)
>> @@ -642,7 +643,7 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
>>            elif meta == 'union':
>>                check_keys(expr, info, meta,
>>                           ['union', 'base', 'discriminator', 'data'],
>> -                       ['if', 'features'])
>> +                       ['if', 'runtime_if', 'features'])
>>                normalize_members(expr.get('base'))
>>                normalize_members(expr['data'])
>>                check_union(expr)
>> @@ -659,8 +660,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
>>            elif meta == 'command':
>>                check_keys(expr, info, meta,
>>                           ['command'],
>> -                       ['data', 'returns', 'boxed', 'if', 'features',
>> -                        'gen', 'success-response', 'allow-oob',
>> +                       ['data', 'returns', 'boxed', 'if', 'runtime_if',
>> +                        'features', 'gen', 'success-response', 'allow-oob',
>>                            'allow-preconfig', 'coroutine'])
>>                normalize_members(expr.get('data'))
>>                check_command(expr)
> 
> Why can't we merge here the changes from patch 9?
> 

Oops, that's a rebase mistake, thanks. It belongs here indeed.

> -- >8 --
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 5ae26395964..f31f28ecb10 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -638,7 +638,8 @@ def check_exprs(exprs: List[QAPIExpression]) ->
> List[QAPIExpression]:
> 
>            if meta == 'enum':
>                check_keys(expr, info, meta,
> -                       ['enum', 'data'], ['if', 'features', 'prefix'])
> +                       ['enum', 'data'], ['if', 'runtime_if', 'features',
> +                                          'prefix'])
>                check_enum(expr)
>            elif meta == 'union':
>                check_keys(expr, info, meta,
> @@ -654,7 +655,8 @@ def check_exprs(exprs: List[QAPIExpression]) ->
> List[QAPIExpression]:
>                check_alternate(expr)
>            elif meta == 'struct':
>                check_keys(expr, info, meta,
> -                       ['struct', 'data'], ['base', 'if', 'features'])
> +                       ['struct', 'data'], ['base', 'if', 'runtime_if',
> +                                            'features'])
>                normalize_members(expr['data'])
>                check_struct(expr)
>            elif meta == 'command':
> @@ -667,7 +669,8 @@ def check_exprs(exprs: List[QAPIExpression]) ->
> List[QAPIExpression]:
>                check_command(expr)
>            elif meta == 'event':
>                check_keys(expr, info, meta,
> -                       ['event'], ['data', 'boxed', 'if', 'features'])
> +                       ['event'], ['data', 'boxed', 'if', 'runtime_if',
> +                                   'features'])
>                normalize_members(expr.get('data'))
>                check_event(expr)
>            else:
> ---
> 
> Otherwise, patch LGTM :)


