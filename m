Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1909C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNkU-00016Z-5U; Fri, 26 Jan 2024 10:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTNkR-00015a-TV
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTNkP-0008De-PY
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706281440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KQqM4d2OnomnUxb6KTJuQsFHZEeo84Y4P4Rfq+HD90I=;
 b=Wzi7dz+GRDwl8Wvut82aD0jgj0svCj7kZ+WZIRnzIGF7BI2iWkK63A+KuO4C0QjTpGbmeR
 4Io97XPry1fYgFhvYMsJ8vlGdRzH744B4YgkeFs8gW75ngJ1AhoB4fE1wl/BSzMDyYs5aD
 rvw+a3fcF7ZlP7I36ufchr042zE0ZkI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437--VFU2d5vPPiqCWHuT1GkSw-1; Fri, 26 Jan 2024 10:03:58 -0500
X-MC-Unique: -VFU2d5vPPiqCWHuT1GkSw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-680139b1990so13177026d6.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706281437; x=1706886237;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQqM4d2OnomnUxb6KTJuQsFHZEeo84Y4P4Rfq+HD90I=;
 b=XuVHH0W/nv7uMS5xx4cELREsy/HwPkhTy4sfihiaL6PbHMh7mjQBf0Ydu10EEr/Wnv
 nfX/lwQknI7ytG2QUdC6vWZe3AfRySPbCsqgsD76GUIRUS+AHPUpOz6Ivn0k3dZAQncL
 gHz36ZNWDKPNn23iNFbiYhRkjqcOi0BYeZ7eGqrgth8THz/z3tRXrJhgkVOt4Uy1zRFz
 lKhwF1qdeej1RKygVBvEljfuxAb9Cp1jTiYe3cMvjralZwyZ18+y2BbXSSqRXizpNYwR
 tFWgd+DAYp0cz63BWG+j76XL9O5N60gBtwr8XrRwSWN9N5M69us62D0LGyH7btQyFRNh
 sl9Q==
X-Gm-Message-State: AOJu0YwdYDNyWnYzOa0mhN08Kvme7eIbRdhANOQvZIRjE4Vz7Wwf+MJS
 sjy3GSR6I+GaYQCzfit3Dk8IQOg/QRumy7JSn2wiWEpPT0EXp6wVaIRrQD8v3CE0GGcdXr9Is9Z
 6LXLlXISsjKppfo4kosfwegGvW3iKMpJLRnoEfyTKAoSJXZIaB8ey
X-Received: by 2002:ad4:5ca8:0:b0:686:ae74:ae2f with SMTP id
 q8-20020ad45ca8000000b00686ae74ae2fmr1650320qvh.92.1706281437560; 
 Fri, 26 Jan 2024 07:03:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlDnoaSkmDdqflr//ologr4NxBixnunpbBUG7PQIfQkbQZPakwu5o7KULp4EAfPHmp/262vg==
X-Received: by 2002:ad4:5ca8:0:b0:686:ae74:ae2f with SMTP id
 q8-20020ad45ca8000000b00686ae74ae2fmr1650309qvh.92.1706281437313; 
 Fri, 26 Jan 2024 07:03:57 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 ol9-20020a0562143d0900b006817d42eac6sm576258qvb.53.2024.01.26.07.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 07:03:56 -0800 (PST)
Message-ID: <fd570ec7-68c0-4f7e-a17e-ac5825c805ff@redhat.com>
Date: Fri, 26 Jan 2024 16:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/46] hw/arm/fsl: use qemu_configure_nic_device()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-25-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240108204909.564514-25-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
>   hw/arm/fsl-imx25.c  | 2 +-
>   hw/arm/fsl-imx6.c   | 2 +-
>   hw/arm/fsl-imx6ul.c | 2 +-
>   hw/arm/fsl-imx7.c   | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 9d2fb75a68..a24fa7b443 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -170,7 +170,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>   
>       object_property_set_uint(OBJECT(&s->fec), "phy-num", s->phy_num,
>                                &error_abort);
> -    qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
> +    qemu_configure_nic_device(DEVICE(&s->fec), true, NULL);
>   
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), errp)) {
>           return;
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index b2153022c0..02f3024090 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -380,7 +380,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>   
>       object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
>                                &error_abort);
> -    qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
> +    qemu_configure_nic_device(DEVICE(&s->eth), true, NULL);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), errp)) {
>           return;
>       }
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index e37b69a5e1..ca3dd439ec 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -442,7 +442,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>                                    s->phy_num[i], &error_abort);
>           object_property_set_uint(OBJECT(&s->eth[i]), "tx-ring-num",
>                                    FSL_IMX6UL_ETH_NUM_TX_RINGS, &error_abort);
> -        qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
> +        qemu_configure_nic_device(DEVICE(&s->eth[i]), true, NULL);
>           sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
>   
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0,
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 474cfdc87c..1acbe065db 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -446,7 +446,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>                                    s->phy_num[i], &error_abort);
>           object_property_set_uint(OBJECT(&s->eth[i]), "tx-ring-num",
>                                    FSL_IMX7_ETH_NUM_TX_RINGS, &error_abort);
> -        qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
> +        qemu_configure_nic_device(DEVICE(&s->eth[i]), true, NULL);
>           sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
>   
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0, FSL_IMX7_ENETn_ADDR[i]);

Reviewed-by: Thomas Huth <thuth@redhat.com>


