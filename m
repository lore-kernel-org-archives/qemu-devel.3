Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1F1C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0WsI-0003DK-71; Thu, 03 Apr 2025 22:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WsH-0003D7-Ei; Thu, 03 Apr 2025 22:33:41 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WsF-00048G-S0; Thu, 03 Apr 2025 22:33:41 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-86dde90e7a3so698240241.1; 
 Thu, 03 Apr 2025 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743734018; x=1744338818; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bwOuelpGM1Yba2R3/XOOIlbsmMz76TTHXdCfw0UXaU=;
 b=HWCUhom5EqMbuC2/ZgjO3tYA2SUCYNIp0VfwL/InM7tgMxgRPvlIO7w2A9nvwUb96F
 GyDginKDhnWXMLhRsM3IT7fXdzmXcGsYkLYxMQ3504ApdQDNdu1bLozgzkaMRu9s9FoC
 yTxB0zoT2c0KSX3LzlWSKzPsBE+0nyKwUGT0dVUCOqwwLO8/FOwX1cMygFz2JfmfMuS1
 JWaLDzWNxnx9tFqnHi8l8106fdaYIwNWzNGbkMK07MwYC5o7d8GgvDGkm2b76myUMv1Y
 iEcA9ue3kpJr8owut0SBep2f1ahOcMFXrRF9sUm44LZmcAWEGAM84EGj0/pS+B93+aBB
 jXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743734018; x=1744338818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bwOuelpGM1Yba2R3/XOOIlbsmMz76TTHXdCfw0UXaU=;
 b=WbcG9LLFUy0YC+Eomy7KYRqT1DGyLOSSUV1/aZvKqJ6794oYepr+nxvcC2slhlk9VC
 3hScQ3u4zgLYbosBwifuUCIUtnx9hHHkWWVD7iSwnVO8BKVgOD3m3jC8FTOQl0mzW6Pw
 JV9nwsANmEawRsQrP2nY199t+dxdbjSI0Amj7LdXuuvuwmsXv7pzmZAP6kgFNWUUW7xN
 XNdRHzLrnAb1+jUNg7ET0DkDCsH5hLVB8Bl5Tel21SSP9RqlOYxPHJw60Q5xzlGzdcef
 OK2LArtvdzG2fVTYloVL/bA8D1bSwfGUvCKcvZeGzSe1asECU3ltFlX7RwzNWL55+pEX
 Qgcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNoW0Csok/DRBfovpXaX9bwtaqWK9vc+IovXPOJHBR5b70jcxX2pH3YZTaxgFeWzPv/mcko9NaRcab@nongnu.org
X-Gm-Message-State: AOJu0Yy6Ic4jEHNt1Ty7GD0pTG9vFDrPtsDQaB4zt0AadaxI8hYSa83h
 HOzS9gdMpn5Q/qUy6hypYyCZS9hu6A/ZUvcJa5WB/p3xi99f8x10SH3xj23qRY+uwhjQpmxEm7m
 cOt/TbZFdlk7dxE6X2bwX6EvVQd8=
X-Gm-Gg: ASbGncsoXwY0Yze/BdvmZOcvhApKuMxGHYhoel3Thzov4Jayho50JzmUA67phCBIHH/
 E/tZGxbYc9ComwF/wfwBE1+abqMeneK227Gss2FOhkZmWMlHpNJgR1DeIWDgsit9MikEu8L/f8A
 DVAWnfdl1LwL/HOz0SiDhk4V8ToAph/Y8JfEFr0q5GkTciQamiHpdyTxLI
X-Google-Smtp-Source: AGHT+IEamexak7DohjTooAObEop+vYcg2t3UDkHKUFyRwyJQM7gallaysukT3ub/sElSavqeJb9QaYnceA0fMVJGIiU=
X-Received: by 2002:a67:e7c7:0:b0:4c5:1c02:5b46 with SMTP id
 ada2fe7eead31-4c8554b8217mr1347698137.25.1743734018094; Thu, 03 Apr 2025
 19:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 12:33:11 +1000
X-Gm-Features: ATxdqUEpEJoXBYy4uz3xzmyDbljNtphMerFXIORqX0eIitov9VhojoLw6PFio5c
Message-ID: <CAKmqyKN3sjM1k=QMO9R3MtzSP1dy8ReJk81Kwi8Eq0G5F-j-dA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Improve Microchip Polarfire SoC customization
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Wed, Mar 19, 2025 at 4:13=E2=80=AFPM Sebastian Huber
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
> v3:
>
> * In patch 4, add support for Qemu test runs.
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
>  hw/riscv/microchip_pfsoc.c                 | 153 +++++++++++++++------
>  include/hw/riscv/microchip_pfsoc.h         |   1 +
>  4 files changed, 164 insertions(+), 121 deletions(-)
>
> --
> 2.43.0
>

