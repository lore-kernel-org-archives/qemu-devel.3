Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D75C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjniZ-0003cW-AY; Mon, 11 Mar 2024 18:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngo-0000ia-8H
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngm-0004Gx-4I
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iq0LE+iqlQL+6JCbSe4i1yV9MLceNgsbOkUlbT+WpVE=;
 b=X+rlK0T5fdj1/TNjKQPsFeftmlEIOGyXldcUff038MIMT1Ot/7LW6UmryatatUSBU+XZO7
 /2ZBRdskv/SIHubuwUl/sjf81B+3Vyi0XT2rO+MhBC/SSWanoIYsVRU1t6lE+3AXeMXIIb
 rNLy1VUY9LkhrI3wDgYJ41mo2OtoCpg=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-2j1ARF9UPeCqDYlVtmAGLQ-1; Mon, 11 Mar 2024 18:00:05 -0400
X-MC-Unique: 2j1ARF9UPeCqDYlVtmAGLQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7dbbeb665a4so296896241.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194404; x=1710799204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iq0LE+iqlQL+6JCbSe4i1yV9MLceNgsbOkUlbT+WpVE=;
 b=bIaOkAIXUBthOw2eKI33nbkK2pNA1I/ElI9lMrxyrKFPIOMlzBqPSUlil+yLa2fkKr
 UGrddwYAuOnl4cCyudo4rRkOg//6dc95TCUNOQspcjlPFa+pOxqamD6JnT4jlXjKZZ5o
 55vumzdezWYaPz/UqBvRDqGl9HdJqcp6+dVj/J+BFIMNzU3jnGo0zcLOUlAFnkbW6pwr
 nOdsVA7HiNV8eQ5iD7u9BOBHn8r+rr5EiDtCqCZYwxbzAZ15dRqFsZgLHWQjQHtY47H8
 SQf238OpB3/zst2q9few6EdniSJcb1g6aVecCn13yLWeaNJySuabUIeZQpU6qTnpmlrA
 eMbQ==
X-Gm-Message-State: AOJu0Yw7Z8xU7zQ2C8TlMm4L6upFc4emWbBmF4qI26gTDCn4c/DbsApV
 g/6oO5y07WKp4SK4HgVWf1XKOgfAn5emIDCIYqlEE/l+MNclnXQWbbLhBbDtY8Nsb0hMmNc3gIm
 C7txSrtGq8DjAgD2yQnbXsXewhD9U9qJYd188NwLpYS1TtUGguPE5HKBH1V3F/fL9vyIWbG3cLf
 lScFmtONHO82aKE3tBZqQpuyunk+rMiPuE0Q==
X-Received: by 2002:a67:fada:0:b0:472:e0f6:f3c1 with SMTP id
 g26-20020a67fada000000b00472e0f6f3c1mr4275458vsq.2.1710194403310; 
 Mon, 11 Mar 2024 15:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0BAcimaAKH4NWH2PuxSa5oqdyY2y8p0uaKaz/ivqNI+H/8ZklqroVjXreqa6Xb5iZ3uE6Uw==
X-Received: by 2002:a67:fada:0:b0:472:e0f6:f3c1 with SMTP id
 g26-20020a67fada000000b00472e0f6f3c1mr4275431vsq.2.1710194402865; 
 Mon, 11 Mar 2024 15:00:02 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:02 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 24/34] migration: migration_file_set_error
Date: Mon, 11 Mar 2024 17:59:15 -0400
Message-ID: <20240311215925.40618-25-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

From: Steve Sistare <steven.sistare@oracle.com>

Define and export migration_file_set_error to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-9-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  2 ++
 hw/vfio/common.c         |  9 +--------
 hw/vfio/migration.c      | 11 +++--------
 migration/migration.c    | 11 +++++++++++
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 28cfaed2c7..e521cd5229 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -109,6 +109,8 @@ bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 bool migration_is_running(void);
+void migration_file_set_error(int err);
+
 /* ...and after the device transmission */
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index de010680ff..b44204eade 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -39,7 +39,6 @@
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "migration/migration.h"
 #include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
@@ -150,14 +149,8 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
 
 static void vfio_set_migration_error(int err)
 {
-    MigrationState *ms = migrate_get_current();
-
     if (migration_is_setup_or_active()) {
-        WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-            if (ms->to_dst_file) {
-                qemu_file_set_error(ms->to_dst_file, err);
-            }
-        }
+        migration_file_set_error(err);
     }
 }
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 49c0016add..a15fd486c6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -17,13 +17,12 @@
 
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "migration/blocker.h"
-#include "migration/misc.h"
 #include "qapi/error.h"
 #include "exec/ramlist.h"
 #include "exec/ram_addr.h"
@@ -714,9 +713,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
-        }
+        migration_file_set_error(ret);
     }
 
     trace_vfio_vmstate_change_prepare(vbasedev->name, running,
@@ -746,9 +743,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
-        }
+        migration_file_set_error(ret);
     }
 
     trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
diff --git a/migration/migration.c b/migration/migration.c
index db1e627848..216f63d62b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3038,6 +3038,17 @@ static MigThrError postcopy_pause(MigrationState *s)
     }
 }
 
+void migration_file_set_error(int err)
+{
+    MigrationState *s = current_migration;
+
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->to_dst_file) {
+            qemu_file_set_error(s->to_dst_file, err);
+        }
+    }
+}
+
 static MigThrError migration_detect_error(MigrationState *s)
 {
     int ret;
-- 
2.44.0


