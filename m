Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 18:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2b3r-0005PA-OA; Thu, 02 May 2024 14:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2b3j-0005Ko-Vz
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:21:37 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2b3f-0005t2-FB
 for qemu-devel@nongnu.org; Thu, 02 May 2024 14:21:28 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f447976de7so343212b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714674080; x=1715278880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9SdjpnexvPIB/MuPJgdCQOg0z+AiWEjxx0UmMJVtMxY=;
 b=kOIk3Yc1VJ8jgxBAzUH8O8XuQbMj/8TIKJbHjzMdwguFcIJMfZXIyGS7tSPWWeqZCy
 uLqj9C4RkpnBENvIrQlTTg8i7yOSeNLG0UkhWqaVgwwjpbAluLNoffcA3naESvVYC7eC
 d1vkN4PuKkGxhM21YZsbHI+bvcOcvnpPzSsU7thSYtn0oBmKPPhcE/QZccoCKdSRCTL4
 XyE+OdUonpf8860mW1BOjMTNKm+Erg7/ph845sSymIKLvHOBGxyvrP+XV/O/YOXoEink
 VLlV9vcFvfCCNkTSTRSx8Aq9HVhNfBuw5gIIZ6QMIhO30jTBlDjzVjHjua6uSW9wYHJ+
 omCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714674080; x=1715278880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9SdjpnexvPIB/MuPJgdCQOg0z+AiWEjxx0UmMJVtMxY=;
 b=WxxEWiy4jl+Rvl2Rs5zcSYuvZRk7918AnXqHbIIIqRWIdpqrWdYr8JjLvYtyXWzlRQ
 pXy8MQA2h8Wpyg6Xf1nuSt88zbnboYm3jk8P5gjiO56p2CqP3RVs6TLPwm5WDGaUHnJe
 fl9LXWano2xV1WNk2km297KRn7E3n7evPvse48g6l7wyx+isfVNnisFsCUXIq/L5foxK
 GCA5tYJ4RY1I73AghN0XPv4RSuUT55GrwpRmRVCuhEFxg+D7tO08ELXemjQvWm24nGyv
 Ta5lmrJa5fmnJ8RKnMWrvqbpW9VmpJHCyz+rkO+6MG3XTxhiBLkjYM/FnUc/D6HTPUGb
 b0oQ==
X-Gm-Message-State: AOJu0YzfzALy+9BOTv46Q/aPtusj95jFi8kSMVFalTf6TTPoO2obVW4K
 6U1Y7V2CRnrCdlJ+zmraPwkeyHyWQMwvKjcYWqM/FrARwcHhgXuzUb36fXEL5qKQ5kn9TqQacxj
 Hx+k=
X-Google-Smtp-Source: AGHT+IHLbKFChnRSxmcCC/8d1RSLzmQe/IGIQmylHPHddFhak16K4vW0vL2IhE3dpZTFw27rb3HtEw==
X-Received: by 2002:a05:6a20:9f8b:b0:1ad:7e4d:5b81 with SMTP id
 mm11-20020a056a209f8b00b001ad7e4d5b81mr607992pzb.5.1714674080334; 
 Thu, 02 May 2024 11:21:20 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::ecd0? ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a056a00245100b006e71aec34a8sm1560023pfj.167.2024.05.02.11.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 11:21:19 -0700 (PDT)
Message-ID: <2db9cb71-044d-4a84-b677-f240aec679eb@linaro.org>
Date: Thu, 2 May 2024 11:21:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] TCG plugins new inline operations
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Contrary to what the cover letter says, all patches have been reviewed 
in the series since v4.

On 5/2/24 11:08, Pierrick Bouvier wrote:
> This series implement two new operations for plugins:
> - Store inline allows to write a specific value to a scoreboard.
> - Conditional callback executes a callback only when a given condition is true.
>    The condition is evaluated inline.
> 
> It's possible to mix various inline operations (add, store) with conditional
> callbacks, allowing efficient "trap" based counters.
> 
> It builds on top of new scoreboard API, introduced in the previous series.
> 
> NOTE: Two patches still need review
> 
> v2
> --
> 
> - fixed issue with udata not being passed to conditional callback
> - added specific test for this in tests/plugin/inline.c (udata was NULL before).
> 
> v3
> --
> 
> - rebased on top of "plugins: Rewrite plugin code generation":
>    20240316015720.3661236-1-richard.henderson@linaro.org
> - single pass code generation
> - small cleanups for code generation
> 
> v4
> --
> 
> - remove op field from qemu_plugin_inline_cb
> - use tcg_constant_i64 to load immediate value to store
> 
> v5
> --
> 
> - rebase on top of master now that Richard's series was merged
> 
> Pierrick Bouvier (9):
>    plugins: prepare introduction of new inline ops
>    plugins: extract generate ptr for qemu_plugin_u64
>    plugins: add new inline op STORE_U64
>    tests/plugin/inline: add test for STORE_U64 inline op
>    plugins: conditional callbacks
>    tests/plugin/inline: add test for conditional callback
>    plugins: distinct types for callbacks
>    plugins: extract cpu_index generate
>    plugins: remove op from qemu_plugin_inline_cb
> 
>   include/qemu/plugin.h        |  42 +++++++----
>   include/qemu/qemu-plugin.h   |  80 ++++++++++++++++++++-
>   plugins/plugin.h             |  12 +++-
>   accel/tcg/plugin-gen.c       | 136 +++++++++++++++++++++++++++--------
>   plugins/api.c                |  39 ++++++++++
>   plugins/core.c               | 109 ++++++++++++++++++++--------
>   tests/plugin/inline.c        | 130 +++++++++++++++++++++++++++++++--
>   plugins/qemu-plugins.symbols |   2 +
>   8 files changed, 466 insertions(+), 84 deletions(-)
> 

