Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7147FFEDA03
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z4m-0003l2-AP; Tue, 17 Mar 2026 14:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z4k-0003ke-UG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:23:30 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z4j-00034A-2P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:23:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B4C54D3BC;
 Tue, 17 Mar 2026 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8qszfObvvrpBzl9FjAnV8XOcetgvioqDs1BJyFKlgo=;
 b=No8xyFZpYxwgiXrFKEQgLL6N65RpfAr9q54p8JsR5G/IuZaKRexDWjmuI4tXsM8imyg7pK
 MyonhFRTVMVFwzuaPSNSQZLWCd+Mi9RZFHf60bOTjbYkIF5fsDjr+vcq/2Ru7VC+z3CeWp
 89WZlfBt5qCAVfi8G4/SAe3u4XDjRAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8qszfObvvrpBzl9FjAnV8XOcetgvioqDs1BJyFKlgo=;
 b=ADo2kutz1HHolpjBAWS/TaMccV4aM3VkIcaWVgPK/cyPDiu0pbh16nb9wy1ExObSPn4Ckl
 02aTicUJZPruEuCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=No8xyFZp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ADo2kutz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8qszfObvvrpBzl9FjAnV8XOcetgvioqDs1BJyFKlgo=;
 b=No8xyFZpYxwgiXrFKEQgLL6N65RpfAr9q54p8JsR5G/IuZaKRexDWjmuI4tXsM8imyg7pK
 MyonhFRTVMVFwzuaPSNSQZLWCd+Mi9RZFHf60bOTjbYkIF5fsDjr+vcq/2Ru7VC+z3CeWp
 89WZlfBt5qCAVfi8G4/SAe3u4XDjRAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8qszfObvvrpBzl9FjAnV8XOcetgvioqDs1BJyFKlgo=;
 b=ADo2kutz1HHolpjBAWS/TaMccV4aM3VkIcaWVgPK/cyPDiu0pbh16nb9wy1ExObSPn4Ckl
 02aTicUJZPruEuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35E234273B;
 Tue, 17 Mar 2026 18:23:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oDxMOxucuWnXdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 18:23:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 01/10] tests/qtest/migration: Fix leak of migration tests data
Date: Tue, 17 Mar 2026 15:23:11 -0300
Message-ID: <20260317182320.31991-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317182320.31991-1-farosas@suse.de>
References: <20260317182320.31991-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5B4C54D3BC
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When the migration-test is invoked with the '-p' flag (to run a single
test), the glib code won't call the destroy function for the
not-executed tests, causing the MigrationTest wrapper data to leak.

This doesn't affect make check, but affects debugging use-cases where
having a leak pop up in ASAN output is extra annoying.

Fix by adding the tests data to a list and freeing them all at the end
of migration-test execution. Any tests actually dispatched by glib
will have the destroy function called as usual.

Note that migration_test_add_suffix() is altered to call
migration_test_add() so that there's only one place adding the data to
the list.

Performance is not an issue at the moment, we have < 100 tests.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260311213418.16951-2-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c      |  2 ++
 tests/qtest/migration/migration-util.c | 19 ++++++++++++++-----
 tests/qtest/migration/migration-util.h |  2 +-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 0bfc241914..b9371372de 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1162,5 +1162,7 @@ int migration_env_clean(MigrationTestEnv *env)
     }
     g_free(tmpfs);
 
+    migration_tests_free();
+
     return ret;
 }
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index c2462306a1..2648ad7f61 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -38,6 +38,7 @@
 #include "linux/kvm.h"
 #endif
 
+GQueue *tests;
 
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
@@ -243,6 +244,8 @@ static void migration_test_destroy(gpointer data)
 {
     MigrationTest *test = (MigrationTest *)data;
 
+    g_queue_remove(tests, test);
+
     g_free(test->data);
     g_free(test->name);
     g_free(test);
@@ -268,21 +271,27 @@ void migration_test_add(const char *path,
 
     qtest_add_data_func_full(path, test, migration_test_wrapper,
                              migration_test_destroy);
+    if (!tests) {
+        tests = g_queue_new();
+    }
+    g_queue_push_tail(tests, test);
 }
 
 void migration_test_add_suffix(const char *path, const char *suffix,
                                void (*fn)(char *name, MigrateCommon *args))
 {
-    MigrationTest *test = g_new0(MigrationTest, 1);
+    g_autofree char *name = NULL;
 
     g_assert(g_str_has_suffix(path, "/"));
     g_assert(!g_str_has_prefix(suffix, "/"));
 
-    test->func = fn;
-    test->name = g_strconcat(path, suffix, NULL);
+    name = g_strconcat(path, suffix, NULL);
+    migration_test_add(name, fn);
+}
 
-    qtest_add_data_func_full(test->name, test, migration_test_wrapper,
-                             migration_test_destroy);
+void migration_tests_free(void)
+{
+    g_queue_free_full(tests, migration_test_destroy);
 }
 
 #ifdef O_DIRECT
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index e73d69bab0..694773e594 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -59,5 +59,5 @@ void migration_test_add_suffix(const char *path, const char *suffix,
                                void (*fn)(char *name, MigrateCommon *args));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
-
+void migration_tests_free(void);
 #endif /* MIGRATION_UTIL_H */
-- 
2.51.0


