Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F4AF33A74
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9o4-0002QK-Fd; Thu, 05 Mar 2026 09:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vy9nu-0002Pr-Bu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:35:54 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vy9np-0003V6-Nz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:35:53 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 8E0E743239
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2026 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1772721346;
 bh=WOgLFJyvlIUCt5BYtexURzJns9T0xDXOFhw4KvQRcGA=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Nt6ex+hlipFfd7WIOD4KDZRBjvY8+A0rM1fJ4zAaj1zTSA5dpAclKte+PWupGvpVI
 4OplM5+pUAuwo7OzBJtDrp2KobnP34pk7iNQSjG3V/54RUS3qSPnMS2ZvbTSQrfZN0
 tCU7vcDKRtDT+Y/VwNjgomEwr0oxU9qPFSkeQlmwl3XMXTMHS1s8HrZBOefdrqxout
 S/X7r4rYLsgGTyKwjMaUs9aTbmJjlTyeRC17xDZ1DdL45O9rri30qqEop8PQImhhSf
 kxY1FOZ1LdAH6S6zgdh8WJevCmN6nwAenUCl+tk+CTe37GG+xNf9lwhnP1+tz7KgjO
 Cg2nLA22fs8rA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 849B77F77D
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2026 14:35:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 14:30:09 -0000
From: Launchpad Bug Tracker <2133804@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 milestone=ubuntu-26.04; status=Fix Released; importance=High;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; milestone=ubuntu-24.04.4; status=Confirmed; importance=High;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; milestone=ubuntu-26.04; status=Fix Released; importance=High;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug-Tags: server-todo
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hectorcao janitor mjt+launchpad-tls paelzer
 utkarsh xypron
X-Launchpad-Bug-Reporter: Heinrich Schuchardt (xypron)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <176477927666.3767208.4954653462090539439.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <177272101955.301612.9941538996367959287.malone@scripts.lp.internal>
Subject: [Bug 2133804] Re: QEMU does not emulate IOCTL TCGETS2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2b2e09fee12efee48836b36f2ca9a800f38d982a";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 7fdc868759f9f0b45c374fbd521fc6ebd54bf235
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
Reply-To: Bug 2133804 <2133804@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This bug was fixed in the package qemu - 1:10.2.1+ds-1ubuntu1

