Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329FBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weThr-00055O-IH; Tue, 30 Jun 2026 04:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThl-0004zQ-6v
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThj-0003Q6-DF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c82538b6c0so24795005ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807624; x=1783412424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLw+7vaR8va6nbyyKlMzc8R1dshwKiZRd0bebnyPoPw=;
 b=NAHkiGOSoke+F7zoDIlvIuq5cDljQEVeEl5j1YLy57MTGr35Z/+1t1ii1SGN9KlqXR
 vQxUI8Yws97Tdin3t7W9vaIOfA47f1eDoZzoLem72w84+xmWar4qTcgPwlP9I51DNiH/
 5OB7dLSukLZoZnpD+h9GVL4dIMLvu99VvXLW+jzK3lAAHvhCu3GrbsaiMP/IkKoMqn56
 cwzpSvNBUHLfGKJKEo89RoshCpwwuG4I3J3vuHUcWSi24pHFHqvwUG7L0jycQ6sCuQuk
 Ie8k9MRNBv7n0PeSPQ8nqEIQMKvO/cPBtlOxT0yVLQ28bqFf+CPtqKWCvsk25KoRv80H
 GDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807624; x=1783412424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLw+7vaR8va6nbyyKlMzc8R1dshwKiZRd0bebnyPoPw=;
 b=r728j51IiIN1kqK0ZiO+BdavDSjhWEr9+7QK8UXwpUlrW7RVxMB3DGWQbc3sAJk4Sc
 KFlMj9jwPTcC/4d8uJzoLuiHc+RIMKpW2lFXt473RJ0J7shlvRObkXC1rqRqxEK+k0F5
 wly3pYagFPIhqXv4yqxPbiY9tijftOiNHpN1wVlGnsRQ8oaBxStVRcFmiIuT7S1snmYR
 3KA8z5l1qpxnju6gdPInaJGVM67DENPWky63I1wm7Ga96VAv3xwjrii7xXWqgCCOcdNL
 3eHLJGgcv/i+JNZI+SWoNjZ4qGSnO68sRJKwiZbnJS3Mxv9jJ90cBJmVhhiGyLbpj7IW
 gNXA==
X-Gm-Message-State: AOJu0YzGYlYySehJO1lvyX/TOJjp/bbpmYNgEw54tJxOW/8rjw7PcZiE
 OrQDzXmV68PIDEoWIgMqW3LrfGwQtkSOK717bUuWxJb+O2qmOkUeRI4Z6DFevS4M
X-Gm-Gg: AfdE7ckNBMQb2xyUI20BU9iG3j6NM25ypq4jBXjkn3P5x3eyTFMAzlRVlNV+ZWHTf6O
 1Lf1LdESH12SeYmaLR3vaL5Y+GgzI744WvrtQac5faDz105bUo7r4HlhPU01jF009VEgWRFT5Up
 BJ5pv3IELhHxnkzYDBRsCqUPDIVhBzVC9XZXnk1pFAsSN4+zsdWd2PhjSw1j4LHgXpagiUNCc0s
 iJX/580IgsckzP+V9YxLIqvOL08/UDnV4HkQh1nnjNEHI1vsfzMnI7PO9GyK/lOJc7t9oH8m6vj
 p6uzKeRKHd7n4VC2Yy2eo8lEBwdk+0RH2Bg6LMf5cBDKr1UOqnCi5hYtB4TqgvP7rIxIAnLmpv7
 dWMh40yI99lRPfvTI2Q2dahACI5U6kzbGXXCSDADZoGYYtQ2A5kceFQmOLH81kCrYqJCmumaoOr
 TohR4Dl5/LX6FwrMGRfg1sQzy5/CDuAtysOaPeF3xIEuM=
X-Received: by 2002:a17:903:2441:b0:2c9:e266:e32e with SMTP id
 d9443c01a7336-2ca2ed2c766mr20580475ad.47.1782807624532; 
 Tue, 30 Jun 2026 01:20:24 -0700 (PDT)
Received: from setun ([2401:4900:a344:dc6e:573c:3e9:c03e:731a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca4f2a71dbsm1284615ad.50.2026.06.30.01.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:20:24 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH v2 2/7] migration: Propagate error in postcopy setup
 functions
Date: Tue, 30 Jun 2026 13:49:35 +0530
Message-ID: <20260630081940.611092-3-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630081940.611092-1-aadeshveer07@gmail.com>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x62f.google.com
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
2.54.0


