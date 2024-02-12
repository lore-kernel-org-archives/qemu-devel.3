Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE50C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 23:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZg1N-0003A1-01; Mon, 12 Feb 2024 18:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1L-00039V-F6
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:31 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZg1J-00007C-Ji
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 18:47:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EBBF06117F;
 Mon, 12 Feb 2024 23:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E5FC433C7;
 Mon, 12 Feb 2024 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707781646;
 bh=YaIoEXiZmAWD90yvUSHBh9yHf8dD8ng/dQA6IDTeBNw=;
 h=From:To:Cc:Subject:Date:From;
 b=i8sHoVcZdDnvM2AuZPmItf5Xr8NufvOhvpZTRORHFUY5Rtv8FAfw38VrLnPP5Q6Pr
 V1X3LOwG8jDRyh0H17yrHsv/WAdvOA4EchuBxSrXWuj5xjMLvOAxe7yAiVy0+z8Xug
 7odoAIowLBjmZpw3NH/mlOAJFzMKwe4xpMKitMGtfIXIySLPcszf7FijtH1mQytJNK
 zgnBSDu9dIKRM6USMROJLbI1Hr258wW81AIFuip2tc/zkOEzi3O+qUa87HCTFNcrPG
 ALfHHvPffk8CO5nqdkI3rQRgPWf47kE0LuIwocCbMNbToaDKoImlphz7JTQ3b/5tUd
 rj2kZe56FMTfQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 00/12] Hppa64 patches
Date: Tue, 13 Feb 2024 00:47:11 +0100
Message-ID: <20240212234723.222847-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:

  Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa64-pull-request

for you to fetch changes up to a9314795f068515ff5925d0f68adf0a3215f6d2d:

  hw/hppa/machine: Load 64-bit firmware on 64-bit machines (2024-02-13 00:44:06 +0100)

----------------------------------------------------------------
target/hppa: Enhancements and fixes

Some enhancements and fixes for the hppa target.

The major change is, that this patchset adds a new SeaBIOS-hppa firmware
which is built as 32- and 64-bit firmware.
The new 64-bit firmware is necessary to fully support 64-bit operating systems
(HP-UX, Linux, NetBSD,...).

----------------------------------------------------------------

Helge Deller (11):
  disas/hppa: Add disassembly for qemu specific instructions
  target/hppa: Add "diag 0x101" for console output support
  hw/pci-host/astro: Avoid aborting on access failure
  hw/pci-host/astro: Implement Hard Fail and Soft Fail mode
  lasi: allow access to LAN MAC address registers
  target/hppa: Implement do_transaction_failed handler for I/O errors
  lasi: Add reset I/O ports for LASI audio and FDC
  target/hppa: Allow read-access to PSW with rsm 0,reg instruction
  target/hppa: PDC_BTLB_INFO uses 32-bit ints
  target/hppa: Update SeaBIOS-hppa to version 16
  hw/hppa/machine: Load 64-bit firmware on 64-bit machines

Sven Schnelle (1):
  hw/net/tulip: add chip status register values

 disas/hppa.c                |   4 +++
 hw/hppa/machine.c           |  52 +++++++++++++++++++++---------------
 hw/misc/lasi.c              |  13 +++++++++
 hw/net/tulip.c              |   4 +--
 hw/pci-host/astro.c         |  36 ++++++++++++++-----------
 include/hw/misc/lasi.h      |   2 ++
 include/hw/pci-host/astro.h |   2 ++
 pc-bios/hppa-firmware.img   | Bin 163324 -> 167820 bytes
 pc-bios/hppa-firmware64.img | Bin 0 -> 206024 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/cpu.c           |   1 +
 target/hppa/cpu.h           |   5 ++++
 target/hppa/helper.h        |   1 +
 target/hppa/mem_helper.c    |  21 ++++++++++++++-
 target/hppa/sys_helper.c    |  36 +++++++++++++++++++++++++
 target/hppa/translate.c     |  14 +++++++++-
 16 files changed, 150 insertions(+), 43 deletions(-)
 mode change 100644 => 100755 pc-bios/hppa-firmware.img
 create mode 100755 pc-bios/hppa-firmware64.img

-- 
2.43.0


