Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85083D46634
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgWFO-00068n-97; Thu, 15 Jan 2026 17:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWFF-0005z4-J8
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:55:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWFD-0008K6-LB
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768517711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2BbPrejjC1FlAZ8xQiekJJRvkNULNih9IpSitGenkg=;
 b=cyvWiwwGQeNXqAit0PMLij27U+cJzMNiCaSkOC/IL6rXjaqfyzSmwanViIE25hVU/zfG85
 sYm6/VzC0iXLxDoIYgFa7tz8BTBmPLwh01SOTo87tcz2SLEoR2TOJ165jhY0CkryctkFkX
 cLda9EhOXE98txaiH0AyPaDZkkTESNg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-rY7w0snCPoioQSVL9NUPzA-1; Thu, 15 Jan 2026 17:55:09 -0500
X-MC-Unique: rY7w0snCPoioQSVL9NUPzA-1
X-Mimecast-MFC-AGG-ID: rY7w0snCPoioQSVL9NUPzA_1768517709
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c6a5bc8c43so154648985a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768517708; x=1769122508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2BbPrejjC1FlAZ8xQiekJJRvkNULNih9IpSitGenkg=;
 b=eEZ99Ob2iy31hKs6ueo6nv9572vAgG4nbDe+l7oC3Yd0CbFLmIweFhfET8wEmD6zaS
 bZpuc6UbD7bB57aSulsBFCjbf4fi5CW6ypw01pWllbJ5qYJTknDp7oyO96IXYslXXZSy
 SxLt1TpvWrn9sK3QmQAAmsfM4GpZHjLZC8FB59AkT+7hUOZs3MKksxEVv9uIKFc444sS
 mjYYHgPtvNQI92J7Io9freCDdYfT3/s5buXogVkd7UWL+A2DXeBGcZ/Anw54b4nkKLhy
 pUJbM67zsZ64M5MqqGtD0KrO3EB+1eq2MzTyA/CykD0cYm1myGOkQyUNNYxBkbmh64UU
 HGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768517708; x=1769122508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R2BbPrejjC1FlAZ8xQiekJJRvkNULNih9IpSitGenkg=;
 b=ro5KX8JwephESUXvtnZS1VVoNWplzG9cA/qHpT3iNgfthU22ayMB4rJ/w9WZDyyPsZ
 anpP4t62tVMX7MLU6fNRj+sVal/5w6uhYM5389PVMNuyVs/nRsly+NGz+OktDWLalr7z
 xGmU7ytrXXRjcNUinWwP9T/v0mpSVgin+CIAk7znBnkapVGer14CflMqvRryxAWV25dW
 9eHV8i8W7cL0iA76ntFIY7s+gmfmJpux0v4PHDf3Ou76bk2Ord119oM2b5wYv6/dBlLx
 LNdgp8LVJKR4YnEwy2zX4e2kZHa4USPWpcgAos41u7Kuw59NX6p7DbyqkOkLgBNSEuyj
 WIaA==
X-Gm-Message-State: AOJu0YwqQdNVyP+MV2A9fcZDKWxeZ15od4SkE+bpZMav6B4NVNlZu44A
 oSHRufSJOI4dfqAPGyEyNkueVldzIhetPM5EX4KlTy+HzpKBArlUA9x7ypIP0kNH/d5u8QMnF2u
 ZCem+bHHpcBu3erqDihiaHMN6/YJgbToEMRlHR7uf4C7LKFYLr4Ippbs9/543rMKjq8+6CTL4cj
 vAAdA6ZGQ+2aaPYBPXeRE7+S2BnIk6DM7emxCk1A==
X-Gm-Gg: AY/fxX67Zjq0yUXG7l4C4TzZFb2G1pL7B07AllFfWjNndMtjrJl5cwH8VYTeQu3bt1n
 rFCx6anGr5/F4qu99famYgA/B4RkHR8vAu3mFO5y929DY/A+HSWya+0CV/CgFYLVnKN8JTb7rbE
 qX2RNwbqhMq3XtBYfH494HzXYue0+HfSJRQXWsZNAbwI6ln/JJUvbsSiiUKgyV2oPYTwMQlreTN
 8Z61tEnh7HG9hfKnH4Rw5JsMgG2ZnkSJYnvufItdHKqSlLV8dU4BGFnCscMEadq7fIDo7Or9aCj
 AhsRS+dXgBwiP/UP8NP4F83Qr5po9vS2eYhR0bRi48T8PWvIyRz5VWz9hy1rLf8vX0y5IykTYrN
 d
X-Received: by 2002:a05:620a:4415:b0:8c3:7e05:db01 with SMTP id
 af79cd13be357-8c6a66d6957mr144837985a.2.1768517708487; 
 Thu, 15 Jan 2026 14:55:08 -0800 (PST)
