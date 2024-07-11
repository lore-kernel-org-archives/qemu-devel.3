Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E94C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsSa-0002g6-8C; Thu, 11 Jul 2024 07:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRsSV-0002QU-BS
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:59:35 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRsST-0006gG-KH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:59:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so1326018a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720699172; x=1721303972; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=werTonj7QNq+ua51haeygUPcm9W0ZEoCpESBneEXr5U=;
 b=WNuuDr5OkPIHAaZVLm/sMZi3/uQaKWdice1VR6ALAZ58QjOc/4FSlnl9nWJZl0K9q1
 RpH4L+HIgrQkRq/drzkzak6dUwIg7aGNp6ZIL++XE5VdwIAHXzk0mQ9rWSwiUqS7dD+C
 TW5XcuFUAhNUbI8FlTFokITGhkHhjMYW2kWRy/APALxzcpJCEtRBXmaFeE2o9n6vlU+c
 j6mmatyuCYjgPfar10+2XVNH4hCF1SmPE2MLjImxarCgAdVrG91LP/jnQonr5Ydx46N1
 0un0Bahtg73UcJD6JNaxsEYRxgfk+F7J3gmQReZZgIO4YShxd9W60IZ4niFWQ8WJEwwT
 25tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720699172; x=1721303972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=werTonj7QNq+ua51haeygUPcm9W0ZEoCpESBneEXr5U=;
 b=oopXL08+VJ+dwuXikdUqQoYQJS45AS7zRTCHBJeKm/hxMYGkmyPQeHtfi8ujR+RzeG
 MI3Hq3ViJmT7RyD84ZaIdq4xcdJhB9TfAODZ+cPlecSpUZmJKjF8aCKjG8Fu372bIKX6
 XXxxe6eWquuuty0zCkqmko37lsh6DNYJdrReic9lFTgXtwUcmA58yayQx4qvQvevfIlS
 FxHvSNvrD1jrJs+96tZ14Pm4cksDPwVOMPhfn5+rcf9OPiCwxHygozGf/mNLsx4pf+9e
 hYT2KCgS5mc+JBVz0zJjL7KHz+XB+7iMplPO0Wi8N+rPpJPMxlXRqPgEGZnBoJ4XDETO
 dnvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6GPw6f1WwYuPR5UgKaguMxaFFjHdTJFpFcMwHsKi+W2NXhqjOwrVVTIjgbmQ3Kk9Qr4MxT1IwCRlpu6z0cmGCl2K0gq4=
X-Gm-Message-State: AOJu0YzHFXyH3teqWhbzvFZUuaem2MINml9RxvC9al58GcijVXw44d/7
 8+cE6Dk448sT6Y6NP0MjQhgvkapsjfwa9pM4iEQort/qP997VHQx+Xl/d/KcANZg9Y02Lfv7QN9
 IdB1DvuX41D+ugufwZWABHtb2xbwihIkgrNkdHQ==
X-Google-Smtp-Source: AGHT+IHoRn575wSFRpHdhPoGsIQtDx3qlYWl74xlQ60nrZPI28oD6g5R4UE+O1SA6Aq4WQmMbZWG2mYCINhvt4c3a7o=
X-Received: by 2002:a05:6402:2813:b0:57c:603a:6b2b with SMTP id
 4fb4d7f45d1cf-5980e547f6amr1736371a12.21.1720699171546; Thu, 11 Jul 2024
 04:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720690278.git.mchehab+huawei@kernel.org>
 <b9cd4a65d3389102def662a8bc09ffaa622265f7.1720690278.git.mchehab+huawei@kernel.org>
 <20240711075332-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240711075332-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2024 12:59:20 +0100
Message-ID: <CAFEAcA-PYnZ-32MRX+PgvzhnoAV80zBKMYg61j2f=oHaGfwSsg@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm/virt: Wire up GPIO error source for ACPI / GHES
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 linux-edac@kernel.org, 
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 11 Jul 2024 at 12:54, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 11, 2024 at 11:52:03AM +0200, Mauro Carvalho Chehab wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Creates a GED - Generic Event Device and set a GPIO to
> > be used or error injection.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++----
> >  hw/arm/virt.c            | 12 +++++++++++-
> >  include/hw/boards.h      |  1 +
> >  3 files changed, 37 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index e10cad86dd73..b6f2e55014a2 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -63,6 +63,7 @@
> >
> >  #define ARM_SPI_BASE 32
> >
> > +#define ACPI_GENERIC_EVENT_DEVICE "GEDD"
> >  #define ACPI_BUILD_TABLE_SIZE             0x20000
> >
> >  static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
> > @@ -155,9 +156,14 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
> >
> >      Aml *aei = aml_resource_template();
> >      /* Pin 3 for power button */
> > -    const uint32_t pin_list[1] = {3};
> > +    uint32_t pin = 3;
> >      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> > -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> > +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
> > +                                 "GPO0", NULL, 0));
> > +    pin = 6;
> > +    /* Pin 8 for generic error */
>
> For real? Code says 6, comment says 8.
>
> Comments must come before the code they comment, not after it,
> then this kind of thing won't happen.

It might also be nice to have a symbolic constant for the
pin number somewhere, so we don't rely on the magic number here and...

> > @@ -1014,6 +1021,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
> >  {
> >      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> >                                          qdev_get_gpio_in(pl061_dev, 3));
> > +    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> > +                                          qdev_get_gpio_in(pl061_dev, 6));

...here being the same.

Then if the code says "pin = VIRT_GPIO_ERROR_PIN" or something
similar the comment isn't required because the code is clear
without it.

(This is already a problem for the power-button pin 3, so we could
do an initial cleanup patch to sort out pin 3 first).

thanks
-- PMM

