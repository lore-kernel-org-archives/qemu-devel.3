Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D58C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 20:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59J4-0006xy-Ne; Wed, 16 Apr 2025 16:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59J2-0006xP-Kk
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:24 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u59J0-0002Dc-MC
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:24:24 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4769e30af66so20881cf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744835061; x=1745439861; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIlrewoaQYQbA7a3DJLRaGEKksLPhtEAOMpnKU4+utU=;
 b=xqvDhn1TkRIJkxiqfP93I29dkHp09SlbvamgqIcRQckicCiBMf8CNEX+wl2az6+etf
 qiWePumIpRvLEYGvidglJXOO41lp5x3NPOVEJTZi/fzshQEkwgmauPblgEhoF+zsQHLL
 9+aCeYr878XcgyUbb4rwHXTT5xlB8rzNcePPSvqb7KTEkt/dlg221S71QPmqb/pDw5am
 i8HwdgVARpVrdvzh8YE1e3pLX+9HUabJDcaQEKSZBtZeFRUvW6HpDStl7jCIxYiNB2UG
 Re3l/gY3Ix+j+VEkbYRVVCT/xmrpQfCC5fLZKxF3EcJDbXt/1HrW9PUsXJRLdQXIO9MH
 6cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744835061; x=1745439861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIlrewoaQYQbA7a3DJLRaGEKksLPhtEAOMpnKU4+utU=;
 b=PeU9UpVI8fMYKo1QrHc9kCY/ghk9Jft0WoavfeqOwalwFYko32IEoMK1wKjcfjuVe5
 eJ9xXsT1R428rr0FlYXCub7yrNIOMYI3K3i08g6+Nfrk+7sKz6/5Z+a5JuqIORGCuNoS
 Gvrv+UQKcQSdJ32Hd5lRGRnISlgwsyXfHcAF6mLJuAvsDP6es9kleSOvkwk0OFkv14rv
 /Qr8jyzXKaZJk2dl4YGYXwZO8I9urmVElCzzW4ynZNO5P16JEcghhhZptADWNT+74Qbw
 btKXhTjg6AoNrZ1iVG49qZszHv2BYHuvtUiHV3u78MvY2+//i66NRMTSlN+FsShsBQ2N
 TsZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn7xFi8dXB2Rl+MOGpxYQDaTozqUqcL283r24JQ5vj+exbNtFn9+gIDd5l+AHpyopG+eFrMU8Qson+@nongnu.org
X-Gm-Message-State: AOJu0YzVaHTkIr8c74/0ilQwo41P4K64AV9OIeoyvzW3MslVZ/vQuAMR
 kCSaHOi0PYDZlKgDnUBiVqeUtQUp5DFcvzaxFm5Kd6r1FGt07CAeRvF4xsARrKh3cpAa6IUAyy1
 rNJjgIZIMUQZwE3J7yo4rF8fsCVJKcLQfrxl1
X-Gm-Gg: ASbGncsSi+1Gb6VgQ0pFcD4uNp4DMLpXzw4jr/d1tpQ2ZFeaNY/y2q3ZtH6tkx6C2fA
 i8iX/4BjEJsJrMkHv788kbzrL18bjjW2E5sUXc1Hb0Kj4h6FHNi+2p4Y0HMBE38Qlj/gDFpn1J4
 9hTXSJUsXdURn4kjhbkBL9U9lw4qYiQQoEfiVuXRMVLd++blq1BCreh+6wIxO9SnQ=
X-Google-Smtp-Source: AGHT+IEHSAe+CoY77WTZsYDiPWOBn7CyocWflB59+Guets0OjWo+eGBnGjSAVusKTi8ryLMQiDN8sRHw6o1CNysOWdM=
X-Received: by 2002:ac8:5d4e:0:b0:476:d668:fd1c with SMTP id
 d75a77b69052e-47ade60b880mr943071cf.2.1744835061292; Wed, 16 Apr 2025
 13:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250416034327.315714-1-jamin_lin@aspeedtech.com>
 <20250416034327.315714-6-jamin_lin@aspeedtech.com>
