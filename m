Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5B6E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnuq-0001er-CN; Wed, 18 Feb 2026 15:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vsnuS-0001cT-OK
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:12:32 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vsnuQ-0002Y8-G6
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:12:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DFDB61857;
 Wed, 18 Feb 2026 20:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3E5C116D0;
 Wed, 18 Feb 2026 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771445545;
 bh=mgZlM6/10+cu5QgnPE0lEKFT+lYSfxjzXHXHrsmt/JI=;
 h=From:To:Cc:Subject:Date:From;
 b=vKMvWUyu8YaNbFmWF62UyIhvG1Xd7WGzNFdA6ZOlkqcdiubsu6Nwg+NZOZg9vgQ5i
 VD4Cjz3cJX9UoLyVfwZ92+Hcs2LuRqnreIC2/KSYtCpiAT8EkVZNHnEVcb1Yfsp+eP
 0GX4y/KK3gMeiT737rqpx56FApSYb7iIo39hs9/cofXAdiUJLtIlVqm8resdvPPRgc
 6dGhuyXoOo7E6JWeQubwWLD/EdhSXkvMcR00GYc6+S89YgJ/bFOeZNLz7C7HKqlN7b
 aBfnIfBo3Yrfe6xrsvK8oOjFLlnONRxxQUjn9jwr4CkR/+PqkRGIVd5pFP54HpXb/o
 Ty7M4l3jQUa7Q==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 0/4] hppa a400 machine support
Date: Wed, 18 Feb 2026 21:12:17 +0100
Message-ID: <20260218201221.20958-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

Major enhancements to SeaBIOS-hppa to support an A400
server. This server requires 64-bit PAT firmware, so
SeaBIOS-hppa was extendend a lot. PAT firmware is required
as well to support 64-bit HP-UX 11i3 or MPE.

The patches to qemu are quite small.

Please review.

Helge

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


