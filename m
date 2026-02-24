Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091ECF4BB84
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 20:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuynk-0001Rx-IH; Tue, 24 Feb 2026 15:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuynh-0001Ro-OR
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:14:33 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuynf-00078y-GY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:14:33 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-824b5f015bcso5632932b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 12:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771964070; x=1772568870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eKY8PrpcoSdypHR1Kxu3mbhrRQnJKap30Z7g+DcZFl0=;
 b=hb1BaYjjZfX4BlguFxfFyHEH5aAyFsC7QYBV4nGMdg8icMvxjOc6pIIof3M5N5n9wQ
 rZlApV/k7li1+uL3W6WpKcgzGrqycY4iI8CBXwVkWo/qliEWJCF4zOsubCSMGW8Rh6LY
 Rcn6muRBmmcJ0lpmjK6Ag52yozu7iQpvuBjBpGhgoOK7BnRwSdSdMUPI6YCraE1UzLNy
 wq84JJhIK63XnD0Tq4pKKkojjy3kVsy4QBuimWlVKFIMWGdtCOuPX/12WvzJ1JhdA/yr
 glCJ7NpvEcUr4BMr25iJB/Cu6Nh7mBrRRQnRLWPRreh1N7smXXBU25ZKCjsEwbuKyNBI
 n/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771964070; x=1772568870;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eKY8PrpcoSdypHR1Kxu3mbhrRQnJKap30Z7g+DcZFl0=;
 b=dQsJZ8dDsHdUDtd64Pob5zAZj+3oVyEUa03kNj5hs1VmxsTPz5eb8/H48eIa5M9sFd
 cyJSKOGRTX4iOwkFxtZhJo180C6l3loYiS9QwG4ESSPpm7pQ3NP/g3xCZCdJoXaZhZEe
 ibsNG35wLTrFW3RwenMjlL7pka+3n6H8JP4ls94nMbdDA5Ns0geNZPzDtsf7PZg05Kza
 BKZsnGyONMma5AvrJNB1l13AEnjBo91ozPJDKpezApyJWa1TG/odMaYoGWcDinEtIZhA
 2ZLDfXlKHSmpSVnlcJFR7R1VXvkGs6KYMEDkvYYyycBF9sVRIU4Rqn4K5M7mCZhb/7Zv
 UNjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQW20jTv19LekqXdktVFDGtKEvLyyoX58GdFAOZcQz0Funi5jAdNTCDQvFUlzn/NhcB3lHGExpg8O8@nongnu.org
X-Gm-Message-State: AOJu0YzKoRsSCk9atbnlvevXX4NePppwO2akdwXI+R4z+vLGCguonem3
 bCij3TtPdsiAsoLFUHT8eCkdheVs8qZI+9QIF7RaXgRD6b1vW3/YY1R6OCf0QjoqiZo=
X-Gm-Gg: ATEYQzzQUPM/ENwzaQIwX6pEixrAJ9hmMip52Iejw6kCpBlkbh8ZzixE5hJCA/5iSly
 NyUfIbyMrtzWVqqcntacNIE55Nu/bZRuX1JU79dkNz5NrY/3afzBynMe1NKwJhxufTFRBfsFpxz
 IhLd9N+HoYeYjonHU+sxRl+l6QP6EbRFUsxtcsOOZ6hRggrxxqJ84Z2yOZxnTbqE/7vRUtYRSfy
 KTnFQYD4v3xpQEzeS39lxXwADHoTdtjayNpCRfAHnJfCiSa6UOeEEl0eT7xjFM6KjXQkdxSd6MV
 I+P7yU+I2uXkr6eScz3ea7VfdFo1l2hDryKmUkr/0YFaeVNX8m/S7dC45krowdPTZBhYU/FkhOj
 mq732GOcah8NuGQABTikpDuCfvox3xgLzkKIeTu6p/aHviw+lbzXbOVSH4lqjgGVyjjfb+lUFQW
 jnmrFWLoxz6EgBD1AwgvY5K7AD2k+V3UxunvB/eToU0+zk+g1E1BtqV/NELvvHsXn7x1vk
X-Received: by 2002:a05:6a00:4405:b0:81e:f623:b9fe with SMTP id
 d2e1a72fcca58-826da8c0e12mr11906407b3a.4.1771964069958; 
 Tue, 24 Feb 2026 12:14:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd64367bsm11683671b3a.4.2026.02.24.12.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 12:14:28 -0800 (PST)
