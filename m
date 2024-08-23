Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFD9C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 14:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shV5p-0002LS-2f; Fri, 23 Aug 2024 10:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1shV55-00020r-Q1; Fri, 23 Aug 2024 10:16:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1shV53-0004G5-Tr; Fri, 23 Aug 2024 10:15:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D9F1A87EC2;
 Fri, 23 Aug 2024 17:14:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 860D212B0F5;
 Fri, 23 Aug 2024 17:15:42 +0300 (MSK)
Received: (nullmailer pid 1411614 invoked by uid 1000);
 Fri, 23 Aug 2024 14:15:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL for-9.1 0/3] Trivial patches for 2024-08-23
Date: Fri, 23 Aug 2024 17:15:39 +0300
Message-Id: <20240823141542.1411594-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 407f9a4b121eb65166375c410e14d7b704bc1106:

  Update version for v9.1.0-rc3 release (2024-08-22 15:07:32 +1000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to d6192f3f7593536a4285e8ab6c6cf3f34973ce62:

  hw/display/vhost-user-gpu.c: fix vhost_user_gpu_chr_read() (2024-08-23 12:10:28 +0300)

----------------------------------------------------------------
trivial patches for 2024-08-23

There are just 3 patches in here, one adding a comment (no code changes)
and two fixing bugs (one is a regression bug).  I think it's suitable for
9.1

----------------------------------------------------------------
Ani Sinha (1):
      hw/x86: add a couple of comments explaining how the kernel image is parsed

Haoran Zhang (1):
      hw/display/vhost-user-gpu.c: fix vhost_user_gpu_chr_read()

Peter Maydell (1):
      system/vl.c: Print machine name, not "(null)", for unknown machine types

 hw/display/vhost-user-gpu.c | 2 +-
 hw/i386/x86-common.c        | 7 +++++--
 system/vl.c                 | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

