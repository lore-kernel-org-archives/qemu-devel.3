Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B221CC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbPkZ-0003Y2-D6; Fri, 24 Jan 2025 14:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbPkX-0003Uq-6H
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:53:53 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbPkV-0004b3-Jt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:53:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6C8CE5C612F;
 Fri, 24 Jan 2025 19:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A4C4CED2;
 Fri, 24 Jan 2025 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737748428;
 bh=DD6F6AMCcVW/aE5bjj89/59MoF5iJZ9Y9mSpYv1/XlY=;
 h=From:To:Cc:Subject:Date:From;
 b=Zll1NXh+BjoGvZLRM/aSwyaP+FCDahjG3yuaDmcLS0wiek5CMV/TzqboPVrHcVdiv
 SIp717AAqZioeXRE5bnQMrGEBpLp6FrZEyw7urpvyGPiy4eKDbwgOBbmfaSFfShwYN
 ed5ZQNWj/wGT0bNZwWS6giw7/rb4sfjORL4MTJ9DXpr1BlMhWQONnKdKxa7DoTn7Ee
 1WkcHmQScBP3cuNv9WMVabCmn6ccaHtyinP/R7alDvu9mbgynyL72FSJJQ/ZgSEYXl
 iZGa5NQR4ynXfCmbCFvJnQT9SoImOm8wK/DEnJx+ZGByqXHTla1hJtq1X4411IBM7N
 dGhohEpeaTx5g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/2] Hppa system for v10 patches
Date: Fri, 24 Jan 2025 20:53:43 +0100
Message-ID: <20250124195345.15118-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 32a97c5d05c5deb54a42315d48cecf86cbeadaf4:

  Merge tag 'pull-tcg-20250117' of https://gitlab.com/rth7680/qemu into staging (2025-01-21 08:28:33 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-system-for-v10-pull-request

for you to fetch changes up to c656f293dfe31661e4252d78cfa6cab6372ad5ca:

  hw/hppa: Fix booting Linux kernel with initrd (2025-01-24 20:51:53 +0100)

----------------------------------------------------------------
hppa updates

* Fixes booting a Linux kernel which is provided on the command line.
* Allow more than 4GB RAM on 64-bit boxes

----------------------------------------------------------------

Helge Deller (2):
  hw/hppa: Support up to 256 GiB RAM on 64-bit machines
  hw/hppa: Fix booting Linux kernel with initrd

 hw/hppa/hppa_hardware.h |  2 ++
 hw/hppa/machine.c       | 74 +++++++++++++++++++++--------------------
 target/hppa/cpu.h       |  4 +++
 3 files changed, 44 insertions(+), 36 deletions(-)

-- 
2.47.0


