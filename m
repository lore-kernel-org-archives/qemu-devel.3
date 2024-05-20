Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAAEC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s93Iq-00015i-K6; Mon, 20 May 2024 09:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93Io-000151-C8
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:43:46 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93Im-00068v-L8
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:43:46 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so12137753a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716212623; x=1716817423; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CQJ0dr6xj2U9L7Z89lH1uYRqxyd/Zt8Blr5zZkqfx7A=;
 b=DmiFjN39I9ymgLgxq7C/6/mh63LBLInO5SG6pHg0lQb8sQckOFFs5m2HihI8E6PG17
 t0575TPpOunxwCeVl0235UuHPPTsSEsUnuxFs8DLvUscd9fgtOvvoCnrgoXuVtzHnvas
 FT8KE1WBnLaj2PQiT1mY2ZlZZEPTyMLr8rO83w9Q2Bfalw52MbBSIpq6IVhiZmSWeGwp
 Pp4RO9WAdnktYYzYZfi/KX7Kd9NenTqVKRNR0Zz//g0rFs8eIv803FMd8Vhc5fJkVGxD
 Hy+mzXtN2PS9x0fZJuVRcgOAjA7juxOxCjnjfu1Crg5vvAxH7kSEMKAf/ulDrH9Qlw3X
 V6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716212623; x=1716817423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQJ0dr6xj2U9L7Z89lH1uYRqxyd/Zt8Blr5zZkqfx7A=;
 b=xG6E7L4yH/Tc8MIZh8Z7vCPTmclwDuaJQF50Et0DP6pW6sq+yZe30d+uomjkvFmYjy
 ZfNEYQkmaLEbLQAyZT8fkuTY7NW0JWxVEsUt6VqxREILmCfk41ARy+dUY4zqcT3g+u21
 y3hu9DwNRttZjXIE/PbV4JF19fVX/exWbR5lGdjD4QISX7MgFlJUnMi6hW6DafjeeKmW
 eG4bWCNvcJ2bcWqi8TBumflAMKHn4UuVCzNbMXVW86xYg7F8RbtmKRqlMCzTHw0a1MJb
 OE7spJYYBEja0mUfdTAcIXxyHUPC46Abj6h6Pg6uo8NWM+uImOzkKM/Y7vh9g9kADLpp
 61qw==
X-Gm-Message-State: AOJu0Yy6nV2tNwbaAOFx/FDEJHa5qlWFztWyOZ7ZC+M2hoxGSzUtJHtP
 lVt/hJPNxTEfGmakiM7+y6Ei7FbPdcBzA8sUxslCEC64EzRMx5VWFgSoDeGJmeVTK4N/naV9R6C
 llZ2gA3PPGdzZ74vSswDOgh2EmnCkgWpzAJyduA==
X-Google-Smtp-Source: AGHT+IEelUSH+L5UIOfA8cqvIiSsgFhFMGqv12aG+YnINtklmJfeFsUy1u5A/LpwNyd+Lm3tV139IdXrEDpE1orZr/Y=
X-Received: by 2002:aa7:c3c5:0:b0:574:ea61:3b00 with SMTP id
 4fb4d7f45d1cf-5752b4554a9mr6086427a12.8.1716212622776; Mon, 20 May 2024
 06:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240507130349.86851-1-sebastian.huber@embedded-brains.de>
 <20240507130349.86851-2-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240507130349.86851-2-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 14:43:30 +0100
Message-ID: <CAFEAcA9VQZ-EinEiaTp1_tu4Xb7E4tN4rprJu40uumVUfTiLpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/xilinx_zynq: Add cache controller
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 7 May 2024 at 14:04, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> The Zynq 7000 SoCs contain a CoreLink L2C-310 cache controller.  Add the
> corresponding Qemu device to the xilinx-zynq-a9 machine.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>  hw/arm/xilinx_zynq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 3190cc0b8d..078abd77bd 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -242,6 +242,7 @@ static void zynq_init(MachineState *machine)
>      busdev = SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
> +    sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
>      sysbus_connect_irq(busdev, 0,
>                         qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));

If we add the cache controller to this board we also need to
update the board's entry in hw/arm/Kconfig to add a
"select PL310" line. This ensures that if the user asks
to build the zynq board type then we will also compile in
the PL310 device.

thanks
-- PMM