X-Received: by 2002:a05:620a:4415:b0:8c3:7e05:db01 with SMTP id
 af79cd13be357-8c6a66d6957mr144834985a.2.1768517707783; 
 Thu, 15 Jan 2026 14:55:07 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71d8314sm70353185a.24.2026.01.15.14.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:55:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 2/2] migration: Remove fd: support on files
Date: Thu, 15 Jan 2026 17:55:03 -0500
Message-ID: <20260115225503.3083355-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115225503.3083355-1-peterx@redhat.com>
References: <20260115225503.3083355-1-peterx@redhat.com>
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

This feature was deprecated in 9.1.  Remove it in this release (11.0).

We also need to remove one unit test (/migration/precopy/fd/file) that
covers the fd: file migration, because it'll stop working now.

Reviewed-by: Prasad Pandit <ppandit@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst             | 14 ---------
 docs/about/removed-features.rst       |  9 ++++++
 migration/fd.c                        | 11 ++++---
 tests/qtest/migration/precopy-tests.c | 41 ---------------------------
 4 files changed, 16 insertions(+), 59 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dfb0a6eba5..a46cc6b9fd 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -560,17 +560,3 @@ If the user requests a modern x86 CPU model (i.e. not one of ``486``,
 ``athlon``, ``kvm32``, ``pentium``, ``pentium2``, ``pentium3``or ``qemu32``)
 a warning will be displayed until a future QEMU version when such CPUs will
 be rejected.
-
-Migration
----------
-
-``fd:`` URI when used for file migration (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``fd:`` URI can currently provide a file descriptor that
-references either a socket or a plain file. These are two different
-types of migration. In order to reduce ambiguity, the ``fd:`` URI
-usage of providing a file descriptor to a plain file has been
-deprecated in favor of explicitly using the ``file:`` URI with the
-file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
-command documentation for details on the ``fdset`` usage.
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 4aae30918d..ebb46bb3b1 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -710,6 +710,15 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
 storage migration with ``blockdev-mirror`` + NBD" in
 docs/interop/live-block-operations.rst for a detailed explanation.
 
+``migrate`` command with file-based ``fd:`` URI (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+In order to reduce ambiguity, the ``fd:`` URI usage of providing a
+file descriptor to a plain file has been removed in favor of
+explicitly using the ``file:`` URI with the file descriptor being
+passed as an ``fdset``. Refer to the ``add-fd`` command documentation
+for details on the ``fdset`` usage.
+
 ``migrate-set-capabilities`` ``block`` option (removed in 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/migration/fd.c b/migration/fd.c
index 9bf9be6acb..fdeece2101 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -24,6 +24,7 @@
 #include "qemu/sockets.h"
 #include "io/channel-util.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 static bool fd_is_pipe(int fd)
 {
@@ -58,8 +59,9 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     if (!migration_fd_valid(fd)) {
-        warn_report("fd: migration to a file is deprecated."
-                    " Use file: instead.");
+        error_setg(errp, "fd: migration to a file is not supported."
+                   " Use file: instead.");
+        return;
     }
 
     trace_migration_fd_outgoing(fd);
@@ -92,8 +94,9 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
     }
 
     if (!migration_fd_valid(fd)) {
-        warn_report("fd: migration to a file is deprecated."
-                    " Use file: instead.");
+        error_setg(errp, "fd: migration to a file is not supported."
+                   " Use file: instead.");
+        return;
     }
 
     trace_migration_fd_incoming(fd);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index aca7ed51ef..3af8ec2e33 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -289,45 +289,6 @@ static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 
     test_precopy_common(args);
 }
-
-static void *migrate_hook_start_precopy_fd_file(QTestState *from,
-                                                QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-    int src_flags = O_CREAT | O_RDWR;
-    int dst_flags = O_CREAT | O_RDWR;
-    int fds[2];
-
-    fds[0] = open(file, src_flags, 0660);
-    assert(fds[0] != -1);
-
-    fds[1] = open(file, dst_flags, 0660);
-    assert(fds[1] != -1);
-
-
-    qtest_qmp_fds_assert_success(to, &fds[0], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-
-    qtest_qmp_fds_assert_success(from, &fds[1], 1,
-                                 "{ 'execute': 'getfd',"
-                                 "  'arguments': { 'fdname': 'fd-mig' }}");
-
-    close(fds[0]);
-    close(fds[1]);
-
-    return NULL;
-}
-
-static void test_precopy_fd_file(char *name, MigrateCommon *args)
-{
-    args->listen_uri = "defer";
-    args->connect_uri = "fd:fd-mig";
-    args->start_hook = migrate_hook_start_precopy_fd_file;
-    args->end_hook = migrate_hook_end_fd;
-
-    test_file_common(args, true);
-}
 #endif /* _WIN32 */
 
 /*
@@ -1255,8 +1216,6 @@ void migration_test_add_precopy(MigrationTestEnv *env)
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
                        test_precopy_fd_socket);
-    migration_test_add("/migration/precopy/fd/file",
-                       test_precopy_fd_file);
 #endif
 
     /*
-- 
2.50.1


