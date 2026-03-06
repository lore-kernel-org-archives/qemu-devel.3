Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678B9FCC04F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZEZ-0003kd-Nc; Fri, 06 Mar 2026 12:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZER-0003MG-5V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:45:00 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZEM-0005zl-K0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:44:56 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-899f27df3d1so60976596d6.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772819093; x=1773423893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qslgXUX47sIfmqd7BXbYcv+4YoqZg41zaCODzJDcnBk=;
 b=XZ30E1sbxbQbNU5TkYqTfaL+ulMcUhAiFnUA+8eCtLa2plhxixpszCILxYuhJuJW2o
 Eg3ob1EObfYBWl3+SQhTyS206blGygH20xzYUFO2hqtgmyKDSBsMp2T4enQn7C80Saqr
 vfU6iCTOQxjBjrxSB8vtYsZYuALCIkwmnZWS3853hb4SLkhYWn9k3DgbB3JrAvvA/kyC
 67TSg12+12W1rKT15JMkF0gKJjDgUkAQgNWtqZgghgFpixaV6Jh/o2OPoOkVeAP+QaSV
 pPjmCx3WHBSkW+ltgOgLqWWql5d84r5OFbGg5LpUyCek1z6keTUnODNd7QY2e1KFzbkS
 yQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772819093; x=1773423893;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qslgXUX47sIfmqd7BXbYcv+4YoqZg41zaCODzJDcnBk=;
 b=NtiggYdq08q8tm9879gFDYgmkkLpJ/Mr7eA8CYkLww8kG6ztMI0xbriflG+0QfVhv5
 rXnytalH+eslcUmcalEsEuwYBAy/6KjUjtPgn4JI3nQVr/JUqBQewL1h6CezrPWdWU68
 vyDann4QWiM7fuWXb8s9XyBrtSLBEL4mXfUuyQRflBl80qwZxd8jYcmeA7R8bWgXphvS
 UUKI7vfhJqcL1WStUC1kZGxTOoAyQUDnEVc3nNMNcQ2DywmsmAG0xk82msx2tSV+udjc
 CJx+J8P6awbCpzMrSpobnm+UdGCEJ2bpplbcIkKYndzzYJjpvlAPVMaX15BmjxPi2M8k
 w5xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUgiI5XXkidZ0v9IJc0ldXORs2IQfqZxDU6MN/piO2eVWSaqRIxkW3sJxNMYWucrjMRIpppSoCNsMb@nongnu.org
X-Gm-Message-State: AOJu0YxZGkNTn3yWjNeQD+kov9d/rcmanhMrkkybda0+2GuJxvF7XTGn
 UkzDW7ZhPRA8dU/d+VVtYy/9ZTsaU64jqY7jK9vmZkh/07AzJm0jIyXBBotUx8l7VZA=
X-Gm-Gg: ATEYQzwuOnRrQy7L8XTIvHHgq71MKttIORL69OOflev2+ymXu1T1n8hosOig9ctpbPV
 I3nAI5ISVkNOk2EtMUr2AORfYb17oYBqbz7z0KxPHQVOFr417HeLvQAZTItFWws1EZhKvwvIx34
 TAUuIn485XObvM8irh5sMtS5TX8lQKWJIomN1uEc1/nug4WfoCvFBt4E6yiaV9E8zAfSmMeUVaM
 xhuiPX5Ar/bbOx8S9+n9cZXOsUBgsDQtaHH6dyyaCH3QMDxw+2dpWNij9KJu481erigei51Z88U
 xTm1WkFilNmc8cdk3d+aUtXmJ6uvtmVJvxa2WrwM46ZGE2X0PEwuAaFlhQ9kJ3kO0E9Jnl0/gj6
 MdYDcWq6Q+Vyy0QDby09mNGnEkw/bfFNgxxNonpeXDaNBUiGH6gs2C+04N/69hX+dwSK7NuRVfa
 Pez70svbvgpyyb/umNlW7dT3i65nsBPBgTVsZ3mgtIJ77wFriStvWTjW3wSzMZUwI9uaibOsFf0
 qVk5BM=
X-Received: by 2002:a05:620a:bd5:b0:8c7:c25:9e69 with SMTP id
 af79cd13be357-8cd6d4886edmr356053885a.66.1772819093487; 
 Fri, 06 Mar 2026 09:44:53 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f48407esm153312285a.6.2026.03.06.09.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:44:53 -0800 (PST)
