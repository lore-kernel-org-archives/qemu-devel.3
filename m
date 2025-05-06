Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32450C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDtb-0003C9-2h; Tue, 06 May 2025 04:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCDtY-00037N-Vw
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCDtV-0006ED-QR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746520996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLudRUQRRIXoYeKtWK2mqXpNLSaWKLM3wDSmuHnWTyc=;
 b=bUh85MhpKL91XPcDlV0CVuAE63gjXYr6qnxFWD1haGwl+1eR/TbDzufh5iYpG67S78JrIv
 pS0DmSKcHWyG6bvijP6PM/x5dlU9T6nMdbXaeI4IPohmAJMLKNed+z1IQlkwwfGN6VKae6
 dDHUT1PhmkPQfB1hLaH7EEjII/+wKR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-iWKyGMLzPMeATMY-eztqgA-1; Tue, 06 May 2025 04:43:15 -0400
X-MC-Unique: iWKyGMLzPMeATMY-eztqgA-1
X-Mimecast-MFC-AGG-ID: iWKyGMLzPMeATMY-eztqgA_1746520994
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so27446085e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746520994; x=1747125794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wLudRUQRRIXoYeKtWK2mqXpNLSaWKLM3wDSmuHnWTyc=;
 b=oeGzXBTmOQG9Ky9TBU7bhAw9r9rkVB+ypLgPn3cqf4LFR0/YlFYVozsoD0iZ46Va2Q
 9gl8PpWojFAhZ0thSLGeVhpBmjtO7ZXmfiWHyPvsP7ytR5cL/yK9mRtns6YFkI+tN8Ge
 JQGrdToXD3epeRHom5MnPkFdG+Bq/hRhD9IG6p4bj+O5m/SMLHE+O3lP6GYmTucGEhJU
 7EtNii9lRZSQ/P7ImQQsr3NSUSqy7H4gR02zAM+JgaibuDQ2xV2S37lbay/pmvbjKJkA
 5rYtaqOw01Y7Qd0CC356LyTKmLzC7eBNkbH3IhqaLoPnbemsvIyDmjJ88ruC7XeRCiF+
 QrFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbE/WgVpB8w6dHoSFWVea8v0ZI1UhFqpyiaXqzUX/P8Y1CVbUpSo7xvrNWAjz3soXEZgj3pVxieHKS@nongnu.org
X-Gm-Message-State: AOJu0YzfkBDH/Sv2KpB/pAoZtEj1v7ZE7UPXC5v4k82XIpdev9X5C8BW
 Sf97DU/FlRUzeg+DKf3SHKTq//oStgUueDhuIohrH8I0JBFntt0xU5W2We2FPbYv3zYLENA8do3
 S6I/5m/GWD4t/FUdEPdFx5YKM3uvm6hzv7mjx+4Un5PILj1CGWg9e
X-Gm-Gg: ASbGncuNY8CaEIkIzNiYLYnp5zwTl4xm3wjLR10LnDDJ8gdvnH9sX0wJSRFoFkmPREi
 Syuv6Bk5SP8kH6lJPmu7DoQNgm5hPScILQoM6xZ1HrMlZ+LWT44jTq84l081XuN92YQHg0XmY5a
 bMTUwBeSixljTySGWdM3woVqmNHLzc6vp+QaeOwD4xQyg8EGgjZEvRG0ySDSaSOLVeTHmnTn6rC
 q2iHJRsVA6r8SSDEr7XrKg6BGpXz2ORv0HC6OvCcvDnvEdzqYjZLA6TMvyI5JZ5FagE6Dsi7qmc
 39d8NBCeccJY58oc2fwjjYp6GMrbyTnJeAMWJLslAjawv5CMBgLUEG/ILNk=
X-Received: by 2002:a05:600c:468c:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-441c4923885mr78863115e9.23.1746520994188; 
 Tue, 06 May 2025 01:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQrC5OqH/6GDANrgffATsNSuEEAhYcVBor8IjBFJePSiNTomJQFY2tysaZJJPUPgcunmH1ig==
X-Received: by 2002:a05:600c:468c:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-441c4923885mr78860615e9.23.1746520990623; 
 Tue, 06 May 2025 01:43:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af32a0sm209759555e9.23.2025.05.06.01.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:43:08 -0700 (PDT)
