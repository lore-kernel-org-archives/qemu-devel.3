Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CE6C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 13:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPhYG-0005Sl-2X; Thu, 12 Jun 2025 09:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPhXd-0005NQ-Al
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPhXQ-0003Bk-Kr
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749733209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHsAQntFVcsIBCOhWYVLQYkuOn7X5zgs+z7Sw3eNENs=;
 b=AxfkqPEdGtieVa1yHv8TDrStIr1mJEXaY4w94oZZ3IVtTIdM3B82OMxQQU4asNXRuym/TO
 Pk4iIg/kvEXWUOw39KDBBQv+IlZ5dG+V9cURdESW61DPB98lPeQcmLc07SaTUZdwcgHS/M
 x7Q2+fkpfHd3dBTCLqFxUHsnNwCB5T4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-45o4sRQvOJiZo3T6EeRk2Q-1; Thu, 12 Jun 2025 09:00:07 -0400
X-MC-Unique: 45o4sRQvOJiZo3T6EeRk2Q-1
X-Mimecast-MFC-AGG-ID: 45o4sRQvOJiZo3T6EeRk2Q_1749733205
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso583106f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 06:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749733205; x=1750338005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHsAQntFVcsIBCOhWYVLQYkuOn7X5zgs+z7Sw3eNENs=;
 b=lykTfQ/ARE/fH/h7cmyrPhyCDl76h+BCx2kajPby48ExzFOmyw5Um11uFQfq5Tk3vz
 MRpRmX75dBFRje6j7tOnfBcJsVkypWIPH0REpHentpeNvT4rMe1F4m5KAx+3ZjVtFrbI
 twXc8qavgTaVAIQxod1cFCH9VeYVsFoydjlqv/TJTNWYEFdEwbwr3WiTFEMqZczwfsNS
 yHLK3uxAHwPCaVCxfBOL9gV6uw4d05Ifhd9cKmgt1UeqHpPudbQt2jTyPlGjgqCAb80k
 9J/uoZnvqcKCMmmICr6A0sKx9XLxGfJzIUdnhaAmQqFFXPDYmg6dtjMY38taziib5Irk
 /9+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHTpj/uvgyP03I5IjZDCfSJ9JzxgFoQdM8IDJNZ6Mnuqn/Op36RjUvgSomCu33KYJWeCCsxesm6eCw@nongnu.org
X-Gm-Message-State: AOJu0Yzgu4yahNYu60d4cLD9FOOpgBBHyOcCB4vAKKAnTCV3Wd7MAloA
 1Yg3DlSyJbd9Q5rTEhafMuhrJqDSNKw6zpoJLz0q37wnHBCtokUrUlCU9VULxdFKuNCqyE4mXuq
 GeccYpBNXESPquS9H+5sPYlxXFbu45iiX+6ZzExlACLKFwOTtg2W5AiMb
X-Gm-Gg: ASbGnctUDnuF1eH6sziugXp7YUhnWTW0rGItkpJHPqVHT4t63nIMT6gOQj46iOTuFJR
 nar9bQj+cqSfDuVsRi6ECJekTQZ2+04djuOUKxB1lzH59T8skeOyuKQkaJPBxI/e09q7QQovPGc
 34XR/fd5HzFKDrVa9poJWcpnYUIH8+k22Z/gNHziII368w4VRDWNGQAr1o0DnsuheFi/ACWV4ZQ
 d37EAiCqNDj73Q9SPQqfUe4WNqpoFNfwFFAO8a4Gs/IjVvI41m2sqootwoQ6jV7xgjxnirptRS1
 18nOrtBu7dPZyjk8UH+/w+ZVX/QWXPZCCK6lYEdDEgY=
X-Received: by 2002:a05:6000:1a86:b0:3a5:2923:8006 with SMTP id
 ffacd0b85a97d-3a5587fe1f6mr5968711f8f.25.1749733204741; 
 Thu, 12 Jun 2025 06:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBhJxpu2Pc7TE1nkGz7+57w8v9KEBSJzCGz76A/dBLEnOeoEv1QR4Lz9fojkDv5fs4m3jeQQ==
