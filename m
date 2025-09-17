Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9BCAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 14:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uytA8-0004n9-5l; Wed, 17 Sep 2025 10:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uytA6-0004mr-TB; Wed, 17 Sep 2025 10:29:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uytA0-0003Cy-Ps; Wed, 17 Sep 2025 10:29:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F4188154F72;
 Wed, 17 Sep 2025 17:29:17 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1F51E283174;
 Wed, 17 Sep 2025 17:29:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH trivial] vhost-user-test: remove trailing newlines in
 g_test_message() calls
Date: Wed, 17 Sep 2025 17:29:16 +0300
Message-ID: <20250917142919.928244-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Fixes: c9a1ea9c52 Revert "tests/qtest: use qos_printf instead of g_test_message"

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/qtest/vhost-user-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 56472ca709..e8c3613560 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -392,7 +392,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * We don't need to do anything here, the remote is just
          * letting us know it is in charge. Just log it.
          */
-        g_test_message("set_owner: start of session\n");
+        g_test_message("set_owner: start of session");
         break;
 
     case VHOST_USER_GET_PROTOCOL_FEATURES:
@@ -418,7 +418,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * the remote end to send this. There is no handshake reply so
          * just log the details for debugging.
          */
-        g_test_message("set_protocol_features: 0x%"PRIx64 "\n", msg.payload.u64);
+        g_test_message("set_protocol_features: 0x%"PRIx64, msg.payload.u64);
         break;
 
         /*
@@ -426,11 +426,11 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * address of the vrings but we can simply report them.
          */
     case VHOST_USER_SET_VRING_NUM:
-        g_test_message("set_vring_num: %d/%d\n",
+        g_test_message("set_vring_num: %d/%d",
                    msg.payload.state.index, msg.payload.state.num);
         break;
     case VHOST_USER_SET_VRING_ADDR:
-        g_test_message("set_vring_addr: 0x%"PRIx64"/0x%"PRIx64"/0x%"PRIx64"\n",
+        g_test_message("set_vring_addr: 0x%"PRIx64"/0x%"PRIx64"/0x%"PRIx64,
                    msg.payload.addr.avail_user_addr,
                    msg.payload.addr.desc_user_addr,
                    msg.payload.addr.used_user_addr);
@@ -463,7 +463,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_CALL:
         /* consume the fd */
         if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
-            g_test_message("call fd: %d, do not set non-blocking\n", fd);
+            g_test_message("call fd: %d, do not set non-blocking", fd);
             break;
         }
         /*
@@ -509,12 +509,12 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
          * fully functioning vhost-user we would enable/disable the
          * vring monitoring.
          */
-        g_test_message("set_vring(%d)=%s\n", msg.payload.state.index,
+        g_test_message("set_vring(%d)=%s", msg.payload.state.index,
                    msg.payload.state.num ? "enabled" : "disabled");
         break;
 
     default:
-        g_test_message("vhost-user: un-handled message: %d\n", msg.request);
+        g_test_message("vhost-user: un-handled message: %d", msg.request);
         break;
     }
 
-- 
2.47.3


