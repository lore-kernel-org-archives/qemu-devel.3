Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDF6C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pd-0001rJ-V9; Wed, 19 Jun 2024 18:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pb-0001qb-OA
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pa-0008Pp-3v
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjknN8ER+pxUl3oEWYLqDMj6B7YTis7H8m8tqUgYtxU=;
 b=TuO0FQXzawGccRx8IulZdsY8FUNahDdR8OuNPHvKFbmfqdcQbJcH20x09pbMgpKIPXiIxB
 rzVbnC4dpdlkGzKhe3L6blALPMc7lmZrHjTCzt9aD0kQPzBy5FwlDQE3pR+oTYTXTD2Rv0
 ReMCFQ8YW3bVjKt0Ebij/Se06WM/EKw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-_H4alwXsNUyecnDTgFhNfQ-1; Wed, 19 Jun 2024 18:31:04 -0400
X-MC-Unique: _H4alwXsNUyecnDTgFhNfQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dfe5c3dab2cso39927276.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836263; x=1719441063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjknN8ER+pxUl3oEWYLqDMj6B7YTis7H8m8tqUgYtxU=;
 b=VbXXNOqYLC5coUgDgATehyJe7bXYfskqisbrczHhpOtHt3KHDsnSsoXIDhHd0q31o+
 NMle9z0o/4AM67Sj9Y5zlcosaoZZTrq4Vb/HXT/cEbEAEcShYlq6A7N+xFQzh5oNq6FV
 +OCbU6cBSh/zCdm40HTMtu+7lIHL4qhEyJsXF59X2g7rOaaXFxDA3beEP9+OPCBrVz1T
 kHrs5crN++Yn9fIWWjm8iECVt6v25yfNYPZmFYZJNoogTVJ5aAIycvVWh9nrMP5Qmuz+
 zP9HxloJcz+Gp79ICFspBuFOp0gCVCiJj/2KVBmcLK6DkiZj8kRJsLJPZBKnq0ZY46Cn
 syZw==
X-Gm-Message-State: AOJu0Yyt9fAjqrVJ2C5/vEl7PBs+DRCqzZIM9CqM8y1v05HkH2iZon4i
 nBbAylG825hP7mMdblOzdKo92ZANC5NrDalFnhCYWqItHy5tGAKykrApcW2DNOFJGn/3iZNqZyV
 tpgbAQccQYl/q8Fu3ktf0+mCmZkyjL9u/7dkRgGXqSX+so/Jl3hvSDDrVv1157Ig939sIfopONs
 Rkx9I0Lo2i8d6t+YPCjDQXd5HTrUio3ebS6g==
X-Received: by 2002:a25:d041:0:b0:df7:8a41:3009 with SMTP id
 3f1490d57ef6-e02be297ccamr3566325276.6.1718836263170; 
 Wed, 19 Jun 2024 15:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOXJGwI9BE6J1QQigkV1mtskoejr1cHBXSg57t6LTJaWU8zPT9P2aLVNuM9zT8ACuPKjXRFQ==
X-Received: by 2002:a25:d041:0:b0:df7:8a41:3009 with SMTP id
 3f1490d57ef6-e02be297ccamr3566298276.6.1718836262429; 
 Wed, 19 Jun 2024 15:31:02 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:31:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 06/11] migration/docs: Update postcopy recover session for
 SETUP phase
Date: Wed, 19 Jun 2024 18:30:41 -0400
Message-ID: <20240619223046.1798968-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Firstly, the "Paused" state was added in the wrong place before. The state
machine section was describing PostcopyState, rather than MigrationStatus.
Drop the Paused state descriptions.

Then in the postcopy recover session, add more information on the state
machine for MigrationStatus in the lines.  Add the new RECOVER_SETUP phase.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/postcopy.rst | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index 6c51e96d79..a15594e11f 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -99,17 +99,6 @@ ADVISE->DISCARD->LISTEN->RUNNING->END
     (although it can't do the cleanup it would do as it
     finishes a normal migration).
 
- - Paused
-
-    Postcopy can run into a paused state (normally on both sides when
-    happens), where all threads will be temporarily halted mostly due to
-    network errors.  When reaching paused state, migration will make sure
-    the qemu binary on both sides maintain the data without corrupting
-    the VM.  To continue the migration, the admin needs to fix the
-    migration channel using the QMP command 'migrate-recover' on the
-    destination node, then resume the migration using QMP command 'migrate'
-    again on source node, with resume=true flag set.
-
  - End
 
     The listen thread can now quit, and perform the cleanup of migration
@@ -221,7 +210,8 @@ paused postcopy migration.
 
 The recovery phase normally contains a few steps:
 
-  - When network issue occurs, both QEMU will go into PAUSED state
+  - When network issue occurs, both QEMU will go into **POSTCOPY_PAUSED**
+    migration state.
 
   - When the network is recovered (or a new network is provided), the admin
     can setup the new channel for migration using QMP command
@@ -229,9 +219,20 @@ The recovery phase normally contains a few steps:
 
   - On source host, the admin can continue the interrupted postcopy
     migration using QMP command 'migrate' with resume=true flag set.
-
-  - After the connection is re-established, QEMU will continue the postcopy
-    migration on both sides.
+    Source QEMU will go into **POSTCOPY_RECOVER_SETUP** state trying to
+    re-establish the channels.
+
+  - When both sides of QEMU successfully reconnects using a new or fixed up
+    channel, they will go into **POSTCOPY_RECOVER** state, some handshake
+    procedure will be needed to properly synchronize the VM states between
+    the two QEMUs to continue the postcopy migration.  For example, there
+    can be pages sent right during the window when the network is
+    interrupted, then the handshake will guarantee pages lost in-flight
+    will be resent again.
+
+  - After a proper handshake synchronization, QEMU will continue the
+    postcopy migration on both sides and go back to **POSTCOPY_ACTIVE**
+    state.  Postcopy migration will continue.
 
 During a paused postcopy migration, the VM can logically still continue
 running, and it will not be impacted from any page access to pages that
-- 
2.45.0


