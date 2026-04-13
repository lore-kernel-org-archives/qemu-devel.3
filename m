Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0947F34C51
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGhJ-00005r-2C; Mon, 13 Apr 2026 08:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wCGhH-00005b-9n
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:47:23 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wCGhE-0007iZ-Mg
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:47:23 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 69419506AF
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1776084430;
 bh=46aBjDo9+BGuQeExRtM6J6wA0g4iRUZmYpMyP4biXfQ=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=nvkv5izJdGYMI6htgx6ueo/f3Lq3wDpioi5AQb6Me173pae14gx3jx71G+BHfLru8
 JjxzBIemku5bmORB9dVQiCB6NoOjmoPsUGLH9VVUNX2sQ4u4L1egC7FsVr1ern4aVk
 mXTO0cjaYgSGRfTpZVyGB6gLyjnGYiPVcYTIsu+OEeu2sAhn9aS0uhc0/ORdW7MtPf
 JdQIwiCi1WAtMmkPSSF3BdwdN35URD75om/ImK4hQ/b6odPSD3MyMR9QYawwMT9I3G
 lgWX1lVWgCCccgHnkxwdsKng5+px47oOwW4zUP0ZbtDcxJOI7LfOjbYupIAZFHOuJu
 W1lerW5iP6l2g==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id DB1348C492
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 12:47:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 12:37:44 -0000
From: =?utf-8?q?=F0=9F=A4=96_prod-kernel-team-janitor?=
 <1915063@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux; component=main;
 status=Expired; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux-oem-5.10;
 component=main; status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux-oem-5.6;
 component=main; status=Expired; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: apport-collected focal kernel-autoclosed
 kernel-autoclosed-expired kernel-daily-bug
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: apw babumoger dober60 imammedo markrhpearson
 paelzer prod-kernel-team-janitor sergiodj th-huth ubuntu-kernel-bot
X-Launchpad-Bug-Reporter: David Ober (dober60)
X-Launchpad-Bug-Modifier: =?utf-8?q?=F0=9F=A4=96_prod-kernel-team-janitor_=28prod-kernel-team-janitor=29?=
References: <161281335451.16853.7070328699645987751.malonedeb@wampee.canonical.com>
Message-Id: <177608386415.279468.16460003203265708534.malone@juju-98d295-prod-launchpad-55>
Subject: [Bug 1915063] Re: Windows 10 wil not install using qemu-system-x86_64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="866d07beecca8ac2e3326342adf6c1740cd3e7b3";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 0b909ac39815b4c061f25f0d56e89fb8bd00aeda
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1915063 <1915063@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The task "linux (Ubuntu)" has expired because it has had no new comments
or updates for more than three years.

If this issue is still present in an Ubuntu LTS kernel still under
active support, please reopen the bug and provide updated details. If
this issue was reported against an Ubuntu kernel no longer under active
support but the issue still exists in a currently supported Ubuntu
kernel, please open a new bug against that kernel version and provide
the updated details, with a reference link to the original bug.

This action was performed by an automated process maintained by the
Ubuntu Kernel Team.

** Tags added: kernel-autoclosed kernel-autoclosed-expired

** Changed in: linux (Ubuntu)
       Status: Confirmed =3D> Expired

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1915063

Title:
  Windows 10 wil not install using qemu-system-x86_64

Status in QEMU:
  Fix Released
Status in linux package in Ubuntu:
  Expired
Status in linux-oem-5.10 package in Ubuntu:
  Fix Released
Status in linux-oem-5.6 package in Ubuntu:
  Expired
Status in qemu package in Ubuntu:
  Invalid

Bug description:
  Steps to reproduce
  install virt-manager and ovmf if nopt already there
  copy windows and virtio iso files to /var/lib/libvirt/images

  Use virt-manager from local machine to create your VMs with the disk, CPU=
s and memory required
      Select customize configuration then select OVMF(UEFI) instead of seab=
ios
      set first CDROM to the windows installation iso (enable in boot optio=
ns)
      add a second CDROM and load with the virtio iso
  	change spice display to VNC

    Always get a security error from windows and it fails to launch the ins=
taller (works on RHEL and Fedora)
  I tried updating the qemu version from Focals 4.2 to Groovy 5.0 which was=
 of no help
  ---=20
  ProblemType: Bug
  ApportVersion: 2.20.11-0ubuntu27.14
  Architecture: amd64
  CasperMD5CheckResult: skip
  CurrentDesktop: ubuntu:GNOME
  DistributionChannelDescriptor:
   # This is the distribution channel descriptor for the OEM CDs
   # For more information see http://wiki.ubuntu.com/DistributionChannelDes=
criptor
   canonical-oem-sutton-focal-amd64-20201030-422+pc-sutton-bachman-focal-am=
d64+X00
  DistroRelease: Ubuntu 20.04
  InstallationDate: Installed on 2021-01-20 (19 days ago)
  InstallationMedia: Ubuntu 20.04 "Focal" - Build amd64 LIVE Binary 2020103=
0-14:39
  MachineType: LENOVO 30E102Z
  NonfreeKernelModules: nvidia_modeset nvidia
  Package: linux (not installed)
  ProcEnviron:
   TERM=3Dxterm-256color
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  ProcFB: 0 EFI VGA
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-5.6.0-1042-oem root=3DUUID=
=3D389cd165-fc52-4814-b837-a1090b9c2387 ro locale=3Den_US quiet splash vt.h=
andoff=3D7
  ProcVersionSignature: Ubuntu 5.6.0-1042.46-oem 5.6.19
  RelatedPackageVersions:
   linux-restricted-modules-5.6.0-1042-oem N/A
   linux-backports-modules-5.6.0-1042-oem  N/A
   linux-firmware                          1.187.8
  RfKill:
  =20
  Tags:  focal
  Uname: Linux 5.6.0-1042-oem x86_64
  UpgradeStatus: No upgrade log present (probably fresh install)
  UserGroups: adm cdrom dip docker kvm libvirt lpadmin plugdev sambashare s=
udo
  _MarkForUpload: True
  dmi.bios.date: 07/29/2020
  dmi.bios.vendor: LENOVO
  dmi.bios.version: S07KT08A
  dmi.board.name: 1046
  dmi.board.vendor: LENOVO
  dmi.board.version: Not Defined
  dmi.chassis.type: 3
  dmi.chassis.vendor: LENOVO
  dmi.chassis.version: None
  dmi.modalias: dmi:bvnLENOVO:bvrS07KT08A:bd07/29/2020:svnLENOVO:pn30E102Z:=
pvrThinkStationP620:rvnLENOVO:rn1046:rvrNotDefined:cvnLENOVO:ct3:cvrNone:
  dmi.product.family: INVALID
  dmi.product.name: 30E102Z
  dmi.product.sku: LENOVO_MT_30E1_BU_Think_FM_ThinkStation P620
  dmi.product.version: ThinkStation P620
  dmi.sys.vendor: LENOVO

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1915063/+subscriptions


