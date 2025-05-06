Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B5EC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5ut-00058z-3W; Mon, 05 May 2025 20:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5ur-00057b-41
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:12:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5up-0000AN-An
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:12:08 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so6643321b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490325; x=1747095125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WwbE5zCuRNdoSj9HMHlPp/aP8km5G0RdQVXA9a3KT6Q=;
 b=YF4HaJAr4TmyXJOuqdxtZQh7TV1jC03CE8aHjPyX8Ll+My/QV9KEWtmi45R2VgsPBk
 7lIF6Pd2qGes9dE1wBCg8OmCsBSeuKpBOwWHNQtIg8TLWhJhYVtwYIb5d2mk4/cWYdLD
 2zqKQiuA4OPRniMi901gwdYvhI63a8qtwM474sbB9YHGnHj8EaYxbG2YdGwgJMOD1qXB
 obsNa2lH83F1ZPmISo8IFl1MLH9IPpq/4xgKwf2r3Y3gbJx88xiIVuAYfNxJk55GpwGW
 dWmMtsZbdL20RFxjuKPWWS88Q4reINKoLzXfX29qy2V4XNf6NGcyOuq0g5drgndS7Iry
 2iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490325; x=1747095125;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WwbE5zCuRNdoSj9HMHlPp/aP8km5G0RdQVXA9a3KT6Q=;
 b=gsQNLwc5iwJuxJXzUxrdyerphqyI557h14w8Z0My6Aqx6hlNFS6ll6gIAhYAWUonNj
 DJYxpKrmUp4TqnpkQT81o6XdUqMsiV/UR+g3+QA322nrvKjw2TzQMuiQaWV5FTnQ7ouQ
 ZpSmSLVHNXCNWx/KVeQgTXXlwLA6ddNiPJ0AxnveF5SQyevjALDGFGIQvc9UtVSHJjXd
 37EedxMI4VYvIml85SdwqQcjwRNjdLGumbaw6SJl/zcjSiqxpPjWL7v1mBhFSivhFaKQ
 UN3FH2R1tICd80/hbi5ZP1zr7rv6vDcBt9U0hmmX0sFi7j5041qUMYD41hJ1TVTPyno8
 d9Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA26bTtNB+iGx056zkaV4YSCtS93EkTui/2CK19NRxvN83ySiiPmRLfd1z6tnTvqKS4aX7jrsN5Mzt@nongnu.org
X-Gm-Message-State: AOJu0Yxj8VxPSVlxb5zCoSS1jOmF42OxSUIIwMObwwOfPAnIAtOGBloL
 LllZrpY7DEpb/XWDqrMAkdjhnbKLD/zk/8qkDJg3RARUnGzj75nmLjGVs1e9CplHB+q2r3S7Cp3
 3lV8=
X-Gm-Gg: ASbGncvrd4RuTd6RDIKorOtBrIQQltZb4mbNZw3WCk2fJdzRx+up8UYHz1hghaI+bij
 aP3naQ7c/FDE7Hjg3iOuOUajURepTaukD2zPLoVOjNiN6LAF9I94JxvEdO8hdXPZGKW4LtBcACN
 /K9BOIpjqrOw9XbLgT5eiYltdA7HnidBBu8zWgA5NA9CwIAMjAQ3/8rs5V5N2zUlCCA66l5Sl1x
 CHKAqSWTEhSGwNiMgJng3TOxdw1FhH+gSxHX0Cm1GmrnvG8j586iIRhjMIlFObJXkIADcIAch27
 /+uJUvHp06uKferkaO1NmMS7kGpmUVU3pdFxX/czpTMCpXZ7F0lQRbpJqJks74HcWLM3AJjNx9X
 vq4l/ASnWHmMnAuSfGcA=
X-Google-Smtp-Source: AGHT+IFQjW3s/sgHUcq7TS1swEa4LywwFshXfUe4FPdRWIQmAryK+v8kojx8ohUI9gk1CY668QrMKg==
X-Received: by 2002:a05:6a00:e84:b0:736:4cde:5c0e with SMTP id
 d2e1a72fcca58-740919e4dbdmr1318238b3a.10.1746490325492; 
 Mon, 05 May 2025 17:12:05 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbbe25sm7795188b3a.59.2025.05.05.17.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:12:05 -0700 (PDT)
Message-ID: <a8566819-5a9c-464f-8c8b-b74ff9f65207@linaro.org>
Date: Mon, 5 May 2025 21:12:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 05/24] hw/arm/virt: Introduce machine state acpi pcihp flags
 and props
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-6-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> acpi_pcihp VirtMachineClass state flag will allow
> to opt in for acpi pci hotplug. This is guarded by a
> class no_acpi_pcihp flag to manage compats (<= 10.0
> machine types will not support ACPI PCI hotplug).
> 
> Machine state acpi_pcihp flag msu be set before the creation
                         nit:    ^--- must be set


> of the GED device which will use it.
> 
> Currently the ACPI PCI HP is turned off by default. This will
> change later on for 10.1 machine type.
> 
> We also introduce properties to allow disabling it.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/arm/virt.h |  2 ++
>   hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c8e94e6aed..1e9d002880 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -135,6 +135,7 @@ struct VirtMachineClass {
>       bool no_tcg_lpa2;
>       bool no_ns_el2_virt_timer_irq;
>       bool no_nested_smmu;
> +    bool no_acpi_pcihp;
>   };
>   
>   struct VirtMachineState {
> @@ -156,6 +157,7 @@ struct VirtMachineState {
>       bool mte;
>       bool dtb_randomness;
>       bool second_ns_uart_present;
> +    bool acpi_pcihp;
>       OnOffAuto acpi;
>       VirtGICType gic_version;
>       VirtIOMMUType iommu;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3e72adaa91..1601750913 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2414,8 +2414,10 @@ static void machvirt_init(MachineState *machine)
>       create_pcie(vms);
>   
>       if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
>           vms->acpi_dev = create_acpi_ged(vms);
>       } else {
> +        vms->acpi_pcihp = false;
>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>       }
>   
> @@ -2610,6 +2612,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>       vms->its = value;
>   }
>   
> +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    return vms->acpi_pcihp;
> +}
> +
> +static void virt_set_acpi_pcihp(Object *obj, bool value, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    vms->acpi_pcihp = value;
> +}
> +
>   static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(obj);
> @@ -3327,6 +3343,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                             "in ACPI table header."
>                                             "The string may be up to 8 bytes in size");
>   
> +    object_class_property_add_bool(oc, "acpi-pcihp",
> +                                   virt_get_acpi_pcihp, virt_set_acpi_pcihp);
> +    object_class_property_set_description(oc, "acpi-pcihp",
> +                                          "Force acpi pci hotplug");

How about "Force ACPI PCI hotplug"?


>   }
>   
>   static void virt_instance_init(Object *obj)
> @@ -3365,6 +3385,9 @@ static void virt_instance_init(Object *obj)
>           }
>       }
>   
> +    /* default disallows ACPI PCI hotplug */
> +    vms->acpi_pcihp = false;
> +
>       /* Default disallows iommu instantiation */
>       vms->iommu = VIRT_IOMMU_NONE;
>   
> @@ -3415,8 +3438,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>   
>   static void virt_machine_10_0_options(MachineClass *mc)
>   {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>       virt_machine_10_1_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
> +    vmc->no_acpi_pcihp = true;
>   }
>   DEFINE_VIRT_MACHINE(10, 0)
>   

Otherwise,

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

