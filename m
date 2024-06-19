Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05579C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pg-0001rp-2D; Wed, 19 Jun 2024 18:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pd-0001qx-5i
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pb-0008QA-79
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L38AJcNNqLJeaRvR67UdJo8JcCpE6ytDh1IVL/CID4c=;
 b=hdK4TT4PYCMgALSCjzwIJXNn/gDmllFB9ae1khrA1rFC79dZaXDzE/AAh+iMMPsaTtJlMx
 p+3XI/mBDDfKx6tbckd5wxVbIe9y3ey/JPbGzxO5krBMjB4zyEf61mA16EPyN+OXSJifF9
 qgmcw385TVsvtQy1B8+E3CeYCNdxBy4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-XBOJEqq9NH6ImVnFUeF-_g-1; Wed, 19 Jun 2024 18:31:05 -0400
X-MC-Unique: XBOJEqq9NH6ImVnFUeF-_g-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5b970b125fcso45188eaf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836264; x=1719441064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L38AJcNNqLJeaRvR67UdJo8JcCpE6ytDh1IVL/CID4c=;
 b=JEReZpsT7jPNhwZWB8DSQysVhTjOHoXToBq0LJKsxsN+eUZqGCHiT0wb9SLvpZFsY1
 n+6XIGr+JXUfsIkM6RUP0LXA/R9nEzkVpO7xXK4X739boDM5w8wE5HmAaGwC9wS7lRx9
 7ktRi6yiEOIUmMEhenf9hulFHB8qMopYOSE/UGP7SRfUOYhRAsRYtBKmDwAlNdAfW9y6
 L/9yihmtQBKoNidk/caKsFKn33avJx4ubpYYyGUCGzzuVNlfnqWUParMriOfnO3622+X
 6nkANa7mHFl5vTO5Fmr9uSweN7o6oCeVGvV8zOZSGvYtszVUl262qQon7CMZv3j5WwTO
 IeiQ==
X-Gm-Message-State: AOJu0Yy2CZbi4SI4/2pHeU67Z4fYGwKe1Jbo+blVz2oajJhAJG+XS+VW
 qxCvMcVgzwHW8hYJ9ZIayUOtJtwEeSq/2USjCrOxc+52Xr/QZksteEL5ZySVdGkpX/62Q9b40Lh
 869wgV1j5cSSc+8PFLmIx/SpoKS0id22qnPMP4C/Uvepfxs8x888NjYQ0wafZVqynJuzyInj1wD
 XOA3dt6J3tuCogGbjOQFtAC1/sa6VFCY0mAA==
X-Received: by 2002:a4a:3559:0:b0:5bb:815d:e2ab with SMTP id
 006d021491bc7-5c1adb96992mr3783189eaf.1.1718836264514; 
 Wed, 19 Jun 2024 15:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH38j0wnCHFa+BOv3PBcU22V8rrybAa4XrPGaQVggW659b1k1Cxx1i44VX79xVPfbeNHPqeqA==
X-Received: by 2002:a4a:3559:0:b0:5bb:815d:e2ab with SMTP id
 006d021491bc7-5c1adb96992mr3783160eaf.1.1718836263904; 
 Wed, 19 Jun 2024 15:31:03 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:31:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 07/11] tests/migration-tests: Drop most WIN32 ifdefs for
 postcopy failure tests
Date: Wed, 19 Jun 2024 18:30:42 -0400
Message-ID: <20240619223046.1798968-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Most of them are not needed, we can stick with one ifdef inside
postcopy_recover_fail() so as to cover the scm right tricks only.
The tests won't run on windows anyway due to has_uffd always false.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 85a21ff5e9..640713bfd5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1363,9 +1363,9 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
                                                   "completed", NULL });
 }
 
-#ifndef _WIN32
 static void postcopy_recover_fail(QTestState *from, QTestState *to)
 {
+#ifndef _WIN32
     int ret, pair1[2], pair2[2];
     char c;
 
@@ -1427,8 +1427,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     close(pair1[1]);
     close(pair2[0]);
     close(pair2[1]);
+#endif
 }
-#endif /* _WIN32 */
 
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
@@ -1468,7 +1468,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
-#ifndef _WIN32
     if (args->postcopy_recovery_test_fail) {
         /*
          * Test when a wrong socket specified for recover, and then the
@@ -1477,7 +1476,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
         postcopy_recover_fail(from, to);
         /* continue with a good recovery */
     }
-#endif /* _WIN32 */
 
     /*
      * Create a new socket to emulate a new channel that is different
@@ -1506,7 +1504,6 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-#ifndef _WIN32
 static void test_postcopy_recovery_double_fail(void)
 {
     MigrateCommon args = {
@@ -1515,7 +1512,6 @@ static void test_postcopy_recovery_double_fail(void)
 
     test_postcopy_recovery_common(&args);
 }
-#endif /* _WIN32 */
 
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_recovery_tls_psk(void)
@@ -3693,10 +3689,8 @@ int main(int argc, char **argv)
                            test_postcopy_preempt);
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
-#ifndef _WIN32
         migration_test_add("/migration/postcopy/recovery/double-failures",
                            test_postcopy_recovery_double_fail);
-#endif /* _WIN32 */
         if (is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.45.0


