Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76684C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGti-0000KU-DU; Mon, 17 Jun 2024 14:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGta-0000Du-Bp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtX-0006Ic-By
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tz8mAzBKLZeeLf11HYzcmc5ZaFjBtDHCXl7INRqRcO0=;
 b=cKw1qHDT/HVXqr7pWjlDlsqGIrzB3CswvtjP3KJKH4VMLAyBOjb2lzyJNlx9mHmGX3HDG/
 oEc5DEIXXgL0vIC2fGu90mLC0l58sv3pbPzg7JQycgkdzuDo+pbONOila213rbM20Xo67A
 evO+3MzIPZHLm7ZCe1ivlUXXpk1SYmU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-JdCNRSCiMQi51s2HSTKBng-1; Mon, 17 Jun 2024 14:15:51 -0400
X-MC-Unique: JdCNRSCiMQi51s2HSTKBng-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-375938907fbso6495385ab.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648150; x=1719252950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tz8mAzBKLZeeLf11HYzcmc5ZaFjBtDHCXl7INRqRcO0=;
 b=dAe1A+LKKU+tq036a+Mj/uU1VtCGu4ytTu/XNzyremDx3OYscUU5//XQ/TZGhfBZb7
 LJESN4rbTGgO1X78LynFdqDkeZpxeYEj1UENur2Ff3qyB+QMoBUT5OcESSAcSLQZdWDS
 mvv6DbS9ZEotAjmU+yy+z4Hxkbmg0k7aXRC8l5HPL8k0adyxDWB+HsUT5nAm8eodvtt7
 Uwq+JZOlhT6SHdtC5L1I28hBigg9LGfWBWq7IJJTTdVInnwU6+7Hwgy1LW+O/LXTaual
 X31TVVEyEB/8ipXFHGohdBrQ0JphUPovFszgBVTiN8G++QM9bhnDE/kvkXzZZSmh2/Ce
 iNSg==
X-Gm-Message-State: AOJu0YyRQhXJKE8/QJ0UaqyMcWjPCIqYCgaoUt34j45OAepPPjSV/8LB
 ABNtHfVG1XV4CdmFs05kSF2v958hYdnzXvdDKl6iE3wEqnEd4gP1Id0iBkBwis90XQZXdeaI17h
 xhkWIqfwJ0eQJPuUSA+GyKn9u5HRmvHnDv3915saYEwNWIO7rG1EfDFBs4FyExtwTd9lDJln9sr
 RxmURg+P1FAlB6hebBAtTc6QF1E+ZWw5DMQw==
X-Received: by 2002:a92:b707:0:b0:375:ca48:75e9 with SMTP id
 e9e14a558f8ab-375e0dfb7a1mr104926535ab.1.1718648149903; 
 Mon, 17 Jun 2024 11:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsdpZwwufKvv9xaiXPMQn4/OiydT5swjg2BC61HW1ns9+5wQhZNDmup98t4nik66MpxjpovQ==
X-Received: by 2002:a92:b707:0:b0:375:ca48:75e9 with SMTP id
 e9e14a558f8ab-375e0dfb7a1mr104926225ab.1.1718648149313; 
 Mon, 17 Jun 2024 11:15:49 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 07/10] tests/migration-tests: Drop most WIN32 ifdefs for
 postcopy failure tests
Date: Mon, 17 Jun 2024 14:15:31 -0400
Message-ID: <20240617181534.1425179-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7e3406471..13b59d4c10 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1353,9 +1353,9 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
                                                   "completed", NULL });
 }
 
-#ifndef _WIN32
 static void postcopy_recover_fail(QTestState *from, QTestState *to)
 {
+#ifndef _WIN32
     int ret, pair1[2], pair2[2];
     char c;
 
@@ -1417,8 +1417,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     close(pair1[1]);
     close(pair2[0]);
     close(pair2[1]);
+#endif
 }
-#endif /* _WIN32 */
 
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
@@ -1458,7 +1458,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
-#ifndef _WIN32
     if (args->postcopy_recovery_test_fail) {
         /*
          * Test when a wrong socket specified for recover, and then the
@@ -1467,7 +1466,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
         postcopy_recover_fail(from, to);
         /* continue with a good recovery */
     }
-#endif /* _WIN32 */
 
     /*
      * Create a new socket to emulate a new channel that is different
@@ -1496,7 +1494,6 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-#ifndef _WIN32
 static void test_postcopy_recovery_double_fail(void)
 {
     MigrateCommon args = {
@@ -1505,7 +1502,6 @@ static void test_postcopy_recovery_double_fail(void)
 
     test_postcopy_recovery_common(&args);
 }
-#endif /* _WIN32 */
 
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_recovery_tls_psk(void)
@@ -3486,10 +3482,8 @@ int main(int argc, char **argv)
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


