Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F07C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlntk-000737-RH; Mon, 20 Jul 2026 09:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlntT-0006yp-SG
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:18:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlntP-0001Er-Ip
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:18:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so2033309f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553526; x=1785158326; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gDfSSUpPFmGzYrWP+G121a4FEVFQYzCHGfzGBULlGCU=;
 b=V38pMca+Mf+oCH2vS6MM4LxoXOSpdLjIvqqg5PHGc1VtraSA664d4S5JBelk4Aaaki
 dUUn+GRaeYlErzkO747fFtjdqkFdhR7jQGzIBICBa76D7r01ghWUUVnMSQhycHHtkG/i
 8V8TnCqVD9QoRl4wYw4bPET2w0oFBLPThY851NBsPf7hcdUaG+B5cFt5yUwOH3OCDaSw
 N0TSaB4uvj5tqnRvPIz49m+7z5B5JRUXgTarbhB95Yb9DCO5727MukvLiCOIOsnrtJjt
 /MbA/teQVU9O47Quy1SoFWythvoMtapQSTcO6+YIOBwSViIaO9PGWV9DznOcfGQ1iN6a
 an7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553526; x=1785158326;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDfSSUpPFmGzYrWP+G121a4FEVFQYzCHGfzGBULlGCU=;
 b=ksUJ1y9OqfNp85Ds/oy4nNBOGXRXJAnkH6nBDzAlGUKzdb/QQ2amL4VjU4XLitRZxy
 PyjAHcCzm0xjoM0hl/QsMv7S26hmSx14zl7wvQyv067oMhRCCWk7u0YBEyacWXYlIt7p
 L+s1KrTSxWVEWOegpJ3Z+6RNDjb/vR8/tQSDXBH3nA77FIUO0FephaGJZSRrWLaCRgZv
 wWqJJEHjxRARY9VjWU0oRPaxd6EUIKVkAn3tYzDl2qXmflC15+qJEWoEqlgyh2SkQnOH
 krccKUJQSqs44u/fymXG1abXFezJsy+rvl3f1HHH7XUf9IQ4ZHKXixa2WrlxvRRrPAb2
 uR3w==
X-Gm-Message-State: AOJu0YzzNB5j2JitZ4gKGZlteq0vC5MqatcwXtMFMtTIiLMJaVmLd2yE
 GemiTfWS4OuGh7YUbefORjZ7klzqkbJrPqOM8TiUiIDY7671jXM2pfyCW0UfTUDJhIk=
X-Gm-Gg: AR+sD12bnA7hHDwpvJu/a6JndwfzENV9vafX+hcI62br1M074GgISxAkG2kb/FIVxgt
 8hz9FQfXktnzm7eV1WxpnJY3uztE3OCFxubSNsFXZo20ARibqbemgSUk1B70uHv/A6/EzhcvFEv
 qF9HG/7NvLPG3cKu8AcMkthStZYmihxOSGkGha0FUrmKSeLbjnTSLexPQSzbCpE6enE6IpK6KDP
 J4Yvve8CdXrPuiHx8aUE1UgGfea8tCr1m1gUy4JnMXyiBZVFhoyA6RiOJnLfMTgQPBkMFh7XrLI
 3MHNtWxJXr9pm5G2Fm818ghZYWvX6vXPo7+hLQFi2j1PKsjIUYyMF697xS4QbbsuphgqaZ2ynTN
 Wt5bKH10BPBgMhIoXQqY0MAzsrymCUgmCLGrJZUA5houzSvPzQ7tBsJ8efluFeFM8/KLHmKIEqU
 hDxg==
X-Received: by 2002:a05:6000:26cd:b0:47f:73e8:3f8c with SMTP id
 ffacd0b85a97d-47f73e8400dmr6457910f8f.14.1784553525442; 
 Mon, 20 Jul 2026 06:18:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm30839218f8f.24.2026.07.20.06.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:18:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F5AD5F911;
 Mon, 20 Jul 2026 14:18:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 00/98] tests/tcg: run tests with meson
