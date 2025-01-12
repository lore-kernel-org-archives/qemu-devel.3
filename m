Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F295EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 23:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX7fK-0002qK-L9; Sun, 12 Jan 2025 18:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX7fJ-0002q8-Fe; Sun, 12 Jan 2025 18:46:45 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX7fH-0007sT-NL; Sun, 12 Jan 2025 18:46:45 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4aff1c57377so2118064137.0; 
 Sun, 12 Jan 2025 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736725602; x=1737330402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9O660XbMNachmX0zw4ZgF49qepPT7E3bYqs5jTTxKw=;
 b=P6YQ57HoQtNKswq1Ix0RSgubJJooIaHukwtNsYnNSRpPRPCp8XjEjXogDNoDga8ih/
 BaqRyY/5qt95ixt7REBzGUOQ1Or8qZbNaJGwRxkexhdCiQb7dGc1IFW38idkuRDGph+o
 ymS1/q1aCXIjCcfTnodUCAQvllfX6dbQO36LEBLqTWcrtBwmK+3IYHKSGIw3OUNeunD+
 JE/UsbY2shpLJ8z2EygrNJrjaIXZhKBIUHAFRV8+i5nP33qSC62CW0rDpoxRVsD6I3lm
 jNXP0Lta2dpj0adj79Ml624XMENSPnWcmbo08EtKO8ooDHO/VhJ9ZKF6kjEnoHR5UOtH
 5OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736725602; x=1737330402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9O660XbMNachmX0zw4ZgF49qepPT7E3bYqs5jTTxKw=;
 b=WHzpzuTu/lIdJHO6DHz1M58dv267jpGavDeQSL6kvPvdJM/M4x8V9if7VV9TQW833k
 VzcFYhno17zIcd1Zed1UhRK/pEq/g6GUdXuEJDREik1aVEe7nwZqPS/WCAI0nhPw4adv
 Wj5GFWjLAVIpQXU4f4yyONSQcPRbXCs9LmQWXaX2PWS0Fr8XOfGG0YJ+OTcP73IFJsMl
 DoV5ya3ocD/dzV+mDL+1I0w2k1+acHjiaJER7cBAxVWVL1GSgIE0hDsVd32ESzSKqqdz
 ENlDdpT4ScDxrebXTqLtbKROMYr9umGS97nyVHjQOUVc6nDhVu4t95aUpR/q0bYd5EP4
 sYwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxhOD5i3UTUvzjXMx8NiyjKrOM5kpPPM0Atbv5H3fvqoWqrJP2paiJJITLMZMWoePBh+ZMYRWmPw==@nongnu.org
X-Gm-Message-State: AOJu0Yx8zM1IUQX44TQUhzODO9pt4va1C+gEqObYkO/3ea1SjSrbvFSH
 fEmSlz3utlAHLDweYPcQ9f+aZa9hvFhQDxs2R10TaIi+5Dd4a44Ktsgb6mEfHrQnWFjGHLkmExz
 ljmNpbxaRoc1/V1WMP2sCtTuH1V8=
X-Gm-Gg: ASbGncvuHDO2+vCS3SupSa2ifjqgXYJ+vlQCKxXwV88AlBkuGQ/pepC6VFVnKldhtkO
 tMmueJnrymEcWu9yLuldoYkFtmars66d8ohHSkcX4/qwgohazwlYTrZQSFjNeXQIRMf4=
X-Google-Smtp-Source: AGHT+IFYzO1ycg8poPCdmKSHxklr1vLbd0JDVB2137Li5i9iguPFObJTLV5Xfz7bP7jok1nOoQCbp5rfCo4bvvbceyI=
X-Received: by 2002:a05:6102:4a10:b0:4b2:bcae:a721 with SMTP id
 ada2fe7eead31-4b5820cf928mr12894705137.11.1736725602277; Sun, 12 Jan 2025
 15:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20250112225614.33723-1-philmd@linaro.org>
 <20250112225614.33723-4-philmd@linaro.org>
In-Reply-To: <20250112225614.33723-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 09:46:16 +1000
X-Gm-Features: AbW1kvZBt50-96btYV3kgYc92gRZ2BChskYUDhYtjIMZ4hcb5MjmHiWomP6UO1I
Message-ID: <CAKmqyKM6vjXR32F4yvLc1qsT=WoZSbcZuwnvNX1Bndv3Smx33A@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/arm/v7m: Remove use of &first_cpu in machine_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>,
 qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Joel Stanley <joel@jms.id.au>, Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Mon, Jan 13, 2025 at 8:57=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> When instanciating the machine model, the machine_init()
