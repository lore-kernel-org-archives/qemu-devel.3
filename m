Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FA7C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5vY-0006ZN-Hx; Mon, 05 May 2025 20:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5vT-0006V4-Uh
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:12:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5vN-0000CK-OL
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:12:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c3407a87aso75004015ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490360; x=1747095160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cATzkfXbohQXK2Q2vXX1nYmyT7NMj8ji2K01wgqx4QU=;
 b=uCFc78gkm8GGfa90SBqLBzy1MjGAIrEx9t63k3BvBryrZnzfUT+CSxOs6WnRvms47o
 +k+51W5BZ8Jxan0XKQw+k2fhm97NbSkaPN6V0xz9CqhVSKFh2abfC9cQ/ml97tYinJY/
 04oKqAoK6hVz2mKP0p02J4y568foNvYYXwlShzNif1Nj9D9CcmirUVJiVdOoZPpFTfrP
 TLg+INgJryVPF00B9UJ57DJJFvWrCR7Ud0ykbElQKbEvozKFbNt/VnU2RadGEGHMzvrz
 EPywkYlv8Qbfos1x/ncjb1+t7dQW/M7AHFT+xWytzdNvMd2CZEekR6r1PtCiuf/2Pk0x
 jWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490360; x=1747095160;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cATzkfXbohQXK2Q2vXX1nYmyT7NMj8ji2K01wgqx4QU=;
 b=WDi40EszGBTZhU7BgJa/VYU0OhcWolXrLzK7daklWZTaJFbgwYYe06TEDzp5CJSa5n
 OUubEp4MYISNUbEWwmaMweEXIitV7eGnNZj9Uv0Rz9jbM0KXoPIC2EpYvfFpqtI2/Hwo
 Tl8OIH0KuUaQPL17RRi5fqEspM3o3KfbBVWXEzQZ4etvJvjiOd759wGMrfka9Ug5ptIH
 XGkTryFhwYVCIE8bqjUO4e1OZ2u5zgV/Vy8evCtbROd5ri+7aMU41lQqVS7jhZ3B1o15
 i/tyS8Ha7aOlnEUP61YaaWmBNW7sNn+k9wVaZNhuI3DNpIHsYWa59TvADyuuxIFckY6y
 MZvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfTs4+li/MtwpLYH/8s6QRSRyGoBT9WsN6Tp8klcDV70E2nP5grF4H00HZxi+Ua6s1FJeLmH8OMhgS@nongnu.org
X-Gm-Message-State: AOJu0YzSNlCDGab/rk3NS+HvKrBrbUsWWRcs7pyotRfrvlU2ed7JnPiv
 mlyJJwO/FYJEx2oSA8qFIYiSl+vdaxXYthiCfkx3ef1t56GnsU2w3boEwEW1rH8=
X-Gm-Gg: ASbGncsjtqCGPUM4FaUJq8acnQAIQjM7VsHP+TunjMqIBQVsfczXrHffM9kHIJJ7Vud
 PR4hwRtqW4++g9UlO0fSutlHcavb4tdGYXqrUN+uCye0TkhlJBAUYpeBnQK4v1Fbh7qsLF6gv3X
 Dhy9FCEOxcO6cb6Rf0gnIQ5PJGlAzxUiWnob+ZaZYa7UoV7s5ycaQhHDqz0mUmRqNTBPrvEIPy9
 WHUSNqbtFcuGxBx9/Ns3EftLFs+/DYDAf5/OX3Y9HXpHVjZFiLnpBVhIPH4vcFrliw+5H1WQXuE
 ejOoWbeROk6B5V6sEF9/CuNxIOa11MSzF5aZHNeOzd8aGpro4+MZlBP1kg7asiaEAviAc5buDT1
 Gn7ePOceukrnzWERY2AM=
X-Google-Smtp-Source: AGHT+IH8hMXCqrpCUMHSoKYqsBvnkT1BBGPpQe5ocYenfi8VLaveYg7qDMOyuMvJLM3tjIgY1KH9Fg==
X-Received: by 2002:a17:903:8cd:b0:224:fa0:36da with SMTP id
 d9443c01a7336-22e1ea54c68mr115503445ad.18.1746490359828; 
 Mon, 05 May 2025 17:12:39 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15229474sm61393085ad.184.2025.05.05.17.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:12:39 -0700 (PDT)
