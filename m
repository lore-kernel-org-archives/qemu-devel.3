Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F2BC5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJulI-0007jq-65; Tue, 27 May 2025 09:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJulF-0007i6-Pq
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJulB-00057u-VG
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748354063;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUlrC4W6uOTNQ8bZE8ImtEYqZRoBhHReT9sR4QUSUWA=;
 b=anyReP2Qc80allaIiKdXQZxN9aQtLoasvrD6eQ89viy5YpiqVAF/CRmRVrnYMj4rZVC215
 9Bpe7lbm2UgNzGBGvbf2mUHOrH3yWj4u85DYJiMdpOzHFhE/Nba69lzi0oJHPaHQWboNel
 iP7e49FDmVKbvb72Ar/6kUIVr4WdKWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-tF5PyGcjOGSiODniCgdVew-1; Tue, 27 May 2025 09:54:20 -0400
X-MC-Unique: tF5PyGcjOGSiODniCgdVew-1
X-Mimecast-MFC-AGG-ID: tF5PyGcjOGSiODniCgdVew_1748354059
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so19680585e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354059; x=1748958859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUlrC4W6uOTNQ8bZE8ImtEYqZRoBhHReT9sR4QUSUWA=;
 b=OT0f3J+NxzCxE+hcf6S9sdRmktUpxM4WV6JOlNbNNxIgak1y4k7zBZFL6sVhSJaTie
 rfIUa0hTKXJ3WUoR20zUTUz89Ud+9+FOfNHI/OlkXCK9rKFi6cJlA9Rb5+5r/AB6ceZ3
 cHQ5+jkqSvJd16Ydkq8S6vA9YDJlB0JRJdW6Rq8MJLXzBTNO8T4FNyPcbn6tt4QTxu5k
 NlWoXeuiDZuO0/QuVK+tj8KC2236B0iLsA9cJSrGnkohdZUWOA2GJs72f6uR0kzbqO3q
 UaK8QFh/usPKLRLl3AFPm3uZdnxU8mQGSqLDhO/B9A4eVEMAo9KSRq7zEJB6HfYZfO4r
 KtWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1DYu04YA9+EV9lsdQ9DTMNi1WnSBUU1ln8JnXMDwm+RKZxGxF/t81HLcyhCC75UG8PXzf3jkYVoXn@nongnu.org
X-Gm-Message-State: AOJu0Yzg3Yr6epG3tJFXjMT4eQlPX1Ki7zCXJ+DsBxOmO4q2LkxUOmmf
 0kgqrBEsvs6MuJWizX5tU5mI6uxqjmG49/0Pp9AAv/b/ebeHfjm6G8fjwohIukiHUYgczp0Ax3K
 6iRAtm+Ky0MCNC3zHggYgfHc07ASzXsrEe+0HC1dBw0Ka1mD+ibBczc1e
X-Gm-Gg: ASbGnct5OXmkpr7y8O5fm9BnS+IX/TcF1sldiavJwrqi4Mk/mRNs+2bN7Esyoy1evMu
 ni8x2F+tI00gcgKVe4zeZ1sSfbd+YgxuGzInhqyOP+aPupeyXO+2dfACo9vp018lNbwRlzFy+UH
 ZLzwys6ctdZC70YUSMMF+xyc1PUrqc1pwXkRA54Grc/ZBZ1HBo3ZTszE1+IMaG2z63tZz1DNxoF
 hdOjRiXa+AWk7AHG3duWRVqgZijjLTY1bfRQd0+j48O/4MYqDlxbUjdxd1BTIS8SiuPkNTnKnub
 d0Jcu7dh0SUPPTbvA4twUaKyUUdmtTlSTU8k5Uuf+51Da+VuG5snBTzYubI=
X-Received: by 2002:a05:600c:512a:b0:44b:2f53:351c with SMTP id
 5b1f17b1804b1-44c91dcb6e7mr123795705e9.18.1748354059175; 
 Tue, 27 May 2025 06:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHHkSpoRV2Exl+qfev2epv0E7K5EG8RSsd5GIGvDXLgyJMlrW2mwFwzrlRh1sRZgrT4GWQyg==
X-Received: by 2002:a05:600c:512a:b0:44b:2f53:351c with SMTP id
 5b1f17b1804b1-44c91dcb6e7mr123795355e9.18.1748354058754; 
 Tue, 27 May 2025 06:54:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f74cce5bsm264808385e9.24.2025.05.27.06.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:54:17 -0700 (PDT)
Message-ID: <d6bd4794-bcee-4701-8e63-4adee91120d9@redhat.com>
Date: Tue, 27 May 2025 15:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi pcihp
 flags and props
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-3-eric.auger@redhat.com>
 <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Igor,

