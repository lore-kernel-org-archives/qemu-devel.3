Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FBAC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCad-0008Rx-F1; Mon, 01 Jul 2024 04:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOCa3-0008IJ-Kh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOCZy-0005Ab-RG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719823205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sEJGdQ+a4y5p3b3Y3+Lpv+rI23frkynwbMJZkj6QJE=;
 b=FnrkoheavXPzmmzfVEQ5K8EY8L+U4jmO+khhucd3890G3X6McDHJ270EPQhR0gCGGsBIen
 LZyz0Vbb+KXWZG2yzAGECeyuF6GzyY6Lwj+0v0IkHL4IEmEglodBwalM1821Bdj0PGH6L5
 KMdw8JE4BwF0sHAoUTFAFLMaR8Gc8ew=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-ITYsPw6qOF6M97d92WkkoA-1; Mon, 01 Jul 2024 04:40:03 -0400
X-MC-Unique: ITYsPw6qOF6M97d92WkkoA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42568f0cc18so20321795e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719823202; x=1720428002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sEJGdQ+a4y5p3b3Y3+Lpv+rI23frkynwbMJZkj6QJE=;
 b=R1Ni/RLfEy3/DdU7QrSHztxfdz6lKHxhE+tYxEL9X5enSyYvIxl9f8wBRdYVnMiRMI
 K4Nji5Zps9FZA+IrsmrhUd3pvTM+wO7x+HRu+M5KfgDHNKicGZAGTHJmd2S1cZu37cEv
 VpG008Am9AvBf9QcWYFNJdZOuqYXbMlWNDMin5aG4ciSeg8UCBeZUwtLTnR67GNuKInH
 4vzX2beMwJx6NGi3RvAEb+a8m/DndWS285gvf3VsmHT5sIZWAsxNKNsbHmdSnc7FJbFk
 AO2KT6ZNtCEXwdWUv3/ssvKQNbLA7E+/nYeiXjTJfVZDtll28MiEjKvu4Um6eNYXWsqj
 9u0g==
X-Gm-Message-State: AOJu0YyZ+K1RNe8b2UbyjYF833u3+z+WgzRfac69HVK6PrGYUKPGcWgC
 pW8EGKl+IGVu8AZYlRmd/Lp94UAq6TPp7nrKl8nRRmnU5EXW9/8lu74CkwgPQER7ahPi7/wtJ1d
 MeGWyrTBzY08jbo00pdZPs/yTNT/T/S/bxsutT/vk8tRaEzLpm4Py
X-Received: by 2002:a05:600c:304a:b0:424:ac90:8571 with SMTP id
 5b1f17b1804b1-4257a01161cmr31432545e9.18.1719823202703; 
 Mon, 01 Jul 2024 01:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYJ1bbtxxhURSRLBOq7cgvm1pggAYqGJI4YRcNLOAQ9rnyxuhp+LjElrvPFwfGBEp6RLihFQ==
X-Received: by 2002:a05:600c:304a:b0:424:ac90:8571 with SMTP id
 5b1f17b1804b1-4257a01161cmr31432465e9.18.1719823202276; 
 Mon, 01 Jul 2024 01:40:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42577a0d108sm53322445e9.0.2024.07.01.01.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 01:40:01 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:40:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Message-ID: <20240701104000.52df4854@imammedo.users.ipa.redhat.com>
In-Reply-To: <6d033738d79d4b9a83fe216679f8e587@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
 <6d033738d79d4b9a83fe216679f8e587@baidu.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, 28 Jun 2024 03:04:28 +0000
"Gao,Shiyuan" <gaoshiyuan@baidu.com> wrote:

