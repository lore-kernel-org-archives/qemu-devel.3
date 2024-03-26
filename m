Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB4DCD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3WK-0006t0-R2; Tue, 26 Mar 2024 05:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3WJ-0006sh-FF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:55:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3WH-0006a6-Aq
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:55:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34175878e30so3783646f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711446899; x=1712051699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=19rZZLrivxa4jqNDHVvWKoJbD5zRGJZWuCL/ZYv5X9I=;
 b=J9z0yjL7yXCOaWcJtmMVJ9UXIKVKB8LHe3YvC5/g0LUI/dVie3ONx81ucVF3ojicX3
 lb+40HnR5HK8tFT1R5bz3bHQCP0PKwOHOHpYU1dvrtn/gVVlED1WYL4RJBUEExDMcMPw
 TV3O7WLkdYk4pom+juLROOMiJSfl9UCxLxOinwkR/RzHhurSbLG6KCQOFyWJj36SpEPT
 r/r64Q2ihmnV9jfn0R5c48gFBEc4CWfQv3MyyWCIXgQ0MUVM8JRDow+m3qErko3ZRoZ/
 AS9FkZipwWK7sbtPrDbHH6EE9WexNLowH+t/gixAEYHG5LMX7eXPLMoOHNsK6KupbDnH
 1pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711446899; x=1712051699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19rZZLrivxa4jqNDHVvWKoJbD5zRGJZWuCL/ZYv5X9I=;
 b=NH9SFm2YgcWGC6l4I8vZrhi6PnCeT5qGAO4JNMQD6nO0C5dcanMLuHPNvqbapS33AU
 3QkQ3AWkNkHjLex2FC99IUG+YAiJHC9OOTWRHZyQXTKNhfLvuLepcGMyDnJuYUVA6WYX
 X91HwmG6y0hHOJk95GHpm0ayjcMbSVmEM9KWHNre2/H/WORjs1ThwqJJ+H+50sIIV6dp
 /rRpEY7EtZGOALlaSGUXL/SDj2sNrS2aOY8DqzNKJT15tmxIOiQ85z75NE8pXkw1MQY2
 0gANhZlU2yJkM/xxw6Any9cT7MCgbo7YB3+22xkD3AcanPVo6dRloHW2rLhntmXTu5To
 YTbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtZW3bcJxNabn44Q0lpWRi/XEDImWveI0Sa3FjEdNeaMHoxMRDKlaiYgotfbLIFwBtHySmg5OSEy8P2ycwOSmk3AWRAos=
X-Gm-Message-State: AOJu0Yxdj2dvZu44EleBnegDUUyVfGN+/eCxLAq+pemy4egscRN92MJd
 uH2MX2+50NKNIobqmAVkJowTPL7AqnuVimKLCZBhptGEW+GMOtPxih4G3tOhiAU=
X-Google-Smtp-Source: AGHT+IH3RANrclwg3H+gWu50fGFZaGCzzasESLc3G0LmFHNSJofbjUX+lpLgX9rfB9yz96Iyy1FrIg==
X-Received: by 2002:a5d:4d03:0:b0:33e:c070:9574 with SMTP id
 z3-20020a5d4d03000000b0033ec0709574mr7140173wrt.20.1711446899114; 
 Tue, 26 Mar 2024 02:54:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b0041462294fe3sm11043010wmo.42.2024.03.26.02.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 02:54:58 -0700 (PDT)
Message-ID: <c0bdb1f6-b456-4378-a2ee-b2355ad5bb42@linaro.org>
Date: Tue, 26 Mar 2024 10:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 peter.maydell@linaro.org
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
 <9eb2194e-7efe-448a-a511-9d10e589943e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9eb2194e-7efe-448a-a511-9d10e589943e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 26/3/24 04:33, Pierrick Bouvier wrote:
