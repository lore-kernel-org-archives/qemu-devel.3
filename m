Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB33C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 07:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhFD-0003rR-1L; Tue, 30 Jul 2024 03:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYhFA-0003iX-QU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYhF7-0002H7-Se
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722324356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5xEK7R2nb157eewENV4C21/1t6bjW/YfM6JPF2QG74=;
 b=TenxjCj4LK4KXkHxIQJRo7r3D63twf9Ck25/3iX/7OwssuzvU1yratDwa6+3aNpMFi6OoD
 k9R0r3IqAKqAUAXAqVusUJi6uA86Sjg0BGYaBodY5Rf0H+diNQXSM0lJSqdc2JWr0/aU/W
 6mOI563U2c9EAG5Qi6YZQT0KRViILKY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-9EOyMflyM32YyfbsNycz3g-1; Tue, 30 Jul 2024 03:25:52 -0400
X-MC-Unique: 9EOyMflyM32YyfbsNycz3g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42816096cb8so31234995e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 00:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722324351; x=1722929151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5xEK7R2nb157eewENV4C21/1t6bjW/YfM6JPF2QG74=;
 b=NjHTJ4OuAOdlH40/vm62MxBc66VG6yfNjYIisYAtwvkXIM+Uw6mvRz5mDA93Be/xOh
 4zYyy35ifFJCO0Q6Y0gpwDuszcM91lQh1dcr3Kan9KifrIfgNbF3OkQAzruY1BjtJCsk
 nLRfT5OARkLZJ2JMxbuy+SwXssilCBYZvshJcmIihhEj0eezVw+ByCAZ06X+DtIoE4+c
 FA4DTv/mOlHHDDq21RXFFobqG2TY9pwDZ7ubmcGrdHhVkqQ4x7+tPlmjr3A2v+qboOSX
 j9vyso744FooTqMAm2QZW9BBegd40gzuSbwQYywwntFYHxybN627/YFwHXu/jxcEThAp
 T3tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJCc2IoZAyjGqdS+hagOW7euN/lD+XtmTd+rfptZdz/5iXr/JugYsoiKQQsUJSiAioZ4EivLM0D4c1iYhzN6lgd8lpuE4=
X-Gm-Message-State: AOJu0YxPo9crUCJTznTgSD50zM1ux1CPPVbkJAYoCfaIktAA/p3xQUpV
 w6E40CkKJF58/dwOoSZHdHM4Wjnq9AH+o/OFtZoEM8xUr+0w0QInyDzcG2yeoejdE2HFbBvmZf+
 IfY8mklBGP2YuIDuGqOevRR0hpy2Sn7KpVGGvf6i+SBkI/V41hoAW
X-Received: by 2002:a05:600c:4585:b0:426:61fc:fc1a with SMTP id
 5b1f17b1804b1-42811d7792bmr90856385e9.3.1722324351582; 
 Tue, 30 Jul 2024 00:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/gDWBFo6htQDYTEcS5D2SAcLjd2SmqORuGhu3ZlxQ75NycjD7PqRFbIHMJtcxRFp9bn/8wQ==
X-Received: by 2002:a05:600c:4585:b0:426:61fc:fc1a with SMTP id
 5b1f17b1804b1-42811d7792bmr90856125e9.3.1722324351142; 
 Tue, 30 Jul 2024 00:25:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281225141dsm120696385e9.45.2024.07.30.00.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 00:25:50 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:25:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a define
Message-ID: <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
In-Reply-To: <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 22 Jul 2024 08:45:53 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> index b0c68d66a345..c99c8b1713c6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      if (s->acpi_dev) {
>          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
>      } else {
> -        /* use gpio Pin 3 for power button event */
> +        /* use gpio Pin for power button event */
>          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);

/me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
you are passing 3. Is this a bug?

BTW: dropping '3' from comment doesn't make it any better.

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


