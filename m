Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82243C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQohv-0004tH-5F; Mon, 08 Jul 2024 09:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQohn-0004qT-FU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQohl-0008RK-KZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720446417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZYNNuqk86Qjz5ykdFCl7yYzVQ6X6y4DiiY0UaN1MpA=;
 b=WzSIBfH9uPUoE3d+v6LdmXaO1PvyGtGdZOjE5LiOjFsaiBqOBZ7UoQyxU4at8eNu18Za5W
 y+ipq++pA5Q/NbkJ1P1RmiNsyAlK0w3KHrzou+LRhuiHrBoEU+6yBcOSf8BonaUYZCz7Cz
 3lEqYYMm6rm2L+HZMzgM6f4h7L+2J7s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-jx_s-3lHN4CcsV3gufSP-Q-1; Mon, 08 Jul 2024 09:46:53 -0400
X-MC-Unique: jx_s-3lHN4CcsV3gufSP-Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77c539bfbcso277579466b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720446412; x=1721051212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZYNNuqk86Qjz5ykdFCl7yYzVQ6X6y4DiiY0UaN1MpA=;
 b=cxqIjlZLo9XYcaL6d4UpP+5vj8RoFWs+BLWiqBHDNYssZbz01WBJV4wllJQlnDuBuC
 I1NCS3Lom5waTQyTc5ThXMLwbL404+Y8O5/yRfqAqO92RFax0O0UAwHDpNVjmaRxaaIv
 TIkKqxJhV/Q1mWBimznM6d58g9Tjh6+Ff8S0AcIitDO8a8qJO8gl/Bl/hE0cgC/dYOtL
 tMDC2lSr1TiHy56P+JeZUXoRWDFSAZt+SE6+PsbWkBVjB0kWFaSRubPEtAZQ2bwSRsEU
 bZJyIq8WPC4yj01/KAughYY1EWdk+ZP3iuZTTifgbdj3aOp9Fz60Tgj+7sKPiS21GQOZ
 V21w==
X-Forwarded-Encrypted: i=1;
 AJvYcCViKs0+uHdB2KVE/PreIX8CMulrtOEr0uLJZ06MByzvOTGqeyGRnwK7hQj0/5PvtAeBlmAzqD+/ZX6EqE4HpGRIJDQ14ic=
X-Gm-Message-State: AOJu0YxuhMPMStPBKOhmMS3DfXiHxdMdJ3IbvNW5kBOcacKkewTbEmcc
 WpiJuNVLxLesh+A7h+U58+xCmyvKpsxOvU9AI+ToYUH9pr6cIqlVuv0ft6eVecpKgap8Y6YnDiG
 KUSTh/FOxbo+XWqChZY889VikKrKaAvFw19TNhNnrFiWrKhhbN7F2
X-Received: by 2002:a17:906:d183:b0:a6f:586b:6c2 with SMTP id
 a640c23a62f3a-a77ba70a6a1mr677321366b.60.1720446412161; 
 Mon, 08 Jul 2024 06:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEVhH0ib8soHBfHamjVA24xOrFyzTHNskmSGMO8bgjsZ0zMrCPJkEWzXSVmGxOQmsCwx5/xA==
X-Received: by 2002:a17:906:d183:b0:a6f:586b:6c2 with SMTP id
 a640c23a62f3a-a77ba70a6a1mr677318566b.60.1720446411633; 
 Mon, 08 Jul 2024 06:46:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab065672sm935582466b.136.2024.07.08.06.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 06:46:51 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:46:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 4/8] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <20240708154648.3aeab316@imammedo.users.ipa.redhat.com>
