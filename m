Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601C606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R2LDMjvk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GC0mBJj+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GVhkgA6q;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=m/z8pywZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhJc-0000jP-Ov; Thu, 26 Nov 2026 16:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJK-0000i9-2A
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:22 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJH-0000ir-BO
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:21 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C0641FE0D;
 Thu, 26 Nov 2026 21:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGW9z4+wx9j3qY/dLrMFmhq4C65Q2Sh+kc3FzKpBoBs=;
 b=R2LDMjvkCn79fdidZIb+8EOMq6yvciXv924zzNlNyHXNxUzNDJ7vpmUUbEHf1CBV08OKNj
 B9w9lpRxK/Cj3ffohYI3KcJb3Xm7UbomAfHB/lmrNmryhT3KHYOKNYTu0Ra24LA/dvCE0A
 6hFu2/fif9nwtT7ZpbktRC6TwTAo9LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGW9z4+wx9j3qY/dLrMFmhq4C65Q2Sh+kc3FzKpBoBs=;
 b=GC0mBJj+/md2mYle3ZlHoBY+BaDqD5CtWg74JiX3pt94KlwyMV50dAE7R0sf9Xk+oZMyI5
 2fR3FpbY8IHV3JBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGW9z4+wx9j3qY/dLrMFmhq4C65Q2Sh+kc3FzKpBoBs=;
 b=GVhkgA6qSyvLWtTQOJCreFQVLD6lc0rjdkN1YmTJbgLIL9l1VUUX/q1Ls7UinN1fIRKDPn
 5B5B7XxPjmMR2FbvD7DjM3oABeMBLtwt4ynlEzhj+dFB3QQxkc3FFG9qvTIwK4Ug7HvRGA
 pxku9q+dtwL3itKvm/9NDeTljHED8ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGW9z4+wx9j3qY/dLrMFmhq4C65Q2Sh+kc3FzKpBoBs=;
 b=m/z8pywZxQUIsQwAnmgOa5NUQlNjbe3KsQdXauPKAS39v/18IDSimnRb5FWmr7OpSzLODO
 9jJWSin2B9vi9BCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3225A134C3;
 Thu, 26 Nov 2026 21:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3qzICtuoCGtRZgAAD6G6ig:T6
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 21:47:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: [PATCH 5/5] tests/qtest/migration: Make it possible to run stress.c
Date: Thu, 26 Nov 2026 18:47:04 -0300
Message-ID: <20261126214704.3108327-6-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126214704.3108327-1-farosas@suse.de>
References: <20261126214704.3108327-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Allow the code from tests/migration-stress/stress.c to be executed as
a guest workload for migration-test.

So far, the only workload that runs for all qtest migration-tests is a
loop over the guest memory that increments a byte on each page. It's
tailored to detect memory corruption and is specially useful for
testing ram migration.

The guestperf.py script uses another workload, stress.c, which is
similarly a loop that touches all memory pages. While still
artificial, the stress workload runs as an initrd paired with an
actual Linux kernel and could be more useful for detecting migration
issues in areas other than ram migration.

Add support for running stress.c in migration-test. Introduce the
environment variable QTEST_MIG_KERNEL to inform the kernel to be used
(guestperf takes the kernel from the running host). Change
bootfile_get_opts() to setup -kernel and -initrd.

The memory size for the guest is kept the same as guestperf.py: 1GB.

Since stress.c touches all memory that's provided to it, some extra
space needs to be allocated for the kernel use. (I tried to be precise
with this but could not reach the exact computation for the extra
space, so 300M is being added to avoid OOM.)

