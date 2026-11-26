Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B1606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lr5AA1Pa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z8B1Q4T7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lr5AA1Pa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z8B1Q4T7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhJU-0000if-50; Thu, 26 Nov 2026 16:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJD-0000h9-JU
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:15 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xWhJB-0000Dn-Kw
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:47:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EF1B2282D;
 Thu, 26 Nov 2026 21:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esexrgAySePlCg8wCqSubGvjmvFwnGtdVWX+RATGNUM=;
 b=lr5AA1PaQXlTlg5ne3r2UdI41R494POYEzIVPHMljVic4lMDpt/EtdcVZSpBQTM2pX9CN4
 t5yqLmmOx2SuQsM26pPBN8uIpEXT1nypA0V5Ujc/atNgLWFRnArVCZ3PBRI/4mG5eKF2TV
 BPszKCloJaraLYH1LfW629+Uke8rUr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esexrgAySePlCg8wCqSubGvjmvFwnGtdVWX+RATGNUM=;
 b=Z8B1Q4T76TtBlr3HJk1pXDL7iiwlatGf95QE9HHCdMPty7TDVuBknd9dntiwJfZidyoROk
 y43yIoDrFu87GLBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lr5AA1Pa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z8B1Q4T7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795729631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esexrgAySePlCg8wCqSubGvjmvFwnGtdVWX+RATGNUM=;
 b=lr5AA1PaQXlTlg5ne3r2UdI41R494POYEzIVPHMljVic4lMDpt/EtdcVZSpBQTM2pX9CN4
 t5yqLmmOx2SuQsM26pPBN8uIpEXT1nypA0V5Ujc/atNgLWFRnArVCZ3PBRI/4mG5eKF2TV
 BPszKCloJaraLYH1LfW629+Uke8rUr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795729631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esexrgAySePlCg8wCqSubGvjmvFwnGtdVWX+RATGNUM=;
 b=Z8B1Q4T76TtBlr3HJk1pXDL7iiwlatGf95QE9HHCdMPty7TDVuBknd9dntiwJfZidyoROk
 y43yIoDrFu87GLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 468F7134C3;
 Thu, 26 Nov 2026 21:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3qzICtuoCGtRZgAAD6G6ig:T3
 (envelope-from <farosas@suse.de>); Thu, 26 Nov 2026 21:47:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/5] tests/migration-stress: Cleanups to stress.c
Date: Thu, 26 Nov 2026 18:47:01 -0300
Message-ID: <20261126214704.3108327-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126214704.3108327-1-farosas@suse.de>
References: <20261126214704.3108327-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: 3EF1B2282D
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

- brackets in all branches
- use snake_case
- inverted christmas tree variable declaration
- fix coding style of comments
- use a 'for' in the infinite loop (easier to read)
- tweaks to comments
- increment n_mb inline

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/migration-stress/stress.c | 109 ++++++++++++++++----------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/tests/migration-stress/stress.c b/tests/migration-stress/stress.c
index 44db4bef8f0..3d8cb8984b7 100644
--- a/tests/migration-stress/stress.c
+++ b/tests/migration-stress/stress.c
@@ -49,20 +49,19 @@ static __attribute__((noreturn)) void exit_failure(void)
     }
 }
 
