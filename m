Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308E4C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 10:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riXfo-0007WF-6g; Fri, 08 Mar 2024 05:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1riXfn-0007Vs-0m
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:41:55 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1riXfl-0002b4-9D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:41:54 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so282205066b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 02:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709894510; x=1710499310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jlA0XHaKUEAKha0j1a+S7Bo8scovzI02S0u/ITX8r/o=;
 b=XFd7hQwWzARst7ux94pJfs0HmMh3ao7CXLQMUBnsrlYt5OQhQ5Oq50bhKSvk5wmqsk
 ZB0QIJJr3lFoO6TZRhP7IMT0D8Zc01/MA7IsZYCLixu5FWZBvvjX61t9Oy+EcXAO3VRD
 AI7XsCxAMtnJaiAuR3pOr//RHZpMYxcbcAcu706EXZizwf10O/oWTxpDl2X8YDSx+Uzd
 GIxFhqCq7A5HjH3bnd/POE9T4S9JLJDHbMu6r94/GAoFby2nQxGPEHHflXMiRX1YbX54
 ihABkWisO6nK2sJyGbz0aC9XPnXkUxgKldCDbSVNVEfAtsVqu7nn9QDLEuUSkQrcdh8x
 waIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709894510; x=1710499310;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlA0XHaKUEAKha0j1a+S7Bo8scovzI02S0u/ITX8r/o=;
 b=ZDy1DrHsqDwJRz8sJEDUzSjUuVr7aKjNXAggCxwN+TurlzKEY1c0OycE9ByjhVZ6Q6
 SgzRHkzUAKXs9YU7jCwH20F+RCCF3XW2tkgHleEiuYMUCPkchtWXMRVh+DLQeULCdDQc
 Lp6KK0obvXiesBmWBSEraGRzneOJCp/zArBCb2qD6txx+Lg95OxY7FeruE4xEkVI0C2+
 6D1wgomkJXrHS5XE9vsE48RQ0WKBh4ExDfu28262G5DwzaKdCYSIdnLVuI1Wa0EUVQ33
 24Moa6E6n/W/E+CHqQVPDnrq0D9JgkSclfs5zCo0yl1/H7NWGS/JhoG9EXzQuyvCqKoE
 klag==
X-Gm-Message-State: AOJu0YwC9KUTVadx7NHCTTkNl3mscfUBSlVJof1o9UVI+OJ+A91+B5eC
 qC1YHh75QBp2lOoIYRjcJBK7pFoOOEVl0mkMzknvyJOseXMgIyRjcZc4gqOqFr5kbxbuxvJ/dHT
 aJFo=
X-Google-Smtp-Source: AGHT+IFgi9YjVZq6/Lmr1HCEb9Izytb+jzRaI4SN7teC5SGDK9/RqW42HWAvCsgd/SBfi7ryOUscfA==
X-Received: by 2002:a17:906:71c7:b0:a45:182e:29ba with SMTP id
 i7-20020a17090671c700b00a45182e29bamr10134110ejk.30.1709894510598; 
 Fri, 08 Mar 2024 02:41:50 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 w26-20020a170906385a00b00a4394f052cesm9139987ejc.150.2024.03.08.02.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 02:41:50 -0800 (PST)
Message-ID: <85654372-1266-4137-a2df-fcc8eadf4d4d@linaro.org>
Date: Fri, 8 Mar 2024 14:41:40 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] TCG plugins new inline operations
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi everyone,

polite ping for this series, that might have a chance to be included for 
9.0 soft-freeze.

Regards,
Pierrick

On 2/29/24 09:53, Pierrick Bouvier wrote:
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
> Based-on: 20240229052506.933222-1-pierrick.bouvier@linaro.org
> 
> Pierrick Bouvier (5):
>    plugins: prepare introduction of new inline ops
>    plugins: add new inline op STORE_U64
>    tests/plugin/inline: add test for STORE_U64 inline op
>    plugins: conditional callbacks
>    tests/plugin/inline: add test for condition callback
> 
>   include/qemu/plugin.h        |  10 +-
>   include/qemu/qemu-plugin.h   |  80 +++++++-
>   plugins/plugin.h             |   9 +
>   accel/tcg/plugin-gen.c       | 359 +++++++++++++++++++++++++++++++----
>   plugins/api.c                |  76 +++++++-
>   plugins/core.c               |  28 ++-
>   tests/plugin/inline.c        | 128 ++++++++++++-
>   plugins/qemu-plugins.symbols |   2 +
>   8 files changed, 633 insertions(+), 59 deletions(-)
> 