Message-ID: <ee369c86-3bb5-45d6-a6ca-b1d1573cb115@linaro.org>
Date: Mon, 5 May 2025 21:12:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 06/24] hw/acpi: Rename and move build_x86_acpi_pci_hotplug
 to pcihp
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-7-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-7-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> We plan to reuse build_x86_acpi_pci_hotplug() implementation
> for ARM so let's move the code to generic pcihp.
> 
> Associated static aml_pci_pdsm() helper is also moved along.
> build_x86_acpi_pci_hotplug is renamed into build_acpi_pci_hotplug().
> 
> No code change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/acpi-build.h    |   4 -
>   include/hw/acpi/pcihp.h |   6 ++
>   hw/acpi/pcihp.c         | 174 +++++++++++++++++++++++++++++++++++++++-
>   hw/i386/acpi-build.c    | 150 +---------------------------------
>   4 files changed, 181 insertions(+), 153 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 0dce155c8c..8ba3c33e48 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -5,10 +5,6 @@
>   
>   extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>   
> -/* PCI Hot-plug registers bases. See docs/spec/acpi_pci_hotplug.txt */
> -#define ACPI_PCIHP_SEJ_BASE 0x8
> -#define ACPI_PCIHP_BNMR_BASE 0x10
> -
>   void acpi_setup(void);
>   Object *acpi_get_i386_pci_host(void);
>   
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index ac21a95913..2da0bc45c9 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -33,6 +33,10 @@
>   #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
>   #define ACPI_PCIHP_IO_LEN_PROP "acpi-pcihp-io-len"
>   
> +/* PCI Hot-plug registers bases. See docs/spec/acpi_pci_hotplug.txt */

This reference needs to be updated to point to acpi_pci_hotplug.rst.

