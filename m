Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28005C44501
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 15:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgP4Y-0007dV-C9; Sun, 05 Jul 2026 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wgP4W-0007d2-HV
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 11:47:56 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wgP4V-00014r-15
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 11:47:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4503D61383;
 Sun,  5 Jul 2026 15:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBFE1F000E9;
 Sun,  5 Jul 2026 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783266472;
 bh=KyCpJPad1dUHUvbx2U/xBHir4K3PT/9hxkv8OUhQMVM=;
 h=From:To:Cc:Subject:Date;
 b=nwX9n+UdRzG1IjhtcsEpm4wRzNyPdPgSe5/LsqKquY53RPSFXGT9hKXU4nzYMX6iF
 ss69oUQi6xXfJ5UkkazoWdCVlJMB8Zd7QNKeobbkzs/ZI1xZKd7gXf+UkdHRG7I8kO
 wGE2pgSzFf6ZegDmjYWJzrIQoThHVJIUCUE4Ht8QdRq9p04V2Kbvsk6oyOaKmpdWs6
 dmOuMDsxq8PKz6HKP7+4GAyf/y8b7gSXTpUN4dwAsBSooSbLjNMUy+6diyK8EeA/A5
 WfsmUEWrBHkYWLM72YHHyGgY9TazVTYNTgm64lFkieFCrSgh4NKE5j8XMRVRkxAdn8
 Rrq575wccJhaA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/4] Hppa fixes for v11.1 patches
Date: Sun,  5 Jul 2026 17:47:44 +0200
Message-ID: <20260705154749.7368-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

The following changes since commit 7f2007d1924565c7a38b2c6ba01ebc1a85db0a49:

  Merge tag 'pull-qobject-2026-07-02' of https://repo.or.cz/qemu/armbru into staging (2026-07-03 07:42:51 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-for-v11.1-pull-request

for you to fetch changes up to 90ce9a41508d4368d16334f7d1d8a9ed9bfa3747:

  target/hppa: Update SeaBIOS-hppa to version 25 (2026-07-05 17:42:14 +0200)

----------------------------------------------------------------
Updates for hppa architecture for qemu v11.1

A few patches to fix TLB for HP-UX 9, and a lasi irq fix,
as well as a new SeaBIOS-hppa v25 firmware.

----------------------------------------------------------------

Helge Deller (3):
  target/hppa: Work-around for Fast TLB insert instruction on HP-UX 9
  target/hppa: Delay MMU update until TLB protection bits were set
  target/hppa: Update SeaBIOS-hppa to version 25

Keith Monahan (1):
  hw/misc/lasi: derive IRR from pending and unmasked requests

 hw/misc/lasi.c              |  25 +++++++++++++++++++------
 pc-bios/hppa-firmware.img   | Bin 632780 -> 633992 bytes
 pc-bios/hppa-firmware64.img | Bin 665208 -> 666392 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/insns.decode    |   2 ++
 target/hppa/translate.c     |   4 ++--
 6 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.54.0


