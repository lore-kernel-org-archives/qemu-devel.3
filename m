Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BD4CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMDP-0003EB-E4; Tue, 19 May 2026 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPMDH-0003DP-MS
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:32 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPMDG-0006ts-2B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:31 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3511543CB8;
 Tue, 19 May 2026 15:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F1CC2BD01;
 Tue, 19 May 2026 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779203907;
 bh=0lK4rt6DZc2SX44PTnp22WI+8M5zcVK19F5wYBI0ueA=;
 h=From:To:Cc:Subject:Date:From;
 b=KgR+gbHq2ppF8m83wLyNvHmBU5ZfUGS+dJpgX9yeXoFwBWg18X/HY81ARO0060WGn
 38NqV3R9gNUZNdWhlQyXgUvGD5PAyS3g/STgZKA8mMrKeJrRhic88udIuIxQxEM6OH
 B76RIHV9XcBxhgBIi5oowtKc0wJTBB4AJnkJR3eGGdjMQw1JFZumaAqnlhH0u7G//f
 SM0ltzgqJUJ3BXstXAnWo+kX3wAQUud5w9QrfECRTBKEeLjnVn7fy+as7WxyiaOJoB
 Pa+1jJjuNskyqKccF2+Mjg5Jglh6jqFuerNRwQk4MPksIDEJ0DiVoiTivF/GVTiGId
 FusnudNj6cpSQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/2] Hppa post v11 patches patches
Date: Tue, 19 May 2026 17:18:21 +0200
Message-ID: <20260519151823.13878-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The following changes since commit 6d17fd91f6cf88df5cb2205e578640d72605cc43:

  Merge tag 'pull-nvme-20260518' of https://gitlab.com/birkelund/qemu into staging (2026-05-18 08:33:20 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-post-v11-patches-pull-request

for you to fetch changes up to cf05a5c52716fae63a1792a67b94b0612cb800b8:

  hw/hppa: Move static variable lasi_dev into MachineState (2026-05-19 17:17:26 +0200)

----------------------------------------------------------------
Two hppa cleanup patches

Two leftover cleanup patches which I did not wanted to merge shortly before the qemu-v11 release.
Nothing critical, and both suggested by Philippe Mathieu-Daudé.

----------------------------------------------------------------

Helge Deller (2):
  hw/pci-host/astro: Encode Astro version numbers
  hw/hppa: Move static variable lasi_dev into MachineState

 hw/hppa/machine.c   | 15 ++++++++++-----
 hw/pci-host/astro.c |  5 ++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.54.0


