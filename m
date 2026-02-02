Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F40D172C4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 04:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmlAb-00072T-FH; Sun, 01 Feb 2026 23:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmlAW-000725-U8
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 23:04:09 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmlAU-0001La-8d
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 23:04:08 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-352f60d6c2fso2604265a91.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 20:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770005044; x=1770609844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0QfoEGxMsIuEzYlDvBzapUpsFyjX75R5u1DkPg0u/6U=;
 b=P9c77h5Dp26KLBvUgV/oeC9UWjYMvvUZ6Qr/u2LCPU2GkytM1cuKBog+p/D3zqvH+T
 U3Q9Q/kWfFRVJnf9DpZcgb8UkU7LVeXW5R8KLY9+kIpXVzkmpkw2M9BgEP6S2KAgyT1p
 JHZ1pf7YAswNboOyZDAcb73E+xYNdc4Z2dglGfpXTvU5AuCH9S2npGg4P5s6O5bhR4GI
 48E2g9B3IikDbjrDVHtUU/5YeUmM4RbNrenIUrd/bNKaYadzL7C5OG+WZZBuEm6BPsSU
 6KnOYfwS+0noS/CxoloDa14F+w5gyWGT+HQyz02mtZDa9MPT0LiGj4Fnsq4ZT/QSUshR
 aaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770005044; x=1770609844;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0QfoEGxMsIuEzYlDvBzapUpsFyjX75R5u1DkPg0u/6U=;
 b=jT3wCshlNJxzqh8AJJU3V9mlY+QNxMhqZYtVkYDBLY7po4ecdG/jCBGEEYE0NCe7um
 PXt12Mk+Yh3yyFxzymw+PQLfoYcS/hhQqdiC5mBHaj26f80geLUkuIC+4eslXpZdOm1z
 KJChwMdB0tiOkZPX6Jywkfg2KCvjGBoZOqzd55JQaSMMHt/fAr97/lB+10hUQop8sd7S
 eCFkDrbMoj8Z1OjQx076aSeLKums643Qu2kGChGJr/NQUzpMdIUHvrW3uWn5CIc4mIW/
 a9wp2GuwjBkmvKNKzUzD/B+Zu7wXOF9TvWJQACIpd9HPIU6hH/3Y+1+52Vwrd8637h1K
 hxqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdHB0P9oxEVlq0h3hHOyBRP8cBZL2hxv2LqaPfHoV5IMoAfG95fhKSV9eO3yXpOwmyg2aL0/kCjvci@nongnu.org
X-Gm-Message-State: AOJu0Yz3JClLjLNQL6ndWwHF1c/Q9ReVg+qfZojuPO5g3p5Ik2HOFOA9
 URI/rDScFL5QVHAGvh23puA7CXqq/oy1vt4JXC6j3e1aYoJAdUKYL4R3rc4ME9+MWx4=
X-Gm-Gg: AZuq6aIqzL70jjWJT3c5E90pN6UrkMUgY8sxlFxeKX9EIgZW6mmOk++PgLh6mr89tgE
 cisw/CuPWYjOgiBe3LCVT7fpntIgo4kimlgh2UFfRA4tQaehVejuiqsTQIAzTQg+BJS38pFI2s/
 n55pjp0rDDd7lDpoXqYGvJ9K4HiDXRKL5Tz/QF4lJywkWN3FJjDp8/iQmkTMKmoLjjJx8nnzR22
 LZvkA2hFne29JKZ7VjJP3t/kWlbnf7k4OGtdEaLWJZmOHbdAncl5pDOmwdNtXbGoLW5irbPl5df
 Mksr28qpGSWfYTcwkGmNvBcF+YNuRs/JFb5bZEvy7l/HoX9/cyaMufwZpJN+JIH0Iq8hk/8YAxM
 bqpADAMa+gQL9Stsy8k2ZKJnzsrihZcQtgpmWHQXQaZ67q17P1ZHvvvTMwHPgCNG9OW/gRz4BDl
 HC4y9YHtR6psKDRsEC7Rhbxa4Prw5cFOUDOSG1+5injVPHHIx1O3+H3LO8eelRX2dNgFD1wzkjL
 GhFo16ZacDkRclLuxb67e8EldbVQJw9+pdxLLssGA==
