Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7F2C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq35K-0007PP-So; Wed, 05 Mar 2025 23:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq35D-0007Oj-IC; Wed, 05 Mar 2025 23:43:44 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq35B-0001oW-Q8; Wed, 05 Mar 2025 23:43:43 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-86b31db3c3bso72457241.3; 
 Wed, 05 Mar 2025 20:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741236220; x=1741841020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sxAwyMut+Gvjjv1ae6Ch3FK4ooK3tCw1t5KNxXISDo=;
 b=ECcr1WZx6j9YaKmkV8qV4UoagQsLVNaMwQt6VUy1LDSYN9e0DGMH8uvjqSxweSuWY8
 UjxZD7Um3zCtkKlmcp3kqMk13AcDFONIuXmHIf38qqzCFUQ3d3s0ga5iaV/2XD+o+pO9
 vYe2eLjrLelMSEsxYtNmHn2vDguSb2ytjCpIzi8cRzc7+3wtoJfa4gB2EbUJnxWskmAC
 7UPhGZoMAbyRLBRwy4zxK3Reb2Dn39tHY4QO359vF/lsUhLNsZYhr/eaNsfROuCfkAs2
 0Nn6Qi7tJiz0SfzqmNAr2H6zZ+Qcz0bSEOUnofW1EZQZTwNDPAV4Sc7ZL8KYcIqo2io4
 0gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741236220; x=1741841020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sxAwyMut+Gvjjv1ae6Ch3FK4ooK3tCw1t5KNxXISDo=;
 b=MeY6z/PThftz4OsQiQzuqimkZ19/w7XBlXpEKfom9VNxUpC1XwWHNPMbuthnnTdoti
 8bxB+bEJ+QXBnT1Oay1zr2os2q3afFnFw00BmZikqV7Gh/HxrH/tnXpHKz1PnjM6s+ay
 WeEUkd8f1iOf06SGW0LqpGhngKPZDL6Byu3VGQFjwIohIlPR/ePcvxg76FUDa+8G0p57
 dqMI61qkPQF5bPa5g7+gZVpA5rctxKelEjqzWGCm4OaYk7pvxqv7raHMgSYT6NYXC90J
 WNwQr+UV4QCE3+D4AJukKdjFRX9V40aZ83hGS9jgl0uDnIOL6dagqb7k7JkXMx06yFlu
 zshA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSJdweDH4+IikgF9Et13AucLAvh627ckPBDQm70vs1aP0n5e8ZCMnGeRJnoi5/zKapWq6OlBHQYpRO@nongnu.org
X-Gm-Message-State: AOJu0YxM7RInnVFi8Rq9uq9Rw0Sq1QzUgluw7yWqD07rFuQgW3U8SQJ0
 pP38qj1jSFjmmFKA8jZaudFCKu6mKk5GoFjng4hDV2qBdvaAOnVcPd99YK6MhNfT5knWEFkr6Y/
 pVls//P1XSaHrAW4GX37zWMOjPcw=
X-Gm-Gg: ASbGncsT49nyqdRTezWeJMSmqOBobr+/ZqiYuilxQ6LqC/qsRsEJ+szJwBzvb+YdGcv
 r8bSayO6g8uCWRdpZfDW1lLeEidK6DMdWv/j3/69pWAXdCuZW6aiOaZHpMmW/kpLtAJSMVlpVEV
 wUG4VOGv1k7e7v3Ucw0dKl+yGUxQU6BKyIOb8QQWQIjUhFg5Va9ZNxSIIr
X-Google-Smtp-Source: AGHT+IFP7404/wOPXx5L99k2dZFNG2JuWq40W7RGjhOqsfCbFlgcwZ5HngB3mE3REYaxHENGQCd/LMBvN2ABFEFbemE=
X-Received: by 2002:a05:6102:4408:b0:4c2:20d3:a125 with SMTP id
 ada2fe7eead31-4c2e27a87bemr3898146137.8.1741236219971; Wed, 05 Mar 2025
 20:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 14:43:14 +1000
X-Gm-Features: AQ5f1JqPqBvUHZzNkM1u-b-p5BqUxyI5OjORICHc2HnS_8S6qIghzha5n6oLkr0
Message-ID: <CAKmqyKNbKCZbT6F7gP4p6o1pi_fW5hyr06GR46_09HAXMo_ztA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Improve Microchip Polarfire SoC customization
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Feb 25, 2025 at 10:55=E2=80=AFAM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Booting the microchip-icicle-kit machine using the latest PolarFire SoC
> Hart Software Services (HSS) no longer works since Qemu lacks support
> for several registers (clocks, DRAM controller). Also reading from the
> SDCard does not work currently.
>
> In order to allow tests runs for real-time kernels such as RTEMS and
> Zephyr, improve the boot customization. This patch set enables a direct
> run of kernel executables, for example:
>
> qemu-system-riscv64 -no-reboot -nographic \
>   -serial null -serial mon:stdio \
>   -smp 2 \
>   -bios none \
>   -machine microchip-icicle-kit,clint-timebase-frequency=3D10000000 \
>   -kernel rtos.elf
>
> v2:
>
> * Add documentation update.
>
> * In patch 3, warn if no device tree is specified.
>
> * In patch 4, use riscv_find_firmware() to locate the firmware shipped wi=
th Qemu.
>
> Sebastian Huber (6):
>   hw/misc: Add MPFS system reset support
>   hw/riscv: More flexible FDT placement for MPFS
>   hw/riscv: Make FDT optional for MPFS
>   hw/riscv: Allow direct start of kernel for MPFS
>   hw/riscv: Configurable MPFS CLINT timebase freq
>   hw/riscv: microchip_pfsoc: Rework documentation

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  docs/system/riscv/microchip-icicle-kit.rst | 124 ++++++-----------
>  hw/misc/mchp_pfsoc_sysreg.c                |   7 +
>  hw/riscv/microchip_pfsoc.c                 | 151 +++++++++++++++------
>  include/hw/riscv/microchip_pfsoc.h         |   1 +
>  4 files changed, 162 insertions(+), 121 deletions(-)
>
> --
> 2.43.0
>

