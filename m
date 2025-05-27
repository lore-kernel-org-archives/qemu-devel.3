Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F235C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJswv-00007B-DW; Tue, 27 May 2025 07:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJswt-00006P-Vw
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJswp-0004PG-8Y
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748347099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHqXEgaQTrxB4IKRGQZjKBkcdlkshcKYt4h4/GTe1W4=;
 b=H7I0mAEN1BvzzdjV99PjOF8rb4PFeMx/5nlo+YaE3UtfwmnoNH7BTyGcX92uceVrqUTA+P
 N4z02PgNU6LciYScRCGFk7bjEqU5Hb84b6mEWw2qI+1wjT9+yfEqCaGRx3SJmjUWLvGryN
 HQjjbgox36/RkvvpsgidHaIkwPguwxY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-2uzNu-ZqND-zPMw10D06jQ-1; Tue, 27 May 2025 07:58:17 -0400
X-MC-Unique: 2uzNu-ZqND-zPMw10D06jQ-1
X-Mimecast-MFC-AGG-ID: 2uzNu-ZqND-zPMw10D06jQ_1748347096
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a360d01518so2142513f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 04:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748347096; x=1748951896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dHqXEgaQTrxB4IKRGQZjKBkcdlkshcKYt4h4/GTe1W4=;
 b=Wa7Ik+bd9XMGPujZB92RXT2YyI68xsnHEJc1BCB6e+/klqjgzJ4oZX3Fxe7adHs+7a
 6xr9blOAzh1KgTwTEaLEUOtOkvE/+SBspnQae8LgmQ6VqwNxIAjzUJCmU1wGx+5orvr6
 BJC+4X4b4gUSvcNHfVhKdQITxCLrH8sbRZ4xnB+J5Eut5a5TjEIhv4zUgtv4loujwN35
 MFsxEZvzMgomQMDA4/saunFNtJHtDsBqSYt+0CASsQDz+F7GIbhWP+bVQnF7mt/u93L2
 +neXoW47x9M5gZv+gaoPS+GKyPDediG4eeyHYa+kx0IlV/KKIc/27hZ001cQRhs152WM
 FZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMC2+ShsFIM6y4IhJSn4nhXJr+LNRMi9OSrW316RvG455YvYhmtEr0nYDIrPNrcTn+CQstaauF/RMI@nongnu.org
X-Gm-Message-State: AOJu0YzxXwobVZ8ZMDNrQBfA5kcM6PCOpgoYVb6ZWJtXMSCL5A9cbvqE
 qrmHN4RmXEJULyQoNaHuWo0eX5WJvvDr/q0DbM64Bs0gw+croRhgv5u5iOcigNN7QNnIYc3AIK3
 K4z24T5Ni7iJ1bUckC7VYsfMU+nACItvmM0r9EFKqFTxRqrZpJYtvHVH+
X-Gm-Gg: ASbGncsRugnWGObSXcV3DYu//4DiAwE5bDZoneteDY81x2CBl2CEXmG1meZbjBGJMZr
 NeXqwHoTPyp6IOI65Mz9sfwaa+04adyS0MdU9rImGwDVY2E4HWG4oiN8GpkAE5DiBrfEb4KSoLl
 lfVqNmsZyt9aC2qdjwrn4PBQ0MmYNjv+w9SmscnVjjHEeWV6ZC9mF+4vDIne0oDj1iZbWH9YbTs
 KZc36roDj+JWox0fnE7lkeMuT01GOxCBqLWdbLtePC7GZdEi2MWmTVtsqw+kdBlxdXaUfzpyBXu
 aGgTKaZvISHZWQPkh9UXm/1VReWpv7N1
X-Received: by 2002:a05:6000:26c9:b0:3a4:de02:208 with SMTP id
 ffacd0b85a97d-3a4de0204a6mr3238324f8f.25.1748347096457; 
 Tue, 27 May 2025 04:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg2S45A0q+Bkz6bjGpepTsVbPjp5Zk/wfFuxEcNt+w+HiMdX/WfpqNoLTrLej+kFaLGreMVg==
