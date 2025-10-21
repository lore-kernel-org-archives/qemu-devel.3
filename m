Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF55ACCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 22:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBKSt-0003qQ-Am; Tue, 21 Oct 2025 18:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSq-0003pP-N4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSo-0001KX-KL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761084257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69ecGEZJFtzy4xFcHboVNxa4L/XTe4GWvnXGonXsjRQ=;
 b=h3dtjJxWCcnM74vbZDgGvzYwVYVaWkfbfldjWFx5Rb4aTvV2rom/t8lx5JUBeuahwI+MzD
 CziFbNeABPS/zp8C5XFjQ9zSH29L/uBUQWVEIsSdGDW2PZP3pBPpDrPUpDtcEWMKqyMA4P
 64eX2pd7yjXz0CqNKHhnieRji+KSp+A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-DnwFUZ-PM7-CpajaNSL8Pg-1; Tue, 21 Oct 2025 18:04:15 -0400
X-MC-Unique: DnwFUZ-PM7-CpajaNSL8Pg-1
X-Mimecast-MFC-AGG-ID: DnwFUZ-PM7-CpajaNSL8Pg_1761084255
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-890f1090e81so1076214785a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 15:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761084254; x=1761689054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69ecGEZJFtzy4xFcHboVNxa4L/XTe4GWvnXGonXsjRQ=;
 b=R+U22jbtK4+FjZYQUTmrocoBmCmMnA8bsstAk9gnY+Ww1APQaJPZewSZkUsAbSlnG6
 e1wKYhyV0wHHm3Wr7Ijv+TWRX2quOcVy1vAc0hXhh3hSfuh5X+/giVMfyGY5FqNzqOZZ
 lO7PFDJXMq+bnw8f1i9C9roWhHWpkx5hF8YT/G5zg0q82nWxx361J631qFU70vDA8xnP
 h+vAdYyw7/QnmpjMbn9KMbZs8vaQgqjtD2paIC02IoGeP+YR4tgKvkqpIQwL7JNesyrf
 xCE7EWfMZPultAEnPEIEAiA/x9fyNFmxCQytDZB2n8g6aeWa4NBVYZN+KOeydY0nBkSg
 qcQg==
X-Gm-Message-State: AOJu0Yyzbk8/zcFC/t/oB5fMJQZTn7+SdPrkYZ7Af+ZYFotCly7JN6xF
 305oGDJ7tgXL6Y3d7hopq86ayqHA0DRPsWT/7BdXcg7iOqwSxja06ie3moiyEe/vQbZBGeV37rF
 EPYMNIm7ltlTWKOjhNlbpktWqWv89uFTni+TLopUwgUX3lO2sIMFWfMXmilTSeCGXCTDxIRuCtd
 rgbG6OF0VbvHV7mDhmQR0oxwDjOFhKsUIuFvPKCA==
X-Gm-Gg: ASbGnctWptPgIEa9+y/UtkWUakG8K1lg0vZ/Vy4LZ7XX2Dm6dotn2Fs6UrdhWdMOsd+
 dGmfSbyLfN3NBLIwLlzO9EplNyLGxZHAP4Uf+Td2ztYTdEIIWkGGEgvq+RbNWr8YeV2eZvZEiUT
 PBirfUzFRtj9jjInR0zX3a2GK8lZHKv+rQyB1o2lMMNQBBjRpQWLAdHEXWR9L3umarXwTumN6GA
 4346xhdR60CRyy/lyezQS1QpikRja3InBC/fhNOCfMC9oBJJmOkSS5AHkZEUOCJoKI9wTvME1Ea
 l1FnlqvdN2ABz7X3T/EzZgbSygsn9LSAga4xqAPJJH0kFI+MM3vB+biA4nO5IEuY
