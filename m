Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4564C2BA18
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 02:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKUMW-0006wZ-Rk; Thu, 20 Jun 2024 22:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sKUMU-0006wQ-O5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 22:50:50 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sKUMR-00028j-96
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 22:50:50 -0400
To: Igor Mammedov <imammedo@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: Failed to hot-plug device to pxb bridge
Thread-Topic: Failed to hot-plug device to pxb bridge
Thread-Index: AQHaw4XI87/5oTfsUESpKSNFbrbm9A==
Date: Fri, 21 Jun 2024 02:50:31 +0000
Message-ID: <2cae6cf3c0f64b509ceed04be6a8bd70@baidu.com>
References: <3A8D097B-3BA7-40DC-8DDF-D79B7BEE5CEE@baidu.com>,
 <20240530160919.01a3effc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240530160919.01a3effc@imammedo.users.ipa.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.184]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.52
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sorry for not replying earlier, I have been busy with other things.

> > Hi Igor, Daniel and all:
> >
> >  https://lore.kernel.org/all/20220422135101.65796823@redhat.com/t/#r831=
d589f243c24334a09995620b74408847a87a0
> >
> > This message discuss hotplug device to pxb bridge. At the end, Igor sug=
gested enable shpc on pxb bridge:
> >=A0=A0 pxb_dev_realize_common():
> >=A0=A0=A0=A0=A0 qdev_prop_set_bit(bds, PCI_BRIDGE_DEV_PROP_SHPC, true);
>
>
> you can try check if hotplug gets to shpc_device_plug_cb() and what it do=
es there
> if it gets to the end but you don't get any reaction from guest OS
> it might be a guest issue.

I checked the guest dmesg and found that failed load shpc driver.

  [    0.966668] shpchp 0000:00:05.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PCI0.S28_)
  [    0.968238] shpchp 0000:00:05.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PCI0)
  [    0.969160] shpchp 0000:00:05.0: Cannot get control of SHPC hotplug
  [    0.969876] shpchp 0000:00:06.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PCI0.S30_)
  [    0.971454] shpchp 0000:00:06.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PCI0)
  [    0.972376] shpchp 0000:00:06.0: Cannot get control of SHPC hotplug
  [    0.973119] shpchp 0000:80:00.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PC80)
  [    0.974674] shpchp 0000:80:00.0: Cannot get control of SHPC hotplug
  [    0.979422] shpchp 0000:81:01.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PC80)
  [    0.980948] shpchp 0000:81:01.0: Cannot get control of SHPC hotplug
  [    0.981685] shpchp 0000:60:00.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PC60)
  [    0.994623] shpchp 0000:60:00.0: Cannot get control of SHPC hotplug
  [    0.995349] shpchp 0000:61:01.0: Requesting control of SHPC hotplug vi=
a OSHP (\_SB_.PC60)
  [    0.996891] shpchp 0000:61:01.0: Cannot get control of SHPC hotplug
  [    0.997626] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4

Read the shpc driver code, I found that before shpc_init it need check the =
shpc capability of bridge(shpc_capable) and
get hotplug control from firmware(acpi_get_hp_hw_control_from_firmware) in =
shpc_probe.

Howerver it return fail in acpi_get_hp_hw_control_from_firmware. I dump the=
 acpid table, not found OSC and OSHP
method in dsdt.dsl.

In the QEMU build_dsdt, not found build osc method in i440fx.

Putting aside this pxb scenario, I suspect that after disable acpi-pci-hotp=
lug-with-bridge-support,
hot-plug into the PCI bridge via SHPC can be successful in i440fx ?


> > Howerver, I tried it and the guest can't find the device on pxb bridge.=
 Add some log, QEMU use hotplug handler shpc_device_plug_cb.
> >
> > QEMU command line:
> > -device pxb,bus_nr=3D96,id=3Dpci.1,numa_node=3D0,bus=3Dpci.0,addr=3D0x3
> > -device pxb,bus_nr=3D128,id=3Dpci.2,numa_node=3D1,bus=3Dpci.0,addr=3D0x=
4
> > -device pci-bridge,chassis_nr=3D3,id=3Dpci.3,bus=3Dpci.0,addr=3D0x5
> > -device pci-bridge,chassis_nr=3D4,id=3Dpci.4,bus=3Dpci.0,addr=3D0x6
> > -device pci-bridge,chassis_nr=3D5,id=3Dpci.5,bus=3Dpci.1,addr=3D0x1
> > -device pci-bridge,chassis_nr=3D6,id=3Dpci.6,bus=3Dpci.2,addr=3D0x1
> >
> > Hotplug command:
> > {"execute":"human-monitor-command","arguments":{"command-line":"drive_a=
dd dummy file=3D/home/test/data1.img,format=3Dqcow2,if=3Dnone,id=3Ddrive-vi=
rtio-disk1,cache=3Dnone"}}
> > {"execute":"device_add","arguments":{"driver":"virtio-blk-pci","scsi":"=
off","bus":"pci.5","addr":"0x1","drive":"drive-virtio-disk1","id":"virtio-d=
isk1"}}
> >
> > Some info in the guest:
> > [root@localhost ~]# lspci -tv
> > -+-[0000:80]---00.0-[81-82]----01.0-[82]--
> >=A0 +-[0000:60]---00.0-[61-62]----01.0-[62]--
> >=A0 \-[0000:00]-+-00.0=A0 Intel Corporation 440FX - 82441FX PMC [Natoma]
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-01.0=A0 Intel Corporation 8237=
1SB PIIX3 ISA [Natoma/Triton II]
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-01.1=A0 Intel Corporation 8237=
1SB PIIX3 IDE [Natoma/Triton II]
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-01.2=A0 Intel Corporation 8237=
1SB PIIX3 USB [Natoma/Triton II]
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-01.3=A0 Intel Corporation 8237=
1AB/EB/MB PIIX4 ACPI
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-02.0=A0 Cirrus Logic GD 5446
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-03.0=A0 Red Hat, Inc. QEMU PCI=
 Expander bridge
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-04.0=A0 Red Hat, Inc. QEMU PCI=
 Expander bridge
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-05.0-[01]--
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-06.0-[02]--
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-07.0=A0 Red Hat, Inc. Virtio n=
etwork device
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-08.0=A0 Red Hat, Inc. Virtio b=
lock device
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \-09.0=A0 Red Hat, Inc. Virtio m=
emory balloon
> > [root@localhost boot]# grep -i 'shpc' config-3.10.0-1160.83.1.el7.x86_6=
4
> > CONFIG_HOTPLUG_PCI_SHPC=3Dy
> > [root@localhost boot]# uname -r
> > 3.10.0-1160.83.1.el7.x86_64
> >
> > Thanks.
> >
> >
>=

