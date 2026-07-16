Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AABC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkFgi-0006Dq-Mn; Thu, 16 Jul 2026 02:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wkFgg-0006DF-F6; Thu, 16 Jul 2026 02:35:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wkFgd-0002QX-OO; Thu, 16 Jul 2026 02:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784183702; bh=NjlrzohBIu7+43BlB66ySFRfm3d1bfSR5cb2ZatdC7w=;
 h=From:To:Cc:Subject:Date;
 b=xNoovZxgw0WmwdS2zaUS52G3jRU+WkgOYp1hKhZ+HTw+BRYm0ep5u4DqFd/8k8sd4
 p67jgA9A4GxxBOx3qtTL/wJ07ETMCUueKHJpY5M4izTgv3pVdNmNjdjs9wMzeiJcTo
 d6tI+y8nKot+tgTW9l+vZKW8tb9vBn9oAdpT4J+xEvkLkjttZRU/7PqE4d2eqFLuX+
 ZzopGHpNhSLfNrUoC927JVkhP8o6ID/7UcU9U0900vTsk4OdeGoaVhf1FNHqpZwHqj
 Vws2MfgWn8+IHVZlQQUD96YAE2qw9MUAhtj1fXnceou08eBS6VPvMyThLJL2pcfxY5
 TOOTzo8WyGAuQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F29C1C21C3;
 Thu, 16 Jul 2026 09:35:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 092123EFD4B;
 Thu, 16 Jul 2026 09:35:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D7E2114216; Thu, 16 Jul 2026 09:35:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Xu <peterx@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH trivial] spelling: happend
Date: Thu, 16 Jul 2026 09:34:54 +0300
Message-ID: <20260716063457.532035-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Fixes: 44adb5fcc20d "target/riscv: Remove spike as default machine"
Fixes: 48814111366b "migration: Always set DEVICE state"
Fixes: 3345fb3b6d7f "migration/postcopy: Add latency distribution report for blocktime"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/about/removed-features.rst | 2 +-
 migration/migration.c           | 2 +-
 qapi/migration.json             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f7a2aa326de..0735b4ea1d5 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1241,7 +1241,7 @@ RISC-V default machine (removed in 11.1)
 ''''''''''''''''''''''''''''''''''''''''
 
 RISC-V used to define ``spike`` as the default machine if no machine option
-was given via the command line.  This happend because ``spike`` was the first
+was given via the command line.  This happened because ``spike`` was the first
 RISC-V machine implemented in QEMU and setting it as default was
 convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
 and having ``spike`` as a default is no longer justified.
diff --git a/migration/migration.c b/migration/migration.c
index 9736c14458b..9df6da131ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2806,7 +2806,7 @@ static bool migration_switchover_prepare(MigrationState *s)
     bql_lock();
     /*
      * After BQL released and retaken, the state can be CANCELLING if it
-     * happend during sem_wait().. Only change the state if it's still
+     * happened during sem_wait().. Only change the state if it's still
      * pre-switchover.
      */
     migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
diff --git a/qapi/migration.json b/qapi/migration.json
index 66bd900465a..802474750b5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -270,7 +270,7 @@
 #     (Since 10.1)
 #
 # @postcopy-non-vcpu-latency: average remote page fault latency for
-#     all faults happend in non-vCPU threads (in ns).  It has the same
+#     all faults happened in non-vCPU threads (in ns).  It has the same
 #     definition of @postcopy-latency but this only provides
 #     statistics to non-vCPU faults.  This is only present when the
 #     postcopy-blocktime migration capability is enabled.
-- 
2.47.3