In-Reply-To: <d6d19210-67e0-4995-8ca5-b5bdc41e16ee@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 10 Jul 2026 14:58:12 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <d6d19210-67e0-4995-8ca5-b5bdc41e16ee@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Mon, 20 Jul 2026 14:18:43 +0100
Message-ID: <87qzkxssss.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 7/10/2026 2:42 PM, Pierrick Bouvier wrote:
>> This series replaces TCG tests makefiles with meson, with the
>> goal of having something more readable and maintainable in the long term.
>> Also it closes the gap that tcg tests had with the rest of tests, by int=
egrating
>> them with meson directly.
>>=20
>> It covers all existing tests for all architectures, including
>> user/system/multiarch-user/multiarch-system. It implements all requireme=
nts
>> listed on original thread [1].
>>=20
>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>=20
>> We also have for free:
>> - correct and complete dependencies for any test, including:
>>   scripts, c.inc, headers, reference files and binaries/plugins.
>> - catch test declaration issues at configure time vs test time.
>> - proper data types for variables instead of string expansion with make.
>>=20
>> Series first introduce the meson machinery needed in tests/tcg/meson.bui=
ld, step
>> by step. Then it adds support for all existing archs. Finally, we remove
>> Makefiles and configure bits, and add documentation.
>>=20
>> Usage:
>>=20
>> ```
>> make check-tcg
>> make check-tcg-aarch64-linux-user
>> make check-tcg-aarch64-softmmu
>> make tcg-tests
>>=20
>> ninja tcg-tests
>> ninja clean
>> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
>> ```
>>=20
>> v5
>> --
>>=20
>> - remove Makefiles incrementally to ease review, as suggested by Philippe
>> - default timeout 120 (matching Makefile default)
>>=20
>> v4
>> --
>>=20
>> - rebase on top of master (Makefiles + Dockerfile changes)
>> - full CI pass on GitLab
>> - update documentation for tcg-tests
>> - check host cross cc is working (handle fedora cross compiler without r=
untime or
>>   headers)
>> - rename cc_docker_arch to cc_docker_host_arch
>> - add test added since v3: aarch64/fprcvt
>> - enable tricore system tests (was missing -kernel parameter)
>> - add xtensaeb system tests
>> - remove dependency from s390x/console.c to roms/SLOF submodule, which a=
llows to
>>   compile those tests without requiring the submodule.
>> - fix meson warnings (min version for test with external program in args=
 +
>>   s/source_root/project_source_root/)
>> - skip failing test gdb-prot-none on GitLab CI
>>=20
>> v3
>> --
>>=20
>> - add all architectures
>> - reduce number of plugins tests (only add one test for each plugin from
>>   multiarch pool)
>> - add depends for executable - allow to depend on a custom target for ge=
nerated
>>   headers (x86_64 mmx, avx)
>> - add new tests added since last version for aarch64 (mte + gpc)
>> - refactor series to keep all arch files at end
>> - add docker host architecture selection
>>=20
>> v2
>> --
>>=20
>> - s/mispell/misspell
>> - moved comment about why we remove 'lib' prefix for plugins
>> - if user declare a wrong entry in a dictionary, list possible keys
>> - build tests by default (with 'all' target), as long as cross compiler =
is
>>   natively installed, to avoid triggering a container build.
>> - reword some comments based on reviewers feedback
>> - always declare all tests and avoid "per config" errors (no 'if' in arc=
h files)
>> - move compiler feature and gdb version checks directly in tests/tcg/mes=
on.build
>> - add support for cross containers
>> - add top target 'tcg-tests' to rebuild all tests
>>=20
>> Pierrick Bouvier (98):
>>   tests/tcg/multiarch/system/memory.c: remove unused variable
>>   tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>>     input
>>   tests/tcg/multiarch/plugin: rename check-plugin-output to
>>     regex-compare
>>   meson: bump minimal version to 1.6.0
>>   tests/tcg: introduce meson.build
>>   tests/tcg/meson.build: introduce exe_name
>>   tests/tcg/meson.build: introduce test_name
>>   tests/tcg/meson.build: introduce cflags
>>   tests/tcg/meson.build: introduce qemu_args
>>   tests/tcg/meson.build: introduce env_var
>>   tests/tcg/plugins: build list of test_plugins
>>   tests/tcg/meson.build: introduce plugin_test
>>   tests/tcg/meson.build: test gdb support and introduce gdb_arch
>>   tests/tcg/meson.build: introduce gdb_test
>>   tests/tcg/meson.build: introduce wrapper
>>   tests/tcg/meson.build: introduce expected_output
>>   tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>>   tests/tcg/meson.build: add wrapper run_with_input
>>   tests/tcg/meson.build: add wrapper record_replay
>>   tests/tcg/meson.build: add wrapper check_plugin_output
>>   tests/tcg/meson.build: add logic to skip tests
>>   tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>>   tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>>   tests/tcg/meson.build: move gdb_arch support check
>>   tests/tcg/meson.build: let test infrastructure detect compiler
>>   tests/docker/docker.py: return error code if probe fails
>>   tests/docker/docker.py: remove "Image is up to date" info
>>   tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch
>>   tests/tcg/meson.build: check host cross cc is working
>>   tests/tcg/meson.build: introduce depends
>>   tests/tcg/meson.build: add top-level 'tcg-tests' target
>>   tests/tcg/Makefile: skip user/system tests if target Makefile is not
>>     present
>>   tests/tcg/multiarch/gdbstub/prot-none.py: deactivate on gitlab CI
>>   tests/tcg/multiarch: declare user tests
>>   tests/tcg/multiarch: declare system tests
>>   tests/tcg/meson.build: add generic plugin tests
>>   tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
>>   tests/tcg/aarch64: user tests
>>   tests/tcg/aarch64/system/gpc-test.c: remove unused variables
>>   tests/tcg/aarch64: system tests
>>   tests/tcg/aarch64_be: user tests
>>   tests/tcg/alpha: add float reference files
>>   tests/tcg/alpha: user tests
>>   tests/tcg/alpha: system tests
>>   tests/tcg/arm: user tests
>>   tests/tcg/arm: system tests
>>   tests/tcg/hexagon/overflow.c: add missing include
>>   tests/tcg/hexagon: user tests
>>   tests/tcg/multiarch/sha1.c: fix big endian implementation
>>   tests/tcg/hppa: add float reference files
>>   tests/tcg/hppa: user tests
>>   tests/tcg/i386: add missing float reference files
>>   tests/tcg/i386: user tests
>>   tests/tcg/i386: system tests
>>   tests/tcg/loongarch64: user tests
>>   tests/tcg/loongarch64: system tests
>>   tests/tcg/m68k: add float reference files
>>   tests/tcg/m68k: user tests
>>   scripts/probe-gdb-support.py: add mapping for mips architecture
>>   tests/tcg/mips: add float reference files
>>   test/tcg/mips: user tests
>>   tests/tcg/mips64: add float reference files
>>   tests/tcg/mips64: user tests
>>   tests/tcg/mips64el: add float reference files
>>   tests/tcg/mips64el: user tests
>>   tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
>>     toolchain
>>   tests/tcg/or1k/test_addic.c: remove unused variables
>>   tests/tcg/or1k/test_muli.c: remove set but unused variable
>>   tests/tcg/or1k: add float reference files
>>   plugins/api.c: identify or1k pc register and mark it as read only
>>   tests/tcg/or1k: user tests
>>   tests/tcg/ppc64: add float reference files
>>   tests/tcg/ppc64: remove dependency on qemu/compiler.h
>>   tests/tcg/ppc64: user tests
>>   tests/tcg/ppc64le: add missing float reference file
>>   tests/tcg/ppc64le: user tests
>>   tests/tcg/riscv64: add float reference files
>>   tests/tcg/riscv64: user tests
>>   tests/tcg/riscv64: system tests
>>   tests/tcg/s390x/head64.S: declare _exit symbol after main
>>   tests/tcg/s390x: add float reference files
>>   tests/tcg/s390x: user tests
>>   tests/tcg/s390x/console.c: directly implement memcpy and memset
>>   tests/tcg/s390x: system tests
>>   tests/tcg/sh4: add float reference files
>>   tests/tcg/sh4: user tests
>>   tests/tcg/tricore: system tests
>>   tests/tcg/x86_64: add missing float reference file
>>   tests/tcg/x86_64: user tests
>>   tests/tcg/x86_64: system tests
>>   tests/tcg/xtensa/crt.S: align .text section
>>   tests/docker/dockerfiles/debian-xtensa-cross.docker: add test_kc705_be
>>     toolchain for xtensaeb
>>   tests/tcg/xtensa: system tests
>>   tests/tcg/xtensa: xtensaeb system tests
>>   tests: remove tcg tests machinery
>>   tests/tcg: remove remaining Makefiles
>>   configure: remove --cross-cc* options
>>   docs/devel/testing/: update documentation
>>=20
>>  configure                                     | 473 ---------
>>  docs/devel/build-system.rst                   |   4 +-
>>  docs/devel/testing/main.rst                   |  55 +-
>>  meson.build                                   |   4 +-
>>  plugins/api.c                                 |   2 +
>>  pythondeps.toml                               |   2 +-
>>  scripts/probe-gdb-support.py                  |   1 +
>>  .../packagefiles/anyhow-1-rs/meson.build      |   2 +-
>>  .../arbitrary-int-1-rs/meson.build            |   2 +-
>>  .../packagefiles/attrs-0.2-rs/meson.build     |   2 +-
>>  .../packagefiles/bilge-0.2-rs/meson.build     |   2 +-
>>  .../bilge-impl-0.2-rs/meson.build             |   2 +-
>>  .../packagefiles/either-1-rs/meson.build      |   2 +-
>>  .../packagefiles/foreign-0.3-rs/meson.build   |   2 +-
>>  .../packagefiles/glib-sys-0.21-rs/meson.build |   2 +-
>>  .../itertools-0.11-rs/meson.build             |   2 +-
>>  .../packagefiles/libc-0.2-rs/meson.build      |   2 +-
>>  .../packagefiles/probe-0.5-rs/meson.build     |   2 +-
>>  .../proc-macro-error-1-rs/meson.build         |   2 +-
>>  .../proc-macro-error-attr-1-rs/meson.build    |   2 +-
>>  .../packagefiles/proc-macro2-1-rs/meson.build |   2 +-
>>  .../packagefiles/quote-1-rs/meson.build       |   2 +-
>>  subprojects/packagefiles/syn-2-rs/meson.build |   2 +-
>>  .../unicode-ident-1-rs/meson.build            |   2 +-
>>  tests/Makefile.include                        |  68 +-
>>  tests/docker/docker.py                        |   4 +-
>>  .../dockerfiles/debian-all-test-cross.docker  |  14 +-
>>  .../dockerfiles/debian-xtensa-cross.docker    |   4 +-
>>  tests/lcitool/refresh                         |  14 +-
>>  tests/meson.build                             |   2 +-
>>  tests/tcg/Makefile.target                     | 281 -----
>>  tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
>>  tests/tcg/aarch64/Makefile.target             | 210 ----
>>  tests/tcg/aarch64/meson.build                 | 207 ++++
>>  tests/tcg/aarch64/system/gpc-test.c           |   5 -
>>  tests/tcg/aarch64/system/meson.build          | 108 ++
>>  tests/tcg/aarch64_be/Makefile.target          |  17 -
>>  tests/tcg/aarch64_be/meson.build              |  22 +
>>  tests/tcg/alpha/Makefile.softmmu-target       |  34 -
>>  tests/tcg/alpha/Makefile.target               |  18 -
>>  tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
>>  tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
>>  tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
>>  tests/tcg/alpha/meson.build                   |  55 +
>>  tests/tcg/alpha/system/meson.build            |  46 +
>>  tests/tcg/arm/Makefile.softmmu-target         |  80 --
>>  tests/tcg/arm/Makefile.target                 |  87 --
>>  tests/tcg/arm/fcvt.c                          |   6 +-
>>  tests/tcg/arm/meson.build                     |  80 ++
>>  tests/tcg/arm/system/meson.build              |  66 ++
>>  tests/tcg/hexagon/Makefile.target             | 146 ---
>>  tests/tcg/hexagon/meson.build                 | 111 ++
>>  tests/tcg/hexagon/overflow.c                  |   1 +
>>  tests/tcg/hppa/Makefile.target                |  14 -
>>  tests/tcg/hppa/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
>>  tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/hppa/meson.build                    |  22 +
>>  tests/tcg/i386/Makefile.softmmu-target        |  37 -
>>  tests/tcg/i386/Makefile.target                | 102 --
>>  tests/tcg/i386/float_convd.conf               | 988 ------------------
>>  tests/tcg/i386/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/i386/meson.build                    |  58 +
>>  tests/tcg/i386/system/meson.build             |  48 +
>>  tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
>>  tests/tcg/loongarch64/Makefile.target         |  20 -
>>  tests/tcg/loongarch64/meson.build             |  32 +
>>  tests/tcg/loongarch64/system/meson.build      |  47 +
>>  tests/tcg/m68k/Makefile.target                |   7 -
>>  tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
>>  tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/m68k/meson.build                    |  23 +
>>  tests/tcg/meson.build                         | 462 ++++++++
>>  tests/tcg/minilib/Makefile.target             |  21 -
>>  tests/tcg/mips/Makefile.target                |  19 -
>>  tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
>>  tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/mips/meson.build                    |  25 +
>>  tests/tcg/mips64/Makefile.target              |  20 -
>>  tests/tcg/mips64/float_convd.ref              | 988 ++++++++++++++++++
>>  tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
>>  tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
>>  tests/tcg/mips64/meson.build                  |  27 +
>>  tests/tcg/mips64el/Makefile.target            |   8 -
>>  tests/tcg/mips64el/float_convd.ref            | 988 ++++++++++++++++++
>>  tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
>>  tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
>>  tests/tcg/mips64el/meson.build                |  14 +
>>  tests/tcg/multiarch/Makefile.target           | 224 ----
>>  tests/tcg/multiarch/gdbstub/prot-none.py      |  11 +-
>>  tests/tcg/multiarch/meson.build               | 149 +++
>>  .../multiarch/plugin/check-plugin-output.sh   |  36 -
>>  tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
>>  tests/tcg/multiarch/sha1.c                    |   4 +-
>>  tests/tcg/multiarch/sha1.ref                  |   1 +
>>  .../multiarch/system/Makefile.softmmu-target  |  81 --
>>  tests/tcg/multiarch/system/memory.c           |   3 +-
>>  tests/tcg/multiarch/system/meson.build        |  53 +
>>  tests/tcg/or1k/Makefile                       |  71 --
>>  tests/tcg/or1k/float_convd.ref                | 247 +++++
>>  tests/tcg/or1k/float_convs.ref                | 187 ++++
>>  tests/tcg/or1k/float_madds.ref                | 192 ++++
>>  tests/tcg/or1k/meson.build                    |  72 ++
>>  tests/tcg/or1k/test_addic.c                   |   2 +-
>>  tests/tcg/or1k/test_muli.c                    |   5 +-
>>  tests/tcg/plugins/meson.build                 |  11 +-
>>  tests/tcg/ppc64/Makefile.target               |  63 --
>>  tests/tcg/ppc64/float_convd.ref               | 988 ++++++++++++++++++
>>  tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
>>  tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
>>  tests/tcg/ppc64/meson.build                   |  56 +
>>  tests/tcg/ppc64/vector.c                      |  11 +-
>>  tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
>>  tests/tcg/ppc64le/Makefile.target             |   7 -
>>  tests/tcg/ppc64le/float_convd.ref             | 988 ++++++++++++++++++
>>  tests/tcg/ppc64le/meson.build                 |  14 +
>>  tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
>>  tests/tcg/riscv64/Makefile.target             |  20 -
>>  tests/tcg/riscv64/float_convd.ref             | 988 ++++++++++++++++++
>>  tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
>>  tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
>>  tests/tcg/riscv64/meson.build                 |  38 +
>>  tests/tcg/riscv64/system/meson.build          |  38 +
>>  tests/tcg/s390x/Makefile.softmmu-target       |  57 -
>>  tests/tcg/s390x/Makefile.target               | 127 ---
>>  tests/tcg/s390x/console.c                     |  30 +-
>>  tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
>>  tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
>>  tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
>>  tests/tcg/s390x/head64.S                      |   2 +
>>  tests/tcg/s390x/meson.build                   | 140 +++
>>  tests/tcg/s390x/system/meson.build            |  90 ++
>>  tests/tcg/scripts/check_plugin_output.sh      |  25 +
>>  tests/tcg/scripts/record_replay.sh            |  16 +
>>  .../scripts/run_and_check_forbidden_output.sh |  19 +
>>  tests/tcg/scripts/run_and_diff.sh             |  15 +
>>  tests/tcg/scripts/run_with_input.sh           |  12 +
>>  tests/tcg/sh4/Makefile.target                 |  18 -
>>  tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
>>  tests/tcg/sh4/float_convs.ref                 | 374 +++++++
>>  tests/tcg/sh4/float_madds.ref                 | 384 +++++++
>>  tests/tcg/sh4/meson.build                     |  25 +
>>  tests/tcg/test_cc.c                           |   7 +
>>  tests/tcg/tricore/Makefile.softmmu-target     |  53 -
>>  tests/tcg/tricore/meson.build                 |  57 +
>>  tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
>>  tests/tcg/x86_64/Makefile.target              |  40 -
>>  tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
>>  tests/tcg/x86_64/meson.build                  |  83 ++
>>  tests/tcg/x86_64/system/meson.build           |  62 ++
>>  tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
>>  tests/tcg/xtensa/crt.S                        |   1 +
>>  tests/tcg/xtensa/meson.build                  | 110 ++
>>  tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
>>  157 files changed, 30640 insertions(+), 3855 deletions(-)
>>  delete mode 100644 tests/tcg/Makefile.target
>>  delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/aarch64/Makefile.target
>>  create mode 100644 tests/tcg/aarch64/meson.build
>>  create mode 100644 tests/tcg/aarch64/system/meson.build
>>  delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>>  create mode 100644 tests/tcg/aarch64_be/meson.build
>>  delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/alpha/Makefile.target
>>  create mode 100644 tests/tcg/alpha/float_convd.ref
>>  create mode 100644 tests/tcg/alpha/float_convs.ref
>>  create mode 100644 tests/tcg/alpha/float_madds.ref
>>  create mode 100644 tests/tcg/alpha/meson.build
>>  create mode 100644 tests/tcg/alpha/system/meson.build
>>  delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/arm/Makefile.target
>>  create mode 100644 tests/tcg/arm/meson.build
>>  create mode 100644 tests/tcg/arm/system/meson.build
>>  delete mode 100644 tests/tcg/hexagon/Makefile.target
>>  create mode 100644 tests/tcg/hexagon/meson.build
>>  delete mode 100644 tests/tcg/hppa/Makefile.target
>>  create mode 100644 tests/tcg/hppa/float_convd.ref
>>  create mode 100644 tests/tcg/hppa/float_convs.ref
>>  create mode 100644 tests/tcg/hppa/float_madds.ref
>>  create mode 100644 tests/tcg/hppa/meson.build
>>  delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/i386/Makefile.target
>>  delete mode 100644 tests/tcg/i386/float_convd.conf
>>  create mode 100644 tests/tcg/i386/float_convd.ref
>>  create mode 100644 tests/tcg/i386/float_madds.ref
>>  create mode 100644 tests/tcg/i386/meson.build
>>  create mode 100644 tests/tcg/i386/system/meson.build
>>  delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/loongarch64/Makefile.target
>>  create mode 100644 tests/tcg/loongarch64/meson.build
>>  create mode 100644 tests/tcg/loongarch64/system/meson.build
>>  delete mode 100644 tests/tcg/m68k/Makefile.target
>>  create mode 100644 tests/tcg/m68k/float_convd.ref
>>  create mode 100644 tests/tcg/m68k/float_convs.ref
>>  create mode 100644 tests/tcg/m68k/float_madds.ref
>>  create mode 100644 tests/tcg/m68k/meson.build
>>  create mode 100644 tests/tcg/meson.build
>>  delete mode 100644 tests/tcg/minilib/Makefile.target
>>  delete mode 100644 tests/tcg/mips/Makefile.target
>>  create mode 100644 tests/tcg/mips/float_convd.ref
>>  create mode 100644 tests/tcg/mips/float_convs.ref
>>  create mode 100644 tests/tcg/mips/float_madds.ref
>>  create mode 100644 tests/tcg/mips/meson.build
>>  delete mode 100644 tests/tcg/mips64/Makefile.target
>>  create mode 100644 tests/tcg/mips64/float_convd.ref
>>  create mode 100644 tests/tcg/mips64/float_convs.ref
>>  create mode 100644 tests/tcg/mips64/float_madds.ref
>>  create mode 100644 tests/tcg/mips64/meson.build
>>  delete mode 100644 tests/tcg/mips64el/Makefile.target
>>  create mode 100644 tests/tcg/mips64el/float_convd.ref
>>  create mode 100644 tests/tcg/mips64el/float_convs.ref
>>  create mode 100644 tests/tcg/mips64el/float_madds.ref
>>  create mode 100644 tests/tcg/mips64el/meson.build
>>  delete mode 100644 tests/tcg/multiarch/Makefile.target
>>  create mode 100644 tests/tcg/multiarch/meson.build
>>  delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>>  create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>>  create mode 100644 tests/tcg/multiarch/sha1.ref
>>  delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
>>  create mode 100644 tests/tcg/multiarch/system/meson.build
>>  delete mode 100644 tests/tcg/or1k/Makefile
>>  create mode 100644 tests/tcg/or1k/float_convd.ref
>>  create mode 100644 tests/tcg/or1k/float_convs.ref
>>  create mode 100644 tests/tcg/or1k/float_madds.ref
>>  create mode 100644 tests/tcg/or1k/meson.build
>>  delete mode 100644 tests/tcg/ppc64/Makefile.target
>>  create mode 100644 tests/tcg/ppc64/float_convd.ref
>>  create mode 100644 tests/tcg/ppc64/float_convs.ref
>>  create mode 100644 tests/tcg/ppc64/float_madds.ref
>>  create mode 100644 tests/tcg/ppc64/meson.build
>>  delete mode 100644 tests/tcg/ppc64le/Makefile.target
>>  create mode 100644 tests/tcg/ppc64le/float_convd.ref
>>  create mode 100644 tests/tcg/ppc64le/meson.build
>>  delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/riscv64/Makefile.target
>>  create mode 100644 tests/tcg/riscv64/float_convd.ref
>>  create mode 100644 tests/tcg/riscv64/float_convs.ref
>>  create mode 100644 tests/tcg/riscv64/float_madds.ref
>>  create mode 100644 tests/tcg/riscv64/meson.build
>>  create mode 100644 tests/tcg/riscv64/system/meson.build
>>  delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/s390x/Makefile.target
>>  create mode 100644 tests/tcg/s390x/float_convd.ref
>>  create mode 100644 tests/tcg/s390x/float_convs.ref
>>  create mode 100644 tests/tcg/s390x/float_madds.ref
>>  create mode 100644 tests/tcg/s390x/meson.build
>>  create mode 100644 tests/tcg/s390x/system/meson.build
>>  create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>>  create mode 100755 tests/tcg/scripts/record_replay.sh
>>  create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>>  create mode 100755 tests/tcg/scripts/run_and_diff.sh
>>  create mode 100755 tests/tcg/scripts/run_with_input.sh
>>  delete mode 100644 tests/tcg/sh4/Makefile.target
>>  create mode 100644 tests/tcg/sh4/float_convd.ref
>>  create mode 100644 tests/tcg/sh4/float_convs.ref
>>  create mode 100644 tests/tcg/sh4/float_madds.ref
>>  create mode 100644 tests/tcg/sh4/meson.build
>>  create mode 100644 tests/tcg/test_cc.c
>>  delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>>  create mode 100644 tests/tcg/tricore/meson.build
>>  delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/x86_64/Makefile.target
>>  create mode 100644 tests/tcg/x86_64/float_madds.ref
>>  create mode 100644 tests/tcg/x86_64/meson.build
>>  create mode 100644 tests/tcg/x86_64/system/meson.build
>>  delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
>>  create mode 100644 tests/tcg/xtensa/meson.build
>>  delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
>>=20
>
> If someone with a macos machine could give a try with their podman or
> docker, it would be nice. The hosts I have access to don't have
> virtualization support unfortunately.


