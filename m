Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BC606A32D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tpyI/kKc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0EY0T/SJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tpyI/kKc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0EY0T/SJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhJK-0000iJ-Qg; Thu, 26 Nov 2026 16:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJF-0000hc-Qo
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJD-0000Qc-Ty
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C540B2283D;
 Thu, 26 Nov 2026 21:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5MlGXrPbTCT9eaFrpJi4zE85cvQYuh9dveEG7wpC/4=;
 b=tpyI/kKcJE1B/FV/Kd7FH7rojuOs/KXsQuPw5CA8/d7ChPO6ehX38mZA1jAE5kPyQbTl6u
 jIAt8gUQ6p3jcuJcfhIfZXVEVECGUtuEZkpz13XIkUrIw0EPM5dZRaUsVoa4PtvGkOFOmh
 XhRYJ4Jv1uKidhNLcT/Fh4Zid5i1Aeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5MlGXrPbTCT9eaFrpJi4zE85cvQYuh9dveEG7wpC/4=;
 b=0EY0T/SJM7efr5gf+PzkOwZPGbE7Y9UZnMi7pBYUBSbwNMxKeq9UJurdP72rLuHtSspLGi
 NNMfCeva0QQCvbCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5MlGXrPbTCT9eaFrpJi4zE85cvQYuh9dveEG7wpC/4=;
 b=tpyI/kKcJE1B/FV/Kd7FH7rojuOs/KXsQuPw5CA8/d7ChPO6ehX38mZA1jAE5kPyQbTl6u
 jIAt8gUQ6p3jcuJcfhIfZXVEVECGUtuEZkpz13XIkUrIw0EPM5dZRaUsVoa4PtvGkOFOmh
 XhRYJ4Jv1uKidhNLcT/Fh4Zid5i1Aeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5MlGXrPbTCT9eaFrpJi4zE85cvQYuh9dveEG7wpC/4=;
 b=0EY0T/SJM7efr5gf+PzkOwZPGbE7Y9UZnMi7pBYUBSbwNMxKeq9UJurdP72rLuHtSspLGi
 NNMfCeva0QQCvbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 625B2134C3;
 Thu, 26 Nov 2026 21:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3qzICtuoCGtRZgAAD6G6ig:T5
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 21:47:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/5] tests/qtest/migration: Adapt wait_for_serial routine for
 stress.c
Date: Thu, 26 Nov 2026 18:47:03 -0300
Message-ID: <20261126214704.3108327-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126214704.3108327-1-farosas@suse.de>
References: <20261126214704.3108327-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.80
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

The wait_for_serial routine currently only supports matching against
the A-B workload, i.e. it only accepts the 'A' character and the 'B'
character.

In preparation for adding tests/migration-stress/stress.c as an
alternative guest workload for migration-test, change
wait_for_serial() to check for the strings produced by stress.c. Also
check for output from a Linux kernel such as panics and allow running
without 'quiet', for debugging.

No change intended for the default workload.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 90 +++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a081c8e7bb9..3bfa59a0fd5 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -41,38 +41,86 @@ static QTestMigrationState dst_state;
 static char *tmpfs;
 
 /*
- * Wait for some output in the serial output file,
- * we get an 'A' followed by an endless string of 'B's
- * but on the destination we won't have the A (unless we enabled suspend/resume)
+ * Wait for some output in the serial output file, we get a so called
+ * "A" pattern followed by a endless string of the so called "B"
+ * pattern. On the destination we won't have the A (unless we enabled
+ * suspend/resume). Depending on the guest code being used, the
+ * patterns are different:
+ *
+ * For bootfile.c:
+ * A='A'
+ * B='B'
+ *
+ * For stress.c:
+ * A="/init (<tid>): INFO: RAM # GiB across # CPUs"
+ * B="/init (<tid>): INFO: #ms copied # GB in #ms"
  */
 void wait_for_serial(const char *side)
 {
     g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
     FILE *serialfile = fopen(serialpath, "r");
+    char buf[128];
+    int i = 0;
+    const char *a_b[] = { "AB", "ABB", "ABBB", "B", "BB", "BBB", "BBBB" };
+    const char *stress[] = { "/init (", ": INFO: RAM" };
+    const char *skip[] = { "[", "]" };
+    const char *bad[] = { "panic+", "Code:", "BUG:" };
 
-    do {
-        int readvalue = fgetc(serialfile);
+    for (;;) {
 
-        switch (readvalue) {
-        case 'A':
-            /* Fine */
-            break;
+        if (!fgets(buf, 128, serialfile)) {
+            int c = fgetc(serialfile);
 
-        case 'B':
-            /* It's alive! */
-            fclose(serialfile);
-            return;
+            if (c == EOF) {
+                usleep(1000);
+                fseek(serialfile, 0, SEEK_SET);
+                continue;
+            }
+        }
+
+        /* look for the main patterns */
+        i = 0;
+        while (i < ARRAY_SIZE(a_b)) {
+            if (g_str_equal(buf, a_b[i++])) {
+                goto found;
+            }
+        }
+
+        i = 0;
+        while (i < ARRAY_SIZE(stress)) {
+            if (strstr(buf, stress[i++])) {
+                goto found;
+            }
+        }
 
-        case EOF:
-            fseek(serialfile, 0, SEEK_SET);
-            usleep(1000);
-            break;
+        /*
+         * Look for the stress.c patterns: dmesg lines when 'quiet' is
+         * not used in the kernel cmdline or kernel panic messages.
+         */
 
-        default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
-            g_assert_not_reached();
+        i = 0;
+        while (i < ARRAY_SIZE(bad)) {
+            if (strstr(buf, bad[i++])) {
+                goto err;
+            }
         }
-    } while (true);
+
+        i = 0;
+        while (i < ARRAY_SIZE(skip)) {
+            if (strstr(buf, skip[i++])) {
+                break;
+            }
+        }
+        usleep(1000);
+    }
+
+err:
+    fprintf(stderr, "Unexpected string on %s: %s\n", side, buf);
+    fclose(serialfile);
+    g_assert_not_reached();
+
+found:
+    fclose(serialfile);
 }
 
 static void cleanup(const char *filename)
-- 
2.53.0


