Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E8C3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 13:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3wwD-0000s9-1I; Sun, 13 Apr 2025 08:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3ww8-0000rM-8Q; Sun, 13 Apr 2025 08:59:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3ww6-0007ti-G3; Sun, 13 Apr 2025 08:59:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50BFF116A4C;
 Sun, 13 Apr 2025 15:57:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DA8691EEE79;
 Sun, 13 Apr 2025 15:59:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CE2BC58521; Sun, 13 Apr 2025 15:59:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL v2 0/3] Trivial patches for 2025-04-13
Date: Sun, 13 Apr 2025 15:59:34 +0300
Message-Id: <20250413125937.2448971-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365:

  Update version for v10.0.0-rc3 release (2025-04-09 04:33:10 -0400)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to d08c08320a3580108b442d5eff296f0925fae4f0:

  docs: Document removal of 64-bit on 32-bit emulation (2025-04-13 15:57:56 +0300)

----------------------------------------------------------------
trivial patches for 2025-04-13

3 small changes for 10.0 if it's not too late

v2: + "docs: Document removal of 64-bit on 32-bit emulation"
----------------------------------------------------------------
Arthur Sengileyev (1):
      Fix objdump output parser in "nsis.py"

Richard Henderson (1):
      docs: Document removal of 64-bit on 32-bit emulation

Stefan Weil (1):
      docs: Fix some typos (found by codespell and typos)

 docs/about/deprecated.rst       | 4 ++--
 docs/about/removed-features.rst | 9 +++++++++
 docs/devel/codebase.rst         | 6 +++---
 docs/devel/qapi-domain.rst      | 4 ++--
 include/exec/memory.h           | 4 ++--
 qapi/qdev.json                  | 2 +-
 scripts/nsis.py                 | 2 +-
 7 files changed, 20 insertions(+), 11 deletions(-)

