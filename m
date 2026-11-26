Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04981606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FW3o1Tvd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BypG1r0d;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FW3o1Tvd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BypG1r0d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhJZ-0000iu-26; Thu, 26 Nov 2026 16:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJF-0000hb-PL
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJC-0000Ja-8L
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AB272283B;
 Thu, 26 Nov 2026 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+GmnFkIohooLqukNR7Ns8+/vT1O6BZG0CxIAfAsZpg=;
 b=FW3o1TvdAENpKFEjlANTWXvvnKdZlwMIzRHmMb7Y9POyWXhSmaeDQ26yRLJgAyjEP4MdzI
 nfqP/eA+vIT+hqn0vD5FkIC71WRtbmt3JmvhU/2sbDdTzU8rtiBArC8qBcWUy7hFAd7HR1
 H86D9Vb0i8rcC/tT5Wd/1Airp1HAgLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+GmnFkIohooLqukNR7Ns8+/vT1O6BZG0CxIAfAsZpg=;
 b=BypG1r0d+iuTp9G+m5zCe3oOEk8dN1R8eXiwjl/aGCF1eXdl3uz32ApUDavwphm0sJG4nt
 yi5v77YRe5nOqdBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+GmnFkIohooLqukNR7Ns8+/vT1O6BZG0CxIAfAsZpg=;
 b=FW3o1TvdAENpKFEjlANTWXvvnKdZlwMIzRHmMb7Y9POyWXhSmaeDQ26yRLJgAyjEP4MdzI
 nfqP/eA+vIT+hqn0vD5FkIC71WRtbmt3JmvhU/2sbDdTzU8rtiBArC8qBcWUy7hFAd7HR1
 H86D9Vb0i8rcC/tT5Wd/1Airp1HAgLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+GmnFkIohooLqukNR7Ns8+/vT1O6BZG0CxIAfAsZpg=;
 b=BypG1r0d+iuTp9G+m5zCe3oOEk8dN1R8eXiwjl/aGCF1eXdl3uz32ApUDavwphm0sJG4nt
 yi5v77YRe5nOqdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E75F134C3;
 Thu, 26 Nov 2026 21:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3qzICtuoCGtRZgAAD6G6ig:T4
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 21:47:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/5] tests/qtest/migration: Move guest workload code into
 bootfile.c
Date: Thu, 26 Nov 2026 18:47:02 -0300
Message-ID: <20261126214704.3108327-4-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126214704.3108327-1-farosas@suse.de>
References: <20261126214704.3108327-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
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

Move all the code related to the guest workload into bootfile.c in
preparation for adding a second type of workload.

Move to bootfile.c:

- start|end_address variables, used to iterate over the guest
  pages. Set them at bootfile_create() since they don't need to
  change.

- check_guests_ram function, used to check for memory
  corruption. Merge it with the adjacent code in migrate_end. Give it
  a migrate_ prefix now that it will be exported.

- migrate_prepare|wait_for_dirty_mem, the logic for monitoring guest
  memory dirtying. Move along the defines for the magic marker.

- the memory size and boot drive options. Change the bootfile_get()
  API to pass the options already assembled instead of passing only
  the bootpath.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/bootfile.c   | 166 ++++++++++++++++++++++++++-
 tests/qtest/migration/bootfile.h   |  20 ++++
 tests/qtest/migration/framework.c  | 176 ++---------------------------
 tests/qtest/migration/framework.h  |   2 -
 tests/qtest/migration/misc-tests.c |   1 +
 5 files changed, 196 insertions(+), 169 deletions(-)

diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index e46ad09de76..d40bd0c2d3e 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -11,6 +11,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "framework.h"
+#include "migration-util.h"
 
 /*
  * The boot file modifies memory area in [start_address, end_address)
@@ -23,6 +25,9 @@
 #include "ppc64/a-b-kernel.h"
 #include "s390x/a-b-bios.h"
 
+unsigned start_address;
+unsigned end_address;
+
 static char *bootpath;
 
 void bootfile_delete(void)
@@ -48,19 +53,29 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
         x86_bootsect[SYM_suspend_me - SYM_start] = suspend_me;
         content = x86_bootsect;
         len = sizeof(x86_bootsect);
+        start_address = X86_TEST_MEM_START;
+        end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         content = s390x_elf;
         len = sizeof(s390x_elf);
+        start_address = S390_TEST_MEM_START;
+        end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         content = ppc64_kernel;
         len = sizeof(ppc64_kernel);
+        start_address = PPC_TEST_MEM_START;
+        end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
         g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+        start_address = ARM_TEST_MEM_START;
+        end_address = ARM_TEST_MEM_END;
     } else if (strcmp(arch, "loongarch64") == 0) {
         content = loongarch64_kernel;
         len = sizeof(loongarch64_kernel);
+        start_address = LOONGARCH_TEST_MEM_START;
+        end_address = LOONGARCH_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
@@ -73,7 +88,154 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
     return bootpath;
 }
 
-char *bootfile_get(void)
+char *bootfile_get_opts(const char *arch, char **mem_size)
 {
-    return bootpath;
+    const char *memory_size;
+    char *boot;
+
+    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
+        memory_size = "150M";
+        boot = g_strdup_printf(
+            "-drive if=none,id=d0,file=%s,format=raw "
+            "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
+
+    } else if (g_str_equal(arch, "s390x")) {
+        memory_size = "128M";
+        boot = g_strdup_printf("-bios %s", bootpath);
+
+    } else if (g_str_equal(arch, "ppc64")) {
+        memory_size = "256M";
+        boot = g_strdup_printf("-bios %s", bootpath);
+
+    } else if (g_str_equal(arch, "aarch64")) {
+        memory_size = "150M";
+        boot = g_strdup_printf("-kernel %s", bootpath);
+
+    } else if (g_str_equal(arch, "loongarch64")) {
+        memory_size = "256M";
+        boot = g_strdup_printf("-bios %s", bootpath);
+    } else {
+        g_assert_not_reached();
+    }
+
+    *mem_size = g_strdup(memory_size);
+    return boot;
+}
+
+void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to)
+{
+    uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
+    uint64_t marker_address = start_address + MAGIC_OFFSET;
+    uint8_t watch_byte;
+
+    /*
+     * Wait for the MAGIC_MARKER to get transferred, as an
+     * indicator that a migration pass has made some known
+     * amount of progress.
+     */
+    do {
+        usleep(1000 * 10);
+    } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
+
+    /* If suspended, src only iterates once, and watch_byte may never change */
+    if (get_src()->suspend_me) {
+        return;
+    }
+
+    /*
+     * Now ensure that already transferred bytes are
+     * dirty again from the guest workload. Note the
+     * guest byte value will wrap around and by chance
+     * match the original watch_byte. This is harmless
+     * as we'll eventually see a different value if we
+     * keep watching
+     */
+    watch_byte = qtest_readb(from, watch_address);
+    do {
+        usleep(1000 * 10);
+    } while (qtest_readb(from, watch_address) == watch_byte);
+}
+
+void migrate_prepare_for_dirty_mem(QTestState *from)
+{
+    /*
+     * The guest workflow iterates from start_address to
+     * end_address, writing 1 byte every TEST_MEM_PAGE_SIZE
+     * bytes.
+     *
+     * IOW, if we write to mem at a point which is NOT
+     * a multiple of TEST_MEM_PAGE_SIZE, our write won't
+     * conflict with the migration workflow.
+     *
+     * We put in a marker here, that we'll use to determine
+     * when the data has been transferred to the dst.
+     */
+    qtest_writeq(from, start_address + MAGIC_OFFSET, MAGIC_MARKER);
+}
+
+void migrate_check_guests_ram(QTestState *who)
+{
+    /*
+     * Our ASM test will have been incrementing one byte from each page from
+     * start_address to < end_address in order. This gives us a constraint
+     * that any page's byte should be equal or less than the previous pages
+     * byte (mod 256); and they should all be equal except for one transition
+     * at the point where we meet the incrementer. (We're running this with
+     * the guest stopped).
+     */
+    unsigned address;
+    uint8_t first_byte;
+    uint8_t last_byte;
+    bool hit_edge = false;
+    int bad = 0;
+    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
+
+    qtest_memread(who, start_address, &dest_byte_a, 1);
+
+    /* Destination still running, wait for a byte to change */
+    do {
+        qtest_memread(who, start_address, &dest_byte_b, 1);
+        usleep(1000 * 10);
+    } while (dest_byte_a == dest_byte_b);
+
+    qtest_qmp_assert_success(who, "{ 'execute' : 'stop'}");
+
+    /* With it stopped, check nothing changes */
+    qtest_memread(who, start_address, &dest_byte_c, 1);
+    usleep(1000 * 200);
+    qtest_memread(who, start_address, &dest_byte_d, 1);
+    g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
+
+    qtest_memread(who, start_address, &first_byte, 1);
+    last_byte = first_byte;
+
+    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
+         address += TEST_MEM_PAGE_SIZE)
+    {
+        uint8_t b;
+        qtest_memread(who, address, &b, 1);
+        if (b != last_byte) {
+            if (((b + 1) % 256) == last_byte && !hit_edge) {
+                /*
+                 * This is OK, the guest stopped at the point of
+                 * incrementing the previous page but didn't get
+                 * to us yet.
+                 */
+                hit_edge = true;
+                last_byte = b;
+            } else {
+                bad++;
+                if (bad <= 10) {
+                    fprintf(stderr, "Memory content inconsistency at %x"
+                            " first_byte = %x last_byte = %x current = %x"
+                            " hit_edge = %x\n",
+                            address, first_byte, last_byte, b, hit_edge);
+                }
+            }
+        }
+    }
+    if (bad >= 10) {
+        fprintf(stderr, "and in another %d pages", bad - 10);
+    }
+    g_assert(bad == 0);
 }
diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index a4060ea4f72..4f628160f5d 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -15,11 +15,27 @@
  */
 #ifdef __ASSEMBLER__
 #define MIGRATION_GUEST_CODE
+#else
+#include "libqtest.h"
 #endif
 
 /* Common */
 #define TEST_MEM_PAGE_SIZE 4096
 
+/*
+ * An initial 3 MB offset is used as that corresponds
+ * to ~1 sec of data transfer with our bandwidth setting.
+ */
+#define MAGIC_OFFSET_BASE (3 * 1024 * 1024)
+/*
+ * A further 1k is added to ensure we're not a multiple
+ * of TEST_MEM_PAGE_SIZE, thus avoid clash with writes
+ * from the migration guest workload.
+ */
+#define MAGIC_OFFSET_SHUFFLE 1024
+#define MAGIC_OFFSET (MAGIC_OFFSET_BASE + MAGIC_OFFSET_SHUFFLE)
+#define MAGIC_MARKER 0xFEED12345678CAFEULL
+
 /* x86 */
 #define X86_TEST_MEM_START (1 * 1024 * 1024)
 #define X86_TEST_MEM_END   (100 * 1024 * 1024)
@@ -50,6 +66,10 @@
 void bootfile_delete(void);
 char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
 char *bootfile_get(void);
+char *bootfile_get_opts(const char *arch, char **memory_size);
+void migrate_prepare_for_dirty_mem(QTestState *from);
+void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
+void migrate_check_guests_ram(QTestState *who);
 #endif
 
 #endif /* BOOTFILE_H */
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b7aef6b21cb..a081c8e7bb9 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -36,27 +36,10 @@
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 #define MULTIFD_TEST_CHANNELS 4
 
-unsigned start_address;
-unsigned end_address;
 static QTestMigrationState src_state;
 static QTestMigrationState dst_state;
 static char *tmpfs;
 