-static int get_command_arg_str(const char *name,
-                               char **val)
+static int get_command_arg_str(const char *name, char **val)
 {
     static char line[1024];
     FILE *fp = fopen("/proc/cmdline", "r");
     char *start, *end;
 
-    if (fp == NULL) {
+    if (!fp) {
         fprintf(stderr, "%s (%05d): ERROR: cannot open /proc/cmdline: %s\n",
                 argv0, gettid(), strerror(errno));
         return -1;
     }
 
-    if (!fgets(line, sizeof line, fp)) {
+    if (!fgets(line, sizeof(line), fp)) {
         fprintf(stderr, "%s (%05d): ERROR: cannot read /proc/cmdline: %s\n",
                 argv0, gettid(), strerror(errno));
         fclose(fp);
@@ -71,37 +70,38 @@ static int get_command_arg_str(const char *name,
     fclose(fp);
 
     start = strstr(line, name);
-    if (!start)
+    if (!start) {
         return 0;
+    }
 
     start += strlen(name);
 
     if (*start != '=') {
-        fprintf(stderr, "%s (%05d): ERROR: no value provided for '%s' in /proc/cmdline\n",
-                argv0, gettid(), name);
+        fprintf(stderr, "%s (%05d): ERROR: no value provided for '%s' "
+                "in /proc/cmdline\n", argv0, gettid(), name);
     }
     start++;
 
     end = strstr(start, " ");
-    if (!end)
+    if (!end) {
         end = strstr(start, "\n");
+    }
 
     if (end == start) {
-        fprintf(stderr, "%s (%05d): ERROR: no value provided for '%s' in /proc/cmdline\n",
-                argv0, gettid(), name);
+        fprintf(stderr, "%s (%05d): ERROR: no value provided for '%s' "
+                "in /proc/cmdline\n", argv0, gettid(), name);
         return -1;
     }
 
-    if (end)
+    if (end) {
         *val = g_strndup(start, end - start);
-    else
+    } else {
         *val = g_strdup(start);
+    }
     return 1;
 }
 
-
-static int get_command_arg_ull(const char *name,
-                               unsigned long long *val)
+static int get_command_arg_ull(const char *name, unsigned long long *val)
 {
     char *valstr;
     char *end;
@@ -146,7 +146,6 @@ static int random_bytes(char *buf, size_t len)
     return 0;
 }
 
-
 static unsigned long long now(void)
 {
     struct timeval tv;
@@ -176,69 +175,68 @@ static inline void xor_1M(void *ram_start, void *data_page)
     }
 }
 
-static void stressone(unsigned long long ramsizeMB)
+static void stress_one(unsigned long long ramsize_mb)
 {
-    g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
-    size_t i;
-    g_autofree char *data = g_malloc(RAM_PAGE_SIZE);
-    size_t nMB = 0;
+    g_autofree char *ram_start = g_malloc(ramsize_mb * 1024 * 1024);
+    g_autofree char *data_page = g_malloc(RAM_PAGE_SIZE);
     unsigned long long before, after;
+    int i, n_mb = 0;
 
-    /* We don't care about initial state, but we do want
+    /*
+     * init ram: We don't care about initial state, but we do want
      * to fault it all into RAM, otherwise the first iter
      * of the loop below will be quite slow. We can't use
      * 0x0 as the byte as gcc optimizes that away into a
-     * calloc instead :-) */
-    memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
+     * calloc instead :-)
+     */
+    memset(ram_start, 0xfe, ramsize_mb * 1024 * 1024);
 
-    if (random_bytes(data, RAM_PAGE_SIZE) < 0) {
+    /* init data: write a page of garbage */
+    if (random_bytes(data_page, RAM_PAGE_SIZE) < 0) {
         return;
     }
 
     before = now();
 
-    while (1) {
-        for (i = 0; i < ramsizeMB; i++) {
-            xor_1M(ram, data);
-            nMB++;
+    for (;;) {
+        for (i = 0; i < ramsize_mb; i++) {
+            xor_1M(ram_start, data_page);
 
-            if (nMB == 1024) {
+            if (++n_mb == 1024) {
                 after = now();
                 fprintf(stderr, "%s (%05d): INFO: %06llums copied 1 GB in %05llums\n",
                         argv0, gettid(), after, after - before);
                 before = now();
-                nMB = 0;
+                n_mb = 0;
             }
         }
     }
 }
 
-
-static void *stressthread(void *arg)
+static void *stress_thread(void *arg)
 {
-    unsigned long long ramsizeMB = *(unsigned long long *)arg;
+    unsigned long long ramsize_mb = *(unsigned long long *)arg;
 
-    stressone(ramsizeMB);
+    stress_one(ramsize_mb);
 
     return NULL;
 }
 
-static void stress(unsigned long long ramsizeGB, int ncpus)
+static void stress(unsigned long long ramsize_gb, int n_cpus)
 {
     size_t i;
-    unsigned long long ramsizeMB = ramsizeGB * 1024 / ncpus;
-    ncpus--;
+    unsigned long long ramsize_mb = ramsize_gb * 1024 / n_cpus;
 
-    for (i = 0; i < ncpus; i++) {
+    n_cpus--;
+
+    for (i = 0; i < n_cpus; i++) {
         pthread_t thr;
-        pthread_create(&thr, NULL,
-                       stressthread,   &ramsizeMB);
+        pthread_create(&thr, NULL, stress_thread, &ramsize_mb);
     }
 
-    stressone(ramsizeMB);
+    stress_one(ramsize_mb);
 }
 
-
 static int mount_misc(const char *fstype, const char *dir)
 {
     if (g_mkdir_with_parents(dir, 0755) < 0 && errno != EEXIST) {
@@ -271,7 +269,7 @@ static int mount_all(void)
 
 int main(int argc, char **argv)
 {
-    unsigned long long ramsizeGB = 1;
+    unsigned long long ramsize_gb = 1;
     char *end;
     int ch;
     int opt_ind = 0;
@@ -283,7 +281,7 @@ int main(int argc, char **argv)
         { NULL, 0, NULL, 0 }
     };
     int ret;
-    int ncpus = 0;
+    int n_cpus = 0;
 
     argv0 = argv[0];
 
@@ -291,7 +289,7 @@ int main(int argc, char **argv)
         switch (ch) {
         case 'r':
             errno = 0;
-            ramsizeGB = strtoll(optarg, &end, 10);
+            ramsize_gb = strtoll(optarg, &end, 10);
             if (errno != 0 || *end) {
                 fprintf(stderr, "%s (%05d): ERROR: Cannot parse RAM size %s\n",
                         argv0, gettid(), optarg);
@@ -301,7 +299,7 @@ int main(int argc, char **argv)
 
         case 'c':
             errno = 0;
-            ncpus = strtoll(optarg, &end, 10);
+            n_cpus = strtoll(optarg, &end, 10);
             if (errno != 0 || *end) {
                 fprintf(stderr, "%s (%05d): ERROR: Cannot parse CPU count %s\n",
                         argv0, gettid(), optarg);
@@ -317,21 +315,24 @@ int main(int argc, char **argv)
     }
 
     if (getpid() == 1) {
-        if (mount_all() < 0)
+        if (mount_all() < 0) {
             exit_failure();
+        }
 
-        ret = get_command_arg_ull("ramsize", &ramsizeGB);
-        if (ret < 0)
+        ret = get_command_arg_ull("ramsize", &ramsize_gb);
+        if (ret < 0) {
             exit_failure();
+        }
     }
 
-    if (ncpus == 0)
-        ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+    if (n_cpus == 0) {
+        n_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    }
 
     fprintf(stdout, "%s (%05d): INFO: RAM %llu GiB across %d CPUs\n",
-            argv0, gettid(), ramsizeGB, ncpus);
+            argv0, gettid(), ramsize_gb, n_cpus);
 
-    stress(ramsizeGB, ncpus);
+    stress(ramsize_gb, n_cpus);
 
     exit_failure();
 }
-- 
2.53.0