At bootfile_create(), either bootpath will be set, meaning the A-B
workload is to be used, or if the user set the new environment
variables, then kernel_path/initrd_path will be set. The rest of the
code tests boopath to know which workload is in use.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
Note: hugepages are not yet supported in the tests, this is coming in
a separate series. Depending on how it goes I can remove the HUGETLB
parts from this patch.
---
 tests/qtest/migration/bootfile.c       | 189 ++++++++++++++++++++++++-
 tests/qtest/migration/bootfile.h       |   5 +-
 tests/qtest/migration/cpr-tests.c      |  52 ++++++-
 tests/qtest/migration/framework.c      |  11 +-
 tests/qtest/migration/framework.h      |   2 +
 tests/qtest/migration/postcopy-tests.c |   6 +-
 tests/qtest/migration/precopy-tests.c  |  19 ++-
 7 files changed, 272 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index d40bd0c2d3e..2d14931c5fb 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "framework.h"
 #include "migration-util.h"
+#include "qemu/cutils.h"
 
 /*
  * The boot file modifies memory area in [start_address, end_address)
@@ -29,6 +30,8 @@ unsigned start_address;
 unsigned end_address;
 
 static char *bootpath;
+static char *kernelpath;
+static char *initrdpath;
 
 void bootfile_delete(void)
 {
@@ -38,14 +41,30 @@ void bootfile_delete(void)
     unlink(bootpath);
     g_free(bootpath);
     bootpath = NULL;
+
+    g_free(kernelpath);
+    kernelpath = NULL;
+
+    g_free(initrdpath);
+    initrdpath = NULL;
 }
 
-char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
+char *bootfile_create(const char *arch, const char *kernel,
+                      const char *dir, bool suspend_me)
 {
     unsigned char *content;
     size_t len;
 
     bootfile_delete();
+
+    if (kernel) {
+        kernelpath = g_strdup(kernel);
+        initrdpath = g_strdup("tests/migration-stress/initrd-stress.img");
+
+        g_test_message("Using guest workload \"stress.c\"");
+        return NULL;
+    }
+
     bootpath = g_strdup_printf("%s/bootsect", dir);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -85,14 +104,168 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
     g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
     fclose(bootfile);
 
+    g_test_message("Using guest workload \"A-B\"");
+
     return bootpath;
 }
 
-char *bootfile_get_opts(const char *arch, char **mem_size)
+/* assumes guest uses 4k */
+static uint64_t pgtables_size(long size_gb)
+{
+    uint64_t pgtb_size = 0, size_b = size_gb << 30;
+    uint64_t n_pages, ptrs_per_lvl;
+
+    n_pages = size_b >> 12;
+
+    ptrs_per_lvl = n_pages >> 21;
+    pgtb_size += ptrs_per_lvl ?: 1;
+
+    ptrs_per_lvl >>= 30;
+    pgtb_size += ptrs_per_lvl ?: 1;
+
+    ptrs_per_lvl >>= 39;
+    pgtb_size += ptrs_per_lvl ?: 1;
+
+    ptrs_per_lvl >>= 48;
+    pgtb_size += ptrs_per_lvl ?: 1;
+
+    pgtb_size <<= 12;
+
+    size_b += pgtb_size;
+    return size_b;
+}
+
+static uint64_t rsvd_size(long size_gb)
+{
+    uint64_t size_b;
+
+    /*
+     * 300M for kernel text, bss, percpu areas, etc. Rough
+     * approximation from what's reported in dmesg: "Memory:
+     * 2110788K/3145208K available (16384K kernel code, 2951K rwdata,
+     * 12716K rodata, 4088K init, 4672K bss, 177440K reserved, 0K
+     * cma-reserved)"
+     */
+    size_b = (300UL << 20);
+
+    size_b += pgtables_size(size_gb);
+
+    /* FIXME: init keeps being killed due to OOM, add an arbitrary 1/8 */
+    size_b += size_b >> 3;
+
+    return size_b;
+}
+
+/*
+ * Build the kernel command line options string to be passed to QEMU's
+ * -append option. Allow a few of the more useful kernel command line
+ * options to be replaced by the user setting the QTEST_MIG_APPEND
+ * environment variable. A few options are required and will be added
+ * automatically if not present on the user-provided string.
+ *
+ * Returns:
+ * default options + required options + user options
+ */
+static char *build_append_str(long ramsize, long cpus)
+{
+    bool add_ramsize, add_cpus, add_quiet;
+    const char *user_opts = getenv("QTEST_MIG_APPEND");
+    const char *default_opts = "noapic printk.time=1 noreplace-smp "
+        "cgroup_disable=memory pci=noearly console=ttyS0";
+    g_autofree char *required_opts = NULL;
+    g_autofree char *r1 = NULL;
+    g_autofree char *r2 = NULL;
+    g_autofree char *r3 = NULL;
+
+    if (user_opts) {
+        add_ramsize = !strstr(user_opts, "ramsize=");
+        add_cpus = !strstr(user_opts, "cpus=");
+        /* let them remove 'quiet' by omitting it from the env var */
+        add_quiet = false;
+    } else {
+        add_ramsize = add_cpus = add_quiet = true;
+    }
+
+    if (add_quiet) {
+        r1 = g_strdup("quiet ");
+    }
+
+    if (add_ramsize) {
+        r2 = g_strdup_printf("ramsize=%ld ", ramsize);
+    }
+
+    if (add_cpus) {
+        r3 = g_strdup_printf("cpus=%ld ", cpus);
+    }
+
+    required_opts = g_strconcat(r1 ?: "", r2 ?: "", r3 ?: "", NULL);
+
+    return g_strconcat(default_opts, required_opts, user_opts, NULL);
+}
+
+static char *bootfile_get_kernel_opts(const char *arch, int mem_type,
+                                      char **size_mb_str)
+{
+    const char *size_gb_str;
+    const char *smp;
+    long size_gb, n_vcpus;
+    uint64_t size_b;
+
+    assert(g_str_equal(arch, "x86_64"));
+    assert(kernelpath);
+    assert(initrdpath);
+
+    /*
+     * The default is 1GB / 1vcpu guest, but it can be overridden via
+     * env variables.
+     */
+    size_gb_str = getenv("QTEST_MIG_MEM_G");
+    smp = getenv("QTEST_MIG_SMP");
+
+    if (!smp) {
+        smp = "1";
+    }
+
+    if (!size_gb_str) {
+        size_gb_str = "1";
+    }
+
+    assert(!qemu_strtol(smp, NULL, 0, &n_vcpus));
+    assert(n_vcpus > 0 && n_vcpus <= 4096);
+
+    assert(!qemu_strtol(size_gb_str, NULL, 0, &size_gb));
+    assert(size_gb > 0 && size_gb <= 256000);
+
+    /*
+     * stress.c dirties all of "ramsize", increase the memory size to
+     * avoid OOM.
+     */
+    size_b = rsvd_size(size_gb);
+
+    /* Align to the next MB to not lose the fractional bytes. */
+    size_b = QEMU_ALIGN_UP(size_b, 1UL << 20);
+
+    if (mem_type == MEM_TYPE_HUGETLB) {
+        size_b = QEMU_ALIGN_UP(size_b, 1UL << 30);
+    }
+
+    *size_mb_str = g_strdup_printf("%ldM", size_b >> 20);
+
+    return g_strdup_printf(
+        "-smp %s -kernel %s -initrd %s -cpu host "
+        "-append '%s' ", smp, kernelpath, initrdpath,
+        build_append_str(size_gb, n_vcpus));
+}
+
+char *bootfile_get_opts(const char *arch, int mem_type, char **mem_size)
 {
     const char *memory_size;
     char *boot;
 
+    if (!bootpath) {
+        return bootfile_get_kernel_opts(arch, mem_type, mem_size);
+    }
+
     if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
         memory_size = "150M";
         boot = g_strdup_printf(
@@ -128,6 +301,10 @@ void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to)
     uint64_t marker_address = start_address + MAGIC_OFFSET;
     uint8_t watch_byte;
 
+    if (!bootpath) {
+        return;
+    }
+
     /*
      * Wait for the MAGIC_MARKER to get transferred, as an
      * indicator that a migration pass has made some known
@@ -158,6 +335,10 @@ void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to)
 
 void migrate_prepare_for_dirty_mem(QTestState *from)
 {
+    if (!bootpath) {
+        return;
+    }
+
     /*
      * The guest workflow iterates from start_address to
      * end_address, writing 1 byte every TEST_MEM_PAGE_SIZE
@@ -190,6 +371,10 @@ void migrate_check_guests_ram(QTestState *who)
     int bad = 0;
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
+    if (!bootpath) {
+        return;
+    }
+
     qtest_memread(who, start_address, &dest_byte_a, 1);
 
     /* Destination still running, wait for a byte to change */
diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index 4f628160f5d..a66105bc4a1 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -64,9 +64,10 @@
 
 #ifndef MIGRATION_GUEST_CODE
 void bootfile_delete(void);
-char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
+char *bootfile_create(const char *arch, const char *kernel,
+                      const char *dir, bool suspend_me);
 char *bootfile_get(void);
-char *bootfile_get_opts(const char *arch, char **memory_size);
+char *bootfile_get_opts(const char *arch, int mem_type, char **memory_size);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
 void migrate_check_guests_ram(QTestState *who);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 3c21b79001e..d4a50e8e564 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -172,6 +172,34 @@ static void test_mode_transfer_defer(char *name, MigrateCommon *args)
     test_mode_transfer_common(args, true, NULL);
 }
 
