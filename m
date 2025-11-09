Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704E7CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDYx-0007cV-GS; Sun, 09 Nov 2025 17:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYu-0007Zz-Nu
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:04 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYr-0005rh-Si
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F05E439B2;
 Sun,  9 Nov 2025 22:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B5EC4CEF7;
 Sun,  9 Nov 2025 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762726017;
 bh=X1UKHCY7sUexdXxDOTH9zYAzpArYzYhsLKxl1GCrkgo=;
 h=From:To:Cc:Subject:Date:From;
 b=aZJbLDomFG8h7sBl0lY3h3C8/QRvxD4SqechirMGAopeXx0WJi3i8eBudph+ZRU8n
 DGzt0V0L1t0fqvCVo/lKI1nWlORFfQXTwd8K/rr8GQ4gvgpbbNXiUXzBqXuPNGp2lF
 9TFqDmMXQ3OUZVou8vhMviCmm7KAhSK1PwlluX8BjcW2R1mDaPZPLVU4nH8GHxt4f+
 GGuLtkDwMmPtZ9VHLuTF86AvOWHS/C0WyPH2wgZS1NYCvzJAYEzG1dOGJE74vzIBao
 4nCmWRCMO4rNcD0h7ISScK1NJ6goDLleJd9+Cpzx+72GXyCs3a0RmYAU7VYu14uhHb
 AK87IbnVLZ9vg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/7] Lasi fixes patches
Date: Sun,  9 Nov 2025 23:06:47 +0100
Message-ID: <20251109220654.46718-1-deller@kernel.org>
X-Mailer: git-send-email 2.51.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/lasi-fixes-pull-request

for you to fetch changes up to 8c1fa9cbecba50ae7e732923ee567fe40551d1a6:

  target/hppa: Update SeaBIOS-hppa to version 20 (2025-11-09 22:47:31 +0100)

----------------------------------------------------------------
hppa lasi bugfixes pull request

Please pull a bunch of fixes which repair issues introduced due to the previous
patch series which added LASI SCSI and LASI network card support as  well as
the new 715 machines.
This includes fixes for reported coverty issues, and repairs the B160L machine
emulation.

Thanks!
Helge

----------------------------------------------------------------

Helge Deller (1):
  target/hppa: Update SeaBIOS-hppa to version 20

Soumyajyotii Ssarkar (6):
  ncr710: Fix potential null pointer dereference
  ncr710: Drop leftover debug code
  i82596: Remove crc_valid variable
  i82596: Adding proper break-statement functionality in RX functions
  ncr710: Add missing vmstate entries
  ncr710: Use address space of device instead of global address space

 hw/net/i82596.c             |  14 +++++---------
 hw/scsi/lasi_ncr710.c       |   4 ++++
 hw/scsi/lasi_ncr710.h       |   1 -
 hw/scsi/ncr53c710.c         |  16 +++++-----------
 hw/scsi/ncr53c710.h         |   1 +
 pc-bios/hppa-firmware.img   | Bin 630056 -> 630644 bytes
 pc-bios/hppa-firmware64.img | Bin 699872 -> 700304 bytes
 roms/seabios-hppa           |   2 +-
 8 files changed, 16 insertions(+), 22 deletions(-)

-- 
2.51.1


