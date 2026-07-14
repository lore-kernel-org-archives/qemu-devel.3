Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4296BC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwI-000659-1V; Tue, 14 Jul 2026 10:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwC-000650-QZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:44 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwA-0002Tq-Vz
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:44 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-381ed661712so4886663a91.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038601; x=1784643401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DEwZFCuCIRpLTbXq9T/Srj49IsDFq6R+mSkrteH3nSE=;
 b=a3BWUq3r94cUT+lGuqrznuIJOA+WsOcUwQYMdi0J6BQS9QicV/sOUJidfGIWJo4coA
 n1KK4SDZlzv0lDLiSGg8Kojwpqia1lNwMIvnz5R2PYKkFXT1sGlH2XxFOjOCoJGR/J7+
 czcVjyJQpTgzsbNEXOv7K6AuToDKY5CWuEGBiOOb+IxmEDpVx4i1aluDQ6VIcgx/SJqk
 LWpsCa3Fbp6DKlvBJyOCb0T+PfmBjzZrU/uAi41BrzaCZx8FpenbIhvuCcug1X7FI6hb
 4koe+kNe9RsRl0MZtPW41DT7UVNKjvIrTWCgEzdA+WaqPQvSOt5TSQKyr2gdcx8LeHoC
 X0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038601; x=1784643401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DEwZFCuCIRpLTbXq9T/Srj49IsDFq6R+mSkrteH3nSE=;
 b=BG3A+x5fV6eZg3reul4pbJ2psDUt/RCKUkrhq5zCw5Kgp8LUozi+mXuNr1/ixChG0u
 quzre16wdnz3lbRu08+UdKUBY6K6vrogIr0xU+Bccrx03R8bvAM7uijU12QP/52N6bIp
 qD9OVhMI9wakGwxB5CM4zHJQRD1yPpe5M0tVdNOTB8tJ17xcYM2V5NijqnfVnHGvw/2T
 4zmfOsjCWmPj00pCloBuYSb/wYNXS65lTzIQDbFhNbrBb5/PjpjHCGFKuWLwOjK4oz1r
 ELJbRq6ZsIk4T5tNmCW6kt8lvBzHIo+mgQ1s7TXZ622ElFJhoPjiCmChQtLE9TlDejJl
 hWfA==
X-Gm-Message-State: AOJu0YzFCzLqVNS7ESKpQEoESeDvKGQGKRfsOvzfjJlgKvmHKgEszUL5
 s+66Fm495kKna5BZQ3ybnwBW8H7YhdQPfBNi1+1GfqBeTgMMC5Y81HRonpzwzNC6
X-Gm-Gg: AfdE7cl1nylRELzQCSCHt6oLQ3C0DeTAVhDZ2ZmHrWPaxtSmDQ1/pP+gSV4ArmQ/uBV
 eea6GTIWULoyMTiFT9JvAtVW6ZaPzvsPdkCPnjR0FIaXNn6QGTlhtDNW8eg3a3hNF1OzH00GhxA
 +/kV2R14SjEt26RZYTFeGpOI+AENh4aQTS6RBdfrg/lcFT2ZAKWAUWOo2PNLuRo6S30RUQWfqIz
 IJmgqJVNPe9tMv/rdPCFp54p8O8yJ0kfwCZh92VHyyw/iohiXWOcImN1XOp1BEA933umgeEcxZN
 B/V0vtskDG14FuH/0J56A8UQu+LKwqmS56kaPsq2Xv3fJN5sQ01EEZL8S0al4HfJzcy+06LhfOp
 I6wZpHA2nUPsUTCobxaPAiodK78Z5aiiQVYH/LHmaoxpodd3fSVdyOIuo+av/asqhEtatJ6YTC/
 Q2CDRGte0Dzc+FAmX5L1uEMPtE2KzrQdV6sBUVZ6K5lA==
X-Received: by 2002:a17:90b:2544:b0:38e:408:9d7d with SMTP id
 98e67ed59e1d1-38e1af44e01mr2904530a91.36.1784038600941; 
 Tue, 14 Jul 2026 07:16:40 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:16:40 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 01/11] migration: Propagate error in postcopy setup
 functions
Date: Tue, 14 Jul 2026 19:45:37 +0530
Message-ID: <20260714141547.1268000-2-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Modernize error handling in postcopy_ram_incoming_setup() and
postcopy_temp_pages_setup() by replacing error_reports and local error
handling with standard Error propagation.

