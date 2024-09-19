Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0F1CF3941
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHUi-0007yW-UL; Thu, 19 Sep 2024 09:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUg-0007qI-Bu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:50 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUQ-0005zx-UR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=6vNa82WphtB1is9lgrKpqh6cZbhNlLMUwM6YrQbpBXs=; b=h+Fy/18hZSQWnxkI
 cF1soIFGxmL4f+WRJZzgcY2y5z1fXstdXPMfi5xzatT64qXLveqtF0kk/TkI1ANJ7DMkzKm0yV5bQ
 gfVx+is6u337HH568vRVrzejyhUMHP3D5QTP3dSgKUQsCFtbMt0yMHLG+tDK8ReXVgxicucxA1EJl
 +bh8FHp7b+kAsfYgNSz1xHhEMAKXxe7jyL6zer+q4JvbqjG3fzfYpQa1Q3WB+3ePlQLpUpTPHmz5B
 mK5x/vUL2Oxg+qRF0GixSX3YfQqDQ+UbWzG/y5kzqS70l1SjNovhPK5QYV8JJuuRDDlDQ9M6wUmwh
 0rlgiK9fvrSxYSmEGA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srHUM-006QOJ-2F;
 Thu, 19 Sep 2024 13:46:30 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 4/7] migration: Remove unused
 socket_send_channel_create_sync
Date: Thu, 19 Sep 2024 14:46:23 +0100
Message-ID: <20240919134626.166183-5-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919134626.166183-1-dave@treblig.org>
References: <20240919134626.166183-1-dave@treblig.org>
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

socket_send_channel_create_sync only use was removed by
  d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/socket.c | 18 ------------------
 migration/socket.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 9ab89b1e08..5ec65b8c03 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -42,24 +42,6 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
                                      f, data, NULL, NULL);
 }
 
-QIOChannel *socket_send_channel_create_sync(Error **errp)
-{
-    QIOChannelSocket *sioc = qio_channel_socket_new();
-
-    if (!outgoing_args.saddr) {
-        object_unref(OBJECT(sioc));
-        error_setg(errp, "Initial sock address not set!");
-        return NULL;
-    }
-
-    if (qio_channel_socket_connect_sync(sioc, outgoing_args.saddr, errp) < 0) {
-        object_unref(OBJECT(sioc));
-        return NULL;
-    }
-
-    return QIO_CHANNEL(sioc);
-}
-
 struct SocketConnectData {
     MigrationState *s;
     char *hostname;
diff --git a/migration/socket.h b/migration/socket.h
index 46c233ecd2..04ebbe95a1 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -22,7 +22,6 @@
 #include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
-QIOChannel *socket_send_channel_create_sync(Error **errp);
 
 void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
-- 
2.46.1


