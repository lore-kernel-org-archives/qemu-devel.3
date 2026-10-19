Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA1ECCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIhKm-0006xN-JS; Mon, 19 Oct 2026 02:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xIhKk-0006vD-6L; Mon, 19 Oct 2026 02:58:58 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xIhKi-0006l9-90; Mon, 19 Oct 2026 02:58:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 0328880806;
 Mon, 19 Oct 2026 09:58:50 +0300 (MSK)
Received: from i115954770.yandex-team.ru
 by mail-nwsmtp-smtp-corp-main-68 with ESMTPSA id nwSS6342ba60-wpaYifFj;
 Mon, 19 Oct 2026 09:58:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792393129;
 bh=61SAkshpE84P3qk9SnDj3Abgk5zfZLPjNo3gEjqZms0=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=XWpWuRpCvkO0eJzpuMOBGwKceYnLInhwc4jk7IrFFi2fJcLVgEGgszWKKG9TQb04a
 7kwbxSsv8S6B0AyeMGvxWUfkp3oq6GGvFNUbakJF9lk1o/uHYTC10kkPkRWBlZ1/5w
 alczjBtRMTnnX+h9rOwrwtalhGxlPSIrAQKvGTBM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PULL 0/2] block: block-jobs and bitmaps patches
Date: Mon, 19 Oct 2026 09:58:26 +0300
Message-ID: <20261019065828.16335-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 62c31d1b6aa8e255c528df41c51a35dec9516be9:

  Merge tag 'pull-riscv-to-apply-20261016' of https://github.com/alistair23/qemu into staging (2026-10-16 06:09:05 +0200)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-2026-10-16

for you to fetch changes up to 5689c59055e7652cc4b6ac0a47b6e48faad4d59d:

  block/mirror: inherit the source node discard flag in mirror_top (2026-10-16 09:46:54 +0300)

----------------------------------------------------------------
block: block-jobs and bitmaps patches

----------------------------------------------------------------

Haoqian He (1):
  block/mirror: inherit the source node discard flag in mirror_top

Jean-Louis Dupond (1):
  qcow2: add functionality to repair bitmaps

 block/mirror.c         | 10 ++++++++--
 block/qcow2-bitmap.c   | 41 ++++++++++++++++++++++++++++++++++++++---
 block/qcow2-refcount.c |  3 ++-
 block/qcow2.c          | 16 ++++++++++++----
 block/qcow2.h          |  3 ++-
 5 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.43.0


