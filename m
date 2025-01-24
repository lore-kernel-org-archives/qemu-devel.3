Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E861C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJLG-0000QL-Lt; Fri, 24 Jan 2025 08:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJKy-0000OV-GC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tbJKw-0007G8-Og
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:03:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2A2BE5C5A81;
 Fri, 24 Jan 2025 13:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDB4C4CED2;
 Fri, 24 Jan 2025 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737723778;
 bh=wOfvPimm++bcR+fr8JPr4UgbbfbJtbzGWJ0HL1R9UT0=;
 h=From:To:Cc:Subject:Date:From;
 b=cRdbw2RBsqpLLSJ8dI8YTzcZjLo0Kx7nxGZbjR1+MmtS5ucZKxIr4/h/X46+BmGmw
 bHNgpZOa25jcVv/cXeJ9PREuvagxTBX2CeXRSwDOphV8ls+tUnOARFEfrcTv+7b9U4
 OvdbbZyU6guTw0qqAluXPxBc1T7dvQFAPamFFn0U9yH4XiNM+HMGPuhNNM0m2498/J
 SxzRNcU8r3xGm4ddfCKnQd0/ziUsLMBIlx7g6fk2yi190pAmV+ne9rQ4s/IygrHAQ3
 S+4spKdCGe93rmjz6bkJG1WLeOTT6GJ0y1EjtDeWl5ANUnHkrjhhDv6/S8tPldwLVy
 f0/CnUeQI5Ueg==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v3 0/6] Linux user fix gupnp patches
Date: Fri, 24 Jan 2025 14:02:48 +0100
Message-ID: <20250124130254.3134-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 0e3aff9ec34059512d597eacfcf4d1b5d4570c50:

  Merge tag 'pull-10.0-gdb-plugins-doc-updates-170125-1' of https://gitlab.com/stsquad/qemu into staging (2025-01-17 10:13:07 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-fix-gupnp-pull-request

for you to fetch changes up to 3719acc273865744b885ad9bcb141b4496c31887:

  linux-user: netlink: Add missing QEMU_IFLA entries (2025-01-24 13:58:40 +0100)

----------------------------------------------------------------
linux-user: Add support for various missing netlink sockopt entries

Add missing sockopt calls and thus fix building the debian gupnp package in a chroot.

This fixes debian bug report:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1044651

Signed-off-by: Helge Deller <deller@gmx.de>

----------------------------------------------------------------

Helge Deller (6):
  linux-user: netlink: Add missing IFA_PROTO to
    host_to_target_data_addr_rtattr()
  linux-user: Use unique error messages for cmsg parsing
  linux-user: netlink: Add IP_PKTINFO cmsg parsing
  linux-user: netlink: Add emulation of IP_MULTICAST_IF
  linux-user: netlink: add netlink neighbour emulation
  linux-user: netlink: Add missing QEMU_IFLA entries

 linux-user/fd-trans.c     | 169 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall.c      |  34 ++++++--
 linux-user/syscall_defs.h |   6 ++
 3 files changed, 192 insertions(+), 17 deletions(-)

-- 
2.47.0


