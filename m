Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50215E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO06U-0005fg-68; Wed, 18 Dec 2024 14:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06S-0005fH-B4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:04 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tO06Q-0001ab-Km
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7966FA4016F;
 Wed, 18 Dec 2024 19:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E47BC4CECD;
 Wed, 18 Dec 2024 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734551570;
 bh=iMoM5h2OriTHPpIK0pJs10G8VsNK42RcEcdmd5FfyMI=;
 h=From:To:Cc:Subject:Date:From;
 b=rMVJYQeLnKqLZ6Gz8mxVY079KKi7TcgNcyE8p/jmqFEgQaSDf5K+BavlCMN7fBP9S
 pA+VhGRH7hwVh+DvlqzoxBLZP3M38K8YC1iEmE/WGMLfwc6MXYU37Immf9iLvzrw6S
 os0zphtdmnIpMxZXs+Iwz/G9mW7v0Lt2QRR15I1Q/QweZu/vvCOOx1BqfmSRSVf6oC
 bqnj9b6Hw6AR0q3L+qslDYX0vCNgZCQh8NOqiO/g9S9bQYTpxSmtMUVCPtbojCfY+S
 YENkr+oiostXNnZ4DlHIeZgWdENpWVHRbWKURr/UaTluDacLpOGuBN+VsE1yQlKHqd
 nOanCSXsWtMvA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 0/6] Linux user fix gupnp patches
Date: Wed, 18 Dec 2024 20:52:41 +0100
Message-ID: <20241218195247.5459-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

for you to fetch changes up to 22743482ec633511c8d3c9410149d42df480b3eb:

  linux-user: netlink: Add missing QEMU_IFLA entries (2024-11-29 15:25:27 +0100)

----------------------------------------------------------------
linux-user: Add support for various missing netlink sockopt entries

This patchset adds various missing sockopt calls, so that qemu linux-user
is able to successfully build the debian gupnp package in a chroot.

Tested with a 32-bit big-endian hppa linux-user chroot running on a phyiscal
x86-64 little-endian host.

This fixes debian's bug report:
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

 linux-user/fd-trans.c | 137 +++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall.c  |  29 +++++++--
 2 files changed, 161 insertions(+), 5 deletions(-)

-- 
2.47.0


