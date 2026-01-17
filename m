Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F30C9830B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 00:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgtmL-0001zK-Gj; Fri, 16 Jan 2026 19:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgtmJ-0001yS-JI
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 19:02:55 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgtmH-0002aY-RW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 19:02:55 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34c7d0c5ddaso1516658a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 16:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768608172; x=1769212972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/sRihiugWw12vthN/9KraAvZdOSkdoqtFtCdh8h/GQ=;
 b=cBBe4cC0HRMxrX0xKoyEcbvGZWAMhl8fhwgVRFEjWCM83r8sgonMpklwTIQNEXDwVg
 WHuxbg+gYpMKgpnsUnfNzaaB/RBvEX/AEpxn09l90u5oIS8a0B/cdqE7VNuf+e7DBwmC
 iZ6aBDBK3+JQendSmYmpCXP/r11Wn7ErAOupKvMo7FGWKPqibEBIcqG/ajZhP7t8EV7G
 ugV4tEcXnKvZDEo1aK+wbCgPijqMLmex9Fs2/9/keAGQonmVpoWegutxozaESHF8W0Sd
 CnQ458J/ETxJsl//euqZXyhsNWMqcXDH6kI6uaw0xYJSdNfFKIfIvgynN04jyyywc6wr
 WvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768608172; x=1769212972;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/sRihiugWw12vthN/9KraAvZdOSkdoqtFtCdh8h/GQ=;
 b=aBiEKuT18OUufeNbwsJxTZitpxMIUIK/1Xmhb+YUEOiyqEnxm7hwqClWYGf5cnflr4
 j687zGPP2+IBWED+bv2O0zduxehr8O9OE4ueCSjErgE/EicbnBY64Ur1rY0Lnb+6pbbS
 Yq9Uk5M4eGWAJQyWbwcdF7oJdS9CpTLP63SHfdTB6UM8hmRU5r3n/HO4SdD/NwefTEjV
 h/FCdD4V8pzy/CEAWY/q1QY/z7lL/IFH77c/JNW6uGpZuSO8rZBM4bfjLjonlCrAJYNO
 2I6iyC2FGp3DU64BmS5/vm/amwcT8vOxOldd4Eo36ujYvDwhJzZqeKz3mFRzScENY+yO
 Zmcw==
X-Gm-Message-State: AOJu0Ywrt6bpapGNE2xmssTcz8OnsP5fAFZ/9r39wsQfpOWo9yChI5AJ
 JdSi8CDobbPzImhF7uaM1yii1iPeJq1exR89gcNSSb8bgr4ptFtzI+XBlP50R2kk4cY=
X-Gm-Gg: AY/fxX7B2gBjQhIcuAdhE0gS5xtJre4hCde6Hb6/ijNkovU6xp8xiF/p0FbNffRWEj9
 zsfemQN4iVf7Y+aPoAvl99ieTXX+VoZmImxwpbHoZsjmxQjqPFUUcx+EEGpDjr4du/5hIzauJih
 S0Nhho8cRwpXoiAD06UnU/nudCZd1UYZiEks9nEsgCXTq4y1TdgHoWPkyDIhNDT71lhgzdm07BG
 9GQfrr1WP+vf62qGi/xpXR57GF+08JqaZFtmLweBr1vlF1l4vEGcABFoAUlc4u8mTJNeogCafPk
 X7xUA6CYkDIBkDRpf6G8onv06/7SBJzYRP3o7qUFcBFk4QsjyFiI2RULcvvgGoyt8fFU5/oQixJ
 QwnXo2GuOEwkdqlJD3D3HuFv8LiJVrPtkCuhLRjZz4+06Lr1v4156oJwzlDqzspskQ8QOKqY73f
 CXLj53TjVx2a4Hu9aRVJtsaiEQcIng360RRO+xJCmukrU2lJNa4pJh1yKQXEhKcBuqIco=
X-Received: by 2002:a17:90b:2dd2:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-35272c8de28mr4391432a91.11.1768608171994; 
 Fri, 16 Jan 2026 16:02:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352733eac4fsm1470181a91.1.2026.01.16.16.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 16:02:51 -0800 (PST)
Message-ID: <fa736dbe-6a3b-4e17-87bc-39cae8d8e475@linaro.org>
Date: Fri, 16 Jan 2026 16:02:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] plugins: factorize plugin dependencies and
 library details
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-3-pierrick.bouvier@linaro.org>
 <aWotkyT7pmw3RKh8@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <aWotkyT7pmw3RKh8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/16/26 4:22 AM, Daniel P. Berrangé wrote:
> On Fri, Jan 02, 2026 at 01:47:15PM -0800, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   meson.build                   |  2 +-
>>   contrib/plugins/meson.build   | 13 ++-----------
>>   plugins/meson.build           | 15 ++++++++++++++-
>>   tests/tcg/plugins/meson.build | 13 ++-----------
>>   4 files changed, 19 insertions(+), 24 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index db87358d62d..3d6c6c702d0 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4499,7 +4499,7 @@ if get_option('plugins')
>>     if host_os == 'windows'
>>       # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
>>       # so that plugin authors can compile against it.
>> -    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
>> +    install_data(win32_qemu_plugin_api, install_dir: 'lib')
>>     endif
>>   endif
>>   
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> index 6f72b2ce0c9..8f9f0257ee5 100644
>> --- a/contrib/plugins/meson.build
>> +++ b/contrib/plugins/meson.build
>> @@ -9,17 +9,8 @@ endif
>>   t = []
>>   if get_option('plugins')
>>     foreach i : contrib_plugins
>> -    if host_os == 'windows'
>> -      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
>> -                        include_directories: '../../include/qemu',
>> -                        link_depends: [win32_qemu_plugin_api_lib],
>> -                        link_args: win32_qemu_plugin_api_link_flags,
>> -                        dependencies: glib)
>> -    else
>> -      t += shared_module(i, files(i + '.c'),
>> -                        include_directories: '../../include/qemu',
>> -                        dependencies: glib)
>> -    endif
>> +    t += shared_module(i, files(i + '.c'),
>> +                      dependencies: plugins_deps)
> 
> Nit-pick - under-indented by 1 space. The orignal code had the
> same bug, but lets not preserve it.
> 
> 
>> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
>> index a6e78438510..c58f2e382ae 100644
>> --- a/tests/tcg/plugins/meson.build
>> +++ b/tests/tcg/plugins/meson.build
>> @@ -1,17 +1,8 @@
>>   t = []
>>   if get_option('plugins')
>>     foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
>> -    if host_os == 'windows'
>> -      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
>> -                        include_directories: '../../../include/qemu',
>> -                        link_depends: [win32_qemu_plugin_api_lib],
>> -                        link_args: win32_qemu_plugin_api_link_flags,
>> -                        dependencies: glib)
>> -    else
>> -      t += shared_module(i, files(i + '.c'),
>> -                        include_directories: '../../../include/qemu',
>> -                        dependencies: glib)
>> -    endif
>> +    t += shared_module(i, files(i + '.c'),
>> +                      dependencies: plugins_deps)
> 
> Same under-indent by 1.
> 
> With the indents fixed:
> 
>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 

Patch 3 already fixes the indent.

> 
> 
> With regards,
> Daniel


