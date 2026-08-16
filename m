Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C3C5DF7F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 23:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvk04-00009E-3N; Sun, 16 Aug 2026 19:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wvjzv-000093-86
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 19:10:35 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wvjzq-0005mS-7b
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 19:10:33 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 11EBD3F307
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1786921828;
 bh=BDAGaLqzlyfGpfnSoHmK/Njo3TRaEV2gpWmdw75qswM=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=GIDoVSaUWEtncNvr01n5HVaJ9s5g+1EMEfHXlcDf90YoRzgMmpJH3NXFTqY/DJzQ3
 j/f4RzD7acfl4NRpdIBZYQjwNR8DM5KeBg3a69CnXkYNzsJdgniK1JgIgiDTKQNQfW
 Y5EUhVRg4eeSRRkuQgVbh+2pTrymIRI6Unvm4LmfNjzW+5AkduVJKtZKHDlPlUXej9
 VBGDUh8QwbLxMkWae62pXoJZnri3dgzNCt/pWLIZgiYgnwf/RvmnL3vhFnitTrnPKU
 kUYfK35PKH4ZCBccAx/UdeHQhZsQOBFCirvxM7jG7EhiEhVnnvGPzZtTKQTiOGN2jl
 lYZtGIq3bXDgA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 0982E7F404
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 23:10:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 23:02:11 -0000
From: Ubuntu Kernel Bot <2163604@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Unknown; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux-hwe-6.11;
 component=main; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: amd64 apport-bug kernel-daily-bug noble
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kennybobs
X-Launchpad-Bug-Reporter: Ken Sharp (kennybobs)
X-Launchpad-Bug-Modifier: Ubuntu Kernel Bot (ubuntu-kernel-bot)
References: <178689637290.2447309.1476538072834918294.malonedeb@juju-98d295-prod-launchpad-55>
Message-Id: <178692133173.1018648.6034244772378890656.launchpad@juju-98d295-prod-launchpad-60>
Subject: [Bug 2163604] Re: Wine's ntdll:exception test causes GPF in KVM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f3f5e18eeb078b421219d9c98ba0dd1171ead1a";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 4d8685dfa9139fdef8283ad46f15e6d732177eb9
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 2163604 <2163604@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

** Tags added: kernel-daily-bug

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2163604

Title:
  Wine's ntdll:exception test causes GPF in KVM

Status in QEMU:
  New
Status in linux-hwe-6.11 package in Ubuntu:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  Wine's winetest.exe is used to test various components of Wine
  (WineHQ.org), and can be run on a Windows VM. When it gets to the
  ntdll:exception test, Qemu exits silently.

  [Aug16 16:36] kvm_intel: kvm [23609]: vcpu2, guest rIP: 0xfffff8058f0f954=
2 Unhandled WRMSR(0x1d9) =3D 0x1
  [  +0.000128] qemu-system-x86[23609]: segfault at 594ae11c0760 ip 0000594=
ae11c0760 sp 00007fffe472fd08 error 15 likely on CPU 0 (core 0, socket 0)
  [  +0.000014] Code: 00 00 20 3b 20 5a b0 7f 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 cb ce 55 01 00 00 00 00 97 00 00 00 00 00 00 00 <2=
0> 00 0a 6c 69 62 73 63 41 00 00 00 00 00 00 00 30 52 60 e1 4a>

  Qemu should handle this gracefully, but then so should KVM.
  I tested Qemu 11.1.0 and the exact same happens. Will report to Qemu.

  Kernel testing is difficult as I rely on old Nvidia drivers, and
  they're broken in newer kernels with no chance of them being fixed.

  Attaching the specific binary from today's daily build.

  ProblemType: Bug
  DistroRelease: Ubuntu 24.04
  Package: linux-image-6.11.0-29-generic 6.11.0-29.29~24.04.1
  ProcVersionSignature: Ubuntu 6.11.0-29.29~24.04.1-generic 6.11.11
  Uname: Linux 6.11.0-29-generic x86_64
  NonfreeKernelModules: nvidia_modeset nvidia
  ApportVersion: 2.28.3-0ubuntu0.1
  Architecture: amd64
  AudioDevicesInUse:
   USER        PID ACCESS COMMAND
   /dev/snd/controlC0:  ken        3933 F.... wireplumber
   /dev/snd/controlC1:  ken        3933 F.... wireplumber
   /dev/snd/seq:        ken        3929 F.... pipewire
  CasperMD5CheckResult: unknown
  CurrentDesktop: MATE
  Date: Sun Aug 16 16:57:54 2026
  MachineType: LENOVO 0606AD5
  ProcFB: 0 simpledrmdrmfb
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-6.11.0-29-generic root=3DUUID=3D=
83ed7b7f-ef51-49d7-a6be-a8efee1cdd32 ro rootflags=3Dsubvol=3D@ vt.handoff=
=3D7 zswap.enabled=3D1 zswap.shrinker_enabled=3D1 zswap.max_pool_percent=3D=
20 zswap.zpool=3Dzsmalloc zswap.compressor=3Dlz4 resume=3DUUID=3Dafb35822-b=
a94-455b-839e-a91d503b9608 intel_iommu=3Don iommu=3Dpt video=3D1920x1080@60
  PulseList: Error: command ['pacmd', 'list'] failed with exit code 1: No P=
ulseAudio daemon running, or not running as session daemon.
  RelatedPackageVersions:
   linux-restricted-modules-6.11.0-29-generic N/A
   linux-backports-modules-6.11.0-29-generic  N/A
   linux-firmware                             20240318.git3b128b60-0ubuntu2=
.29
  RfKill:
  =20
  SourcePackage: linux-hwe-6.11
  UpgradeStatus: Upgraded to noble on 2026-05-15 (93 days ago)
  dmi.bios.date: 12/15/2016
  dmi.bios.release: 0.60
  dmi.bios.vendor: LENOVO
  dmi.bios.version: A0KT60AUS
  dmi.board.asset.tag: To be filled by O.E.M.
  dmi.board.name: LENOVO
  dmi.board.vendor: LENOVO
  dmi.board.version: NONE
  dmi.chassis.type: 7
  dmi.chassis.vendor: LENOVO
  dmi.chassis.version: NONE
  dmi.modalias: dmi:bvnLENOVO:bvrA0KT60AUS:bd12/15/2016:br0.60:svnLENOVO:pn=
0606AD5:pvrThinkStationS30:rvnLENOVO:rnLENOVO:rvrNONE:cvnLENOVO:ct7:cvrNONE=
:skuLENOVO_BI_A0:
  dmi.product.family: To be filled by O.E.M.
  dmi.product.name: 0606AD5
  dmi.product.sku: LENOVO_BI_A0
  dmi.product.version: ThinkStation S30
  dmi.sys.vendor: LENOVO

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2163604/+subscriptions