I don't think we can drop local compiler support - for exactly this
reason. The CI image is unlikely to have virtualisation support either.

As it happens it all skips anyway:

Full log written to /Users/alex/lsrc/qemu.git/builds/testing/meson-logs/tes=
tlog.txt
/Users/alex/lsrc/qemu.git/builds/testing/pyvenv/bin/meson test  --no-rebuil=
d -t 1  --num-processes 1 --print-errorlogs  --suite tcg
 1/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-hello                 =
       SKIP             0.01s   exit status 77
 2/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-interrupt             =
       SKIP             0.00s   exit status 77
 3/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-memory                =
       SKIP             0.00s   exit status 77
 4/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-gdb-memory            =
       SKIP             0.00s   exit status 77
 5/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-gdb-interrupt         =
       SKIP             0.00s   exit status 77
 6/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-gdb-untimely-packet   =
       SKIP             0.00s   exit status 77
 7/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-gdb-registers         =
       SKIP             0.00s   exit status 77
 8/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-memory-sve            =
       SKIP             0.00s   exit status 77
 9/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-asid2                 =
       SKIP             0.00s   exit status 77
10/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-feat-xs               =
       SKIP             0.00s   exit status 77
11/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-gpc-test              =
       SKIP             0.00s   exit status 77
12/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-rme_gdi               =
       SKIP             0.00s   exit status 77
