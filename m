Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D8DD172CC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmU1-0007HV-OD; Mon, 02 Feb 2026 00:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmmTz-0007Gr-Ma
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:28:19 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmmTx-0001LV-Vb
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:28:19 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso2179789b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770010096; x=1770614896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnllqSj09UDgDaJYj+cSDe6h8/TH92XBjQZvGCWBZz4=;
 b=u7256yU1173/5GeoYJCfEFKvgk4PNcPDJaeyALXvOzpousSPi0jk1GPqB0P3H0ZRfQ
 OPZqaVSQFYVpHlDQ55Day1qp5MS680vYC+v6nStV7390T1tekvXbe0hJIUq7dEhog93C
 mTioqNmOvQkn2eTzV9MErOc/Tl87T4hRj0LDeuJF4Khfu4K2Ua9BPn6Y+9Mj692f4avK
 hlXlMvGHuzlJvTNONHJEUlf8O4+ttFgEwddoNWb6Z5OQv65eKErVCaSSlmRWm0feeHhM
 hyRMrXp3H/ohRHwbHq/66YQRaqlRst4aQiC+JqURARJDUWxMQ7nPcAjfPjIO4zOXzZkA
 SEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010096; x=1770614896;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dnllqSj09UDgDaJYj+cSDe6h8/TH92XBjQZvGCWBZz4=;
 b=YHIvYZFh6UatdIuIdfZD+qS5ja5WUNLQuSXI2WeK2erMWTqomVZMb+cSYm2M2BaDSJ
 x37Xng1VUs8cB0OvrY4Twe8OM8sgEocpeNGD/HrfOxVt55S62PjNVGpYJarWVELRRnCu
 i5Pb7kimzqqyg0rszhb3yMyNufpu+CZuEiMUWodPyRsW2A5RvV3z9KXqcZzWJIFEixiV
 3esYQ0HJMtN6IBfMPfUH58t5C9nKGXGxpzR79HUQ+LO0T8pwgDhe+wAi+G7TmnBtcy2r
 30ulDcwGZ2+yxjzUoz9XHO6ZtGGV9m0eETG/r3ySuMc5melkbOtZ15mQWUv3UI1yftk1
 jIFg==
X-Gm-Message-State: AOJu0Yxf4YuTmIhjjlF5b5ZvZz/2OtYkRNPDj5B0jLnrqg8jjgN3HVrA
 uepMLtmQOvxjQVazeLHt6ywVYVQ2uW8H1bQLL+TaWh0kF774nvbbgsNg590Pe5m5M1e0rDewcKe
 pt2HT
X-Gm-Gg: AZuq6aL8HVjNyR/YIH9Wfkld0/UElUWsBSXXVlhLhnNbLYyuJGn9IhEhw7u7bqPdcdP
 jucPKVqz9yZbGfu6flrhXuspkdwkFhA0i4KNvXx86+yOqa9wJ8yi7pl7+n7vXaHbbN051RTNMjw
 iY917Tj+skbpI+xy/P1hMiLDJHdOg4qFardK6/jOPP9eUa1C7HT/aN6HicbBf7o8QYyPyfY3K6p
 IYW4JKn5qzTuHtXniWWLTN+RZzWudu+Xi2MXDNMniqMxINvDwPNH0R26vMS8gGziKKlloDPYuYe
 JaiVEHEZSebI/74OtIi+m8Zl9VJ3WakwoimTCSMyg6dsYOdEseRA60qyIlXo3HPinTc5tvzQKNt
 0D9s29744JNov7RmJn3vHiG+LXaGaei9lerIjiqLqUH3rC4qfX4HFGRCoaTpQJryNAKT7IrdeJm
 /8tjwRRqmY+SP/NM5m3GOKrPkxH75z+qy9zBuQYxcJa8Lz+r2AIVBCj/MC
