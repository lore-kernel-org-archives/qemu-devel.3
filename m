Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB43CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKZk-0008KU-Qp; Tue, 19 May 2026 09:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPKZj-0008Ip-8t
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:33:35 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPKZh-0000hn-VP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:33:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D1DB860121;
 Tue, 19 May 2026 13:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC0DC2BCB3;
 Tue, 19 May 2026 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779197612;
 bh=RJTJnu/DpOScu3q/nhSNqkRFcjwyud0mzEjv+7K08Gc=;
 h=From:To:Cc:Subject:Date:From;
 b=ufkp/rcFyN3FAWiGHAI/wCCUGOack4zm8KcsheXNuCjsZz5SQ1XC7uwnxhIz/Tbqr
 yI9Go38w2BWZiJ6SYA7MG63IkRT9QjYgGq+mPp20HTq5xvPhXKESbVfhevcJIpmK/U
 bJc8l3XaomiRowxtZxZe0qwrFttl1zk/u1VYwP6nbMXZhWhn5mu1rMZeNkoYBfDGng
 swFFlKaYZ4vIMmlcPhuyJ6GDzubx5UAfeQ6M+f2s7ajYuvMgGSYUBA5R7Y5uMbV4im
 vFN12mDPK3JIyAHUmcbr8JiMo8wDX5+bsJMxcQHcNWzq6NvplD9hQlyI27o0Y4k3xW
 gwy/g3l7haHyg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/2] Two hppa cleanup patches
Date: Tue, 19 May 2026 15:33:27 +0200
Message-ID: <20260519133329.4268-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

Two leftover cleanup patches which I did not wanted to merge shortly before the qemu-v11 release.
Nothing critical, and both suggested by Philippe Mathieu-Daudé.

Please review.

Helge Deller (2):
  hw/pci-host/astro: Encode Astro version numbers
  hw/hppa: Move static variable lasi_dev into MachineState

 hw/hppa/machine.c   | 15 ++++++++++-----
 hw/pci-host/astro.c |  5 ++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.54.0


