Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693A4C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVXs-0005PO-QV; Fri, 07 Feb 2025 16:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXq-0005Os-P6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXo-0001rs-Lm
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8EC495C110C;
 Fri,  7 Feb 2025 21:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35ADC4CEE2;
 Fri,  7 Feb 2025 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738962343;
 bh=i30A6zdXGXg5q05tpROTHVEGAeB8sw9Tt3VVFiD0kek=;
 h=From:To:Cc:Subject:Date:From;
 b=oBnoABzIzmrF8vyT4s0QgtkImIJ8IsmKysJsumh4LY2AvkQCw+VLE/jkqb8x74x6T
 o+uhBQXjBbDcKa2nMGcgj5oXSemTTL1yg+MG7Q7U9QdbaG0Dq2Y9Xpju4slL9Hmoy5
 GFRxuzo5Gt1YlK31UQFs4r2anBH3BiqKbfa6sJOU5irGQv+/ifiE0KU/SGeBB8zjQM
 kTR4P6Ps3UCX1Bd03fHZ6m1LvRVME5zBKILoMepzHsx+1NswvJx8L/18oLsDCkUMYx
 XzRfG0AspskPH0++VjNFT1jr/p145MOdU9IwVNq7O1lQPdBR/8Vn8HncpDQ4Yxpx43
 I2NDJA+H/WsbA==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/6] Hppa system for v10 diva artist patches
Date: Fri,  7 Feb 2025 22:05:34 +0100
Message-ID: <20250207210540.24594-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit 6fccaa2fba391815308a746d68f7fa197bc93586:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-02-02 11:09:10 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-system-for-v10-diva-artist-pull-request

for you to fetch changes up to 3dc340f8a7cfbc30193ab269aad1a5a6026365a6:

  target/hppa: Update SeaBIOS-hppa (2025-02-04 23:07:05 +0100)

----------------------------------------------------------------
HPPA graphics and serial console enhancements

A small series of patches which enhance the graphics output on 64-bit hppa
machines. Allow disabling the artist graphic card and introduces drivers for
the Diva GSP (remote management) cards which are used in later 64-bit machines
and which we now use for serial console output.

The LMMIO regions of the Astro chip are now supported too, which is important
to support other graphic cards like an ATI PCI card with a 64-bit Linux kernel.

----------------------------------------------------------------

Helge Deller (6):
  hw/char: Add emulation of Diva GSP PCI management boards
  hw/hppa: Wire up Diva GSP card
  artist: Allow disabling artist on command line
  hw/hppa: Avoid creation of artist if disabled on command line
  hw/pci-host/astro: Add LMMIO range support
  target/hppa: Update SeaBIOS-hppa

 MAINTAINERS                 |   1 +
 hw/char/Kconfig             |   3 +
 hw/char/diva-gsp.c          | 297 ++++++++++++++++++++++++++++++++++++
 hw/char/meson.build         |   1 +
 hw/display/artist.c         |   9 +-
 hw/hppa/Kconfig             |   1 +
 hw/hppa/machine.c           |  42 +++--
 hw/pci-host/astro.c         |  52 +++++++
 include/hw/pci-host/astro.h |   6 +-
 roms/seabios-hppa           |   2 +-
 10 files changed, 383 insertions(+), 31 deletions(-)
 create mode 100644 hw/char/diva-gsp.c

-- 
2.47.0


