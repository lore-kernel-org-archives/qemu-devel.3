Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7624ACAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJhZ-0001kF-6g; Thu, 18 Sep 2025 14:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Q1TMaAcKCmoabMdQMIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--steviea.bounces.google.com>)
 id 1uzJhU-0001jf-CY
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 14:49:48 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Q1TMaAcKCmoabMdQMIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--steviea.bounces.google.com>)
 id 1uzJhS-0002yU-MW
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 14:49:48 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2665df2e24aso22798905ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758221380; x=1758826180; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SZh7HNwDggLgI0mFfjdx9B3XpYyPXunvtsg5o4BmdCs=;
 b=PgopiW2IQFILIwLP0YY8aoAXRtNTd8Lxq63Y/UI26EuZbjURk3J+FCQtGAweYCBYzk
 em+Jx8sUW5gYHOwz8UNS/lYUvHkC869yOo3DtlmMCricylQnG+YGP6GnfabIffCe2ekR
 S6GV3Hr20+MMZoNNkvZXQhvDY6V6yo4v83loPZ/pmPx760vlNFzBD9qNwnwpbDC2EDgY
 jNofD1oNKfCS6bm9ec6EEOZqlDnhOQ0VEWXh3JAn9CJIWkyak6oKjlaSLIX7Oi2jxb+m
 VnyTNIZ7YNn5t5JqHdy04MFZHs0R19Wvbd7q+4Wep+WVVnO490f/SY4JUBnI1sFSVejE
 aF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758221380; x=1758826180;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZh7HNwDggLgI0mFfjdx9B3XpYyPXunvtsg5o4BmdCs=;
 b=INJ0xw8/VPNuh3RrVzVa+HJ1vTFgInrpS3Z8L0SldFeantoN7ClRvcZ9DDfKVwCSsc
 +OLXwZwLMCdoEzaIz+EXHyW4KwvZw3h+gXc0bUgSJfZelOmYiz63EcCgGboMP3nMt7Di
 qHR1NwaFL7aumEV2g+EAAsi7d5a/zlMMJju5SKP9BOD0vPjBaIZibSdK0OwZGbU7sntz
 wngdKkoMUY9+RREwYr6pI52ZO5OwjHKA+LqLAvUQIEtfoUtKdFXHIMZ8izjsXRw2BsT1
 lfDZkZCvqGQGFWPq2wk9TvCClwMRkQukXdqEUr5rUKC9OL+3XPu6RNTC10YbFX/VgXFu
 I9AQ==
X-Gm-Message-State: AOJu0YxqqljEG/rbcMgAzrHbuNypA8dwRLyd77drEZLvaNwnI0Vd6NQr
 scsEphNF4BintJgN/kfWrqv03kDDU4JBHkaxr23pF8O2cU0Bloz36flrmXIpRPpxXSi12l1nvPA
 kjC5RaG6SZA==
X-Google-Smtp-Source: AGHT+IGN6+R7xiBzixLXr2GSr5BSsP/gfLd0IB/hHw4bwD91Jexn9kXU0/zQ6G+A78Tu/XRFeVidOGSyF0Ld
X-Received: from pjtu6.prod.google.com ([2002:a17:90a:c886:b0:32d:a0b1:2b14])
 (user=steviea job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b68:b0:24b:24dc:91a7
 with SMTP id d9443c01a7336-269ba521114mr5942335ad.45.1758221379677; Thu, 18
 Sep 2025 11:49:39 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:49:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918184935.2704752-1-steviea@google.com>
Subject: [PATCH] linux-user: Surface more /proc/self/stat fields to the
 emulated process
From: Stevie Alvarez <steviea@google.com>
To: laurent@vivier.eu
Cc: qemu-devel@nongnu.org, Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3Q1TMaAcKCmoabMdQMIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--steviea.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Shu-Chun Weng <scw@google.com>


Some fields make sense even for the emulated process. Some external
programs/tests might depend on the fields, e.g. starttime.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/syscall.c | 93 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..7f3d346902 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8216,15 +8216,99 @@ static int open_self_smaps(CPUArchState *cpu_env, int fd)
     return open_self_maps_1(cpu_env, fd, true);
 }
 
