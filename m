Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695E2E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7O-0004M8-0n; Fri, 06 Dec 2024 17:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7N-0004Lz-B7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7L-0002Q7-PK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8l4cpJdky+6VCEyXhHeGMSpMlUpTsGKiYvdnk77GRc=;
 b=dnfH0tabqFfdeYv5J3Uy6xCMO5RSXjom4iBgLYDEtsWQE0npPxYDvL5JvPt4qJlX5/vkyC
 L54INUk1V7q2mOYSHVGVp+JvkOBLHPeNN2JIVFZVmHLulbAWGGKABAkjaIbQopkGdbAexB
 dIjLBb0VlGdjq7FuYfusjxr7FZmIi+U=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-eIeK3V8aPKCqppoZvraFLw-1; Fri, 06 Dec 2024 17:48:10 -0500
X-MC-Unique: eIeK3V8aPKCqppoZvraFLw-1
X-Mimecast-MFC-AGG-ID: eIeK3V8aPKCqppoZvraFLw
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-841a54a6603so443897839f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525287; x=1734130087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8l4cpJdky+6VCEyXhHeGMSpMlUpTsGKiYvdnk77GRc=;
 b=wbVgKd+rh/rm7zFnib7zPm1aYqJ2mtA9HRjNOrJOTQeXRRlz6xfGZCG2zqaappguG1
 fNiCm8NMzRjmxOcPHOlSmCkXdZ88n69f6F+88AdWii+ehzGYDnTEjL88JTKmm8cFIUOy
 4VZItpEoWIr/IhLHAorSzTcHdDqORAlNaXj7H7aOHVbfwnlBP0GOOypW8vbwp9YMoIRE
 1JYRAY1+7NtohBG2aj4lxUUIolR5rYJBn5OlkUlKT42itRYBodS6aRoCND8QFt5ZOKuZ
 b+B82I7pJd6X23lvfQgidlxfoP6mRh6pfeBybOAz1mXQjgCnO1Vak7fP7Wz2e4WKZoN5
 XoOQ==
X-Gm-Message-State: AOJu0YySNV0Q2EArrEV7uDKJI++fR3weEDt771RglJpNDaHOa03J2Bnp
 96AcYNVVZrKnbfWsgSZQDKIyUyFr73msXiCYkxYkJVRS+anVzs7ufgRK/XFcd9u+q04z6I3aVI2
 cxt77wRJllPmTmspgUDGLox/fXWP8/vb1INYul3mV9iUKSnLZQs4ukBkgYqoLo//Z3YC9LgAutv
 7XC2lTnQGT3u0FIwDo1bG4ZqPyr8ZdwRCyzA==
X-Gm-Gg: ASbGncspo2jZ/9MxNuOBM68RQUkHcEaCdlaRkMrSGBS8bDpPhdO8dJe/U50we7MiZqT
 KqCd6Nxtl660n+tSqBDltIEYmaDCl9hoDOAqo1l1kdWe7f+j24v+iVtpZMR2wPwjjC5gaz+fdw0
 zLPSNqQDTubbRdX39w4doLzas3hT++swzqgHUVsnqzWSInt4bf3m2Im+gUsorMYzs5LK0pVkSUl
 gx68rTN6IqmjmDgeaypwlfAScFDmonGpMEgDTtieKhTpSkWr0fNo8IT+M9ScpdypxZMjc9SO+CB
 FTF6syvATYOXAUHfILYd3dZ9eg==
X-Received: by 2002:a05:6602:2c06:b0:841:950b:386d with SMTP id
 ca18e2360f4ac-8447e202016mr733309739f.3.1733525287437; 
 Fri, 06 Dec 2024 14:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmF9yRhri8h5+sffg2R5gMhZMQbNVM/Nt4jbRYRF4D2dxEKR9J5DT91XtJIR6Z2Ohr2IN8GQ==
X-Received: by 2002:a05:6602:2c06:b0:841:950b:386d with SMTP id
 ca18e2360f4ac-8447e202016mr733307239f.3.1733525287123; 
 Fri, 06 Dec 2024 14:48:07 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:48:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 4/7] migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH
 messages
Date: Fri,  6 Dec 2024 17:47:52 -0500
Message-ID: <20241206224755.1108686-5-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

RAM_SAVE_FLAG_MULTIFD_FLUSH message should always be correlated to a sync
request on src.  Unify such message into one place, and conditionally send
the message only if necessary.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h        |  2 +-
 migration/multifd-nocomp.c | 27 +++++++++++++++++++++++++--
 migration/ram.c            | 18 ++++--------------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 6493512305..0fef431f6b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -354,7 +354,7 @@ static inline uint32_t multifd_ram_page_count(void)
 
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
-int multifd_ram_flush_and_sync(void);
+int multifd_ram_flush_and_sync(QEMUFile *f);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 219f9e58ef..58372db0f4 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -20,6 +20,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#include "qemu-file.h"
 
 static MultiFDSendData *multifd_ram_send;
 
@@ -343,9 +344,10 @@ retry:
     return true;
 }
 
-int multifd_ram_flush_and_sync(void)
+int multifd_ram_flush_and_sync(QEMUFile *f)
 {
     MultiFDSyncReq req;
+    int ret;
 
     if (!migrate_multifd()) {
         return 0;
@@ -361,7 +363,28 @@ int multifd_ram_flush_and_sync(void)
     /* File migrations only need to sync with threads */
     req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
 
-    return multifd_send_sync_main(req);
+    ret = multifd_send_sync_main(req);
+    if (ret) {
+        return ret;
+    }
+
+    /* If we don't need to sync with remote at all, nothing else to do */
+    if (req == MULTIFD_SYNC_LOCAL) {
+        return 0;
+    }
+
+    /*
+     * Old QEMUs don't understand RAM_SAVE_FLAG_MULTIFD_FLUSH, it relies
+     * on RAM_SAVE_FLAG_EOS instead.
+     */
+    if (migrate_multifd_flush_after_each_section()) {
+        return 0;
+    }
+
+    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+    qemu_fflush(f);
+
+    return 0;
 }
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
diff --git a/migration/ram.c b/migration/ram.c
index 44010ff325..90811aabd4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1306,15 +1306,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                 (!migrate_multifd_flush_after_each_section() ||
                  migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_ram_flush_and_sync();
+                int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
                     return ret;
                 }
-
-                if (!migrate_mapped_ram()) {
-                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-                    qemu_fflush(f);
-                }
             }
 
             /* Hit the end of the list */
@@ -3044,18 +3039,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     bql_unlock();
-    ret = multifd_ram_flush_and_sync();
+    ret = multifd_ram_flush_and_sync(f);
     bql_lock();
     if (ret < 0) {
         error_setg(errp, "%s: multifd synchronization failed", __func__);
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
-        && !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
-
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ret = qemu_fflush(f);
     if (ret < 0) {
@@ -3190,7 +3180,7 @@ out:
     if (ret >= 0 && migration_is_running()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
-            ret = multifd_ram_flush_and_sync();
+            ret = multifd_ram_flush_and_sync(f);
             if (ret < 0) {
                 return ret;
             }
@@ -3268,7 +3258,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
          * Only the old dest QEMU will need this sync, because each EOS
          * will require one SYNC message on each channel.
          */
-        ret = multifd_ram_flush_and_sync();
+        ret = multifd_ram_flush_and_sync(f);
         if (ret < 0) {
             return ret;
         }
-- 
2.47.0