In-Reply-To: <4a092822-099c-4818-a0fc-1b9bb376b3c6@opnsrc.net>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-5-salil.mehta@huawei.com>
 <20240706162845.3baf5568@imammedo.users.ipa.redhat.com>
 <4a092822-099c-4818-a0fc-1b9bb376b3c6@opnsrc.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 8 Jul 2024 05:21:06 +0000
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hi Igor,
>=20
> On 06/07/2024 14:28, Igor Mammedov wrote:
> > On Fri, 7 Jun 2024 12:56:45 +0100
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> > =20
> >> OSPM evaluates _EVT method to map the event. The CPU hotplug event eve=
ntually
> >> results in start of the CPU scan. Scan figures out the CPU and the kin=
d of
> >> event(plug/unplug) and notifies it back to the guest. Update the GED A=
ML _EVT
> >> method with the call to \\_SB.CPUS.CSCN
> >>
> >> Also, macro CPU_SCAN_METHOD might be referred in other places like dur=
ing GED
> >> intialization so it makes sense to have its definition placed in some =
common
> >> header file like cpu_hotplug.h. But doing this can cause compilation b=
reak
> >> because of the conflicting macro definitions present in cpu.c and cpu_=
hotplug.c =20
> > one of the reasons is that you reusing legacy hw/acpi/cpu_hotplug.h,
> > see below for suggestion. =20
> ok
> > =20
> >> and because both these files get compiled due to historic reasons of x=
86 world
> >> i.e. decision to use legacy(GPE.2)/modern(GED) CPU hotplug interface h=
appens
> >> during runtime [1]. To mitigate above, for now, declare a new common m=
acro
> >> ACPI_CPU_SCAN_METHOD for CPU scan method instead.
> >> (This needs a separate discussion later on for clean-up)
> >>
> >> Reference:
> >> [1] https://lore.kernel.org/qemu-devel/1463496205-251412-24-git-send-e=
mail-imammedo@redhat.com/
> >>
> >> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Gavin Shan <gshan@redhat.com>
> >> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> >> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> >> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> >> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> >> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> >> ---
> >>   hw/acpi/cpu.c                  | 2 +-
> >>   hw/acpi/generic_event_device.c | 4 ++++
> >>   include/hw/acpi/cpu_hotplug.h  | 2 ++
> >>   3 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> >> index 473b37ba88..af2b6655d2 100644
> >> --- a/hw/acpi/cpu.c
> >> +++ b/hw/acpi/cpu.c
> >> @@ -327,7 +327,7 @@ const VMStateDescription vmstate_cpu_hotplug =3D {
> >>   #define CPUHP_RES_DEVICE  "PRES"
> >>   #define CPU_LOCK          "CPLK"
> >>   #define CPU_STS_METHOD    "CSTA"
> >> -#define CPU_SCAN_METHOD   "CSCN"
> >> +#define CPU_SCAN_METHOD   ACPI_CPU_SCAN_METHOD
> >>   #define CPU_NOTIFY_METHOD "CTFY"
> >>   #define CPU_EJECT_METHOD  "CEJ0"
> >>   #define CPU_OST_METHOD    "COST"
> >> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_de=
vice.c
> >> index 54d3b4bf9d..63226b0040 100644
> >> --- a/hw/acpi/generic_event_device.c
> >> +++ b/hw/acpi/generic_event_device.c
> >> @@ -109,6 +109,10 @@ void build_ged_aml(Aml *table, const char *name, =
HotplugHandler *hotplug_dev,
> >>                   aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINE=
R "."
> >>                                                MEMORY_SLOT_SCAN_METHOD=
));
> >>                   break;
> >> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> >> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
> >> +                                             ACPI_CPU_SCAN_METHOD)); =
=20
> > I don't particularly like exposing cpu hotplug internals for outside co=
de
> > and then making that code do plumbing hoping that nothing will explode
> > in the future. =20
>=20
> I understand your point but I've followed what was already existing.
>=20
> For example,
>=20
> build_dsdt()
>=20
> {
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
>=20
>  =C2=A0=C2=A0=C2=A0 acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (irqmap[VIRT_U=
ART] + ARM_SPI_BASE));
>  =C2=A0=C2=A0=C2=A0 if (vmc->acpi_expose_flash) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_dsdt_add_flash(scope, &m=
emmap[VIRT_FLASH]);
>  =C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0 fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
>  =C2=A0=C2=A0=C2=A0 virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base,=20
> memmap[VIRT_MMIO].size,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (i=
rqmap[VIRT_MMIO] + ARM_SPI_BASE),
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,=
 NUM_VIRTIO_TRANSPORTS);
>  =C2=A0=C2=A0=C2=A0 acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + =
ARM_SPI_BASE,=20
> vms);
>  =C2=A0=C2=A0=C2=A0 if (vms->acpi_dev) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_ged_aml(scope, "\\_SB."=
GED_DEVICE,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HOTPLUG_HANDLER(vms-=
>acpi_dev),
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irqmap[VIRT_ACPI_GED=
] + ARM_SPI_BASE,=20
> AML_SYSTEM_MEMORY,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memmap[VIRT_ACPI_GED=
].base);
>  =C2=A0=C2=A0=C2=A0 } else {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_dsdt_add_gpio(scope, &me=
mmap[VIRT_GPIO],
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>  =C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
>=20
> }
>=20
> Refactoring all of this code will create a noise in this patch-set.
> > build_cpus_aml() takes event_handler_method to create a method that
> > can be called by platform. What I suggest is to call that method here
> > instead of trying to expose CPU hotplug internals and manually building
> > call path here.
> > aka:
> >    build_cpus_aml(event_handler_method =3D PATH_TO_GED_DEVICE.CSCN)
> > and then call here
> >    aml_append(if_ctx, aml_call0(CSCN));
> > which will call  CSCN in GED scope, that was be populated by
> > build_cpus_aml() to do cpu scan properly without need to expose
> > cpu hotplug internal names and then trying to fixup conflicts caused by=
 that.
> >
> > PS:
> > we should do the same for memory hotplug, we see in context above
> > =20
> Although. I agree with your suggested change but I think this should be
>=20
> carried in another patch-set.

I have to disagree with another patch-set on top as it introduces
unnecessary code changes, wich 'another patch-set' will put back.
(talking specifically about CPU hotplug)

Not to mention doing as it was suggested should reduce size of
your series and overall complexity.

>=20
> Best, Salil.
>=20
> > =20
> >> +                break;
> >>               case ACPI_GED_PWR_DOWN_EVT:
> >>                   aml_append(if_ctx,
> >>                              aml_notify(aml_name(ACPI_POWER_BUTTON_DEV=
ICE),
> >> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotpl=
ug.h
> >> index 48b291e45e..ef631750b4 100644
> >> --- a/include/hw/acpi/cpu_hotplug.h
> >> +++ b/include/hw/acpi/cpu_hotplug.h
> >> @@ -20,6 +20,8 @@
> >>   #include "hw/acpi/cpu.h"
> >>  =20
> >>   #define ACPI_CPU_HOTPLUG_REG_LEN 12
> >> +#define ACPI_CPU_SCAN_METHOD "CSCN"
> >> +#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
> >>  =20
> >>   typedef struct AcpiCpuHotplug {
> >>       Object *device; =20
>=20