+static GStrv strv_concat(char **a, char **b, char **c, int max_len)
+{
+    /*
+     * We don't support g_strv_builder, so do a hacky pointer
+     * arithmetic. The arr only holds the pointers, the g_strdupv
+     * at the end is a deep copy.
+     */
+    g_autofree char **arr = g_new0(char *, max_len);
+    char **srcp, **dstp = arr;
+
+    /* +1 to skip the last element which is "" */
+    srcp = a;
+    while (*(srcp + 1)) {
+        *dstp++ = *srcp++;
+    }
+
+    *dstp++ = *b;
+
+    /* +1 to skip the first element which is "" */
+    srcp = c + 1;
+    while (*srcp) {
+        *dstp++ = *srcp++;
+    }
+
+    *dstp = NULL;
+    return (GStrv)g_strdupv(arr);
+}
+
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
 {
     g_autofree char *qtest_from_args = NULL;
@@ -209,8 +237,30 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
 
     exec_args = g_strconcat(qtest_qemu_binary(migration_get_env()->qemu_dst),
                             " -incoming defer ", from_str, NULL);
+
     argv = g_strsplit(exec_args, " ", -1);
-    migrate_set_parameter_strv(who, "cpr-exec-command", argv);
+
+    /*
+     * Handle the -append qemu option. QMP does the right thing if we
+     * pass it all the kernel options as a single string, no quotes.
+     */
+    if (strstr(exec_args, " -append ")) {
+        g_auto(GStrv) tmp = NULL;
+        g_auto(GStrv) head = NULL;
+        g_auto(GStrv) tail = NULL;
+        g_auto(GStrv) local_argv;
+        int max_len = g_strv_length(argv);
+
+        tmp = g_strsplit(exec_args, "'", -1);
+
+        head = g_strsplit(tmp[0], " ", -1);
+        tail = g_strsplit(tmp[2], " ", -1);
+
+        local_argv = strv_concat(head, &tmp[1], tail, max_len);
+        migrate_set_parameter_strv(who, "cpr-exec-command", local_argv);
+    } else {
+        migrate_set_parameter_strv(who, "cpr-exec-command", argv);
+    }
 }
 
 static void wait_for_migration_event(QTestState *who, const char *waitfor)
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 3bfa59a0fd5..2839217c94d 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -261,7 +261,7 @@ int migrate_args(char **from, char **to, MigrateStart *args)
     g_autofree char *memory_backend = NULL;
     const char *events;
 
