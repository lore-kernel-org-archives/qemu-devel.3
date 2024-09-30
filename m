Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACCECDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYW-0004gc-8v; Mon, 30 Sep 2024 15:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXw-000436-2t
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMXm-0003xU-QZ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AsdoBAm4/H/7Jy2H83poWUQ7xQPm3c8gUhD4CXkcCgo=;
 b=ancHlzBpOK4eCIoVymHJQpizwEoFMWUVxMQIae5pnLCoH2d+R++cyloHMerph69YiOKgIC
 IFcpbNknZfclasbQ+rMbn4ms0mG0wfRfZC8KkzakMgH52LmukAFZiGy4Mo6JvUuM7fY9VS
 vr0F9WMfA2DbBHZ7WkKkOI5xBaHevY8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-NO7T5VowO7KvxgBRt3ktfQ-1; Mon, 30 Sep 2024 15:58:49 -0400
X-MC-Unique: NO7T5VowO7KvxgBRt3ktfQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-458260b3dccso96613651cf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726324; x=1728331124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsdoBAm4/H/7Jy2H83poWUQ7xQPm3c8gUhD4CXkcCgo=;
 b=nXwYT//p1Pde4zs8R0S+qNydMlPkvbug605CfDMtrmnwhD6mfdKSSLWI41tV7Irh2J
 5jc/Bt3wHSFpMsU4nm91pGbWZSr5ZHWBWPMncMfiqn0naxqcx2kJAP4dEqfxSSNp5lll
 K9YstgsLqa/lwzyS+vUxBTQ8XFgPZwGzUasI64ah/4ymmNVbi2tAIdahNChSOwRXRGXE
 9eKaIWjX1QRGDu3lahayOeBmYO+aWF/k8rOBxU3qGCSjeAn+xTZrfUWDZyutt+M9UPaF
 SfJgyO/4rZXzP2qBAETjedb2URvA2rZHWlBJFu9vRnKMOZmgNmmTkj0yI4kODQIVfKs8
 F3EA==
X-Gm-Message-State: AOJu0YyTzLMIkg51ml5v2nFUaDgiiWKaui6C0ua11HurVmx//TuykoVG
 J/0a/5CIoazVr9PCDrM3QQhZY5ZEG/JYdn83XJ6WTAnoUYc0JzyesGBA4r88QMbEncs5TGxH0PR
 fifwln9EXLV+rEum15B8NZf52MuBJ9gXT9JWqAl+ArGWKQZ9JUsMxMYB7llT74FCoVfXbM9nwy4
 r4YcrDZbMDOZBvroI0q/Al5axMvcqxE5IRQA==
X-Received: by 2002:a05:622a:d1:b0:458:34df:1e6a with SMTP id
 d75a77b69052e-45c9f292b5bmr212843431cf.48.1727726324003; 
 Mon, 30 Sep 2024 12:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGTck3+ESskPrGJHCUxQNvDlQUXbp+UL5AXiNPooCEFu2ayCsK4lii6fSwoOVPAExbiEAsxg==
X-Received: by 2002:a05:622a:d1:b0:458:34df:1e6a with SMTP id
 d75a77b69052e-45c9f292b5bmr212843141cf.48.1727726323572; 
 Mon, 30 Sep 2024 12:58:43 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:58:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 1/7] migration: Unify names of migration src main thread
Date: Mon, 30 Sep 2024 15:58:31 -0400
Message-ID: <20240930195837.825728-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240930195837.825728-1-peterx@redhat.com>
References: <20240930195837.825728-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make pthread name match with what we report in query-migrationthreads.

We used to report the same, but not anymore after 60ce47675d ("migration:
Rename thread debug names").  Not a huge deal but it was still good to
follow.

Multifd threads are still matched because at least on the src the QMP
facility reused p->name.  The QMP command missed dest multifd threads
though, but that's another thing to address later.

Not copy stable, as we'd better keep the names not changed for stable
branches in QMP responses (even though we shouldn't guarantee ABI stability
on the names anyway).

Cc: Juraj Marcin <jmarcin@redhat.com>
Reported-by: Prasad Pandit <ppandit@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 2 ++
 migration/migration.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 38aa1402d5..519455796d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -28,6 +28,8 @@
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
 
+#define  MIGRATION_THREAD_SRC_MAIN  "mig/src/main"
+
 struct PostcopyBlocktimeContext;
 
 #define  MIGRATION_RESUME_ACK_VALUE  (1)
diff --git a/migration/migration.c b/migration/migration.c
index ae2be31557..505b62c8f3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3467,7 +3467,8 @@ static void *migration_thread(void *opaque)
     Error *local_err = NULL;
     int ret;
 
-    thread = migration_threads_add("live_migration", qemu_get_thread_id());
+    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN,
+                                   qemu_get_thread_id());
 
     rcu_register_thread();
 
@@ -3820,7 +3821,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         qemu_thread_create(&s->thread, "mig/snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
     } else {
-        qemu_thread_create(&s->thread, "mig/src/main",
+        qemu_thread_create(&s->thread, MIGRATION_THREAD_SRC_MAIN,
                 migration_thread, s, QEMU_THREAD_JOINABLE);
     }
     s->migration_thread_running = true;
-- 
2.45.0


