Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61636C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDWp-0000FF-4X; Fri, 28 Jun 2024 11:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDWm-0000EQ-PB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:28:44 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDWj-0002cH-CK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:28:44 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cb9a370ddso1060204a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719588520; x=1720193320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OlrX9SDkdFPcLBvdcs4vXRLWSRCSHXB+GXv+A370Q4A=;
 b=evy+aOK0LM0lnr2iIYlKkEursT9wcOOK51esK3ZOEnc7wCQ7sqNLXsawqLoy1m3N5m
 xzbX7ypEIdsmYqTpU3vwzXDMJqJZpKNtTqtlKD8lSab+u7IBuvDMVB7SnpDMctljb58w
 UM3Awo4kXNxUOA6UHmXmGVgNnjzmyIDq1Iok4xheP2VlvDKH6QolBd/PkV6c0VJ7rDeS
 2+jr2Z7f+RYOeOMf6rC5xD7JFd2v+sR868q985b1Nu2nch27QGuuKMQyEiMzN1F5DXB/
 AyzYt9VZcbL6rA8N0EqwibRAZmcFV6BwpVyT08vcOvQYEvAxPMtZd6hw/QIm44cEZHkk
 kd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719588520; x=1720193320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlrX9SDkdFPcLBvdcs4vXRLWSRCSHXB+GXv+A370Q4A=;
 b=MZmMAE4VfaiFmS2c/QHeAM5rGskIGlwQ6/X81fOd9Oc2CUneObybpR5itenWSnk6is
 VAvee9i4aWgujqF6siOYmYVi/yrGBMuvcwQYe70n9vBigUFpoD7oQ2aIrUEFeFhqd4u8
 NgzS8Ak9EMgi1Ptf0UzLY/UOse0VCt85GwRf/cfTCpBz4uIySbWh8vwbFehqjF0EwaVb
 fne+44tFM99jPrPyvGKtoE7LOZmSkO4wuQROMBR96OE5y5nVDrKsKbhMP8vDqRl2yhZx
 K7ShuSCeeG4sljHVIT+h6Sf7CfKeXQTJ0sg6rCj68Zp5c3yk3GZDuYJcIgsz6F4Vvea0
 WfKg==
X-Gm-Message-State: AOJu0Yzpc8h7dH+nRCqO0oS99voV69QAdpjc6F9Mg4oRZ4kyxZoX5uE/
 qhUX5qz8G7NbCbwtyeRhQlgq/k6XVzGRuQBqMrPknXPTfJ5NZj7kZn7q1WScH2FA0jsXkFPL2EC
 a7ja685gLsyT5rilMgEjVuR84WQDEjDbK114wzg==
X-Google-Smtp-Source: AGHT+IHgerdBg2z1k6AWz2xXvYQUQ8nvbNGrpVvawCmp9vdRt88K8Uol4RUWofdnDQH2z/YMmJvs1pamGWcTFOW9QgA=
X-Received: by 2002:a50:931a:0:b0:57d:2db9:15e8 with SMTP id
 4fb4d7f45d1cf-57d4bdcb3bfmr11229915a12.34.1719588519700; Fri, 28 Jun 2024
 08:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240628105437.635079-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240628105437.635079-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 16:28:28 +0100
Message-ID: <CAFEAcA9A67=qkLfwZgg1DgzQA9+fW34Uv7+pYcmGY4Yz=3xzPw@mail.gmail.com>
Subject: Re: [PATCH] hw/ide/macio.c: switch from using qemu_allocate_irq() to
 qdev input GPIOs
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 28 Jun 2024 at 11:55, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> This prevents the IRQs from being leaked when the macio IDE device is used.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/ide/macio.c                | 10 ++++++----
>  include/hw/misc/macio/macio.h |  5 +++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index aca90d04f0..e84bf2c9f6 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -420,7 +420,8 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
>  {
>      MACIOIDEState *s = MACIO_IDE(dev);
>
> -    ide_bus_init_output_irq(&s->bus, s->ide_irq);
> +    ide_bus_init_output_irq(&s->bus,
> +                            qdev_get_gpio_in(dev, MACIO_IDE_PMAC_IDE_IRQ));
>
>      /* Register DMA callbacks */
>      s->dma.ops = &dbdma_ops;
> @@ -456,8 +457,8 @@ static void macio_ide_initfn(Object *obj)
>      sysbus_init_mmio(d, &s->mem);
>      sysbus_init_irq(d, &s->real_ide_irq);
>      sysbus_init_irq(d, &s->real_dma_irq);
> -    s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
> -    s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
> +
> +    qdev_init_gpio_in(DEVICE(obj), pmac_ide_irq, MACIO_IDE_PMAC_NIRQS);
>
>      object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
>                               (Object **) &s->dbdma,
> @@ -508,7 +509,8 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
>
>  void macio_ide_register_dma(MACIOIDEState *s)
>  {
> -    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
> +    DBDMA_register_channel(s->dbdma, s->channel,
> +                           qdev_get_gpio_in(DEVICE(s), MACIO_IDE_PMAC_DMA_IRQ),
>                             pmac_ide_transfer, pmac_ide_flush, s);
>  }
>
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
> index 2b54da6b31..869b66055b 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -92,6 +92,11 @@ struct MACIOIDEState {
>      uint32_t irq_reg;
>  };
>
> +#define MACIO_IDE_PMAC_NIRQS 2
> +
> +#define MACIO_IDE_PMAC_DMA_IRQ 0
> +#define MACIO_IDE_PMAC_IDE_IRQ 1
> +
>  void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
>  void macio_ide_register_dma(MACIOIDEState *ide);

Can we also now delete the dma_irq and ide_irq fields from the
MACIOIDEState struct?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