X-Received: by 2002:a05:6000:26c9:b0:3a4:de02:208 with SMTP id
 ffacd0b85a97d-3a4de0204a6mr3238291f8f.25.1748347096010; 
 Tue, 27 May 2025 04:58:16 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d6c9faffsm6715489f8f.74.2025.05.27.04.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 04:58:15 -0700 (PDT)
Date: Tue, 27 May 2025 13:58:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi
 pcihp flags and props
Message-ID: <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-3-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-3-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 27 May 2025 09:40:04 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> acpi_pcihp VirtMachineClass state flag will allow
> to opt in for acpi pci hotplug. This is guarded by a

> class no_acpi_pcihp flag to manage compats (<= 10.0
> machine types will not support ACPI PCI hotplug).

there is no reason to put an effort in force disabling it
on old machines, as long as code works when explicitly
enabled property on CLI.

See comment below on how to deal with it 

> 
> Machine state acpi_pcihp flag must be set before the creation
> of the GED device which will use it.
> 
> Currently the ACPI PCI HP is turned off by default. This will
> change later on for 10.1 machine type.

one thing to note, is that turning it on by default might
cause change of NIC naming in guest as this brings in
new "_Sxx" slot naming. /so configs tied to nic  go down the drain/

Naming, we have, also happens to be broken wrt spec
(it should be unique system wide, there was a gitlab issue for that,
there is no easy fix that though)

So I'd leave it disabled by default and let users to turn
it on explicitly when needed. 

> 
> We also introduce properties to allow disabling it.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  include/hw/arm/virt.h |  2 ++
>  hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 9a1b0f53d2..10ea581f06 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -129,6 +129,7 @@ struct VirtMachineClass {
>      bool no_tcg_lpa2;
>      bool no_ns_el2_virt_timer_irq;
>      bool no_nested_smmu;
> +    bool no_acpi_pcihp;
>  };
>  
>  struct VirtMachineState {
> @@ -150,6 +151,7 @@ struct VirtMachineState {
>      bool mte;
>      bool dtb_randomness;
>      bool second_ns_uart_present;
> +    bool acpi_pcihp;
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a3..a0deeaf2b3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState *machine)
>      create_pcie(vms);
>  
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;

I don't particularly like no_foo naming as it makes code harder to read
and combined with 'duplicated' field in machine state it make even things worse.
(if I recall right Philippe was cleaning mess similar flags usage
have introduced with ITS)

instead of adding machine property (both class and state),
I'd suggest adding the only property to GPE device (akin to what we have in x86 world)
And then one can meddle with defaults using hw_compat_xxx


>          vms->acpi_dev = create_acpi_ged(vms);
>      } else {
> +        vms->acpi_pcihp = false;
>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
>  
> @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>      vms->its = value;
>  }
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
>  static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
> @@ -3310,6 +3326,10 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>                                            "in ACPI table header."
>                                            "The string may be up to 8 bytes in size");
>  
> +    object_class_property_add_bool(oc, "acpi-pcihp",
> +                                   virt_get_acpi_pcihp, virt_set_acpi_pcihp);
> +    object_class_property_set_description(oc, "acpi-pcihp",
> +                                          "Force ACPI PCI hotplug");
>  }
>  
>  static void virt_instance_init(Object *obj)
> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
>          vms->tcg_its = true;
>      }
>  
> +    /* default disallows ACPI PCI hotplug */
> +    vms->acpi_pcihp = false;
> +
>      /* Default disallows iommu instantiation */
>      vms->iommu = VIRT_IOMMU_NONE;
>  
> @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
>  
>  static void virt_machine_10_0_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_10_1_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
> +    vmc->no_acpi_pcihp = true;
>  }
>  DEFINE_VIRT_MACHINE(10, 0)
>  


