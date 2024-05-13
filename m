Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE44DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VgG-0004KJ-EN; Mon, 13 May 2024 09:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1s6VgF-0004Jn-0A
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:25:27 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1s6VgC-0005Du-E4
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:25:26 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 92B2B4ADED
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1715606721;
 bh=MZlAKF0oJU4PD9nUXxqK72KRnjrxNhyszq3mK/P4w9I=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=e/F/G4MxbOo+YxgMplxojzJC558He9LZV0NUB7Jy+4mgGrtqnqFCU+wcpA3K/Xnls
 aJmdTIXDks7PR2WbfXP9nP1ENeWy2fzIf0+WsoDpR7UNt/OJ5D5R9AmpVOI6eajfe2
 cKInwQ/R7XnMkoZgEB/4yPRTjZQ2NjA4XOCb5bctUI0sSl9etMQzoyS5FlYtxA27W8
 27WEwmSyjloHWgOg8NLZ6wsacRBYquyuevz7a1lPpCm0pI8zGYEYgpBbr1KvdPHzX6
 PEeRnHQPY+bAKZr182JUsL+WIBmNN8ykMbzTAR+tmpWm1wJry3Ab+3Xb5fV5s8hnLS
 cREMhw7RXGE9g==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 804D27E00F
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 13:25:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 May 2024 13:18:04 -0000
From: Sergio Durigan Junior <2065579@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=ubuntu-z-systems; status=New; importance=Undecided;
 assignee=skipper-screen-team; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=sergio.durigan@canonical.com; 
X-Launchpad-Bug-Tags: architecture-s39064 bugnameltc-206380 severity-critical
 targetmilestone-inin---
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugproxy sergiodj
X-Launchpad-Bug-Reporter: bugproxy (bugproxy)
X-Launchpad-Bug-Modifier: Sergio Durigan Junior (sergiodj)
References: <171559617548.234481.1609401859991330301.malonedeb@juju-98d295-prod-launchpad-7>
Message-Id: <171560628417.1908563.9111532389196118447.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 2065579] Re: [UBUNTU 22.04] OS guest boot issues on 9p filesystem
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0e1f616671af724398db43b36ddfb3ed1f2682ec";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 9b59f7adf07a058ba86a778cb0070e7581af3bf5
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 2065579 <2065579@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thank you for the report.

Given that this is an upstream regression and there is a related
upstream bug about it, I believe it's best to wait for their
input/feedback before moving forward.

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Changed in: qemu (Ubuntu)
     Assignee: (unassigned) =3D> Sergio Durigan Junior (sergiodj)

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2065579

Title:
  [UBUNTU 22.04] OS guest boot issues on 9p filesystem

Status in Ubuntu on IBM z Systems:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  =3D=3D=3D Reported by <d.herrendoerfer@de.ibm.com> - 2024-05-13 03:53:01 =
=3D=3D=3D

  ---Problem Description---
  OS guest boot issues on 9p filesystem due to unix domain sockets open fai=
lure
  =20
  Contact Information =3D d.herrendoerfer@de.ibm.com=20
  =20
  Machine Type =3D 3931-7G4=20
  =20
  ---uname output---
  5.15.0-92-generic #102-Ubuntu SMP Wed Jan 10 09:35:24 UTC 2024 s390x s390=
x s390x GNU/Linux
  =20
  ---Steps to Reproduce---
   #!/bin/bash

  # Cleanup target dir
  [ -d ./target ] && rm -rf target
  mkdir target

  # Add configuration updates
  mkdir -p ./target/etc/initramfs-tools/
  echo 9p >> ./target/etc/initramfs-tools/modules
  echo 9pnet_virtio >> ./target/etc/initramfs-tools/modules

  # Add the test script
  cat > ./target/test_init << EOF
  #!/bin/bash

  echo "Test for unix domain sockets"

  nc -Ul /socket &
  sleep 1
  echo "Sockets work" | nc -UN /socket || echo "Sockets fail"

  echo o > /proc/sysrq-trigger
  sleep 999
  EOF
  chmod 700 ./target/test_init

  # Create an Ubuntu 23.10 around it
  echo "Creating Ubuntu target OS"
  debootstrap --variant=3Dminbase\
              --include=3Dudev,kmod,initramfs-tools,systemd,netcat-openbsd,=
linux-image-generic \
              --exclude=3Dman,bash-completion \
              mantic ./target > /dev/null || exit 1

  # Run the test in 9p forwarded filesystem
  echo "Running OS in qemu"
  qemu-system-s390x \
    -m 8192 \
    -smp 4 \
    -nodefaults -nographic -no-reboot -no-user-config \
    -kernel ./target/boot/vmlinuz \
    -initrd ./target/boot/initrd.img \
    -append 'root=3DfsRoot rw rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,ve=
rsion=3D9p2000.L,msize=3D512000,cache=3Dmmap,posixacl console=3Dttysclp0 in=
it=3D/test_init quiet' \
    -fsdev local,security_model=3Dpassthrough,multidevs=3Dremap,id=3Dfsdev-=
fsRoot,path=3D./target \
    -device virtio-9p-pci,id=3DfsRoot,fsdev=3Dfsdev-fsRoot,mount_tag=3DfsRo=
ot \
    -device virtio-serial-ccw -device sclpconsole,chardev=3Dconsole \
    -chardev stdio,id=3Dconsole,signal=3Doff=20

  =20
  ---Debugger---
  A debugger is not configured

  Userspace rpm: qemu-(current).deb=20
  =20
  Userspace tool common name: qemu=20

  Userspace tool obtained from project website:  na=20
  =20
  The userspace tool has the following bit modes: both=20
  =20
  *Additional Instructions for d.herrendoerfer@de.ibm.com:
  -Attach ltrace and strace of userspace application.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu-z-systems/+bug/2065579/+subscriptions


