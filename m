Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43816D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkS5x-0000tk-U0; Mon, 26 Jan 2026 14:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkS5w-0000rm-O1
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:17:52 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkS5u-00017A-Ky
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:17:52 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82318b640beso1773316b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769455069; x=1770059869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CjHC9gZI9QcB0itwXIxyfTFoVfqFyAs4oQkobhxv3d0=;
 b=MQzCqLBptpbN3pz+1G1w7CTuiJoxMQpdTqUJdHbDdkjSW5i4eR7fyaAXxcXVL8VPLr
 ZhjvzyKkWdmKoxV3+Cvj1ulJqOIrSSibi5cBdx6eFNCNssAc3xhrj20cgqcHbdRhXApc
 ic2QQ+IpiWL8v1x9FqafIjvVQmxCgw/T3Gu7MBFcfvvb45p18Y2JDm45vQFoWm/QQmdR
 B+uYakNivjNTRATh7C4YbI/x2NMPdGdLsVhoAluGwQC/i5rQEB2OoajuHga07iDh1MET
 NmLuOwY9XmpyONCxJOq1eSfl14jZ+Bn/VMbs76JgPTGdcKzx4KTUfJwkWqXZOhjo3Onk
 NOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769455069; x=1770059869;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjHC9gZI9QcB0itwXIxyfTFoVfqFyAs4oQkobhxv3d0=;
 b=L49APXxCQHS0iHQQecAOe2SgaHm5YsGDd29f2ucDW9KnP78l/x8A5/ZTqdFlGzHTuN
 EM/ZbN0Pg9uaRO8qQSLkEz5zBwj39U/JIm/vkfFKGD807X7wo597/kw8j43lLPtfBiRD
 D0TolxIhsxtYUWvk6LC9S4CqECR95/WoMdQoVeYMJllk3KNZtFk+Ob4g1QangydUE+N5
 zx+pPrgA54FIA0wmOAF9PuQHxHKkVDJ90KEjonX2ZxEnVj4vSWxUabf+uMcJ8z2hzdnE
 R/7xeAUs1wTCrDmQnOl5oMWRf0nDM+Kjff0ObUfKIPXOKcGZkEa1qiOLGqPYZ/JGQjXX
 haUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRdqcaYmoAcWL8HDwsIRqnyGzXzssPQKYoKRgzu4RsAVcSmHabFFxz6Q6102fbe2HoA7g+p/4Hh+T3@nongnu.org
X-Gm-Message-State: AOJu0Yy53jBlYNjVcX1ItZ/DQXk+IFN4SGZe4iW82e5UyPhZ5EYXDY6u
 yz3rQ7oV2jkmhpH/fVisPe8OkelGeNvlRsEYjc7aypG1WY6vRAkJLW1FkAQ7yoeuAyI=
X-Gm-Gg: AZuq6aJzA8GAGYxo5GM4aUeVpVZmYZKA337YyEGybqmpUQazsMKbTIES09WDw55a65O
 Gyr0nXu4Z2Y2CciQBMBhbrTFxkeIAjl2hLPGHJkFRwPY8L6dQiGsLrdnR8JUnS9ree1yCQfdYSK
 76xBx2l0AXFNKUoF/6dEyHP/EddQyO2uByHxmGPrRoOWw8Y+p0hQ17E2+0X+W7OVto+/mib+Ffj
 TH6yr94C6MWPTrC21sjvQ/U3nVUEHtZHws53azOPZpPpezyWrtJE7RhE4s/+ziy4wToaKaHtF8m
 OoVzDEmn43zOa6zT+ahBf1dWP6esQ8GkRBJmszsN1JuUPEhgYrOyn7OJnx5/BgWaU/PHcxz8/h5
 O+0G5nWp080air1rXxuCcd7tFpXXSnnqHObXCBsippRrTRDwDGIsC+oh9gUs7w+uTlBH9mijDDc
 A7YSwY31OuMGbwKC7TKXWsrGyB34Prgg7VXg4n403IEh9mgLCFp/uXol/V
X-Received: by 2002:a05:6a00:1d9b:b0:823:1d10:cf04 with SMTP id
 d2e1a72fcca58-823412be5c5mr3909068b3a.55.1769455068922; 
 Mon, 26 Jan 2026 11:17:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231876fd1fsm9961566b3a.69.2026.01.26.11.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 11:17:48 -0800 (PST)
Message-ID: <a6e5c00e-1ac7-4d5a-ae5d-e53e0cc829fd@linaro.org>
Date: Mon, 26 Jan 2026 11:17:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Enable PC diversion via the plugin API
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
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

