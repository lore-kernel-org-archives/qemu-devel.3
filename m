Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D852E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHKq-00051o-8R; Fri, 10 Jan 2025 10:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tWHKW-0004yQ-Sr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:53:49 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tWHKV-0003Ci-1I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:53:48 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso396420166b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736524425; x=1737129225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeSfkq1E7WfczTL6fYifsnuqQrit11jE1yqgEB+jIWU=;
 b=KEtrztmK4Glo6D46Vp1imzgY8w0/YOWAO72wwA9FghnDvLQ/qb6BYvHGOVCj1UflYd
 odbGXZTrBwoHO0j2vZHkmwmCUX8oF1Y8iDeS5lgHVFzHM6L+wfGaH1zHrPuNug8AZGUr
 Y5Uo+OelRqxrx7PIOoZCHmEo4BggDgZ+5EGkgmsngl9gvzUW9H8tTu5vq3JnlYcdtOqi
 BCiz2xnekAE2KRiCgTYClj9pChQNPYC1/u5KiBm3Had1DdOu2o9SfrINokP5zqOJKVb3
 tAV7ZVgzUFhIQApjQuplW3CTFnrR8aGR71E238xG8eUB1sr0X5Tl+pigQG/tyMpmOzQH
 0gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524425; x=1737129225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WeSfkq1E7WfczTL6fYifsnuqQrit11jE1yqgEB+jIWU=;
 b=g2431XS66t92S7aiQRXLjWv7z1r7uDsjm4CVvKoF05gMrd/6FLq3xmDjnNL+c6aRBP
 dxD+g6PoayUSHx+yqpy6VlrSovh6WLustX5sSGO3dYI/frzBwHclEbKYTa1+NKcWnVa1
 rc1kUXwMhjg5RWPJLVNb32rHzSCOjcxkuiQScXD/9D2rR2AgM7w8fMvvg6BaU5UDUV1m
 J2YOHmZHJKLWiCVOgPWdYe2KKuXKIvUzZbDXJEpTotN0NLOAJJutbBiEN35GnZEo0YUB
 XuqxXidDd1RoRRJOUsdqDbQNQQPaWwn+WU5rYplI9Is2wyOPIKGnMZ7lulzC+9Zxni17
 L3sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1L+GIlvU0HJ29LHBC/OcYoSw6UlEJoBq5iIG2mykK02yTfPruDjs23eo55OTIJUOPy/zuZkTjui6o@nongnu.org
X-Gm-Message-State: AOJu0YxvhQnrpnnWS/3zSb9YqJUHRd13jmYKkzdEF3hixA8BcUGycgnj
 e01o1+vmYpGBl0DMWRyTaGqm1M/Dn+GEnK9d6m5uNTAJwwOHaZpXqPMAMPlJEAL/S0RabfBQzZ2
 bQpbkiQUWSttaPBC9bCYKNQLOwtw=
X-Gm-Gg: ASbGncvs2sUkUfvOLT2uPdhsHAWuxjbNa6pNANLnx6QLhjdlcq8JaZVvI913QVEK4hD
 1FGn9592Ftu3eGzUfMgnpIRG/l4lEC6vyx7+3
X-Google-Smtp-Source: AGHT+IGyf+fEHd4Cic5Pm/iSz/Blw4/wg1YL19pJatVY/VWxXMO2TbGIuIC6QZfa0rNk9Ho3XCiZnpmLHNWw6d1j/CQ=
X-Received: by 2002:a17:907:7e95:b0:aaf:c19a:cc1c with SMTP id
 a640c23a62f3a-ab2ab6c6625mr892774666b.22.1736524425029; Fri, 10 Jan 2025
 07:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20250108220422.169967-1-deller@kernel.org>
In-Reply-To: <20250108220422.169967-1-deller@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Jan 2025 10:53:32 -0500
X-Gm-Features: AbW1kvZRtYOUbGQz0h_5L3rigA_lIYlzNBWFZ6xWWq3SZw2CSLi79Tr6Uof-thU
Message-ID: <CAJSP0QUuyZ99jMVbEV1gMa=3kz03C2Dn0JwH4_ndjmaVGeaP6g@mail.gmail.com>
Subject: Re: [PULL v2 0/6] Linux user fix gupnp patches
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x629.google.com
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

