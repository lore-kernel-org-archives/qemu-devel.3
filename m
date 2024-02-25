Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B766C54798
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 16:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reHmh-0008M1-Oo; Sun, 25 Feb 2024 11:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1reHmg-0008Le-4t
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:55:26 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1reHmd-0007qs-CD
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:55:25 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A63423F9CF
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1708880116;
 bh=VUNMwVpdkN2FmXHlcpYOVfrdSGUEQ2DEp1ty/w2jwX8=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=RFisW3xCkXawlwVhI/pL378qEZ2Y9JTpzuIgSUec0TGDwh1jPINoEzc+6AZaZabu+
 InJK0bi1P0LFnWVLzIss1II7uvJJJ+7tEs9coJRVsCFKMUIh38a4yXyOuAdK8lGgVs
 YdJZnP4vBfY2mPyRO9j9bCVOfpuFQJmm6MlU0LZVhl5BFPkwatrw0ooLVDkWfzf+y7
 Ri4+24ioyiBl+b1naGHOoVoYJqjJMMBBstPxRwEdcg1qAGMEpSdL8tUgAqxFM+AMsD
 nCBHsip/3qveMtj7IhzMPpIoawVMP3GnOwqa+LfRQRZJir9RRL0IQULzzmAofQvqzp
 VPI1b2ZdvNqHg==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 96C4B7E2C6
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 16:55:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Feb 2024 16:46:13 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <2054889@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: pcap usb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fysnet philmd
X-Launchpad-Bug-Reporter: Benjamin David Lunt (fysnet)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd=29?=
References: <170879673718.858735.7795185871522080358.malonedeb@juju-98d295-prod-launchpad-4>
Message-Id: <170887957315.1973561.1801135968014195536.malone@juju-98d295-prod-launchpad-4>
Subject: [Bug 2054889] Re: pcap streams are text files which insert 0xD in
 Windows version
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9643586c585856148a18782148972ae9c1179d06";
 Instance="launchpad-scripts"
X-Launchpad-Hash: e239269b32334f3d24536c79f699caefec0fd463
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Bug 2054889 <2054889@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Benjamin,

QEMU bug tracker is on GitLab:
https://gitlab.com/qemu-project/qemu/-/issues

But instead of re-opening the issue there, since you
already figured the problem, do you mind directly post
your patch? See guidelines there:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html

Thanks!

Phil.

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2054889

Title:
  pcap streams are text files which insert 0xD in Windows version

Status in QEMU:
  Confirmed

Bug description:
  Since Windows text files use CRLFs for all \n, the Windows version of
  QEMU inserts a CR in the PCAP stream when a LF is encountered when
  using USB PCAP files.

  Starting at line 275 in hw/usb/bus (https://gitlab.com/qemu-
  project/qemu/-/blob/master/hw/usb/bus.c?ref_type=3Dheads#L275), the file
  is opened as text instead of binary.

  I think the following patch would fix the issue:
      if (dev->pcap_filename) {
  -       int fd =3D qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |=
 O_TRUNC, 0666);
  +       int fd =3D qemu_open_old(dev->pcap_filename, O_CREAT | O_WRONLY |=
 O_TRUNC | O_BINARY, 0666);
          if (fd < 0) {
              error_setg(errp, "open %s failed", dev->pcap_filename);
              usb_qdev_unrealize(qdev);
              return;
          }
  -       dev->pcap =3D fdopen(fd, "w");
  +       dev->pcap =3D fdopen(fd, "wb");
          usb_pcap_init(dev->pcap);
      }

  To show an example, when using a very common protocol to USB disks,
  the BBB protocol uses a 10-byte command packet. For example, the
  READ_CAPACITY(10) command (implemented at https://gitlab.com/qemu-
  project/qemu/-/blob/master/hw/scsi/scsi-disk.c#L2068) will have a
  command block length of 10 (0xA). When this 10-byte command (part of
  the 31-byte CBW) is placed into the PCAP file, the Windows file
  manager inserts a 0xD before the 0xA, turning the 31-byte CBW into a
  32-byte CBW.

  Actual CBW:
    0040   55 53 42 43 01 00 00 00 08 00 00 00 80 00 0a 25   USBC..........=
..
    0050   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      %..............

  PCAP CBW
    0040   55 53 42 43 01 00 00 00 08 00 00 00 80 00 0d 0a   USBC..........=
..
    0050   25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   %..............

  I believe simply opening the PCAP file as BINARY instead of TEXT will
  fix this issue.

  Thank you.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2054889/+subscriptions