Message-ID: <6ffd1660-b521-4352-98fc-93a0114b84be@linaro.org>
Date: Tue, 24 Feb 2026 12:14:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Enable PC diversion via the plugin API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/24/26 7:46 AM, Florian Hofhammer wrote:
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
> GDB XMLs, but that would (1) make syncing with GDB harder, (2) not cover
> all architectures, as there's not an XML description of all
> architectures available in the gdb-xml/ directory, and (3) require quite
> some changes to the whole GDB infrastructure in gdbstub/ to even encode
> the attribute in the correct structs and pass them on over the different
> layers up into the plugin API.
> 
> This version v4 of the patch series is more about small refactorings and
> cleanups than changes in functionality.
> 
> Best regards,
> Florian
> 
> Changes:
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
> 
> Florian Hofhammer (7):
>    plugins: add flag to specify whether PC is rw
>    linux-user: make syscall emulation interruptible
>    plugins: add PC diversion API function
>    tests/tcg: add test for qemu_plugin_set_pc API
>    plugins: add read-only property for registers
>    plugins: prohibit writing to read-only registers
>    tests/tcg/plugins: test register readonly feature
> 
>   include/plugins/qemu-plugin.h                 | 18 +++++
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
>   linux-user/or1k/cpu_loop.c                    |  2 +-
>   linux-user/ppc/cpu_loop.c                     |  6 +-
>   linux-user/riscv/cpu_loop.c                   |  2 +-
>   linux-user/s390x/cpu_loop.c                   |  2 +-
>   linux-user/sh4/cpu_loop.c                     |  2 +-
>   linux-user/sparc/cpu_loop.c                   |  4 +-
>   linux-user/syscall.c                          | 16 +++++
>   linux-user/xtensa/cpu_loop.c                  |  3 +
>   plugins/api.c                                 | 43 ++++++++++--
>   plugins/core.c                                | 29 ++++----
>   tests/tcg/arm/Makefile.target                 |  6 ++
>   tests/tcg/hexagon/Makefile.target             |  7 ++
>   tests/tcg/mips/Makefile.target                |  6 +-
>   tests/tcg/mips64/Makefile.target              | 15 ++++
>   tests/tcg/mips64el/Makefile.target            | 15 ++++
>   tests/tcg/mipsel/Makefile.target              | 15 ++++
>   tests/tcg/multiarch/Makefile.target           | 22 +++++-
>   .../{ => plugin}/check-plugin-output.sh       |  0
>   .../{ => plugin}/test-plugin-mem-access.c     |  0
>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++
>   tests/tcg/plugins/meson.build                 |  1 +
>   tests/tcg/plugins/registers.c                 | 68 +++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   |  6 ++
>   tests/tcg/sparc64/Makefile.target             | 16 +++++
>   36 files changed, 331 insertions(+), 41 deletions(-)
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
> base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8

A few small nits reported by checkpatch.

$ ./scripts/checkpatch.pl $(git merge-base upstream/master HEAD)..HEAD

1/8 Checking commit 23b2901d559b (plugins: add flag to specify whether 
PC is rw)
2/8 Checking commit cf46ff49010c (linux-user: make syscall emulation 
interruptible)
WARNING: Block comments use a leading /* on a separate line
#217: FILE: linux-user/mips/cpu_loop.c:144:
+                /* Returning from a successful sigreturn syscall or from

WARNING: Block comments use * on subsequent lines
#218: FILE: linux-user/mips/cpu_loop.c:145:
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.

WARNING: Block comments use a leading /* on a separate line
#247: FILE: linux-user/ppc/cpu_loop.c:345:
+                /* Returning from a successful sigreturn syscall or from

WARNING: Block comments use * on subsequent lines
#248: FILE: linux-user/ppc/cpu_loop.c:346:
+                /* Returning from a successful sigreturn syscall or from
+                   control flow diversion in a plugin callback.

3/8 Checking commit 2bb085851ee5 (plugins: add PC diversion API function)
4/8 Checking commit 3001ad67e7e5 (tests/tcg: add test for 
qemu_plugin_set_pc API)
ERROR: New file 'tests/tcg/mips64/Makefile.target' requires 
'SPDX-License-Identifier'
ERROR: New file 'tests/tcg/mips64el/Makefile.target' requires 
'SPDX-License-Identifier'
ERROR: New file 'tests/tcg/mipsel/Makefile.target' requires 
'SPDX-License-Identifier'
ERROR: open brace '{' following function declarations go on the next line
#216: FILE: tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c:15:
+void exit_success(void) {

ERROR: open brace '{' following function declarations go on the next line
#220: FILE: tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c:19:
+int main(int argc, char *argv[]) {

ERROR: New file 'tests/tcg/sparc64/Makefile.target' requires 
'SPDX-License-Identifier'

5/8 Checking commit c85ae80717dc (plugins: add read-only property for 
registers)
ERROR: do not use C99 // comments
#45: FILE: plugins/api.c:413:
+static const char pc_str[] = "pc"; // generic name for program counter

ERROR: do not use C99 // comments
#46: FILE: plugins/api.c:414:
+static const char eip_str[] = "eip"; // x86 specific name for program 
counter

ERROR: do not use C99 // comments
#47: FILE: plugins/api.c:415:
+static const char rip_str[] = "rip"; // x86_64 specific name for 
program counter

ERROR: do not use C99 // comments
#48: FILE: plugins/api.c:416:
+static const char pswa_str[] = "pswa"; // s390x specific name for 
program counter

ERROR: do not use C99 // comments
#49: FILE: plugins/api.c:417:
+static const char iaoq_str[] = "iaoq"; // HP/PA specific name for 
program counter

ERROR: do not use C99 // comments
#50: FILE: plugins/api.c:418:
+static const char rpc_str[] = "rpc"; // microblaze specific name for 
program counter


6/8 Checking commit 156dc74ab9a5 (plugins: prohibit writing to read-only 
registers)
7/8 Checking commit dba748c1e46c (tests/tcg/plugins: test register 
readonly feature)
ERROR: New file 'tests/tcg/plugins/registers.c' requires 
'SPDX-License-Identifier'
ERROR: New file 'tests/tcg/plugins/registers.c' must not have license 
boilerplate header text, only the SPDX-License-Identifier, unless this 
file was copied from existing code already having such text.

Regards,
Pierrick

