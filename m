Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81969D46623
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgULN-00013C-Lt; Thu, 15 Jan 2026 15:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUL4-0000wB-Kq
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:53:07 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUL2-0003cJ-Nn
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:53:06 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34b75fba315so583984a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768510383; x=1769115183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NUz4GX8ByEoSpG2KghD4CFBBDW1bW9Zc1AZ6m/2ZXQI=;
 b=D6Bfb5ZRX3QLtgArNO3o8tO2bLkN4wWKWYw4QMLrKibzu5sV9nmqUnjQG/omFaOUZG
 cVqr0sibYxrWh6Lul+KcAeBag66UjSqIKUTX2QEUd0n9H1aXMeyf79NjwdXj+zMp00jJ
 KTPCuCcJB0oWQ+7GgFz6WmvQgi0O5FgOH42bHVqZup+iI3FQw5WTmQUy9bJqp6k0WEyu
 kMIiQCRgxgpi/lYk3dwWLrSrJ+YveUhHl/yLhM6rDpgVHN/LgLU+pUPUr74YF7aJnLjs
 nwygNj6GJ+5cSF3uXSxJT7x4cRS3wHnWmeRse3bCKi5uxIVyS/zhQ+9PfazybVtTaSUN
 m6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768510383; x=1769115183;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NUz4GX8ByEoSpG2KghD4CFBBDW1bW9Zc1AZ6m/2ZXQI=;
 b=skxFuNCATOkRtYxO3kVrJRowq6wr9v5MULXutbaoxo1um6n6uWvDr+ofeNzAjs928E
 xdjQeA7sOi6+LPF8oYZ7IMjmNXbhNYBnMH1VtWBcxibpRSLjtNMtIpv/+bpO8YhY+s4h
 igbMgkfQXBn0OmEKYeHmQLAPsCsGtlTluC4SDiV1hsviTmRy+u3/ZMTG1seklDOJSDwJ
 IJ/q+vWlw7YuhZ/9Tp7OlR+Wt3VetJxTYUpR8LZ+/iqRejjCyuYNkhhf+WK9up0XHxYh
 /7FpIoKcJQBshd7YbkxpC+tyIQtBJYYUHoBBHZ5ztMP7+DvTUpSbpxt6O2j8JmVy3eQ3
 Me6g==
X-Gm-Message-State: AOJu0YwIZTPw0DeE7Grsu6dwiEAfBADFLLGcUPlqA9lZmi5gDwl3FAs2
 ERfvEcA553mr0n94gbOlEIb0JEXNdWJNeqih1VvXIS3oFjA+/Vc70+2sM8kBe8eaPUYw0UHYZDu
 beuHv
X-Gm-Gg: AY/fxX5Os8NB6tRu2RPH9AG8cd9w+/aw1na4wAmgeYZobguO8KeNnMeyKQXmukTezZm
 Vq45GM5aVzq6Mri/G2Pxn94qJBubf05JgG751ybAwve9mtUJCWPLRpfiI+WwF6qN55DtET1hdb+
 fhwA83thfJnnMGOxB56KplJp8fLuIRZVvfOPtTEfm8jJqeLvS+kLmF1+uWJAoRxRj5fdReCKkPJ
 8StW2rfQJ+eO+luyxdSnWOCkn1qk/w+UdPvO4Vgcx5B5Py+xHQ1pro5atcCSzcIV+QXk86I2vRe
 1dJXMo/dLLkkNfOe2zvh5Xp6HSaAjjQZXGkKsBGMVOScGvfRn7iwLESR6DLnQ1E7UDpuZOOdLZ6
 tu1XZAtg4R0pYDQF1KsB3nt/DJinaBRf1+3W0h+hlBK8rpgYGw2Ek8J+yjgDwkIg62mrsgnFNnM
 FxaNlY4bPHALVZFJpwuavAcjOms/Ov+gwDrsA2iwAJ1Kpk88jo7r7juxk09/n76KBVSUo=
X-Received: by 2002:a17:90b:4fc1:b0:340:ad5e:c3 with SMTP id
 98e67ed59e1d1-35272ee0d43mr527987a91.1.1768510382844; 
 Thu, 15 Jan 2026 12:53:02 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3527304c5d3sm287332a91.3.2026.01.15.12.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 12:53:02 -0800 (PST)
Message-ID: <fd00e161-6727-4d92-978e-8bb83a27f612@linaro.org>
Date: Thu, 15 Jan 2026 12:53:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] plugins: enable C++ plugins
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/2/26 1:47 PM, Pierrick Bouvier wrote:
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

Ping on this series.
It has been reviewed and is ready to be merged.

Thanks,
Pierrick

