Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA93CAC5AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 00:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqi9P-0000Pq-CS; Tue, 17 Sep 2024 20:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9J-00004y-TF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:26 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9I-0006OL-Ey
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=VXIh1OpJ2WnHoB3ZdnaHZH2OsRh0yz520CNkxHpQVeg=; b=AgYORbIEnl0L1WdC
 0Gh8CjNZ4Ndp69wRWEhATTrqNUlYBvs1fLY5Y6tuhjFAGshYumyIaO4bg8MqEzuuyw3d/yw8HjOR2
 jNEVwKe2ViENMGio/ZwN0eq2K5yPf0q87DlMUwuPTxxGNpcJyvAv7dFx1Mp2YlhckaADZ1+5brI8A
 eFIqZdYE5KVTHvKyCodVnoCIwavebRucqXNkx6Zwd31SiQYBNszEmiU+ypjOZO3Dq62dolig7bZk0
 Tv+7vauZYsuWXpLlASLPYai5pKOrlxKLvHBaD2ZELya4NECz0wRQ2wWiwNYr+Do8aLt/XlM41Brem
 YdI5yT18KTFomRAi5A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqi9F-006Dj5-27;
 Wed, 18 Sep 2024 00:02:21 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 3/3] migration: Remove unused socket_send_channel_create_sync
Date: Wed, 18 Sep 2024 01:02:07 +0100
Message-ID: <20240918000207.182683-4-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918000207.182683-1-dave@treblig.org>
References: <20240918000207.182683-1-dave@treblig.org>
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
2.46.0