On 5/27/25 1:58 PM, Igor Mammedov wrote:
> On Tue, 27 May 2025 09:40:04 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> acpi_pcihp VirtMachineClass state flag will allow
>> to opt in for acpi pci hotplug. This is guarded by a
>> class no_acpi_pcihp flag to manage compats (<= 10.0
>> machine types will not support ACPI PCI hotplug).
> there is no reason to put an effort in force disabling it
> on old machines, as long as code works when explicitly
> enabled property on CLI.
>
> See comment below on how to deal with it 
>
>> Machine state acpi_pcihp flag must be set before the creation
>> of the GED device which will use it.
>>
>> Currently the ACPI PCI HP is turned off by default. This will
>> change later on for 10.1 machine type.
> one thing to note, is that turning it on by default might
> cause change of NIC naming in guest as this brings in
> new "_Sxx" slot naming. /so configs tied to nic  go down the drain/
>
> Naming, we have, also happens to be broken wrt spec
> (it should be unique system wide, there was a gitlab issue for that,
> there is no easy fix that though)
>
> So I'd leave it disabled by default and let users to turn
> it on explicitly when needed. 

what is the status on q35, isn't it enabled by default? If so why
wouldn't we want the same setting on ARM? Is that because of the known
issue you report above?

The no_foo compat stuff was especially introduced to avoid breaking the
guest ABI for old machine types (like the NIC naming alternation you evoke).
>
>> We also introduce properties to allow disabling it.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>  include/hw/arm/virt.h |  2 ++
>>  hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 9a1b0f53d2..10ea581f06 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -129,6 +129,7 @@ struct VirtMachineClass {
>>      bool no_tcg_lpa2;
>>      bool no_ns_el2_virt_timer_irq;
>>      bool no_nested_smmu;
>> +    bool no_acpi_pcihp;
>>  };
>>  
>>  struct VirtMachineState {
>> @@ -150,6 +151,7 @@ struct VirtMachineState {
>>      bool mte;
>>      bool dtb_randomness;
>>      bool second_ns_uart_present;
>> +    bool acpi_pcihp;
>>      OnOffAuto acpi;
>>      VirtGICType gic_version;
>>      VirtIOMMUType iommu;
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 9a6cd085a3..a0deeaf2b3 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState *machine)
>>      create_pcie(vms);
>>  
>>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
> I don't particularly like no_foo naming as it makes code harder to read
> and combined with 'duplicated' field in machine state it make even things worse.
> (if I recall right Philippe was cleaning mess similar flags usage
> have introduced with ITS)
>
> instead of adding machine property (both class and state),
> I'd suggest adding the only property to GPE device (akin to what we have in x86 world)
> And then one can meddle with defaults using hw_compat_xxx
no_foo still is a largely used pattern in arm virt: no_ged,
kvm_no_adjvtime, no_kvm_steal_time, no_tcg_lpa2, ../.. There are plenty
of them and I am not under the impression this is going to be changed.

If you refer to 8d23b1df7212 ("hw/arm/virt: Remove
VirtMachineClass::no_its field") I think the no_its was removed because
the machine it applied was removed.

If I understand correctly you would like the prop to be attached to the
GED device. However the GED device is internally created by the virt
machine code and not passed through a "-device" CLI option. So how would
you pass the option on the cmd line if you don't want it to be set by
default per machine type?

Thanks

Eric
>
>
>>          vms->acpi_dev = create_acpi_ged(vms);
>>      } else {
>> +        vms->acpi_pcihp = false;
>>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>      }
>>  
>> @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>>      vms->its = value;
>>  }
>>  
>> +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    return vms->acpi_pcihp;
>> +}
>> +
>> +static void virt_set_acpi_pcihp(Object *obj, bool value, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    vms->acpi_pcihp = value;
>> +}
>> +
>>  static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>>  {
>>      VirtMachineState *vms = VIRT_MACHINE(obj);
>> @@ -3310,6 +3326,10 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>>                                            "in ACPI table header."
>>                                            "The string may be up to 8 bytes in size");
>>  
>> +    object_class_property_add_bool(oc, "acpi-pcihp",
>> +                                   virt_get_acpi_pcihp, virt_set_acpi_pcihp);
>> +    object_class_property_set_description(oc, "acpi-pcihp",
>> +                                          "Force ACPI PCI hotplug");
>>  }
>>  
>>  static void virt_instance_init(Object *obj)
>> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
>>          vms->tcg_its = true;
>>      }
>>  
>> +    /* default disallows ACPI PCI hotplug */
>> +    vms->acpi_pcihp = false;
>> +
>>      /* Default disallows iommu instantiation */
>>      vms->iommu = VIRT_IOMMU_NONE;
>>  
>> @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>>  
>>  static void virt_machine_10_0_options(MachineClass *mc)
>>  {
>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>> +
>>      virt_machine_10_1_options(mc);
>>      compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
>> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
>> +    vmc->no_acpi_pcihp = true;
>>  }
>>  DEFINE_VIRT_MACHINE(10, 0)
>>  