In-Reply-To: <20250416034327.315714-6-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 16 Apr 2025 13:24:09 -0700
X-Gm-Features: ATxdqUHuiKuaCRgygQT4464B8pLf8NVPA2tkBPJ3a-HZPxZUrl-QFbIC7Bb5LzU
Message-ID: <CA+QoejVSakV1zfpUwP_ybF5AzcO9k9LYy=ApiR-joi94oRUH4w@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -178
X-Spam_score: -17.9
X-Spam_bar: -----------------
X-Spam_report: (-17.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This has to happen after we have the bootrom in QEMU or it will fail
on the default cases. Besides that it looks good.

On Tue, Apr 15, 2025 at 8:43=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Introduce "aspeed_load_vbootrom()" to support loading a virtual boot ROM =
image
> into the vbootrom memory region, using the "-bios" command-line option.
>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  include/hw/arm/aspeed.h |  1 +
>  hw/arm/aspeed.c         | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 973277bea6..2b8332a7d7 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -41,6 +41,7 @@ struct AspeedMachineClass {
>      uint32_t uart_default;
>      bool sdhci_wp_inverted;
>      bool vbootrom;
> +    const char *vbootrom_name;
>  };
>
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index b70a120e62..7f11371f02 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -27,6 +27,7 @@
>  #include "system/reset.h"
>  #include "hw/loader.h"
>  #include "qemu/error-report.h"
> +#include "qemu/datadir.h"
>  #include "qemu/units.h"
>  #include "hw/qdev-clock.h"
>  #include "system/system.h"
> @@ -305,6 +306,34 @@ static void aspeed_install_boot_rom(AspeedMachineSta=
te *bmc, BlockBackend *blk,
>                     rom_size, &error_abort);
>  }
>
> +/*
> + * This function locates the vbootrom image file specified via the comma=
nd line
> + * using the -bios option. It loads the specified image into the vbootro=
m
> + * memory region and handles errors if the file cannot be found or loade=
d.
> + */
> +static void aspeed_load_vbootrom(MachineState *machine, uint64_t rom_siz=
e,
> +                                 Error **errp)
> +{
> +    AspeedMachineState *bmc =3D ASPEED_MACHINE(machine);
> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(machine);
> +    const char *bios_name =3D machine->firmware ?: amc->vbootrom_name;
> +    g_autofree char *filename =3D NULL;
> +    AspeedSoCState *soc =3D bmc->soc;
> +    int ret;
> +
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!filename) {
> +        error_setg(errp, "Could not find vbootrom image '%s'", bios_name=
);
> +        return;
> +    }
> +
> +    ret =3D load_image_mr(filename, &soc->vbootrom);
> +    if (ret < 0) {
> +        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name=
);
> +        return;
> +    }
> +}
> +
>  void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>                                        unsigned int count, int unit0)
>  {
> @@ -483,6 +512,11 @@ static void aspeed_machine_init(MachineState *machin=
e)
>          }
>      }
>
> +    if (amc->vbootrom) {
> +        rom_size =3D memory_region_size(&bmc->soc->vbootrom);
> +        aspeed_load_vbootrom(machine, rom_size, &error_abort);
> +    }
> +
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
>  }
>
> @@ -1691,6 +1725,7 @@ static void aspeed_machine_ast2700a0_evb_class_init=
(ObjectClass *oc, void *data)
>      amc->uart_default =3D ASPEED_DEV_UART12;
>      amc->i2c_init  =3D ast2700_evb_i2c_init;
>      amc->vbootrom =3D true;
> +    amc->vbootrom_name =3D "ast27x0_bootrom.bin";
>      mc->auto_create_sdcard =3D true;
>      mc->default_ram_size =3D 1 * GiB;
>      aspeed_machine_class_init_cpus_defaults(mc);
> @@ -1712,6 +1747,7 @@ static void aspeed_machine_ast2700a1_evb_class_init=
(ObjectClass *oc, void *data)
>      amc->uart_default =3D ASPEED_DEV_UART12;
>      amc->i2c_init  =3D ast2700_evb_i2c_init;
>      amc->vbootrom =3D true;
> +    amc->vbootrom_name =3D "ast27x0_bootrom.bin";
>      mc->auto_create_sdcard =3D true;
>      mc->default_ram_size =3D 1 * GiB;
>      aspeed_machine_class_init_cpus_defaults(mc);
> --
> 2.43.0
>

