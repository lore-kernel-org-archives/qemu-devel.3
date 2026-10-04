Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706A5CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDKcj-0003zf-OM; Sun, 04 Oct 2026 07:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKci-0003zN-67
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:20 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcg-00022x-77
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3B3A41B5E;
 Sun,  4 Oct 2026 11:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A041F000FF;
 Sun,  4 Oct 2026 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791114194;
 bh=xMxmctHB3P1lDre9FNucJEK6kcoVRJ5jbhKHqF6yA8Q=;
 h=From:To:Cc:Subject:Date;
 b=HR4a3kQ2jC18lTjQU97MbfRBQn7vKs1YHwiyjQmYHf6my8QSMBT0A3fcR26fbaUbe
 rFq2PRZuoU1SqyBYeqbzHTNnKOFA7ighQNVVSMV1cod2U+s5YvR8ByqnT/LrIgCf6s
 1blRjxbNUBT6b3gAGjoXxxzf2lvLcbBKPcHPmBfSk11ASsEaK1su7zv12aKWS/SEy4
 CFG5WCbY0rU65zMU1MhMcqGM+WrFkmmzptzpUCPzyyDUBhdeCulJDhb8do3G08DG9Z
 O9FkyPediCVBxPoz+dPGYxpV2xZlbrktSBg3StYgy34kGRF1/kMs1W/JPVQpXT8dJj
 ALPpOeQl/cIzQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/5] Linux user next patches
Date: Sun,  4 Oct 2026 13:43:05 +0200
Message-ID: <20261004114311.3874-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:

  Merge tag 'hppa-a400-updates-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 8e021b85cc06caec24a24302aa68f040a0970c12:

  linux-user/mips: pick Loongson-3A4000 if a pre-r6 mips64 binary needs nan2008 (2026-10-04 13:32:14 +0200)

----------------------------------------------------------------
linux user patches

Some patches for linux-user, which
- make it possible to run pre-r6 mips64 binaries that need nan2008 without
  requiring the user to explicitly set a compatible -cpu, and
- copy the executable's e_flags into core dumps on mips and riscv

----------------------------------------------------------------

Alex Rønne Petersen (2):
  target/mips: fix Loongson-3A4000 definition to have abs2008 and
    nan2008
  linux-user/mips: pick Loongson-3A4000 if a pre-r6 mips64 binary needs
    nan2008

Matt Turner (3):
  linux-user: add elf_core_eflags() hook for core dump e_flags
  linux-user/mips64: set EF_MIPS_ABI2 in mipsn32 core dumps
  linux-user/riscv: copy the executable's e_flags into core dumps

 linux-user/elfload.c           |  7 ++++++-
 linux-user/mips/elfload.c      | 14 ++++++++------
 linux-user/mips64/target_elf.h |  2 ++
 linux-user/riscv/target_elf.h  |  3 +++
 target/mips/cpu-defs.c.inc     |  4 ++--
 5 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.54.0