Replace use of strerror() on errno with error_setg_errno() for modular
handling of errors and change return values to -1 on failure as no
caller checks the actual return value.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/postcopy-ram.c | 41 +++++++++++++++++-----------------------
 migration/postcopy-ram.h |  2 +-
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f5ef93f193..96a65aa976 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1464,10 +1464,9 @@ retry:
     return NULL;
 }
 
-static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
+static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyTmpPage *tmp_page;
-    int err;
     unsigned i, channels;
     void *temp_page;
 
@@ -1487,11 +1486,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
         temp_page = mmap(NULL, mis->largest_page_size, PROT_READ | PROT_WRITE,
                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
         if (temp_page == MAP_FAILED) {
-            err = errno;
-            error_report("%s: Failed to map postcopy_tmp_pages[%d]: %s",
-                         __func__, i, strerror(err));
+            error_setg_errno(errp, errno,
+                             "%s: Failed to map postcopy_tmp_pages[%d]",
+                             __func__, i);
             /* Clean up will be done later */
-            return -err;
+            return -1;
         }
         tmp_page->tmp_huge_page = temp_page;
         /* Initialize default states for each tmp page */
@@ -1505,11 +1504,10 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
                                        PROT_READ | PROT_WRITE,
                                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (mis->postcopy_tmp_zero_page == MAP_FAILED) {
-        err = errno;
         mis->postcopy_tmp_zero_page = NULL;
-        error_report("%s: Failed to map large zero page %s",
-                     __func__, strerror(err));
-        return -err;
+        error_setg_errno(errp, errno, "%s: Failed to map large zero page",
+                         __func__);
+        return -1;
     }
 
     memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
@@ -1517,15 +1515,13 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
     return 0;
 }
 
-int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis, Error **errp)
 {
-    Error *local_err = NULL;
-
     /* Open the fd for the kernel to give us userfaults */
     mis->userfault_fd = uffd_open(O_CLOEXEC | O_NONBLOCK);
     if (mis->userfault_fd == -1) {
-        error_report("%s: Failed to open userfault fd: %s", __func__,
-                     strerror(errno));
+        error_setg_errno(errp, errno, "%s: Failed to open userfault fd",
+                         __func__);
         return -1;
     }
 
@@ -1533,8 +1529,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
      * Although the host check already tested the API, we need to
      * do the check again as an ABI handshake on the new fd.
      */
-    if (!ufd_check_and_apply(mis->userfault_fd, mis, &local_err)) {
-        error_report_err(local_err);
+    if (!ufd_check_and_apply(mis->userfault_fd, mis, errp)) {
         return -1;
     }
 
@@ -1546,8 +1541,8 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
     /* Now an eventfd we use to tell the fault-thread to quit */
     mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
     if (mis->userfault_event_fd == -1) {
-        error_report("%s: Opening userfault_event_fd: %s", __func__,
-                     strerror(errno));
+        error_setg_errno(errp, errno, "%s: Opening userfault_event_fd",
+                         __func__);
         close(mis->userfault_fd);
         return -1;
     }
@@ -1559,12 +1554,11 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
 
     /* Mark so that we get notified of accesses to unwritten areas */
     if (foreach_not_ignored_block(ram_block_enable_notify, mis)) {
-        error_report("ram_block_enable_notify failed");
+        error_setg(errp, "ram_block_enable_notify failed");
         return -1;
     }
 
-    if (postcopy_temp_pages_setup(mis)) {
-        /* Error dumped in the sub-function */
+    if (postcopy_temp_pages_setup(mis, errp)) {
         return -1;
     }
 
@@ -2201,9 +2195,8 @@ int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
      * shouldn't be doing anything yet so don't actually expect requests
      */
     if (migrate_postcopy_ram()) {
-        if (postcopy_ram_incoming_setup(mis)) {
+        if (postcopy_ram_incoming_setup(mis, errp)) {
             postcopy_ram_incoming_cleanup(mis);
-            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
             return -1;
         }
     }
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index a080dd65a7..98d918713f 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -23,7 +23,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
  * Make all of RAM sensitive to accesses to areas that haven't yet been written
  * and wire up anything necessary to deal with it.
  */
-int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis, Error **errp);
 
 /*
  * Initialise postcopy-ram, setting the RAM to a state where we can go into
-- 
2.55.0


