Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F07D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlW1X-0005vJ-M3; Thu, 29 Jan 2026 12:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlW1U-0005uy-Lz
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:41:40 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlW1S-0001Hu-Po
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:41:40 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so1078062b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708497; x=1770313297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xOCdFlTPvyhHsaEbbXa5ehtRg2ZCO6H7MxJuju9NZgw=;
 b=X01kNxgxsOYL+B9XQ1oBOc5PcsDJpAuy1zgzINfX/npE/RdyQXitd0+0D/Y5Y5GRjz
 fS27ln0pNdfJ2c/bSr5v7+odljGd3n2zauqxl5UAxJFEy7hI5f85EdzBl9O9tQXQc1gN
 e4l83b/1dFIEOE9cGammaD+UoXhMDHymZXAh9LX3l0sU9jeZGZC5OJ4zT15W1jAIaEOg
 9ze9vPdo/oA+ucwHcwA5PGdhn9CHURgKNcC0u9Fm/s7/w4mPDLU8MjObO2IiBqwmN2fp
 vVHjVGF9TQ4u353z+oDScPIYyxsa9xkXaG5e62aksS+lxNe9GtghVBMaNYffiaINovF/
 23kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708497; x=1770313297;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOCdFlTPvyhHsaEbbXa5ehtRg2ZCO6H7MxJuju9NZgw=;
 b=mvQhBcgxCDAS4B6G0sdyOiHcxxmd52y+NTKyA9Hl606qqLgGggGnnFknJaNy7poWBT
 W254gw8DpUzp1EWxFbiuNeUEkHpVltynwF46mhUQYjkkGYRj1p8+WLr2mrMJhz50P2fK
 7zy+Wy6XBI0uvJCqEHV91d2Yb1I2vmZuZKavT90DDKaqRrQx1qqCjOVbPS4lAvvAKzfR
 FQ15x44pBucPzwxdI6UHPE14w7GJgfslW7FSDfM+0RQ3qsOfa8+tyTsSDqiic6+Hs3kG
 eSosBGv0hgTk/My7tQYrCtKlho3U2vBxg0IGrjiiH/dWW2sToOtiK9bp7nPOHcBoas/b
 2ybg==
X-Gm-Message-State: AOJu0YymJv8kCfgDzwlzYGQt9DRB7vSytQmAOw3YEpowk9ijJKm5Bk/0
 yIxfZ9TuDmIW0YjT3CXBf38MGyOYttwbBlNuorwCN/mYCCkGuAVdRHGKP2+iebHHM/tTExpNP3S
 CbgVl
X-Gm-Gg: AZuq6aL+ibOEwsJF9scmK+EltP8HE/y6aMCytFfz1/aPTdVwPz/ZmpiBWfXWQ2RFfVk
 rELONPHRTlBQgCRrqp1VKwODDa5l4nTolt8JFmG6Kh1HO/jyqPi9gzo0I9T3sYbif6FV7P22Gei
 F3P/ZdFUaT8r4wg7Vw1BnOYKZSfMjckO9YxHHFqs2OhNus5YauHU1kRIKfdpJHJGS8lTqM7yB+o
 yo1/pRHJG1p/2JQISth6ZAyuoh3BQoAJlLK8QbAiTD7YZbAjzk4kKG/+HBE23iBg2sasECHr91x
 8kVfZ1huthcmINgNKo5xMXmLh31JxyY5XcJYqa89OnUVIdQ51c8SgYiSND74eehRGZ+Zm5oJ79M
 lCNq1NUJ+OnJ3Dwd3qX8ko926nJdHlBLq6CF8jFM0wL/x+FLswIBB6ega1JUSBhaQbdyn8+2ybk
 HM17rvGfS5/ERn39QmSHKQ6Q0YSYkk5P45VW22aLsaYZRzmUWbKZ5SnLqR
X-Received: by 2002:a05:6a00:21d6:b0:81e:8e66:38d9 with SMTP id
 d2e1a72fcca58-8236919903fmr8359979b3a.17.1769708497158; 
 Thu, 29 Jan 2026 09:41:37 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b4e96dsm5976624b3a.23.2026.01.29.09.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 09:41:36 -0800 (PST)