X-Received: by 2002:a17:90a:e704:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-3543b394145mr10586105a91.18.1770005043856; 
 Sun, 01 Feb 2026 20:04:03 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:f104:411e:690f:7d65?
 (bg30dj09str9vbyq0vvw.ip6.superloop.au.
 [2401:d002:dc0f:2100:f104:411e:690f:7d65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642aaecd19sm13377597a12.29.2026.02.01.20.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 20:04:03 -0800 (PST)
Message-ID: <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
Date: Mon, 2 Feb 2026 15:03:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
 <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/30/26 04:41, Pierrick Bouvier wrote:
> On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
>> The following changes since commit 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9:
>>
>>    Merge tag 'pr-build_fix-20260128' of https://gitlab.com/pbo-linaro/qemu into staging 
>> (2026-01-29 13:29:33 +1100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260129
>>
>> for you to fetch changes up to bed25f00d306bbbcc85d068b6469fc00aeecbd11:
>>
>>    plugins: reduce source conflicts in plugins list (2026-01-29 09:34:14 -0800)
>>
>> ----------------------------------------------------------------
>> Changes:
>> - contrib/plugins/hotblocks: Minor bug fixes and add limit argument (Alex Bradbury 
>> <asb@igalia.com>)
>> - linux-user: introduce syscall-filter plugin API (Ziyang Zhang <functioner@sjtu.edu.cn>)
>> - plugins: return bool from register r/w API (Florian Hofhammer 
>> <florian.hofhammer@fhofhammer.de>)
>> - plugins: enable C++ plugins (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>> - plugins: reduce source conflicts in plugins list (Pierrick Bouvier 
>> <pierrick.bouvier@linaro.org>)
>>
>> ----------------------------------------------------------------
>> Alex Bradbury (5):
>>        contrib/plugins/hotblocks: Correctly free sorted counts list
>>        contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
>>        contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
>>        docs/about/emulation: Add documentation for hotblocks plugin arguments
>>        contrib/plugins/hotblocks: Allow limit to be set as a command line argument
>>
>> Florian Hofhammer (1):
>>        plugins: return bool from register r/w API
>>
>> Pierrick Bouvier (13):
>>        linux-user: move user/syscall-trace.h to linux-user/syscall.c
>>        plugins: move win32_linker.c file to plugins directory
>>        plugins: factorize plugin dependencies and library details
>>        plugins: use complete filename for defining plugins sources
>>        plugins: define plugin API symbols as extern "C" when compiling in C++
>>        tests/tcg/plugins/mem.c: remove dependency on qemu headers
>>        plugins: move qemu-plugin.h to include/plugins/
>>        meson: fix supported compiler arguments in other languages than C
>>        meson: enable cpp (optionally) for plugins
>>        qga/vss-win32: fix clang warning with C++20
>>        meson: update C++ standard to C++23
>>        contrib/plugins: add empty cpp plugin
>>        plugins: reduce source conflicts in plugins list
>>
>> Ziyang Zhang (2):
>>        linux-user: add plugin API to filter syscalls
>>        tcg tests: add a test to verify the syscall filter plugin API
>>
>>   docs/about/emulation.rst                         |  12 +++
>>   docs/devel/tcg-plugins.rst                       |   4 +-
>>   meson.build                                      |  26 ++---
>>   include/{qemu => plugins}/qemu-plugin.h          |  62 +++++++++---
>>   include/qemu/plugin-event.h                      |   1 +
>>   include/qemu/plugin.h                            |  35 +++++--
>>   include/user/syscall-trace.h                     |  43 --------
>>   bsd-user/freebsd/os-syscall.c                    |   1 -
>>   contrib/plugins/execlog.c                        |  14 +--
>>   contrib/plugins/hotblocks.c                      |  20 ++--
>>   contrib/plugins/uftrace.c                        |   8 +-
>>   linux-user/syscall.c                             |  44 ++++++++-
>>   plugins/api.c                                    |  36 ++++---
>>   plugins/core.c                                   |  39 +++++++-
>>   {contrib/plugins => plugins}/win32_linker.c      |   0
>>   tests/tcg/multiarch/test-plugin-syscall-filter.c |  39 ++++++++
>>   tests/tcg/plugins/insn.c                         |   4 +-
>>   tests/tcg/plugins/mem.c                          |  59 +++++------
>>   tests/tcg/plugins/syscall.c                      |  19 ++++
>>   contrib/plugins/cpp.cpp                          | 119 +++++++++++++++++++++++
>>   contrib/plugins/meson.build                      |  38 +++++---
>>   plugins/meson.build                              |  17 +++-
>>   qga/vss-win32/requester.cpp                      |   6 +-
>>   tests/tcg/multiarch/Makefile.target              |   7 +-
>>   tests/tcg/plugins/meson.build                    |  27 ++---
>>   25 files changed, 497 insertions(+), 183 deletions(-)
>>   rename include/{qemu => plugins}/qemu-plugin.h (95%)
>>   delete mode 100644 include/user/syscall-trace.h
>>   rename {contrib/plugins => plugins}/win32_linker.c (100%)
>>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
>>   create mode 100644 contrib/plugins/cpp.cpp
> 
> v2
> -- 
> 
> - Delete syscall-trace header and move functions to linux-user/syscall.c
> 
> Note: There is a regression upstream with native windows builds where:
> 
> $ ./configure
> Looking in links: file://C:/GitLab-Runner/builds/qemu/python/wheels
> WARNING: Location 'file://C:/GitLab-Runner/builds/qemu/python/wheels' is
> ignored: it is neither a file nor a directory.
> ERROR: Could not find a version that satisfies the requirement
> meson==1.10.0 (from versions: none)
> 
> This is not related to this series, and seems like an MSYS bug. It can be avoiding by 
> *not* updating core packages (pacman -Syu). Hopefully will be solved upstream before 
> updating becomes mandatory.
> 
> This series has been tested on Windows with changes described above and it works as expected.
> 
> Regards,
> Pierrick
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

