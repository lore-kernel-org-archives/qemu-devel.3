Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7586C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkDv-0005L2-QJ; Fri, 04 Jul 2025 13:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkDs-0005GR-VD
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:29:17 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkDr-0006FO-FH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:29:16 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e81749142b3so1034214276.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751650154; x=1752254954; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nMkIAivR8A07/e7hTxG37AHAXq+zZDKU4zZIBDChe5k=;
 b=L65wCWWq/YbAHikNdR55tvG691PJPhtBgQ8T/sDyuEyzOaRxpXamYBJV+9+LDViuJg
 TxDw9BV5G7GgNYCPZXNt0YyQVAUHtjva45LzNj7cz/dZhqUu+w4uvXfaTTX2siQ538M0
 4M3Xn1IaTbLg+jx5fyilfVp3J/PUtnI3IhAWTQXXEeXBopmqEegliesJ5sbfPThbd0nx
 52JgQ5St46Fb1hMRUUbFnW5CQEczTXk19Df1UgC+78OKqvJNYLNseddRKlsPgf9succr
 XzlRiDRpFM1QFpU1JjKIKwlEXE//0YF4caoWpc7hQ2JEZ2bUEKWa/V1Lhv+T7/38kkTl
 p/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751650154; x=1752254954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nMkIAivR8A07/e7hTxG37AHAXq+zZDKU4zZIBDChe5k=;
 b=plnn2jO3F4mtLYBfvTQ5FCRjID598EYVzVqXZ+4+L6iHdNWjeg8JklNat3A8FHx8Su
 miqw3Xw59xt6KftzXAsnqYyX2vJtNynShaDaCwGS3RkxU/FqlqLLkfHj+uLbzrJjsN6t
 HF0CnqWsKpkmHzNsosUg3BUZJzPnvpE1rJE63w25ZG4hU+yxrsN/LF2ohxLzgifXukFM
 ILIyNyLCzxBVEwXSixpxgsJNSAPHX//i0yGDmCBtFcS4pBUspSZEKwQdGtjZ32EZrzOo
 kFMcZBjSCcev69B/73p9pd8eznbF1a0lpX0RvYt03++fJzBjAktz0ya5u8Zbfd9t/9cs
 pg5g==
X-Gm-Message-State: AOJu0YxFNL4YFNJMjHdSkgVx/8FsMjScOpm/IKsP4WtNqjjkaGphRnof
 4X0wgWlhToWQZSMJhZrBIlW6krcCCy52sjQzpQuB6Sc58IInkQIY3rHwjRE3TzR/VCPbyf9LYQX
 eXYLKs7qnOz/Fm7sAYezSx0aNECL+n+uJQP8PMF7uEQ==
X-Gm-Gg: ASbGncv6K9NnxpyifE1WRLO4OgG6Sm7zrQqvaC6cCPG2G3ideNJlscvlRgQuNcATG09
 5einFVcfu2py80yRv4GHg2AxXD+4cpF6uXk3PMY3XuqNZEyuiV1KYZCU2/erd+pzbrvJjXa0LoY
 19d17iFlhPsX0H4HzZy1r2wl5NJ9ESgKmZ72GAHpu4LMIv
X-Google-Smtp-Source: AGHT+IGHtqW6rrvCNMjn47rqMvL1xEzjMI9IORZBxCJ6Gdql937wszCv2Ih4iXVyZjHdRna2c3KmuLu0HQdrvLHzX40=
X-Received: by 2002:a05:690c:4989:b0:70c:9364:2c62 with SMTP id
 00721157ae682-71668d5b732mr46235807b3.25.1751650154352; Fri, 04 Jul 2025
 10:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250704165729.208381-1-jcksn@duck.com>
 <20250704165729.208381-12-jcksn@duck.com>
In-Reply-To: <20250704165729.208381-12-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 18:29:02 +0100
X-Gm-Features: Ac12FXwLOinZUAmv9ooylTV6km-QV2FTo9MZYDFjEPszhZwkrS-Hw09fccRpam4
Message-ID: <CAFEAcA9B914uJELAAggfqKYCFHku3CPac97FHHR05_QHVs_VFw@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] MAX78000: Add AES to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 4 Jul 2025 at 17:57, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds AES to max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/max78000_soc.c         | 14 +++++++++++---
>  include/hw/arm/max78000_soc.h |  2 ++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 074fb1da8b..39ae4e0396 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -45,6 +45,8 @@ static void max78000_soc_initfn(Object *obj)
>
>      object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
>
> +    object_initialize_child(obj, "aes", &s->aes, TYPE_MAX78000_AES);
> +
>      s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>  }
>
> @@ -54,6 +56,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      MemoryRegion *system_memory = get_system_memory();
>      DeviceState *dev, *gcrdev, *armv7m;
>      g_autofree char *trng_link = NULL;
> +    g_autofree char *aes_link = NULL;
>      SysBusDevice *busdev;
>      Error *err = NULL;
>      int i;
> @@ -137,6 +140,14 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>      trng_link = g_strdup("trng");
>      object_property_set_link(OBJECT(gcrdev), trng_link, OBJECT(dev), &err);
>
> +    dev = DEVICE(&s->aes);
> +    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40007400);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 5));
> +
> +    aes_link = g_strdup("aes");
> +    object_property_set_link(OBJECT(gcrdev), aes_link, OBJECT(dev), &err);

Here again you can just pass "aes" as a direct argument.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

