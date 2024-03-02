Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A13AC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 22:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgXxM-0006Ah-CJ; Sat, 02 Mar 2024 17:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxI-00069j-FF
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxD-0003gY-OU
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BA9E860F3E;
 Sat,  2 Mar 2024 22:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD8FC433F1;
 Sat,  2 Mar 2024 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709418927;
 bh=QxpUQHjYZrYwwl1ZX8fNpRt0CF3Jl0AE0E/aa+9jEfQ=;
 h=From:To:Cc:Subject:Date:From;
 b=tvhoY6y8ZbZRgjJ1j/Kz7vdG41DdBGRll6Bzl0ZRcpAj69ZXpDpzG+GxYnKXJ80gr
 kvIfBEFe9zJooM9tiV2gq5XlSgEMxEOvvPqkaJqa8Sr0hQXlEcRe/NBXotP9GnrScI
 La/9qME/RzW8t3yX0mbdc8XGV8X8pTJ0VedAkWqbM8Ty4E8U+L0qVFMX9GhusIAlV8
 L7n6FQccwTROOt2G13F/CEPSbDSi8tG3hyFFTQwwjKfV01bwp5HaOVRinMHg01w4Uh
 hS5xlHzwmWN4p+Bou8xXeQdtXv0nvu9WB6U5cE2pZ6YWN7S6SDHLVdT/vkTCyJKl0K
 4r4Cp6BmXLVkQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 0/5] HPPA64 updates
Date: Sat,  2 Mar 2024 23:35:19 +0100
Message-ID: <20240302223524.24421-1-deller@kernel.org>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.094,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some fixes for the hppa64 target.
Add references to SeaBIOS-hppa and hppa-firmware into
pc-bios/README file and add rom make targets.
Patches 2-5 need review.

Guenter Roeck (1):
  target/hppa: Fix unaligned double word accesses for hppa64

Helge Deller (4):
  target/hppa: Restore unwind_breg before calculating ior
  pc-bios/meson: Add hppa-firmware64.img blob
  pc-bios/README: Add information about hppa-firmware
  roms/hppa: Add build rules for hppa-firmware

 pc-bios/README           | 6 ++++++
 pc-bios/meson.build      | 1 +
 roms/Makefile            | 7 +++++++
 target/hppa/cpu.c        | 3 ++-
 target/hppa/helper.c     | 7 ++++++-
 target/hppa/mem_helper.c | 3 ++-
 target/hppa/op_helper.c  | 3 ++-
 7 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.44.0