Message-ID: <318973f3-8fed-4605-bd13-60c46025e150@linaro.org>
Date: Fri, 6 Mar 2026 09:44:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] Enable PC diversion via the plugin API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 3/5/26 2:05 AM, Florian Hofhammer wrote:
> Hi,
> 
> This patch series builds on top of the discussion from the thread at
> https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch/
> and adds a plugin API function to set the program counter of the guest,
> as just writing to it via qemu_plugin_write_register() has no direct
> effect.
> 
> This version v7 of the patch series addresses the requested changes from
> the previous v6 submission (details below).
> 
> Note: checkpatch.pl still reports a warning about line length violations
> in patch nr. 7/8 but I did not fix this, as the line was already > 80
> characters long previously, the change added only a single character,
> and I think the readability of the code is better as it is now. Please
> let me know if you disagree and would like me to fix this!
> 
> @Pierrick: you already reviewed patch 3/7 (now 4/8) previously, but I
> had to change the regex in scripts/qemu-plugin-symbols.py to account for
> attributes, so please re-review!
> 
> Best regards,
> Florian
> 
> Changes:
> v7:
> - Add Pierrick's patch to clamp 32-bit registers to prevent accidental
>    sign extension
> - Fix documentation build by using __attribute__((__noreturn__)) instead
>    of G_NORETURN (required adjusting scripts/qemu-plugin-symbols.py).
> - Rework test-plugin-set-pc test to get rid of volatile guard and make
>    control flow more linear
> - Link to v6: https://lore.kernel.org/qemu-devel/20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch
> v6:
> - update commit message for patch 4/7
> v5:
> - make QEMU abort via asserts instead of just returning an error from
>    the plugin API if preconditions are violated
> - extend tests for qemu_plugin_set_pc() to different contexts
> - fix issues highlighted by checkpatch.pl
> v4:
> - switch strcmp out in favor of g_strcmp0
> - split the patch introducing the qemu_plugin_set_pc() API into three
>    patches, two for preparing the plugin infrastructure and the syscall
>    handling code and a third introducing the actual plugin API
> v3:
> - make PC registers read-only across architectures
> - add tests for read-only registers
> - adjust test structure for qemu_plugin_set_pc() by moving
>     architecture-specific tests into corresponding directories
> v2:
> - add setjmp() in syscall handling path to allow PC redirection from
>     syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
>     exiting a TB would not be live anymore in syscall handlers)
> - add flags to ensure the qemu_plugin_set_pc() API is only called from
>     contexts where the CPU is live
> - add test for qemu_plugin_set_pc() API
> v1:
> - initial version
> 
> ---
> Florian Hofhammer (7):
>        plugins: add flag to specify whether PC is rw
>        linux-user: make syscall emulation interruptible
>        plugins: add PC diversion API function
>        tests/tcg: add tests for qemu_plugin_set_pc API
>        plugins: add read-only property for registers
>        plugins: prohibit writing to read-only registers
>        tests/tcg/plugins: test register accesses
> 
> Pierrick Bouvier (1):
>        plugins/core: clamp syscall arguments if target is 32-bit
> 
>   MAINTAINERS                                        |   1 +
>   include/plugins/qemu-plugin.h                      |  19 +++
>   linux-user/aarch64/cpu_loop.c                      |   2 +-
>   linux-user/alpha/cpu_loop.c                        |   2 +-
>   linux-user/arm/cpu_loop.c                          |   2 +-
>   linux-user/hexagon/cpu_loop.c                      |   2 +-
>   linux-user/hppa/cpu_loop.c                         |   1 +
>   linux-user/i386/cpu_loop.c                         |   8 +-
>   linux-user/include/special-errno.h                 |   8 ++
>   linux-user/loongarch64/cpu_loop.c                  |   5 +-
>   linux-user/m68k/cpu_loop.c                         |   2 +-
>   linux-user/microblaze/cpu_loop.c                   |   2 +-
>   linux-user/mips/cpu_loop.c                         |   9 +-
>   linux-user/or1k/cpu_loop.c                         |   2 +-
>   linux-user/ppc/cpu_loop.c                          |  10 +-
>   linux-user/riscv/cpu_loop.c                        |   2 +-
>   linux-user/s390x/cpu_loop.c                        |   2 +-
>   linux-user/sh4/cpu_loop.c                          |   2 +-
>   linux-user/sparc/cpu_loop.c                        |   4 +-
>   linux-user/syscall.c                               |  16 +++
>   linux-user/xtensa/cpu_loop.c                       |   1 +
>   plugins/api.c                                      |  42 ++++++-
>   plugins/core.c                                     |  50 ++++++--
>   scripts/qemu-plugin-symbols.py                     |   9 +-
>   tests/tcg/arm/Makefile.target                      |   6 +
>   tests/tcg/hexagon/Makefile.target                  |   8 ++
>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>   .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
>   .../{ => plugin}/test-plugin-mem-access.c          |   0
>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 134 +++++++++++++++++++++
>   tests/tcg/plugins/meson.build                      |   2 +
>   tests/tcg/plugins/registers.c                      |  79 ++++++++++++
>   tests/tcg/plugins/setpc.c                          | 109 +++++++++++++++++
>   33 files changed, 514 insertions(+), 44 deletions(-)
> ---
> base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
> change-id: 20260303-setpc-v5-c1df30bad07f

This was merged into master (2d3f78269a14a389aefecba28decd16dd5151802).
Thank you for your contribution!

Regards,
Pierrick