X-Received: by 2002:a05:6000:1a86:b0:3a5:2923:8006 with SMTP id
 ffacd0b85a97d-3a5587fe1f6mr5968663f8f.25.1749733203954; 
 Thu, 12 Jun 2025 06:00:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a56198f827sm1901683f8f.29.2025.06.12.06.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 06:00:03 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:00:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi
 pcihp flags and props
Message-ID: <20250612150002.6bd9b330@imammedo.users.ipa.redhat.com>
In-Reply-To: <b0be20a1-6b7f-4a0a-a228-b2f0eaca88e1@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-3-eric.auger@redhat.com>
 <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
 <6374e8f1-8eee-49cb-9c7f-75aaed1a0f08@redhat.com>
 <20250611104915.5a5a2bea@imammedo.users.ipa.redhat.com>
 <b0be20a1-6b7f-4a0a-a228-b2f0eaca88e1@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 11 Jun 2025 10:56:36 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> On 6/11/25 10:49 AM, Igor Mammedov wrote:
> > On Wed, 11 Jun 2025 08:47:36 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> > =20
> >> Hi Igor,
> >>
> >> On 5/27/25 1:58 PM, Igor Mammedov wrote: =20
> >>> On Tue, 27 May 2025 09:40:04 +0200
> >>> Eric Auger <eric.auger@redhat.com> wrote:
> >>>   =20
> >>>> acpi_pcihp VirtMachineClass state flag will allow
> >>>> to opt in for acpi pci hotplug. This is guarded by a
> >>>> class no_acpi_pcihp flag to manage compats (<=3D 10.0
> >>>> machine types will not support ACPI PCI hotplug).   =20
> >>> there is no reason to put an effort in force disabling it
> >>> on old machines, as long as code works when explicitly
> >>> enabled property on CLI.
> >>>
> >>> See comment below on how to deal with it=20
> >>>   =20
> >>>> Machine state acpi_pcihp flag must be set before the creation
> >>>> of the GED device which will use it.
> >>>>
> >>>> Currently the ACPI PCI HP is turned off by default. This will
> >>>> change later on for 10.1 machine type.   =20
> >>> one thing to note, is that turning it on by default might
> >>> cause change of NIC naming in guest as this brings in
> >>> new "_Sxx" slot naming. /so configs tied to nic  go down the drain/
> >>>
> >>> Naming, we have, also happens to be broken wrt spec
> >>> (it should be unique system wide, there was a gitlab issue for that,
> >>> there is no easy fix that though)
> >>>
> >>> So I'd leave it disabled by default and let users to turn
> >>> it on explicitly when needed.=20
> >>>   =20
> >>>> We also introduce properties to allow disabling it.
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> >>>> ---
> >>>>  include/hw/arm/virt.h |  2 ++
> >>>>  hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
> >>>>  2 files changed, 29 insertions(+)
> >>>>
> >>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> >>>> index 9a1b0f53d2..10ea581f06 100644
> >>>> --- a/include/hw/arm/virt.h
> >>>> +++ b/include/hw/arm/virt.h
> >>>> @@ -129,6 +129,7 @@ struct VirtMachineClass {
> >>>>      bool no_tcg_lpa2;
> >>>>      bool no_ns_el2_virt_timer_irq;
> >>>>      bool no_nested_smmu;
> >>>> +    bool no_acpi_pcihp;
> >>>>  };
> >>>> =20
> >>>>  struct VirtMachineState {
> >>>> @@ -150,6 +151,7 @@ struct VirtMachineState {
> >>>>      bool mte;
> >>>>      bool dtb_randomness;
> >>>>      bool second_ns_uart_present;
> >>>> +    bool acpi_pcihp;
> >>>>      OnOffAuto acpi;
> >>>>      VirtGICType gic_version;
> >>>>      VirtIOMMUType iommu;
> >>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>>> index 9a6cd085a3..a0deeaf2b3 100644
> >>>> --- a/hw/arm/virt.c
> >>>> +++ b/hw/arm/virt.c
> >>>> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState *machi=
ne)
> >>>>      create_pcie(vms);
> >>>> =20
> >>>>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabl=
ed(vms)) {
> >>>> +        vms->acpi_pcihp &=3D !vmc->no_acpi_pcihp;   =20
> >>> I don't particularly like no_foo naming as it makes code harder to re=
ad
> >>> and combined with 'duplicated' field in machine state it make even th=
ings worse.
> >>> (if I recall right Philippe was cleaning mess similar flags usage
> >>> have introduced with ITS)
> >>>
> >>> instead of adding machine property (both class and state),
> >>> I'd suggest adding the only property to GPE device (akin to what we h=
ave in x86 world)
> >>> And then one can meddle with defaults using hw_compat_xxx   =20
> >> What I fail to understand is whether you want me to attach this proper=
ty
> >> to the GPEX host bridge device or to the GED device. Comment on patch =
=20
> > I'd say GED.
> > =20
> >> 6/25 seems to indicate you expect it to be attached to the GPEX. I ask
> >> here because also the GED device will need to be configured depending =
on
> >> the hp setting. Maybe we can retrieve the info from the gpex at that
> >> time. on x86 it is attached to piix4 or ich9 I/O controller hub which =
do
> >> not have direct equivalent on ARM. =20
> > for ARM, equivalent would be GED device which hosts our paravirt acpi r=
egisters. =20
>=20
> OK thank you for the clarification. I will add a property to the GED devi=
ce.
>=20
> As the GED device is directly instantiated by the virt machine code (not
> exposed to the end user CLI) I guess we still want a virt machine option
> that would allow to set the property explicitly from CLI?

