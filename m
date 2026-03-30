Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426161061B1C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HwM-0004IE-8A; Mon, 30 Mar 2026 15:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvX-0003pD-En
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvV-0005De-88
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82cd5c07f93so124195b3a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774897526; x=1775502326; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xvDeM0TyoHIJuMI9O46gKFM23hqyKFmD6p428QNsoc8=;
 b=nFjnuKfRiMTEaoXQxV6tSu+jj6WVg9ZKsf3DXrfKHK4nYllSlLlnUM3WvoGWt1E33u
 EylmwoldGEwfyCoYoIOb6XF6kjzhsHeP4LrblXVFeF+dbvLApXzdxExDDlAtvKw60lcF
 AbTVrnhvkbu+W6f5L6fWhel2jwvTDuRpUJSpzDyuiApnFsAsUbw8iy/+PQ/3WsDsr6Qt
 ABTj9pZwAmuSbxnG3iLOkpsQSb5dpQSNGf0fAWf8q5mgohoRC3xoMfiCQoyZ9mRsrNR1
 3xWlkfBRsA7fXCGENuJeGG9RVLBGGPocInWMXM+O5NXiLsXKTOR6JwuFN2rYNCQja1QI
 LiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774897526; x=1775502326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xvDeM0TyoHIJuMI9O46gKFM23hqyKFmD6p428QNsoc8=;
 b=L5tDshO45ljw04E/NDc0xq3yP2R4SvHRbHz/irWKT+fpJqlhAIJ/XfhskaPOs4qtl1
 3O5Cer6165LBJJS6Mr63sPbPBPBipd8jQ/Nl1xhJ828Ar9r50TNAIu5ygZ2V7xv8uR5f
 agLsshcgtrpr5f+DYGEbmNYlU4ecn2vpoVxGKdQenqusGAPUoCAvE1/kOLZ0pXqeEnK4
 nPFeIwh9fgEw5xcguTfT3NRvoCVAju5JCxy5bRMr7waTk308xbWjrb2abDpNoUcJ4H/5
 MG8lKwzfGqawRJaHObLiHMrc2RfQMTu8DM6zDOcoNxu2TkQwT78JQ8dbz3uyknbSTHj5
 Fi2Q==
X-Gm-Message-State: AOJu0YyYpbslQIxx6v+3sN7L7aAYxr4k2/u9MtvD/pZZ+9JNxFZkRcDN
 UNa+/thdAzBSY4uYlo33E9DWdfqJoqMtbiCRQx9MVhEnsAEBfvaXsQhNw31EFg==
X-Gm-Gg: ATEYQzwireBcz/i6SK3Y/5MGw9Ey/pe7Uu72Exz01fzyxw0U8rAwO2PuXSJNYlEAUp3
 VQI7hJLi+IPm+Q04YIfIDJxpmKVVgU9Upk1XpdRyy2FjXE8BqdFb50AJ3smz7cNI/wqbhMC6eXh
 cvEFYPWD6GFpOSpvGl1ry1YIG5e1KS6w++XcV12KToxrB4uWLQZqzAEWL64KSdvXqelOqpW2kBX
 /K2G7SP0zhDWhFg9RLmLlQXfxNhy4jAdI8aWhVorw/Os4zCUQVD9qshGmah/1BurIJuIrFKPkEB
 bsJM4Cx302fFgEfrJH/eVQxMOkJ/s2DBsZCXeIWhVsMwyIPI4RBu/kxjn9KmgV1WehMH/qMBL0d
 NXuuq/qGclM4YBpwIBhiIw2Y0GgJM/XQz06NvwLllk3q9YC4Oe70Sgvrzqjj7BR/T+Y6NME7rGv
 hCF1lJEEA4F9F6xOVULI7QxX7Fx7HlyZ1xs0CO6noVIr1C0Ehbl3B5D85klkLppAk0SJX0QLa5l
 IPpIgS1bEW4z9BzCQ==
