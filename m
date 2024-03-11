Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07D7C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnhR-0001HB-RD; Mon, 11 Mar 2024 18:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngp-0000nL-NN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngm-0004HD-Vu
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+7z8zapbeRNv2trHhs1cLEOfHBQW8nwm253n8XWXpE=;
 b=LR+vfOPVpsq7IkSJJ6Qy0Jh9J+lHjfxbLhLj003/gdw/IeF6btWjNCShWy4PcXcibcATBr
 SE1abMr7BdJBjrZC4ZaDcxyrR8VSu3Gy4ACN8NWClXkPQIngt0gCquVd2Ob5OdJcVoffSc
 Q4PKYJKAfqni2alnRHzgNFt0C1bn4VM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-qpUt04RPNc2iA3kFBkbKUg-1; Mon, 11 Mar 2024 18:00:05 -0400
X-MC-Unique: qpUt04RPNc2iA3kFBkbKUg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6818b8cb840so15028106d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194404; x=1710799204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+7z8zapbeRNv2trHhs1cLEOfHBQW8nwm253n8XWXpE=;
 b=wSkMfWdRtUIHaVK383shYpoanHdGV4olaKrR/WGGhDdoEVWyUitPluF9qrx5vaWspR
 i/hDQ65N1LXHdQF/hpjVO/KNGuBD82RyayYyNUVO+Q4xj1p96teva4P0uKU4r6qPal64
 /H1Z5rjpmP708mpo7a5gGUvgBekmHTZnJJsIvp1ez3P6RPx3b0Zt1m/ukByUh0/eBLB0
 VUs8EGZDzMQngeuBJPlcXUdTa/evATvvMnMgyOJGydk/5vyXunaZjcwfC7JDdvu26utR
 nttWMRsyecR4pJH44cPWpFjqtamtLB4t8+haNLUSzJ2Rse5q+zR53v6kmDoAu41abKO3
 nt9g==
X-Gm-Message-State: AOJu0Yx4+ldY4gJJgrx3PYnVz/S2ZqAxIPK+9sYTtDEBuBi0QXqPDMRb
 lCl8ktNMkmMIqtkYK1fv2AtAN/egVqbtKASydOGnboLz7k8TIiq/a63TNbRkotQ9O43fE3VXqf0
 3v5YWPDkyxXeUlmKLTRgLAQ0c0IjDJcrIzpZsmh6AVMbRxpDQfb7EBtFynndGwMOIxxtLECn+6s
 Y5FFpcyBrFgXFzI98hrcYcMgVV//AqHvqw5A==
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr407188qvc.4.1710194404578; 
 Mon, 11 Mar 2024 15:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1VfYyBAPHBu1KugNzJwJ+S3wiVaovQYm2Cfi6Y0taRC/52wi3infIRzm50ZphWSVjaAmb1A==
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr407156qvc.4.1710194404131; 
 Mon, 11 Mar 2024 15:00:04 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:03 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 25/34] migration: privatize colo interfaces
Date: Mon, 11 Mar 2024 17:59:16 -0400
Message-ID: <20240311215925.40618-26-peterx@redhat.com>
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

Remove private migration interfaces from net/colo-compare.c and push them
to migration/colo.c.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-10-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c   | 17 +++++++++++------
 net/colo-compare.c |  3 +--
 stubs/colo.c       |  1 -
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 315e31fe32..84632a603e 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -63,9 +63,9 @@ static bool colo_runstate_is_stopped(void)
     return runstate_check(RUN_STATE_COLO) || !runstate_is_running();
 }
 
-static void colo_checkpoint_notify(void *opaque)
+static void colo_checkpoint_notify(void)
 {
-    MigrationState *s = opaque;
+    MigrationState *s = migrate_get_current();
     int64_t next_notify_time;
 
     qemu_event_set(&s->colo_checkpoint_event);
@@ -74,10 +74,15 @@ static void colo_checkpoint_notify(void *opaque)
     timer_mod(s->colo_delay_timer, next_notify_time);
 }
 
+static void colo_checkpoint_notify_timer(void *opaque)
+{
+    colo_checkpoint_notify();
+}
+
 void colo_checkpoint_delay_set(void)
 {
     if (migration_in_colo_state()) {
-        colo_checkpoint_notify(migrate_get_current());
+        colo_checkpoint_notify();
     }
 }
 
@@ -162,7 +167,7 @@ static void primary_vm_do_failover(void)
      * kick COLO thread which might wait at
      * qemu_sem_wait(&s->colo_checkpoint_sem).
      */
-    colo_checkpoint_notify(s);
+    colo_checkpoint_notify();
 
     /*
      * Wake up COLO thread which may blocked in recv() or send(),
@@ -518,7 +523,7 @@ out:
 
 static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
 {
-    colo_checkpoint_notify(data);
+    colo_checkpoint_notify();
 }
 
 static void colo_process_checkpoint(MigrationState *s)
@@ -642,7 +647,7 @@ void migrate_start_colo_process(MigrationState *s)
     bql_unlock();
     qemu_event_init(&s->colo_checkpoint_event, false);
     s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
-                                colo_checkpoint_notify, s);
+                                colo_checkpoint_notify_timer, NULL);
 
     qemu_sem_init(&s->colo_exit_sem, 0);
     colo_process_checkpoint(s);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index f2dfc0ebdc..c4ad0ab71f 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -28,7 +28,6 @@
 #include "sysemu/iothread.h"
 #include "net/colo-compare.h"
 #include "migration/colo.h"
-#include "migration/migration.h"
 #include "util.h"
 
 #include "block/aio-wait.h"
@@ -189,7 +188,7 @@ static void colo_compare_inconsistency_notify(CompareState *s)
         notify_remote_frame(s);
     } else {
         notifier_list_notify(&colo_compare_notifiers,
-                             migrate_get_current());
+                             NULL);
     }
 }
 
diff --git a/stubs/colo.c b/stubs/colo.c
index 08c9f982d5..f8c069b739 100644
--- a/stubs/colo.c
+++ b/stubs/colo.c
@@ -2,7 +2,6 @@
 #include "qemu/notify.h"
 #include "net/colo-compare.h"
 #include "migration/colo.h"
-#include "migration/migration.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-migration.h"
 
-- 
2.44.0


