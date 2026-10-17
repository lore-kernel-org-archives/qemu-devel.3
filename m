Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755A8CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2X-0000a8-Da; Sat, 17 Oct 2026 16:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1g-0006cC-4x; Sat, 17 Oct 2026 16:29:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1e-00040Y-I7; Sat, 17 Oct 2026 16:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268848; bh=1zHwW4WwoHU5qLd69mI83pMRaWYA96zbDsVK4o30ErU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sR+VLy1gV8oRb1UPo0aw0G/i9eqhzJm8TlL3cXQCSbQuklLflyRqJEZglhI1gUgdi
 6ejEwWlICes3m786lsjOP68/I9h4CHQL2gYAVZ8RuQhJxV2GO5aNMoxz3U979qmq30
 FL3CmJ0SeJgZFjHuY7icxyaKJ1C1BHhyH3n7TjfthvxmYsRHs+9I6PkSGwzvNKDATV
 7vshaJymVK1n0s9zStxSNjDitWR8J5STz03ADIRWMU46SVqysB6vK53R8QUKIj0Atk
 +ZRftmHUQ2Ubr2uSYuur3Rw8Hs65WvhFYMEtZRtgX4ZMZmyZaWcpQKGlbQhVB/Y5z+
 4ykGgImuOKu5Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2B3A1DE754;
 Sat, 17 Oct 2026 23:27:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A0DAF44342A;
 Sat, 17 Oct 2026 23:27:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 24/73] hw/display/qxl: trace skipped stale loadvm
 commands
Date: Sat, 17 Oct 2026 23:25:42 +0300
Message-ID: <20261017202638.728621-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Emit a trace event when qxl_post_load() drops a cursor or surface
command whose guest address no longer resolves, so a migration that
lands on a stale tracked pointer is visible instead of silent.

Message-ID: <20260825172051.435372-4-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
(cherry picked from commit 7e429d3624c4ad911af533e2f8f914b12f36dadc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index fb77f217b1..d5f9771f5a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2461,6 +2461,8 @@ static int qxl_post_load(void *opaque, int version)
             }
             if (!qxl_loadvm_cmd_valid(d, d->guest_surfaces.cmds[in],
                                       QXL_CMD_SURFACE)) {
+                trace_qxl_post_load_stale_cmd(d->id, "surface",
+                                              d->guest_surfaces.cmds[in]);
                 continue;
             }
             cmds[out].cmd.data = d->guest_surfaces.cmds[in];
@@ -2468,12 +2470,15 @@ static int qxl_post_load(void *opaque, int version)
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
             out++;
         }
-        if (d->guest_cursor &&
-            qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
-            cmds[out].cmd.data = d->guest_cursor;
-            cmds[out].cmd.type = QXL_CMD_CURSOR;
-            cmds[out].group_id = MEMSLOT_GROUP_GUEST;
-            out++;
+        if (d->guest_cursor) {
+            if (qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
+                cmds[out].cmd.data = d->guest_cursor;
+                cmds[out].cmd.type = QXL_CMD_CURSOR;
+                cmds[out].group_id = MEMSLOT_GROUP_GUEST;
+                out++;
+            } else {
+                trace_qxl_post_load_stale_cmd(d->id, "cursor", d->guest_cursor);
+            }
         }
         qxl_spice_loadvm_commands(d, cmds, out);
         g_free(cmds);
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4bfc457fba..c5e7e42af2 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -82,6 +82,7 @@ qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, const char *des
 qxl_io_write(int qid, const char *mode, uint64_t addr, const char *aname, uint64_t val, unsigned size, int async) "%d %s addr=%"PRIu64 " (%s) val=%"PRIu64" size=%u async=%d"
 qxl_memslot_add_guest(int qid, uint32_t slot_id, uint64_t guest_start, uint64_t guest_end) "%d %u: guest phys 0x%"PRIx64 " - 0x%" PRIx64
 qxl_post_load(int qid, const char *mode) "%d %s"
+qxl_post_load_stale_cmd(int qid, const char *kind, uint64_t data) "%d skip stale %s cmd 0x%"PRIx64
 qxl_pre_load(int qid) "%d"
 qxl_pre_save(int qid) "%d"
 qxl_reset_surfaces(int qid) "%d"
-- 
2.47.3