13/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-semiheap              =
       SKIP             0.00s   exit status 77
14/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-semiconsole           =
       SKIP             0.00s   exit status 77
15/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-memory-record-replay  =
       SKIP             0.00s   exit status 77
16/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-vtimer                =
       SKIP             0.00s   exit status 77
17/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-pauth-3               =
       SKIP             0.00s   exit status 77
18/32 tcg+tcg-aarch64-softmmu - qemu:aarch64-softmmu-gdb-mte               =
       SKIP             0.00s   exit status 77
19/32 tcg+tcg-i386-softmmu - qemu:i386-softmmu-hello                       =
       SKIP             0.00s   exit status 77
20/32 tcg+tcg-i386-softmmu - qemu:i386-softmmu-interrupt                   =
       SKIP             0.00s   exit status 77
21/32 tcg+tcg-i386-softmmu - qemu:i386-softmmu-memory                      =
       SKIP             0.00s   exit status 77
22/32 tcg+tcg-i386-softmmu - qemu:i386-softmmu-gdb-memory                  =
       SKIP             0.00s   exit status 77
23/32 tcg+tcg-i386-softmmu - qemu:i386-softmmu-gdb-interrupt               =
       SKIP             0.00s   exit status 77
24/32 tcg+tcg-i386-softmmu - qemu:i386-softmmu-gdb-untimely-packet         =
       SKIP             0.00s   exit status 77
