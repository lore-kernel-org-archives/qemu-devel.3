Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE1FD715E3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiSk-0002VR-HT; Sat, 24 Jan 2026 13:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiSY-0002O9-Dr
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:34:13 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiSV-0004ag-Bq
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:34:09 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so36332125ad.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279644; x=1769884444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gXxvm3cC6ZLthl5NMKCepcTo0S8Gup7/o7pXdPyg4Bo=;
 b=E8e09xt9xjF6SWTSXHmTZayus8R8IuW+VhYgnY08HJmzH7k3g4DJEOPIZLxT2gxuml
 a8zJH30HZeg81LI/stee/I0+2egP5qU+JDHExeNDtHyPjvdwz7O/VivrwHCV4I0YRVkM
 bCFYvByx62MyFoWhg4qktcsmdY1ie5vi7SF3lqX94VPtHOmv2RfwUIXiBzOD+4cNmbcx
 NLy3wONEkz81usQxB8zUFVWfND9QpM66GLhCLrg2ZCKhIUI7HIBZlNTDjYrZZntla3Q9
 w1dFrx0wjm/EEPLyb3XJQluQU1BoDS8pZvmya+HxaNTVy4Uw4TDQfI0NrLG6STZFE9Gu
 YwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279644; x=1769884444;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXxvm3cC6ZLthl5NMKCepcTo0S8Gup7/o7pXdPyg4Bo=;
 b=djH9zk8F9cPqJpfQzbykhp2yMhufm7O4ZtinwOvmg8vv1wtyLJQigGFi7fCUMcEDLX
 8LwDNZFZmv6q2mIML+UykRHteg3cfRjH0xs/uic5o+YIVwJMAmrBrfK26Wt6pjEWnpUd
 wiAmMXghTYKib8tj8wxmk1qi3tDZfaIIYTDc0vu+ZFgAbmaPztPbN6pTNEu9ZCkRYAbv
 Oq80aWMkZTbKgAdl9wMn3P8+LCqa3BkvxC2w7hC2G1FmV9TcNqcBpgk9urFx90MmX6DC
 cmwAwcHdO2fjRR47M7pG1sbRwgyNj0acVmwB82BZb9bSZY1pNqWwbcHXF/EyUDH/mMQv
 ALjA==
X-Gm-Message-State: AOJu0YxlT2Muvo8yLVVOxquIGFgOhmjzehfLkFNrlK6fggYTYGasN1FF
 0bF2vB84bTrKdF/1aJD1reXZMDnVGBKLqhTompL2aJbfSySuIf4RgJGQscPg5tm+iV/KMsAfUAl
 9Z+rnbAY=
X-Gm-Gg: AZuq6aLH8wLbeAS0bGQT8aLyHSedb6D3xIaIqbOtuHCjJNqbwRkhoH4nV5vrvlidMJ3
 HW6Vbn3HemGk/4egAXk3ZTK251TWtQkMTyoUD0gPkHdtZCvVZlJ4uyeHpJ+s58fhhzPgeFz70xb
 CS+9YlMB+tqbkmBSyd63B7mOZIf8IUGO9j5pM1DkakdjGNhOMtDyvammGfmb4uGnIWt941On+Ew
 IveYYS3oIuPEzeknWjzGakQw/XH/A2faKNKvBsbjNtyU7TwJObSPieWjO9ldQtav2O0s3LOUVxc
 GvMz/Jf8T4FMtpQRaZ8Nrl/ObMuDYwrUv40bMcjuqNvDlBirYTaqsUyU2hmTKtuadvwQhsxpjqa
 IGQORVpMzKbwNbYaysmmTEHbkt7hocmN6JW252ng9vJhEriSmyK0GLRuXCmKJHz6HaVBpuna6J0
 MMSeFIBtCLg6YEjpf+BHMgFj31m9zIuFeAhRpRTu9s7zksRiL4ZXVenR82
X-Received: by 2002:a17:902:f54f:b0:2a7:3daa:5822 with SMTP id
 d9443c01a7336-2a7fe77dd97mr57784675ad.60.1769279643796; 
 Sat, 24 Jan 2026 10:34:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802dcd97bsm51264715ad.35.2026.01.24.10.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jan 2026 10:34:03 -0800 (PST)
Message-ID: <30f15d71-2965-4094-9950-e27dd1d01a6a@linaro.org>
Date: Sat, 24 Jan 2026 10:34:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] plugins: enable C++ plugins
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/19/26 11:11 AM, Pierrick Bouvier wrote:
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
>   scripts/clean-includes                      |   2 +-
>   tests/tcg/plugins/meson.build               |  18 +--
>   13 files changed, 204 insertions(+), 87 deletions(-)
>   rename include/{qemu => plugins}/qemu-plugin.h (99%)
>   rename {contrib/plugins => plugins}/win32_linker.c (100%)
>   create mode 100644 contrib/plugins/cpp.cpp
> 

sent v4 (fixed conflict with master):
https://lore.kernel.org/qemu-devel/20260124182921.531562-1-pierrick.bouvier@linaro.org/T/#t

