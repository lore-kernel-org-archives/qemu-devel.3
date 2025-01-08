Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D32DE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeAF-0004Cg-EE; Wed, 08 Jan 2025 17:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAE-0004Bn-6k
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAC-0006OU-81
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 152305C55F8;
 Wed,  8 Jan 2025 22:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B23C4CED3;
 Wed,  8 Jan 2025 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736373865;
 bh=GUTBW7BneAdK8QbcgGHg/CqNQiYaj5UWLRo7o08hi5E=;
 h=From:To:Cc:Subject:Date:From;
 b=h10wK78vUVZvHrLwJGb61UPf8mZwgfMuivyTu3f/ZGMQ/rr6zji5XddMTK8CIfvDj
 wNgYKw8cxEKkpYFuPD0CuSHG6ki4ESScexBvfbZDXKD5KjAXlnZm1ISsNsz9LsUhKs
 Sr1tdGtB4lUUIxaIg5N+E3QvGFyJV2dOrwMUsXbdQzWQfkc5gY4wNbuTzDzpuvDDLs
 bdo7fXAgdDd8FIn8SojP9ivPrJpvIVAKYDkQpcGzQ6q1XHfAatTqFyRet3PdarEMos
 Dv8YeJve052CAe9uGuvOEJaMNP4i0Jx2EpN5XN63QKMQV3wyewqVz9NuyiG+j5hfy6
 yNNMOaCNl7l+Q==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v2 0/6] Linux user fix gupnp patches
Date: Wed,  8 Jan 2025 23:04:16 +0100
Message-ID: <20250108220422.169967-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit 791e3837c1105aec4e328674aad32e34056957e2:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-25 10:44:11 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-fix-gupnp-pull-request

for you to fetch changes up to 526635dc5edf989781219c1ee7d50846c0555a46:

  linux-user: netlink: Add missing QEMU_IFLA entries (2024-12-27 21:30:27 +0100)

----------------------------------------------------------------
linux-user: Add support for various missing netlink sockopt entries

This patchset adds various missing sockopt calls, so that qemu linux-user
is able to successfully build the debian gupnp package in a chroot.

Tested with a 32-bit big-endian hppa linux-user chroot running on a phyiscal
x86-64 little-endian host.

This fixes debian's bug report:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1044651

Signed-off-by: Helge Deller <deller@gmx.de>

Stefan, please merge it now in mainline (unless Laurent
finally answers differently). It just adds until-now unsupporzted
functionality, so nothing existing can break.

----------------------------------------------------------------

Helge Deller (6):
  linux-user: netlink: Add missing IFA_PROTO to
    host_to_target_data_addr_rtattr()
  linux-user: Use unique error messages for cmsg parsing
  linux-user: netlink: Add IP_PKTINFO cmsg parsing
  linux-user: netlink: Add emulation of IP_MULTICAST_IF
  linux-user: netlink: add netlink neighbour emulation
  linux-user: netlink: Add missing QEMU_IFLA entries

 linux-user/fd-trans.c | 137 +++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall.c  |  29 +++++++--
 2 files changed, 161 insertions(+), 5 deletions(-)

-- 
2.47.0


