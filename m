Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD70E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3OT-0007M7-3x; Thu, 19 Feb 2026 07:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OF-0007Ks-73
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:19 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OB-0008An-K3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:17 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BD22240706;
 Thu, 19 Feb 2026 12:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8D9C4CEF7;
 Thu, 19 Feb 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771505051;
 bh=/2As5PAN1gRHlChXX9/XVd1aFluuu8PythyLY5m93J4=;
 h=From:To:Cc:Subject:Date:From;
 b=nHkSOeI+bpAS+ZUwOUWYQgLJ9ZTqLKf6BIOKkRBtLp5fP4iDTtsODpkn0BKHlFzVU
 A91I959Lsj6JxyM0nDbTo2QCCySKws1V2ghINHUzuZGwI/w6yL0V5jdaT1js6PBVM/
 5HorR0pBHgPWZJh5pDyQzqcXPxuTC16+511qufhdv3sibo3Zt0K+GLh/2GlMoZAMBS
 RUmiRHy1lrAn/b7wo88QI9qoX+k7xTW/pySMX4e3k9CMYODBD8dNRfCXDHzUJk5pxQ
 AJW1sFqJv0aczAVKC2cu/BwwtfO6KJnyiE1pvQYbIMurNaXS+XY6Ih6lhQH+DaP/Xs
 4exM7wWs328gg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 0/4] Hppa a400 patches
Date: Thu, 19 Feb 2026 13:44:04 +0100
Message-ID: <20260219124408.3515-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-a400-pull-request

for you to fetch changes up to 9e59b112b6c0e24831e1f28926df0bc917b14902:

  hw/hppa: Add emulation for the 64-bit A400 server (2026-02-19 13:41:21 +0100)

----------------------------------------------------------------
hppa a400 machine support

Major enhancements to SeaBIOS-hppa to support an A400 server. This server
requires 64-bit PAT firmware, so SeaBIOS-hppa was extendend a lot. PAT firmware
is required as well to support 64-bit HP-UX 11i3 or MPE.

----------------------------------------------------------------

Helge Deller (4):
  hw/hppa: Add BMC on 64-bit machines only
  target/hppa: Update SeaBIOS-hppa to version 22
  hw/hppa: Require SeaBIOS version 22 for A400 machine
  hw/hppa: Add emulation for the 64-bit A400 server

 hw/hppa/machine.c           |  32 +++++++++++++++++++++++++++++++-
 pc-bios/hppa-firmware.img   | Bin 628952 -> 632048 bytes
 pc-bios/hppa-firmware64.img | Bin 692032 -> 713608 bytes
 roms/seabios-hppa           |   2 +-
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.53.0


