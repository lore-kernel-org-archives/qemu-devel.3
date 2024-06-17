Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC45EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJI86-0001IF-Is; Mon, 17 Jun 2024 15:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJI7z-0001HS-Rj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJI7y-0002ny-3a
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718652892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Nsi1rGNBpDS621kGMYVJWeNDvtz4ustbSwyS0V891U=;
 b=WD3DC76a8qZmffVwYITYDRy1bzoZyYy3W4tntOjo7amZHVgCJvFXjHvMXZNn7yc5X8kb+v
 QE8eNNpcXT3i5BR0skEYQn+mAZbkV+qOXu3jFIprHo8QESIOFxT2fpOUWdsw/B8G0ZqbEH
 0B+05GabrpSphacJAWbc/yWyW7K78KM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-O-RbGq6KNRu42kdS1rj2Rg-1; Mon, 17 Jun 2024 15:34:51 -0400
X-MC-Unique: O-RbGq6KNRu42kdS1rj2Rg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ad803bc570so9753916d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 12:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718652890; x=1719257690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Nsi1rGNBpDS621kGMYVJWeNDvtz4ustbSwyS0V891U=;
 b=n8Y8Lp/s/ZVAGkbGTOdYfuLEid49Guxrp0Htn2VEornytiM7exQJg0qmQqJp4o1WmO
 uou1c8qL3cAPWG++qTaixT9ZrYafJTcJg7NSrmO1VRW5s6FnZqMMJGZtke8z6IrD7oMq
 +lcPL7eRqXqCUoXacSTG8xUdMuplIjGwxN8Lu4XlYQp4ACnRQBabshNQnJ6ase5lRGK6
 55fTDyDyBjddclhXJpmH01WANqP56rLQLhZPBjvlcwj8oNTCGceAae225JvuGzz33Omo
 CKytPpyynSnZb2779mlMfU8/3eMC4EyE92k50NTi01xks2b4h0Kilp/NnWRmaS/EbUZr
 7KIA==
X-Gm-Message-State: AOJu0Yzr41BljgkObRwLL8FQF9JpQXQ8Grlub8vvOX/G7X2JY6mrnCOd
 z465RXztsAvUZ0OE7ah9V+mHd3grq+9BjfPmM8B0FXQDxvst+jq7K9BpAFE8b3czamvmuJMVmtx
 PBaPJKn5Lyb4uIYCE2QWm9e2HwADlUHC65NaHsxXTKkBn8BP3Ov2ZoDV4e9DPyzsH1vfQRss7rs
 RTbihqUHIW26zk36Ca74lVtALIvvwvmJm1Aw==
X-Received: by 2002:a0c:d60d:0:b0:6b2:b03d:edec with SMTP id
 6a1803df08f44-6b2b03def09mr115805916d6.3.1718652890107; 
 Mon, 17 Jun 2024 12:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8i2YOhbnpx9pz1Q2jYlxt+lkumMCIgfZw7sILHJ/SKKkgkMv8F7hU1RdVqGyxs2YSQuYGvA==
X-Received: by 2002:a0c:d60d:0:b0:6b2:b03d:edec with SMTP id
 6a1803df08f44-6b2b03def09mr115805506d6.3.1718652889315; 
 Mon, 17 Jun 2024 12:34:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5ee02d5sm58835566d6.112.2024.06.17.12.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 12:34:48 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:34:46 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 00/10] migration: New postcopy state, and some cleanups
Message-ID: <ZnCP1uVDNP2GQ4ZA@x1n>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Hello,

On Mon, Jun 17, 2024 at 02:15:24PM -0400, Peter Xu wrote:
> v2:
> - Collect tags
> - Patch 3
>   - cover all states in migration_postcopy_is_alive()
> - Patch 4 (old)
>   - English changes [Fabiano]
>   - Split the migration_incoming_state_setup() cleanup into a new patch
>     [Fabiano]
>   - Drop RECOVER_SETUP in fill_destination_migration_info() [Fabiano]
>   - Keep using explicit state check in migrate_fd_connect() for resume
>     [Fabiano]
> - New patches
>   - New doc update: "migration/docs: Update postcopy recover session for
>     SETUP phase"
>   - New test case: last four patches

I just found that this won't apply on top of latest master, and also has a
trivial conflict against the direct-io stuffs.  Fabiano, I'll wait for a
few days on comments, and resend v3 on top of your direct-io stuff.

Meanwhile I also plan to squash below fixup to the last test patch, just to
fix up a spelling error I just found, and also renamed the test cases (as
the new test is actually also a "double failure" test, just at different
phase).  Comments welcomed for that fixup even before a repost.

===8<===
From 5b8fbc3a9d9e87ebfef1a3e5592fd196eecd5923 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jun 2024 14:40:15 -0400
Subject: [PATCH] fixup! tests/migration-tests: Cover postcopy failure on
 reconnect

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a4fed4cc6b..fe33b86783 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1474,7 +1474,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to,
 
     /*
      * Kick dest QEMU out too. This is normally not needed in reality
-     * because when the channel is shutdown it should also happens on src.
+     * because when the channel is shutdown it should also happen on src.
      * However here we used separate socket pairs so we need to do that
      * explicitly.
      */
@@ -1565,7 +1565,7 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-static void test_postcopy_recovery_double_fail(void)
+static void test_postcopy_recovery_fail_handshake(void)
 {
     MigrateCommon args = {
         .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
@@ -1574,7 +1574,7 @@ static void test_postcopy_recovery_double_fail(void)
     test_postcopy_recovery_common(&args);
 }
 
-static void test_postcopy_recovery_channel_reconnect(void)
+static void test_postcopy_recovery_fail_reconnect(void)
 {
     MigrateCommon args = {
         .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
@@ -3759,10 +3759,10 @@ int main(int argc, char **argv)
                            test_postcopy_preempt);
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
-        migration_test_add("/migration/postcopy/recovery/double-failures",
-                           test_postcopy_recovery_double_fail);
-        migration_test_add("/migration/postcopy/recovery/channel-reconnect",
-                           test_postcopy_recovery_channel_reconnect);
+        migration_test_add("/migration/postcopy/recovery/double-failures/handshake",
+                           test_postcopy_recovery_fail_handshake);
+        migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
+                           test_postcopy_recovery_fail_reconnect);
         if (is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.45.0


-- 
Peter Xu


