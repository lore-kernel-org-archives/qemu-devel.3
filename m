Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7BACF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkmy-0001to-Rj; Fri, 04 Oct 2024 12:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmQ-0001nR-3B; Fri, 04 Oct 2024 12:03:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmO-0001Tp-4K; Fri, 04 Oct 2024 12:03:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C938195565;
 Fri,  4 Oct 2024 19:03:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 00BDD14D973;
 Fri,  4 Oct 2024 19:03:31 +0300 (MSK)
Received: (nullmailer pid 1282501 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/23] Trivial patches for 2024-10-04
Date: Fri,  4 Oct 2024 19:03:08 +0300
Message-Id: <20241004160331.1282441-1-mjt@tls.msk.ru>
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

The following changes since commit 423be09ab9492735924e73a2d36069784441ebc6:

  Merge tag 'warn-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-03 10:32:54 +0100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 6b7d2f6e1896fb675e8518ed61c792d4dd92e034:

  MAINTAINERS: Add myself as maintainer of e500 machines (2024-10-04 18:57:38 +0300)

----------------------------------------------------------------
trivial patches for 2024-10-04

- many dead code removals by Dr. David Alan Gilbert
- forgotten minor bugfixes (vnc, resource freeing in qemu-keymap)
- some more..

----------------------------------------------------------------
Akihiko Odaki (1):
      qemu-keymap: Release local allocation references

Bernhard Beschow (1):
      MAINTAINERS: Add myself as maintainer of e500 machines

Dr. David Alan Gilbert (14):
      hw/xen: Remove deadcode
      q35: Remove unused mch_mcfg_base
      net: Remove deadcode
      hw/net/net_rx_pkt: Remove deadcode
      hw/char: Remove unused serial_set_frequency
      linux-user: Remove unused handle_vm86_fault
      hw: Remove unused fw_cfg_init_io
      ui/cursor: remove cursor_get_mono_image
      vhost: Remove unused vhost_dev_{load|save}_inflight
      remote: Remove unused remote_iohub_finalize
      replay: Remove unused replay_disable_events
      hw/pci: Remove unused pcie_chassis_find_slot
      hw/net/rocker: Remove unused rocker_fp_ports
      block-backend: Remove deadcode

Laurent Vivier (1):
      MAINTAINERS: remove gensyscalls.sh from the linux-user section

Marc-André Lureau (1):
      vnc: fix crash when no console attached

Peter Maydell (1):
      docs/devel: Mention post_load hook restrictions where we document the hook

Philippe Mathieu-Daudé (2):
      hw/audio/virtio-snd: Remove unnecessary "exec/tswap.h" header
      hw/mips: Build fw_cfg.c once

Thomas Huth (2):
      tests/tcg/plugins: Remove remainder of the cris target
      tests/functional: Fix hash validation

 MAINTAINERS                                 |   7 +-
 block/block-backend.c                       |  73 ---------------
 docs/devel/migration/main.rst               |   6 ++
 docs/devel/replay.rst                       |   3 +
 hw/audio/virtio-snd.c                       |   1 -
 hw/char/serial.c                            |   7 --
 hw/mips/meson.build                         |   2 +-
 hw/net/net_rx_pkt.c                         |  13 ---
 hw/net/net_rx_pkt.h                         |  17 ----
 hw/net/rocker/rocker.c                      |   5 -
 hw/net/rocker/rocker.h                      |   1 -
 hw/nvram/fw_cfg.c                           |   5 -
 hw/pci-host/q35.c                           |  10 --
 hw/pci/pcie_port.c                          |  10 --
 hw/remote/iohub.c                           |  13 ---
 hw/virtio/vhost.c                           |  56 ------------
 hw/xen/xen-legacy-backend.c                 |  18 ----
 hw/xen/xen_devconfig.c                      |   8 --
 include/hw/char/serial.h                    |   2 -
 include/hw/nvram/fw_cfg.h                   |   1 -
 include/hw/pci-host/q35.h                   |   2 -
 include/hw/pci/pcie_port.h                  |   1 -
 include/hw/remote/iohub.h                   |   1 -
 include/hw/virtio/vhost.h                   |   2 -
 include/hw/xen/xen-legacy-backend.h         |   5 -
 include/net/net.h                           |   4 -
 include/net/queue.h                         |   4 -
 include/sysemu/block-backend-global-state.h |   8 --
 include/sysemu/replay.h                     |   2 -
 include/ui/console.h                        |   1 -
 linux-user/user-internals.h                 |   1 -
 linux-user/vm86.c                           | 136 ----------------------------
 net/hub.c                                   |  25 -----
 net/net.c                                   |  10 --
 net/queue.c                                 |  11 ---
 qemu-keymap.c                               |   9 +-
 replay/replay-events.c                      |   9 --
 tests/functional/qemu_test/asset.py         |   2 +-
 tests/tcg/plugins/syscall.c                 |   1 -
 ui/cursor.c                                 |  24 -----
 ui/vnc.c                                    |   2 +-
 41 files changed, 22 insertions(+), 496 deletions(-)

