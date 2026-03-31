Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011DA10F92EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eCR-0000At-Pn; Tue, 31 Mar 2026 14:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCQ-0000AT-6k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:26 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCO-0001Wp-IE
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:25 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CB2B4441E1;
 Tue, 31 Mar 2026 18:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1680C2BCB3;
 Tue, 31 Mar 2026 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983142;
 bh=7SlH6C3OwgyA3Yes0hnZPE80m/4oX0nbkdJFmwhyzXI=;
 h=From:To:Cc:Subject:Date:From;
 b=h/jQh9O6gFKHWZb8UXUrsxjwiFHFYxQ4LKw4ralxQYoHcfMjJbI8xnLAPr4oEer6Z
 oRIPxMQAfBgAKYev+9ajoli+BYFaeB+yuex1m1Y/hQdwwbCZsDV8m/fZQUsnG3mQp8
 bg2535NxoLxv2EKyZpQcgpDb9L4o+wdUiJC4k5QPgyO7Hbl6a1s190v+Rarhn/W6MU
 zoTBhY0ptdfxWL9OyYbsQFP/Ac0lT1CVYvGfD4o/RUCldnhgvCplye2d6C2+7nGSBl
 l6Kt0GXjQI0BVRVO7Gld/PkXgoGRZIihMubJnY0ayLhEzLecr1IX59/2bEcjXCJZx8
 tp0OfXlH2LypA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/8] Hppa more v11 fixes patches
Date: Tue, 31 Mar 2026 20:52:11 +0200
Message-ID: <20260331185219.12187-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:

  Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-more-v11-fixes-pull-request

for you to fetch changes up to bf758751aa4d088f8d7bead7d335d028bcbb89d6:

  target/hppa: Update SeaBIOS-hppa to version 24 (2026-03-31 20:24:24 +0200)

----------------------------------------------------------------
HPPA patches for qemu-v11

A few late fixes for the HPPA architecture for QEMU v11:
- graphics support was broken for 64-bit machines. This series adds
  support for VGA graphics for Linux guests
- the various memory ranges were not correctly implemented
- TOC/NMI was not working on 64-bit machines
- minor 64-bit HP-UX boot fixes (but HP-UX 64-bit still crashes)

----------------------------------------------------------------

Helge Deller (8):
  hw/pci-host/astro: Make astro address arrays accessible for other
    users
  hw/pci-host/astro: Fix initial addresses in IOC
  hw/pci-host/astro: Implement LMMIO registers
  hw/pci-host/astro: Fix LMMIO DIRECT mappings
  hw/pci-host/astro: Add GMMIO mapping
  target/hppa: Fix TOC handler for 64-bit CPUs
  hw/hppa: Implement memory ranges
  target/hppa: Update SeaBIOS-hppa to version 24

 hw/hppa/hppa_hardware.h     |   3 +-
 hw/hppa/machine.c           |  58 +++++++---
 hw/pci-host/astro.c         | 209 ++++++++++++++++++++++++++++++------
 include/hw/pci-host/astro.h |  12 ++-
 pc-bios/hppa-firmware.img   | Bin 631968 -> 632780 bytes
 pc-bios/hppa-firmware64.img | Bin 714440 -> 665208 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/int_helper.c    |   7 +-
 8 files changed, 238 insertions(+), 53 deletions(-)

-- 
2.53.0


