Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA1EC54E4A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz53-0007Ai-Cd; Sat, 09 Mar 2024 10:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz4y-00079E-O7; Sat, 09 Mar 2024 10:57:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz4w-0004Fp-EF; Sat, 09 Mar 2024 10:57:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A5DC454525;
 Sat,  9 Mar 2024 18:58:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 02976944BA;
 Sat,  9 Mar 2024 18:57:29 +0300 (MSK)
Received: (nullmailer pid 1694643 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/11] Trivial patches for 2024-03-09
Date: Sat,  9 Mar 2024 18:57:18 +0300
Message-Id: <20240309155729.1694607-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 84644ac1b0f80d41b8a2f66547b83b2ad4a98576:

  Merge tag 'darwin-20240305' of https://github.com/philmd/qemu into staging (2024-03-08 18:19:25 +0000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to d65f1ed7de1559534d0a1fabca5bdd81c594c7ca:

  docs/acpi/bits: add some clarity and details while also improving formating (2024-03-09 18:56:37 +0300)

----------------------------------------------------------------
trivial patches for 2024-03-09

----------------------------------------------------------------
Ani Sinha (1):
      docs/acpi/bits: add some clarity and details while also improving formating

BALATON Zoltan (1):
      hw/scsi/lsi53c895a: Fix typo in comment

Frediano Ziglio (1):
      hw/vfio/pci.c: Make some structure static

Markus Armbruster (4):
      replay: Improve error messages about configuration conflicts
      char: Slightly better error reporting when chardev is in use
      blockdev: Fix block_resize error reporting for op blockers
      qerror: QERR_DEVICE_IN_USE is no longer used, drop

Michael Tokarev (1):
      make-release: switch to .xz format by default

Thomas Huth (3):
      hw/cxl/cxl-cdat: Fix type of buf in ct3_load_cdat()
      hw/pci-bridge/cxl_upstream: Fix problem with g_steal_pointer()
      hw/mem/cxl_type3: Fix problem with g_steal_pointer()

 blockdev.c                   |  3 +--
 chardev/char-fe.c            | 13 ++++++-----
 docs/devel/acpi-bits.rst     | 55 +++++++++++++++++++++++++++++++-------------
 hw/cxl/cxl-cdat.c            |  4 ++--
 hw/mem/cxl_type3.c           | 24 +++++++++----------
 hw/pci-bridge/cxl_upstream.c |  8 +++----
 hw/scsi/lsi53c895a.c         |  2 +-
 hw/vfio/pci.c                |  4 ++--
 include/hw/cxl/cxl_cdat.h    | 17 +++++++++-----
 include/qapi/qmp/qerror.h    |  3 ---
 replay/replay.c              |  2 +-
 scripts/make-release         |  2 +-
 system/vl.c                  |  2 +-
 13 files changed, 82 insertions(+), 57 deletions(-)

