Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B3FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQAQ-0000pF-DH; Fri, 09 May 2025 12:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uDQAO-0000iu-JL; Fri, 09 May 2025 12:01:40 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uDQAL-00045C-VU; Fri, 09 May 2025 12:01:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5fbed53b421so3467684a12.0; 
 Fri, 09 May 2025 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746806494; x=1747411294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IMwc7g0gPuHpf710a69q+fyDXuR4UXONr4b3md0hTM=;
 b=mFu4i147/7mPC8V25y4bZdzAKl5GegnE6IXoo3UGLE1xWa3rWwvG3kUz0hwpH4eQgy
 y8m27yykFDu/loPPGZ5m3Pc53r9RJwmIlnynqdY6qJFb3HMFA54VX6OSo9lza1BZSWbH
 OHAZ7eOgdDwGORtKUN67kBkSOui1j8VfV3S1xP9ea0Fcr4S91jmXEeCPlLI+wk3wPB5G
 +zQGYGAzOtjeYtGOaHK4H9b2i0cynMf87EYRaN8EL61D/nCbiTS+Op55Yn50pzL6tbvT
 UdySaQpZ98UgQqLF65g+tus+sxkNx9lSRkZj1k+G3wppS70bnZdqQG4v334Dy8JLk07Z
 5W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746806494; x=1747411294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IMwc7g0gPuHpf710a69q+fyDXuR4UXONr4b3md0hTM=;
 b=ggb5o64lGOlk5Eog2xg9Crv43XS6uJLs7xYFOEVh8Qaz9BO11N6eFTRHFp8dJ3nLIL
 uWf62Dbrr1517aF1uKcplH2AAirZJ4z44SwT0ctk1Z5PfkhZAW8TJaCnvbjGeY3Z6HUv
 BNAkTl8ofnELsQM5MpNmnKqF3P210E+QxHi4eiBMe49oUvuDOFe7H1moPhrawZKlj0yQ
 aMe6WpLPuqyMXgJ7JKp5b+EHsTGF0rS6pnWtxuI3gBNWMTEeXsVcOa4IHiN3t5PpUsSz
 14RqtKKXgkpiUVk7WQoTkkKWSlYxe6L1oA0Engz3UN2wNka167W5ncIuGg5Moh0PIXS0
 VgFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLOaVp4oliSXS66bHCbWLIrKb9O+mB0/3fAi2fv5uJwhY9HrZ6LN8rbIBlREis/GspsSGDqCuzS3LClq0=@nongnu.org
X-Gm-Message-State: AOJu0YzNRldDdzV4cWM3JCk9cVHESvneb+fPZkAXIIIpc8kvcVNq09s/
 WF5ycwJGYp/FZJX9SG9DbA7rC813HKA356Vek57O9oMuBeobfYIR1774NTwXCesAD6gHyylPrXr
 8M7u3yJpVp7PXxY26aj1oobn1ckNTPAlCeCs=
X-Gm-Gg: ASbGncta/7O7JIB7j+Fih9rphN5/a0h0CozQ5/qAmruY2APTxNsWRMjaBh4+8m4RPE3
 5dV3K+DK6cVxuW3W/OJpgtQNpLMfnyNsG63QlwHphSbFcgrZR3qVfbNCP0zMge9c7X5N/ZVHskk
 S7wQJnc1oATj3zaAnmlC99
X-Google-Smtp-Source: AGHT+IGz3DTqRN29qluUtEYMGXXMv6eN82AAi3HjzwTdvlIjkX1KjzDHIBbupgYGiGGJ4Li0LyYxnSqMU95HUhhzfbU=
X-Received: by 2002:a05:6402:3591:b0:5f8:30c2:8650 with SMTP id
 4fb4d7f45d1cf-5fca078ee00mr3315814a12.14.1746806493851; Fri, 09 May 2025
 09:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250507180737.183147-1-mjt@tls.msk.ru>
