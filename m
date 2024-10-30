Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF06D6B6A0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B4s-0003Vz-Ek; Wed, 30 Oct 2024 11:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4q-0003VV-G6
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4o-0007ke-F4
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fq34e+xBKmQ7ga4DrHPUzO43nYUW5RRJHXBVVJfk/Ig=;
 b=fdO2vxhwQuEK1YQAxcxg24y/FKHnyy4ZqaC14ZWKYyxhnN9N2R1Jwe1UtpWdKJUw9j3wJ/
 qFSLMs5hG47unPPi9ZYuUMfcPPByiXzonsjJ3sBpgxsRcXVGBRAQ+uGaTp7I8gASD27s2d
 k63dxx8aGmnq+md4W8WxowZctoTYB8w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674--EU3NgS7OGqrhYd2gIngfQ-1; Wed, 30 Oct 2024 11:57:39 -0400
X-MC-Unique: -EU3NgS7OGqrhYd2gIngfQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d19597cee0so49692256d6.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303858; x=1730908658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fq34e+xBKmQ7ga4DrHPUzO43nYUW5RRJHXBVVJfk/Ig=;
 b=kOclD0fG/CZ6/fpeofbN8MB2trUG4QAORzh48+aorX2RirFy1RPb6MJ9tt+PIvmxMV
 VCu1b4XOFiK955EutQDOf+6d9aEH4DHgaadZudupilOl/5SZa19nRoRr8Kh7ITBCYyCP
 rDyp4dHfql7JBuQ1bhaC/8HhCrnRK/dom2E2IDBn586A9QhqM0aHB6p5lZlo95bLWeyQ
 dG6QIukseu/7JTqIBIyoJZVLqIFRs/pM8LKMEQm2l29zI2gag15TMNTfLNUL4WI4TdBK
 DGoCKa1Lr992P6llnOx+wgYhp6k4q/EpKvyB8y/KXrkXFG9gjSKEhAeR7Wg7XrU/TtGe
 wCAQ==
X-Gm-Message-State: AOJu0YypMJcKTIydF0ZWKWXc+6Rqb6GezyecbZqZL0RD5x16kLn8+92t
 IGMmYwYXc5Ilk1KhYAFh2DSFa5Q9vwK/EkD0fsRdmoXxg48naRbGFllMwTKIkl8Qjsz4W2TBy0+
 TVeyCAbKTzkr5n0e58wBzGSi7uihDUWsydBYezCasMUCtm7L53zjdL1y6EdE0y7f978UIAMwAoS
 n8FzK6YB7N6tlyb6UE+H3mRjUynEdwpcoLog==
X-Received: by 2002:a05:6214:568c:b0:6d1:939f:d861 with SMTP id
 6a1803df08f44-6d346020777mr52962706d6.26.1730303858004; 
 Wed, 30 Oct 2024 08:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyEdN9R8MUVctyLByAlUSpYHSmqO/oODMoLGF/V9rG16auW8l9Mt3FR/CmTzRY86q2lq1TTg==
X-Received: by 2002:a05:6214:568c:b0:6d1:939f:d861 with SMTP id
 6a1803df08f44-6d346020777mr52962396d6.26.1730303857658; 
 Wed, 30 Oct 2024 08:57:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 01/18] migration: Cleanup migrate_fd_cleanup() on accessing
 to_dst_file
Date: Wed, 30 Oct 2024 11:57:17 -0400
Message-ID: <20241030155734.2141398-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240919163042.116767-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 021faee2f3..f5f428e764 100644
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


