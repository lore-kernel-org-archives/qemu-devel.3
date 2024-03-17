Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81E0C54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaL-0002Fp-84; Sun, 17 Mar 2024 16:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaJ-0002F6-N7
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaI-0002do-5m
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nz8vhY0nyugAeRv9MWQlmYdsswd/VLGriTQno8XhX7U=;
 b=UKENncML9wKXjtQFF3dsDWULEhd9iVIqPcwa0c/KbR0su+QOIVsrX8pPrNLZWuSl8WbHGA
 uB9+Bd/FZ/3+ERxaTx6mW5p92O5+J0WOvrgVFKp0bKW5C6EduYV5QiYpMpbFhLJtY6aZ3K
 8CiAS17sQifsTgj4Sn/xKJHW7aFSsHw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-xHFKda0IOzijUt9iLfLtWw-1; Sun, 17 Mar 2024 16:58:20 -0400
X-MC-Unique: xHFKda0IOzijUt9iLfLtWw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430d45c66acso372621cf.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709099; x=1711313899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nz8vhY0nyugAeRv9MWQlmYdsswd/VLGriTQno8XhX7U=;
 b=b0zA0wHKA7MOvytQCLUhQNv0XWezgdHCpzY9AeQMPAn+HpjON6VDaZ81q7N/YzzSRB
 zDISVoFOQQEoBcccEkU3SqP462jiY3iTlkV4rP/rKhM5kETWJTbyvszrDHefM/2nXxqF
 XAeieXnUwTJa8eDo7y+o/uV+SSecumoOl3A/DuilYHoihewm1eBuIdm0O6n0d2QBsaaD
 /yeHufdmtkmz1M2LiwcocbYjrRJ9HlvHeJniy915oUgCsr7oJnpnHjf6n6MXskSVcQA8
 j/txdkhuqmBxgvAIDsqQ9BzdFrqAUvevgNbHreigcj2MN96FsDSl0iemjSqxLGwjp6T5
 KIZQ==
X-Gm-Message-State: AOJu0YwlTgwC9dTe8KSkcSwgRdPJl6WWV5iTRxtVBSKfwUh/PBtAtsci
 WjSaHyXZ7HHnOyXuvEiri/cz8k6BCUFxcqt/zK6YcQuQwYdub3M/lV8ryJUAm/mLl1wto5eFqJ6
 JefL+OuucDClyJXLf93vVGvpHKOO5wsTekAGlt/DtH1huAxppGbGPy2wLXIIMIi4ptA0NGEjNYz
 xkV26G5f5xZU4QY1A13n4vIfg5NGst7GZxmg==
X-Received: by 2002:ad4:41cc:0:b0:691:87dd:f836 with SMTP id
 a12-20020ad441cc000000b0069187ddf836mr6382254qvq.5.1710709099164; 
 Sun, 17 Mar 2024 13:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0hAPoh8PVF19JyzM3bDv5NCa9eyF5V5INCZ/GqxFjfehjwVscBnYO8Eozt1fUPIOGGXpCsw==
X-Received: by 2002:ad4:41cc:0:b0:691:87dd:f836 with SMTP id
 a12-20020ad441cc000000b0069187ddf836mr6382223qvq.5.1710709098636; 
 Sun, 17 Mar 2024 13:58:18 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:18 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/10] migration/multifd: Ensure we're not given a socket for
 file migration
Date: Sun, 17 Mar 2024 16:58:02 -0400
Message-ID: <20240317205803.361163-10-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

When doing migration using the fd: URI, QEMU will fetch the file
descriptor passed in via the monitor at
fd_start_outgoing|incoming_migration(), which means the checks at
migration_channels_and_transport_compatible() happen too soon and we
don't know at that point whether the FD refers to a plain file or a
socket.

For this reason, we've been allowing a migration channel of type
SOCKET_ADDRESS_TYPE_FD to pass the initial verifications in scenarios
where the socket migration is not supported, such as with fd + multifd.

The commit decdc76772 ("migration/multifd: Add mapped-ram support to
fd: URI") was supposed to add a second check prior to starting
migration to make sure a socket fd is not passed instead of a file fd,
but failed to do so.

Add the missing verification and update the comment explaining this
situation which is currently incorrect.

Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240315032040.7974-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.c        | 8 ++++++++
 migration/file.c      | 7 +++++++
 migration/migration.c | 6 +++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 39a52e5c90..c07030f715 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -22,6 +22,7 @@
 #include "migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-file.h"
+#include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "options.h"
 #include "trace.h"
@@ -95,6 +96,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
     }
 
     if (migrate_multifd()) {
+        if (fd_is_socket(fd)) {
+            error_setg(errp,
+                       "Multifd migration to a socket FD is not supported");
+            object_unref(ioc);
+            return;
+        }
+
         file_create_incoming_channels(ioc, errp);
     } else {
         qio_channel_set_name(ioc, "migration-fd-incoming");
diff --git a/migration/file.c b/migration/file.c
index ddde0ca818..b6e8ba13f2 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -15,6 +15,7 @@
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
+#include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "options.h"
 #include "trace.h"
@@ -58,6 +59,12 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
     int fd = fd_args_get_fd();
 
     if (fd && fd != -1) {
+        if (fd_is_socket(fd)) {
+            error_setg(errp,
+                       "Multifd migration to a socket FD is not supported");
+            goto out;
+        }
+
         ioc = qio_channel_file_new_dupfd(fd, errp);
     } else {
         ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
diff --git a/migration/migration.c b/migration/migration.c
index 644e073b7d..f60bd371e3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -166,9 +166,9 @@ static bool transport_supports_seeking(MigrationAddress *addr)
     }
 
     /*
-     * At this point, the user might not yet have passed the file
-     * descriptor to QEMU, so we cannot know for sure whether it
-     * refers to a plain file or a socket. Let it through anyway.
+     * At this point QEMU has not yet fetched the fd passed in by the
+     * user, so we cannot know for sure whether it refers to a plain
+     * file or a socket. Let it through anyway and check at fd.c.
      */
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         return addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD;
-- 
2.44.0