X-Received: by 2002:a05:6a00:3990:b0:801:eee2:45b6 with SMTP id
 d2e1a72fcca58-823aa62e75dmr10751870b3a.24.1770010096514; 
 Sun, 01 Feb 2026 21:28:16 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfd729sm13804878b3a.44.2026.02.01.21.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 21:28:15 -0800 (PST)
Message-ID: <fbcd2b53-d563-486b-87aa-368d7262d11b@linaro.org>
Date: Sun, 1 Feb 2026 21:28:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] plugins: enable C++ plugins
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 1/24/26 10:29 AM, Pierrick Bouvier wrote:
> Writing plugins in C can be sometimes tedious, especially when using Glib to
> keep track of execution state. We can directly use the same C API but write our
> plugin in C++, benefiting from its great standard library offering strings,
> smart pointers, data structures and synchronization mechanisms.
> 
> It's common for downstream QEMU forks to provide C++ for plugins, like this:
> - https://github.com/panda-re/panda/tree/dev/panda/plugins
> - https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin
> 
> Hopefully this will help more people to use upstream QEMU, and as a benefit, get
> their contribution back and help to develop plugins ecosystem upstream directly.
> 
> This series first cleans up build system for plugins, factorizing details
> between contrib/plugins and tests/tcg/plugins folders.
> Then, we perform codebase cleanups to fix conflicts between existing headers
> and C++ headers.
> After that, we can update the C++ standard used by QEMU, to benefit fully
> from latest updates of the language.
> Finally, we define an empty C++ plugin, making sure we can keep track of
> possible regression in qemu-plugin header.
> 
> Note: This series is *not* a trojan horse to bring C++ in QEMU
> codebase, nor to define an alternative C++ API for plugins. It's just enabling
> more users to get the most out of existing C plugin API.
> 
> CI: https://gitlab.com/pbo-linaro/qemu/-/pipelines/2242427013
> 
> v4
> --
> 
> rebase on top of master (new conflict with ./scripts/clean-includes)
> 
> v3
> --
> 
> - fix indentation in patch 2
> 
> v2
> --
> 
> - drop coroutine.h rename patch as it's not needed
> - drop ctype.h rename patch, and move qemu-plugin.h to include/plugins
> - fix mem.c to not depend on other QEMU headers
> 
> Pierrick Bouvier (11):
>    plugins: move win32_linker.c file to plugins directory
>    plugins: factorize plugin dependencies and library details
>    plugins: use complete filename for defining plugins sources
>    plugins: define plugin API symbols as extern "C" when compiling in C++
>    tests/tcg/plugins/mem.c: remove dependency on qemu headers
>    plugins: move qemu-plugin.h to include/plugins/
>    meson: fix supported compiler arguments in other languages than C
>    meson: enable cpp (optionally) for plugins
>    qga/vss-win32: fix clang warning with C++20
>    meson: update C++ standard to C++23
>    contrib/plugins: add empty cpp plugin
> 
>   docs/devel/tcg-plugins.rst                  |   4 +-
>   meson.build                                 |  26 +++--
>   include/{qemu => plugins}/qemu-plugin.h     |  11 +-
>   include/qemu/plugin.h                       |   2 +-
>   plugins/core.c                              |   2 +-
>   {contrib/plugins => plugins}/win32_linker.c |   0
>   tests/tcg/plugins/mem.c                     |  59 ++++------
>   contrib/plugins/cpp.cpp                     | 119 ++++++++++++++++++++
>   contrib/plugins/meson.build                 |  25 ++--
>   plugins/meson.build                         |  17 ++-
>   qga/vss-win32/requester.cpp                 |   6 +-
>   tests/tcg/plugins/meson.build               |  18 +--
>   12 files changed, 203 insertions(+), 86 deletions(-)
>   rename include/{qemu => plugins}/qemu-plugin.h (99%)
>   rename {contrib/plugins => plugins}/win32_linker.c (100%)
>   create mode 100644 contrib/plugins/cpp.cpp
> 

This was merged into master (a8e6997ef).

Regards,
Pierrick

