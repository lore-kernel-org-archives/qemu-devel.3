Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B708F483D6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ibC-0004NS-6n; Mon, 23 Mar 2026 12:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4ib3-0004M4-NI; Mon, 23 Mar 2026 12:57:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4ib1-0001Cx-B6; Mon, 23 Mar 2026 12:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1774285039; bh=btsjFwuIM1+8WIAyRCAEuPZlKzrC7qc17WCyqUnzwDk=;
 h=From:To:Cc:Subject:Date;
 b=Tjiaia21F6vGePrMRALb7qrzwPXxSpGoTSAG4hJ0J6YqZXPecI8Thdsdqd74NPk78
 jDgqyDOFrpARzqFRCcmKggApkvrHG6tFRNaQFQmvuXPonuw9FdwLgQsLdFQu6k1w4E
 VyHs2RsUDFwjXfmTALHBmZRtXWdaA1jLo2a+Q/OjkpisNmK7hezfXiFqOGEHIx+4Mj
 luIGcqM259wdWECuE+hSfmMWdm7OkxRJ05Bp0L4mtLkwaYmiODum7PeUGh0Y2dXpzK
 thSFIknraHP+nT5t1+ruyXx5M68ID6uLnjdPvYfvRletaeLrk2VVKamUTi9AgnIxqi
 b5Clr29nyqcxg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88A37196B4A;
 Mon, 23 Mar 2026 19:57:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9EF5538528E;
 Mon, 23 Mar 2026 19:57:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL v2 0/4] Trivial patches for 2026-03-23
Date: Mon, 23 Mar 2026 19:57:13 +0300
Message-ID: <20260323165736.386677-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit eb153d8fd3be325a5aa7e1a6a73be8854eeaaf27:

  Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu into staging (2026-03-23 10:55:20 +0000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to b7ae542de40364cccb683a67e5f891d3ef69818f:

  Fix several typos in documentation (found by codespell) (2026-03-23 19:55:24 +0300)

----------------------------------------------------------------
trivial patches for 2026-03-23

minor u2f tweaks ny Stefan, and small docs/comments updates

v2: fix email address of Stefan.
    (not resending the series)
----------------------------------------------------------------
Stefan Weil (3):
      Fix include statement for u2f-emu.h
      docs: Update GitHub URL of libu2f-emu
      Fix several typos in documentation (found by codespell)

xieyi (1):
      tests: fix typo in char unit test comment

 contrib/plugins/traps.c         | 2 +-
 docs/about/emulation.rst        | 2 +-
 docs/devel/code-provenance.rst  | 4 ++--
 docs/system/devices/usb-u2f.rst | 2 +-
 docs/system/tls.rst             | 8 ++++----
 hw/arm/virt.c                   | 2 +-
 hw/usb/u2f-emulated.c           | 2 +-
 include/hw/arm/virt.h           | 2 +-
 include/plugins/qemu-plugin.h   | 2 +-
 qapi/block-core.json            | 8 ++++----
 qapi/job.json                   | 2 +-
 qapi/uefi.json                  | 2 +-
 qemu-options.hx                 | 6 +++---
 tests/unit/test-char.c          | 2 +-
 14 files changed, 23 insertions(+), 23 deletions(-)

