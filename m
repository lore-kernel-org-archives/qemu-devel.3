Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26639C3ABB2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 00:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqLxQ-0005gT-0b; Mon, 16 Sep 2024 20:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqLxM-0005dV-9Y; Mon, 16 Sep 2024 20:20:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqLx9-0004h7-0F; Mon, 16 Sep 2024 20:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=tMr2hCwjWAs6864CxYZ41XYc60jRLO1VTLyODAr5PCM=; b=X+TK+9Dk6XwCZw52
 ATwgnXS4EFBaF/PNaTC4WFvgFWjOgaTeWU0S85wgjPGl5LEJekEfLzNbhUTKZL9WmsoLH4xgybwpH
 1KNDwvy1ecY6NeA1NvyX9PiNE/WGd1kb96RJ6WBzdpQ54mrDp9XaEj0mANKcK4Z9mf6kHdAbcjxjF
 C8khg3txoITzD+GRhX/5pUm/Djuwm8zUMtuS/OI9hDWEOpQJlZ5xb/2F74Juzy0vBBotZdvUIaOMU
 bO9bSIsT6mBdE7229mZ4E/MDrOHdybogpCBl561QX6fqOzpTC/NHSQWqllDgQSYuFnyqd1M/hAu4K
 Il13a1fC4G2hlW/Iig==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqLwx-0062n3-2I;
 Tue, 17 Sep 2024 00:20:11 +0000
From: dave@treblig.org
To: jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] block: Remove unused aio_task_pool_empty
Date: Tue, 17 Sep 2024 01:20:07 +0100
Message-ID: <20240917002007.330689-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

aio_task_pool_empty has been unused since it was added in
  6e9b225f73 ("block: introduce aio task pool")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 block/aio_task.c         | 5 -----
 include/block/aio_task.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/block/aio_task.c b/block/aio_task.c
index 9bd17ea2c1..bb5c05f455 100644
--- a/block/aio_task.c
+++ b/block/aio_task.c
@@ -119,8 +119,3 @@ int aio_task_pool_status(AioTaskPool *pool)
 
     return pool->status;
 }
-
-bool aio_task_pool_empty(AioTaskPool *pool)
-{
-    return pool->busy_tasks == 0;
-}
diff --git a/include/block/aio_task.h b/include/block/aio_task.h
index 18a9c41f4e..c81d637617 100644
--- a/include/block/aio_task.h
+++ b/include/block/aio_task.h
@@ -40,8 +40,6 @@ void aio_task_pool_free(AioTaskPool *);
 /* error code of failed task or 0 if all is OK */
 int aio_task_pool_status(AioTaskPool *pool);
 
-bool aio_task_pool_empty(AioTaskPool *pool);
-
 /* User provides filled @task, however task->pool will be set automatically */
 void coroutine_fn aio_task_pool_start_task(AioTaskPool *pool, AioTask *task);
 
-- 
2.46.0


