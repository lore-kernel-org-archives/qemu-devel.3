Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EC0C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWdZ-0000Oi-0P; Fri, 23 Feb 2024 09:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdWVx-0006by-Jk
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:27:01 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdWVw-0008Kl-2b
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:27:01 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-564a53b8133so533093a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708698418; x=1709303218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+t5x9rR2LwXUuL+CTRbQc2GK1VB3ALj4Vmgi21EOVIw=;
 b=ZE79DxZuVZfytbxP2/pfLskhSGrqXKjk3suDt+cuTQGdxjGyOCiv6puE6/BFflX2qj
 0tZmn31LgPxrpA+zLJaZ+Re88EU/MYy4B8hIEGkDq/SZ2QZSk97Gl2eU60Jm5G/GQ5IS
 NNO3KIBWYFY9c53oqaKGN5Djc+nyJaO5m/ww09E18DXT7WUEBmOqFkGRShE6UzNJxXcC
 lXbpZu4qp8aflj20R1H0PkITMX7AlWN3yTvAks69fhRTy4W8q9oBUfnIZu+J0lKjvX+d
 e2G87BugO+tcJMtyTVVZM71WTZuODHOgEfphKPD5zJpdJwfpCXdx8q4tzzyKOM72ZjDn
 tmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708698418; x=1709303218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+t5x9rR2LwXUuL+CTRbQc2GK1VB3ALj4Vmgi21EOVIw=;
 b=dNUOLwy+rzcbViwBsH4pvDqtn4/TLbPYMMtc6f7nhhmstkmQdvorA6rHbTcnpTxWSc
 pb1i7BLuS9vm5IWyaGmvnD6ueUuuMPMFUtPlNqndOCL0pS776sYosAp4SIVzEtDCDwdn
 otqEWgzulfh/TD4mE5gdyWtwPJQz8sd5zsv2nkCjIMkJrulE64Q+HoXPY47HtcXbitUr
 ikIsGpPW586GOjMb42jSqf+dl19dhZrDJ0Iu+tS71Pgpv8oyRIwx5h4jSHwFViGg456i
 pwOEU50FMZJ0O2UnAbv4FjyEgPJ4Gxg9iFbBGNSTIMz3vw94w5ro14dH5sY9z+pPMSNb
 Ffpg==
X-Gm-Message-State: AOJu0YxX99sYFQi0aQpAxJsucyKcy2v0/m3O7Ir1/Q+eghhoeV7m/HEE
 qBRlPzI5buLmanupoYPVF6BJwacsCFcdfc5Ss82c4voN10bcRdHgueHyN3zszB7Z9hGM8VeY46s
 DHmCzrs/JytjwUEqibu0R0EW53FTK1M2g22NtWQ==
X-Google-Smtp-Source: AGHT+IFBkQYeoyh78C6dKCumcRVkWk2yql/eHbXjC6N5Xe06g5yZUz8sqZ/1tx1DBvMlD7qwDs9zfcIUxUHhY81e4pI=
X-Received: by 2002:a05:6402:160a:b0:564:7350:cac8 with SMTP id
 f10-20020a056402160a00b005647350cac8mr1367755edv.15.1708698417766; Fri, 23
 Feb 2024 06:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
 <20240219200908.49551-2-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240219200908.49551-2-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 14:26:46 +0000
Message-ID: <CAFEAcA_LZ6oGj_y+_9zKDZNVSk8zOb4hQG+OKETXyE3-ezP_Rg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] Implement STM32L4x5_RCC skeleton
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024 at 20:11, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Add the necessary files to add a simple RCC implementation with just
> reads from and writes to registers. Also instanciate the RCC in the

"instantiate"

> STM32L4x5_SoC. It is needed for accurate emulation of all the SoC
> clocks and timers.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---



> +static const MemoryRegionOps stm32l4x5_rcc_ops =3D {
> +    .read =3D stm32l4x5_rcc_read,
> +    .write =3D stm32l4x5_rcc_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .max_access_size =3D 4,
> +        .unaligned =3D false
> +    },
> +};

What's the .valid.min_access_size ?
Do we need to set the .impl max/min access size here too ?


> +
> +static const ClockPortInitArray stm32l4x5_rcc_clocks =3D {
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, hsi16_rc, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, msi_rc, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, hse, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, lsi_rc, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, lse_crystal, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, sai1_extclk, NULL, 0),
> +    QDEV_CLOCK_IN(Stm32l4x5RccState, sai2_extclk, NULL, 0),
> +    QDEV_CLOCK_END
> +};

These are input clocks, so they each need a VMSTATE_CLOCK()
line in the VMStateDescription. (I think only input clocks
need to be migrated.)

> +
> +
> +static void stm32l4x5_rcc_init(Object *obj)
> +{
> +    Stm32l4x5RccState *s =3D STM32L4X5_RCC(obj);
> +
> +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32l4x5_rcc_ops, s,
> +                          TYPE_STM32L4X5_RCC, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +
> +    qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
> +
> +    s->gnd =3D clock_new(obj, "gnd");
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