> implementations usually create the CPUs, so have access
> to its first CPU. Use that rather then the &first_cpu
> global.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/b-l475e-iot01a.c    | 2 +-
>  hw/arm/microbit.c          | 2 +-
>  hw/arm/mps2-tz.c           | 2 +-
>  hw/arm/mps2.c              | 2 +-
>  hw/arm/msf2-som.c          | 2 +-
>  hw/arm/musca.c             | 2 +-
>  hw/arm/netduino2.c         | 2 +-
>  hw/arm/netduinoplus2.c     | 2 +-
>  hw/arm/olimex-stm32-h405.c | 2 +-
>  hw/arm/stellaris.c         | 2 +-
>  hw/arm/stm32vldiscovery.c  | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
> index 5002a40f06d..c9a5209216c 100644
> --- a/hw/arm/b-l475e-iot01a.c
> +++ b/hw/arm/b-l475e-iot01a.c
> @@ -82,7 +82,7 @@ static void bl475e_init(MachineState *machine)
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>
>      sc =3D STM32L4X5_SOC_GET_CLASS(&s->soc);
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0,
> +    armv7m_load_kernel(s->soc.armv7m.cpu, machine->kernel_filename, 0,
>                         sc->flash_size);
>
>      if (object_class_by_name(TYPE_DM163)) {
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> index 374fbcb3618..3f56fb45ce1 100644
> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -56,7 +56,7 @@ static void microbit_init(MachineState *machine)
>      memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI_B=
ASE,
>                                          mr, -1);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +    armv7m_load_kernel(s->nrf51.armv7m.cpu, machine->kernel_filename,
>                         0, s->nrf51.flash_size);
>  }
>
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index 0136e419bfd..d3a9f1b03ac 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -1211,7 +1211,7 @@ static void mps2tz_common_init(MachineState *machin=
e)
>                                      mms->remap_irq);
>      }
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +    armv7m_load_kernel(mms->iotkit.armv7m[0].cpu, machine->kernel_filena=
me,
>                         0, boot_ram_size(mms));
>  }
>
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index efb3500742f..56b2af40f1d 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -460,7 +460,7 @@ static void mps2_common_init(MachineState *machine)
>                   qdev_get_gpio_in(armv7m,
>                                    mmc->fpga_type =3D=3D FPGA_AN511 ? 47 =
: 13));
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +    armv7m_load_kernel(mms->armv7m.cpu, machine->kernel_filename,
>                         0, 0x400000);
>  }
>
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index 5c415abe852..9b20f1e2c98 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -92,7 +92,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machi=
ne)
>      cs_line =3D qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +    armv7m_load_kernel(soc->armv7m.cpu, machine->kernel_filename,
>                         0, soc->envm_size);
>  }
>
> diff --git a/hw/arm/musca.c b/hw/arm/musca.c
> index 3c3b534cb72..e9c092abc3d 100644
> --- a/hw/arm/musca.c
> +++ b/hw/arm/musca.c
> @@ -590,7 +590,7 @@ static void musca_init(MachineState *machine)
>                                                       "cfg_sec_resp", 0))=
;
>      }
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +    armv7m_load_kernel(mms->sse.armv7m[0].cpu, machine->kernel_filename,
>                         0, 0x2000000);
>  }
>
> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> index 8b1a9a24379..df793c77fe1 100644
> --- a/hw/arm/netduino2.c
> +++ b/hw/arm/netduino2.c
> @@ -48,7 +48,7 @@ static void netduino2_init(MachineState *machine)
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +    armv7m_load_kernel(STM32F205_SOC(dev)->armv7m.cpu, machine->kernel_f=
ilename,
>                         0, FLASH_SIZE);
>  }
>
> diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
> index bccd1003549..81b6334cf72 100644
> --- a/hw/arm/netduinoplus2.c
> +++ b/hw/arm/netduinoplus2.c
> @@ -48,7 +48,7 @@ static void netduinoplus2_init(MachineState *machine)
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu),
> +    armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
>                         machine->kernel_filename,
>                         0, FLASH_SIZE);
>  }
> diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
> index 4ad7b043be0..1f15620f9fd 100644
> --- a/hw/arm/olimex-stm32-h405.c
> +++ b/hw/arm/olimex-stm32-h405.c
> @@ -51,7 +51,7 @@ static void olimex_stm32_h405_init(MachineState *machin=
e)
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu),
> +    armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
>                         machine->kernel_filename,
>                         0, FLASH_SIZE);
>  }
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 7303e096ef7..284980ad4b5 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1366,7 +1366,7 @@ static void stellaris_init(MachineState *ms, stella=
ris_board_info *board)
>      create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
>      create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, 0, flash=
_size);
> +    armv7m_load_kernel(ARMV7M(armv7m)->cpu, ms->kernel_filename, 0, flas=
h_size);
>  }
>
>  /* FIXME: Figure out how to generate these from stellaris_boards.  */
> diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
> index cc419351605..e6c1f5b8d7d 100644
> --- a/hw/arm/stm32vldiscovery.c
> +++ b/hw/arm/stm32vldiscovery.c
> @@ -51,7 +51,7 @@ static void stm32vldiscovery_init(MachineState *machine=
)
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu),
> +    armv7m_load_kernel(STM32F100_SOC(dev)->armv7m.cpu,
>                         machine->kernel_filename,
>                         0, FLASH_SIZE);
>  }
> --
> 2.47.1
>
>

