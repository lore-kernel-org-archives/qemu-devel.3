Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129E4C5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8Z-0004gi-8k; Sun, 03 Mar 2024 20:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx8G-0002sG-MN
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx8F-0002UT-58
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQjfAx5fwudle9JMFQ3un6R3jAgdZL0axGO7bP69yRk=;
 b=ciRgfk0zOa3qfWNIp3Gqm9jtWVmYGbwRaXZNqqtMBj7d9MyQffNqA09z0j95CNhkINGoO7
 Y3hQ7LOiV+yiRPyDjwe+QNdJTW0MmqX4V67sjuif6UW6SswSu6Q+HC97TIcAzJMxUiuUrE
 WTimxzpmRboAfNwbxwnKcOrdSmKUoYA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-zJ38GSrmNoemaGbvBocP4w-1; Sun,
 03 Mar 2024 20:28:37 -0500
X-MC-Unique: zJ38GSrmNoemaGbvBocP4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 707B93C0DD05;
 Mon,  4 Mar 2024 01:28:37 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10D7A40C6EBA;
 Mon,  4 Mar 2024 01:28:33 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 27/27] migration/multifd: Document two places for mapped-ram
Date: Mon,  4 Mar 2024 09:26:34 +0800
Message-ID: <20240304012634.95520-28-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Add two documentations for mapped-ram migration on two spots that may not
be extremely clear.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240301091524.39900-1-peterx@redhat.com
Cc: Prasad Pandit <ppandit@redhat.com>
[peterx: fix two English errors per Prasad]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 12 ++++++++++++
 migration/ram.c     |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b4e5a9dfcc..d4a44da559 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -709,6 +709,18 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
     if (p->c) {
         migration_ioc_unregister_yank(p->c);
+        /*
+         * An explicit close() on the channel here is normally not
+         * required, but can be helpful for "file:" iochannels, where it
+         * will include fdatasync() to make sure the data is flushed to the
+         * disk backend.
+         *
+         * The object_unref() cannot guarantee that because: (1) finalize()
+         * of the iochannel is only triggered on the last reference, and
+         * it's not guaranteed that we always hold the last refcount when
+         * reaching here, and, (2) even if finalize() is invoked, it only
+         * does a close(fd) without data flush.
+         */
         qio_channel_close(p->c, &error_abort);
         object_unref(OBJECT(p->c));
         p->c = NULL;
diff --git a/migration/ram.c b/migration/ram.c
index 1f1b5297cf..c79e3de521 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4258,7 +4258,13 @@ static int ram_load_precopy(QEMUFile *f)
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_MEM_SIZE:
             ret = parse_ramblocks(f, addr);
-
+            /*
+             * For mapped-ram migration (to a file) using multifd, we sync
+             * once and for all here to make sure all tasks we queued to
+             * multifd threads are completed, so that all the ramblocks
+             * (including all the guest memory pages within) are fully
+             * loaded after this sync returns.
+             */
             if (migrate_mapped_ram()) {
                 multifd_recv_sync_main();
             }
-- 
2.44.0


