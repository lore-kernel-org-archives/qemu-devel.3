Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090E606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=je+D523I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIiA-0004hX-GT; Wed, 25 Nov 2026 14:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xWIi1-0004dn-QJ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:31:15 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xWIhy-0001C2-Uu
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:31:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so63754035e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1795635067; x=1796239867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cHREIcmN/tPZ4idfLagQ5H1Kd5j/BcuZdiQ/EI04YlA=;
 b=je+D523Ie2vlaKqh5FosHc3UuGI62jnHnrILNVusOQt4I6wx4Rb1dfSXwbhfXs5gA6
 7wQmnHLYvh3cOcCw1CiPHIEy+Nkbf09yzY2/PpOaxnB8V3uxSlPqiDf6QDT15hF8rXCz
 53QwGZiwbIMqUfNiOY3lu0MksPWV3eYx7jh3q2y6/bY1oAA7P82D+dXYEbb51bxxTflh
 eOFN+riW/AE/WoAwe9MAZqqdcnKq6HfoZffpcj+0xBWMcDijlVKU1oC1MetsR0vAq6gG
 U9y56mRdhcpVIfW2kG+RttDHv522YM1djYqEjVjk7Bmgur2olg3xEjU32EoIzsVg/hQV
 qJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795635067; x=1796239867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cHREIcmN/tPZ4idfLagQ5H1Kd5j/BcuZdiQ/EI04YlA=;
 b=THm5eBxmaLsSxfDD31yJN8NAHXPd9yjoaJWi1yHHpGjIAb+APh/ek3s6aMrFucRKy1
 QsvXIpnIyQe36ShUTomgX9l/c0G6srOvvJ7F85ZX3StBfFR11cuBRwuV7tu3geaV/yHx
 f2of6zY7euKl5vbo0sdT+WHiDcBV86vy6w2xZ103AahVrGpZ92IM+3011Q8J3e29lphm
 1X0N5r/FUtpUQzay6xBu5WraNsDZ21xzwHozbLfbSR+Kupnq09T2tz2Pg+XxFpbhZ0CC
 Zd0mlk/j9DY5/b260/StwU76tuRMN9lWVsQSqS3v+jJ9fRDD89XEdisacUmlwLWXE6uP
 vBYQ==
X-Gm-Message-State: APuU4Z/1Mm2uf9ijOn1FfYSGDGgJ2WYcbLNoMCx3js0IaCdgYJZNuzie
 zcr7v+jXtPbvdqjThTNEt5PwGnEYppvJ+DH9kWroYZwQCIac/sf6vMZG1YSL1hEHuAMX+dYcu5m
 PCtkI
X-Gm-Gg: AZFdTZfQVicYzLjr3MtWaiFuvgVvLPtpoGjH6NIaA4KVqkgLNrYZWg0lnTKT6aQMAWC
 mUgq4nXlb1mcJNM/CAsoh/5vtDF4KW+f6n+2BAeE95VOBEcRuIDhlTiqs5fODhdp0zl1Gny5PhU
 WjJHf5zS3KDQobrtLMW6Rbo7nNkzY4l1A5RJTX8OhPL8YM6RHqS6NpLJJwPVak8bixjBIj5NtZr
 t5bD9QllyTPXNzGcpzIjztThIhZA2chiz16uQ5UjZgP7inBkX3nDX8Wc1MTjNSEOzPnS9tDYWd0
 8vn40BDJMIUxNs2MLqmrv9J/680CDjvBFajdIOl2Wy8v+0jO8wyLwe37E0IBAnDgUbtTps+oZl9
 9ZXO8O4gtFo13iJpbAtXcKuoVXEa6BBmDTfrNGTzU8bc/v3T4iWTar9g8YwLMQtH47o/feMw4Bk
 7kXyD8YdIfseKSBDmgaW5E679e/Q7qAJd04Q2Nkj+AjRRG8//UoEMWR4GNhsGpTLj2lIzLZKjSk
 QEMU4JFLaBeSgxM8Ih4CW2+y/eLUyozCJ6K2jbLk4CQiNrnZ+xof63P0qff0ulSxJGqyMT/3ydK
 NDKbfdHqACmuA/YYHRA+jDTmfkc=
