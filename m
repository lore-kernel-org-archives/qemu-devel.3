Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1857D4A604
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeON-00037f-OA; Fri, 16 Jan 2026 02:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeNt-0002h7-Gc
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:36:41 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeNr-00079q-7D
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:36:41 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 15:30:24 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 15:30:24 +0800
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Hao Wu <wuhaotsh@google.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, <nabihestefan@google.com>, <komlodi@google.com>
Subject: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Date: Fri, 16 Jan 2026 15:30:18 +0800
Message-ID: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit c1c58cee16380f81f88fbde6b12f247b376839e2:

  Merge tag 'pull-target-arm-20260115' of https://gitlab.com/pm215/qemu into staging (2026-01-16 09:33:20 +1100)

are available in the Git repository at:

  https://github.com/jamin-aspeed/qemu.git tags/pull-vbootrom-20260116

for you to fetch changes up to 107253db5886ec9c0173ffdcb1671a51695a20d5:

  pc-bios: Update vbootrom image to commit 1c8e9510b22c (2026-01-16 15:09:53 +0800)

----------------------------------------------------------------
vbootrom update pull request

----------------------------------------------------------------

Jamin Lin (3):
  MAINTAINERS: Update ASPEED entry
  roms/vbootrom: Update to commit 1c8e9510b22c
  pc-bios: Update vbootrom image to commit 1c8e9510b22c

 MAINTAINERS                 |   2 ++
 pc-bios/ast27x0_bootrom.bin | Bin 16408 -> 28564 bytes
 pc-bios/npcm7xx_bootrom.bin | Bin 672 -> 736 bytes
 pc-bios/npcm8xx_bootrom.bin | Bin 672 -> 672 bytes
 roms/vbootrom               |   2 +-
 5 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0