X-Received: by 2002:a05:6a00:1912:b0:7fb:f87d:a0aa with SMTP id
 d2e1a72fcca58-82c960a60demr12564625b3a.52.1774897526221; 
 Mon, 30 Mar 2026 12:05:26 -0700 (PDT)
Received: from [127.0.1.1] (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca84644d9sm8496989b3a.13.2026.03.30.12.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:05:25 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Mon, 30 Mar 2026 19:04:42 +0000
Subject: [PATCH 2/3] migration/postcopy: Factor out uffd_setup_incoming()
 from postcopy setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-fast-snapshot-refactor-v1-2-22143e70c467@gmail.com>
References: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
In-Reply-To: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Takeru Hayasaka <hayatake396@gmail.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=hayatake396@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

Extract the generic userfaultfd initialization from
postcopy_ram_incoming_setup() into a new uffd_setup_incoming() function
that can be shared between postcopy live migration and fast snapshot
load.

uffd_setup_incoming() handles:
- Opening the userfaultfd and API handshake
- Creating the eventfd for quit notification
- Setting the page fault handler callback
- Starting the fault handler thread
- Registering all RAM blocks with UFFDIO_REGISTER
- Allocating temporary page buffers for UFFDIO_COPY

postcopy_ram_incoming_setup() becomes a thin wrapper that adds
postcopy-specific logic: blocktime tracking and the preemption thread.

Also move the PostcopyPageHandler typedef from migration.h to
postcopy-ram.h where it logically belongs and is needed for the
uffd_setup_incoming() declaration.

The channels parameter of postcopy_temp_pages_setup() is now passed
by the caller instead of being determined internally, so
uffd_setup_incoming() callers can control how many temporary page
buffers are allocated.

No functional change for postcopy migration.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
 migration/migration.h    | 11 --------
 migration/postcopy-ram.c | 66 +++++++++++++++++++++++++++++++++---------------
 migration/postcopy-ram.h | 27 ++++++++++++++++++++
 3 files changed, 73 insertions(+), 31 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 33525402922d..43ea32c07ba7 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -89,17 +89,6 @@ typedef enum {
     PREEMPT_THREAD_QUIT,
 } PreemptThreadStatus;
 
-/*
- * Callback to handle a page fault from the userfaultfd fault thread.
- * Implementations resolve the fault by supplying the requested page,
- * e.g., by requesting it from the migration source (postcopy) or by
- * reading it from a snapshot file (fast snapshot load).
- */
-typedef int (*PostcopyPageHandler)(MigrationIncomingState *mis,
-                                   RAMBlock *rb,
-                                   ram_addr_t offset,
-                                   void *fault_address);
-
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 8dcd8ff35e85..7af207d6ead5 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1478,22 +1478,15 @@ retry:
     return NULL;
 }
 