-/*
- * An initial 3 MB offset is used as that corresponds
- * to ~1 sec of data transfer with our bandwidth setting.
- */
-#define MAGIC_OFFSET_BASE (3 * 1024 * 1024)
-/*
- * A further 1k is added to ensure we're not a multiple
- * of TEST_MEM_PAGE_SIZE, thus avoid clash with writes
- * from the migration guest workload.
- */
-#define MAGIC_OFFSET_SHUFFLE 1024
-#define MAGIC_OFFSET (MAGIC_OFFSET_BASE + MAGIC_OFFSET_SHUFFLE)
-#define MAGIC_MARKER 0xFEED12345678CAFEULL
-
-
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -92,108 +75,6 @@ void wait_for_serial(const char *side)
     } while (true);
 }
 
-void migrate_prepare_for_dirty_mem(QTestState *from)
-{
-    /*
-     * The guest workflow iterates from start_address to
-     * end_address, writing 1 byte every TEST_MEM_PAGE_SIZE
-     * bytes.
-     *
-     * IOW, if we write to mem at a point which is NOT
-     * a multiple of TEST_MEM_PAGE_SIZE, our write won't
-     * conflict with the migration workflow.
-     *
-     * We put in a marker here, that we'll use to determine
-     * when the data has been transferred to the dst.
-     */
-    qtest_writeq(from, start_address + MAGIC_OFFSET, MAGIC_MARKER);
-}
-
-void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to)
-{
-    uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
-    uint64_t marker_address = start_address + MAGIC_OFFSET;
-    uint8_t watch_byte;
-
-    /*
-     * Wait for the MAGIC_MARKER to get transferred, as an
-     * indicator that a migration pass has made some known
-     * amount of progress.
-     */
-    do {
-        usleep(1000 * 10);
-    } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
-
-
-    /* If suspended, src only iterates once, and watch_byte may never change */
-    if (src_state.suspend_me) {
-        return;
-    }
-
-    /*
-     * Now ensure that already transferred bytes are
-     * dirty again from the guest workload. Note the
-     * guest byte value will wrap around and by chance
-     * match the original watch_byte. This is harmless
-     * as we'll eventually see a different value if we
-     * keep watching
-     */
-    watch_byte = qtest_readb(from, watch_address);
-    do {
-        usleep(1000 * 10);
-    } while (qtest_readb(from, watch_address) == watch_byte);
-}
-
-static void check_guests_ram(QTestState *who)
-{
-    /*
-     * Our ASM test will have been incrementing one byte from each page from
-     * start_address to < end_address in order. This gives us a constraint
-     * that any page's byte should be equal or less than the previous pages
-     * byte (mod 256); and they should all be equal except for one transition
-     * at the point where we meet the incrementer. (We're running this with
-     * the guest stopped).
-     */
-    unsigned address;
-    uint8_t first_byte;
-    uint8_t last_byte;
-    bool hit_edge = false;
-    int bad = 0;
-
-    qtest_memread(who, start_address, &first_byte, 1);
-    last_byte = first_byte;
-
-    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
-         address += TEST_MEM_PAGE_SIZE)
-    {
-        uint8_t b;
-        qtest_memread(who, address, &b, 1);
-        if (b != last_byte) {
-            if (((b + 1) % 256) == last_byte && !hit_edge) {
-                /*
-                 * This is OK, the guest stopped at the point of
-                 * incrementing the previous page but didn't get
-                 * to us yet.
-                 */
-                hit_edge = true;
-                last_byte = b;
-            } else {
-                bad++;
-                if (bad <= 10) {
-                    fprintf(stderr, "Memory content inconsistency at %x"
-                            " first_byte = %x last_byte = %x current = %x"
-                            " hit_edge = %x\n",
-                            address, first_byte, last_byte, b, hit_edge);
-                }
-            }
-        }
-    }
-    if (bad >= 10) {
-        fprintf(stderr, "and in another %d pages", bad - 10);
-    }
-    g_assert(bad == 0);
-}
-
 static void cleanup(const char *filename)
 {
     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, filename);