Instead of machine option,
I'd go pc/q35 way (aka -global ged.acpi-pci-hotplug-with-bridges=3Don/off).
it's not as pretty as machine specific option but that would work just as w=
ell
and as bonus could be used for microvm in the same form.

>=20
> Thanks
>=20
> Eric =C2=A0
> > =20
> >> Thanks
> >>
> >> Eric =20
> >>>   =20
> >>>>          vms->acpi_dev =3D create_acpi_ged(vms);
> >>>>      } else {
> >>>> +        vms->acpi_pcihp =3D false;
> >>>>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
> >>>>      }
> >>>> =20
> >>>> @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj, bool va=
lue, Error **errp)
> >>>>      vms->its =3D value;
> >>>>  }
> >>>> =20
> >>>> +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
> >>>> +{
> >>>> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> >>>> +
> >>>> +    return vms->acpi_pcihp;
> >>>> +}
> >>>> +
> >>>> +static void virt_set_acpi_pcihp(Object *obj, bool value, Error **er=
rp)
> >>>> +{
> >>>> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> >>>> +
> >>>> +    vms->acpi_pcihp =3D value;
> >>>> +}
> >>>> +
> >>>>  static bool virt_get_dtb_randomness(Object *obj, Error **errp)
> >>>>  {
> >>>>      VirtMachineState *vms =3D VIRT_MACHINE(obj);
> >>>> @@ -3310,6 +3326,10 @@ static void virt_machine_class_init(ObjectCla=
ss *oc, const void *data)
> >>>>                                            "in ACPI table header."
> >>>>                                            "The string may be up to =
8 bytes in size");
> >>>> =20
> >>>> +    object_class_property_add_bool(oc, "acpi-pcihp",
> >>>> +                                   virt_get_acpi_pcihp, virt_set_ac=
pi_pcihp);
> >>>> +    object_class_property_set_description(oc, "acpi-pcihp",
> >>>> +                                          "Force ACPI PCI hotplug");
> >>>>  }
> >>>> =20
> >>>>  static void virt_instance_init(Object *obj)
> >>>> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
> >>>>          vms->tcg_its =3D true;
> >>>>      }
> >>>> =20
> >>>> +    /* default disallows ACPI PCI hotplug */
> >>>> +    vms->acpi_pcihp =3D false;
> >>>> +
> >>>>      /* Default disallows iommu instantiation */
> >>>>      vms->iommu =3D VIRT_IOMMU_NONE;
> >>>> =20
> >>>> @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
> >>>> =20
> >>>>  static void virt_machine_10_0_options(MachineClass *mc)
> >>>>  {
> >>>> +    VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> >>>> +
> >>>>      virt_machine_10_1_options(mc);
> >>>>      compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10=
_0_len);
> >>>> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
> >>>> +    vmc->no_acpi_pcihp =3D true;
> >>>>  }
> >>>>  DEFINE_VIRT_MACHINE(10, 0)
> >>>>     =20
>=20


