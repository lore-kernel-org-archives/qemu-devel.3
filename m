Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E650C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radu7-0002Aq-E8; Thu, 15 Feb 2024 10:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radu2-00027s-0m
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:43:59 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radtz-0004gj-Kp
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:43:57 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50eac018059so1419505e87.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708011834; x=1708616634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kqcA9so7cV6dWBKdATLcRDtcdH0GoOKySw+jjMyO5EA=;
 b=CcUJ0Nm6Dr3ET/RyXzNU4rx84k7Fxm0CZvdwkkvuBFREP1IDXyWzu+KWynw6zMFsUZ
 wAPNTTj6X6pMliChSUD+Gkb6m37IQVh5aTpN7zAdwKOQ0FXEz/OxXIpXwAL2QWtfHBWN
 HYL5Qh/12ErCD2acuK6HPmWYyMIJTLBOZS1GznHtb/infI2VWizGiCU6DRGgf1qD2TLd
 ADBHf3LuThRpknGSRcC7ovnSxBP6DVNqveMlcxjObNwZr6IeZK+zZ6w/pGETYTMMu4s/
 wvYo6LtZObm7ahMHgoKQYBVhtKJPGRC/UbUNGUzCANY8wUmjtJMaLRBOeO0rIvOpfybN
 drlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708011834; x=1708616634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kqcA9so7cV6dWBKdATLcRDtcdH0GoOKySw+jjMyO5EA=;
 b=fg41bbGTEEv+uBt6poPNE2/ynx2/qxOdwBbQhUqap9wP5nWHdWFOznpbVqw2evPCX1
 WH12gEykAJgkDmuum+rjgIESCpjjxcCgivm5PVnuoB2bKupPcrxg2sQsC5C0+dT3DO0U
 evfCGtnJNn1CHxRkY7FXZNaLyE1blT0m2ksSI+ilkWkJyGVA9vATmarTYjO+qZTsM5nz
 upVkbjbcG4I45KjDWnko8J/aj9TXTPRVQef19+6vITOAjf7keXTTS7YdIqqJeT7Yo79m
 8Oxuj5k6hGTIwHuBsnz8vtM0aZA2o7Rf0LM/bR1qwXj2eYUsXzGd2KgIJZrw2318YnhO
 7kKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkdbxm3AF7hvYxZuNGsWWuTxuKlLCM5Pgh7dC6Nb1/OLD0qo40UvzNSQaAlj9gYmneZ5aoR2Rq5vMUiW3EgDtHa2YubxM=
X-Gm-Message-State: AOJu0YylDsBFeVi5aTnQ74rbV/unbeDFVMWaeDqNSmykvHrh26z3pbcw
 PpjHLS17dhllT76zCwuOsd09RZ849WdoGCcKcW5FZZmHdsEgqi66hFzPKeDw/qg=
X-Google-Smtp-Source: AGHT+IE56HhMyg2lqVZnHD8lsS9fs6LYSoczqEjX2UTmRdZuSgHBE+NMsPRP9OvW3NHyMefHNmhG8A==
X-Received: by 2002:ac2:5478:0:b0:511:6f43:b5d with SMTP id
 e24-20020ac25478000000b005116f430b5dmr1648152lfn.17.1708011833740; 
 Thu, 15 Feb 2024 07:43:53 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 gc8-20020a170906c8c800b00a3da60b16fesm463330ejb.95.2024.02.15.07.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 07:43:53 -0800 (PST)
Message-ID: <7feac60b-3adc-4b3e-a971-6139e1fcd72d@linaro.org>
Date: Thu, 15 Feb 2024 16:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/misc: add a user creatable dummy device for
 debugging
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20240215141055.55173-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215141055.55173-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/2/24 15:10, Alex Bennée wrote:
> This is an experimental patch to allow the creation of unimp regions
> from the command line. I'm not sure we would ever merge it as
> generally unimp regions are created by the machine definition and
> adding your own regions into existing device spaces is likely to break
> things pretty badly.
> 
> However what I was looking for was a simple way to test that a Xen XFT
> test was accessing and trapping where I thought it was without hacking
> up the machine models themselves. It allows the addition of unimp
> regions to specific address spaces as in the future we shouldn't rely
> on sysbus being the default but it's pretty clunky as you need to
> intuit the full QOM path of the region, e.g.:
> 
>    /qemu-system-aarch64 -machine fby35 --display none \
>      -serial mon:stdio -d unimp \
>      --device dummy-device,name=dummy1,offset=0x10001000,size=0x1000,x-address-space="/machine/unattached/fsi.opb[0]"
> 
> Then running info mtree -f shows:
> 
>    ...
>    FlatView #15
>     AS "fsi.opb", root: fsi.opb
>     Root memory region: fsi.opb
>      0000000010001000-0000000010001fff (prio 0, i/o): dummy1
>      0000000080000000-000000008fffffff (prio 0, i/o): fsi.master
>      00000000a0000000-00000000a00003ff (prio 0, i/o): cfam.config
>      00000000a0000400-00000000a00007ff (prio 0, i/o): cfam @0000000000000400
>      00000000a0000800-00000000a0000bff (prio 0, i/o): fsi.slave
>      00000000a0000c00-00000000a0000fff (prio 0, i/o): fsi.scratchpad
>      00000000a0001000-00000000a01fffff (prio 0, i/o): cfam @0000000000001000
> 
> No need to review this RFC unless you particularly think this would be
> useful to develop further.

