Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F578CF395D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 16:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srK3T-0004g9-Rf; Thu, 19 Sep 2024 12:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srK3R-0004Xr-RV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srK3Q-0000FJ-AN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726763451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sJuqsr58LBB69SsuxZGkJ5RDmjH6Yqf8sAzR4L4/8EA=;
 b=S1RAX67gnE0GEAj9GyU32fNuhZiq1729FhqRl6aW99+TdT93gyOe1V5qR+RpOzW9UKwK0D
 R67WTAKTW6tcefwvQmlkRVCAhNdwx8GCe+YhZUn8Pf1Hxz+MbMSoOGCQidfuKacH8cEbE2
 ag8zPGDk86tfGu0NBZk7tNUcdomhykQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-G3WTYPLrOG62hHWkeQgfSA-1; Thu, 19 Sep 2024 12:30:46 -0400
X-MC-Unique: G3WTYPLrOG62hHWkeQgfSA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5daa71823e0so1312393eaf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 09:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726763446; x=1727368246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sJuqsr58LBB69SsuxZGkJ5RDmjH6Yqf8sAzR4L4/8EA=;
 b=MyjsX07ENG44iTchnTNzJ5Ciwt8uhZEU8YZuA3Es8BVrNUXjxr0wNVsa2Hjoi0RmmX
 RSnYh4CdASVttnZAPGvL1Bxmq8hYpET3QJK3OrDbaP9db/OOmTdtQ3xS1ZgDSR5s6djx
 6b6WC/T+LD69l8gCCSl0+loYvNLiP+Yj7yqg63NoVWDCJYoEr4lTMxbTR202hSUTzU4B
 iB1EeajT6KLH+xpYUxsVm/hbezRrqeR4iManJpt7gzfIfuSPY408v5uLzU9oj0EcEEnQ
 v8xlp/vT2o7pgVgh6huNQ8sUBi0XlshfpcUgacAhR5RmnHcWLuo1TJV6y/SgzRn6mNz/
 KVFQ==
X-Gm-Message-State: AOJu0Yz98T3ZjoSQVsisE1ptQljXnWQz9jy9QO09O0LeiAN69VBkRy4y
 J6iIQW9jKxHZijB5Vhz8FIE7oHpeD0DEBWKGu/MtWi5z+FlADIZR0PEBmYPQcMkKgBIXpKmllYI
 RJr/I9rgwZmBTOaeMspv8XYUIyfFY8I69CYjXSlUZ8f02nHU8k9mHMsFiLxxk6Q+sjkSOweWWoG
 rRt1ghF+37OCpywr/MJjQdLY5vEqUkrdlAbg==
X-Received: by 2002:a05:6359:5f8f:b0:1b1:a666:2bba with SMTP id
 e5c5f4694b2df-1bc97624c38mr21343155d.24.1726763445815; 
 Thu, 19 Sep 2024 09:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7CQGWdYnHMDRxkvbJFhiJPRnTpU8rxO3LjpvXcmHxf8EpGeYypDylUo0Wjnu1+3LpQLti3A==
X-Received: by 2002:a05:6359:5f8f:b0:1b1:a666:2bba with SMTP id
 e5c5f4694b2df-1bc97624c38mr21339655d.24.1726763445373; 
 Thu, 19 Sep 2024 09:30:45 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb0809a59sm89741585a.45.2024.09.19.09.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 09:30:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 peterx@redhat.com
Subject: [PATCH] migration: Cleanup migrate_fd_cleanup() on accessing
 to_dst_file
Date: Thu, 19 Sep 2024 12:30:42 -0400
Message-ID: <20240919163042.116767-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The cleanup function can in many cases needs cleanup on its own.

The major thing we want to do here is not referencing to_dst_file when
without the file mutex.  When at it, touch things elsewhere too to make it
look slightly better in general.

One thing to mention is, migration_thread has its own "running" boolean, so
it doesn't need to rely on to_dst_file being non-NULL.  Multifd has a
dependency so it needs to be skipped if to_dst_file is not yet set; add a
richer comment for such reason.

Resolves: Coverity CID 1527402
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ae2be31557..a10fae1aee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1405,6 +1405,9 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
 static void migrate_fd_cleanup(MigrationState *s)
 {
     MigrationEventType type;
+    QEMUFile *tmp = NULL;
+
+    trace_migrate_fd_cleanup();
 
     g_free(s->hostname);
     s->hostname = NULL;
@@ -1415,26 +1418,29 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     close_return_path_on_source(s);
 
-    if (s->to_dst_file) {
-        QEMUFile *tmp;
-
-        trace_migrate_fd_cleanup();
+    if (s->migration_thread_running) {
         bql_unlock();
-        if (s->migration_thread_running) {
-            qemu_thread_join(&s->thread);
-            s->migration_thread_running = false;
-        }
+        qemu_thread_join(&s->thread);
+        s->migration_thread_running = false;
         bql_lock();
+    }
 
-        multifd_send_shutdown();
-        qemu_mutex_lock(&s->qemu_file_lock);
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        /*
+         * Close the file handle without the lock to make sure the critical
+         * section won't block for long.
+         */
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
-        qemu_mutex_unlock(&s->qemu_file_lock);
+    }
+
+    if (tmp) {
         /*
-         * Close the file handle without the lock to make sure the
-         * critical section won't block for long.
+         * We only need to shutdown multifd if tmp!=NULL, because if
+         * tmp==NULL, it means the main channel isn't established, while
+         * multifd is only setup after that (in migration_thread()).
          */
+        multifd_send_shutdown();
         migration_ioc_unregister_yank_from_file(tmp);
         qemu_fclose(tmp);
     }
-- 
2.45.0


