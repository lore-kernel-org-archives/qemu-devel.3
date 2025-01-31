Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4048C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdnEW-0008Ff-9W; Fri, 31 Jan 2025 04:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnET-0008F7-UM
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:37 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnES-0004D7-8y
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5651EA41A13;
 Fri, 31 Jan 2025 09:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DB0C4CED1;
 Fri, 31 Jan 2025 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738315352;
 bh=tSxeE/sRbmffRXrJyJ0O2JkG1kIsmAeqggF38ldeStk=;
 h=From:To:Cc:Subject:Date:From;
 b=GZcRk8UQGNymzyCntZl7c8jY6BTgOJQaoqDznLThoW7bomVxJq8jMmOByQDOZCARF
 IM8BJUi6dd3SPqkvSJDxrqvWdZPdiGnVEm0mA0Ejx3fWLFvhL1w5+Td6+lFS2OmQPU
 s7Z61oL/98lCbbh4THNXCRIQKjfDYNf1R0azPfI8+t6Zz0mjYik2HRYf7+lxSg743k
 Wn/EMXd5ars7FA/WG/VXan+M+eveVzP4nwefDcIgZn/Dm0hm83wei3+aFj2UCJYwTO
 7YUFIdMYtL/WTh1RUjhEfByAnxJm3SLf11wedHsN2bfALHdtVm2Scn/CqRK90o46ah
 A7pX9LI54Y6qw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL v2 0/9] Hppa system mfdiag for v10 patches
Date: Fri, 31 Jan 2025 10:22:20 +0100
Message-ID: <20250131092229.38232-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

for you to fetch changes up to db34be329162cf6b06192703065e6c1010dbe3c5:

  target/hppa: Update SeaBIOS-hppa to version 18 (2025-01-31 10:05:42 +0100)

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

V2:
- fix linux-user build by adding missing "#ifndef CONFIG_USER_ONLY ... #endif"

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
 target/hppa/translate.c     |  34 +++++++++++++++++++++++++++-------
 16 files changed, 149 insertions(+), 42 deletions(-)
 mode change 100644 => 100755 pc-bios/hppa-firmware.img
 mode change 100644 => 100755 pc-bios/hppa-firmware64.img

-- 
2.47.0