Some devices are only useful for QEMU hardness test suite,
but still are very useful in-tree.

https://lore.kernel.org/qemu-devel/20200817161853.593247-6-f4bug@amsat.org/

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/dummy.c     | 97 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build |  2 +-
>   2 files changed, 98 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/dummy.c
> 
> diff --git a/hw/misc/dummy.c b/hw/misc/dummy.c
> new file mode 100644
> index 00000000000..701c3468951
> --- /dev/null
> +++ b/hw/misc/dummy.c
> @@ -0,0 +1,97 @@
> +/*
> + * user creatable dummy device wrapper
> + *
> + * This is a simple wrapper around the unimp device
> + *
> + * Copyright (c) 2024 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/address-spaces.h"
> +#include "hw/misc/unimp.h"
> +
> +#define TYPE_DUMMY_DEVICE "dummy-device"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(DummyDeviceState, DUMMY_DEVICE)
> +
> +struct DummyDeviceState {
> +    DeviceState parent_obj;
> +
> +    DeviceState *unimp;
> +
> +    MemoryRegion *mr;
> +
> +    char *name;
> +    char *as_name;
> +    uint64_t offset;
> +    uint64_t size;
> +};
> +
> +static void dummy_realize(DeviceState *dev, Error **errp)
> +{
> +    DummyDeviceState *s = DUMMY_DEVICE(dev);
> +
> +    if (s->size == 0) {
> +        error_setg(errp, "property 'size' not specified or zero");
> +        return;
> +    }
> +
> +    if (s->name == NULL) {
> +        error_setg(errp, "property 'name' not specified");
> +        return;
> +    }
> +
> +    if (s->as_name == NULL) {
> +        s->mr = get_system_memory();
> +    } else {
> +        bool ambiguous = false;
> +        /* this needs to be a full path. e.g. /machine/unattached/foo[0] */
> +        Object *obj = object_resolve_path_type(s->as_name, TYPE_MEMORY_REGION, &ambiguous);

OMG yet another attempt of device which automatically map itself in
its REALIZE()...

> +        if (!obj || ambiguous) {
> +            error_setg(errp, "Unable to find %s to locate region", s->as_name);
> +            return;
> +        }
> +        s->mr = MEMORY_REGION(obj);
> +    }
> +
> +    /*
> +     * While this is a test device we don't want to make it too easy
> +     * to shoot yourself in the foot.
> +     */
> +    s->unimp = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
> +    qdev_prop_set_string(s->unimp, "name", s->name);
> +    qdev_prop_set_uint64(s->unimp, "size", s->size);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->unimp), &error_fatal);
> +
> +    /* Now lets map it to memory */
> +    memory_region_add_subregion_overlap(s->mr, s->offset, &UNIMPLEMENTED_DEVICE(s->unimp)->iomem, 0);

... here!

> +}
> +
> +static Property dummy_properties[] = {
> +    DEFINE_PROP_UINT64("offset", DummyDeviceState, offset, 0),
> +    DEFINE_PROP_UINT64("size", DummyDeviceState, size, 0),
> +    DEFINE_PROP_STRING("name", DummyDeviceState, name),
> +    DEFINE_PROP_STRING("x-address-space", DummyDeviceState, as_name),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void dummy_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = dummy_realize;
> +    device_class_set_props(dc, dummy_properties);
> +}
> +
> +static const TypeInfo dummy_devices[]  = {
> +    {
> +        .name = TYPE_DUMMY_DEVICE,
> +        .parent = TYPE_DEVICE,
> +        .instance_size = sizeof(DummyDeviceState),
> +        .class_init = dummy_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(dummy_devices)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index e4ef1da5a53..309314e2398 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -5,7 +5,7 @@ system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>   system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
>   system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
>   system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
> -system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
> +system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c', 'dummy.c'))
>   system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
>   system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
>   system_ss.add(when: 'CONFIG_PVPANIC_COMMON', if_true: files('pvpanic.c'))