Otherwise,

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> +#define ACPI_PCIHP_SEJ_BASE 0x8
> +#define ACPI_PCIHP_BNMR_BASE 0x10
> +
>   typedef struct AcpiPciHpPciStatus {
>       uint32_t up;
>       uint32_t down;
> @@ -69,6 +73,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                            AcpiPciHpState *s, DeviceState *dev,
>                                            Error **errp);
>   
> +void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
> +
>   /* Called on reset */
>   void acpi_pcihp_reset(AcpiPciHpState *s);
>   
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 5f79c9016b..35d8c0bfd2 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -26,7 +26,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "hw/acpi/pcihp.h"
> -
> +#include "hw/acpi/aml-build.h"
>   #include "hw/pci-host/i440fx.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -513,6 +513,178 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
>                                      OBJ_PROP_FLAG_READ);
>   }
>   
> +static void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
> +{
> +    Aml *UUID, *ifctx1;
> +    uint8_t byte_list[1] = { 0 }; /* nothing supported yet */
> +
> +    aml_append(ctx, aml_store(aml_buffer(1, byte_list), retvar));
> +    /*
> +     * PCI Firmware Specification 3.1
> +     * 4.6.  _DSM Definitions for PCI
> +     */
> +    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
> +    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(0), UUID)));
> +    {
> +        /* call is for unsupported UUID, bail out */
> +        aml_append(ifctx1, aml_return(retvar));
> +    }
> +    aml_append(ctx, ifctx1);
> +
> +    ifctx1 = aml_if(aml_lless(aml_arg(1), aml_int(2)));
> +    {
> +        /* call is for unsupported REV, bail out */
> +        aml_append(ifctx1, aml_return(retvar));
> +    }
> +    aml_append(ctx, ifctx1);
> +}
> +
> +static Aml *aml_pci_pdsm(void)
> +{
> +    Aml *method, *ifctx, *ifctx1;
> +    Aml *ret = aml_local(0);
> +    Aml *caps = aml_local(1);
> +    Aml *acpi_index = aml_local(2);
> +    Aml *zero = aml_int(0);
> +    Aml *one = aml_int(1);
> +    Aml *not_supp = aml_int(0xFFFFFFFF);
> +    Aml *func = aml_arg(2);
> +    Aml *params = aml_arg(4);
> +    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
> +    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
> +
> +    method = aml_method("PDSM", 5, AML_SERIALIZED);
> +
> +    /* get supported functions */
> +    ifctx = aml_if(aml_equal(func, zero));
> +    {
> +        build_append_pci_dsm_func0_common(ifctx, ret);
> +
> +        aml_append(ifctx, aml_store(zero, caps));
> +        aml_append(ifctx,
> +            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> +        /*
> +         * advertise function 7 if device has acpi-index
> +         * acpi_index values:
> +         *            0: not present (default value)
> +         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
> +         *        other: device's acpi-index
> +         */
> +        ifctx1 = aml_if(aml_lnot(
> +                     aml_or(aml_equal(acpi_index, zero),
> +                            aml_equal(acpi_index, not_supp), NULL)
> +                 ));
> +        {
> +            /* have supported functions */
> +            aml_append(ifctx1, aml_or(caps, one, caps));
> +            /* support for function 7 */
> +            aml_append(ifctx1,
> +                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
> +        }
> +        aml_append(ifctx, ifctx1);
> +
> +        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
> +        aml_append(ifctx, aml_return(ret));
> +    }
> +    aml_append(method, ifctx);
> +
> +    /* handle specific functions requests */
> +    /*
> +     * PCI Firmware Specification 3.1
> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> +     *        Operating Systems
> +     */
> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
> +    {
> +       Aml *pkg = aml_package(2);
> +
> +       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> +       aml_append(ifctx, aml_store(pkg, ret));
> +       /*
> +        * Windows calls func=7 without checking if it's available,
> +        * as workaround Microsoft has suggested to return invalid for func7
> +        * Package, so return 2 elements package but only initialize elements
> +        * when acpi_index is supported and leave them uninitialized, which
> +        * leads elements to being Uninitialized ObjectType and should trip
> +        * Windows into discarding result as an unexpected and prevent setting
> +        * bogus 'PCI Label' on the device.
> +        */
> +       ifctx1 = aml_if(aml_lnot(aml_lor(
> +                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
> +                )));
> +       {
> +           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
> +           /*
> +            * optional, if not impl. should return null string
> +            */
> +           aml_append(ifctx1, aml_store(aml_string("%s", ""),
> +                                        aml_index(ret, one)));
> +       }
> +       aml_append(ifctx, ifctx1);
> +
> +       aml_append(ifctx, aml_return(ret));
> +    }
> +
> +    aml_append(method, ifctx);
> +    return method;
> +}
> +
> +void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> +{
> +    Aml *scope;
> +    Aml *field;
> +    Aml *method;
> +
> +    scope =  aml_scope("_SB.PCI0");
> +
> +    aml_append(scope,
> +        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> +    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("PCIU", 32));
> +    aml_append(field, aml_named_field("PCID", 32));
> +    aml_append(scope, field);
> +
> +    aml_append(scope,
> +        aml_operation_region("SEJ", AML_SYSTEM_IO,
> +                             aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
> +    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("B0EJ", 32));
> +    aml_append(scope, field);
> +
> +    aml_append(scope,
> +        aml_operation_region("BNMR", AML_SYSTEM_IO,
> +                             aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
> +    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("BNUM", 32));
> +    aml_append(field, aml_named_field("PIDX", 32));
> +    aml_append(scope, field);
> +
> +    aml_append(scope, aml_mutex("BLCK", 0));
> +
> +        method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
> +    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> +    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> +    aml_append(method,
> +        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
> +    aml_append(method, aml_release(aml_name("BLCK")));
> +    aml_append(method, aml_return(aml_int(0)));
> +    aml_append(scope, method);
> +
> +    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
> +    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> +    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> +    aml_append(method,
> +        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("PIDX")));
> +    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
> +    aml_append(method, aml_release(aml_name("BLCK")));
> +    aml_append(method, aml_return(aml_local(0)));
> +    aml_append(scope, method);
> +
> +    aml_append(scope, aml_pci_pdsm());
> +
> +    aml_append(table, scope);
> +}
> +
>   const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>       .name = "acpi_pcihp_pci_status",
>       .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 864f6b5bf8..2d1eea4a1a 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -647,96 +647,6 @@ static bool build_append_notification_callback(Aml *parent_scope,
>       return !!nr_notifiers;
>   }
>   
> -static Aml *aml_pci_pdsm(void)
> -{
> -    Aml *method, *ifctx, *ifctx1;
> -    Aml *ret = aml_local(0);
> -    Aml *caps = aml_local(1);
> -    Aml *acpi_index = aml_local(2);
> -    Aml *zero = aml_int(0);
> -    Aml *one = aml_int(1);
> -    Aml *not_supp = aml_int(0xFFFFFFFF);
> -    Aml *func = aml_arg(2);
> -    Aml *params = aml_arg(4);
> -    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
> -    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
> -
> -    method = aml_method("PDSM", 5, AML_SERIALIZED);
> -
> -    /* get supported functions */
> -    ifctx = aml_if(aml_equal(func, zero));
> -    {
> -        build_append_pci_dsm_func0_common(ifctx, ret);
> -
> -        aml_append(ifctx, aml_store(zero, caps));
> -        aml_append(ifctx,
> -            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> -        /*
> -         * advertise function 7 if device has acpi-index
> -         * acpi_index values:
> -         *            0: not present (default value)
> -         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
> -         *        other: device's acpi-index
> -         */
> -        ifctx1 = aml_if(aml_lnot(
> -                     aml_or(aml_equal(acpi_index, zero),
> -                            aml_equal(acpi_index, not_supp), NULL)
> -                 ));
> -        {
> -            /* have supported functions */
> -            aml_append(ifctx1, aml_or(caps, one, caps));
> -            /* support for function 7 */
> -            aml_append(ifctx1,
> -                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
> -        }
> -        aml_append(ifctx, ifctx1);
> -
> -        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
> -        aml_append(ifctx, aml_return(ret));
> -    }
> -    aml_append(method, ifctx);
> -
> -    /* handle specific functions requests */
> -    /*
> -     * PCI Firmware Specification 3.1
> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> -     *        Operating Systems
> -     */
> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
> -    {
> -       Aml *pkg = aml_package(2);
> -
> -       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
> -       aml_append(ifctx, aml_store(pkg, ret));
> -       /*
> -        * Windows calls func=7 without checking if it's available,
> -        * as workaround Microsoft has suggested to return invalid for func7
> -        * Package, so return 2 elements package but only initialize elements
> -        * when acpi_index is supported and leave them uninitialized, which
> -        * leads elements to being Uninitialized ObjectType and should trip
> -        * Windows into discarding result as an unexpected and prevent setting
> -        * bogus 'PCI Label' on the device.
> -        */
> -       ifctx1 = aml_if(aml_lnot(aml_lor(
> -                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
> -                )));
> -       {
> -           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
> -           /*
> -            * optional, if not impl. should return null string
> -            */
> -           aml_append(ifctx1, aml_store(aml_string("%s", ""),
> -                                        aml_index(ret, one)));
> -       }
> -       aml_append(ifctx, ifctx1);
> -
> -       aml_append(ifctx, aml_return(ret));
> -    }
> -
> -    aml_append(method, ifctx);
> -    return method;
> -}
> -
>   /*
>    * build_prt - Define interrupt routing rules
>    *
> @@ -1227,62 +1137,6 @@ static Aml *build_q35_dram_controller(const AcpiMcfgInfo *mcfg)
>       return dev;
>   }
>   
> -static void build_x86_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> -{
> -    Aml *scope;
> -    Aml *field;
> -    Aml *method;
> -
> -    scope =  aml_scope("_SB.PCI0");
> -
> -    aml_append(scope,
> -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> -    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> -    aml_append(field, aml_named_field("PCIU", 32));
> -    aml_append(field, aml_named_field("PCID", 32));
> -    aml_append(scope, field);
> -
> -    aml_append(scope,
> -        aml_operation_region("SEJ", AML_SYSTEM_IO,
> -                             aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
> -    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> -    aml_append(field, aml_named_field("B0EJ", 32));
> -    aml_append(scope, field);
> -
> -    aml_append(scope,
> -        aml_operation_region("BNMR", AML_SYSTEM_IO,
> -                             aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
> -    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
> -    aml_append(field, aml_named_field("BNUM", 32));
> -    aml_append(field, aml_named_field("PIDX", 32));
> -    aml_append(scope, field);
> -
> -    aml_append(scope, aml_mutex("BLCK", 0));
> -
> -    method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
> -    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> -    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> -    aml_append(method,
> -        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
> -    aml_append(method, aml_release(aml_name("BLCK")));
> -    aml_append(method, aml_return(aml_int(0)));
> -    aml_append(scope, method);
> -
> -    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
> -    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
> -    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
> -    aml_append(method,
> -        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("PIDX")));
> -    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
> -    aml_append(method, aml_release(aml_name("BLCK")));
> -    aml_append(method, aml_return(aml_local(0)));
> -    aml_append(scope, method);
> -
> -    aml_append(scope, aml_pci_pdsm());
> -
> -    aml_append(table, scope);
> -}
> -
>   static Aml *build_q35_osc_method(bool enable_native_pcie_hotplug)
>   {
>       Aml *if_ctx;
> @@ -1394,7 +1248,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           aml_append(dsdt, sb_scope);
>   
>           if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> -            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>           }
>           build_piix4_pci0_int(dsdt);
>       } else if (q35) {
> @@ -1438,7 +1292,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           aml_append(dsdt, sb_scope);
>   
>           if (pm->pcihp_bridge_en) {
> -            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>           }
>           build_q35_pci0_int(dsdt);
>       }


