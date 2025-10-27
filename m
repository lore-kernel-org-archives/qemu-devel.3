Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69345CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 21:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUaY-0002Z2-Si; Mon, 27 Oct 2025 17:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZl-0002UQ-Vz
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:32 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZh-0004yV-87
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 59DF840736;
 Mon, 27 Oct 2025 21:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D4EC4CEF1;
 Mon, 27 Oct 2025 21:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761599767;
 bh=qJav4LEByyAmB7GnA4fejUpxL8R67WGBXXFjtGCpBrg=;
 h=From:To:Cc:Subject:Date:From;
 b=G4XjvkWFE7L16lV1kXgNKsrVPS4ZCkqi9zNw1UBDydEmKH+EdPAkEgmALQSlslPX5
 I+3NFFIUBXAlMkb62fEnHCjqgdag0vcWoeTteArByAL438pxDBQLKSEJ7EbRznNr8a
 5ViW8e4LN9Tvwyi4hIHkWwJZXtXAyxVHaGbJZ9Jz8frKaxf/NrE6adIg0CmmAMeQpL
 xBnBU4L881WhsskBDtzmPLL8lcoJbMpgExRbgOw1XXzfXI4zGHktzapNRiD8xzeV43
 rPueM74ruz9C4XgCbSgKuiJphWmeqXxNJG3yhaXvnp0ifHZhVn5q984pxwTEB1TDm+
 z05Q8yw5/qnBQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
Subject: [PULL 00/11] Devel scsi ncr710 patches
Date: Mon, 27 Oct 2025 22:15:52 +0100
Message-ID: <20251027211603.7141-1-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The following changes since commit 3bf5c57a11827d9fa706524d57ee3e5af68a429e:

  Merge tag 'pull-tcg-20251014' of https://gitlab.com/rth7680/qemu into staging (2025-10-14 10:25:05 -0700)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/devel-scsi-ncr710-pull-request

for you to fetch changes up to 95a3f921811ba3f817538580ee7b85336dd16e39:

  hw/hppa: Add 715 machine type including NCR710 SCSI (2025-10-27 22:13:22 +0100)

----------------------------------------------------------------
HP-PARISC 715 machine with NCR710 SCSI chip

This series adds a new emulation for a HP PA-RISC 715/64 model,
as descrived here: https://www.openpa.net/systems/hp-9000_715.html.

That machine has no PCI bus and instead uses a "LASI" chip which has built-in
NCR 53c710 SCSI and i82596 network chips. Compared to the other already
emulated machines B160L and C3700, this machine should be able to support older
operating systems like HP-UX 9 as well.

The QEMU project participated in the Google Summer of Code 2025 program by
"Implementing LASI Network Card and NCR 710 SCSI Controller Device Models", and
Soumyajyotii Ssarkar stepped up to develop those drivers.

This patch series includes the code for the NCR710 SCSI controller,
the network code will follow in later patch series.

----------------------------------------------------------------

Helge Deller (7):
  target/hppa: Update SeaBIOS-hppa to version 19
  hw/hppa: Fix firmware end address for LASI chip
  hw/hppa: Fix interrupt of LASI parallel port
  hw/hppa: Add NCR 710 SCSI driver to LASI chip Kconfig entry
  hw/hppa: PCI devices depend on availability of PCI bus
  hw/hppa: Require SeaBIOS version 19 for 715 machine
  hw/hppa: Add 715 machine type including NCR710 SCSI

Soumyajyotii Ssarkar (4):
  lasi_ncr710: Add LASI wrapper for NCR 53c710 SCSI chip
  ncr710: Add driver for the NCR 53c710 SCSI chip
  lasi: Forward LASI SCSI ports to NCR 53c710 driver
  hw/scsi: Add config option for new ncr710 driver

 MAINTAINERS                 |    2 +
 hw/hppa/Kconfig             |    2 -
 hw/hppa/hppa_hardware.h     |    3 +-
 hw/hppa/machine.c           |  146 ++-
 hw/misc/Kconfig             |    5 +
 hw/misc/lasi.c              |    6 +-
 hw/scsi/Kconfig             |    5 +
 hw/scsi/lasi_ncr710.c       |  282 ++++
 hw/scsi/lasi_ncr710.h       |   57 +
 hw/scsi/meson.build         |    1 +
 hw/scsi/ncr53c710.c         | 2432 +++++++++++++++++++++++++++++++++++
 hw/scsi/ncr53c710.h         |  246 ++++
 hw/scsi/trace-events        |   29 +
 include/hw/misc/lasi.h      |    2 +
 pc-bios/hppa-firmware.img   |  Bin 167644 -> 630056 bytes
 pc-bios/hppa-firmware64.img |  Bin 206104 -> 699872 bytes
 roms/seabios-hppa           |    2 +-
 17 files changed, 3191 insertions(+), 29 deletions(-)
 create mode 100644 hw/scsi/lasi_ncr710.c
 create mode 100644 hw/scsi/lasi_ncr710.h
 create mode 100644 hw/scsi/ncr53c710.c
 create mode 100644 hw/scsi/ncr53c710.h

-- 
2.51.0