-static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
+static int postcopy_temp_pages_setup(MigrationIncomingState *mis,
+                                     unsigned int channels)
 {
     PostcopyTmpPage *tmp_page;
     int err;
-    unsigned i, channels;
+    unsigned i;
     void *temp_page;
 
-    if (migrate_postcopy_preempt()) {
-        /* If preemption enabled, need extra channel for urgent requests */
-        mis->postcopy_channels = RAM_CHANNEL_MAX;
-    } else {
-        /* Both precopy/postcopy on the same channel */
-        mis->postcopy_channels = 1;
-    }
-
-    channels = mis->postcopy_channels;
+    mis->postcopy_channels = channels;
     mis->postcopy_tmp_pages = g_new0(PostcopyTmpPage, channels);
 
     for (i = 0; i < channels; i++) {
@@ -1531,7 +1524,19 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
     return 0;
 }
 
-int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
+/*
+ * Generic userfaultfd setup for incoming migration.
+ *
+ * Opens the userfaultfd, performs the API handshake, registers all RAM
+ * blocks for missing-page notifications, allocates temporary page buffers,
+ * and starts the fault handler thread using the given callback.
+ *
+ * Both postcopy live migration and fast snapshot load use this function;
+ * the caller supplies the appropriate page_fault_handler.
+ */
+int uffd_setup_incoming(MigrationIncomingState *mis,
+                        PostcopyPageHandler handler,
+                        unsigned int channels)
 {
     Error *local_err = NULL;
 
@@ -1549,15 +1554,11 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
      */
     if (!ufd_check_and_apply(mis->userfault_fd, mis, &local_err)) {
         error_report_err(local_err);
+        close(mis->userfault_fd);
         return -1;
     }
 
-    if (migrate_postcopy_blocktime()) {
-        assert(mis->blocktime_ctx == NULL);
-        mis->blocktime_ctx = blocktime_context_new();
-    }
-
-    /* Now an eventfd we use to tell the fault-thread to quit */
+    /* An eventfd we use to tell the fault-thread to quit */
     mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
     if (mis->userfault_event_fd == -1) {
         error_report("%s: Opening userfault_event_fd: %s", __func__,
@@ -1566,7 +1567,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
-    mis->page_fault_handler = postcopy_page_fault_handler;
+    mis->page_fault_handler = handler;
 
     postcopy_thread_create(mis, &mis->fault_thread,
                            MIGRATION_THREAD_DST_FAULT,
@@ -1579,11 +1580,29 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
-    if (postcopy_temp_pages_setup(mis)) {
+    if (postcopy_temp_pages_setup(mis, channels)) {
         /* Error dumped in the sub-function */
         return -1;
     }
 
+    return 0;
+}
+
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
+{
+    unsigned int channels;
+
+    if (migrate_postcopy_blocktime()) {
+        assert(mis->blocktime_ctx == NULL);
+        mis->blocktime_ctx = blocktime_context_new();
+    }
+
+    channels = migrate_postcopy_preempt() ? RAM_CHANNEL_MAX : 1;
+
+    if (uffd_setup_incoming(mis, postcopy_page_fault_handler, channels)) {
+        return -1;
+    }
+
     if (migrate_postcopy_preempt()) {
         /*
          * This thread needs to be created after the temp pages because
@@ -1745,6 +1764,13 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
     g_assert_not_reached();
 }
 
+int uffd_setup_incoming(MigrationIncomingState *mis,
+                        PostcopyPageHandler handler,
+                        unsigned int channels)
+{
+    g_assert_not_reached();
+}
+
 int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
 {
     g_assert_not_reached();
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index a080dd65a77a..3bbd1ed7e323 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -15,10 +15,37 @@
 
 #include "qapi/qapi-types-migration.h"
 
+/*
+ * Callback to handle a page fault from the userfaultfd fault thread.
+ * Implementations resolve the fault by supplying the requested page,
+ * e.g., by requesting it from the migration source (postcopy) or by
+ * reading it from a snapshot file (fast snapshot load).
+ */
+typedef int (*PostcopyPageHandler)(MigrationIncomingState *mis,
+                                   RAMBlock *rb,
+                                   ram_addr_t offset,
+                                   void *fault_address);
+
 /* Return true if the host supports everything we need to do postcopy-ram */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
                                     Error **errp);
 
+/*
+ * Generic userfaultfd setup for incoming migration.
+ *
+ * Opens userfaultfd, registers all RAM blocks, allocates temporary
+ * page buffers and starts the fault handler thread.  The caller
+ * supplies the page_fault_handler callback appropriate for the use
+ * case (postcopy live migration or fast snapshot load).
+ *
+ * @channels: number of temporary page channels to allocate
+ *            (1 for most cases, RAM_CHANNEL_MAX when postcopy preempt
+ *            is enabled).
+ */
+int uffd_setup_incoming(MigrationIncomingState *mis,
+                        PostcopyPageHandler handler,
+                        unsigned int channels);
+
 /*
  * Make all of RAM sensitive to accesses to areas that haven't yet been written
  * and wire up anything necessary to deal with it.

-- 
2.43.0


