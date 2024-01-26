Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44553C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNfC-0005l3-W5; Fri, 26 Jan 2024 09:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTNf9-0005kR-C7
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:58:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTNf7-0006gI-Qs
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706281113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cBu5tXEHpSKPBcZyoFKTgVb4Ak5Oiwza79aExSzV6TI=;
 b=DO6/tj5rp/Epn8QAtc0GsvyLP1YoHDtIojmVQmCqeh/D5tlzHD+NZviUvqMhqcRkDcje7g
 0XAZSNW/QzN+uVkP5V6aoYr4poRBPkwCF1eo7dxPVBdXoNpgWN7uJcNC5kemjDermTXyuo
 mWePy5WNAQ69wcD9FcUgP8tSeRamARg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-KskNFkM2O62PAkNrEZqM4A-1; Fri, 26 Jan 2024 09:58:30 -0500
X-MC-Unique: KskNFkM2O62PAkNrEZqM4A-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-67ef8bbfe89so14195116d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706281110; x=1706885910;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cBu5tXEHpSKPBcZyoFKTgVb4Ak5Oiwza79aExSzV6TI=;
 b=ol3ICOgDwVT0JJWkRzwfJl8FBcAsW3BnA8BUQqVJQJ9GYcNlkw/kYgpj8NKQEv/h2d
 Ai/hgzH/TwCNlMJ4U0InU+hBVlSiyAGV+KRJDC6JOoDzVMvp9HC/JOQ71FIk0H+FvAXp
 yEjEzbsdDryMNG9z9igabbncXSOD5MUHSQhYnBJZyBhcJyaNLBSVfBa7YjviskdKne6N
 IN7HtmKWN6r35cnTL1UgfbaCHdyEWNLFumaIHexafNYGLyDsT2Hv5JqzZA6j653c+qET
 G+rKh3qLBDA83vRCADx5EZ2c0mKd6Gk2zHrwSw7wv5TrMAi4e7nUTvrHdGNUivVZ0gRi
 zvnA==
X-Gm-Message-State: AOJu0YwmkZnU+eQZ+gszuLeFBBcZdjd3gUtV6P4NbUYw32K1viFk/3Tb
 l6k/t9cpLCFIrg3Y2sdfxT4fe1VoQYeFqac7QeRimDfsbyMCHeArTTaEdTPYOs8uCBd1Yo+FXoO
 uuWoPtmuUwTbexI7qDx6JfW2nWK04vK0to7azktsGhGNxPZ37HWru
X-Received: by 2002:ac8:5c8b:0:b0:42a:6d05:270f with SMTP id
 r11-20020ac85c8b000000b0042a6d05270fmr1596796qta.7.1706281110046; 
 Fri, 26 Jan 2024 06:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC5b097dKuBCTfctQRqf/DhxYhOjmvjD/wU5GbufoJj22xfErfX7LEdKO/f8kVCA7xRTkt8g==
X-Received: by 2002:ac8:5c8b:0:b0:42a:6d05:270f with SMTP id
 r11-20020ac85c8b000000b0042a6d05270fmr1596779qta.7.1706281109775; 
 Fri, 26 Jan 2024 06:58:29 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 r10-20020ac8520a000000b004298a09900bsm581120qtn.53.2024.01.26.06.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 06:58:29 -0800 (PST)
Message-ID: <4509e46a-440a-4bcd-8c7d-d527af066c66@redhat.com>
Date: Fri, 26 Jan 2024 15:58:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/46] hw/arm/allwinner: use qemu_configure_nic_device()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-22-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240108204909.564514-22-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 08/01/2024 21.26, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/arm/allwinner-a10.c |  6 +-----
>   hw/arm/allwinner-h3.c  |  6 +-----
>   hw/arm/allwinner-r40.c | 27 ++-------------------------
>   3 files changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index b0ea3f7f66..57f52871ec 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -142,11 +142,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
>       sysbus_realize(SYS_BUS_DEVICE(&s->dramc), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0, AW_A10_DRAMC_BASE);
>   
> -    /* FIXME use qdev NIC properties instead of nd_table[] */
> -    if (nd_table[0].used) {
> -        qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
> -        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> -    }
> +    qemu_configure_nic_device(DEVICE(&s->emac), true, NULL);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), errp)) {
>           return;
>       }
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index f05afddf7e..4f102ad082 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -369,11 +369,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
>                                 "sd-bus");
>   
>       /* EMAC */
> -    /* FIXME use qdev NIC properties instead of nd_table[] */
> -    if (nd_table[0].used) {
> -        qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
> -        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> -    }
> +    qemu_configure_nic_device(DEVICE(&s->emac), true, NULL);
>       object_property_set_link(OBJECT(&s->emac), "dma-memory",
>                                OBJECT(get_system_memory()), &error_fatal);
>       sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
> diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
> index a0d367c60d..4d5661b014 100644
> --- a/hw/arm/allwinner-r40.c
> +++ b/hw/arm/allwinner-r40.c
> @@ -294,7 +294,6 @@ static void allwinner_r40_init(Object *obj)
>   
>   static void allwinner_r40_realize(DeviceState *dev, Error **errp)
>   {
> -    const char *r40_nic_models[] = { "gmac", "emac", NULL };
>       AwR40State *s = AW_R40(dev);
>   
>       /* CPUs */
> @@ -454,31 +453,8 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
>                       s->memmap[AW_R40_DEV_DRAMPHY]);
>   
> -    /* nic support gmac and emac */
> -    for (int i = 0; i < ARRAY_SIZE(r40_nic_models) - 1; i++) {
> -        NICInfo *nic = &nd_table[i];
> -
> -        if (!nic->used) {
> -            continue;
> -        }
> -        if (qemu_show_nic_models(nic->model, r40_nic_models)) {
> -            exit(0);
> -        }
> -
> -        switch (qemu_find_nic_model(nic, r40_nic_models, r40_nic_models[0])) {
> -        case 0: /* gmac */
> -            qdev_set_nic_properties(DEVICE(&s->gmac), nic);
> -            break;
> -        case 1: /* emac */
> -            qdev_set_nic_properties(DEVICE(&s->emac), nic);
> -            break;
> -        default:
> -            exit(1);
> -            break;
> -        }
> -    }
> -
>       /* GMAC */
> +    qemu_configure_nic_device(DEVICE(&s->gmac), true, "gmac");
>       object_property_set_link(OBJECT(&s->gmac), "dma-memory",
>                                        OBJECT(get_system_memory()), &error_fatal);
>       sysbus_realize(SYS_BUS_DEVICE(&s->gmac), &error_fatal);
> @@ -487,6 +463,7 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
>                          qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_GMAC));
>   
>       /* EMAC */
> +    qemu_configure_nic_device(DEVICE(&s->emac), true, "emac");
>       sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_R40_DEV_EMAC]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,

Reviewed-by: Thomas Huth <thuth@redhat.com>


