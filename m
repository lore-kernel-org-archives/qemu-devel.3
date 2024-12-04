Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D04E77169
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdd0-0003Kg-RY; Tue, 03 Dec 2024 19:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdce-0003H6-VK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcc-0005rr-Hn
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6HNcsiqaXHAtCR81Tet2C9VNDCVc5sLauFrWeUoMuc=;
 b=Jr9tD5747O8Ttn00HIKsXd6XD0iVnL4mau1iOFHfarPLzhRx2B92mRGovUyhH/FXMPIzOc
 zZ7NWVaOZKEUBaR2ZHT+yYU1PW3irdPTR0rpALYH8PZ77NQnDqJiQrKabPyFJhLT7QGv2k
 haL3vwCLYGJz3oEUcbIJ0yQqt3FWHZk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-1oLbw1FLPT2Dzv8CQWcGQQ-1; Tue, 03 Dec 2024 19:52:05 -0500
X-MC-Unique: 1oLbw1FLPT2Dzv8CQWcGQQ-1
X-Mimecast-MFC-AGG-ID: 1oLbw1FLPT2Dzv8CQWcGQQ
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d89309de06so65801636d6.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273524; x=1733878324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6HNcsiqaXHAtCR81Tet2C9VNDCVc5sLauFrWeUoMuc=;
 b=L9imlWnylOzpw4DQfBQp30c0or2QbEtvHm86QyoLf0PdNtz5LI5zlyXeNEg7FJHcpd
 /9P+qOBcsvToTAK6uso4ptVcxOk8t9nUFIvrcRCboBvWoCewN8rBKXaVkG5McG3le+4d
 vxxfO7EF0/8mcO8Qe+R04+u3xPxHpmK/5vqWW7MtONCESw/acTdDRLo4NYFbX8a/xEXQ
 UnoxXW6cHQm97SPygNJQVVx9vBkN46OKylkvt45lt2Pmh3+A3ea+qezkc2v7CiTi9cSq
 q6oHZOI7Zk18woohZ3AwmQxnkgnmCnwbHIkNl1Qej8zB2v+xtoqS4W2AunIWPK7OV+qY
 nbsQ==
X-Gm-Message-State: AOJu0YwnYrGsW7QCwZlT/jdYqSNJY0Z9/Zm78g0FwS823hAAXiL9rIcs
 KNDj8KyYETsulmyylIbNUo4i478vEv4dDV7QtfddYi9C3+y44fdw5isALQwjxQCEq92Vh6BOYdY
 fUYOh2rsxKhLZg8dXjGKXqREFKMSfBerubpf1HscRRYDVF7yEYpQY57yTTSWDdP7hMlEO1Nei2R
 5f9EDuQjeO1YFjePzfVX4FueYhjQ3VGOg0oQ==
X-Gm-Gg: ASbGncuAAcyrTRt/moSUUVJLOU/4WPrb+zLbriH+0dPyXCxyVw2HThUs4tldzu2yNiI
 QJSioP39TonsDH/b6beh2KY/bKVdbUF3GEHhLd/04PK/dxASKEEP5FtQBEnowGdOVgFuQ60zuyQ
 RJcBt5gcowmS/ptSzjcAIk0hiViQ//fvH/4qHtmeURdvw9pbsUizTOWeNehslBZZKBn6yCx1dMN
 rKx42FhfnnHF/FfMX6gDkmo0cpnRnInM1fByHU5tC49J7WN8iADRshHk2Yr6yJTHQEqasdlCITg
 3E2JL1DBgNu7wpTfSOSwMWqpLQ==
X-Received: by 2002:ad4:5f4e:0:b0:6d8:8165:ef21 with SMTP id
 6a1803df08f44-6d8c46ecd45mr39271026d6.49.1733273524304; 
 Tue, 03 Dec 2024 16:52:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9P/+ortXg3b41Bp+raqm8Nws9cdGRStoTLCdCOjTlHhezJ7S3s4bwJECw66qbfByvuDPnfQ==
X-Received: by 2002:ad4:5f4e:0:b0:6d8:8165:ef21 with SMTP id
 6a1803df08f44-6d8c46ecd45mr39270656d6.49.1733273523859; 
 Tue, 03 Dec 2024 16:52:03 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:52:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 11/11] tests/qtest/migration: Test successive migrations
Date: Tue,  3 Dec 2024 19:51:38 -0500
Message-ID: <20241204005138.702289-12-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