On Wed, 8 Jan 2025 at 17:04, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 791e3837c1105aec4e328674aad32e34056957=
e2:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into s=
taging (2024-11-25 10:44:11 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/linux-user-fix-gupnp-pull=
-request
>
> for you to fetch changes up to 526635dc5edf989781219c1ee7d50846c0555a46:
>
>   linux-user: netlink: Add missing QEMU_IFLA entries (2024-12-27 21:30:27=
 +0100)
>
> ----------------------------------------------------------------
> linux-user: Add support for various missing netlink sockopt entries
>
> This patchset adds various missing sockopt calls, so that qemu linux-user
> is able to successfully build the debian gupnp package in a chroot.
>
> Tested with a 32-bit big-endian hppa linux-user chroot running on a phyis=
cal
> x86-64 little-endian host.
>
> This fixes debian's bug report:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1044651
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Stefan, please merge it now in mainline (unless Laurent
> finally answers differently). It just adds until-now unsupporzted
> functionality, so nothing existing can break.
>
> ----------------------------------------------------------------
>
> Helge Deller (6):
>   linux-user: netlink: Add missing IFA_PROTO to
>     host_to_target_data_addr_rtattr()
>   linux-user: Use unique error messages for cmsg parsing
>   linux-user: netlink: Add IP_PKTINFO cmsg parsing
>   linux-user: netlink: Add emulation of IP_MULTICAST_IF
>   linux-user: netlink: add netlink neighbour emulation
>   linux-user: netlink: Add missing QEMU_IFLA entries
>
>  linux-user/fd-trans.c | 137 +++++++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall.c  |  29 +++++++--
>  2 files changed, 161 insertions(+), 5 deletions(-)

Hi Helge,
Please take a look at this CI job failure and send a v3:
https://gitlab.com/qemu-project/qemu/-/jobs/8820703947

FAILED: libqemu-aarch64-linux-user.a.p/linux-user_fd-trans.c.o
cc -Ilibqemu-aarch64-linux-user.a.p -I. -I.. -Itarget/arm
-I../target/arm -I../common-user/host/aarch64
-I../linux-user/include/host/aarch64 -I../linux-user/include
-Ilinux-user -I../linux-user -Ilinux-user/aarch64
-I../linux-user/aarch64 -Iqapi -Itrace -Iui/shader
-I/usr/include/capstone -I/usr/include/glib-2.0
-I/usr/lib/aarch64-linux-gnu/glib-2.0/include -fdiagnostics-color=3Dauto
-Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0 -g -fstack-protector-strong
-Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security
-Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
-Wno-shift-negative-value -isystem
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/linux-headers
-isystem linux-headers -iquote . -iquote
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu -iquote
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/include
-iquote /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/host/includ=
e/aarch64
-iquote /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/host/includ=
e/generic
-iquote /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tcg/aarch64
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
-fno-strict-aliasing -fno-common -fwrapv -fno-pie -no-pie
-fzero-call-used-regs=3Dused-gpr -isystem../linux-headers
-isystemlinux-headers -DCOMPILING_PER_TARGET
'-DCONFIG_TARGET=3D"aarch64-linux-user-config-target.h"' -MD -MQ
libqemu-aarch64-linux-user.a.p/linux-user_fd-trans.c.o -MF
libqemu-aarch64-linux-user.a.p/linux-user_fd-trans.c.o.d -o
libqemu-aarch64-linux-user.a.p/linux-user_fd-trans.c.o -c
../linux-user/fd-trans.c
../linux-user/fd-trans.c: In function =E2=80=98host_to_target_data_addr_rta=
ttr=E2=80=99:
../linux-user/fd-trans.c:1181:10: error: =E2=80=98IFA_PROTO=E2=80=99 undecl=
ared (first
use in this function); did you mean =E2=80=98IFA_RTA=E2=80=99?
1181 | case IFA_PROTO:
| ^~~~~~~~~
| IFA_RTA

Thanks,
Stefan

