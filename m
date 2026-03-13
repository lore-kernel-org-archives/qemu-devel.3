Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E32107BCD3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17HY-0007eT-NC; Fri, 13 Mar 2026 14:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w17H8-0007c9-0L
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:20 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w17H6-0005SD-0v
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EC6760132;
 Fri, 13 Mar 2026 18:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE457C19421;
 Fri, 13 Mar 2026 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773426612;
 bh=NnxFSdCW3cxLs84ZUWqDNwDAjJ7tS5JLLCtRsYzPU+c=;
 h=From:To:Cc:Subject:Date:From;
 b=II40C/u0Oe7JxYmcJVNTY5SlnmCxw4WVpNtGdNqFcXn8WGovepgZ0tToycO0B5YOk
 jb1hOjfEKfNu/o/E5Dp1N0UNiftiBTcSqvNNwRD9XwEXInpE6ztBHvLPAS3k6FQh79
 JHsv3yU/JtLvWJzTxKm0vjXOTDqwJIJpGg6xFUseyKAGCxr4tTeIcwWI57B4g0OUG7
 4BOSaldp89M2NUB/Ila/HRNXhIlp4LPfpYGw57pxf61jr2UWBXHEzSpmrDkQcMPOhn
 xoZH110P+NrcVc7xYPIUdcrN80ZNaPuFu69SN8OfQ2gpbJ4/tqgjiqm4Z45S/IehAZ
 9uNgD+rlK57Pg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/2] Linux user for v11 patches
Date: Fri, 13 Mar 2026 19:30:07 +0100
Message-ID: <20260313183009.34221-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11-pull-request

for you to fetch changes up to 5e5b278d2b1b81fc2b5ca09dba4848f81cd3a718:

  linux-user: fix mremap with old_size=0 for shared mappings (2026-03-12 21:03:48 +0100)

----------------------------------------------------------------
Two linux-user patches

Two linux-user patches from Razvan Ghiorghe.

----------------------------------------------------------------

Razvan Ghiorghe (2):
  linux-user: Fix zero_bss for RX PT_LOAD segments
  linux-user: fix mremap with old_size=0 for shared mappings

 linux-user/elfload.c | 37 +++++++++++++++++++------------
 linux-user/mmap.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 14 deletions(-)

-- 
2.53.0