---------------
qemu (1:10.2.1+ds-1ubuntu1) resolute; urgency=3Dmedium

  * Merge with Debian unstable (LP: #2131929):
    Among several other backported fixes this will resolve
    - qemu-system-any brings in random system emulator with the
      new APT solver (LP: #2127053)
    - add termios2 support (LP: #2133804)
    Remaining changes:
    - qemu-kvm to systemd unit
      - d/qemu-kvm-init: script for QEMU KVM preparation modules, ksm,
        hugepages and architecture specifics
      - d/qemu-system-common.qemu-kvm.service: systemd unit to call
        qemu-kvm-init
      - d/qemu-system-common.install: install helper script
      - d/qemu-system-common.qemu-kvm.default: defaults for
        /etc/default/qemu-kvm
      - d/rules: call dh_installinit and dh_installsystemd for qemu-kvm
    - Distribution specific machine type
      (LP 1776189 1761372 1769053 2012763 2131822)
      - d/p/ubuntu/define-ubuntu-machine-types.patch: define distro machine
        types containing release versioned machine attributes
      - Add an info about -hpb machine type in debian/qemu-system-x86.NEWS
      - ubuntu-q35 alias added to auto-select the most recent q35 ubuntu ty=
pe
    - Enable nesting by default
      - d/p/ubuntu/enable-svm-by-default.patch: Enable nested svm by default
        in qemu64 on amd
        [ No more strictly needed, but required for backward compatibility ]
    - tolerate ipxe size change on migrations to >=3D18.04 (LP 1713490)
      - d/p/ubuntu/pre-bionic-256k-ipxe-efi-roms.patch: old machine types
        reference 256k path
      - d/control-in: depend on ipxe-qemu-256k-compat-efi-roms to be able to
        handle incoming migrations from former releases.
    - d/qemu-block-extra.postinst: Use latest Ubuntu's QEMU
      package version when deciding whether to invoke
      'deb-systemd-helper purge'.
    - d/control-in: Disable B-D on qemu-system-data, due to that also
      - d/rules: Export DEB_BUILD_PROFILES with
        pkg.qemu.use-upstream-vdso when building on non-amd64 architectures.
      - d/control: Disable B-D on seabios.
      - d/rules: Disable upstream tests depending on qemu-system-data
    - d/control-in: B-D on multipath libs for multipath persist in
      qemu-pr-helper (LP 2117378)
    - d/control-in: breaks/replaces for dtb files moving qemu-system-misc
      to qemu-system-data
    - d/rules: Use upstream vDSO for architecture variant builds (LP 213123=
6)
  * Updated delta:
    - d/p/u/define-ubuntu-machine-types.patch: update to match 10.2
  * Dropped changes:
    - d/p/u/lp2121787/* : Fix migration issues because of missing features
      (LP 2121787)
      [Fixed in upstream 10.2]
    - d/p/u/lp-2123828-*: Fix RISC-V instructions endianness (LP 2123828)
      [Fixed in upstream 10.2]

qemu (1:10.2.1+ds-1) unstable; urgency=3Dmedium

  * new upstream stable/bugfix release
    (Closes: #1123670, CVE-2025-14876)
  * - fix-PIRQ-bounds-check-in-xen_physdev_map_pirq-CVE-2026-0665.patch
  * remove ipxe from FIRMWAREPATH (needs ipxe from trixie and up)

qemu (1:10.2.0+ds-2) unstable; urgency=3Dmedium

  * two patches to make statically-linked linux-user not depend on nss
    (remove linkage to qemu-sockets.c)
  * 1095935.patch (Closes: #1095935)
  * d/control: qemu-user: mention possibility to sym-link files in
    /usr/share/qemu/binfmt.d/ to /etc/binfmt.d/
  * d/rules: remove workaround for #1019011 for palcode-clipper -
    the bug in gcc has been fixed (in 2022)
  * d/control: better versioned dependencies of qemu modules: use
    qemu-system-common as a syncronisation point instead of qemu-system-any
    (Closes: LP#2127053)
  * d/control: finally de-couple qemu-system-riscv and qemu-system-s390x
    from qemu-system-misc (remove misc:Depends: riscv, s390x)
  * fix-PIRQ-bounds-check-in-xen_physdev_map_pirq-CVE-2026-0665.patch
    (Closes: #1125423, CVE-2026-0665)
  * d/copyright: fix Files/License sections

qemu (1:10.2.0+ds-1) unstable; urgency=3Dmedium

  * new upstream release
  * d/gbp.conf: switch to 10.2
  * d/patches: refresh
  * d/control.mk: checked-version: 10.2.0+ds, vdso-version: 1:10.2.0+ds-1~
  * d/copyright: rename u-boot-sam460ex bin following upstream change
  * d/copyright: add pc-bios/npcm[78]xx_bootrom.bin to Files-Excluded
  * d/rules: adjust for u-boot-sam460ex rename, work around build bug,
    provide a compat symlink for now
  * d/control.mk: 32bit mips and powerpc hosts are not supported anymore

qemu (1:10.1.3+ds-1) unstable; urgency=3Dmedium

  [ Michael Tokarev ]
  * new upstream stable/bugfix release 10.1.3
    Closes: #1119917, CVE-2025-12464 (buffer overflow in e1000_receive_iov)
    Closes: #1117153, CVE-2025-11234 (UAF in websocket handshake code)
  * d/qemu-user.postinst: add the forgotten `set -e'
  * d/rules: enable vnc-sasl and vnc password (through nettle)
    for xen build (Closes: #1041533)
  * remove patches applied upstream:
    - linux-user-use-correct-type-for-FIBMAP-and-FIGETBSZ.patch
    - tcg-arm-fix-tgen_deposit.patch

  [ Heinrich Schuchardt ]
  * d/rules: reword build-vdso comment

qemu (1:10.1.2+ds-3) unstable; urgency=3Dmedium

  * d/control: qemu-system-xen: add the forgotten ipxe-qemu dependency
    qemu-system binaries require pxe boot roms for the network adaptors.
    When splitting qemu-system-xen into its own package, this dependency
    has been forgotten initally, but has been enabled for bookworm (#103567=
6).
    However, this change were lost when uploading the next version of qemu
    aimed for trixie.  So trixie has this issue too, despite it's been fixed
    in bookworm already.  (Closes: #1035676, #1120146)

qemu (1:10.1.2+ds-2) unstable; urgency=3Dmedium

  * d/control: bump seabios dependency to 1.17.0 due to ESP fixes
  * linux-user-use-correct-type-for-FIBMAP-and-FIGETBSZ.patch
    (Closes: #1119257)

qemu (1:10.1.2+ds-1) unstable; urgency=3Dmedium

  * new upstream stable/bugfix release
    Closes: #1112285 (assertion failure in qemu-system-alpha)
    Fixes migration from 10.0 and earlier

qemu (1:10.1.1+ds-1) unstable; urgency=3Dmedium

  [ Michael Tokarev ]
  * new upstream stable/bugfix release
    Closes: #1082377, CVE-2024-8354
  * removed patches included upstream:
    - block-curl-fix-curl-internal-handles-handling.patch
    - e1000e-prevent-crash-from-legacy-interrupt-firing-af.patch
    - ui-spice-fix-crash-when-disabling-GL-scanout-on.patch
    - hw-vfio-user-add-x-pci-class-code.patch
  * d/control.mk: checked-version :=3D 10.1.1+ds
  * d/control: add python3-distlib:native build-dep variant due to #1115197
  * aarch64-linux-user-no-pauth.patch: disable pauth on aarch64 linux-user
    by default (Closes: #1113951)

  [ Luca Boccassi ]
  * qemu-guest-agent: add ConditionVirtualization=3Dvm
  * qemu-guest-agent: add Documentation=3D referring to manpages

 -- Hector Cao <hector.cao@canonical.com>  Tue, 17 Feb 2026 02:02:42
+0100

** Changed in: qemu (Ubuntu Resolute)
       Status: In Progress =3D> Fix Released

** CVE added: https://cve.org/CVERecord?id=3DCVE-2024-8354

** CVE added: https://cve.org/CVERecord?id=3DCVE-2025-11234

** CVE added: https://cve.org/CVERecord?id=3DCVE-2025-12464

** CVE added: https://cve.org/CVERecord?id=3DCVE-2025-14876

** CVE added: https://cve.org/CVERecord?id=3DCVE-2026-0665

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2133804

Title:
  QEMU does not emulate IOCTL TCGETS2

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Jammy:
  Confirmed
Status in qemu source package in Noble:
  Confirmed
Status in qemu source package in Plucky:
  Won't Fix
Status in qemu source package in Questing:
  Confirmed
Status in qemu source package in Resolute:
  Fix Released

Bug description:
  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of
  TCGETS. TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-
  arm64, ...).

  This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.=20
  A detailed analysis is contained in LP #2133188.

  A proper implementation of the missing IOCTLs will include:

  Functions:

  in linux-user/syscall.c:
  host_to_target_termios2()
  target_to_host_termios2()
  print_termios2()

  Definitions:

  in linux-user/syscall.c
  #define termios2 host_termios2

  in linux-user/syscall_types.h
  STRUCT_SPECIAL(termios2)

  in linux-user/ioctls.h:
  IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))

  in linux-user/user-internals.h:
  void print_termios2(void *arg);

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2133804/+subscriptions


