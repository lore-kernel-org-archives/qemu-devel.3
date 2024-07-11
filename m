Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB12EC3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpFo-000686-1h; Thu, 11 Jul 2024 04:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRpFl-0005zs-TU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRpFj-0003eo-JO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720686850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgRGGHIvVigTmy/ErLoS/r17TRefdo47N3uPDdzUXM4=;
 b=Rg3WXIOaJONOwZcKXEyGQ1KluHRo8RtkdUGXqIPdKWhsYyOgoj1ZTLAc2E2dcmLnFyGPpQ
 VDx3UV/2zUI7iF1yKhVAy0M3wtC8tOoI6tq8Bnd+YSsbfiPqbq3K1WmnQK0i1o7hFHUTRQ
 W2AtaI44as4w69aX/aTr412ZemoOiaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-f-ySM1zVPXqGMDuC_z_49A-1; Thu, 11 Jul 2024 04:34:07 -0400
X-MC-Unique: f-ySM1zVPXqGMDuC_z_49A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42668699453so5152975e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 01:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720686847; x=1721291647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgRGGHIvVigTmy/ErLoS/r17TRefdo47N3uPDdzUXM4=;
 b=riGEyFRkw1cArh95Q/Luj5ggANbf8YB58HWLu4PeMkzCMQTwoGrx/Vs0f5G9k76KC6
 3pEiM2GowUnfIK07JVHSHWl82menUyaPSgGUFQT0mmdVm/Io0sORqm3nJUzV+OwS6QPE
 41vmDk4xu8a2t93DygcAVAiJXFdIz+KAeA/McmOdQXeCNN2bGz41gqaW35WFFeEAt77b
 z8nxJ1XqzgyuW6Zlj8cgTsko9Q9u/seXe5KLfU5yTtb0rghRg6Sm5/x+T8RGQXlZQypZ
 JTgQDcWu+gd1k1WmtSVYhCYDR1LG6m7hcntDu37d+V0Yh2Eo8IuEQOMsv9imXEQd+Hnb
 X6EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCHz5LweK9lO8mhx4eJAw3oio8Ite44vL1+q0zsjqOMArKR5GU3pVwcrtAFk3lUGUNYqJdAcU7Asf5+hZAB7QI7OF1THU=
X-Gm-Message-State: AOJu0YwFHtTZAOD5eSXKdogutMe272flCqNCMI1psRcZRhakBJy0oJNm
 +PvOARjt4uoR90g/ubK6iHdYx70dG+oLeagsM/Iqapi2B4VG8FgKdXSNYInlxbpVkCuTOygXh8v
 MvVmuFELsVVQ/kgMgFP8fjdHUQzdoG6EG/4cFaVw6qwIHp0K4Ew3q
X-Received: by 2002:a05:600c:4baa:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-426706c656bmr73092895e9.8.1720686846704; 
 Thu, 11 Jul 2024 01:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3am/0Rj4wTofQHhYOkBEa9hLzsr4rCVa0tGWMHu2k3f3puBErjYBUafz62to07W6/7R+WOw==
X-Received: by 2002:a05:600c:4baa:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-426706c656bmr73092455e9.8.1720686846217; 
 Thu, 11 Jul 2024 01:34:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279484a9d9sm54403965e9.5.2024.07.11.01.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 01:34:05 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:34:03 +0200
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
Message-ID: <20240711103403.2eadac1e@imammedo.users.ipa.redhat.com>
In-Reply-To: <27cc0420-df0b-481e-a58f-e17fa4d02367@opnsrc.net>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-5-salil.mehta@huawei.com>
 <20240706162845.3baf5568@imammedo.users.ipa.redhat.com>
 <27cc0420-df0b-481e-a58f-e17fa4d02367@opnsrc.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 11 Jul 2024 03:29:40 +0000
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hi Igor,
>=20
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
> > see below for suggestion.
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
> > in the future.
> >
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
> > we should do the same for memory hotplug, we see in context above =20
>=20
> In the x86 world and ARM, two different types of event handling=20
> mechanisms are
> used: one based on GPE and the other on GED. The latter has its own=20
> placeholder
> within the generic_event_device.c file, which also multiplexes other GED=
=20
> events.
> Multiplexing AMLs for two different types of handlers into=20
> build_cpus_aml() seems
> to be a fundamental mistake here. For CPU handling, this should also not=
=20
> be done
> because x86 deals with legacy hotplug and modern hotplug differently but=
=20
> still
> uses the same GPE-based event handling for both. Moreover, which type of=
=20
> handler
> should be used depends upon the context from which build_cpus_aml() is=20
> called
> and it would be ugly to demultiplex these inside the build_cpus_aml() cod=
e.
>
> Therefore, my suggestion is:
> 1. Keep the CPU=E2=80=99s _EVT handling code in the generic_event_device.=
c as it is.
> 2. Pull out the event handler method and CPU scan call-related=20
> initialization entirely
>  =C2=A0=C2=A0=C2=A0 out of the CPU=E2=80=99s AML code (i.e., both in buil=
d_cpus_aml() and=20
> build_legacy_cpu_hotplug_aml()).
> 3. Remove the input parameter of event_handler in build_cpus_aml().
> 4. Create a separate function like build_gpe_aml() and use this function=
=20
> in the
>  =C2=A0 =C2=A0=C2=A0 following places:
>=20
> File: hw/i386/acpi-build.c

