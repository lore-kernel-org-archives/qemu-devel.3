Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD50EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDo-00076E-Fi; Tue, 29 Apr 2025 07:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDh-0006vd-VM; Tue, 29 Apr 2025 07:33:50 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDd-0008Fo-UD; Tue, 29 Apr 2025 07:33:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D79AE613DA;
 Tue, 29 Apr 2025 14:33:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-DNZW9x1I; Tue, 29 Apr 2025 14:33:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926422;
 bh=TNo371By6R1gWLzBQzjueDMSgHamik/HswYQWJjXTkA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=z6DwbRkHmibdE1uWvEEnhz8Oh7V9yjOUKJd3za6cT9GbbAwPTebBJqTpHEhHNKfYD
 M3HfYs66gc0Tj+wDfJ5sxXhNRJaaav7mh+zxKGSiXJAkVj1pA2jg3WYSqLEn8k3Qyt
 x/AWarqwIgilLy15+R6Muv8IsDd/VPvnqcTWlkjg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 4/5] block: Remove unused aio_task_pool_empty
Date: Tue, 29 Apr 2025 14:33:30 +0300
Message-ID: <20250429113335.423535-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
Message-Id: <20240917002007.330689-1-dave@treblig.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
2.34.1