25/32 tcg+tcg-i386-softmmu - qemu:i386-softmmu-gdb-registers               =
       SKIP             0.00s   exit status 77
26/32 tcg+tcg-x86_64-softmmu - qemu:x86_64-softmmu-hello                   =
       SKIP             0.00s   exit status 77
27/32 tcg+tcg-x86_64-softmmu - qemu:x86_64-softmmu-interrupt               =
       SKIP             0.00s   exit status 77
28/32 tcg+tcg-x86_64-softmmu - qemu:x86_64-softmmu-memory                  =
       SKIP             0.00s   exit status 77
29/32 tcg+tcg-x86_64-softmmu - qemu:x86_64-softmmu-gdb-memory              =
       SKIP             0.00s   exit status 77
30/32 tcg+tcg-x86_64-softmmu - qemu:x86_64-softmmu-gdb-interrupt           =
       SKIP             0.00s   exit status 77
31/32 tcg+tcg-x86_64-softmmu - qemu:x86_64-softmmu-gdb-untimely-packet     =
       SKIP             0.00s   exit status 77
32/32 tcg+tcg-x86_64-softmmu - qemu:x86_64-softmmu-gdb-registers           =
       SKIP             0.00s   exit status 77

Ok:                0=20=20=20
Fail:              0=20=20=20
Skipped:           32=20=20

Full log written to
/Users/alex/lsrc/qemu.git/builds/testing/meson-logs/testlog.txt


>
> Infrastructure patches missing reviews:
> - 4
> - 28-29
> - 31
> - 36
>
> All commits above 31 (multiarch and arch) need review also.
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

