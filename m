Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E5AD3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 17:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Zuh-0000Y3-K0; Sun, 20 Oct 2024 13:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1t2Zuc-0000Xm-R2
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 13:40:19 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1t2ZuY-0006wW-CK
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 13:40:18 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-84fc1a5e65bso1091981241.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729446009; x=1730050809; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5dQElZmdOpFlm9UG88kAU1LTaBVdJQXUvWqA3Tf+jXw=;
 b=iMJI2piBC8HitD5qq0cVI7XX4dgW3lDrN8XUsOLjSd7Bva13WM2l+8aKOVrkejZJdU
 Kx6rOxVxE4I3oh05ftDoj7jh3uC8NCaRPl9qBpJnwencFQvnDKrjjkIrpAYQeMldnMqY
 Jl+2jTxIDvge35b6Jn1/QEAOeysSajmVmN8UszyqAVfl4PE6pOv2ZHT2HGpGzLAjCg30
 oZ+Y2gp5Gyf9oHjVMCfRifLMfObeTj0G9OF8mzCd6oz4kUmW1d3iJ/TSdeji2zdNSL6O
 /Z2A9k2b/1rRbf+NR5NPOwddmX87wWwC74QpK1CWEpGieaWd3giv1wnGRuRSiFOqWEgy
 uhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729446009; x=1730050809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dQElZmdOpFlm9UG88kAU1LTaBVdJQXUvWqA3Tf+jXw=;
 b=rIakdgEdfcEYEdCR1wwIGHWYoThT6IKh5IQJnEz7K1hDM/pUhFAZ2TNT+K84fAreH9
 20yi2zB8MXV0F0mAu9Evu5yxPFzb3c5VzTJU4l2BJ0c0rlx8Z1NHWAn2TG+92Sja/6Kx
 IHVKcL7nCrJe1lMac8x6PKk1vDzE2iw/hkyj7a1+cFn5OgmJsfMXJoIM3QaPzFw1oDwr
 jHWgNKahMXoOUur8S9YE9ahUMnD1a3nokgEUQQFAAvhVQG7No0gX1LMeKZaRuhSkr9uE
 VvIsJJ9GOmHpEBfxwtvm8L7+adK0Q1d2d6/qH40WBmclp2Bddue7HoV1cwcnGaVU8ZtJ
 qYyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3wBkyqPUQY3uJgfRltln7sGaYTRXColblC5CAbj9FYcNpquZswVY4vOiNTNJ/l/12kIXrDKRywW+B@nongnu.org
X-Gm-Message-State: AOJu0YxfNaKFvZauWZ11kkgGb1deOAjEfw0iUCVxcR1E/X27y7fMSNPw
 3D8imDHr5WxKG+8jvu5MIFNj/oJmB7xSla3IVcPDjBEXPsLZuiiBQgjJy4sdySWBdbm7gIddKqc
 Q7dwPRlEyqBdBTUSaTFQOaxvni20g5/dDKFGYEQ==
X-Google-Smtp-Source: AGHT+IG4vi/NuEfb80CzvtYT1ihWDnjiE86tCBRUI0Pm+Ge1Bb280g9GXaYQ34p3oxV9/F2MPuI42yWtHFMEmMGjwcQ=
X-Received: by 2002:a05:6102:3a0d:b0:49e:94e8:acd5 with SMTP id
 ada2fe7eead31-4a5d6b746e3mr8432271137.22.1729446009509; Sun, 20 Oct 2024
 10:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
In-Reply-To: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 20 Oct 2024 23:09:57 +0530
Message-ID: <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: open list <linux-kernel@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>,
 Aishwarya TCV <Aishwarya.TCV@arm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anders Roxell <anders.roxell@linaro.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=naresh.kamboju@linaro.org; helo=mail-ua1-x934.google.com
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

On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
> The boot log is incomplete, and no kernel crash was detected.
> However, the system did not proceed far enough to reach the login prompt.
>
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> The arm devices TI beaglebone x15 boot pass.
>
> This is always reproducible.
> First seen on Linux next-20241017 tag.
>   Good: next-20241016
>   Bad: next-20241017
>
> qemu-armv7:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig

Anders bisected this boot regressions and found,
# first bad commit:
  [efe8419ae78d65e83edc31aad74b605c12e7d60c]
    vdso: Introduce vdso/page.h

We are investigating the reason for boot failure due to this commit.

Anyone have noticed a similar qemu-arm boot regressions with
the Linux next-20241017 and  next-20241018 tags ?


> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Boot log:
> -------
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.12.0-rc3-next-20241017
> (tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0,
> GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1729156545
> [    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] random: crng init done
> [    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Size (0x04000000) of region at 0x00000000 exceeds
> limit (0x00000000)
> [    0.000000] cma: Failed to reserve 64 MiB on node -1
>
> <nothing after this>
>
> Boot log link,
> -----
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/details/
>
> Build images:
> ------
>  - https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/
>
> Steps to reproduce via qemu:
> ----------------
> /usr/bin/qemu-system-arm -cpu cortex-a15 \
>           -machine virt,gic-version=3 \
>           -nographic -nic none -m 4G -monitor \
>           none -no-reboot -smp 2 \
>           -kernel zImage \
>           -append \"console=ttyAMA0,115200 rootwait root=/dev/vda
> debug verbose console_msg_format=syslog systemd.log_level=warning rw
> earlycon\"
>           -drive
> file=debian_trixie_armhf_rootfs.ext4,if=none,format=raw,id=hd0 \
>           -device virtio-blk-device,drive=hd0
>
> Steps to reproduce with tuxrun reproducer:
> ---------------
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/reproducer
>
> Boot history compare link:
> ------------------------
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241017/testrun/25476340/suite/boot/test/clang-19-lkftconfig/history/
>
> metadata:
> ----
>   git describe: next-20241017
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/tests/2nYi2nidfMq35VigDlxJblZzokr/
>   toolchain: clang-19, gcc-13 and clang-nightly
>   config: lkftconfig
>   arch: arm
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

