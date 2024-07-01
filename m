Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A978C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sODVc-0006vC-1L; Mon, 01 Jul 2024 05:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sODVW-0006us-9A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:39:34 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sODVS-0006C8-8E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:39:33 -0400
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Gao,Shiyuan"
 <gaoshiyuan@baidu.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Topic: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Index: AQHay5qKRSBFVf/99E2HttGMe0hbxg==
Date: Mon, 1 Jul 2024 09:39:16 +0000
Message-ID: <02403c2f69574128a1700d8b3db37381@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
 <6d033738d79d4b9a83fe216679f8e587@baidu.com>,
 <20240701104000.52df4854@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240701104000.52df4854@imammedo.users.ipa.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.163]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.51
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > > > the PCI bridge will fail when we use SHPC Native type:
> > > >
> > > >=A0=A0 [3.336059] shpchp 0000:00:03.0: Requesting control of SHPC ho=
tplug via OSHP (\_SB_.PCI0.S28_)
> > > >=A0=A0 [3.337408] shpchp 0000:00:03.0: Requesting control of SHPC ho=
tplug via OSHP (\_SB_.PCI0)
> > > >=A0=A0 [3.338710] shpchp 0000:00:03.0: Cannot get control of SHPC ho=
tplug
> > > >
> > > > Add OSHP method support for transfer control to the operating syste=
m,
> > > > after this SHPC driver will be loaded success and the hotplug devic=
e to
> > > > the PCI bridge will success when we use SHPC Native type.
> > > >
> > > >=A0=A0 [1.703975] shpchp 0000:00:03.0: Requesting control of SHPC ho=
tplug via OSHP (\_SB_.PCI0.S18_)
> > > >=A0=A0 [1.704934] shpchp 0000:00:03.0: Requesting control of SHPC ho=
tplug via OSHP (\_SB_.PCI0)
> > > >=A0=A0 [1.705855] shpchp 0000:00:03.0: Gained control of SHPC hotplu=
g (\_SB_.PCI0)
> > > >=A0=A0 [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id =
1 ss_vid 0 ss_did 0
> > >
> > > please describe in commit message reproducer
> > > (aka QEMU CLI and guest OS and if necessary other details)
> >
> > qemu-system-x86_64 -machine pc-q35-9.0
> >=A0=A0=A0=A0 ...
> >=A0=A0=A0=A0 -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Doff
>
> please use full QEMU CLI and follow up steps to trigger the issue.
>
> From above it's not obvious what and where you are trying to hotplug

Nothing needs to be done when you start a i440fx VM, this issue will be tri=
ggered.
PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Doff is used to verify shpc =
driver load sucess.

>
> > guest OS: centos7/ubuntu22.04
> >
> > I will add it in the next version.
> >
> > > > +/*
> > > > + * PCI Firmware Specification 3.0
> > > > + * 4.8. The OSHP Control Method
> > > > + */
> > > > +static Aml *build_oshp_method(void)
> > > > +{
> > > > +=A0=A0=A0 Aml *method;
> > > > +
> > > > +=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0 * We don't use ACPI to control the SHPC, so just retu=
rn
> > > > +=A0=A0=A0=A0 * success is enough.
> > > > +=A0=A0=A0=A0 */
> > > > +=A0=A0=A0 method =3D aml_method("OSHP", 0, AML_NOTSERIALIZED);
> > > > +=A0=A0=A0 aml_append(method, aml_return(aml_int(0x0)));
> > > > +=A0=A0=A0 return method;
> > > > +}
> > > > +
> > > >=A0 static void
> > > >=A0 build_dsdt(GArray *table_data, BIOSLinker *linker,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AcpiPmInfo *pm, AcpiMiscInfo *m=
isc,
> > > > @@ -1452,6 +1469,7 @@ build_dsdt(GArray *table_data, BIOSLinker *li=
nker,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, aml_name_decl("_HID", am=
l_eisaid("PNP0A03")));
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, aml_name_decl("_UID", am=
l_int(pcmc->pci_root_uid)));
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, aml_pci_edsm());
> > > > +=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, build_oshp_method());
> > >
> > > it's global and what will happen if we have ACPI PCI hotplug enabled
> > > and guest calls this NOP method?
> >
> > ths OS get the control of SHPC hotplug and SHPC driver load fail later.
> >
> > [=A0=A0=A0 6.170345] shpchp 0000:00:03.0: Requesting control of SHPC ho=
tplug via OSHP (\_SB_.PCI0.S18_)
> > [=A0=A0=A0 6.171962] shpchp 0000:00:03.0: Requesting control of SHPC ho=
tplug via OSHP (\_SB_.PCI0)
> > [=A0=A0=A0 6.173556] shpchp 0000:00:03.0: Gained control of SHPC hotplu=
g (\_SB_.PCI0)
> > [=A0=A0=A0 6.175144] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id =
1 ss_vid 0 ss_did 0
> > [=A0=A0=A0 6.196153] shpchp 0000:00:03.0: irq 24 for MSI/MSI-X
> > [=A0=A0=A0 6.197211] shpchp 0000:00:03.0: pci_hp_register failed with e=
rror -16
> > [=A0=A0=A0 6.198272] shpchp 0000:00:03.0: Slot initialization failed
> >
> > this looks more suitable.
> >
> > +=A0=A0=A0 if (!pm->pcihp_bridge_en) {
> > +=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, build_i440fx_oshp_method());
> > +=A0=A0=A0 }
>
> we also have
> =A0PIIX4_PM.acpi-root-pci-hotplug (default true)
> though it seems that ACPI hotplug takes precedence of SHPC if both are en=
abled.
> So I'd take it and OSHP approach seems simpler than adding _OSC to do the=
 same.

yes, I tried to add an OSC method, but the OS and the firmware failed to ne=
gotiate in the guest, dmesg as follow.
Through analyzing the code, I found that this process relies on pci_ext_cfg=
_avail in negotiate_os_control. On i440fx,
pci_ext_cfg_avail is false.

[    0.631156] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I EDR HPX-Type3]
[    0.632184] acpi PNP0A03:00: _OSC: not requesting OS control; OS require=
s [ExtendedConfig ASPM ClockPM MSI]
[    0.633160] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.

Therefore, I chose the OSHP method.
>
> >
> > >
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(sb_scope, dev);
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dsdt, sb_scope);
> > > >
> > > > @@ -1586,6 +1604,7 @@ build_dsdt(GArray *table_data, BIOSLinker *li=
nker,
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, =
build_q35_osc_method(true));
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, =
aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aml_append(dev, buil=
d_oshp_method());
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > >
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (numa_node !=3D NUMA_NODE=
_UNASSIGNED) {
> >
> > Hot plug/unplug a device using SHPC will take more time than ACPI PCI h=
otplug, because
> > after pressing the button, it can be cancelled within 5 seconds in SHPC=
 driver.
>
> for SHPC on PXB see,
> commit d10dda2d60 hw/pci-bridge: disable SHPC in PXB
>
> it seems that enabling SHPC on PXB in QEMU is not enough,
> UEFI needs to support that as well
> (CCing Gerd to check whether it is possible at all)
>
> > If I want to use ACPI PCI hotplug in the pxb bridge, what else need to =
be done?
>
> does it have to be hotplug directly into pxb or
> would be it be sufficient to have hotplug support
> on pci-bridge attached to a pxb?

It's sufficient to hotplug support on pci-bridge attached to a pxb.

>
> I particularly do not like spreading ACPI hotplug
> to any host bridges, as it's quite complicated
> code.
>=

