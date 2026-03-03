Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E56EDEBEA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVh8-0008By-RS; Tue, 03 Mar 2026 14:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxVh1-00088l-0X
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:46:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxVgy-00014F-CM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:46:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ae4988e039so18897165ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772567163; x=1773171963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rh+qD60CnqTgO9lcS/lSBXoU6oSU+vhZ8bqx7gfpYvI=;
 b=HA6FT3ZVQVugCmkzF8rh5mx4mBIH6GWTXcnhWi2Nb17uE6WzThHgKKjS2KsMFr87lJ
 MKtuadmOpDTXKJZLtud6t9d5W/LlxmIVuwlZ8cTn/VV106Wc9nEma6KThrYpbovcYeOZ
 vT8qxgqVQtbWhVTFJ+L27Uzgo3O+XS+PKVh3olMzcJMwWqK9uRk+UPzPPSQQNDphVz8x
 fFVbzmP9tzewU8tFKZWr2YMmiNdKMFuaduY2SCtbTELG+M4/o8zeV5FvfXAny95u16yU
 nVgMTKy1oagdzZPfpCMpKl9/UoCWdmSL3Sa/HStaCbRBuiz2QHgKaek4rhJnEKzyaGcs
 /Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567163; x=1773171963;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rh+qD60CnqTgO9lcS/lSBXoU6oSU+vhZ8bqx7gfpYvI=;
 b=HAyrwyfQ5S9/tr+4fb1Y+XlalEbmh/nGaofbQeZb1lf4rD2ZA7NME56x6N/hiUnW2n
 M7PoL+OgOZSAR8FQL8deMJJg3mLkUwATIwZqBMTMHGGbargUPXAO+Ms0q926t01Hzmci
 cxBnPjR1DWOK+x1eg1vQ1DGe4ktrSg+j7m7cHV1nMg74WJSKimTeAZYeZrWB7Ve1M72m
 r+u18fBT5HbFxAvKcLGyhv7itX0S6N1viu2VJWusQ1iSmXlnv0nZHXNm5gC47UKAY5Yd
 oDVIBFE2Lfk1MBghPtOgP64G2PYX9n2LUWRNEmbkMiwQX/DlrKJV3Clvqk/PoM0/r9LD
 CORQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8dGBlipVVZ/KNkFZ2XceeZ85rxVGSVP9uLiPb/8ybRdMKihQYSNEf43CFfU44KJkPkFHs1/BSse07@nongnu.org
X-Gm-Message-State: AOJu0YyGtNrGZ0V09ZU6lSVrBqZPMGO7/+HYpmlE5Wl81+v4UXSU3npA
 2eCMVWGYpKV62P/sDN5v7cka260w4xAc9JyMBFkoj60QZTGHxEbN5tki53znjoUnMe0=
X-Gm-Gg: ATEYQzwuJ6qXV8I1Wu8r6VNiZk3r59oPCojv4p9qF/9JP5cjX5e7IbO+htCy24StikP
 FPEQ09XifbCQiEU4yGWsb7KYjoAbZfqTCpAat5cVSBHUZuteBke7C/GeP8LEZopzHhKA07LfQ7A
 jrArm5Y7uV0voax28GukYsL0xIU8skRa1qhI0R5uJzlyQOzEmJg5PC0Kg3bTt+WsFqgnvUiTlIM
 it1HArNJSCNb2xMr0k/Pv+M80ARyvCMDKVlm9+gKz1cuiVOxpjpHD5XUhYcUpV4/bmT+XXbg1ac
 3teIsdrB1Jyzci/klw4Wnjamukfn04kKqeaLGUBJuCXZiPMcHKoMAXsh7Z+Rpjny49aFvtAg8PN
 F5NTPkbHoiOdeOkS8w6VYn/KyZg4DN2+pu2K6/O7lRGmV+6vhrLV0b6p2K9JLAchYRPxf1WeK0p
 PhHuyoAF5HL9zFpz4VHlRayQ3iF1MzUogeyqknE4UiZtUiL0o50vo4skBnCEIcbEOWkIqP
X-Received: by 2002:a17:903:4765:b0:2aa:d2f4:9c11 with SMTP id
 d9443c01a7336-2ae60c60e17mr32453325ad.5.1772567162271; 
 Tue, 03 Mar 2026 11:46:02 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm89126065ad.54.2026.03.03.11.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 11:46:01 -0800 (PST)