I'm not convinced by above arguments yet (perhaps I don't see a problem
you are observing), so I'd like to keep cpu hotplug isolated/not exposed
as much as possible unless it's proven that it will not work as is.
(see for more below)=20
=20
> build_dsdt()
> {
>  =C2=A0=C2=A0 [...]
>  =C2=A0=C2=A0=C2=A0 scope =3D=C2=A0 aml_scope("_GPE");
>  =C2=A0=C2=A0 [...]
>  =C2=A0=C2=A0=C2=A0 aml_append(dsdt, scope);
>=20
>  =C2=A0=C2=A0=C2=A0 if (pcmc->legacy_cpu_hotplug) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_legacy_cpu_hotplug_aml(=
dsdt, machine, pm->cpu_hp_io_base);
>  =C2=A0=C2=A0=C2=A0 } else {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUHotplugFeatures opts =3D {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi=
_1_compatible =3D true, .has_legacy_cphp =3D true,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .smi_=
path =3D pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fw_u=
nplugs_cpu =3D pm->smi_on_cpu_unplug,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_cpus_aml(dsdt, machine,=
 opts, pc_madt_cpu_entry,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm->cpu_hp_io_=
base, "\\_SB.PCI0", "\\_GPE._E02");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm->cpu_hp_io_base, =
"\\_SB.PCI0");
> + =C2=A0=C2=A0=C2=A0=C2=A0 build_gpe_aml(...,, ,"\\_GPE._E02")
>=20
>  =C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0 [...]
> }
>=20
> File: hw/acpi/cpu.c
>=20
> @@ -343,9 +343,10 @@ const VMStateDescription vmstate_cpu_hotplug =3D {
>  =C2=A0#define CPU_FW_EJECT_EVENT "CEJF"
>=20
>  =C2=A0void build_cpus_aml(Aml *table, MachineState *machine,=20
> CPUHotplugFeatures opts,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_madt_cpu_fn build_madt_cpu=
, hwaddr io_base,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_madt_cpu_fn build_madt_cpu=
, hwaddr base_addr,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *res_root,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *event_handler_method)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AmlRegionSpace rs)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0 Aml *ifctx;
>  =C2=A0=C2=A0=C2=A0=C2=A0 Aml *field;
>=20
>=20
> That said, if you still wish you proceed with your suggestions I can go
> ahead and do it but please understand that I'll have to put a check
> to avoid adding call to CPU Scan for am/virt platform since we would
> want to add that call as part of the GED/AML code. This is unnecessary
> and would look ugly.
I just don't get why you have to call CPU Scan explicitly from arm/virt
side. (maybe my suggestion was lost in translation/was not clear enough)
Let's pretend that hw/i386/acpi-build.c is an arm/virt code and demo
what I was suggesting.


diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 2d6e91b124..33addb6275 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -117,6 +117,9 @@ void build_ged_aml(Aml *table, const char *name, Hotplu=
gHandler *hotplug_dev,
                            aml_notify(aml_name("\\_SB.NVDR"),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_CPU_HOTPLUG_EVT:
+                aml_append(if_ctx, aml_call0("\\_SB.GED.CPEV"));
+                break
             default:
                 /*
                  * Please make sure all the events in ged_supported_events=
[]
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f4e366f64f..8b4f422652 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1536,7 +1536,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             .fw_unplugs_cpu =3D pm->smi_on_cpu_unplug,
         };
         build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
-                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
+                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_SB.GED.CPEV");
     }
=20
this way build_cpus_aml() will create and populate with scan
\\_SB.GED.CPEV method.

which is then called by=20
GED._EVT()
    ...
    if cpuhotplug
          \\_SB.GED.CPEV()
    ...

there is no multiplexing of cpuhp event in build_cpus_aml,
the only event multiplexer is GED._EVT() as it should be.
And you don't have to expose cpu hotplug internals to any
other place[s].

PS:
For legacy cphp handling acpi/cpu.c has only _INI method
that is created when opts.has_legacy_cphp is true.
we should be able to get rid of it when 2.6 machine type is removed.
But ARM [or anything else] don't have to be aware of it
if you use static initializer like it's done in hw/i386/acpi-build.c
and just ignore non relevant fields.



> Thanks
> Salil.
>=20
>=20
> >
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


