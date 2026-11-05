Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398F606A32D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOnFQwU3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP5zq-00047w-PJ; Thu, 05 Nov 2026 17:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zW-00046h-Kn
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:32 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zV-0002Ja-2S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:30 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07971600C8;
 Thu,  5 Nov 2026 22:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2251F0089F;
 Thu,  5 Nov 2026 22:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917885;
 bh=uofusSfXzjqN73N3MbZyd7Z6HgC+JN7YKmtley5S/B0=;
 h=From:To:Cc:Subject:Date;
 b=YOnFQwU31p66xVQMjoCZiKold8ub7I1lGkzWGwInftFJ1yeNQSdoUcFELLwTKT3KJ
 hK9P/ZowiTlsladSZQlHTZgsoG3kf7aEZomAlkI5Yhk6u/T0V5STm24k2tM6oN8x1t
 kModKH3gQ2bVZX6wYUx/4wzQcZeuRPWVlqXrApBOdTRz0BPLFbzuwsloxd6SWAw/Jo
 bPyuy93hS18Zl/lgcNW89QQRNqBpflnRtLkKBXuWHWoBHqvSpDSRcCkSVQzg7SDyLX
 2+Yr4Ds9h6rJnhLc8S/W+hhIZKywqO6ufo+uKRy5OetPB6PlirmlcMcyHHq6FJAuzU
 GBglgO3hp0bUA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 0/8] Hppa 715 cpu nic patches
Date: Thu,  5 Nov 2026 23:31:14 +0100
Message-ID: <20261105223122.8729-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit 99e6fa0053ba1b1454b8c4446f857c430547a702:

  Merge tag 'pull-nbd-2026-11-02' of https://gitlab.com/ebblake/qemu into staging (2026-11-03 10:54:31 -0800)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-715-cpu-nic-pull-request

for you to fetch changes up to 58952e4a5a2ddc0e450bef0770959b1147c98f2e:

  i82596: Various send- and transmit fixes for 715 (2026-11-05 23:29:19 +0100)

----------------------------------------------------------------
qemu-hppa-715

A last bunch of fixes to allow HP-UX 9.05 to run on the 715 machine.
This includes a fix to handle an invalid use of the blr instruction, a fix
which puts the power button address outside of the ROM, and various fixes for
the i82596 NIC.

Tests were run on HP-UX 9.05, HP-UX 10.20, NetBSD and Linux.

----------------------------------------------------------------

Helge Deller (8):
  target/hppa: Move emulated power button into CPU I/O region
  target/hppa: Add special blr instruction for HP-UX 9.05
  lasi_i82596: Decode the PORT command from bits 3:0, not 7:0.
  i82596: Implement 82596CA big-endian mode (SYSBUS bit 7)
  i82596: Initialize variables at chip reset
  i82596: Drop crc calculation
  i82596: Fix source address inserting
  i82596: Various send- and transmit fixes for 715

 hw/hppa/machine.c        |  13 +-
 hw/net/i82596.c          | 355 ++++++++++++++++++++++++++-------------
 hw/net/i82596.h          |   5 +
 hw/net/lasi_i82596.c     |   4 +-
 target/hppa/cpu.h        |   2 +
 target/hppa/insns.decode |   1 +
 6 files changed, 261 insertions(+), 119 deletions(-)

-- 
2.54.0


