Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1335C55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzbK-00016L-8q; Fri, 31 Jul 2026 22:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbJ-000167-AO
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:25 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbH-0002VN-Ci
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:25 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so982059a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551842; x=1786156642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M0lzyPwM940Xr8iUJBQTtpo6xDFVZpAe9k3Ze/FYUnI=;
 b=GFZ8c0AYEBpNtM1gxItVu1fjAOHvnBdaP6Feo6UbQzau/+bJJPAY1yeF04s2Zhaoxi
 zdH/zqCIemu9oY6T3vHczW9Oyzo5fxlIkpCbhqzBvK6m8z8dUcxwEHlhjLnf9u3dlp2m
 e98Ascx7XBo9baQ6KZsRvvaW79HMm0HmSbhuY2kKfJDXceuEkaaNhniHjyd6xnpRfa/U
 uBzdke6rEx57t9Gem1Qgt44q1LbA6B4GkgmNeYGwoHGUllOtgNw+6+ztS6sTRrySmcWb
 0TReYPp2q2jsyu9KDuYQ6fGC6jxyJTlAdqi0CrPUe8s6L7fjlGZgqXkX0jcNIa2RP+2c
 xBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551842; x=1786156642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M0lzyPwM940Xr8iUJBQTtpo6xDFVZpAe9k3Ze/FYUnI=;
 b=MJ8yxNkLvgI1ZUPLtSDdt1E+hlK9cYBdR5j9F+G7eCz7+jrvllFwJYZxPWa+fLaXlC
 ZyJKnqeLO1q1tySdGMwmIWcmvLT4Z8iCHLMc8WNcmUXUG1caWBp7qsV0mnZiwFqha/N/
 g6jKqSnbhKGU4zjlqoU/Zh7f1Bd+9aoouqfOSVRCzT8hvhJDTVUjx0dtkLnXEeXJBwo+
 ie184bFDc1xHXyX6Tf8guUpzQTTl5NQuU8Pc7XwPnK9klbStTym85XBuzFazkOdbnMyL
 dYVF8Hwb7V1QqK5l7++1seyhynRtXphZzrLtGuK+ynMdYgREPXIYLrwXIZii3S7T9Myj
 PfDw==
X-Gm-Message-State: AOJu0Yw1ibwy8N7fmiUwSeyv7yij84kSxIF0ow5k7izOSa3Uhj7PfdMk
 0IZ7HCM3RwTC+BfWz3UPEkBZK60GC4FiZXqPYAZWBOAlQJgEPJM3NFzsSO3enseu
X-Gm-Gg: AR+sD10luYZFdy2VL1L3jbu8hqbHjzZuMarcOURpaiq7d7SZ40WiSUqcsiVgzvfk27J
 whsfEznghpZwH1jtjDqnNCtTmzQTvcnRYsnT1b5xpL1dW1VyeGudxUIWUtGAva0QxQEKm0e9MRM
 8Hsi8eOwbDHV13ClZdyAdVsA5r5+RYCCutAM+PLJbyc9y058/08QfeZ5mDh9aYEKKr1QwRcmCbb
 AYAHRTfcKOKJC7j5Ge3mmxSc/tuGvwh2JeagHPxw0YedW1yezydHOhRVEv4oYTBIF5kWDZ0Vqbl
 9OGvgstnlTtVEKrSiHcDRN4Hqh2Z5JxqlNmsWA2JHyz4VkROgCvk7ScY8cmlB4ifL0O/oi5P6l/
 1mvrBWNQ7uoEowk+TaHhEIluC5djdbC/F05I5iSkcYbJuhfJi2JtmYeLOYol/FEBCl7SgbRwBlF
 8YoNtA7mQ0xiYtkbSr23NGTtNUpsgKr3v8KkKe8tOzUBCZzPEvetwAKlROmdbQE+qN4PLjNQwD6
 i/7cGN9ox7UgiWh
X-Received: by 2002:a05:6a20:9186:b0:3c3:750f:3cf9 with SMTP id
 adf61e73a8af0-3c91a777233mr4167726637.11.1785551841802; 
 Fri, 31 Jul 2026 19:37:21 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:21 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 01/11] migration: Propagate error in postcopy setup
 functions
Date: Sat,  1 Aug 2026 08:06:18 +0530
Message-ID: <20260801023628.22665-2-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x532.google.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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