-    boot_opts = bootfile_get_opts(arch, &memory_size);
+    boot_opts = bootfile_get_opts(arch, args->mem_type, &memory_size);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
 
@@ -454,6 +454,7 @@ static void migrate_mem_type_cleanup(MemType type)
 
 int migrate_start(QTestState **from, QTestState **to, MigrateStart *args)
 {
+    MigrationTestEnv *env = migration_get_env();
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
@@ -464,7 +465,7 @@ int migrate_start(QTestState **from, QTestState **to, MigrateStart *args)
 
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
-    bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
+    bootfile_create(qtest_get_arch(), env->kernel, tmpfs, args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
     if (migrate_args(&cmd_source, &cmd_target, args)) {
@@ -1063,6 +1064,12 @@ MigrationTestEnv *migration_get_env(void)
     env->arch = qtest_get_arch();
     env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
 
+    env->kernel = getenv("QTEST_MIG_KERNEL");
+    if (env->kernel && !g_str_equal(env->arch, "x86_64")) {
+        g_test_message("Kernel option only supported on x86_64");
+        exit(1);
+    }
+
     env->tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
     if (!env->tmpfs) {
         g_test_message("Can't create temporary directory in %s: %s",
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index df25d2a5830..06abd241d4a 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -38,6 +38,7 @@ typedef enum {
      * Use guest-memfd, shared mappings.
      */
     MEM_TYPE_GUEST_MEMFD,
+    MEM_TYPE_HUGETLB,
     MEM_TYPE_NUM,
 } MemType;
 
@@ -53,6 +54,7 @@ typedef struct MigrationTestEnv {
     const char *arch;
     const char *qemu_src;
     const char *qemu_dst;
+    const char *kernel;
     char *tmpfs;
 } MigrationTestEnv;
 
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 6c4fd311529..672dc8b247b 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -124,7 +124,11 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
                            test_multifd_postcopy_preempt);
         migration_test_add("/migration/multifd+postcopy/preempt/recovery/plain",
                            test_multifd_postcopy_preempt_recovery);
-        if (env->is_x86) {
+        /*
+         * TODO: The suspend test writes to the guest memory. That's not yet
+         * supported with a full kernel inside the guest.
+         */
+        if (env->is_x86 && !env->kernel) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
         }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index d57ffcac234..28b1476e9ae 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -805,7 +805,7 @@ static QTestState *dirtylimit_start_vm(void)
     g_autofree gchar *cmd = NULL;
     const char *bootpath;
 
-    bootpath = bootfile_create(qtest_get_arch(), tmpfs, false);
+    bootpath = bootfile_create(qtest_get_arch(), NULL, tmpfs, false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
@@ -1077,7 +1077,11 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
 
 static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
 {
-    if (env->is_x86) {
+    /*
+     * TODO: The suspend test writes to the guest memory. That's not yet
+     * supported with a full kernel inside the guest.
+     */
+    if (env->is_x86 && !env->kernel) {
         migration_test_add("/migration/precopy/unix/suspend/live",
                            test_precopy_unix_suspend_live);
         migration_test_add("/migration/precopy/unix/suspend/notlive",
@@ -1093,8 +1097,15 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_precopy_tcp_cancel);
     if (env->has_uffd) {
-        migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
-                           test_multifd_postcopy_tcp_cancel);
+        /*
+         * FIXME: Using a kernel requires disabling the dirty memory
+         * detection and shortens a race window which breaks this
+         * test. Skip it until the fix is merged.
+         */
+        if (!env->kernel) {
+            migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
+                               test_multifd_postcopy_tcp_cancel);
+        }
     }
 
 #ifdef CONFIG_RDMA
-- 
2.53.0


