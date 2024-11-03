Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7328D1118C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 20:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7glT-000230-P5; Sun, 03 Nov 2024 14:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t7glS-00022Z-JC
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 14:59:58 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1t7glQ-0007AY-23
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 14:59:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C6FA35C4BF3;
 Sun,  3 Nov 2024 19:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EA3C4CECD;
 Sun,  3 Nov 2024 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730663984;
 bh=vQo3qH15XFFycg9P338rnmP8GR3HPX0/65ajYZ2tyvw=;
 h=From:To:Cc:Subject:Date:From;
 b=QiUcnk4DtWKr7NlXU1LGLN2ITdfdi242I3zoKEwcSfvkCzumX3SFta+a1P20PZL4n
 fAj/6lK6y/nFpZYz4uKpvfXUP5bvYJFEF30fgc+yjFRIoH7XQbORAUVffrC+tLXjbv
 j5L44N0D5DuIjYrcrmdlabpagoi+DtgpnzuDEQmicGU0BMSFfIxUFeLrdUvO0utiiw
 DyWVzHifmx9pqnTmtTJe/4aaUWT/B24f+cMSFn/eIzlpnK1hFfXmBJ7g/rBqBiClJf
 KS6mAc/ImVpI7EBvMIiKjyv3fBYCfAhqM1YsCY+bmm2sH/I9eNhgr0QLHleXGwgkwa
 c8xWgDf+E8nBg==
From: deller@kernel.org
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 0/1] Seabios hppa v17 patches
Date: Sun,  3 Nov 2024 20:59:40 +0100
Message-ID: <20241103195941.22724-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:

  Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/seabios-hppa-v17-pull-request

for you to fetch changes up to c9d77526bddba0803a1fa982fb59ec98057150f9:

  target/hppa: Update SeaBIOS-hppa to version 17 (2024-11-03 20:46:06 +0100)

----------------------------------------------------------------
SeaBIOS-hppa v17 pull request

Please pull a single commit, which updates SeaBIOS-hppa
to version 17.

If comes with some important firmware and SCSI fixes and
prepares for futher development to support 64-bit HP-UX
and MPE/UX in the future.

New PDC functions & general enhancements:
- Add PDC_MODEL_GET_INSTALL_KERNEL firmware call
- Add PDC_PAT_EVENT firmware call
- Support ENTRY_IO_BOOTOUT
- Prefer memory-access over io-access of GSP serial port
- Disable LMMIO_DIRECT0 range during modification
- Small optimizations in IODC call

Fixes:
- esp-scsi: indicate acceptance of MESSAGE IN phase data
- Avoid crash when booting without SCSI controller
- Remove exec flag from hppa-firmware.img
- Fix LMMIO detection for PCI cards on Astro/Elroy
- Avoid trashing MPE IPL bootloader stack
- HP-UX 11 64-bit saves number of RAM pages in PAGE0 at 0x33c
- Fix return value of PDC_CACHE/PDC_CACHE_RET_SPID for space id hashing
- Allow PDC functions to act when called in narrow mode
- pcidevice: Use portaddr_t for io port addresses

Cleanups:
- Change default make target to "parisc"
- Clean the "out-64" directory on "make clean"

----------------------------------------------------------------

Helge Deller (1):
  target/hppa: Update SeaBIOS-hppa to version 17

 pc-bios/hppa-firmware.img   | Bin 167820 -> 676760 bytes
 pc-bios/hppa-firmware64.img | Bin 206024 -> 763416 bytes
 roms/seabios-hppa           |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)
 mode change 100755 => 100644 pc-bios/hppa-firmware.img
 mode change 100755 => 100644 pc-bios/hppa-firmware64.img

-- 
2.47.0


