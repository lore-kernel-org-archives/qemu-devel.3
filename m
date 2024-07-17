Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0139C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Uw-0000Xz-By; Wed, 17 Jul 2024 07:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Ug-0007tz-61; Wed, 17 Jul 2024 07:06:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Ud-0007R5-J4; Wed, 17 Jul 2024 07:06:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DCB337B372;
 Wed, 17 Jul 2024 14:06:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4FF3D10B287;
 Wed, 17 Jul 2024 14:06:40 +0300 (MSK)
Received: (nullmailer pid 844381 invoked by uid 1000);
 Wed, 17 Jul 2024 11:06:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/16] Trivial patches for 2024-07-17
Date: Wed, 17 Jul 2024 14:06:24 +0300
Message-Id: <20240717110640.844335-1-mjt@tls.msk.ru>
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

The following changes since commit e2f346aa98646e84eabe0256f89d08e89b1837cf:

  Merge tag 'sdmmc-20240716' of https://github.com/philmd/qemu into staging (2024-07-17 07:59:31 +1000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 66a8de9889ceb929e2abe7fb0e424f45210d9dda:

  meson: Update meson-buildoptions.sh (2024-07-17 14:04:15 +0300)

----------------------------------------------------------------
trivial patches for 2024-07-17

----------------------------------------------------------------
Michael Tokarev (1):
      block/curl: rewrite http header parsing function

Thomas Huth (1):
      tests/avocado: Remove the non-working virtio_check_params test

Zhao Liu (13):
      accel/kvm/kvm-all: Fix superfluous trailing semicolon
      hw/i386/x86: Fix superfluous trailing semicolon
      util/oslib-posix: Fix superfluous trailing semicolon
      target/hexagon/imported/mmvec: Fix superfluous trailing semicolon
      doc/net/l2tpv3: Update boolean fields' description to avoid short-form use
      hw/i386/sgx: Get rid of qemu_open_old()
      hw/usb/host-libusb: Get rid of qemu_open_old()
      hw/usb/u2f-passthru: Get rid of qemu_open_old()
      hw/vfio/container: Get rid of qemu_open_old()
      backends/hostmem-epc: Get rid of qemu_open_old()
      backends/iommufd: Get rid of qemu_open_old()
      backends/rng-random: Get rid of qemu_open_old()
      meson: Update meson-buildoptions.sh

Zhihai Dong (1):
      README.rst: add the missing punctuations

 README.rst                             |   6 +-
 accel/kvm/kvm-all.c                    |   2 +-
 backends/hostmem-epc.c                 |   4 +-
 backends/iommufd.c                     |   3 +-
 backends/rng-random.c                  |   5 +-
 block/curl.c                           |  44 +++++-----
 hw/i386/sgx.c                          |   6 +-
 hw/i386/x86.c                          |   2 +-
 hw/usb/host-libusb.c                   |   3 +-
 hw/usb/u2f-passthru.c                  |   4 +-
 hw/vfio/container.c                    |   6 +-
 qemu-options.hx                        |  10 +--
 scripts/meson-buildoptions.sh          |  14 ++--
 target/hexagon/imported/mmvec/ext.idef |   2 +-
 tests/avocado/virtio_check_params.py   | 143 ---------------------------------
 util/oslib-posix.c                     |   2 +-
 16 files changed, 48 insertions(+), 208 deletions(-)
 delete mode 100644 tests/avocado/virtio_check_params.py

