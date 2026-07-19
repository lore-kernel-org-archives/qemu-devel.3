Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD0C44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlWOO-0004Pa-Ga; Sun, 19 Jul 2026 14:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wlWON-0004PI-2B
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:37:35 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wlWOL-0008DT-EH
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:37:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7291D4045E;
 Sun, 19 Jul 2026 18:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DF41F000E9;
 Sun, 19 Jul 2026 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784486244;
 bh=Z2ubqrZvTXMVqE13NjtPvNGPajechdrnRp0gXkv+zZg=;
 h=From:To:Cc:Subject:Date;
 b=iDhrd+WdEUcCLIT09ujSvZUhMyTZit7gxMYyzHmuRmKY8o656hGlswTBLmQ+Ni70h
 jpyGP7lEErEkesCm5KYTOyOpE8z6eH9HUIfN1BJ3fcoMYf2/zXr2ibUQwkcOVLmevk
 U4dN7Vh+jYGELrSgaQC/TeIvB5/cYxAp3W+xzCCriHvygS5ma3eW85bl6DJ/TQQebA
 GliR2hBSwHEHdw3SAOvtBldUTd8UMuymzyZ0XoEk6tXwh/znOsig1GwbOE+0knGmIL
 1M+f++Pnfc5vt4idVJG0y22Ej/UcgkBjyoLcnUSQ+BpMMHtxzlA+8TSYkM9HpIFSLU
 OkNFd9daNuJxA==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/1] Linux user for v11.1 patches
Date: Sun, 19 Jul 2026 20:37:20 +0200
Message-ID: <20260719183721.3035-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

The following changes since commit 5ef0ecc5942ee07bb581cc96a97bbfc0fdf4005c:

  Merge tag 'hw-misc-20260714' of https://github.com/philmd/qemu into staging (2026-07-17 10:01:52 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11.1-pull-request

for you to fetch changes up to c0e370474b020e4740c85c246e26ec8af1d9d53d:

  linux-user/sparc: Take pending signals in sparc64_set_context() (2026-07-18 23:47:33 +0200)

----------------------------------------------------------------
linux-user for v11.1 pull request

One patch for the linux-user to fix the sparc target regarding signal handling.

----------------------------------------------------------------

Peter Maydell (1):
  linux-user/sparc: Take pending signals in sparc64_set_context()

 linux-user/sparc/cpu_loop.c | 10 ++++++++++
 linux-user/sparc/signal.c   | 30 +++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.54.0


