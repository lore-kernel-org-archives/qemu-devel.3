Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A056BC369C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 19:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5rTM-00016L-Jc; Fri, 18 Apr 2025 15:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1u5rTG-00015u-1t
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:33:54 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1u5rTC-0007Ja-8G
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:33:52 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 003D04BEA6
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1745004825;
 bh=2V9TZmPm7il7PPKOcuz5esbgLb3CuKGeo0vuj2c5rbg=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=HWFggwcCBeOB655gzHneyE2pjo2p4874br5mEXh/Xy0qpjhP2BJImzeVBgowKgqi1
 LVfj0LVaGjAR4yyUzC8HcnjOd7SuTJCytjt7V/faCY/27Se9fLBx8QYIfmPx8AlT52
 3vL0b5Z/5swx4a4iyVaag6Wua68YlIgn2qhS+tGkr1gBBkN53R6fszdizr9o5taqu+
 FpO1QEXJ6D0pxXvqTLEr/zlDtGQD1zGT0LrNyzMKacmvQebj1BEWQ7cIAWGixSyboU
 XBCAc1A+Tr6na9EX+19vfvxyVu8+WsyPcFfJu8m7KPV7Nh0nzhR+Unh/sAdolI75Nu
 sRnYiI2AVgaFg==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id DC0D67E69F
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 19:33:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Apr 2025 11:44:10 -0000
From: =?utf-8?b?SsO8cmcgSMOkZmxpZ2Vy?= <1037606@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=linux; status=Confirmed; importance=Medium;
 assignee=None; 
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux; component=main;
 status=Triaged; importance=Medium; assignee=None; 
X-Launchpad-Bug-Tags: apport-collected kernel-bug-exists-upstream
 kernel-daily-bug precise quantal running-unity
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: brad-figg hramrach jsalisbury leaf-node th-huth
X-Launchpad-Bug-Reporter: Michal Suchanek (hramrach)
X-Launchpad-Bug-Modifier: =?utf-8?b?SsO8cmcgSMOkZmxpZ2VyIChqdWVyZ2gp?=
References: <20120816144502.14385.65707.malonedeb@soybean.canonical.com>
Message-Id: <174497665205.628138.10645069617337964977.launchpad@juju-98d295-prod-launchpad-4>
Subject: [Bug 1037606] Re: vmwgfx does not work with kvm vmware vga
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e76edd883483c71c468bb038e98836435de44530";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 07419316ae33dab5b15794b6a4fe14ddcace8a35
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1037606 <1037606@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

** Tags added: kernel-daily-bug

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1037606

Title:
  vmwgfx does not work with kvm vmware vga

Status in Linux:
  Confirmed
Status in QEMU:
  Won't Fix
Status in linux package in Ubuntu:
  Triaged

Bug description:
  vmwgfx driver fails to initialize inside kvm.

  tried: kvm -m 2048 -vga vmware -cdrom RebeccaBlackLinux.iso (Ubuntu
  based, any Ubuntu live CD would do)

  Apport data collected with qantal alpha live CD (somewhat older
  kernel).

  The error is shjown in CurrentDmesg.txt
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1037606/+attachment/=
3265235/+files/CurrentDmesg.txt

  ---
  ApportVersion: 2.4-0ubuntu8
  Architecture: amd64
  AudioDevicesInUse: Error: command ['fuser', '-v', '/dev/snd/seq', '/dev/s=
nd/timer'] failed with exit code 1:
  CRDA: Error: command ['iw', 'reg', 'get'] failed with exit code 1: nl8021=
1 not found.
  CasperVersion: 1.320
  DistroRelease: Ubuntu 12.10
  IwConfig:
  =C2=A0eth0      no wireless extensions.

  =C2=A0lo        no wireless extensions.
  LiveMediaBuild: Ubuntu 12.10 "Quantal Quetzal" - Alpha amd64 (20120724.2)
  Lsusb: Error: command ['lsusb'] failed with exit code 1: unable to initia=
lize libusb: -99
  MachineType: Bochs Bochs
  Package: linux (not installed)
  ProcEnviron:
  =C2=A0TERM=3Dlinux
  =C2=A0PATH=3D(custom, no user)
  =C2=A0LANG=3Den_US.UTF-8
  =C2=A0SHELL=3D/bin/bash
  ProcFB:

  ProcKernelCmdLine: file=3D/cdrom/preseed/hostname.seed boot=3Dcasper init=
rd=3D/casper/initrd.lz quiet splash -- maybe-ubiquity
  ProcVersionSignature: Ubuntu 3.5.0-6.6-generic 3.5.0
  PulseList: Error: command ['pacmd', 'list'] failed with exit code 1: No P=
ulseAudio daemon running, or not running as session daemon.
  RelatedPackageVersions:
  =C2=A0linux-restricted-modules-3.5.0-6-generic N/A
  =C2=A0linux-backports-modules-3.5.0-6-generic  N/A
  =C2=A0linux-firmware                           1.85
  RfKill:

  Tags:  quantal
  Uname: Linux 3.5.0-6-generic x86_64
  UpgradeStatus: No upgrade log present (probably fresh install)
  UserGroups:

  dmi.bios.date: 01/01/2007
  dmi.bios.vendor: Bochs
  dmi.bios.version: Bochs
  dmi.chassis.type: 1
  dmi.chassis.vendor: Bochs
  dmi.modalias: dmi:bvnBochs:bvrBochs:bd01/01/2007:svnBochs:pnBochs:pvr:cvn=
Bochs:ct1:cvr:
  dmi.product.name: Bochs
  dmi.sys.vendor: Bochs
  ---=20
  ApportVersion: 2.0.1-0ubuntu12
  Architecture: i386
  DistroRelease: Ubuntu 12.04
  InstallationMedia: Ubuntu 10.10 "Maverick Meerkat" - Release i386 (201010=
07)
  Package: linux (not installed)
  ProcEnviron:
   TERM=3Dxterm
   PATH=3D(custom, no user)
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  Tags:  precise running-unity
  Uname: Linux 3.6.0-030600rc3-generic i686
  UnreportableReason: The running kernel is not an Ubuntu kernel
  UpgradeStatus: Upgraded to precise on 2012-08-30 (0 days ago)
  UserGroups: adm admin cdrom dialout lpadmin plugdev sambashare

To manage notifications about this bug go to:
https://bugs.launchpad.net/linux/+bug/1037606/+subscriptions


