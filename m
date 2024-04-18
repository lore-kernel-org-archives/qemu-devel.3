Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E702C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 11:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxPfd-00016Y-Ua; Thu, 18 Apr 2024 07:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxPfb-00016C-JC
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 07:11:12 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxPfY-0007V5-IF
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 07:11:11 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dc6dcd9124bso738883276.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 04:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713438666; x=1714043466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xclo1h1eHuRS3hskpwcTb5tcOFzxV3OXBvIGLYoIHuQ=;
 b=eUlT/jc5jaAHFztX8tTIa96e5vndXQQ+zFQXNyJ2sLei3CkAbUOjcE0NywqSUUt4EA
 LAlml3oFbJ8qTeBe1ikh1z9MFI1HJRomTMVu1e+7zZeVFOFh/vEf538VCJr0QKQnln/f
 gvtC4ZrcI0Nq8fBCEbLFXVKCWBnUOnKe6lE/mQ5XRqUElDpn8XI3njmCDHHDcUqQpq3h
 caqGepOwxWdzze7JtCaIJYoNgHiiJAJPlF76gplJN6BRaZu4PgWWo+c65+2yc/7kL3NS
 n8Vzq2SeYC3el2g1y09XBoyt9VN1QpLD0VXSA15RQnZMxMS5VFtg+SAmJHBWH5G4Kj+r
 tTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713438666; x=1714043466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xclo1h1eHuRS3hskpwcTb5tcOFzxV3OXBvIGLYoIHuQ=;
 b=v2m6XDpfQAvyMyZW1to9h9pEj4kiQw1BOt6RUdlV3fNUylLYdL56GD1BhYhj4JV0C9
 hQUX2xGVLoCoEvr5UiyRTtVga+c9fZguxQLZLCHhzrZCNaWFrRdtXSvDW4XIkaNRj177
 Tu4Esv45APl45TZkzZA658F1P0t2oPC9wY72oUErbKG2cndJTIvKijc2yspCWxa6fq+R
 lXzxA7raABdniq0R/2WHIDfshlnFCjQryjetASaejhyo9DuFdltQgJsdz9GU9D/h/3Nw
 YbYWcQc7aNC21x34lH/bttNCKGFqOk6EGM/pH8oaj4IRlQ0LAGeIYHK2/e6rf0evksTq
 CuuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuDyL973swbPUlQ2sjQ3f80hZ9LpBq7CUHVU23z/B6ZT2DLngZt9mLzgS6O2odX09VuH9sNKdYNqErO0ahHsI5TAI51EY=
X-Gm-Message-State: AOJu0Yy1WSGbYxC2kfNU0MPTIzeFALvj9dlrLgzCwB92zmVb4c0DgbiT
 c1FHpGXeWirjeI9VB9/w3OC1PHNpwje+SH+/XMmVQqspdSdc+RlORqodhtpfT9I=
X-Google-Smtp-Source: AGHT+IGMEEaEEOCnuSq04+FG3ANFJwiqC0wzDpelxdzsb0e2iB7J+QRWow4IluEkhnsCSqkjislboQ==
X-Received: by 2002:a25:d6c9:0:b0:dc2:470b:887e with SMTP id
 n192-20020a25d6c9000000b00dc2470b887emr2372247ybg.21.1713438666408; 
 Thu, 18 Apr 2024 04:11:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a0c8ece000000b00698fd83ac04sm540018qvb.135.2024.04.18.04.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 04:11:05 -0700 (PDT)
Message-ID: <fd68f7e5-11ed-4459-96ac-b4a417dc9aa0@linaro.org>
Date: Thu, 18 Apr 2024 13:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] target/nios2: Remove the deprecated Nios
 II target
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Sandra Loosemore <sloosemore@baylibre.com>,
 Chung-Lin Tang <cltang@baylibre.com>, andrew@reenigne.org,
 Yao Qi <qiyaoltc@gmail.com>
Cc: devel@lists.libvirt.org, Marek Vasut <marex@denx.de>,
 Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20240327144806.11319-1-philmd@linaro.org>
 <20240327144806.11319-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327144806.11319-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=philmd@linaro.org; helo=mail-yb1-xb2a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/24 15:48, Philippe Mathieu-Daudé wrote:
> The Nios II target is deprecated since v8.2 in commit 9997771bc1
> ("target/nios2: Deprecate the Nios II architecture").
> 
> Remove:
> - Buildsys / CI infra
> - User emulation
> - System emulation (10m50-ghrd & nios2-generic-nommu machines)
> - Tests
> 
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                                   |   13 -
>   docs/about/deprecated.rst                     |   11 -
>   docs/about/emulation.rst                      |    7 -
>   docs/about/removed-features.rst               |   14 +
>   docs/system/replay.rst                        |    2 +-
>   docs/user/main.rst                            |    4 -
>   configure                                     |    2 -
>   configs/devices/nios2-softmmu/default.mak     |    6 -
>   configs/targets/nios2-linux-user.mak          |    1 -
>   configs/targets/nios2-softmmu.mak             |    2 -
>   meson.build                                   |    2 -
>   qapi/machine.json                             |    2 +-
>   hw/nios2/boot.h                               |   10 -
>   include/disas/dis-asm.h                       |    5 -
>   include/exec/poison.h                         |    2 -
>   include/exec/user/abitypes.h                  |    3 +-
>   include/hw/intc/nios2_vic.h                   |   66 -
>   include/sysemu/arch_init.h                    |    1 -
>   linux-user/nios2/sockbits.h                   |    1 -
>   linux-user/nios2/syscall_nr.h                 |  333 --
>   linux-user/nios2/target_cpu.h                 |   49 -
>   linux-user/nios2/target_elf.h                 |   14 -
>   linux-user/nios2/target_errno_defs.h          |    7 -
>   linux-user/nios2/target_fcntl.h               |   11 -
>   linux-user/nios2/target_mman.h                |   11 -
>   linux-user/nios2/target_prctl.h               |    1 -
>   linux-user/nios2/target_proc.h                |    1 -
>   linux-user/nios2/target_resource.h            |    1 -
>   linux-user/nios2/target_signal.h              |    9 -
>   linux-user/nios2/target_structs.h             |    1 -
>   linux-user/nios2/target_syscall.h             |   37 -
>   linux-user/nios2/termbits.h                   |    1 -
>   linux-user/syscall_defs.h                     |    4 +-
>   target/nios2/cpu-param.h                      |   20 -
>   target/nios2/cpu-qom.h                        |   18 -
>   target/nios2/cpu.h                            |  301 --
>   target/nios2/helper.h                         |   32 -
>   target/nios2/mmu.h                            |   52 -
>   tests/tcg/nios2/semicall.h                    |   28 -
>   disas/nios2.c                                 | 3514 -----------------
>   hw/intc/nios2_vic.c                           |  313 --
>   hw/nios2/10m50_devboard.c                     |  181 -
>   hw/nios2/boot.c                               |  234 --
>   hw/nios2/generic_nommu.c                      |  101 -
>   linux-user/elfload.c                          |   99 -
>   linux-user/nios2/cpu_loop.c                   |  157 -
>   linux-user/nios2/signal.c                     |  210 -
>   target/nios2/cpu.c                            |  410 --
>   target/nios2/helper.c                         |  371 --
>   target/nios2/mmu.c                            |  216 -
>   target/nios2/monitor.c                        |   35 -
>   target/nios2/nios2-semi.c                     |  230 --
>   target/nios2/op_helper.c                      |  119 -
>   target/nios2/translate.c                      | 1107 ------
>   tests/qtest/machine-none-test.c               |    1 -
>   fpu/softfloat-specialize.c.inc                |    2 +-
>   .gitlab-ci.d/buildtest.yml                    |    4 +-
>   .gitlab-ci.d/crossbuild-template.yml          |    2 +-
>   .gitlab-ci.d/crossbuilds.yml                  |    2 +-
>   disas/meson.build                             |    1 -
>   hw/Kconfig                                    |    1 -
>   hw/intc/Kconfig                               |    3 -
>   hw/intc/meson.build                           |    1 -
>   hw/meson.build                                |    1 -
>   hw/nios2/Kconfig                              |   13 -
>   hw/nios2/meson.build                          |    6 -
>   qemu-options.hx                               |    8 +-
>   scripts/coverity-scan/COMPONENTS.md           |    3 -
>   scripts/gensyscalls.sh                        |    1 -
>   scripts/probe-gdb-support.py                  |    1 -
>   target/Kconfig                                |    1 -
>   target/meson.build                            |    1 -
>   target/nios2/Kconfig                          |    3 -
>   target/nios2/meson.build                      |   17 -
>   target/nios2/trace-events                     |   10 -
>   tests/avocado/boot_linux_console.py           |    8 -
>   tests/avocado/replay_kernel.py                |   11 -
>   tests/docker/Makefile.include                 |    5 -
>   .../debian-nios2-cross.d/build-toolchain.sh   |   87 -
>   tests/tcg/nios2/10m50-ghrd.ld                 |   70 -
>   tests/tcg/nios2/Makefile.softmmu-target       |   32 -
>   tests/tcg/nios2/Makefile.target               |   11 -
>   tests/tcg/nios2/boot.S                        |  218 -
>   tests/tcg/nios2/intr.S                        |   31 -
>   tests/tcg/nios2/test-shadow-1.S               |   40 -
>   85 files changed, 28 insertions(+), 8949 deletions(-)
>   delete mode 100644 configs/devices/nios2-softmmu/default.mak
>   delete mode 100644 configs/targets/nios2-linux-user.mak
>   delete mode 100644 configs/targets/nios2-softmmu.mak
>   delete mode 100644 hw/nios2/boot.h
>   delete mode 100644 include/hw/intc/nios2_vic.h
>   delete mode 100644 linux-user/nios2/sockbits.h
>   delete mode 100644 linux-user/nios2/syscall_nr.h
>   delete mode 100644 linux-user/nios2/target_cpu.h
>   delete mode 100644 linux-user/nios2/target_elf.h
>   delete mode 100644 linux-user/nios2/target_errno_defs.h
>   delete mode 100644 linux-user/nios2/target_fcntl.h
>   delete mode 100644 linux-user/nios2/target_mman.h
>   delete mode 100644 linux-user/nios2/target_prctl.h
>   delete mode 100644 linux-user/nios2/target_proc.h
>   delete mode 100644 linux-user/nios2/target_resource.h
>   delete mode 100644 linux-user/nios2/target_signal.h
>   delete mode 100644 linux-user/nios2/target_structs.h
>   delete mode 100644 linux-user/nios2/target_syscall.h
>   delete mode 100644 linux-user/nios2/termbits.h
>   delete mode 100644 target/nios2/cpu-param.h
>   delete mode 100644 target/nios2/cpu-qom.h
>   delete mode 100644 target/nios2/cpu.h
>   delete mode 100644 target/nios2/helper.h
>   delete mode 100644 target/nios2/mmu.h
>   delete mode 100644 tests/tcg/nios2/semicall.h
>   delete mode 100644 disas/nios2.c
>   delete mode 100644 hw/intc/nios2_vic.c
>   delete mode 100644 hw/nios2/10m50_devboard.c
>   delete mode 100644 hw/nios2/boot.c
>   delete mode 100644 hw/nios2/generic_nommu.c
>   delete mode 100644 linux-user/nios2/cpu_loop.c
>   delete mode 100644 linux-user/nios2/signal.c
>   delete mode 100644 target/nios2/cpu.c
>   delete mode 100644 target/nios2/helper.c
>   delete mode 100644 target/nios2/mmu.c
>   delete mode 100644 target/nios2/monitor.c
>   delete mode 100644 target/nios2/nios2-semi.c
>   delete mode 100644 target/nios2/op_helper.c
>   delete mode 100644 target/nios2/translate.c
>   delete mode 100644 hw/nios2/Kconfig
>   delete mode 100644 hw/nios2/meson.build
>   delete mode 100644 target/nios2/Kconfig
>   delete mode 100644 target/nios2/meson.build
>   delete mode 100644 target/nios2/trace-events
>   delete mode 100755 tests/docker/dockerfiles/debian-nios2-cross.d/build-toolchain.sh
>   delete mode 100644 tests/tcg/nios2/10m50-ghrd.ld
>   delete mode 100644 tests/tcg/nios2/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/nios2/Makefile.target
>   delete mode 100644 tests/tcg/nios2/boot.S
>   delete mode 100644 tests/tcg/nios2/intr.S
>   delete mode 100644 tests/tcg/nios2/test-shadow-1.S
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07af6b9d4..f9db15a173 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -291,19 +291,6 @@ F: disas/*mips.c
>   F: docs/system/cpu-models-mips.rst.inc
>   F: tests/tcg/mips/
>   
> -NiosII TCG CPUs
> -R: Chris Wulff <crwulff@gmail.com>
> -R: Marek Vasut <marex@denx.de>
> -S: Orphan
> -F: target/nios2/
> -F: hw/nios2/
> -F: hw/intc/nios2_vic.c
> -F: disas/nios2.c
> -F: include/hw/intc/nios2_vic.h
> -F: configs/devices/nios2-softmmu/default.mak
> -F: tests/docker/dockerfiles/debian-nios2-cross.d/build-toolchain.sh
> -F: tests/tcg/nios2/
> -
>   OpenRISC TCG CPUs
>   M: Stafford Horne <shorne@gmail.com>
>   S: Odd Fixes
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..06090dd2c2 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -185,12 +185,6 @@ it. Since all recent x86 hardware from the past >10 years is capable of the
>   System emulator CPUs
>   --------------------
>   
> -Nios II CPU (since 8.2)
> -'''''''''''''''''''''''
> -
> -The Nios II architecture is orphan. The ``nios2`` guest CPU support is
> -deprecated and will be removed in a future version of QEMU.
> -
>   ``power5+`` and ``power7+`` CPU names (since 9.0)
>   '''''''''''''''''''''''''''''''''''''''''''''''''
>   
> @@ -226,11 +220,6 @@ These old machine types are quite neglected nowadays and thus might have
>   various pitfalls with regards to live migration. Use a newer machine type
>   instead.
>   
> -Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The Nios II architecture is orphan.
> -
>   ``shix`` (since 9.0)
>   ''''''''''''''''''''
>   
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index a2eefe3f3f..b5ff9c5f69 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -58,10 +58,6 @@ depending on the guest architecture.
>       - :ref:`Yes<MIPS-System-emulator>`
>       - Yes
>       - Venerable RISC architecture originally out of Stanford University
> -  * - Nios2
> -    - Yes
> -    - Yes
> -    - 32 bit embedded soft-core by Altera
>     * - OpenRISC
>       - :ref:`Yes<OpenRISC-System-emulator>`
>       - Yes
> @@ -180,9 +176,6 @@ for that architecture.
>     * - MIPS
>       - System
>       - Unified Hosting Interface (MD01069)
> -  * - Nios II
> -    - System
> -    - https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/nios2/nios2-semi.txt;hb=HEAD
>     * - RISC-V
>       - System and User-mode
>       - https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index f9cf874f7b..8fe50699b3 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -699,6 +699,11 @@ The RISC-V ISA privilege specification version 1.09.1 has been removed.
>   QEMU supports both the newer version 1.10.0 and the ratified version 1.11.0, these
>   should be used instead of the 1.09.1 version.
>   
> +Nios II architecture (removed in 9.1)
> +'''''''''''''''''''''''''''''''''''''
> +
> +The Nios II architecture was orphan.

Per Sandra's comment in
https://lore.kernel.org/qemu-devel/55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com/

Maybe we could change to:

   +Intel has EOL'ed the Nios II processor IP and is now directing
   +their FPGA customers to a RISC-V platform instead.
   +See `Intel discontinuance notification 
<https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html>`_.


> +
>   System emulator CPUS
>   --------------------
>   
> @@ -841,6 +846,11 @@ ppc ``taihu`` machine (removed in 7.2)
>   This machine was removed because it was partially emulated and 405
>   machines are very similar. Use the ``ref405ep`` machine instead.
>   
> +Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (removed in 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The Nios II architecture was orphan.
> +
>   linux-user mode CPUs
>   --------------------
>   
> @@ -860,6 +870,10 @@ The ``ppc64abi32`` architecture has a number of issues which regularly
>   tripped up the CI testing and was suspected to be quite broken. For that
>   reason the maintainers strongly suspected no one actually used it.
>   
> +``nios2`` CPU (removed in 9.1)
> +''''''''''''''''''''''''''''''
> +
> +The Nios II architecture was orphan.
>   
>   TCG introspection features
>   --------------------------

(Original patch content:
https://lore.kernel.org/qemu-devel/20240327144806.11319-3-philmd@linaro.org/)


