Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D6ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 20:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1sOX-0002gP-9s; Thu, 25 Sep 2025 16:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1sO8-0002Y7-Mt
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 16:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1sO0-00064h-9Y
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 16:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758831366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0NZWcxr2QhIo68KFqDly9zHtTMtop+9FSb8bMswxvic=;
 b=VS0r5Xs42sMPToq7wliT+cUG+cgojlUQI1VIN6D6Hi5A2x0q2NTTPXnRA/IF9seat8x7ca
 mwseIGT63Umzfc0otnWtvEN1SJZwJ867TOmkLn6NFFB33bZr0FAlfAdH9PnJH8GnCy/qAT
 u+jyTOC/0KgPO+G6auNFekgDv+0+9kc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-8SnZyTGuMQ-p-gFJOtQ-gQ-1; Thu, 25 Sep 2025 16:16:05 -0400
X-MC-Unique: 8SnZyTGuMQ-p-gFJOtQ-gQ-1
X-Mimecast-MFC-AGG-ID: 8SnZyTGuMQ-p-gFJOtQ-gQ_1758831365
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b5ee6cd9a3so33008291cf.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 13:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758831364; x=1759436164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0NZWcxr2QhIo68KFqDly9zHtTMtop+9FSb8bMswxvic=;
 b=Liy2pmtiScxQGj6hyubGbrGhhC6AoZ+ROqfI3ZK0AS/HKqv5/Wz/o/RRmuPM7bAU68
 OCTQ93sTlYYNFNjKC4u2F2VG9nPmBJBPKhCdRtTmAL+34gv3bcUaXl38ZIggpEZ8Ef7K
 wEAn9lQ75DHkvGB4SDV2FpSxBO0tdRzGY83ji0/GSyJSCmgrNEUx9FemOwlqNK76JD37
 WtJ53+uWFaE7iJs5skIffsbbXIxZaPNJ4IS+eRbYrwTO8KeLmcj0EAlgnPC7ZS6e/Qx3
 8WoJhSkP75S6tTS9XfwsqMnTeA5QrsAiwxYexupTDHXOyxARHzp2qRjVHRYfQbihbz1L
 ik9Q==
X-Gm-Message-State: AOJu0YzfgzBwymhe3sPQMGuZIwhewT0usHUSOu+lulOwrt6qHCB5w4QH
 OU3wcu1Yi4lKmS2JNiyPPIhIXUHPbLmAuvVpLN/gyVAqSydwbNDdTcMivE1/VLM1ucMbbEc3PCX
 7qqQuG7Up4K8sSlkBvyGDDWU8ahLNmsJsbV9mPsIZ/bzcl3c5NsKSruX9BVM489K5VVWk8/pMAA
 prYrs8lGb0hyc7aLXQgNqCJZ3J1PaEl6Atw/1AQw==
X-Gm-Gg: ASbGncuC3mdeRA/RelQWioDka33Es5Ck5ArWAG74NNPVK8QNrkcuwf8Gf9p3SzEyQND
 8MN1Yk0qXkG3axdVdOzUuwMLAtCWSvxMHhPS5FUeREQ/hDchXkPKBPylT/JLXSvPl5uxQr/w4d7
 2/7gkTez4OPI2qLoScb4biA+/ixr2gJp7Vk1bgeOhxB5PdWc0kKjwcGIiMlh5TfC9lJDT76fp4J
 xyb7pMxBUZRA+TyWttYK5aqKJDBMZ7mVT5S1w9W84XJGO2GM5Wh9YWHK9xUNLIOxTaWxMSyh57A
 qzOO4CmWnJqfwDlGmTAK8Fu9AjGQ3Q==
X-Received: by 2002:a05:622a:a06:b0:4b5:f6c5:cfc with SMTP id
 d75a77b69052e-4da484c185bmr66938741cf.19.1758831364128; 
 Thu, 25 Sep 2025 13:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF374wMCl/ONp7q+x8uH/G2zVOeU7okz9ugsfgrqZ9+xOYq92DpCfZPhqHXXXwOJ2Q+ngjhuw==