+#define NUM_PROC_SELF_STAT_FIELDS 52
+
+static void read_proc_self_stat(char buf[], int buf_size, const char *fields[])
+{
+    char *p;
+    int i;
+
+    for (i = 0; i < NUM_PROC_SELF_STAT_FIELDS; i++) {
+        fields[i] = NULL;
+    }
+
+    int fd = open("/proc/self/stat", O_RDONLY);
+    if (fd < 0) {
+        return;
+    }
+    i = read(fd, buf, buf_size);
+    close(fd);
+    if (i <= 0) {
+        return;
+    }
+    if (i == buf_size) {
+        buf[buf_size - 1] = '\0';
+    } else {
+        buf[i] = '\0';
+    }
+
+    fields[0] = strtok_r(buf, " \n", &p);
+
+    /*
+     * Get the next field (comm), but don't tokenize -- we'll need to find the
+     * right-most ')' that marks the end of the file name instead.
+     */
+    fields[1] = strtok_r(NULL, "", &p);
+
+    p = strrchr(fields[1], ')');
+    if (!p) {
+        return;
+    }
+    p[1] = '\0';
+
+    fields[2] = strtok_r(p + 2, " \n", &p);
+    for (i = 3; i < NUM_PROC_SELF_STAT_FIELDS; i++) {
+        fields[i] = strtok_r(NULL, " \n", &p);
+    }
+}
+
 static int open_self_stat(CPUArchState *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu(cpu_env);
     TaskState *ts = get_task_state(cpu);
     g_autoptr(GString) buf = g_string_new(NULL);
+    char host_stat_buf[1024];
+    const char *fields[NUM_PROC_SELF_STAT_FIELDS];
+    const int use_host_stat_fields[] = {
+        /*
+         * `man 5 proc` uses 1-based index, so indices here are one less than
+         * on the man page.
+         */
+        0, /* pid */
+        2, /* state */
+        3, /* ppid */
+        4, /* pgrp */
+        5, /* session */
+        6, /* tty_nr */
+        7, /* tpgid */
+        17, /* priority */
+        18, /* nice */
+        21, /* starttime */
+        38, /* processor */
+        39, /* rt_priority */
+        40, /* policy */
+        NUM_PROC_SELF_STAT_FIELDS, /* sentinel */
+    };
+
     int i;
+    const int *next_use_host_stat_field = use_host_stat_fields;
+
+    read_proc_self_stat(host_stat_buf, sizeof(host_stat_buf), fields);
+
+    for (i = 0; i < NUM_PROC_SELF_STAT_FIELDS; i++) {
+        bool may_use_host_stat = i == (*next_use_host_stat_field);
+        if (may_use_host_stat) {
+            ++next_use_host_stat_field;
+        }
 
-    for (i = 0; i < 44; i++) {
-        if (i == 0) {
+        if (may_use_host_stat && fields[i] != NULL && fields[i][0] != '\0') {
+            g_string_printf(buf, "%s ", fields[i]);
+
+            /*
+             * Some systems do not mount /proc so still check for 0 and 3 even
+             * though `may_use_host_stat` is true for them.
+             */
+        } else if (i == 0) {
             /* pid */
             g_string_printf(buf, FMT_pid " ", getpid());
         } else if (i == 1) {
@@ -8259,7 +8343,8 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
             g_string_printf(buf, TARGET_ABI_FMT_ld " ", ts->info->start_stack);
         } else {
             /* for the rest, there is MasterCard */
-            g_string_printf(buf, "0%c", i == 43 ? '\n' : ' ');
+            g_string_printf(buf, "0%c",
+                            i == NUM_PROC_SELF_STAT_FIELDS - 1 ? '\n' : ' ');
         }
 
         if (write(fd, buf->str, buf->len) != buf->len) {
@@ -8270,6 +8355,8 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
     return 0;
 }
 
+#undef NUM_PROC_SELF_STAT_FIELDS
+
 static int open_self_auxv(CPUArchState *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu(cpu_env);
-- 
2.51.0.470.ga7dc726c21-goog


