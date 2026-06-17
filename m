Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20D6CD98ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 23:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa024-0004QB-T5; Wed, 17 Jun 2026 19:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa022-0004PV-6e
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:54 -0400
Received: from p-east2-cluster1-host3-snip4-4.eps.apple.com ([57.103.76.7]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa01y-0003u4-3d
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:53 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id
 6058C18000A9; Wed, 17 Jun 2026 23:50:40 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQ5YWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtZAkIPSAVcAFkBRQlLAUMFWgZJCFUCQFoDWBFaF1EeWAVyHVxWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1781740243; x=1784332243; bh=dOkWAKGUqvyBpKTA4REXJkOI5M/fMWouhwMDLS0dqVk=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=vT7yj3/OBJrIdkp03OCG8+VjuCW3w7qzjF6Isvc0PN67sZAWNl4x15WEZ/UHpbRrOoKAXlt7Bmjy9bpj94VpGmU6+Od6BFuvt25MGU+Cbo31XP+Xa3+mwsDhRx3tS4WJ+5QU0ErDglTzeogunrqxvH0XikasKJno2ifSCfAiilynX3wK7deP7ZUyjODO88sM2x5E2L9WCPJY9kFDzflxsCW2jZgRF+zvAuK9eA5rK9Tl0xLJGt4yJmFkUv6qEvUoGGC3BUCwQLYhZEg4Dck9uaBtXR3AGY4clHsqmjE0C1VYPOnTrKUiBPmaCb19Tp+Kqxbx8rEtC57zoI0u+iIt3g==
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id
 01B821800118; Wed, 17 Jun 2026 23:50:38 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v2 0/5] hw/m68k: add working floppy controller for q800
Date: Wed, 17 Jun 2026 19:50:27 -0400
Message-ID: <20260617235032.21491-1-mhjacobson@me.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDIyOCBTYWx0ZWRfX6qleBnB/lmqu
 K6rIPfR+apfMvyAdMLNu0d1Z6rBYlpVWJhcN0AKbuykg21TJR2tuESH7j497w+jQO0ZiUMg78Fm
 6wqEZ1XuY6GwYvBdOvUZKpA7pc8Ynn8WBL+4ZnTejGqxEbmxGRy+WYQTwfqaJXQyq4wlcEY906T
 +rEvYr6kLDqSZEJV5Czb/G9v8oz3xFM0TVxWBU+EzJjxbqaXHN2PUiCb2Pqk3v8IvPQBSw40GVf
 LUFS8M7nTiHGwqn2WjyjqOm+ln4u4ZubpfHxT++aaumTEYEz/H1BEofwa/N5qcjahbWr+8iBaCd
 Xa1iYuf2Lkc9iX3qz1Y
X-Proofpoint-GUID: g47TRW65BuY0x4M5qsM97jWYBdk8aovY
X-Proofpoint-ORIG-GUID: g47TRW65BuY0x4M5qsM97jWYBdk8aovY
Received-SPF: pass client-ip=57.103.76.7; envelope-from=mhjacobson@me.com;
 helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the SWIM2 floppy controller and SuperDrive for the q800 machine.

Reading and writing work, and booting a system disk works.
Both GCR and MFM paths work.
Tested with the Quadra 800 ROM running System 7 and A/UX 3.x.
Whole-disk formatting/duplication does not yet work.

Example usage:
$ qemu-system-m68k \
   -machine q800 \
   -m 128 \
   -bios "Quadra800.ROM" \
   -nodefaults \
   -drive if=mtd,file="pram.img",format=raw \
   -drive if=floppy \
   -drive if=floppy \
   -drive if=scsi,media=disk,file="harddisk.img",format=raw \
   -drive if=scsi,media=cdrom \
   -nic user,model=dp83932 \
   -audio none \
   -display cocoa \
   -name "Macintosh Quadra 800"

(To populate the floppy drive at boot, use
 `-drive if=floppy,file="floppy.img",format=raw`.  However, note that the
 Macintosh ROM will eject non-bootable floppies on boot.)

The Sony drive emulator takes raw images and will generate the GCR/MFM
encoding on the fly.  Here are a couple sample images (HFS) to play with:

<https://mjacobson.net/files/mac-disks/floppy-800.img>
<https://mjacobson.net/files/mac-disks/floppy-1440.img>

Matt Jacobson (5):
  hw/block: add Sony/Apple "SuperDrive" diskette drive
  fifo32: add fifo32_peek()
  hw/block: add SWIM2 floppy controller for q800
  hw/m68k: add working floppy controller for q800
  hw/block: remove unused SWIM1 floppy controller stub

 MAINTAINERS                        |   2 -
 hw/block/meson.build               |   2 +-
 hw/block/sony_superdrive.c         | 994 +++++++++++++++++++++++++++++
 hw/block/swim.c                    | 577 -----------------
 hw/block/swim2.c                   | 722 +++++++++++++++++++++
 hw/block/trace-events              |  25 +-
 hw/m68k/q800.c                     |   5 +-
 hw/misc/mac_via.c                  |  16 +
 include/hw/block/sony_superdrive.h |  56 ++
 include/hw/block/swim.h            |  72 ---
 include/hw/block/swim2.h           |  60 ++
 include/hw/m68k/q800.h             |   4 +-
 include/hw/misc/mac_via.h          |   4 +
 include/qemu/fifo32.h              |  25 +
 14 files changed, 1901 insertions(+), 663 deletions(-)
 create mode 100644 hw/block/sony_superdrive.c
 delete mode 100644 hw/block/swim.c
 create mode 100644 hw/block/swim2.c
 create mode 100644 include/hw/block/sony_superdrive.h
 delete mode 100644 include/hw/block/swim.h
 create mode 100644 include/hw/block/swim2.h

-- 
2.53.0