In-Reply-To: <20250507180737.183147-1-mjt@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 9 May 2025 12:01:21 -0400
X-Gm-Features: AX0GCFv7rd7A9Qb1cdoFhpGhbcJAqwjKeU7YpXJaO8X4Yne-z_9zMz2oTVzTQ0M
Message-ID: <CAJSP0QVz2OwZdzA7t5P93vGg0zkpW=ebsJ+gWF64nYS4oxQiew@mail.gmail.com>
Subject: Re: [PULL v2 00/21] Trivial patches for 2025-05-07
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Zixing Liu <liushuyu@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, May 7, 2025 at 2:08=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> The following changes since commit c5e2c4042e3c50b96cc5eaa9683325c5a96913=
b0:
>
>   Merge tag 'pull-loongarch-20250506' of https://github.com/bibo-mao/qemu=
 into staging (2025-05-06 11:03:45 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 40d2aa5a7199f783e12818505857c3fd4663080f:
>
>   docs: replace `-hda` with `-drive` & update `root=3D` kernel parameter =
(2025-05-07 21:05:10 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2025-05-07
>
> Mostly typos in comments by Gustavo Romero,
> plus changing -hda in examples to -drive,
> plus single linux-user update (new syscall variant)
>
> v2: update the last patch Author (it was "via qemu-trivial")
> ----------------------------------------------------------------
> Gustavo Romero (11):
>       hw/pci/pci.c: Turn DPRINTF into trace events
>       hw/isa/ich9: Remove stray empty comment
>       hw/i386/acpi-build: Fix typo and grammar in comment
>       hw/i386/acpi-build: Update document reference
>       hw/acpi/ich9: Remove ICH9_DEBUG macro
>       hw/i386/acpi-build: Fix typo in function name
>       hw/core/machine: Fix indentation
>       qom/object: Fix typo in comment
>       hw/net/e1000: Remove stray empty comment in header
>       hw/pci-host/gpex-acpi: Fix typo in comment
>       hw/acpi/pcihp: Fix typo in function name
>
> Integral (1):
>       docs: replace `-hda` with `-drive` & update `root=3D` kernel parame=
ter
>
> Michael Tokarev (8):
>       linux-user/mmap.c: fix "of of" typo in comment
>       block.c: fix "the the" typo in comment
>       hw/xen/xen-hvm-common.c: fix "the the" typo in comment
>       include/exec/cpu-common.h: fix "the the" typo in comment
>       include/hw/xen/interface/io/blkif.h: fix "the the" typo in comment
>       qapi/qom.json: fix "the the" typo in comment
>       hw/display/apple-gfx.m: fix "in in" typo in comment
>       qapi/machine-target.json: fix "in in" typo in comment
>
> Zixing Liu (1):
>       linux-user/syscall.c: add translation logic for epoll_pwait2 syscal=
l

Hi Michael and Zixing Liu,
Please take a look at the following build failure in the CI system:

arm-linux-gnueabihf-gcc -Ilibqemu-arm-linux-user.a.p -I. -I..
-Itarget/arm -I../target/arm -I../common-user/host/arm
-I../linux-user/include/host/arm -I../linux-user/include -Ilinux-user
-I../linux-user -Ilinux-user/arm -I../linux-user/arm -Iqapi -Itrace
-Iui/shader -I/usr/include/capstone -I/usr/include/glib-2.0
-I/usr/lib/arm-linux-gnueabihf/glib-2.0/include
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g
-fstack-protector-strong -Wempty-body -Wendif-labels
-Wexpansion-to-defined -Wformat-security -Wformat-y2k
-Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
-Wno-shift-negative-value -isystem
/builds/qemu-project/qemu/linux-headers -isystem linux-headers -iquote
. -iquote /builds/qemu-project/qemu -iquote
/builds/qemu-project/qemu/include -iquote
/builds/qemu-project/qemu/host/include/generic -iquote
/builds/qemu-project/qemu/tcg/arm -pthread -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
-fzero-call-used-regs=3Dused-gpr -fPIE -isystem../linux-headers
-isystemlinux-headers -DCOMPILING_PER_TARGET
'-DCONFIG_TARGET=3D"arm-linux-user-config-target.h"' -MD -MQ
libqemu-arm-linux-user.a.p/linux-user_syscall.c.o -MF
libqemu-arm-linux-user.a.p/linux-user_syscall.c.o.d -o
libqemu-arm-linux-user.a.p/linux-user_syscall.c.o -c
../linux-user/syscall.c
../linux-user/syscall.c: In function =E2=80=98do_syscall1=E2=80=99:
../linux-user/syscall.c:13434:33: error: implicit declaration of
function =E2=80=98safe_epoll_pwait2=E2=80=99; did you mean =E2=80=98safe_ep=
oll_pwait=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
13434 | ret =3D get_errno(safe_epoll_pwait2(epfd, ep, maxevents, ts_arg,
| ^~~~~~~~~~~~~~~~~
| safe_epoll_pwait
../linux-user/syscall.c:13434:33: error: nested extern declaration of
=E2=80=98safe_epoll_pwait2=E2=80=99 [-Werror=3Dnested-externs]

https://gitlab.com/qemu-project/qemu/-/jobs/9987233462

Michael: Once the issue is resolved, please send a v2 pull request
(either without the commit in question or with an updated version of
the commit).

Thanks,
Stefan

>
>  block.c                             |  2 +-
>  docs/system/gdb.rst                 |  2 +-
>  docs/system/linuxboot.rst           |  6 +++---
>  docs/system/target-mips.rst         |  2 +-
>  hw/acpi/acpi-pci-hotplug-stub.c     |  2 +-
>  hw/acpi/ich9.c                      | 13 +------------
>  hw/acpi/pcihp.c                     |  2 +-
>  hw/acpi/piix4.c                     |  2 +-
>  hw/core/machine.c                   |  8 ++++----
>  hw/display/apple-gfx.m              |  2 +-
>  hw/i386/acpi-build.c                | 10 +++++-----
>  hw/i386/acpi-build.h                |  2 +-
>  hw/isa/lpc_ich9.c                   |  1 -
>  hw/net/e1000x_regs.h                |  2 +-
>  hw/pci-host/gpex-acpi.c             |  2 +-
>  hw/pci/pci.c                        | 19 ++++++-------------
>  hw/pci/trace-events                 |  4 ++++
>  hw/xen/xen-hvm-common.c             |  2 +-
>  include/exec/cpu-common.h           |  2 +-
>  include/hw/acpi/pcihp.h             |  2 +-
>  include/hw/xen/interface/io/blkif.h |  2 +-
>  linux-user/mmap.c                   |  2 +-
>  linux-user/syscall.c                | 36 +++++++++++++++++++++++++++++++=
+----
>  qapi/machine-target.json            |  2 +-
>  qapi/qom.json                       |  2 +-
>  qom/object.c                        |  2 +-
>  26 files changed, 73 insertions(+), 60 deletions(-)
>

