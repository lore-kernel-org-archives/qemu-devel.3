Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A7FCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILgQ-0003ar-2K; Thu, 30 Apr 2026 03:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wILgM-0003Z9-HL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:19:34 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wILgJ-00012S-Ej
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:19:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AF324404F7;
 Thu, 30 Apr 2026 07:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D024C2BCB3;
 Thu, 30 Apr 2026 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777533565;
 bh=FJtLfLlU5tGib5MdE/xwM+prJdYI09ZeCOyg0IA8Yvs=;
 h=From:To:Cc:Subject:Date:From;
 b=lCurtcFxlcS4GLpckcCMFuyaWPKAhADhOaLffEtrjSrvS+H2OGdQ4rUivOvjcMk29
 lVZ/QwM4saGmIUCKVbIMAWEIGTxJs31p67h0S3+OpF/PPoNPmBGs6f5iCjNAMP6wvg
 yXR6T5tw6XfbMCVVzO6n3Sv7MhTirzdHKcN4B/cWsH9uBMfwCqqxLlo+A2TOlCAV9J
 0julaMbV4lrcN/gll6HeiPotT7OmW4hvB4qmthi0Dh2imSbkMZrOEuGB9tM+ppJVSi
 ueP+rXdznXgTbIqNIVH7Uqa61Y0sQi/SDjCw+3yumWgBqfp8V9HxLDpWpW5GttHg+D
 7owowd0FD4maQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 0/4] Linux user next patches
Date: Thu, 30 Apr 2026 09:19:18 +0200
Message-ID: <20260430071922.15341-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 759c456b1d22fe4083c8b384da27d3f56fd53f82:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-04-27 12:57:33 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 9667bf3249256788245c6ca07bc12106f3e4fa22:

  linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR (2026-04-30 09:00:04 +0200)

----------------------------------------------------------------
Pull request for linux-user

Please pull 4 fixes for the linux-user target.
Two patches fix open bug reports regarding return error codes and allowed parameters.
One adds missing CDROM ioctls (and fixes a few), and the last patch is a leftover
from the previous pull request and helps flushing error strings at exit.

----------------------------------------------------------------

Helge Deller (4):
  linux-user: Add missing CDROM ioctls
  linux-user: Flush errors by using exit() instead of _exit() in error
    path
  linux-user: Allow getsockopt() with NULL optval address
  linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR

 linux-user/ioctls.h  | 29 +++++++++++++----------
 linux-user/main.c    |  2 +-
 linux-user/syscall.c | 56 +++++++++++++++++++++++++-------------------
 3 files changed, 50 insertions(+), 37 deletions(-)

-- 
2.53.0