Message-ID: <d5c6509d-0445-4620-b288-57055ac0b7dd@linaro.org>
Date: Thu, 29 Jan 2026 09:41:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] Plugins patches for 2026-01-28
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/28/26 5:31 PM, Pierrick Bouvier wrote:
> The following changes since commit 9ad7f544c696d73ce377bbad83f3cf8b4dd8dcac:
> 
>    Merge tag 'pull-request-2026-01-27' of https://gitlab.com/thuth/qemu into staging (2026-01-28 10:04:17 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260128
> 
> for you to fetch changes up to 2ddf77d673174d7a5c9ba0bb855cad664225d7c3:
> 
>    plugins: reduce source conflicts in plugins list (2026-01-28 16:41:59 -0800)
> 
> ----------------------------------------------------------------
> Changes:
> - contrib/plugins/hotblocks: Minor bug fixes and add limit argument (Alex Bradbury <asb@igalia.com>)
> - linux-user: introduce syscall-filter plugin API (Ziyang Zhang <functioner@sjtu.edu.cn>)
> - plugins: return bool from register r/w API (Florian Hofhammer <florian.hofhammer@fhofhammer.de>)
> - plugins: enable C++ plugins (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
> - plugins: reduce source conflicts in plugins list (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
> 
> ----------------------------------------------------------------
> Alex Bradbury (5):
>        contrib/plugins/hotblocks: Correctly free sorted counts list
>        contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
>        contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
>        docs/about/emulation: Add documentation for hotblocks plugin arguments
>        contrib/plugins/hotblocks: Allow limit to be set as a command line argument
> 
> Florian Hofhammer (1):
>        plugins: return bool from register r/w API
> 
> Pierrick Bouvier (12):
>        plugins: move win32_linker.c file to plugins directory
>        plugins: factorize plugin dependencies and library details
>        plugins: use complete filename for defining plugins sources
>        plugins: define plugin API symbols as extern "C" when compiling in C++
>        tests/tcg/plugins/mem.c: remove dependency on qemu headers
>        plugins: move qemu-plugin.h to include/plugins/
>        meson: fix supported compiler arguments in other languages than C
>        meson: enable cpp (optionally) for plugins
>        qga/vss-win32: fix clang warning with C++20
>        meson: update C++ standard to C++23
>        contrib/plugins: add empty cpp plugin
>        plugins: reduce source conflicts in plugins list
> 
> Ziyang Zhang (2):
>        linux-user: add plugin API to filter syscalls
>        tcg tests: add a test to verify the syscall filter plugin API
> 
>   docs/about/emulation.rst                         |  12 +++
>   docs/devel/tcg-plugins.rst                       |   4 +-
>   meson.build                                      |  26 ++---
>   include/{qemu => plugins}/qemu-plugin.h          |  62 +++++++++---
>   include/qemu/plugin-event.h                      |   1 +
>   include/qemu/plugin.h                            |  35 +++++--
>   include/user/syscall-trace.h                     |  17 ++++
>   contrib/plugins/execlog.c                        |  14 +--
>   contrib/plugins/hotblocks.c                      |  20 ++--
>   contrib/plugins/uftrace.c                        |   8 +-
>   linux-user/syscall.c                             |   7 +-
>   plugins/api.c                                    |  36 ++++---
>   plugins/core.c                                   |  39 +++++++-
>   {contrib/plugins => plugins}/win32_linker.c      |   0
>   tests/tcg/multiarch/test-plugin-syscall-filter.c |  39 ++++++++
>   tests/tcg/plugins/insn.c                         |   4 +-
>   tests/tcg/plugins/mem.c                          |  59 +++++------
>   tests/tcg/plugins/syscall.c                      |  19 ++++
>   contrib/plugins/cpp.cpp                          | 119 +++++++++++++++++++++++
>   contrib/plugins/meson.build                      |  38 +++++---
>   plugins/meson.build                              |  17 +++-
>   qga/vss-win32/requester.cpp                      |   6 +-
>   tests/tcg/multiarch/Makefile.target              |   7 +-
>   tests/tcg/plugins/meson.build                    |  27 ++---
>   24 files changed, 478 insertions(+), 138 deletions(-)
>   rename include/{qemu => plugins}/qemu-plugin.h (95%)
>   rename {contrib/plugins => plugins}/win32_linker.c (100%)
>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
>   create mode 100644 contrib/plugins/cpp.cpp

v2 sent:
https://lore.kernel.org/qemu-devel/20260129173811.138036-1-pierrick.bouvier@linaro.org/T/#t