> On 3/26/24 05:52, Yao Xingtao wrote:
>> 1. The g_pattern_match_string() is deprecated when glib2 version >= 2.70.
>>     Use g_pattern_spec_match_string() instead to avoid this problem.
>>
>> 2. The type of second parameter in g_ptr_array_add() is
>>     'gpointer' {aka 'void *'}, but the type of reg->name is 'const 
>> char*'.
>>     Cast the type of reg->name to 'gpointer' to avoid this problem.
>>
>> compiler warning message:
>> /root/qemu/contrib/plugins/execlog.c:330:17: warning: 
>> ‘g_pattern_match_string’
>> is deprecated: Use 'g_pattern_spec_match_string'
>> instead [-Wdeprecated-declarations]
>>    330 |                 if (g_pattern_match_string(pat, rd->name) ||
>>        |                 ^~
>> In file included from /usr/include/glib-2.0/glib.h:67,
>>                   from /root/qemu/contrib/plugins/execlog.c:9:
>> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
>>     57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>>        |               ^~~~~~~~~~~~~~~~~~~~~~
>> /root/qemu/contrib/plugins/execlog.c:331:21: warning: 
>> ‘g_pattern_match_string’
>> is deprecated: Use 'g_pattern_spec_match_string'
>> instead [-Wdeprecated-declarations]
>>    331 |                     g_pattern_match_string(pat, rd_lower)) {
>>        |                     ^~~~~~~~~~~~~~~~~~~~~~
>> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
>>     57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>>        |               ^~~~~~~~~~~~~~~~~~~~~~
>> /root/qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 
>> 2 of
>> ‘g_ptr_array_add’ discards ‘const’ qualifier from pointer target type
>> [-Wdiscarded-qualifiers]
>>    339 |                             g_ptr_array_add(all_reg_names, 
>> reg->name);
>>        |                                                            
>> ~~~^~~~~~
>> In file included from /usr/include/glib-2.0/glib.h:33:
>> /usr/include/glib-2.0/glib/garray.h:198:62: note: expected
>> ‘gpointer’ {aka ‘void *’} but argument is of type ‘const char *’
>>    198 |                                            gpointer          
>> data);
>>        |                                            
>> ~~~~~~~~~~~~~~~~~~^~~~
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2210
>> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>> ---
>>   contrib/plugins/execlog.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>> index a1dfd59ab7..fab18113d4 100644
>> --- a/contrib/plugins/execlog.c
>> +++ b/contrib/plugins/execlog.c
>> @@ -311,6 +311,24 @@ static Register 
>> *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
>>       return reg;
>>   }
>> +/*
>> + * g_pattern_match_string has been deprecated in Glib since 2.70 and
>> + * will complain about it if you try to use it. Fortunately the
>> + * signature of both functions is the same making it easy to work
>> + * around.
>> + */
>> +static inline
>> +gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
>> +                                          const gchar *string)
>> +{
>> +#if GLIB_CHECK_VERSION(2, 70, 0)
>> +    return g_pattern_spec_match_string(pspec, string);
>> +#else
>> +    return g_pattern_match_string(pspec, string);
>> +#endif
>> +};
>> +#define g_pattern_spec_match_string(p, s) 
>> g_pattern_spec_match_string_qemu(p, s)
>> +
>>   static GPtrArray *registers_init(int vcpu_index)
>>   {
>>       g_autoptr(GPtrArray) registers = g_ptr_array_new();
>> @@ -327,8 +345,8 @@ static GPtrArray *registers_init(int vcpu_index)
>>               for (int p = 0; p < rmatches->len; p++) {
>>                   g_autoptr(GPatternSpec) pat = 
>> g_pattern_spec_new(rmatches->pdata[p]);
>>                   g_autofree gchar *rd_lower = 
>> g_utf8_strdown(rd->name, -1);
>> -                if (g_pattern_match_string(pat, rd->name) ||
>> -                    g_pattern_match_string(pat, rd_lower)) {
>> +                if (g_pattern_spec_match_string(pat, rd->name) ||
>> +                    g_pattern_spec_match_string(pat, rd_lower)) {
>>                       Register *reg = init_vcpu_register(rd);
>>                       g_ptr_array_add(registers, reg);
>> @@ -336,7 +354,7 @@ static GPtrArray *registers_init(int vcpu_index)
>>                       if (disas_assist) {
>>                           g_mutex_lock(&add_reg_name_lock);
>>                           if (!g_ptr_array_find(all_reg_names, 
>> reg->name, NULL)) {
>> -                            g_ptr_array_add(all_reg_names, reg->name);
>> +                            g_ptr_array_add(all_reg_names, 
>> (gpointer)reg->name);
>>                           }
>>                           g_mutex_unlock(&add_reg_name_lock);
>>                       }
> 
> Would be nice if it's still possible to merge this in 9.0 Peter.

I will post a small PR later today, so until Peter has something
else planned, I can take it, since the patch LGTM now.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


