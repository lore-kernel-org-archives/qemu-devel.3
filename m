Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1411C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPH9F-00010G-Nd; Wed, 11 Jun 2025 04:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPH9D-0000zy-5n
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPH9B-00057e-Ba
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749631762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXcFn0ZtApWQfoXTCpm0D9O5l7K3NG1NHyLY/dvsC9w=;
 b=LhsURp7tGfTCaMAuBvm6rbqR6S1S+4XnXWiqXfsW6c6rFLQ+9rQP+Adjxs943RusUSuLAF
 I6SyhfzqnYuCTrYxIBbPInxlLpgjRISgKcgUt5f1ni0WLhrpysC0pAgEEw3p77GIOnIZA8
 bnQME6RrrV2JZz4u24Bp40WmD/UQyDk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-ATf43mAaONu-sujDzF3ERg-1; Wed, 11 Jun 2025 04:49:19 -0400
X-MC-Unique: ATf43mAaONu-sujDzF3ERg-1
X-Mimecast-MFC-AGG-ID: ATf43mAaONu-sujDzF3ERg_1749631758
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so2801416f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 01:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749631758; x=1750236558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXcFn0ZtApWQfoXTCpm0D9O5l7K3NG1NHyLY/dvsC9w=;
 b=rgsIuood/z5v2acPE/RkCPAKJmwAkqB5NOWw7lchN5+NHHKQ+VT30IQS3+Qs2IloyE
 xAVxt+F846UGAWADTomy7DnFBYfg7WDjcSHbq1TPNymO6CS6DEpjr0zg1eDQPfxkc+1W
 RE6UXz95PTn2J5hQgP4v1el2YFO57Ma638RKH5greDmXBa+rTnJpvcg+F5XZFgr6UM9n
 kZ87OXaOJQjiJo1C7Veto5OsO4SGtWvQe8MZB0qN9Jc7LyUew+Qb7i76Xxcu9TFO/5Z/
 RnekhrE21IY+j0snmKAtFjq9nvyW6yk8XeyiFIJRK5g3l4ugiXa5IUj0mG4bws9Q/EWO
 n3jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa6d7xyDjLHFq/tohwviob4g5j/gOTTSmwPRg6YocCBCb3TucG4ZQzvch6R0Cd415F4LQaEV402gbA@nongnu.org
X-Gm-Message-State: AOJu0YzmiROO5TeLBmAJooVls97HPygbrppNUiB5zaoVa66uersuzaBh
 Sowz8R8Zq540YfsiaJoDQ7YkNynsXEjb4PYy9yelPkCW6mcWpJZhqrGp0EmV0KlHDrAcqXdmMk5
 ofQcNBkHoYIStwP4/cnZTb1M9eH9GZVDw/taR2NLSiEN11QnBVAC2qMcA
X-Gm-Gg: ASbGncs2NhS2tA/fkwRUC+tcwlmNHMmYlIxZuzPzQFeL1f5dwbeeZlQGsbqDWFpyH2Z
 349CkkP9PmdY3M0syQZq5vG+hzkdpIbXXwSj6uuoGSaS2Y0s+a16+iy0t07zrL//52zr1RPrW/2
 xzcfxXuq3N6I6/c5fqTYRGu19VqUuwXOYEdt9v0IskMYIji9r1n70vzYK4XfEhTVXf8qPQbFqty
 H8ran5RpXEvF5FGPAFSrqWx84pjklbMrtAN0svdAi40/jVbJFSHueH33aRLbTfcjqZ81ehqHz9L
 jg5RdUZo1DtvEetyeGNTHbKWSMg4J1sMr23HhdYitR4=
X-Received: by 2002:a5d:5271:0:b0:3a4:f90c:31e3 with SMTP id
 ffacd0b85a97d-3a558acbd57mr1199082f8f.31.1749631757687; 
 Wed, 11 Jun 2025 01:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmGfDKa+s0Gzvm55+sdNbZuN2KkzEKle/gNnevki7I1c0wKyNDX5Fpz7/nufqs9ihZ2i+IDw==
X-Received: by 2002:a5d:5271:0:b0:3a4:f90c:31e3 with SMTP id
 ffacd0b85a97d-3a558acbd57mr1199059f8f.31.1749631757224; 
 Wed, 11 Jun 2025 01:49:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229d9e9sm14806339f8f.13.2025.06.11.01.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 01:49:16 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:49:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 02/25] hw/arm/virt: Introduce machine state acpi
 pcihp flags and props
Message-ID: <20250611104915.5a5a2bea@imammedo.users.ipa.redhat.com>
In-Reply-To: <6374e8f1-8eee-49cb-9c7f-75aaed1a0f08@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-3-eric.auger@redhat.com>
 <20250527135813.2d6cde91@imammedo.users.ipa.redhat.com>
 <6374e8f1-8eee-49cb-9c7f-75aaed1a0f08@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 11 Jun 2025 08:47:36 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 5/27/25 1:58 PM, Igor Mammedov wrote:
