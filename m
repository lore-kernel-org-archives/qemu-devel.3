Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC420CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 07:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNQrZ-0000lZ-NP; Thu, 14 May 2026 03:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wNQrY-0000lE-LW
 for qemu-devel@nongnu.org; Thu, 14 May 2026 03:52:08 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wNQrX-0001qW-3g
 for qemu-devel@nongnu.org; Thu, 14 May 2026 03:52:08 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3692bf38290so332742a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778745124; x=1779349924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Df1fBQImUBl+PdB0NJxwCFXZzQC+MVW+7lNLB+1P3UU=;
 b=d55SN7wJwjJEoRDriaSEq+xayGE0UAxRfCbpHJo9f/xD/MgJaUCYjOQysMoKjNldIG
 9EugMOUumjuglM0zyUGb3D4SBQfancraQN0aVVuBjeZgnb/3dWc4M9FHxkJ074EZ0ybB
 XTmGG8v76NLFR9TdI/av3tnxWwUo0qDXpHJ98NR7g7Rc5y9CnR+s1Y5n7vusxSJ5KFHA
 +ZWVEnLDiPD79Mt0kagS3OEXb6n2dLIs+HAXlZErfOtDbJVq+pwliNQi2f14gtJdENjc
 XmxI9ol9HSZtiCtD7jtR1u1AQs+Urv9frj72bfv1DMcrIUh5ZpYL1O4SiEST5X/Q2CX8
 RvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778745124; x=1779349924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Df1fBQImUBl+PdB0NJxwCFXZzQC+MVW+7lNLB+1P3UU=;
 b=ssZClfXXYGv9VkZ5tCN7KsedXeYUB0W/2WTqYYIl9maGMAlzctb3bTgIcopXyAphdE
 YmHsOi0wQUf/sc4OgS3CifqEdT40B8CErUBYuWOv21SIH4BuXrApfsc9Kl2qeSw368PP
 Pg7Jv9TNeJ13EMa3SoQLFR+kO0zCVSW+WXmhyMbZDkv5CjNXLymRpTLZHtgw4NPSszMI
 M0UGh2glEGc76Wl3F6Kpthe+6fc1TQ7E9z1fjXaLZKTuI9fOljvFIpCdL9roEv275EQ0
 w7shgEEr1BVmPIFk6pd6WHHSDjVcUUJeJJBHVn3lwn2MAIY9VgcrA/kZIl6W0Ggl7NEN
 6g+Q==
X-Gm-Message-State: AOJu0YzAbA7Q1wOrQfctGEN3ztUueFXv59/o7BmpHUOa6p21hUkLZMKL
 i2YfbsL8NRhVPPRxxVSy2vHfuUD+OZHjjoX1Y2xoRVM4XO3+sKckGykFNT3pphlu
X-Gm-Gg: Acq92OEzs1A8xVtLGL2q8B0NiQVTZf0TQJfvzaOkwYXM/5k/7pzhev2xL2GxXMfb7rq
 mCrhc3V7mJIiY6mmwcV+/A3ojYcZYDiYpmrX7kRHIYNCse35Wd085RaJuCfnQospDzVq52daBLG
 kP25mlah7oJ429/3iqhk9bgEhtSr9H1EAG2QnHwlL7eMPaaGlHvfkfmrreTl1Xd3ok4jrFgO+6M
 JuRwP7ev+pzgDjEzwRFMDhfO2xvDcNk/zYd5khTtMEP7nszOSNdwvLElZr/dVru9y7qoEeuvN7j
 A1Nnxd1DwdBicMfc2TlfBoQyUOp9faxdNYZUemMnitIbVFIEaKnDMwqn+3skpSgzvxetwqdlqHJ
 lZpCl1Mpa2r1QfYcn8HA5eOvdJcUe1zhvGIqgfEpYVLYXKj9CUXLHJpYN6zqAq71/B9U88+3U7z
 hq1Uq4U3AioLiK5I4tn8U5
X-Received: by 2002:a17:90a:2ce4:b0:369:73a:3266 with SMTP id
 98e67ed59e1d1-369073a36e6mr3558033a91.10.1778745124287; 
 Thu, 14 May 2026 00:52:04 -0700 (PDT)
Received: from setun ([2405:201:502b:380f:df10:4bc8:ea8:8d6d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368edf4d940sm5278624a91.7.2026.05.14.00.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 00:52:03 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH] migration: use eventfd functions instead of bare read/write
Date: Thu, 14 May 2026 13:21:37 +0530
Message-ID: <20260514075136.301706-2-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102b.google.com
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

Replace read() and write() syscalls on eventfd with glibc wrappers
eventfd_read() and eventfd_write(), to make code more robust, readable
and future-proof.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/postcopy-ram.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f5ef93f193..16113b166d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1330,12 +1330,12 @@ static void *postcopy_ram_fault_thread(void *opaque)
         }
 
         if (pfd[1].revents) {
-            uint64_t tmp64 = 0;
+            eventfd_t tmp_event = 0;
 
             /* Consume the signal */
-            if (read(mis->userfault_event_fd, &tmp64, 8) != 8) {
+            if (eventfd_read(mis->userfault_event_fd, &tmp_event)) {
                 /* Nothing obviously nicer than posting this error. */
-                error_report("%s: read() failed", __func__);
+                error_report("%s: eventfd_read() failed", __func__);
             }
 
             if (qatomic_read(&mis->fault_thread_quit)) {
@@ -1773,13 +1773,11 @@ void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page)
 
 void postcopy_fault_thread_notify(MigrationIncomingState *mis)
 {
-    uint64_t tmp64 = 1;
-
     /*
      * Wakeup the fault_thread.  It's an eventfd that should currently
      * be at 0, we're going to increment it to 1
      */
-    if (write(mis->userfault_event_fd, &tmp64, 8) != 8) {
+    if (eventfd_write(mis->userfault_event_fd, 1)) {
         /* Not much we can do here, but may as well report it */
         error_report("%s: incrementing failed: %s", __func__,
                      strerror(errno));
-- 
2.54.0