X-Received: by 2002:a05:620a:40d4:b0:85f:ffc2:b620 with SMTP id
 af79cd13be357-8907050ddc9mr2126325585a.68.1761084254567; 
 Tue, 21 Oct 2025 15:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5p+VOka/UWLiWV4fFRIWebSck8Qb4jv/hSJ6id/oHKBXOBWYc+4s/vhHhg9c2yIEklK/4GA==
X-Received: by 2002:a05:620a:40d4:b0:85f:ffc2:b620 with SMTP id
 af79cd13be357-8907050ddc9mr2126319285a.68.1761084253921; 
 Tue, 21 Oct 2025 15:04:13 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd098edasm849197285a.19.2025.10.21.15.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 15:04:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon <armenon@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 2/4] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
Date: Tue, 21 Oct 2025 18:04:05 -0400
Message-ID: <20251021220407.2662288-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021220407.2662288-1-peterx@redhat.com>
References: <20251021220407.2662288-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Per reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com

mfd leak is a false positive, try to use a coverity annotation (which I
didn't find manual myself, but still give it a shot).

Fix the other one by capture error if setenv() failed.  When at it, pass
the error to the top (cpr_state_save()).  Along the way, changing all
retval to bool when errp is around.

Resolves: Coverity CID 1641391
Resolves: Coverity CID 1641392
Fixes: efc6587313 ("migration: cpr-exec save and load")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  4 ++--
 migration/cpr-exec.c    | 10 ++++++++--
 migration/cpr.c         | 15 +++++++++------
 migration/migration.c   |  2 +-
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index a412d6663c..027cb98073 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -41,7 +41,7 @@ MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
 
-int cpr_state_save(MigrationChannel *channel, Error **errp);
+bool cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
@@ -56,7 +56,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 void cpr_exec_init(void);
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
-void cpr_exec_persist_state(QEMUFile *f);
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp);
 bool cpr_exec_has_state(void);
 void cpr_exec_unpersist_state(void);
 void cpr_exec_unpreserve_fds(void);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index d57714bc5d..087ca94c87 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -40,16 +40,22 @@ static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
     return qemu_file_new_output(ioc);
 }
 
-void cpr_exec_persist_state(QEMUFile *f)
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
+    /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
     int mfd = dup(fioc->fd);
     char val[16];
 
     /* Remember mfd in environment for post-exec load */
     qemu_clear_cloexec(mfd);
     snprintf(val, sizeof(val), "%d", mfd);
-    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
+    if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
+        error_setg(errp, "Setting env %s = %s failed", CPR_EXEC_STATE_NAME, val);
+        return false;
+    }
+
+    return true;
 }
 
 static int cpr_exec_find_state(void)
diff --git a/migration/cpr.c b/migration/cpr.c
index 22dbac7c72..adee2a919a 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -176,7 +176,7 @@ bool cpr_is_incoming(void)
     return incoming_mode != MIG_MODE_NONE;
 }
 
-int cpr_state_save(MigrationChannel *channel, Error **errp)
+bool cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
     QEMUFile *f;
@@ -190,10 +190,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     } else if (mode == MIG_MODE_CPR_EXEC) {
         f = cpr_exec_output(errp);
     } else {
-        return 0;
+        return true;
     }
     if (!f) {
-        return -1;
+        return false;
     }
 
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
@@ -202,11 +202,14 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
     if (ret) {
         qemu_fclose(f);
-        return ret;
+        return false;
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
-        cpr_exec_persist_state(f);
+        if (!cpr_exec_persist_state(f, errp)) {
+            qemu_fclose(f);
+            return false;
+        }
     }
 
     /*
@@ -217,7 +220,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
                          NULL);
     cpr_state_file = f;
-    return 0;
+    return true;
 }
 
 int cpr_state_load(MigrationChannel *channel, Error **errp)
diff --git a/migration/migration.c b/migration/migration.c
index a63b46bbef..c8a5712993 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2301,7 +2301,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (cpr_state_save(cpr_channel, &local_err)) {
+    if (!cpr_state_save(cpr_channel, &local_err)) {
         goto out;
     }
 
-- 
2.50.1


