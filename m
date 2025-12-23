Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4413E6FE20
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4ev-0008VC-HV; Tue, 23 Dec 2025 10:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4er-0008TT-Uz
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:45 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4eq-0005Mk-96
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 73DC143621;
 Tue, 23 Dec 2025 15:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892D1C113D0;
 Tue, 23 Dec 2025 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505035;
 bh=mof38+MpXjy7kmH/7m/QVKCE3ELgPk2HuAM0cB01sTM=;
 h=From:To:Cc:Subject:Date:From;
 b=j9Q1b+AOkkpwZ5lOkAplmXFxOMTMbjOtCvSmbL6fpxg2PrcTRj4s2pA1JTmMP3G6a
 DZFww3wjFaHTQemJXhmRX/e7A8b5q+/QYNUzDzGXWX9A5fzGJOFw3cLI9IQiPzMfYf
 ngGxong0xZhR40tNn6WHjkRdrY9g7LGaTZfvKigSoZ4+hxIK4Zsh8wdjhLYbntwPH2
 3CzvwX3teBPOlMIt2KNpnD/gayvpX+v5PUb8AYjwk/Nx5kJLP/iX8VT6CZ682VwFy9
 OaPQ1M1c8BAjpBqVi7Ob5rXxUFqEftM4Jv2ucZWokqihinxzDIzJ9y+duXZHigAMkg
 DAdXYIlhMCReg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 00/12] Hppa updates qemu v11 patches
Date: Tue, 23 Dec 2025 16:50:19 +0100
Message-ID: <20251223155031.7110-1-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

The following changes since commit 8dd5bceb2f9cc58481e9d22355a8d998220896de:

  Open 11.0 development tree (2025-12-23 14:45:38 +1100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-updates-qemu-v11-pull-request

for you to fetch changes up to b2c2d00f48cc5f4486cfba33b505ff86d79cb137:

  target/hppa: add 64 bit support to gdbstub (2025-12-23 16:41:56 +0100)

----------------------------------------------------------------
Please pull fixes and updates for the parisc architecture:

- New SeaBIOS-hppa v21 mit fixes for 715 machine
- ncr710 fixes for NetBSD and HP-UX on 715 machine
- 64-bit gdb support

Thanks!
Helge

----------------------------------------------------------------

Helge Deller (1):
  target/hppa: Update SeaBIOS-hppa to version 21

Soumyajyotii Ssarkar (10):
  scsi: ncr710: Add null pointer checks
  scsi: ncr710: Fix use after free in command_complete
  scsi: ncr710: Fix interrupt related register handing
  scsi: ncr710: Fix DMA State machine and flow control
  scsi: ncr710: Fix table indirect addressing endianness
  scsi: ncr710: Mark command complete in status phase and fix disconnect
  scsi: ncr710: Add LUN scanning
  scsi: ncr710: Simplify disconnect handling
  scsi: ncr710: Fix DSA register
  scsi: ncr710: Fix CTEST FIFO status

Sven Schnelle (1):
  target/hppa: add 64 bit support to gdbstub

 hw/scsi/ncr53c710.c         |  93 +++++++++++++++++++++++++++---------
 pc-bios/hppa-firmware.img   | Bin 630644 -> 628952 bytes
 pc-bios/hppa-firmware64.img | Bin 700304 -> 692032 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/gdbstub.c       |  62 ++++++++++++++++--------
 5 files changed, 112 insertions(+), 45 deletions(-)

-- 
2.52.0


