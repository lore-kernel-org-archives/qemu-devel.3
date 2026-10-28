Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143D606BFB6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SO0C5VrT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8zP-0008Ky-8u; Wed, 28 Oct 2026 15:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8zM-0008Jx-CX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:08 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8zK-0004Jy-DE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA59E6020A;
 Wed, 28 Oct 2026 19:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC21F01825;
 Wed, 28 Oct 2026 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793214424;
 bh=lrhRMSXyaLtPI5qfSuKxVLUA+Vt0MWld4FO1DUHH/YY=;
 h=From:To:Cc:Subject:Date;
 b=SO0C5VrTfrgR5bMsYOhzj3RjS1FBLOsQ7VD1ZFkSd4dzSNaAvFGd/d9nue6fcci6f
 pwON6LCkZ/R0+ljyEhgai9SDphothPupIF3WS23WGdKHKcuBu+YWOntPKSfEXUtXvY
 LgpULjKlU7gRCjVw04FGCM6hOxvQjvDvilPsziwsxYBt4w/p3D3Xos7suL7t5UUy8k
 8gN3DrhGfMOe+AXJAOojSboZu87dMRCN4R4g5c5hMXmy1QjnFqwXOJLpitdazNgAK/
 wvMNLl+KBZQS0oOQlj/TA8x1UbPEnar79eyIT6gQbu7lLgV245nfK/fD7XYHwLOx0h
 sBJv0I0Sh8seA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PULL v2 0/9] Hppa 715 2 patches
Date: Wed, 28 Oct 2026 20:06:52 +0100
Message-ID: <20261028190701.17272-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:

  Merge tag 'qga-pull-2026-10-28' of https://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-715-2-pull-request

for you to fetch changes up to 4d5bc20de77152cecb4acdf63afe0db761b2abcf:

  target/hppa: Update SeaBIOS-hppa to version 27 (2026-10-28 20:00:56 +0100)

----------------------------------------------------------------
HPPA architecture patches for HP-UX 9 and 715 machine

A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
Includes a graphics/artist fix, adjustment to 15 bits for protection IDs on
the 32-bit CPUs and various other parts which were missing up to now.
Included is also the FPU patche from Kirill A. Korinsky.

To fully support HP-UX 9.05 an additional NCR710 patch series will follow soon.

----------------------------------------------------------------

Helge Deller (3):
  hw/misc/lasi: LASI Harmony Audio presence emulation
  target/hppa: Map CPUs at same addresses as on physical machines
  target/hppa: Update SeaBIOS-hppa to version 27

Keith Monahan (5):
  target/hppa: Use 15 bit protection IDs on PA1.1 CPUs
  target/hppa: Only allow 8 BTLB entries for HP-UX 9.05
  target/hppa: Implement local broadcast I/O space
  target/hppa: Preload I/O-space BTLB entries for LASI and the central
    bus
  artist: Redraw screen on colormap changes

Kirill A. Korinsky (1):
  target/hppa: restore lazy FPU context isolation

 hw/display/artist.c                   |   6 +
 hw/hppa/machine.c                     | 106 +++++++-
 hw/misc/lasi.c                        |  15 +-
 pc-bios/hppa-firmware.img             | Bin 641484 -> 634968 bytes
 pc-bios/hppa-firmware64.img           | Bin 682800 -> 682880 bytes
 roms/seabios-hppa                     |   2 +-
 target/hppa/cpu.c                     |   1 +
 target/hppa/cpu.h                     |   4 +-
 target/hppa/helper.h                  |   1 +
 target/hppa/mem_helper.c              |  25 +-
 target/hppa/translate.c               |  61 ++++-
 tests/functional/hppa/test_seabios.py |   6 +-
 tests/qtest/hppa-fpu-test.c           | 371 ++++++++++++++++++++++++++
 tests/qtest/meson.build               |   2 +
 14 files changed, 578 insertions(+), 22 deletions(-)
 create mode 100644 tests/qtest/hppa-fpu-test.c

-- 
2.54.0