X-Received: by 2002:a05:600c:154e:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4bb887c3b63mr410668075e9.4.1795635067286; 
 Wed, 25 Nov 2026 11:31:07 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:73c7:7c5f:a985:743e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b1ed8b6a05sm18133069f8f.43.2026.11.25.11.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:31:06 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/2] tests/qtest/migration: test cancel before the channel
 connects
Date: Wed, 25 Nov 2026 20:31:02 +0100
Message-ID: <20261125193102.1423555-3-den@openvz.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125193102.1423555-1-den@openvz.org>
References: <20261125193102.1423555-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Cancel a migration while the source is still connecting, then let the
connection succeed. The source must end up in "cancelled", and a
second migration afterwards must complete.

To keep the source waiting in connect(), the test points it at a unix
socket of its own whose listen queue is already full. On Linux,
connect() then blocks until the test accepts a connection, so the test
is Linux-only.

The return-path capability is on because the hang this test guards
against is the cleanup waiting for the return path thread.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index d57ffcac23..114dd8caf9 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -666,6 +666,68 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
     migrate_end(from, to, false);
 }
 
+#ifdef CONFIG_LINUX
+/* On Linux connect() to a unix socket with a full backlog blocks */
+static int unix_listen_full(const char *path, int *filler)
+{
+    struct sockaddr_un addr = { .sun_family = AF_UNIX };
+    int lfd = socket(AF_UNIX, SOCK_STREAM, 0);
+
+    *filler = socket(AF_UNIX, SOCK_STREAM, 0);
+    g_assert_cmpint(lfd, >=, 0);
+    g_assert_cmpint(*filler, >=, 0);
+
+    g_assert_cmpuint(strlen(path), <, sizeof(addr.sun_path));
+    strcpy(addr.sun_path, path);
+    g_assert_cmpint(bind(lfd, (struct sockaddr *)&addr, sizeof(addr)), ==, 0);
+    g_assert_cmpint(listen(lfd, 0), ==, 0);
+    g_assert_cmpint(connect(*filler, (struct sockaddr *)&addr, sizeof(addr)),
+                    ==, 0);
+    return lfd;
+}
+
+static void test_cancel_src_before_connect(char *name, MigrateCommon *args)
+{
+    g_autofree char *full_path = g_strdup_printf("%s/migsocket-full", tmpfs);
+    g_autofree char *full_uri = g_strdup_printf("unix:%s", full_path);
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int lfd, filler, accepted;
+
+    if (migrate_start(&from, &to, &args->start)) {
+        return;
+    }
+
+    migrate_set_capability(from, "return-path", true);
+    migrate_set_capability(to, "return-path", true);
+
+    lfd = unix_listen_full(full_path, &filler);
+    migrate_qmp(from, to, full_uri, NULL, "{}");
+    migrate_cancel(from);
+
+    /* Taking the filler off the backlog lets the source's connect() finish */
+    accepted = accept(lfd, NULL, NULL);
+    g_assert_cmpint(accepted, >=, 0);
+
+    wait_for_migration_status(from, "cancelled",
+                              (const char * []) { "completed", NULL });
+
+    close(accepted);
+    close(filler);
+    close(lfd);
+    unlink(full_path);
+
+    migrate_incoming_qmp(to, uri, NULL, "{}");
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+    migrate_qmp(from, to, uri, NULL, "{}");
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+
+    migrate_end(from, to, true);
+}
+#endif
+
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
 {
     qtest_qmp_assert_success(who,
@@ -1174,4 +1236,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                                       test_cancel_src_after_status);
         }
     }
+#ifdef CONFIG_LINUX
+    migration_test_add("/migration/cancel/src/before/connect",
+                       test_cancel_src_before_connect);
+#endif
 }
-- 
2.55.0


