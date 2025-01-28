Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AD1C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 22:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcttC-0004EJ-HF; Tue, 28 Jan 2025 17:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tctt8-0004Dn-S6; Tue, 28 Jan 2025 17:16:55 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tctt4-0005x2-53; Tue, 28 Jan 2025 17:16:54 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab633d9582aso1118643466b.1; 
 Tue, 28 Jan 2025 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738102608; x=1738707408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvtrgTFdcm4s6M4/zlLrRfuc5/7W/p7yRQ/tLkEcAuc=;
 b=ZhwNdricJOoAJwV2nIkggPONP44bDSiiIWFJrT621Byt6VRVea8PwJJf9/tl8uIjf1
 TXnZOOqiKxhgNkXaNOP2d/LuZg4UfbS9tFFDlsbBstxLL3PvgO+ljS6qYLZ/3mDOInZ9
 G29qtzwhsTBAzX4sA6WpDQHSmEKihSGfMDqWW1nB/cJ9tT/DCgLHxjfCbsnj6XX8QZLm
 txaqpzV4hSj5Sz0D8FcraNl+rK2eWsAFqGalJlzlTe8HX9DUF56SvJBbyFtgVP91hJmu
 5PT0UH78GX3yDcfUO5c8VN69QU87IT/yQFwoocn9/QYIemO0H2L4TZa2cNFQjiSbSD6d
 ATvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738102608; x=1738707408;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvtrgTFdcm4s6M4/zlLrRfuc5/7W/p7yRQ/tLkEcAuc=;
 b=C4oAO90IRxXOya5lgsvJXVWC7+q7Zr6VN+9V9ZBHwB/UuQfSkzOIgwqH591tVnvppQ
 qL+G6jLXhvlwv5NNZC4VsjE4akHFZJxRjIgpIx/e3VJWmHfZX6TR4ZHAAMYRpKkE0jx/
 UU8AVWr82lY9EeDPqbWQvKrHytlTfnlyWi5KuIXZ11JQdIuu2Dw3W+87yNNTH6U+kO/n
 L9F3QDIYFLxH2Os4Nk3IeSfV2fxBggOq/HCBxHYTk+Q1Gbcv9w8IvDcOg26pzeSG4l8w
 49IKyQ/G8Sg77d4aukc/pgeeJHwsb9wE3WE3vo/Y+CysS3HNTj4bt5twHy/4tWzebexC
 5n/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZyF1+GFJ2+rwQ56FOPN0/50QCBL7f+P9TBDV6MgeSUOMxWIUSZIJAfzafLQjq6wivgL4WIEoOrw==@nongnu.org
X-Gm-Message-State: AOJu0YwQPW3EVJ4lBZfA4l3RJexrqJStpuoVhQzbBd3FTZIKZMgjpCmL
 doJQlnEhDkshuwZASW9hZpiaBqxO74Q80MVelbCirRwnV3w2ZP2f
X-Gm-Gg: ASbGncvULfDVt2k8Px3L5qbAwQ+fcQxbRGHCU7DSfMyalCrlcaWnV8vh6wdft9Wh69U
 RoVJqd/DT1CbDCzPNS+VIDc72QCJUrBYML6ajY2KQSTzXH70TnY6/G/s2bUMHTnvKtWNd5dDHAS
 5V+cRrutHsKnjxCEGjeUzTBvBWE7P0+j2rjhbdE22ECnAA/NkvtKb0w63+8K5pljd9aq3Ss3rS0
 t6Zjb3r6Lre9Cw5kgfJMqQXACgvsNBVelKjCsOolj8ocPlVG24LFPtbqJljQql4hAQsRkdHW9im
 7aV0xxsOach5kscM/dXy9t8sp9iFr04Fyo1iveoXwyLAEhGS0oArfwXtHkXpwE6A
X-Google-Smtp-Source: AGHT+IFXQn1n/5K0jCyGstT+voGs9WZfm5sMGnvF5YTcqcjCyOeVkztxHswYsv1RsSX48l4pCx9A6g==
X-Received: by 2002:a17:907:97d1:b0:aa6:ac9b:681f with SMTP id
 a640c23a62f3a-ab6cfda421fmr64703066b.43.1738102607392; 
 Tue, 28 Jan 2025 14:16:47 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-042-254.89.12.pool.telefonica.de.
 [89.12.42.254]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab675e12090sm853831766b.29.2025.01.28.14.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 14:16:47 -0800 (PST)
Date: Tue, 28 Jan 2025 22:16:46 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 05/21] hw/arm: Add i.MX 8M Plus EVK board
In-Reply-To: <CAFEAcA_NBPqbOrVJw=bDC6=dTGKBKe42XoXMm82jj7+pHEvW3Q@mail.gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-6-shentey@gmail.com>
 <CAFEAcA_NBPqbOrVJw=bDC6=dTGKBKe42XoXMm82jj7+pHEvW3Q@mail.gmail.com>
