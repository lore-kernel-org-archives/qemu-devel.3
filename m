Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD50EC1449
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQ34-0003P0-Un; Tue, 03 Mar 2026 08:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxQ33-0003Os-RQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:44:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxQ31-0001OM-Ig
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:44:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C127F3F7F2;
 Tue,  3 Mar 2026 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772545444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tGonAeDe2b7I3VQ7EDQZfqIbH3fBzOO/S2hixyrBN4=;
 b=uyVNn1M9jN64LjaMUxoWDB3TcfgXZK1MyafnL5ufuiVYlyn0UI+55FKlSwr5dCdrWT+vtC
 3Sw3X1ndso9OM8ch4h85kRTO9KmTq/gHHYcglKTr/BHjD9UCmLTMgnZFkXsTZvIykIcKiG
 51G/YfRIe5HnYMNpm06B6l6RYqhBOrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772545444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tGonAeDe2b7I3VQ7EDQZfqIbH3fBzOO/S2hixyrBN4=;
 b=3/QXZWLvoaNgRfout1VwDVM2MzXXdzip15dhc/vNBXNzC5feh0I9bnaDolg8CBlvZwIPKe
 iHHy5jK0AIksbBBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uyVNn1M9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3/QXZWLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772545444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tGonAeDe2b7I3VQ7EDQZfqIbH3fBzOO/S2hixyrBN4=;
 b=uyVNn1M9jN64LjaMUxoWDB3TcfgXZK1MyafnL5ufuiVYlyn0UI+55FKlSwr5dCdrWT+vtC
 3Sw3X1ndso9OM8ch4h85kRTO9KmTq/gHHYcglKTr/BHjD9UCmLTMgnZFkXsTZvIykIcKiG
 51G/YfRIe5HnYMNpm06B6l6RYqhBOrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772545444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tGonAeDe2b7I3VQ7EDQZfqIbH3fBzOO/S2hixyrBN4=;
 b=3/QXZWLvoaNgRfout1VwDVM2MzXXdzip15dhc/vNBXNzC5feh0I9bnaDolg8CBlvZwIPKe
 iHHy5jK0AIksbBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D0613EA69;
 Tue,  3 Mar 2026 13:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aERAGKLlpmlXYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 13:44:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v3 5/5] tests/functional/ppc64/pseries: Remove custom
 migration routine
Date: Tue,  3 Mar 2026 10:43:48 -0300
Message-ID: <20260303134348.8890-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303134348.8890-1-farosas@suse.de>
References: <20260303134348.8890-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linux.ibm.com,redhat.com,gmail.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: C127F3F7F2
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

Don't implement a custom migration routine at PpcMigrationTest and
instead reuse the generic one from MigrationTest.

This removes the dependency of PpcMigrationTest from
PseriesMachine. Having one test import another causes unittest code to
instantiate the imported test, resulting in the setup and teardown
methods being invoked for the imported test class, even if no test
from that class will be executed.

If run in parallel, the extra setup/teardown methods that result from
importing can race with the ones from the actual test being executed
and cause the following error:

File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
shutil.rmtree(self.workdir)
...
FileNotFoundError: [Errno 2] No such file or directory:
'<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'

Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
Reported-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/functional/migration.py            |  5 +++++
 tests/functional/ppc64/test_migration.py | 11 -----------
 tests/functional/ppc64/test_pseries.py   |  4 ++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 49347a30bb..e995328e83 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -65,6 +65,11 @@ def _get_free_port(self, ports):
             self.skipTest('Failed to find a free port')
         return port
 
+    def migration_with_tcp_localhost_vms(self, dst_vm, src_vm):
+        with Ports() as ports:
+            uri = 'tcp:localhost:%u' % self._get_free_port(ports)
+            self.migrate_vms(uri, uri, dst_vm, src_vm)
+
     def migration_with_tcp_localhost(self):
         with Ports() as ports:
             dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
index a3b819680b..7d49ee175b 100755
--- a/tests/functional/ppc64/test_migration.py
+++ b/tests/functional/ppc64/test_migration.py
@@ -22,17 +22,6 @@ def test_migration_with_exec(self):
         self.set_machine('mac99')
         self.migration_with_exec()
 
-    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
-        with Ports() as ports:
-            port = ports.find_free_port()
-            if port is None:
-                self.skipTest('Failed to find a free port')
-            uri = 'tcp:localhost:%u' % port
-
-            dest_vm.qmp('migrate-incoming', uri=uri)
-            source_vm.qmp('migrate', uri=uri)
-            self.assert_migration(source_vm, dest_vm)
-
 
 if __name__ == '__main__':
     MigrationTest.main()
diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
index ce39e16a22..7373ca1647 100755
--- a/tests/functional/ppc64/test_pseries.py
+++ b/tests/functional/ppc64/test_pseries.py
@@ -9,7 +9,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from test_migration import PpcMigrationTest
+from migration import MigrationTest
 
 class PseriesMachine(MigrationTest):
 
@@ -116,7 +116,7 @@ def test_ppc64_linux_migration(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message,
                                  vm=source_vm)
 
-        self.do_migrate_ppc64_linux(source_vm, dest_vm);
+        self.migration_with_tcp_localhost_vms(dest_vm, source_vm);
 
         # ensure the boot proceeds after migration
         wait_for_console_pattern(self, self.good_message, self.panic_message,
-- 
2.51.0


