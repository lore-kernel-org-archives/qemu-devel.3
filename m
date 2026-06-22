Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6C9CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZDJ-0004wB-2g; Mon, 22 Jun 2026 03:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wbZDF-0004vc-Oe
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:36:58 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wbZDE-0000qP-6m
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:36:57 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c0c41ff84a6so250939766b.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782113814; x=1782718614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=saIQ4DchUtqXUcglD5meLYr7HCQgbtL46j6H8F1dSwU=;
 b=CtFKCE0Yk1fQefoRDPyeyBRHymE2/dDzrMk7Xp9wGSooU5ScczusqGBAbzPWz2IWlE
 0k3Mcyl8VvZ3z4jZNwOA6MuvwBHOXRAx5E8L8YJ3aW9jJ5KWnQ/G907xsKpzyaV6HBVo
 2HibIqZ1HGy0CMoEs2gyq9ZrD4VvNsfkh+dTYgDyFkCLWzsTjrULEosV4OTVBtD7xQ8o
 X3L6bJNzxN6a7b63qzgjPi59RZrcwVuOzxPh1ZPK4ZA5yaXaTOxZM8E/0W3nW26XfaNh
 jUixhzDiPPOSgtPjb7wjtky5gPyiU3Wkv4PTKRx3lJp4A/jVfaJy6Nj2njvBfiZrfHtO
 DQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782113814; x=1782718614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saIQ4DchUtqXUcglD5meLYr7HCQgbtL46j6H8F1dSwU=;
 b=cSuM5FdDWIds0y/1T9JYdwjY7PqynGesfbvf6P6wzeD8JPxBsnkQASx/8M0JsEQUt4
 udlagt38OPQiR/yFpLdXoItHXB1FjUOzbI8eKXBIk0xE2wSD1AREb3luxWqUnn53Dfz7
 Z29+SEovAZBmS3qX1p7vUHkUtyr8zz55KoRVhk6pYE2Ny0uswxBg2n3bNEgdWmwMBmZL
 E2mMJB40fojrrIIm4MZAUnwrVuqNuJ1uCSU+YQOVQ84Rarw9VcSjdaAnullBiv/3H58z
 T+97eUDiiDPhetKYQkPneN2ZwsxAyaD/wIMX4H2TSmMV0UG2htcBDSWNwIKyQWhkfLhz
 IDNQ==
X-Gm-Message-State: AOJu0YxmMCQnhxO6dWox6hqfsx0q/aBUaNuQR6T6kTlEUtsNbBrfdrtH
 +D9P3YUvrCM8b4HTaXtp6qofYqsX2LRAm5fQy5sWx40fR0TT/qxwNOCDRgrVeg==
X-Gm-Gg: AfdE7cmaOWViKxaN9MvmtjnT5DFnvvDkDVfcpUlUMwpCwV1JvY1NW0lA5LmHeQdzkqR
 YdnDMN0J9sQaugb+qvU83qALqA+AHGmQBCTaL/dEOBvRvSLS2EpuGOQLCrru08KUq8H/EL37HEc
 eH/znyBniQR/rx2kWFFwNu2+5tewsfW+PCpcuLzDryk6NzhxYP8TYagenYcknIe9/D0YXr7V6K0
 pxmxYklNiwsH1Zxi6tUbVMaFdJStRWVGA7o6W8dmsgN9SmnVZhYFYqdIrAOSYF6ICMCKzeTbLLz
 pjSRX9FtwFjn0cUzgzfLTR48B65duYzge033UU2SUeOK2+DrjpbvhxMVg1oXMZy85/luP45JVX+
 6UovypCoMiWSr6y9lMj0PbcB1DQrpQgDeREl+Jz09V7HyiqJUAlhERcC8tRReFDX1J8yL+EN17R
 64ohvfrji1WYQ39dBL
X-Received: by 2002:a17:907:3e0b:b0:c06:c347:e7c7 with SMTP id
 a640c23a62f3a-c097ade1ea5mr638813466b.12.1782113813914; 
 Mon, 22 Jun 2026 00:36:53 -0700 (PDT)
Received: from machine.. ([37.113.214.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c5e99977fsm305347866b.20.2026.06.22.00.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 00:36:53 -0700 (PDT)
From: Evgeny Kolmakov <randomjack94dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, berrange@redhat.com,
 Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PATCH] util/filemonitor-inotify: Use QEMU_LOCK_GUARD()
Date: Mon, 22 Jun 2026 10:36:47 +0300
Message-ID: <20260622073647.3721-1-randomjack94dev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=randomjack94dev@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace manual qemu_mutex_(un)lock() calls with
QEMU_LOCK_GUARD() to remove 'goto cleanup' code

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
---
 util/filemonitor-inotify.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 7352b9fe53..fe2057f820 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/filemonitor.h"
 #include "qemu/main-loop.h"
+#include "qemu/lockable.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
@@ -59,10 +60,9 @@ static void qemu_file_monitor_watch(void *arg)
     int used = 0;
     int len;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
 
     if (mon->fd == -1) {
-        qemu_mutex_unlock(&mon->lock);
         return;
     }
 
@@ -72,11 +72,10 @@ static void qemu_file_monitor_watch(void *arg)
         if (errno != EAGAIN) {
             error_report("Failure monitoring inotify FD '%s',"
                          "disabling events", strerror(errno));
-            goto cleanup;
         }
 
         /* no more events right now */
-        goto cleanup;
+        return;
     }
 
     /* Loop over all events in the buffer */
@@ -151,9 +150,6 @@ static void qemu_file_monitor_watch(void *arg)
             }
         }
     }
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
 }
 
 
@@ -257,9 +253,8 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
 {
     QFileMonitorDir *dir;
     QFileMonitorWatch watch;
-    int64_t ret = -1;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
     dir = g_hash_table_lookup(mon->dirs, dirpath);
     if (!dir) {
         int rv = inotify_add_watch(mon->fd, dirpath,
@@ -268,7 +263,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
 
         if (rv < 0) {
             error_setg_errno(errp, errno, "Unable to watch '%s'", dirpath);
-            goto cleanup;
+            return -1;
         }
 
         trace_qemu_file_monitor_enable_watch(mon, dirpath, rv);
@@ -297,11 +292,7 @@ qemu_file_monitor_add_watch(QFileMonitor *mon,
                                       filename ? filename : "<none>",
                                       cb, opaque, watch.id);
 
-    ret = watch.id;
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
-    return ret;
+    return watch.id;
 }
 
 
@@ -312,13 +303,13 @@ void qemu_file_monitor_remove_watch(QFileMonitor *mon,
     QFileMonitorDir *dir;
     gsize i;
 
-    qemu_mutex_lock(&mon->lock);
+    QEMU_LOCK_GUARD(&mon->lock);
 
     trace_qemu_file_monitor_remove_watch(mon, dirpath, id);
 
     dir = g_hash_table_lookup(mon->dirs, dirpath);
     if (!dir) {
-        goto cleanup;
+        return;
     }
 
     for (i = 0; i < dir->watches->len; i++) {
@@ -342,7 +333,4 @@ void qemu_file_monitor_remove_watch(QFileMonitor *mon,
             qemu_set_fd_handler(mon->fd, NULL, NULL, NULL);
         }
     }
-
- cleanup:
-    qemu_mutex_unlock(&mon->lock);
 }
-- 
2.43.0


