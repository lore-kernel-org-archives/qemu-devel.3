Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DB5EFCBD5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226p-0000Az-Hx; Mon, 16 Mar 2026 03:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w226X-00082e-8o; Mon, 16 Mar 2026 03:11:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w226V-0007p2-GT; Mon, 16 Mar 2026 03:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645003; bh=O/QobWZYO3a1Slm7Q6FoRbaGyn2a5zCc8rwbvewyogg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V4gu9l8g2Zgky7Hv3DkVnA4wLAOsv5AmdajrxiJ6bnADU5xPSBR2qglvJGJFArzqm
 emFql9oPMYEM7HeSL2tTkm+rzxAf+P+0yZb6NiGacJInzUmTR+Dpqb4lGrb2PqHpUY
 GquKDcmk/HRIUatUfaEWG9vyTpG4yKPDXRL8Ei1SYkv5QO1Js6DookEwRc/b1ZlUcX
 eXKW7MyUjpsZ9ns3JTpGfNzaHNoM0Iyawopix2maV1Qgto9cjSU3PQUVHo4pi6XpiU
 VwAMZrC+yTPDtnHDpXfrhAWY7Ci+hQhmJffqCMPnImXfiOitg9GskgN1AViEgeTjjX
 53n0sE1BcbZWg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4EB15193C30;
 Mon, 16 Mar 2026 10:10:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5947A380058;
 Mon, 16 Mar 2026 10:10:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 14/14] rename CONFIG_EPOLL_CREATE1 to CONFIG_EPOLL,
 and stop checking for epoll in meson.build
Date: Mon, 16 Mar 2026 10:10:02 +0300
Message-ID: <20260316071005.91624-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since CONFIG_EPOLL is now unused, it's okay to
perform this rename, to make it less ugly.

Since epoll is linux-specific and is always present on linux,
define CONFIG_EPOLL to 1 on linux, without compile-time test.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 meson.build      | 3 +--
 util/aio-posix.h | 4 ++--
 util/meson.build | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 264a1c4b72..b2154bb928 100644
--- a/meson.build
+++ b/meson.build
@@ -2685,8 +2685,7 @@ config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
 # has_header_symbol
 config_host_data.set('CONFIG_BLKZONED',
                      cc.has_header_symbol('linux/blkzoned.h', 'BLKOPENZONE'))
-config_host_data.set('CONFIG_EPOLL_CREATE1',
-                     cc.has_header_symbol('sys/epoll.h', 'epoll_create1'))
+config_host_data.set('CONFIG_EPOLL', host_os == 'linux')
 config_host_data.set('CONFIG_FALLOCATE_PUNCH_HOLE',
                      cc.has_header_symbol('linux/falloc.h', 'FALLOC_FL_PUNCH_HOLE') and
                      cc.has_header_symbol('linux/falloc.h', 'FALLOC_FL_KEEP_SIZE'))
diff --git a/util/aio-posix.h b/util/aio-posix.h
index 0cedb8d189..ab894a3c0f 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -52,7 +52,7 @@ extern const FDMonOps fdmon_poll_ops;
 /* Switch back to poll(2). list_lock must be held. */
 void fdmon_poll_downgrade(AioContext *ctx);
 
-#ifdef CONFIG_EPOLL_CREATE1
+#ifdef CONFIG_EPOLL
 bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd);
 void fdmon_epoll_setup(AioContext *ctx);
 
@@ -71,7 +71,7 @@ static inline void fdmon_epoll_setup(AioContext *ctx)
 static inline void fdmon_epoll_disable(AioContext *ctx)
 {
 }
-#endif /* !CONFIG_EPOLL_CREATE1 */
+#endif /* !CONFIG_EPOLL */
 
 #ifdef CONFIG_LINUX_IO_URING
 bool fdmon_io_uring_setup(AioContext *ctx, Error **errp);
diff --git a/util/meson.build b/util/meson.build
index e7a2a2a64c..33132c04ad 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -3,7 +3,7 @@ util_ss.add(files('thread-context.c'), numa)
 if host_os != 'windows'
   util_ss.add(files('aio-posix.c'))
   util_ss.add(files('fdmon-poll.c'))
-  if config_host_data.get('CONFIG_EPOLL_CREATE1')
+  if config_host_data.get('CONFIG_EPOLL')
     util_ss.add(files('fdmon-epoll.c'))
   endif
   util_ss.add(files('compatfd.c'))
-- 
2.47.3


