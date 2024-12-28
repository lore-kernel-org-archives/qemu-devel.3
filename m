Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6429E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 12:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRVUj-0003Ah-K2; Sat, 28 Dec 2024 07:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tRVUZ-00039l-EM; Sat, 28 Dec 2024 07:00:33 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tRVUX-0006h2-Hl; Sat, 28 Dec 2024 07:00:27 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id A44A0CC83A;
 Sat, 28 Dec 2024 14:59:39 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 42B704615C; Sat, 28 Dec 2024 14:54:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 00/11] Trivial patches for 2024-12-28
Date: Sat, 28 Dec 2024 14:54:35 +0300
Message-Id: <20241228115446.2478706-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following changes since commit 38d0939b86e2eef6f6a622c6f1f7befda0146595:

  Merge tag 'pull-vfio-20241226' of https://github.com/legoater/qemu into staging (2024-12-26 04:38:38 -0500)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 1e3d4d9a1a32ac6835f0d295a5117851c421fb5d:

  qmp: update vhost-user protocol feature maps (2024-12-28 14:42:53 +0300)

----------------------------------------------------------------
trivial patches for 2024-12-28

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      hw/riscv/riscv-iommu-sys.c: fix duplicated 'table_size'

Han Han (1):
      target/i386/cpu: Fix notes for CPU models

Laurent Vivier (1):
      qmp: update vhost-user protocol feature maps

Philippe Mathieu-Daudé (3):
      docs: Correct '-runas' and '-fsdev/-virtfs proxy' indentation
      docs: Correct release of TCG trace-events removal
      docs: Replace 'since' -> 'removed in' in removed-features.rst

Pierrick Bouvier (2):
      docs/devel: remove dead video link for sourcehut submit process
      vvfat: fix ubsan issue in create_long_filename

Zhao Liu (2):
      hw/timer/hpet: Fix comment about capabilities register
      hw/timer/hpet: Drop the unused macro

ckf104 (1):
      contrib/plugins/bbv.c: Start bb index from 1

 block/vvfat.c                     |  4 ++++
 contrib/plugins/bbv.c             |  2 +-
 docs/about/deprecated.rst         |  2 +-
 docs/about/removed-features.rst   | 24 ++++++++++++------------
 docs/devel/submitting-a-patch.rst |  5 +----
 hw/riscv/riscv-iommu-sys.c        |  2 +-
 hw/timer/hpet.c                   |  2 +-
 hw/virtio/virtio-qmp.c            |  6 ++++++
 include/hw/timer/hpet.h           |  1 -
 target/i386/cpu.c                 |  3 ++-
 10 files changed, 29 insertions(+), 22 deletions(-)

