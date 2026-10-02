Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2200CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCl95-0001JN-E4; Fri, 02 Oct 2026 17:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl94-0001JC-IP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:22 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl92-0006RU-SW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:22 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35A8C60D8B;
 Fri,  2 Oct 2026 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B1B1F00893;
 Fri,  2 Oct 2026 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790977817;
 bh=+l39wPEYBERXKjeCtN2PHc6tilY/cGnB//Qt0wKAVJQ=;
 h=From:To:Cc:Subject:Date;
 b=Da626zavsYSVk4b8MmezQ9cxanMwuAhM/Dni5xFvvELHAlhR6WU+zpICkM5jlrRoX
 GBkekFDE9umaB+dvw3z8sHKpEMwvEIUcsyUJQ22GqPVWX/GyjmXUE/inik1C+dumGd
 cr39m+JB8D36F2KK7mzTbumhLlv0X/pFP1HaBjKZgbC5LojYHbTRSL0Tz9F9eRffi+
 UcuHWzpxFEsDy7DUp5XNDgfOQwEuEgDWZoJdD7M4bZ66+prdY7ShcUxGmFKxD36+4L
 LI7s7HeWusJzHpJ23HmINyUh3dBEsNnNVv6CfQXR8gBncPJIHD8mvo37HyP5iAlNAW
 URzI/3BbCj8ow==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Craig Lalley <mr_lalley@yahoo.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 0/4] HPPA A400 updates
Date: Fri,  2 Oct 2026 23:50:10 +0200
Message-ID: <20261002215014.45371-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit efa3b9d5ac8024078225e1ab434411fdfe53b457:

  Merge tag 'pbouvier/pr/tcg-tests-20260925' of https://gitlab.com/p-b-o/qemu into staging (2026-09-25 11:52:47 -0700)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-a400-updates-pull-request

for you to fetch changes up to 1f22bd961e7a512a59fb289daf218298e19ddf50:

  hw/hppa: Place the CPU at HPA 0xfffa0000 and fw_cfg at 0xfffb0000 (2026-10-02 23:39:28 +0200)

----------------------------------------------------------------
HPPA updates for A400 and new SeaBIOS

A new SeaBIOS-hppa version 26 with many fixes, and some updates
regarding the A400 machine. Main goal is still to get MPE
functional on the A400 machines.

Signed-off-by: Helge Deller <deller@gmx.de>

----------------------------------------------------------------

Craig Lalley (3):
  hw/hppa: Rotate Elroy PCI interrupts by pin on the A400
  hw/hppa: Place the second Elroy of the A400 on rope 2
  hw/hppa: Place the CPU at HPA 0xfffa0000 and fw_cfg at 0xfffb0000

Helge Deller (1):
  target/hppa: Update SeaBIOS-hppa to version 26

 hw/hppa/hppa_hardware.h     |   5 +++--
 hw/hppa/machine.c           |  14 +++++++++-----
 hw/pci-host/astro.c         |  32 ++++++++++++++++++++++++++++----
 include/hw/pci-host/astro.h |   2 ++
 pc-bios/hppa-firmware.img   | Bin 633992 -> 641484 bytes
 pc-bios/hppa-firmware64.img | Bin 666392 -> 682800 bytes
 roms/seabios-hppa           |   2 +-
 7 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.54.0