On 1/20/26 7:19 AM, Florian Hofhammer wrote:
> Hi,
> 
> This patch series builds on top of the discussion from the thread at
> https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch/
> and adds a plugin API function to set the program counter of the guest,
> as just writing to it via qemu_plugin_write_register() has no direct
> effect.
> 
> Based on the discussion in the above thread, the series also introduces
> a means to declare registers as read-only from the plugin side, which
> prevents plugins from writing to them via qemu_plugin_write_register().
> This for now is only applied to the PC, and finding the PC register is
> done via some rather hacky strcmp()s. In the above thread, we also
> discussed encoding the read-only property in a custom attribute in the
> GDB XMLs, but that would (1) make syncing with GDB harder, (2) not
> cover all architectures, as there's not an XML description of all
> architectures available in the gdb-xml/ directory, and (3) require quite
> some changes to the whole GDB infrastructure in gdbstub/ to even encode
> the attribute in the correct structs and pass them on over the different
> layers up into the plugin API.
> 
> This patch series does not (yet) bump the plugin API version, as I've
> sent another patch yesterday (see
> https://lore.kernel.org/qemu-devel/f877dd79-1285-4752-811e-f0d430ff27fe@fhofhammer.de/)
> that makes some changes to qemu_plugin_{read,write}_register() as well
> and I'll adjust the plugin API version bump and API usage in a v4 once I
> have an idea whether the patches will make it into a release or not to
> avoid conflicts later on.
> 
> Best regards,
> Florian
> 
> Changes:
> v3:
> - make PC registers read-only across architectures
> - add tests for read-only registers
> - adjust test structure for qemu_plugin_set_pc() by moving
>    architecture-specific tests into corresponding directories
> v2:
> - add setjmp() in syscall handling path to allow PC redirection from
>    syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
>    exiting a TB would not be live anymore in syscall handlers)
> - add flags to ensure the qemu_plugin_set_pc() API is only called from
>    contexts where the CPU is live
> - add test for qemu_plugin_set_pc() API
> v1:
> - initial version
> 
> Florian Hofhammer (5):
>    plugins: add PC diversion API function
>    plugins: add read-only property for registers
>    plugins: prohibit writing to read-only registers
>    tests/tcg: add test for qemu_plugin_set_pc API
>    tests/tcg/plugins: test register readonly feature
> 
>   include/qemu/qemu-plugin.h                    | 17 +++++
>   linux-user/aarch64/cpu_loop.c                 |  2 +-
>   linux-user/alpha/cpu_loop.c                   |  2 +-
>   linux-user/arm/cpu_loop.c                     |  2 +-
>   linux-user/hexagon/cpu_loop.c                 |  2 +-
>   linux-user/hppa/cpu_loop.c                    |  4 ++
>   linux-user/i386/cpu_loop.c                    |  8 ++-
>   linux-user/include/special-errno.h            |  8 +++
>   linux-user/loongarch64/cpu_loop.c             |  5 +-
>   linux-user/m68k/cpu_loop.c                    |  2 +-
>   linux-user/microblaze/cpu_loop.c              |  2 +-
>   linux-user/mips/cpu_loop.c                    |  5 +-
>   linux-user/openrisc/cpu_loop.c                |  2 +-
>   linux-user/ppc/cpu_loop.c                     |  6 +-
>   linux-user/riscv/cpu_loop.c                   |  2 +-
>   linux-user/s390x/cpu_loop.c                   |  2 +-
>   linux-user/sh4/cpu_loop.c                     |  2 +-
>   linux-user/sparc/cpu_loop.c                   |  4 +-
>   linux-user/syscall.c                          |  8 +++
>   linux-user/xtensa/cpu_loop.c                  |  3 +
>   plugins/api.c                                 | 41 +++++++++--
>   plugins/core.c                                | 25 ++++---
>   tests/tcg/arm/Makefile.target                 |  6 ++
>   tests/tcg/hexagon/Makefile.target             |  7 ++
>   tests/tcg/mips/Makefile.target                |  6 +-
>   tests/tcg/mips64/Makefile.target              | 15 ++++
>   tests/tcg/mips64el/Makefile.target            | 15 ++++
>   tests/tcg/mipsel/Makefile.target              | 15 ++++
>   tests/tcg/multiarch/Makefile.target           | 20 +++++-
>   .../{ => plugin}/check-plugin-output.sh       |  0
>   .../{ => plugin}/test-plugin-mem-access.c     |  0
>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++
>   tests/tcg/plugins/meson.build                 |  2 +-
>   tests/tcg/plugins/registers.c                 | 71 +++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   |  6 ++
>   tests/tcg/sparc64/Makefile.target             | 16 +++++
>   36 files changed, 321 insertions(+), 38 deletions(-)
>   create mode 100644 tests/tcg/mips64/Makefile.target
>   create mode 100644 tests/tcg/mips64el/Makefile.target
>   create mode 100644 tests/tcg/mipsel/Makefile.target
>   rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
>   rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>   create mode 100644 tests/tcg/plugins/registers.c
>   create mode 100644 tests/tcg/sparc64/Makefile.target
> 
> 
> base-commit: 38879a667fbb4ef54c70de71494882615f600a64

Thanks for posting Florian.

I'll let Alex review it to see if it matches his original vision, and 
the readonly approach for pc register.

Regards,
Pierrick

