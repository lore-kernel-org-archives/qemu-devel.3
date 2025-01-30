Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97129C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUbn-0004fV-DJ; Thu, 30 Jan 2025 08:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbk-0004el-VL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:24 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbi-0001OH-Nj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:24 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6C58C5C03D9;
 Thu, 30 Jan 2025 13:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02451C4CED2;
 Thu, 30 Jan 2025 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738243758;
 bh=7L3vxVRBhnBd73IAX8h6VNWGsI3XBLcDKRqsDeTBSek=;
 h=From:To:Cc:Subject:Date:From;
 b=Z6qbdXIgcMAbndTyOerxGe1tFt2slewtZv0jZPDoTs3nQ9749HnUtQalmagZzmoEs
 73gTMqHcTydbEYmfcEYb66qZGcPn44jmj0Bexum92xUvPRHbWUWft0JyxKx1z7E4eG
 tf7TB42JByZcPsKyygbA2HKa5jE8o9U1fS8FNLsVIJ0Bv9UdjZNVw+uywKa426TfSM
 naBcR9DjQsKwskNJ/bo/eqAqGl2uLdn9Z3Lj9tEtsXSW9SnPASAld3TXyseYM+j/HC
 oevOpYtMPOVtzcAvWzM8mWO4UttDYrw6VEIdUvjpcOPXPlOJR/sQ0cKi5J9geJoKJN
 b/5cKBUgQA2Aw==
From: deller@kernel.org
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 0/9] Hppa system mfdiag for v10 patches
Date: Thu, 30 Jan 2025 14:29:05 +0100
Message-ID: <20250130132915.16846-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 7faf9d2f12ace4c1d04cf1a2b39334eef9a45f22:

  Merge tag 'pull-aspeed-20250127' of https://github.com/legoater/qemu into staging (2025-01-27 11:20:35 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-system-mfdiag-for-v10-pull-request

for you to fetch changes up to 75564679bbd00e875cc1727050db5cf731e94036:

  target/hppa: Update SeaBIOS-hppa to version 18 (2025-01-30 14:16:58 +0100)

----------------------------------------------------------------
hppa 64-bit mfdiag improvements

The 64-bit hppa qemu emulation still fails to boot 64-bit HP-UX.
This patch series improves the emulation a lot, since it enables us to boot
64-bit HP-UX installer silently up until an endless loop where the machine
reports that it's up an running (it crashed before). This still needs further
analysis, but it's a big step forward.

Main changes to archieve this includes:
- Implementing diagnose registers (especially %dr2 for space-register hashing)
- a new SeaBIOS-hppa version 18, which includes those fixes and enhancements:
  - Fix IRT table entries to use slot number
  - Increase PCI alignment for memory bars to 64k
  - Fix PDC_CACHE/PDC_CACHE_RET_SPID return value
  - Allow up to 256 GB RAM on 64-bit machines

----------------------------------------------------------------

Helge Deller (9):
  MAINTAINERS: Add myself as HPPA maintainer
  hppa: Sync contents of hppa_hardware.h header file with SeaBIOS-hppa
  disas/hppa: implement mfdiag/mtdiag disassembly
  target/hppa: Add CPU diagnose registers
  target/hppa: Drop diag_getshadowregs_pa2 and diag_putshadowregs_pa2
  target/hppa: Add instruction decoding for mfdiag and mtdiag
  target/hppa: 64-bit CPUs start with space register hashing enabled
  target/hppa: Implement space register hashing for 64-bit HP-UX
  target/hppa: Update SeaBIOS-hppa to version 18

 MAINTAINERS                 |   5 +++--
 disas/hppa.c                |  23 +++++++++++++++++++++--
 hw/hppa/hppa_hardware.h     |  36 ++++++++++++++++++++++++++++++++----
 pc-bios/hppa-firmware.img   | Bin 676760 -> 167644 bytes
 pc-bios/hppa-firmware64.img | Bin 763416 -> 206104 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/cpu.c           |  14 ++++++++++++--
 target/hppa/cpu.h           |  21 +++++++++------------
 target/hppa/helper.c        |  25 +++++++++++++++++++++++--
 target/hppa/helper.h        |   1 +
 target/hppa/insns.decode    |   6 ++++--
 target/hppa/int_helper.c    |  10 ++++++----
 target/hppa/machine.c       |   5 +++--
 target/hppa/mem_helper.c    |   5 +++++
 target/hppa/sys_helper.c    |   4 ++--
 target/hppa/translate.c     |  32 +++++++++++++++++++++++++-------
 16 files changed, 147 insertions(+), 42 deletions(-)
 mode change 100644 => 100755 pc-bios/hppa-firmware.img
 mode change 100644 => 100755 pc-bios/hppa-firmware64.img

-- 
2.47.0


