Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E35AC5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvewx-0007mq-MX; Sun, 16 Aug 2026 13:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvews-0007jY-3C
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvewq-00033R-0v
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2caced6038eso29366595ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902423; x=1787507223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5hDxxdLFArNy/AE5beLWIrhBgzeK81RdKFWGUs0EIlo=;
 b=BcciLmolnRtVci6+K/xKWPoZGMh4MMRkueI2SiZcM3KXZdZ4EEhcrNLe0UqFNlJ661
 if82vPP2VRlltVLoVGMVwm2g6pa5TX4tyvmKTExhpTvxbbrYF+wKn3cwcsGZg5AZ+/ON
 OAcRaYC/Kl3naFdPgngqGWkXbgeL0WZh7X4Q5wDO6Idr/QrQ3jbvW5dINXntYJHybyP5
 vqs2ogw1tvnyvNrvcP3uM1/7js+04X0JGXEpQtILOMhepxFmyBPKPwmLoHKiy+236w5t
 PUE9z4JLyk3OmFDmGfb7zpVkO1ggPm8QVqUrPVbHhH0/aXfPIbJgnGrgVjnf3NF6z0Xg
 9kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902423; x=1787507223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5hDxxdLFArNy/AE5beLWIrhBgzeK81RdKFWGUs0EIlo=;
 b=dhc26EScf+PGsw963dinRkErZqyVSulNRXwS+X+x3hOS0NkP17XizjGRqxH2JtKsE/
 Yifb4PhdTqA1AyyQEwQa6bK5fMGD2Vih/dH1U5lD7mlihA5zHbAoGChieL54WYPZsk1s
 HCsFdNQP0kK57cVkJbXPFICWBwuOUjU5nutH7/bXtVwdh7/8k8Vhven5CiJq38Hwmn1j
 xetpm89hfSM5KSUxZAsuosNS5X2CSJmmCiUoYVuaCGUCk14X/gsdnsnBfhJY7/8kLch2
 Ag8DHAeXdpvrhGimG5LcTCNfXQaFtUoltde9KtZqobnAWWETx3Z/r09UXWeCc+MPduAQ
 t80w==
X-Gm-Message-State: AOJu0Yy2y0Ia1qhcRhPXDTcSt3p8Spes8MrLC2kD87bRorL4A7lprCvm
 2FLCOvmCI65ZRqBetulqV3M/mr5XK3A/hbe6AGoUSk7LG1XBqu+i+tSeg1Pp3go3
X-Gm-Gg: AR+sD13hyOVneHkmjbq4xc/HsUUzrFbASGUZF5UE9JTT9UMJs3x+QOC9xxZfkw95bvb
 wwokyYzUhbXsJWRp6vaOIxOZDLin93hGmFdixFR+vEi6jDkEwfqs3bEdspgmDbDgAVZPLlCVJ6U
 gpTbCJMLSCiIO3Ou/2/1KKqLfEzGEr1JkTsA2FWBy90sD9UF5DTJ7ivb0WKkw8KZ7qEpze+Sx0S
 JGw12B2AtgwGf4rTWvD9xzkshNDeQIAW9gfdGtj6PP0/Vy3sBVm5iczFHWLVH3w4svp9N7DZv27
 9vPaZ+lNRLQnIu6BL2Qg5PrlYbQCNxRjoWNYY361x6nirCpkrKO2WSf7Ia4byhNxwDUqQ58Znac
 v5g9e7fJx0u6MM/W1f0o6T6er3cQ2MXQaK0LH5T3NKgk26cS9xj486y7x9g2PX9+VnutagAEHqn
 MkzOQQ458JhrLRVpB16cx567WDieaMpy28Fp1+jIL0RobPb99wVzawh6ZZrHVmL47d/moOWUJj3
 RlX07KouDrbsmg=
X-Received: by 2002:a17:902:f64e:b0:2cf:70d2:da7c with SMTP id
 d9443c01a7336-2d37f77fdfemr287252555ad.12.1786902422575; 
 Sun, 16 Aug 2026 10:47:02 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:01 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v5 01/11] migration: Propagate error in postcopy setup
 functions
Date: Sun, 16 Aug 2026 23:16:21 +0530
Message-ID: <20260816174631.1547811-2-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x633.google.com
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
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
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