X-Received: by 2002:a05:622a:a06:b0:4b5:f6c5:cfc with SMTP id
 d75a77b69052e-4da484c185bmr66938221cf.19.1758831363570; 
 Thu, 25 Sep 2025 13:16:03 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db11cd52e5sm15708131cf.47.2025.09.25.13.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:16:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] migration/multifd/tls: Cleanup BYE message processing on
 sender side
Date: Thu, 25 Sep 2025 16:16:01 -0400
Message-ID: <20250925201601.290546-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch is a trivial cleanup to the BYE messages on the multifd sender
side.  It could also be a fix, but since we do not have a solid clue,
taking this as a cleanup only.

One trivial concern is, migration_tls_channel_end() might be unsafe to be
invoked in the migration thread if migration is not successful, because
when failed / cancelled we do not know whether the multifd sender threads
can be writting to the channels, while GnuTLS library (when it's a TLS
channel) logically doesn't support concurrent writes.

When at it, cleanup on a few things.  What changed:

  - Introduce a helper to do graceful shutdowns with rich comment, hiding
    the details

  - Only send bye() iff migration succeeded, skip if it failed / cancelled

  - Detect TLS channel using channel type rather than thread created flags

  - Move the loop into the existing one that will close the channels, but
    do graceful shutdowns before channel shutdowns

  - local_err seems to have been leaked if set, fix it along the way

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 65 ++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b255778855..98873cee74 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -439,6 +439,39 @@ static void multifd_send_set_error(Error *err)
     }
 }
 
+/*
+ * Gracefully shutdown IOChannels. Only needed for successful migrations on
+ * top of TLS channels.  Otherwise it is same to qio_channel_shutdown().
+ *
+ * A successful migration also guarantees multifd sender threads are
+ * properly flushed and halted.  It is only safe to send BYE in the
+ * migration thread here when we know there's no other thread writting to
+ * the channel, because GnuTLS doesn't support concurrent writers.
+ */
+static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
+{
+    g_autoptr(Error) local_err = NULL;
+
+    if (!migration_has_failed(migrate_get_current()) &&
+        object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
+
+        /*
+         * The destination expects the TLS session to always be properly
+         * terminated. This helps to detect a premature termination in the
+         * middle of the stream.  Note that older QEMUs always break the
+         * connection on the source and the destination always sees
+         * GNUTLS_E_PREMATURE_TERMINATION.
+         */
+        migration_tls_channel_end(ioc, &local_err);
+        if (local_err) {
+            warn_report("Failed to gracefully terminate TLS connection: %s",
+                        error_get_pretty(local_err));
+        }
+    }
+
+    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+}
+
 static void multifd_send_terminate_threads(void)
 {
     int i;
@@ -460,7 +493,7 @@ static void multifd_send_terminate_threads(void)
 
         qemu_sem_post(&p->sem);
         if (p->c) {
-            qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+            migration_ioc_shutdown_gracefully(p->c);
         }
     }
 
@@ -547,36 +580,6 @@ void multifd_send_shutdown(void)
         return;
     }
 
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p = &multifd_send_state->params[i];
-
-        /* thread_created implies the TLS handshake has succeeded */
-        if (p->tls_thread_created && p->thread_created) {
-            Error *local_err = NULL;
-            /*
-             * The destination expects the TLS session to always be
-             * properly terminated. This helps to detect a premature
-             * termination in the middle of the stream.  Note that
-             * older QEMUs always break the connection on the source
-             * and the destination always sees
-             * GNUTLS_E_PREMATURE_TERMINATION.
-             */
-            migration_tls_channel_end(p->c, &local_err);
-
-            /*
-             * The above can return an error in case the migration has
-             * already failed. If the migration succeeded, errors are
-             * not expected but there's no need to kill the source.
-             */
-            if (local_err && !migration_has_failed(migrate_get_current())) {
-                warn_report(
-                    "multifd_send_%d: Failed to terminate TLS connection: %s",
-                    p->id, error_get_pretty(local_err));
-                break;
-            }
-        }
-    }
-
     multifd_send_terminate_threads();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
-- 
2.50.1


