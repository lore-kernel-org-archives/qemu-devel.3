Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42416606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfW0MQtb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6NK-0001Ic-6W; Thu, 05 Nov 2026 17:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP6N8-0001Hx-8m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:55:54 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP6N5-0004W3-GF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:55:52 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 270CB600C8;
 Thu,  5 Nov 2026 22:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A031F0089F;
 Thu,  5 Nov 2026 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793919349;
 bh=n45fscly7iwiQ8GGYMseDj3ZRC1ORLpV0H88udarV40=;
 h=From:To:Cc:Subject:Date;
 b=QfW0MQtbgxfi3FaSExmYt9Lq2Ckfb4pDCXriYS6YBS+K3ilH38covoxIpJLgBdTCO
 gjCVf6FiKVA0z+V+EyVsp7kyrouA4aInfSiuqwpns+6cK7pXzkgerYxh+8AXnkiUeJ
 g4EoB5o+mpbs9MoSKxXplhToFfFgjtiYa3KgehkoOYbWpRNaTu5l4V4tNWEJvXwnpg
 U5bAifPEvN4IoWKJVM/WR8cNIcIds5Lem+99fphciLEHyAmL5UWIKsIOREbB8bv7U6
 zDRZPVK6oS8czKjVhorP+b9GFJtGnTPxCWBcjWMhtqLjWO0wHAvvKs0tojKwWv8je2
 4oSI+Au7eIdAA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 0/2] Linux user next patches
Date: Thu,  5 Nov 2026 23:55:44 +0100
Message-ID: <20261105225547.12848-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

The following changes since commit f71afb409a87c4ecd0f9d63a5963eb645dfab780:

  Merge tag 'pull-loongarch-20261105' of https://github.com/bibo-mao/qemu into staging (2026-11-05 07:24:53 -0800)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to fadeabfa77834f7f0e5150bea30c6f0e52dc2b5f:

  linux-user: report EFAULT for a NULL sysinfo/getitimer buffer (2026-11-05 23:43:50 +0100)

----------------------------------------------------------------
linux user patches

Two last patches from TAKANO Mitsuhiro for linux-user to return EFAULT for
getrandom(), sysinfo() and getitimer() syscalls when called with NULL pointers.

----------------------------------------------------------------

TAKANO Mitsuhiro (2):
  linux-user: allow a zero-length getrandom with a NULL buffer
  linux-user: report EFAULT for a NULL sysinfo/getitimer buffer

 linux-user/syscall.c                          | 12 ++++-
 tests/tcg/multiarch/linux/linux-null-buffer.c | 48 +++++++++++++++++++
 tests/tcg/multiarch/meson.build               |  1 +
 3 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-null-buffer.c

-- 
2.54.0