Message-ID: <430d1aa6-c36c-4399-8e5f-b38a9ae1bd35@linaro.org>
Date: Tue, 3 Mar 2026 11:46:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] tests/tcg: add tests for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/3/26 5:07 AM, Florian Hofhammer wrote:
> The test plugin intercepts execution in different contexts. Without the
> plugin, any of the implemented test functions would trigger an assert
> and fail. With the plugin, control flow is redirected to skip the assert
> and return cleanly via the qemu_plugin_set_pc() API.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   MAINTAINERS                                        |   1 +
>   tests/tcg/arm/Makefile.target                      |   6 +
>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>   .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
>   .../{ => plugin}/test-plugin-mem-access.c          |   0
>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++++++++++++
>   tests/tcg/plugins/meson.build                      |   1 +
>   tests/tcg/plugins/setpc.c                          | 120 ++++++++++++++++++
>   8 files changed, 282 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6698e5ff69..63c0af4d86 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4104,6 +4104,7 @@ S: Maintained
>   F: docs/devel/tcg-plugins.rst
>   F: plugins/
>   F: tests/tcg/plugins/
> +F: tests/tcg/multiarch/plugin/
>   F: tests/functional/aarch64/test_tcg_plugins.py
>   F: contrib/plugins/
>   F: scripts/qemu-plugin-symbols.py
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
> index 6189d7a0e2..613bbf0939 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -78,4 +78,10 @@ sha512-vector: sha512.c
>   
>   ARM_TESTS += sha512-vector
>   
> +ifeq ($(CONFIG_PLUGIN),y)
> +# Require emitting arm32 instructions, otherwise the vCPU might accidentally
> +# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
> +test-plugin-set-pc: CFLAGS+=-marm
> +endif
> +

Is that still needed?

>   TESTS += $(ARM_TESTS)
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index 07d0b27bdd..a347efbadf 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
>   VPATH 	       += $(MULTIARCH_SRC)/linux
>   MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
>   endif
> +ifeq ($(CONFIG_PLUGIN),y)
> +VPATH 	       += $(MULTIARCH_SRC)/plugin
> +MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
> +endif
>   MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
>   
>   #
> @@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>   	PLUGIN_ARGS=$(COMMA)print-accesses=true
>   run-plugin-test-plugin-mem-access-with-libmem.so: \
>   	CHECK_PLUGIN_OUTPUT_COMMAND= \
> -	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
> +	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
>   	$(QEMU) $<
>   run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
> +run-plugin-test-plugin-set-pc-with-libsetpc.so:
>   
>   EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
> -			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
> -else
> +			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so \
> +			  run-plugin-test-plugin-set-pc-with-libsetpc.so
> +
> +else # CONFIG_PLUGIN=n
> +# Do not build the syscall skipping test if it's not tested with the setpc
> +# plugin because it will simply fail the test.
> +MULTIARCH_TESTS := $(filter-out test-plugin-set-pc, $(MULTIARCH_TESTS))
> +
>   # test-plugin-syscall-filter needs syscall plugin to succeed
>   test-plugin-syscall-filter: CFLAGS+=-DSKIP
>   endif
> diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
> similarity index 100%
> rename from tests/tcg/multiarch/check-plugin-output.sh
> rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/plugin/test-plugin-mem-access.c
> similarity index 100%
> rename from tests/tcg/multiarch/test-plugin-mem-access.c
> rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
> diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
> new file mode 100644
> index 0000000000..40d9a9e8f0
> --- /dev/null
> +++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
> @@ -0,0 +1,140 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
> + *
> + * This test set exercises the qemu_plugin_set_pc() function in four different
> + * contexts:
> + * 1. in a syscall callback,
> + * 2. in an instruction callback during normal execution,
> + * 3. in an instruction callback during signal handling,
> + * 4. in a memory access callback.
> + * Note: using the volatile guards is necessary to prevent the compiler from
> + * doing dead code elimination even on -O0, which would cause everything after
> + * the asserts and thus also the target labels to be optimized away.
> + */
> +#include <assert.h>
> +#include <signal.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <setjmp.h>
> +
> +#define NOINLINE __attribute__((noinline))

Test being compiled in O0, it should not need any noinline attribute.

> +#define NORETURN __attribute__((noreturn))

It's used in a single place, simply move the the attribute there, no 
need for another define.

> +
> +static int signal_handled;
> +/*
> + * The volatile variable is used as a guard to prevent the compiler from
> + * optimizing away "unreachable" labels.
> + */
> +static volatile uint32_t guard = 1;
> +

As mentioned on v4, you can simply use an external function for failing 
the test, which won't be tainted with noreturn attribute.
This way, you don't need any guard at all or assert(0), and resulting 
code is linear and easier to read.
It test completes, it all worked. If it crashes, something was wrong.

