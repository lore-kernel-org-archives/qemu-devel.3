Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9652CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiQN-0001uE-RZ; Wed, 03 Sep 2025 04:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1utiPP-0001C1-9q; Wed, 03 Sep 2025 04:00:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1utiPM-0005zA-IL; Wed, 03 Sep 2025 03:59:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CD93314F539;
 Wed, 03 Sep 2025 10:59:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3975026E184;
 Wed,  3 Sep 2025 10:59:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 0/5] Trivial patches for 2025-09-03
Date: Wed,  3 Sep 2025 10:59:45 +0300
Message-ID: <20250903075952.481585-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 8415b0619f65bff12f10c774659df92d3f61daca:

  Merge tag 'qga-pull-2025-08-29-v2' of https://github.com/kostyanf14/qemu into staging (2025-09-02 12:07:05 +0200)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 25fef09ce17ac1ae22638a0b57d97c2bd5cd7d83:

  docs: fix typo in xive doc (2025-09-03 10:57:50 +0300)

----------------------------------------------------------------
trivial patches for 2025-09-03

A few assorted fixes.
Including not-so-trivial (but simple) fix for curl (https)
block protocol with recent curl versions.

----------------------------------------------------------------
Aditya Gupta (1):
      docs: fix typo in xive doc

Michael Tokarev (2):
      block/curl: fix curl internal handles handling
      block/curl: drop old/unuspported curl version checks

Philippe Mathieu-Daudé (1):
      scripts/coverity-scan/COMPONENTS.md: Add a 'plugins' category

Stefan Weil (1):
      chardev/baum: Fix compiler warning for Windows builds

 block/curl.c                        | 20 +++-----------------
 chardev/baum.c                      |  8 ++++++--
 docs/specs/ppc-xive.rst             |  2 +-
 scripts/coverity-scan/COMPONENTS.md |  3 +++
 4 files changed, 13 insertions(+), 20 deletions(-)

