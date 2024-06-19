Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5417BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pd-0001qv-4J; Wed, 19 Jun 2024 18:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pa-0001q7-Kk
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pZ-0008Pk-3O
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27xJFRRKvK54skIyMMmN8RUpsUo90Pcr5piRqr+33Eg=;
 b=XM1YjGw24IkD8Y23Z00LpZkB2w1vzYfIszkvolQhL+bN/9dCdldjMGVvDpEG0gs+UA8oU/
 mDf62xO4hbIW+ccM9Vi78KFc4fmxvcN4lKD/GDRj+JNevyNTcZlhjLkGWcP5aVXp2vt2gR
 EDPTvwUBXexjqDuynfM1FLplEQ2NJuw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-lqq_PWoJMLqSi4fHqL4LOw-1; Wed, 19 Jun 2024 18:31:01 -0400
X-MC-Unique: lqq_PWoJMLqSi4fHqL4LOw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6faa28bab62so55734a34.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836259; x=1719441059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27xJFRRKvK54skIyMMmN8RUpsUo90Pcr5piRqr+33Eg=;
 b=MEtO2QaRmpVJ4cn7sZyk3dZPWUs9jMheDYCR/vHH2uYh0rtLFMKfBHzrLZCq++1Esv
 I5VHiVT1VloeVdZGTfIoDdI2GRygLYaIEAW6Q5UxLXpuwx8rIuzYQhmhG5MO4xDk0uIL
 w8jhNClxANKlKJwuUOnRm9KgKdM5g+D2ltej+mxvOqbEpo8+4hbnTnY5ATqlv1+efl+3
 U3jJYshH2/RyANIJLjEUnJLbYoPEm6SiBUYVIktktMACyZPzk9rXQ0XSR30ON3dUJxnH
 I5k0xJt6edGU5siIMm3w8eKSyDFM1XfjXsVrCe1hJCOGx9f/W+OH+ElsOEENn62LaXsJ
 eDYQ==
X-Gm-Message-State: AOJu0Yy3U1fhK2KwLOweCCjgZWH0+2f8iYiUBTME/XqzgIc6j2hA/Bef
 TYmOH2Z6OpoQXs/oB/GmfD4STu5CxPIXIfClFzYesXzDI8Y+P1CVIeUew7AFafBQusJZenBMhcL
 voo/ZOUzwON/vu9i1541DHr5xt7dLG2aHQEHuDQrgrbovCorncYhOGX10l2tqMQAneBgQ35CFpN
 0iZHPxWTf3XSCr7YXhRU+4BkRNrksigESkPw==
X-Received: by 2002:a05:6830:1c45:b0:6fb:8c91:5969 with SMTP id
 46e09a7af769-70075596c20mr3940776a34.2.1718836259415; 
 Wed, 19 Jun 2024 15:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHDXuLNbGboiDCcn8RUqKWsKIjQGWZZhpdcsSA28maRIqslrDXnUbrHVSVKs0PEWZZ/Ccd+Q==
X-Received: by 2002:a05:6830:1c45:b0:6fb:8c91:5969 with SMTP id
 46e09a7af769-70075596c20mr3940737a34.2.1718836258782; 
 Wed, 19 Jun 2024 15:30:58 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:30:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 04/11] migration: Cleanup incoming migration setup state
 change
Date: Wed, 19 Jun 2024 18:30:39 -0400
Message-ID: <20240619223046.1798968-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Destination QEMU can setup incoming ports for two purposes: either a fresh
new incoming migration, in which QEMU will switch to SETUP for channel
establishment, or a paused postcopy migration, in which QEMU will stay in
POSTCOPY_PAUSED until kicking off the RECOVER phase.

Now the state machine worked on dest node for the latter, only because
migrate_set_state() implicitly will become a noop if the current state
check failed.  It wasn't clear at all.

Clean it up by providing a helper migration_incoming_state_setup() doing
proper checks over current status.  Postcopy-paused will be explicitly
checked now, and then we can bail out for unknown states.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 795b30f0d0..41a88fc50a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -618,6 +618,29 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
     return true;
 }
 
+static bool
+migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
+{
+    MigrationStatus current = mis->state;
+
+    if (current == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        /*
+         * Incoming postcopy migration will stay in PAUSED state even if
+         * reconnection happened.
+         */
+        return true;
+    }
+
+    if (current != MIGRATION_STATUS_NONE) {
+        error_setg(errp, "Illegal migration incoming state: %s",
+                   MigrationStatus_str(current));
+        return false;
+    }
+
+    migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
@@ -656,8 +679,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
-                      MIGRATION_STATUS_SETUP);
+    if (!migration_incoming_state_setup(mis, errp)) {
+        return;
+    }
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
-- 
2.45.0