void panic(void)
{
      g_assert_not_reached();
}

void test_...() {
...
on_panic:
      panic();
after_panic:
      printf("Hello World\n");
}

> +/*
> + * This test executes a magic syscall which communicates two addresses to the
> + * plugin via the syscall arguments. Whenever we reach the "bad" instruction
> + * during normal execution, the plugin should redirect control flow to the
> + * "good" instruction instead.
> + */
> +NOINLINE void test_insn(void)
> +{
> +    long ret = syscall(4095, &&bad_insn, &&good_insn, NULL);
> +    assert(ret == 0 && "Syscall filter did not return expected value");
> +    if (guard) {
> +bad_insn:
> +        assert(0 && "PC redirection in instruction callback failed");
> +    } else {
> +good_insn:
> +        return;
> +    }
> +}
> +
> +/*
> + * This signal handler communicates a "bad" and a "good" address to the plugin
> + * similar to the previous test, and skips to the "good" address when the "bad"
> + * one is reached. This serves to test whether PC redirection via
> + * qemu_plugin_set_pc() also works properly in a signal handler context.
> + */
> +NOINLINE void usr1_handler(int signum)
> +{
> +    long ret = syscall(4095, &&bad_signal, &&good_signal, NULL);
> +    assert(ret == 0 && "Syscall filter did not return expected value");
> +    if (guard) {
> +bad_signal:
> +        assert(0 && "PC redirection in instruction callback failed");
> +    } else {
> +good_signal:
> +        signal_handled = 1;
> +        return;
> +    }
> +}
> +
> +/*
> + * This test sends a signal to the process, which should trigger the above
> + * signal handler. The signal handler should then exercise the PC redirection
> + * functionality in the context of a signal handler, which behaves a bit
> + * differently from normal execution.
> + */
> +NOINLINE void test_sighandler(void)
> +{
> +    struct sigaction sa = {0};
> +    sa.sa_handler = usr1_handler;
> +    sigaction(SIGUSR1, &sa, NULL);
> +    pid_t pid = getpid();
> +    kill(pid, SIGUSR1);
> +    assert(signal_handled == 1 && "Signal handler was not executed properly");
> +}
> +
> +/*
> + * This test communicates a "good" address and the address of a local variable
> + * to the plugin. Upon accessing the local variable, the plugin should then
> + * redirect control flow to the "good" address via qemu_plugin_set_pc().
> + */
> +NOINLINE void test_mem(void)
> +{
> +    long ret = syscall(4095, NULL, &&good_mem, &guard);

Since you use two different syscall numbers, it's worth adding two 
defines, that you will duplicate in test and plugin.
Alternatively, you can use the first parameter of syscall to identify 
which kind of "service" you want from plugin, with defines duplicated 
between test and plugin again.
Feel free to pick the solution you prefer.

Reading 4095 the first time here felt like it was a typo mistake.

> +    assert(ret == 0 && "Syscall filter did not return expected value");
> +    if (guard) {
> +        assert(0 && "PC redirection in memory access callback failed");
> +    } else {
> +good_mem:
> +        return;
> +    }
> +}
> +
> +/*
> + * This test executes a magic syscall which is intercepted and its actual
> + * execution skipped via the qemu_plugin_set_pc() API. In a proper plugin,
> + * syscall skipping would rather be implemented via the syscall filtering
> + * callback, but we want to make sure qemu_plugin_set_pc() works in different
> + * contexts.
> + */
> +NOINLINE NORETURN
> +void test_syscall(void)
> +{
> +    syscall(4096, &&good_syscall);
> +    if (guard) {
> +        assert(0 && "PC redirection in syscall callback failed");
> +    } else {
> +good_syscall:
> +        /*
> +         * Note: we execute this test last and exit straight from here because
> +         * when the plugin redirects control flow upon syscall, the stack frame
> +         * for the syscall function (and potential other functions in the call
> +         * chain in libc) is still live and the stack is not unwound properly.
> +         * Thus, returning from here is risky and breaks on some architectures,
> +         * so we just exit directly from this test.
> +         */
> +        _exit(EXIT_SUCCESS);
> +    }
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +    test_insn();
> +    test_sighandler();
> +    test_mem();
> +    test_syscall();
> +}
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index c5e49753fd..b3e3a9a6d0 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -7,6 +7,7 @@ test_plugins = [
>   'mem.c',
>   'patch.c',
>   'reset.c',
> +'setpc.c',
>   'syscall.c',
>   ]
>   
> diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
> new file mode 100644
> index 0000000000..72ae31a0ef
> --- /dev/null
> +++ b/tests/tcg/plugins/setpc.c
> @@ -0,0 +1,120 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
> + */
> +#include <assert.h>
> +#include <glib.h>
> +#include <inttypes.h>
> +#include <unistd.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +static uint64_t source_pc;
> +static uint64_t target_pc;
> +static uint64_t target_vaddr;
> +
> +static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
> +                         int64_t num, uint64_t a1, uint64_t a2,
> +                         uint64_t a3, uint64_t a4, uint64_t a5,
> +                         uint64_t a6, uint64_t a7, uint64_t a8)
> +{
> +    if (num == 4096) {
> +        qemu_plugin_outs("Marker syscall detected, jump to clean return\n");
> +        qemu_plugin_set_pc(a1);
> +    }
> +}
> +
> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
> +                                int64_t num, uint64_t a1, uint64_t a2,
> +                                uint64_t a3, uint64_t a4, uint64_t a5,
> +                                uint64_t a6, uint64_t a7, uint64_t a8,
> +                                uint64_t *sysret)
> +{
> +    if (num == 4095) {
> +        qemu_plugin_outs("Communication syscall detected, set target_pc / "
> +                         "target_vaddr\n");
> +        source_pc = a1;
> +        target_pc = a2;
> +        target_vaddr = a3;
> +        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63) {
> +            /*
> +             * Some architectures (e.g., m68k) use 32-bit addresses with the
> +             * top bit set, which causes them to get sign-extended somewhere in
> +             * the chain to this callback. We mask the top bits off here to get
> +             * the actual addresses.
> +             */

This looks like an actual bug. Using a backtrace here, can you find 
which function extended it?
Parameter should be treated as unsigned everywhere, else something is 
really going wrong.

> +            qemu_plugin_outs("High bit in addresses detected: possible sign "
> +                             "extension in syscall, masking off top bits\n");
> +            source_pc &= UINT32_MAX;
> +            target_pc &= UINT32_MAX;
> +            target_vaddr &= UINT32_MAX;
> +        }
> +        *sysret = 0;
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
> +{
> +    uint64_t vaddr = (uint64_t)userdata;
> +    if (vaddr == source_pc) {
> +        g_assert(target_pc != 0);
> +        g_assert(target_vaddr == 0);
> +
> +        qemu_plugin_outs("Marker instruction detected, jump to clean return\n");
> +        qemu_plugin_set_pc(target_pc);
> +    }
> +}
> +
> +static void vcpu_mem_access(unsigned int vcpu_index,
> +                            qemu_plugin_meminfo_t info,
> +                            uint64_t vaddr, void *userdata)
> +{
> +    if (vaddr != 0 && vaddr == target_vaddr) {
> +        g_assert(source_pc == 0);
> +        g_assert(target_pc != 0);
> +        qemu_plugin_mem_value val = qemu_plugin_mem_get_value(info);
> +        /* target_vaddr points to our volatile guard ==> should always be 1 */
> +        g_assert(val.type == QEMU_PLUGIN_MEM_VALUE_U32);
> +        g_assert(val.data.u32 == 1);
> +
> +        qemu_plugin_outs("Marker mem access detected, jump to clean return\n");
> +        qemu_plugin_set_pc(target_pc);
> +    }

Thanks for adding this case also!
So you'll definitely need a read for this precise test, to be able to 
keep a load. If it would work with a local variable, that's good, else, 
try with a local static (eventually marked volatile if it helps), and in 
last case, use a global variable.

> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t insns = qemu_plugin_tb_n_insns(tb);
> +    for (size_t i = 0; i < insns; i++) {
> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
> +        /*
> +         * Note: we cannot only register the callbacks if the instruction is
> +         * in one of the functions of interest, because symbol lookup for
> +         * filtering does not work for all architectures (e.g., ppc64).
> +         */

Too sad :)
It's not a problem to instrument all instructions though.

> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
> +                                               QEMU_PLUGIN_CB_RW_REGS_PC,
> +                                               (void *)insn_vaddr);
> +        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
> +                                         QEMU_PLUGIN_CB_RW_REGS_PC,
> +                                         QEMU_PLUGIN_MEM_R, NULL);
> +    }
> +}
> +
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +
> +    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    return 0;
> +}
> 

Thanks for the update.
Test looks good, and minus the style nits reported, it looks quite ready.
It would be nice if we could sort the signed parameter extension also to 
avoid a hack on this.

Regards,
Pierrick

