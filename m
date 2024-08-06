Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D65C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbG15-0002ud-HL; Tue, 06 Aug 2024 04:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbG14-0002sz-12
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbG12-0006Ud-GF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722934678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBJPewKe6BU0COfu0bKneZLn3oPmWdR4THfVKVsrupU=;
 b=f3RWo3lqdFKHKS9jUvQmMGe6iq76lBg1Iq5b4x2o5xeqGIaoCH0Q8O50ULsH7fQJAyhTyh
 EH4XYnlvROTdcTmk36gWA7Lc7mhMCpSAO+4oV0O2ZY6egVi9mOojf3RtE40MO2HKk1scWy
 YEk8A2P0BiecWVGxbCHAMfYdFP/9AR4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-8Y4sh7nJNHuSbCdF9SY7bA-1; Tue, 06 Aug 2024 04:57:57 -0400
X-MC-Unique: 8Y4sh7nJNHuSbCdF9SY7bA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4280e1852f3so2710815e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722934676; x=1723539476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBJPewKe6BU0COfu0bKneZLn3oPmWdR4THfVKVsrupU=;
 b=KNxCvlZTySFLjx1GnT9EBuAlA4xtZxKtAmn+ruw8KRiLIMknoe8nx9Aeh+YiuUKJa0
 lCc+az/kKZeQ9GEitqOC4GlAHqqIQjhqSmc3gSvDc8bz6oBG265NAN1qDnzY+TWIMa5W
 GNtksr7cZYjFtPVaqGu/YjgPXzEsvL4ywVRyf9F9s0WcA19qxtM9oq4Ihbpc6gV30Pko
 ZXTnd3pAuZetxJ8RInmdm31y6vmu5Xfv9QWR69bajYYIcvYGcvDMvdSyQIh82ARKjXza
 KvbXzlXaGxcsif09RPPQK1IL9y2XTZjYaQXeTMKLziJNEBLHZGoTDGH5zGrvVNSPnYc0
 7ZSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs6cBx4ZUuvQa19bsvIisc9U+NKSbHZdexoh1a7PeU2/5Vl9x0iYyaXhLUhurye5v/rDLKUn+b8ydI2qvrwr6Wsu8bDIg=
X-Gm-Message-State: AOJu0YzJiYaCPzxlUJTrEfoYJkK6BiX2yym0WoA5r+fIYs3r4tn0PMXh
 NMWM+iS9xtJDkNSx/ZCAlakTtnaHgF9xUtlcLPgFXEJnT0pv0tvM2dyxb8vHmSl6C92b4vNZPGx
 hXEWdOUlHHV+dX0NT9+p2YkCL85gUBsrak483Oizvh9r5Dy18OKrQ
X-Received: by 2002:a05:600c:3153:b0:428:1846:4f0 with SMTP id
 5b1f17b1804b1-428e6b026b1mr88241905e9.16.1722934675716; 
 Tue, 06 Aug 2024 01:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhy0J15b8IGtupJPtFKwPmRtb6BzvUMcj8sRdt0nXX8aZb/IrgFx/JYW7qKURbakSBHt5GJg==
X-Received: by 2002:a05:600c:3153:b0:428:1846:4f0 with SMTP id
 5b1f17b1804b1-428e6b026b1mr88241715e9.16.1722934675135; 
 Tue, 06 Aug 2024 01:57:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e03c4csm173264425e9.13.2024.08.06.01.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 01:57:54 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:57:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/7] arm/virt: place power button pin number on a define
Message-ID: <20240806105752.00c81877@imammedo.users.ipa.redhat.com>
In-Reply-To: <e5afbbaf2836ebe22b48c455285eccef86db966b.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <e5afbbaf2836ebe22b48c455285eccef86db966b.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri,  2 Aug 2024 23:43:56 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt-acpi-build.c | 6 +++---
>  hw/arm/virt.c            | 7 ++++---
>  include/hw/arm/virt.h    | 3 +++
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd73..f76fb117adff 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
>      Aml *aei = aml_resource_template();
> -    /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> +
> +    const uint32_t pin = GPIO_PIN_POWER_BUTTON;
>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
>      aml_append(dev, aml_name_decl("_AEI", aei));
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 719e83e6a1e7..687fe0bb8bc9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      if (s->acpi_dev) {
>          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
>      } else {
> -        /* use gpio Pin 3 for power button event */
> +        /* use gpio Pin for power button event */
>          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
>      }
>  }
> @@ -1013,7 +1013,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> -                                        qdev_get_gpio_in(pl061_dev, 3));
> +                                        qdev_get_gpio_in(pl061_dev,
> +                                                         GPIO_PIN_POWER_BUTTON));
>  
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
> @@ -1024,7 +1025,7 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>      qemu_fdt_setprop_cell(fdt, "/gpio-keys/poweroff", "linux,code",
>                            KEY_POWER);
>      qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
> -                           "gpios", phandle, 3, 0);
> +                           "gpios", phandle, GPIO_PIN_POWER_BUTTON, 0);
>  }
>  
>  #define SECURE_GPIO_POWEROFF 0
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index ab961bb6a9b8..a4d937ed45ac 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -47,6 +47,9 @@
>  /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
>  #define PVTIME_SIZE_PER_CPU 64
>  
> +/* GPIO pins */
> +#define GPIO_PIN_POWER_BUTTON  3
> +
>  enum {
>      VIRT_FLASH,
>      VIRT_MEM,


