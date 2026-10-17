Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72730CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB4r-0004Kz-F2; Sat, 17 Oct 2026 16:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xIB3M-0003Ai-Ol
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 16:30:55 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xIB3F-0004PO-Eu
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 16:30:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A72C640582;
 Sat, 17 Oct 2026 20:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B042E1F000C6;
 Sat, 17 Oct 2026 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792269034;
 bh=zpe7yrmLZpNqd0Uww9mIAuQjuXLjwa12KhQnGbUvut8=;
 h=From:To:Cc:Subject:Date;
 b=Cc52mxTAODgxRuseAE7wQ2Bl1spq9M/bQ6wuC20T1UgcQpHgIW99+fj7cEnq3b2x+
 AKNBoYHVYTm8KOpgO2YQ2O+Bo6J+Rj0ElrjVcrgx0vABDB0iynfbtPKLGTkxv6H0Iv
 VZ3zRtyG1JF2xWsCtWKfUubabQv27ygxSo/ZiDjRB6uHGWK5NGRotMMcnT/VMGMe1T
 +T/J7hX5VSqiqfcwad/Ui0uOE2ni2HTqf57+Raefv7hJ48KztjOZlNfFJSP3+BMDqY
 pT56Ppcx+ddgZ1Sc+rl65nolrfSb13mwDVDK1ySLM1fPNpI3FvcCD2Sw136OxuWgLn
 Rrrc3jWZKDEug==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 0/1] Linux user next patches
Date: Sat, 17 Oct 2026 22:30:30 +0200
Message-ID: <20261017203031.3107-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 8ee6c77176cfee03be0ec7665b6652b2f31f1531:

  Merge tag 'pull-ufs-20261012' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-10-13 22:01:07 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request

for you to fetch changes up to 56ab4a7356ac7b6a18a4283d51e868e2cf366588:

  linux-user: don't print core dump message by default (2026-10-14 21:14:06 +0200)

----------------------------------------------------------------
linux user patches

One patch from Andreas Schwab to not trash the guest console when
warning about unhandled core dumps.

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: don't print core dump message by default

 linux-user/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.54.0


