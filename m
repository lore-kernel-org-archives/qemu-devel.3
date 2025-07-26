Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B112C87FCE
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTlM-0007xN-IL; Fri, 25 Jul 2025 21:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufTlL-0007wa-7F
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:31:47 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufTlJ-0001kj-At
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:31:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7600271f3e9so2448158b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753493503; x=1754098303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SVZLMS/UMMZR1fzVxFIStIsyvy+r4/EmamX85F3eeTY=;
 b=fYx/sUTdWP0lXy51qavD3Znl7QUdG1P3dUmPA1CxBycpQ3OPCA5ir0oCTVz5uQpKjj
 HVRxLnGPpAMVV9Kch3wSAQh49qXXl4HAfuwFLVHIVoKJXBxlTHLWAjCZ2asovuKb5IEf
 sVDjKL7ohogXhXb2leQZ8o9aLCPqVFCBggFjR/AimDo5mtL1NJaY31htSyRcs/p3VD+7
 dXhrrsWd4CaOhH3Yb0q9qTTE/DJBtIyg7DExtCyruIsGdpufznEVdLn2sY+IN3Qdbm0u
 0l9mYuMeJxBlWXCdB5e6TtqeK7fu+7YwvXL4YPeiA6G+vZETxS7+VbkXrU85bgaCDb6j
 lXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753493503; x=1754098303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVZLMS/UMMZR1fzVxFIStIsyvy+r4/EmamX85F3eeTY=;
 b=dhmW92KARYinWW/NlLam5JtPtiF2wtImNn0d4nniP2wcyqtVRnfyxghJUhqT6z6DN+
 eY2XtLMr32f1jDWeWpKKcH/Jcx7YGgiKvP5ZioIO7nTJV1TWEGkUWHbf5Da7TJDBI+Dm
 OUmjs+h6jxP6++U12crAW8vLw6RK//MjXmaagVvLrA6TxB1IxDS/DuSlvZEvAN0Qc7b+
 7YYkLRida7aL/5VIY885ElcAsPyGJ5AXqITU/waYHUcZuvfwdCZuc55lVZOgMdkMi1Cz
 RUCSRE3EKZWxhTFEVmu3dqWnn2DEZAKwuv2sAXGGG81fjL2NgBnBkEF00QzODZxkHQwH
 SQfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlUBqTXdtsi8LlP+1pP77tRzLHSv5bjNy3oy/Om2wzAF/J+uPqZLxcmQ83FeOzl0MLMNvvByq3b52r@nongnu.org
X-Gm-Message-State: AOJu0YyVLQg8DzDIzkoZU0pGw4xgWJhgBW5P3UXAxqxaZ+0NIQqwQAlm
 S6E97FlVJrgyIca6oqwuryRUWluDNyhcfs65P8p1frmTMb9VxGUN3V0MvMI3d41RHKk=
X-Gm-Gg: ASbGnct7BFUWPcND2EdLckcZO+7l/75Sj+0Ff/Gsiamo0pAdQ8rmqHTL1kqzuCZjBED
 covNuCliu45TBvaBIC+5651NJu47XgosX0O25VOFj4mz8Y9qjjAwhK/Lp9HsBtQKeJ+kSmwE9LJ
 jVrdN8X21puskcM+6LPtz+6aZ6T3SHpHwFCG6MvasH0ikbrQ+/4Im0v+KaWUd6ynHtDswwq+L8w
 rfQWT5HHp8sr145t7Zs+rFUff1a+16mDkth7NXuzy6tOvqcIY1AJoP8/Mnd0AuFD0NVp0uZS9kU
 7JnuYr0m8igdwvlAVVZCoSXVK/MNtLngxL6Arh6aAPSMDUqM9k5oVPR+T7m0wJUFCa8w5Lyvqkx
 ye37ApREcu73zq37FVgziJY1bRIuFOxBb3CI=
X-Google-Smtp-Source: AGHT+IFBOSVTqUFHBPlCQOYUcDrDt9A27RgccF8IXC/fIbNDvBrsp3e72akx7EQU2dTJMKK6KloPQw==
X-Received: by 2002:a05:6a00:3393:b0:742:b928:59cb with SMTP id
 d2e1a72fcca58-761f08bfe55mr11549115b3a.7.1753493503066; 
 Fri, 25 Jul 2025 18:31:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad067cbsm657973b3a.81.2025.07.25.18.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:31:42 -0700 (PDT)
Message-ID: <68586372-a1a8-4a78-bfdb-2d7f8bfef19a@linaro.org>
Date: Fri, 25 Jul 2025 18:31:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/main.c: compile only once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
 <20250725202016.21325-4-pierrick.bouvier@linaro.org>
 <d9fbdd83-599d-4cd2-a98f-6e43f902527d@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d9fbdd83-599d-4cd2-a98f-6e43f902527d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/25/25 1:44 PM, Richard Henderson wrote:
> On 7/25/25 10:20, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build        | 5 ++---
>>    system/meson.build | 1 +
>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 71c253ba135..7718983951e 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4437,14 +4437,14 @@ foreach target : target_dirs
>>        execs = [{
>>          'name': 'qemu-system-' + target_name,
>>          'win_subsystem': 'console',
>> -      'sources': files('system/main.c'),
>> +      'sources': [],
>>          'dependencies': [sdl]
>>        }]
>>        if host_os == 'windows' and (sdl.found() or gtk.found())
>>          execs += [{
>>            'name': 'qemu-system-' + target_name + 'w',
>>            'win_subsystem': 'windows',
>> -        'sources': files('system/main.c'),
>> +        'sources': [],
>>            'dependencies': [sdl]
>>          }]
>>        endif
>> @@ -4519,7 +4519,6 @@ foreach lib: single_binary_libs
>>      single_binary_objects += lib.extract_all_objects(recursive: true)
>>    endforeach
>>    executable('qemu-system',
>> -            sources: files('system/main.c'),
>>                objects: single_binary_objects,
>>                dependencies: single_binary_deps,
>>                link_depends: [block_syms, qemu_syms],
> 
> This series depends on stuff not upstream.  But anyway,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~

Oh right, sorry. Depends on the patch adding the single-binary, which we 
didn't upstream yet.
I'll hold this one a bit longer.

