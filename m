Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5DCCF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swknV-0002T7-C6; Fri, 04 Oct 2024 12:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swknT-0002R8-Vy; Fri, 04 Oct 2024 12:04:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swknS-0001ei-Gq; Fri, 04 Oct 2024 12:04:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 937C395574;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CDD1914D982;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282548 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 15/23] replay: Remove unused replay_disable_events
Date: Fri,  4 Oct 2024 19:03:23 +0300
Message-Id: <20241004160331.1282441-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

replay_disable_events has been unused since 2019's
  c8aa7895eb ("replay: don't drain/flush bdrv queue while RR is working")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/sysemu/replay.h | 2 --
 replay/replay-events.c  | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 8102fa54f0..cba74fa9bc 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -117,8 +117,6 @@ void replay_async_events(void);
 
 /* Asynchronous events queue */
 
-/*! Disables storing events in the queue */
-void replay_disable_events(void);
 /*! Enables storing events in the queue */
 void replay_enable_events(void);
 /*! Returns true when saving events is enabled */
diff --git a/replay/replay-events.c b/replay/replay-events.c
index af0721cc1a..2e46eda6bf 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -92,15 +92,6 @@ void replay_flush_events(void)
     }
 }
 
-void replay_disable_events(void)
-{
-    if (replay_mode != REPLAY_MODE_NONE) {
-        events_enabled = false;
-        /* Flush events queue before waiting of completion */
-        replay_flush_events();
-    }
-}
-
 /*! Adds specified async event to the queue */
 void replay_add_event(ReplayAsyncEventKind event_kind,
                       void *opaque,
-- 
2.39.5