From: Fabiano Rosas <farosas@suse.de>

Add a framework for running migrations back and forth between two
guests (aka ping-pong migration). We have seen a couple of bugs that
only reproduce when a guest is migrated and the destination machine is
used as the source of a new migration.

Add a simple test that does 2 migrations and another test that uses
the late-block-activate capability, which is one area where a bug has
been found.

Note that this does not reuse any of the existing tests
(e.g. test_precopy_common), because there is too much ambiguity
regarding how to handle the hooks, args->result, stop/continue, etc.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241125144612.16194-6-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 121 +++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 74645f749c..4955b3b9eb 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1819,6 +1819,104 @@ finish:
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
+static void migrate_dst_becomes_src(QTestState **from, QTestState **to,
+                                    QTestMigrationState *src_state,
+                                    QTestMigrationState *dst_state)
+{
+    *from = *to;
+
+    *src_state = (QTestMigrationState) { };
+    src_state->serial = dst_state->serial;
+    qtest_qmp_set_event_callback(*from, migrate_watch_for_events, src_state);
+
+    src_state->stop_seen = dst_state->stop_seen;
+}
+
+static void test_precopy_ping_pong_common(MigrateCommon *args, int n,
+                                          bool late_block_activate)
+{
+    QTestState *from, *to;
+    bool keep_paused = false;
+
+    g_assert(!args->live);
+
+    g_test_message("Migrating back and forth %d times", n);
+
+    for (int i = 0; i < n; i++) {
+        g_test_message("%s (%d/%d)", i % 2 ? "pong" : "ping", i + 1, n);
+
+        if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+            return;
+        }
+
+        if (late_block_activate) {
+            migrate_set_capability(from, "late-block-activate", true);
+            migrate_set_capability(to, "late-block-activate", true);
+
+            /*
+             * The late-block-activate capability expects that the
+             * management layer will issue a qmp_continue command on
+             * the destination once the migration finishes. In order
+             * to test the capability properly, make sure the test is
+             * not issuing spurious continue commands.
+             */
+            keep_paused = true;
+        }
+
+        if (!src_state.stop_seen) {
+            wait_for_serial(src_state.serial);
+        }
+
+        /* because of !args->live */
+        qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+        wait_for_stop(from, &src_state);
+
+        migrate_ensure_converge(from);
+        migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
+
+        wait_for_migration_complete(from);
+        wait_for_migration_complete(to);
+
+        /* note check_guests_ram() requires a stopped guest */
+        check_guests_ram(to);
+
+        if (keep_paused) {
+            /*
+             * Nothing issued continue on the destination, reflect
+             * that the guest is paused in the dst_state.
+             */
+            dst_state.stop_seen = true;
+        } else {
+            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+            wait_for_serial(dst_state.serial);
+            dst_state.stop_seen = false;
+        }
+
+        /*
+         * Last iteration, let the guest run to make sure there's no
+         * memory corruption. The test_migrate_end() below will check
+         * the memory one last time.
+         */
+        if (i == n - 1) {
+            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+            wait_for_serial(dst_state.serial);
+            dst_state.stop_seen = false;
+            break;
+        }
+
+        /*
+         * Prepare for migrating back: clear the original source and
+         * switch source & destination.
+         */
+        migrate_cleanup(from, NULL);
+        migrate_dst_becomes_src(&from, &to, &src_state, &dst_state);
+
+        args->start.only_target = true;
+    }
+
+    test_migrate_end(from, to, true);
+}
+
 static void file_dirty_offset_region(void)
 {
     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
@@ -3772,6 +3870,24 @@ static void test_migrate_dirty_limit(void)
     test_migrate_end(from, to, true);
 }
 
+static void test_precopy_ping_pong(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+    };
+
+    test_precopy_ping_pong_common(&args, 2, false);
+}
+
+static void test_precopy_ping_pong_late_block(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+    };
+
+    test_precopy_ping_pong_common(&args, 2, true);
+}
+
 static bool kvm_dirty_ring_supported(void)
 {
 #if defined(__linux__) && defined(HOST_X86_64)
@@ -4055,6 +4171,11 @@ int main(int argc, char **argv)
         }
     }
 
+    migration_test_add("/migration/precopy/ping-pong/plain",
+                       test_precopy_ping_pong);
+    migration_test_add("/migration/precopy/ping-pong/late-block-activate",
+                       test_precopy_ping_pong_late_block);
+
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
2.47.0


