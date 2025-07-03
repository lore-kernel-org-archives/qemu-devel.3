Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C36BC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMi2-0007Kt-Tv; Thu, 03 Jul 2025 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMi0-0007Fa-TN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:22:48 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMhw-0006K8-5B
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:22:47 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-711a3dda147so89326117b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559762; x=1752164562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VZOJlHPxMG0XgAd88gcBG7lA9V7NEZI4RP5wm+CcUEM=;
 b=nqFYgf4QSkkcHAc/f/4vZRkmnW7kLT1MUsRYW502tEv61y0FukE0VINNPW2PNZyYZX
 GiFZ15cf2DsrgR+IIRVDPcGKhAg3iSDOYuDYORGvbRln4yDi2GQoap92u0f91XdRoEx7
 EkdE53l6IotkFkgAq8YmfP2zYxQHlCFhtmy9DzE4qWdbE2asPWUvbJ4n4+eAdML/QO+Y
 9y2UTL4CESLu5oOP3LU6C0foskpyZjQj2c38z05KvRi+JLG07Nitli/J9xafqQUK5Pe9
 E9TxC2diFyBC39XHZvzBqTNoZ4L89sNJIBzKVQjY54flaQHi4pWabQEC6bBMbOtYWYZZ
 3Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559762; x=1752164562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZOJlHPxMG0XgAd88gcBG7lA9V7NEZI4RP5wm+CcUEM=;
 b=wAJDgGXBC8zG2aYXILBpv58BeBmK0o50ApEILTmExPNSXi3pB3Zunj16hVg/fybLBh
 CiyL7sSfv+AW19nENUOlXTQizSq+DyNe4aAVH774JgGS6ztWCFIi0cgiZn7OVosWwlvR
 ciihCwl1JrsWzq4VTM4c5GMjv7B+PFtwjvozgrVHjAMCntTeNgk9z5vjTbVMWDBOrMaS
 vdHu70RL9i6SOjeI/cmGE4YUoZ8x+SIqRWQ5VoBDikrO1/8CoG6rqpKgEYYePbhQSAhh
 ZJVgRzCpbmmvoidp2mpwHK+FAsi1/kFaCw132FT5oRtbyIIFOXlC8mzsW5hyYB54S4eR
 2Hqg==
X-Gm-Message-State: AOJu0YxzjK2iSOXQ9yCWkt11OuojtrpeaS7Z+n/Jl13ayaT0wkNWEM1W
 8B6fl1vKb4xZUe8rR5Q8JNt+CezOKiAm7dtfBXWqfmBjccqQZ8k5hz5fkHY3qJvkl14o+AnGFF3
 BjlQ6AZ6I7D35pYKUQtzoBzkidaasavWgAqgi+m9JayF4ru9ReSjN
X-Gm-Gg: ASbGncsFV2BYHJ6fMLjrlSvtG26j4kmYry54gonmv3g8S4uNuhaVeFtfkGuIEKohBw+
 vH7LPbTiL2ZES3r/2vSC4l300VVvfO7xVNliuJRDE6sWN6wkxP8TRRTkoeFS/90kOuX1rX0ACkI
 sTp8R5zo6b2z+fxaE6TFe/Kmd9ewY/F4l565t3RN8hax0y4k3+NjTrCds=
X-Google-Smtp-Source: AGHT+IFLlYIPOJZJghbq5znRpOdQt728aK5B4DhcNbaQDEn3VIcY6wtSZ0gC2o17rdHa84yaEUIwyhMP3PQtrZcU3vA=
X-Received: by 2002:a05:690c:5:b0:716:3dc5:a35f with SMTP id
 00721157ae682-7164d4d84f7mr113153587b3.19.1751559762312; Thu, 03 Jul 2025
 09:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-10-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-10-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:22:30 +0100
X-Gm-Features: Ac12FXznU-Afd1OvROeAxH5JlAmZZYy3GZQReiM2LdCB1AsUrrbnsQKj5SHsjvM
Message-ID: <CAFEAcA-xYMRaZCBXqUGxW1GFUNZLF=DVSARat=HTOv3VruJU+w@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] MAX78000: Add TRNG to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds TRNG to max78000_soc
>
> Signed-off-by: Jackson Donaldson
> ---
>  hw/arm/max78000_soc.c         | 10 +++++++++-
>  include/hw/arm/max78000_soc.h |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 1a36bba2fc..09667b578c 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -41,6 +41,8 @@ static void max78000_soc_initfn(Object *obj)
>                                  TYPE_MAX78000_UART);
>      }
>
> +    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>  }
>
> @@ -124,6 +126,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>                                                         max78000_uart_irq[i]));
>      }
>
> +    dev = DEVICE(&s->trng);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
> +    dev->id = g_strdup("trng");
> +    object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);

As with the uarts, don't touch dev->id here.

thanks
-- PMM