> > On Tue, 27 May 2025 09:40:04 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  
> >> acpi_pcihp VirtMachineClass state flag will allow
> >> to opt in for acpi pci hotplug. This is guarded by a
> >> class no_acpi_pcihp flag to manage compats (<= 10.0
> >> machine types will not support ACPI PCI hotplug).  
> > there is no reason to put an effort in force disabling it
> > on old machines, as long as code works when explicitly
> > enabled property on CLI.
> >
> > See comment below on how to deal with it 
> >  
> >> Machine state acpi_pcihp flag must be set before the creation
> >> of the GED device which will use it.
> >>
> >> Currently the ACPI PCI HP is turned off by default. This will
> >> change later on for 10.1 machine type.  
> > one thing to note, is that turning it on by default might
> > cause change of NIC naming in guest as this brings in
> > new "_Sxx" slot naming. /so configs tied to nic  go down the drain/
> >
> > Naming, we have, also happens to be broken wrt spec
> > (it should be unique system wide, there was a gitlab issue for that,
> > there is no easy fix that though)
> >
> > So I'd leave it disabled by default and let users to turn
> > it on explicitly when needed. 
> >  
> >> We also introduce properties to allow disabling it.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> >> ---
> >>  include/hw/arm/virt.h |  2 ++
> >>  hw/arm/virt.c         | 27 +++++++++++++++++++++++++++
> >>  2 files changed, 29 insertions(+)
> >>
> >> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> >> index 9a1b0f53d2..10ea581f06 100644
> >> --- a/include/hw/arm/virt.h
> >> +++ b/include/hw/arm/virt.h
> >> @@ -129,6 +129,7 @@ struct VirtMachineClass {
> >>      bool no_tcg_lpa2;
> >>      bool no_ns_el2_virt_timer_irq;
> >>      bool no_nested_smmu;
> >> +    bool no_acpi_pcihp;
> >>  };
> >>  
> >>  struct VirtMachineState {
> >> @@ -150,6 +151,7 @@ struct VirtMachineState {
> >>      bool mte;
> >>      bool dtb_randomness;
> >>      bool second_ns_uart_present;
> >> +    bool acpi_pcihp;
> >>      OnOffAuto acpi;
> >>      VirtGICType gic_version;
> >>      VirtIOMMUType iommu;
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index 9a6cd085a3..a0deeaf2b3 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -2397,8 +2397,10 @@ static void machvirt_init(MachineState *machine)
> >>      create_pcie(vms);
> >>  
> >>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
> >> +        vms->acpi_pcihp &= !vmc->no_acpi_pcihp;  
> > I don't particularly like no_foo naming as it makes code harder to read
> > and combined with 'duplicated' field in machine state it make even things worse.
> > (if I recall right Philippe was cleaning mess similar flags usage
> > have introduced with ITS)
> >
> > instead of adding machine property (both class and state),
> > I'd suggest adding the only property to GPE device (akin to what we have in x86 world)
> > And then one can meddle with defaults using hw_compat_xxx  
> What I fail to understand is whether you want me to attach this property
> to the GPEX host bridge device or to the GED device. Comment on patch

I'd say GED.

> 6/25 seems to indicate you expect it to be attached to the GPEX. I ask
> here because also the GED device will need to be configured depending on
> the hp setting. Maybe we can retrieve the info from the gpex at that
> time. on x86 it is attached to piix4 or ich9 I/O controller hub which do
> not have direct equivalent on ARM.

for ARM, equivalent would be GED device which hosts our paravirt acpi registers.

> 
> Thanks
> 
> Eric
> >
> >  
> >>          vms->acpi_dev = create_acpi_ged(vms);
> >>      } else {
> >> +        vms->acpi_pcihp = false;
> >>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
> >>      }
> >>  
> >> @@ -2593,6 +2595,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
> >>      vms->its = value;
> >>  }
> >>  
> >> +static bool virt_get_acpi_pcihp(Object *obj, Error **errp)
> >> +{
> >> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> >> +
> >> +    return vms->acpi_pcihp;
> >> +}
> >> +
> >> +static void virt_set_acpi_pcihp(Object *obj, bool value, Error **errp)
> >> +{
> >> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> >> +
> >> +    vms->acpi_pcihp = value;
> >> +}
> >> +
> >>  static bool virt_get_dtb_randomness(Object *obj, Error **errp)
> >>  {
> >>      VirtMachineState *vms = VIRT_MACHINE(obj);
> >> @@ -3310,6 +3326,10 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
> >>                                            "in ACPI table header."
> >>                                            "The string may be up to 8 bytes in size");
> >>  
> >> +    object_class_property_add_bool(oc, "acpi-pcihp",
> >> +                                   virt_get_acpi_pcihp, virt_set_acpi_pcihp);
> >> +    object_class_property_set_description(oc, "acpi-pcihp",
> >> +                                          "Force ACPI PCI hotplug");
> >>  }
> >>  
> >>  static void virt_instance_init(Object *obj)
> >> @@ -3344,6 +3364,9 @@ static void virt_instance_init(Object *obj)
> >>          vms->tcg_its = true;
> >>      }
> >>  
> >> +    /* default disallows ACPI PCI hotplug */
> >> +    vms->acpi_pcihp = false;
> >> +
> >>      /* Default disallows iommu instantiation */
> >>      vms->iommu = VIRT_IOMMU_NONE;
> >>  
> >> @@ -3394,8 +3417,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
> >>  
> >>  static void virt_machine_10_0_options(MachineClass *mc)
> >>  {
> >> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> >> +
> >>      virt_machine_10_1_options(mc);
> >>      compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
> >> +    /* 10.0 and earlier do not support ACPI PCI hotplug */
> >> +    vmc->no_acpi_pcihp = true;
> >>  }
> >>  DEFINE_VIRT_MACHINE(10, 0)
> >>    
> 