Message-ID: <4EC5E99E-804A-4154-8D61-22D1358C0F6B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 28=2E Januar 2025 14:29:53 UTC schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> As a first step, implement the bare minimum: CPUs, RAM, interrupt contr=
oller,
>> serial=2E All other devices of the A53 memory map are represented as
>> TYPE_UNIMPLEMENTED_DEVICE, i=2Ee=2E the whole memory map is provided=2E=
 This allows
>> for running Linux without it crashing due to invalid memory accesses=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  MAINTAINERS                    |   9 +
>>  docs/system/arm/imx8mp-evk=2Erst |  47 +++++
>>  docs/system/target-arm=2Erst     |   1 +
>>  include/hw/arm/fsl-imx8mp=2Eh    | 189 +++++++++++++++++
>>  hw/arm/fsl-imx8mp=2Ec            | 371 +++++++++++++++++++++++++++++++=
++
>>  hw/arm/imx8mp-evk=2Ec            |  55 +++++
>>  hw/arm/Kconfig                 |  13 ++
>>  hw/arm/meson=2Ebuild             |   2 +
>>  8 files changed, 687 insertions(+)
>>  create mode 100644 docs/system/arm/imx8mp-evk=2Erst
>>  create mode 100644 include/hw/arm/fsl-imx8mp=2Eh
>>  create mode 100644 hw/arm/fsl-imx8mp=2Ec
>>  create mode 100644 hw/arm/imx8mp-evk=2Ec
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 846b81e3ec=2E=2Ecace8cf25b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -819,6 +819,15 @@ F: hw/pci-host/designware=2Ec
>>  F: include/hw/pci-host/designware=2Eh
>>  F: docs/system/arm/mcimx7d-sabre=2Erst
>>
>> +MCIMX8MP-EVK / i=2EMX8MP
>> +M: Bernhard Beschow <shentey@gmail=2Ecom>
>> +L: qemu-arm@nongnu=2Eorg
>> +S: Odd Fixes
>
>I'd rather we didn't take on a new board model that
>starts out in the "odd fixes" state=2E If you don't
>have enough time to look after it, it seems unlikely
>that anybody else is going to want to take it over=2E

I'd look after it, but I'd also not raise expectations regarding commercia=
l grade support=2E What state would you suggest?

>
>> +F: hw/arm/imx8mp-evk=2Ec
>> +F: hw/arm/fsl-imx8mp=2Ec
>> +F: include/hw/arm/fsl-imx8mp=2Eh
>> +F: docs/system/arm/imx8mp-evk=2Erst
>> +
>>  MPS2 / MPS3
>>  M: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>>  L: qemu-arm@nongnu=2Eorg
>
>> +static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>> +{
>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    FslImx8mpState *s =3D FSL_IMX8MP(dev);
>> +    DeviceState *gicdev =3D DEVICE(&s->gic);
>> +    int i;
>> +
>> +    if (ms->smp=2Ecpus > FSL_IMX8MP_NUM_CPUS) {
>> +        error_setg(errp, "%s: Only %d CPUs are supported (%d requested=
)",
>> +                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp=2Ecpu=
s);
>> +        return;
>> +    }
>> +
>> +    /* CPUs */
>> +    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>> +        /* On uniprocessor, the CBAR is set to 0 */
>> +        if (ms->smp=2Ecpus > 1) {
>> +            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>> +                                    fsl_imx8mp_memmap[FSL_IMX8MP_GIC_D=
IST]=2Eaddr,
>> +                                    &error_abort);
>> +        }
>> +
>> +        /*
>> +         * Magic value form Linux output: "arch_timer: cp15 timer(s) r=
unning at
>> +         * 8=2E00MHz (phys)"=2E
>
>"from"

Will fix=2E

>
>> +         */
>> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>> +                                &error_abort);
>> +
>> +        if (i) {
>> +            /*
>> +             * Secondary CPUs start in powered-down state (and can be
>> +             * powered up via the SRC system reset controller)
>> +             */
>> +            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powere=
d-off",
>> +                                     true, &error_abort);
>> +        }
>> +
>> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index fe47e259b8=2E=2Eadb4ed8076 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -577,6 +577,19 @@ config FSL_IMX7
>>      select SDHCI
>>      select UNIMP
>>
>> +config FSL_IMX8MP
>> +    bool
>> +    imply TEST_DEVICES
>
>Why do we need TEST_DEVICES ?

Copied from FSL_IMX7=2E Will drop=2E

>
>> +    select ARM_GIC
>> +    select IMX
>> +    select UNIMP
>> +
>> +config FSL_IMX8MP_EVK
>> +    bool
>> +    default y
>> +    depends on TCG && AARCH64
>> +    select FSL_IMX8MP
>> +
>>  config ARM_SMMUV3
>>      bool
>
>Looks good otherwise=2E

Thanks,
Bernhard

>
>thanks
>-- PMM