Message-ID: <ed6e2188-85b6-4a50-8947-8abdba13a09d@redhat.com>
Date: Tue, 6 May 2025 10:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 05/24] hw/arm/virt: Introduce machine state acpi pcihp flags
 and props
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-6-eric.auger@redhat.com>
 <a8566819-5a9c-464f-8c8b-b74ff9f65207@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <a8566819-5a9c-464f-8c8b-b74ff9f65207@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/6/25 2:12 AM, Gustavo Romero wrote:
> Hi Eric,
>
> On 4/28/25 07:25, Eric Auger wrote:
>> acpi_pcihp VirtMachineClass state flag will allow
>> to opt in for acpi pci hotplug. This is guarded by a
>> class no_acpi_pcihp flag to manage compats (<= 10.0
>> machine types will not support ACPI PCI hotplug).
>>
>> Machine state acpi_pcihp flag msu be set before the creation
>                         nit:    ^--- must be set
>
>
>> of the GED device which will use it.
>>
>> Currently the ACPI PCI HP is turned off by default. This will
>> change later on for 10.1 machine type.
>>
>> We also introduce properties to allow disabling it.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/hw/arm/virt.h |  2 ++
>>   hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index c8e94e6aed..1e9d002880 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -135,6 +135,7 @@ struct VirtMachineClass {
>>       bool no_tcg_lpa2;
>>       bool no_ns_el2_virt_timer_irq;
>>       bool no_nested_smmu;
>> +    bool no_acpi_pcihp;
>>   };
>>     struct VirtMachineState {
>> @@ -156,6 +157,7 @@ struct VirtMachineState {
>>       bool mte;
>>       bool dtb_randomness;
>>       bool second_ns_uart_present;
>> +    bool acpi_pcihp;
>>       OnOffAuto acpi;
>>       VirtGICType gic_version;
>>       VirtIOMMUType iommu;
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 3e72adaa91..1601750913 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2414,8 +2414,10 @@ static void machvirt_init(MachineState *machine)
>>       create_pcie(vms);
>>         if (has_ged && aarch64 && firmware_loaded &&
>> virt_is_acpi_enabled(vms)) {
>> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
>>           vms->acpi_dev = create_acpi_ged(vms);
>>       } else {
>> +        vms->acpi_pcihp = false;
>>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>       }
>>   @@ -2610,6 +2612,20 @@ static void virt_set_its(Object *obj, bool
>> value, Error **errp)
>>       vms->its = value;
>>   }
>>   +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    return vms->acpi_pcihp;
>> +}
>> +
>> +static void virt_set_acpi_pcihp(Object *obj, bool value, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    vms->acpi_pcihp = value;
>> +}
>> +
>>   static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>>   {
>>       VirtMachineState *vms = VIRT_MACHINE(obj);
>> @@ -3327,6 +3343,10 @@ static void
>> virt_machine_class_init(ObjectClass *oc, void *data)
>>                                             "in ACPI table header."
>>                                             "The string may be up to
>> 8 bytes in size");
>>   +    object_class_property_add_bool(oc, "acpi-pcihp",
>> +                                   virt_get_acpi_pcihp,
>> virt_set_acpi_pcihp);
>> +    object_class_property_set_description(oc, "acpi-pcihp",
>> +                                          "Force acpi pci hotplug");
>
> How about "Force ACPI PCI hotplug"?

Sure.

Thanks!

Eric
>
>
>>   }
>>     static void virt_instance_init(Object *obj)
>> @@ -3365,6 +3385,9 @@ static void virt_instance_init(Object *obj)
>>           }
>>       }
>>   +    /* default disallows ACPI PCI hotplug */
>> +    vms->acpi_pcihp = false;
>> +
>>       /* Default disallows iommu instantiation */
>>       vms->iommu = VIRT_IOMMU_NONE;
>>   @@ -3415,8 +3438,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>>     static void virt_machine_10_0_options(MachineClass *mc)
>>   {
>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>> +
>>       virt_machine_10_1_options(mc);
>>       compat_props_add(mc->compat_props, hw_compat_10_0,
>> hw_compat_10_0_len);
>> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
>> +    vmc->no_acpi_pcihp = true;
>>   }
>>   DEFINE_VIRT_MACHINE(10, 0)
>>   
>
> Otherwise,
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo
>


