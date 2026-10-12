Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4DECA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGBl0-0005nh-L7; Mon, 12 Oct 2026 04:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuanmh12@chinatelecom.cn>)
 id 1xGBkt-0005nS-Ee
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 04:51:37 -0400
Received: from smtph3-03.21cn.com ([150.223.194.104])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanmh12@chinatelecom.cn>) id 1xGBko-0002Ie-DN
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 04:51:34 -0400
HMM_SOURCE_IP: 172.27.0.101:0.1907625505
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-106.63.1.11 (unknown [172.27.0.101])
 by smtph3-03.21cn.com (HERMES) with SMTP id CD98EC02D047;
 Mon, 12 Oct 2026 16:42:48 +0800 (CST)
X-189-SAVE-TO-SEND: +yuanmh12@chinatelecom.cn
Received: from  ([106.63.1.11])
 by gateway-ssl-dep-b4975c4bd-92dqx with ESMTP id
 f004edab61d0494089dd9fa921aa2714 for qemu-devel@nongnu.org; 
 Mon, 12 Oct 2026 16:42:52 CST
X-Transaction-ID: f004edab61d0494089dd9fa921aa2714
X-Real-From: yuanmh12@chinatelecom.cn
X-Receive-IP: 106.63.1.11
X-MEDUSA-Status: 0
From: yuanminghao <yuanmh12@chinatelecom.cn>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/1] migration: shorten dst snapshot load thread name
Date: Mon, 12 Oct 2026 16:42:45 +0800
Message-Id: <20261012084245.30635-1-yuanmh12@chinatelecom.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.223.194.104;
 envelope-from=yuanmh12@chinatelecom.cn; helo=smtph3-03.21cn.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

pthread_setname_np() fails with ERANGE if the name is longer than
15 characters, so "mig/dst/snapshot_load" (21 characters) is
rejected and the thread keeps its default name.

Shorten it to "mig/dst/snapld" (15 characters) so the name is
actually applied.

Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>
---
 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 683bc7bdd5..1329f6bba4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -42,7 +42,7 @@
 #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
-#define  MIGRATION_THREAD_DST_SNAPSHOT_LOAD "mig/dst/snapshot_load"
+#define  MIGRATION_THREAD_DST_SNAPSHOT_LOAD "mig/dst/snapld"
 
 struct PostcopyBlocktimeContext;
 typedef struct ThreadPool ThreadPool;
-- 
2.20.1


