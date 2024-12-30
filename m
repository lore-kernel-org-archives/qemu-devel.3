Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F54E7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 00:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS3Yp-0003BB-9i; Sun, 29 Dec 2024 19:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS3Ym-0003Az-9u
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 19:23:04 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS3Yh-0005SK-VA
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 19:23:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 08D285C562B;
 Mon, 30 Dec 2024 00:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0568BC4CED4;
 Mon, 30 Dec 2024 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735518172;
 bh=+93CC0mD8tjuCXQrB1CeOK/P0vFZOsdhCSE04xzUnmE=;
 h=From:To:Cc:Subject:Date:From;
 b=ECU5WexPtyjzLMmpzvgBlTtW5Y3yXCOMrudMm2cuB4CuNga+SGBJfqA7J0jWVfRrc
 mynu+v4o19hq5CFsbBI5xSJq5OtyHnROqOwcTK3eQ1isOWzj3ZhSZKd8fOEvSLukSR
 gWOdvmtr13X6WtF5n1Ew7lypYffhZFdUIQDPgfsu/zALcoHvJnkDjy/7nvRRrV+4Wy
 hkTSMIoBuBW+rbPgcBr6JtDSQ1oesLWhEdYVeiGEXn55ySZCxwhci5i9J9OA8eJ55n
 yYhcCZXkBl7NP3Shf56wFbyrAgqPy+vAeXljx0MFHjucDHJqa+aKNbuXmQKiwwMKHb
 sXfLdbolQyviw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/2] Hppa updates
Date: Mon, 30 Dec 2024 01:22:46 +0100
Message-ID: <20241230002248.33648-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The following changes since commit ae35f033b874c627d81d51070187fbf55f0bf1a7:

  Update version for v9.2.0 release (2024-12-10 16:20:54 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-updates-for-v9.2-v3-pull-request

for you to fetch changes up to bd2fb633a931b192540522fd842151b2421824ad:

  target/hppa: Speed up hppa_is_pa20() (2024-12-30 01:16:15 +0100)

----------------------------------------------------------------
hppa CPU reset and speedup

Add CPU reset function and speed up runtime and translataion.

----------------------------------------------------------------

Helge Deller (2):
  target/hppa: Add CPU reset method
  target/hppa: Speed up hppa_is_pa20()

 hw/hppa/machine.c |  6 +++---
 target/hppa/cpu.c | 27 +++++++++++++++++++++++++--
 target/hppa/cpu.h |  9 ++++++++-
 3 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.47.0


