Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D1CC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7bcP-0003II-Gj; Fri, 18 Sep 2026 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bbl-0003F7-0x; Fri, 18 Sep 2026 12:38:44 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7bbh-0002gR-QX; Fri, 18 Sep 2026 12:38:39 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59177602CC;
 Fri, 18 Sep 2026 16:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4D71F000FF;
 Fri, 18 Sep 2026 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789749514;
 bh=pWNeBHc+f9ljCdHz/4l/u0sJ1FBlEryXStNBANyH2CI=;
 h=From:To:Cc:Subject:Date;
 b=YWpQAWuWovQPFJzeRbeAKG7BvrW7ReQ1BEXbjUfpCDswYXY4rIONzHGbPwCNZD2Qr
 Cznd7rzrxzqqZY61mSlGIqflwigZ8YeWOsVYdZQIV0NBkVdZGf27H2vAm6CaveTD9G
 bnQTOyqrhN3IyixTle887cEWgKqWHlWPg3bosMjPK4FvPiWgzpQKPB0gA1Mue9YzU3
 XWUMdRgI370WEeti4kM5wKntIrupalMb3XDklX3mOJggprHPPOLb2DgOVH2b+0SiER
 GQzcIxJ9feJ5XyqalzL+5EeNECh/KAeUMx0kFTwAtFLDLSwvykJbB/nEIj8q8ICuk1
 hZPYHHl7pd67g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Helge Deller <deller@gmx.de>, "Denis V. Lunev" <den@openvz.org>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
Subject: [PULL 0/7] Superio hppa patches
Date: Fri, 18 Sep 2026 18:38:21 +0200
Message-ID: <20260918163829.2917-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The following changes since commit 209b2afaface001c7d4d981e38f186afe7b24a50:

  Merge tag 'pull-parallels-2026-09-11' of https://gitlab.com/dlunev/qemu into staging (2026-09-10 22:02:18 -1000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/superio-hppa-pull-request

for you to fetch changes up to a8b79b2d9c50165df1d974de078f951bc4628662:

  hw/hppa: Add NS 87560 SuperIO chip to HP C3700 machine (2026-09-16 20:28:42 +0200)

----------------------------------------------------------------
NS 87560 SuperIO chip

This series adds the emulation of a "NS 87560 SuperIO chip".
The SuperIO chip includes a floppy controller, two serial ports, one parallel
port, an IDE controller and one OHCI USB port.

This National Semiconductor SuperIO chip was commonly used in many HP PA-RISC
B- and C-class workstations, as in the HP C3700 machine which is being
emulated by QEMU already. The last patch wires up this SuperIO driver to the
existing C3700 machine emulation.

This driver was developed during the last few months by Abizer Lokhandwala
<abizerlokhandwalastd10@gmail.com> and mentored and reviewed by me.

----------------------------------------------------------------

Abizer Lokhandwala (6):
  hw/isa/pc87560: Add main isa code for NS 87560 SuperIO chip
  hw/ide/pc87560-ide: Add IDE emulation of NS 87560 SuperIO chip
  hw/usb/hcd-ohci: Add big endian and consistency check support
  hw/usb/pc87560-ohci: Add USB OHCI emulation of NS 87560 SuperIO chip
  hw/pc87560: Wire up emulation of NS 87560 SuperIO chip
  hw/hppa: Add NS 87560 SuperIO chip to HP C3700 machine

Helge Deller (1):
  hw/pci/pci_ids: Add PCI vendor ID and IDs for NS chips

 MAINTAINERS              |   4 +
 hw/hppa/machine.c        |  41 +++-
 hw/ide/meson.build       |   1 +
 hw/ide/pc87560-ide.c     | 358 +++++++++++++++++++++++++++
 hw/ide/trace-events      |   4 +
 hw/isa/Kconfig           |  11 +
 hw/isa/meson.build       |   1 +
 hw/isa/pc87560.c         | 510 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c        |  35 +++
 hw/usb/hcd-ohci.h        |   5 +
 hw/usb/meson.build       |   1 +
 hw/usb/pc87560-ohci.c    | 355 +++++++++++++++++++++++++++
 include/hw/isa/pc87560.h |  96 ++++++++
 include/hw/pci/pci_ids.h |   5 +
 14 files changed, 1420 insertions(+), 7 deletions(-)
 create mode 100644 hw/ide/pc87560-ide.c
 create mode 100644 hw/isa/pc87560.c
 create mode 100644 hw/usb/pc87560-ohci.c
 create mode 100644 include/hw/isa/pc87560.h

-- 
2.54.0