> > > that OS cannot get control of SHPC hotplug and hotplug device to
> > > the PCI bridge will fail when we use SHPC Native type:
> > >
> > >=C2=A0=C2=A0 [3.336059] shpchp 0000:00:03.0: Requesting control of SHP=
C hotplug via OSHP (\_SB_.PCI0.S28_)
> > >=C2=A0=C2=A0 [3.337408] shpchp 0000:00:03.0: Requesting control of SHP=
C hotplug via OSHP (\_SB_.PCI0)
> > >=C2=A0=C2=A0 [3.338710] shpchp 0000:00:03.0: Cannot get control of SHP=
C hotplug
> > >
> > > Add OSHP method support for transfer control to the operating system,
> > > after this SHPC driver will be loaded success and the hotplug device =
to
> > > the PCI bridge will success when we use SHPC Native type.
> > >
> > >=C2=A0=C2=A0 [1.703975] shpchp 0000:00:03.0: Requesting control of SHP=
C hotplug via OSHP (\_SB_.PCI0.S18_)
> > >=C2=A0=C2=A0 [1.704934] shpchp 0000:00:03.0: Requesting control of SHP=
C hotplug via OSHP (\_SB_.PCI0)
> > >=C2=A0=C2=A0 [1.705855] shpchp 0000:00:03.0: Gained control of SHPC ho=
tplug (\_SB_.PCI0)
> > >=C2=A0=C2=A0 [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device=
_id 1 ss_vid 0 ss_did 0 =20
> >
> > please describe in commit message reproducer
> > (aka QEMU CLI and guest OS and if necessary other details) =20
>=20
> qemu-system-x86_64 -machine pc-q35-9.0
>     ...
>     -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Doff

please use full QEMU CLI and follow up steps to trigger the issue.

=46rom above it's not obvious what and where you are trying to hotplug
=20
> guest OS: centos7/ubuntu22.04
>=20
> I will add it in the next version.
>=20
> > > +/*
> > > + * PCI Firmware Specification 3.0
> > > + * 4.8. The OSHP Control Method
> > > + */
> > > +static Aml *build_oshp_method(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 Aml *method;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * We don't use ACPI to control the SHPC, so=
 just return
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * success is enough.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 method =3D aml_method("OSHP", 0, AML_NOTSERIALIZE=
D);
> > > +=C2=A0=C2=A0=C2=A0 aml_append(method, aml_return(aml_int(0x0)));
> > > +=C2=A0=C2=A0=C2=A0 return method;
> > > +}
> > > +
> > >=C2=A0 static void
> > >=C2=A0 build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AcpiPmInfo *pm, AcpiMiscInfo *misc,
> > > @@ -1452,6 +1469,7 @@ build_dsdt(GArray *table_data, BIOSLinker *link=
er,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev,=
 aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev,=
 aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev,=
 aml_pci_edsm());
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, build_osh=
p_method()); =20
> >
> > it's global and what will happen if we have ACPI PCI hotplug enabled
> > and guest calls this NOP method? =20
>=20
> ths OS get the control of SHPC hotplug and SHPC driver load fail later.
>=20
> [    6.170345] shpchp 0000:00:03.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PCI0.S18_)
> [    6.171962] shpchp 0000:00:03.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PCI0)
> [    6.173556] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\_SB_=
.PCI0)
> [    6.175144] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss_vid=
 0 ss_did 0
> [    6.196153] shpchp 0000:00:03.0: irq 24 for MSI/MSI-X
> [    6.197211] shpchp 0000:00:03.0: pci_hp_register failed with error -16
> [    6.198272] shpchp 0000:00:03.0: Slot initialization failed
>=20
> this looks more suitable.
>=20
> +    if (!pm->pcihp_bridge_en) {
> +        aml_append(dev, build_i440fx_oshp_method());
> +    }

we also have
 PIIX4_PM.acpi-root-pci-hotplug (default true)
though it seems that ACPI hotplug takes precedence of SHPC if both are enab=
led.
So I'd take it and OSHP approach seems simpler than adding _OSC to do the s=
ame.

>=20
> > =20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(sb_s=
cope, dev);
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dsdt=
, sb_scope);
> > >
> > > @@ -1586,6 +1604,7 @@ build_dsdt(GArray *table_data, BIOSLinker *link=
er,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, build_q35_osc_method(true=
));
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 } else {
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_HID", aml=
_eisaid("PNP0A03")));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, build_oshp_method());
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > >
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (numa_node !=3D NUMA_NODE_UNASSIGNED) { =20
>=20
> Hot plug/unplug a device using SHPC will take more time than ACPI PCI hot=
plug, because
> after pressing the button, it can be cancelled within 5 seconds in SHPC d=
river.=20

for SHPC on PXB see,
commit d10dda2d60 hw/pci-bridge: disable SHPC in PXB

it seems that enabling SHPC on PXB in QEMU is not enough,
UEFI needs to support that as well
(CCing Gerd to check whether it is possible at all)=20

> If I want to use ACPI PCI hotplug in the pxb bridge, what else need to be=
 done?

does it have to be hotplug directly into pxb or
would be it be sufficient to have hotplug support
on pci-bridge attached to a pxb?

I particularly do not like spreading ACPI hotplug=20
to any host bridges, as it's quite complicated
code.

Michael,
Are there any reasons why we don't have hotplug directly
on PXBs enabled from PCI spec point of view?
(Is it that host bridges just do not support hotplug into them?)



> thanks.
>=20


