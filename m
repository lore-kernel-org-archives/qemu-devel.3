Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E694DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGtg-0000Ha-JJ; Mon, 17 Jun 2024 14:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGta-0000Dw-RG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtX-0006Ir-La
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEHrtQENt0LFtN0vcvE5nOEIasmLrG79F51JvU/6ieg=;
 b=bmkuCIRWL2qTVG+zPosi944rk4GWkuW0SuIOp7mQhqDJW127a2qw6C3SIL7Xp3OODW7cRX
 dfgrWHXd4enEJUnESTdzQ5QAsD1UyK/jxeCCY52/RmavKu3S/apnlL04A4tliDnHntv9uj
 WYq40jT+QddolKNwGgQwXvdw0ZQ4Faw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-WKtl73LcNF6pTtNzhaRqaw-1; Mon, 17 Jun 2024 14:15:50 -0400
X-MC-Unique: WKtl73LcNF6pTtNzhaRqaw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b07a472e83so3991916d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648149; x=1719252949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEHrtQENt0LFtN0vcvE5nOEIasmLrG79F51JvU/6ieg=;
 b=s4GMdVi+wEiEjcyx+IFg5JBkmylryZkN7JAKmrhxROj28ZlksoXstCHukNE6AdzUs5
 aZXdXzLGFHRJNwVFZ0Vn7FrgEsFAL445wWAXES+i+/4nKG3Xcnd8dM5IeR8FlP4qkGYV
 3I3sUzkKO6vvlTFUPbWEMEUrnyQYQo5KmLjiBwSQjcZgkn6CrFujB6PJfBi0E8FGVsbq
 xkGlPXD5XPCpM8cn+zsYAu8hoNzAPnPAn6vq5FrPVET0nnoP7uXL6jcxESH53M7c/mTF
 a44q9PgW/ZAfAjk9SUnWNTkL+ftgTIfMdY1F004ZP+Xc5vNbrzhDE+0jnTenxcfcEURM
 PZTA==
X-Gm-Message-State: AOJu0YzyV6FywRrNa6q576Bw0cyZ9P7bFF4shKeGFqh4duw3Yxi8L+1U
 E/qOt8JDvrQB1LNZj7Y6UU4/IQFf/8uHzVrm2vINpfGIn74LbZgvSRFJq7oaQlaFgozjeG+R2+i
 5TX1UjcKjEb+MIRR5GOVMCRbGciTs7oDII/jHgH2zyw4w70iMfeV3hzUbYeNwuMVC0Cs+AbaNNq
 +5iz20R6jwNCVNM9DVCMQEwJMHOBhnVvop7A==
X-Received: by 2002:a05:620a:4893:b0:797:74ba:8b8 with SMTP id
 af79cd13be357-798d23e0698mr1366899485a.2.1718648148811; 
 Mon, 17 Jun 2024 11:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFasbENddxnm/6ekdse/p/TgRpfH51FOrKDEuAZV6APu5bsFDqKlxS7FDarb4wTo0k8DjXoQ==
X-Received: by 2002:a05:620a:4893:b0:797:74ba:8b8 with SMTP id
 af79cd13be357-798d23e0698mr1366894685a.2.1718648147973; 
 Mon, 17 Jun 2024 11:15:47 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 06/10] migration/docs: Update postcopy recover session for
 SETUP phase
Date: Mon, 17 Jun 2024 14:15:30 -0400
Message-ID: <20240617181534.1425179-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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


