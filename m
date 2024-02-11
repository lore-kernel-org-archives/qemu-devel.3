Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3740CC4829A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xj-00069b-Fc; Sun, 11 Feb 2024 07:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xe-00067F-AA
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:30 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xa-0006Ev-4R
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DAB0ECE0D8D;
 Sun, 11 Feb 2024 12:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65A7C433F1;
 Sun, 11 Feb 2024 12:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654553;
 bh=42639UTSmLWJeJIJeFabwNnZnB2iUY4WSUaIbRKscWk=;
 h=From:To:Cc:Subject:Date:From;
 b=uGladiPQHtvOhpmZjMSlG2W9TQxr4GveyYeqyB7OwnPKiIYS/+7Oj0V7dd8YML2+0
 h7tufvzkifUBAfXqvTQIpmdoo4Fz+0Q+1ySnu+EHKZ8CrTMu51Ovd2RqYf/G81o1o5
 aZ2nJdhtkih7TAcrqTLv3yYKyGAMJaSm53+8Vm2/emMb467ZzP8RRUHjhH0l7biZpa
 2Dku7wDtOnZGf0bf9v0BGHYDqgS1dc7BWlhG5YMpNbzjQSunaDj6aAsWwoHHMDBv/4
 AUCzybqDT5XqkFc+45xL56dDeJ52xD7zgkfCvaIwT95YlUs1pr6QBkQ8DVY7+fx64E
 vfKyBiaV5towQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 00/12] Hppa64 patches
Date: Sun, 11 Feb 2024 13:28:57 +0100
Message-ID: <20240211122909.5807-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
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

for you to fetch changes up to f9d2270c85872bd71a01e15b2ebda2569f17f811:

  hw/hppa/machine: Load 64-bit firmware on 64-bit machines (2024-02-11 13:25:15 +0100)

----------------------------------------------------------------
target/hppa: Enhancements and fixes

A new SeaBIOS-hppa firmware which is built as 32- and 64-bit firmware.
Necessary to fully support 64-bit operating systems (HP-UX, Linux, NetBSD,...).

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

 disas/hppa.c                |   4 ++++
 hw/hppa/machine.c           |  11 ++++++++---
 hw/misc/lasi.c              |  13 +++++++++++++
 hw/net/tulip.c              |   4 ++--
 hw/pci-host/astro.c         |  36 ++++++++++++++++++++----------------
 include/hw/misc/lasi.h      |   2 ++
 include/hw/pci-host/astro.h |   2 ++
 pc-bios/hppa-firmware.img   | Bin 163324 -> 167820 bytes
 pc-bios/hppa-firmware64.img | Bin 0 -> 206024 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/cpu.c           |   1 +
 target/hppa/cpu.h           |   5 +++++
 target/hppa/helper.h        |   1 +
 target/hppa/mem_helper.c    |  21 ++++++++++++++++++++-
 target/hppa/sys_helper.c    |  36 ++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c     |  14 +++++++++++++-
 16 files changed, 128 insertions(+), 24 deletions(-)
 mode change 100644 => 100755 pc-bios/hppa-firmware.img
 create mode 100755 pc-bios/hppa-firmware64.img

-- 
2.43.0