@@ -319,60 +200,41 @@ int migrate_args(char **from, char **to, MigrateStart *args)
 {
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
+    g_autofree gchar *boot_opts = NULL;
     gchar *cmd_source = NULL;
     gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
     g_autofree char *mem_object = NULL;
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
-    const char *memory_size;
+    g_autofree char *memory_size = NULL;
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
-    const char *bootpath = bootfile_get();
     g_autofree char *memory_backend = NULL;
     const char *events;
 
+    boot_opts = bootfile_get_opts(arch, &memory_size);
+
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        memory_size = "150M";
 
         if (g_str_equal(arch, "i386")) {
             machine_alias = "pc";
         } else {
             machine_alias = "q35";
         }
-        arch_opts = g_strdup_printf(
-            "-drive if=none,id=d0,file=%s,format=raw "
-            "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
-        start_address = X86_TEST_MEM_START;
-        end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
-        memory_size = "128M";
         machine_alias = "s390-ccw-virtio";
-        arch_opts = g_strdup_printf("-bios %s", bootpath);
-        start_address = S390_TEST_MEM_START;
-        end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
-        memory_size = "256M";
-        start_address = PPC_TEST_MEM_START;
-        end_address = PPC_TEST_MEM_END;
         machine_alias = "pseries";
         machine_opts = "vsmt=8";
         arch_opts = g_strdup_printf(
-            "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES " "
-            "-bios %s", bootpath);
+            "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES);
     } else if (strcmp(arch, "aarch64") == 0) {
-        memory_size = "150M";
         machine_alias = "virt";
         machine_opts = "gic-version=3";
-        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
-        start_address = ARM_TEST_MEM_START;
-        end_address = ARM_TEST_MEM_END;
+        arch_opts = g_strdup_printf("-cpu max");
     } else if (strcmp(arch, "loongarch64") == 0) {
-        memory_size = "256M";
         machine_alias = "virt";
-        arch_opts = g_strdup_printf("-bios %s", bootpath);
-        start_address = LOONGARCH_TEST_MEM_START;
-        end_address = LOONGARCH_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
@@ -416,10 +278,11 @@ int migrate_args(char **from, char **to, MigrateStart *args)
                                  "-name source,debug-threads=on "
                                  "%s "
                                  "-serial file:%s/src_serial "
-                                 "%s %s %s",
+                                 "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs,
+                                 boot_opts ? boot_opts : "",
                                  arch_opts ? arch_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
@@ -437,11 +300,12 @@ int migrate_args(char **from, char **to, MigrateStart *args)
                                  "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming defer "
-                                 "%s %s %s %s",
+                                 "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs,
                                  events,
+                                 boot_opts ? boot_opts : "",
                                  arch_opts ? arch_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
@@ -584,28 +448,10 @@ int migrate_start(QTestState **from, QTestState **to, MigrateStart *args)
 
 void migrate_end(QTestState *from, QTestState *to, bool test_dest)
 {
-    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
-
     qtest_quit(from);
 
     if (test_dest) {
-        qtest_memread(to, start_address, &dest_byte_a, 1);
-
-        /* Destination still running, wait for a byte to change */
-        do {
-            qtest_memread(to, start_address, &dest_byte_b, 1);
-            usleep(1000 * 10);
-        } while (dest_byte_a == dest_byte_b);
-
-        qtest_qmp_assert_success(to, "{ 'execute' : 'stop'}");
-
-        /* With it stopped, check nothing changes */
-        qtest_memread(to, start_address, &dest_byte_c, 1);
-        usleep(1000 * 200);
-        qtest_memread(to, start_address, &dest_byte_d, 1);
-        g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
-
-        check_guests_ram(to);
+        migrate_check_guests_ram(to);
     }
 
     qtest_quit(to);
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 10761f6e287..df25d2a5830 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -230,8 +230,6 @@ typedef struct {
 } MigrateCommon;
 
 void wait_for_serial(const char *side);
-void migrate_prepare_for_dirty_mem(QTestState *from);
-void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
 
 int migrate_args(char **from, char **to, MigrateStart *args);
 int migrate_start(QTestState **from, QTestState **to, MigrateStart *args);
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 4e0deb7f188..370062db2a7 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qobject/qjson.h"
 #include "libqtest.h"
+#include "migration/bootfile.h"
 #include "migration/framework.h"
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
-- 
2.53.0


