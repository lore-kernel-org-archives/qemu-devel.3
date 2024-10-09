Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D46CEDD91
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1z-0004rk-Jo; Wed, 09 Oct 2024 08:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1x-0004o1-O5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1v-0005VG-HS
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUYJvzmDsbGYqRdVrEwQI7vweQrLaFXP18fwBosGfqE=;
 b=WeVP7Dc6YMZbbdfveulU/EsHAywTpC9eeVwHnaym8vDOUMKhfG6EFvPN3VV2kB+TV9U5GE
 JvzM/dsoeakepDrcj3Z1AZBQslZXjB3NbLLErOekoQOMMWb3foo9rBx6gFduKK0tdScJkj
 j8UnvzvmAY8uHjuAm+H8rEwXVluPQ0A=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-83BBomIfMUuWJ6ft7-sXLA-1; Wed, 09 Oct 2024 08:43:01 -0400
X-MC-Unique: 83BBomIfMUuWJ6ft7-sXLA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-82ad9fca614so891879639f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477780; x=1729082580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUYJvzmDsbGYqRdVrEwQI7vweQrLaFXP18fwBosGfqE=;
 b=bplqf2N8Czj9tmYYwVkMBK5Ff+oPHq48MMo0n9iYrTgAxNV3i6/zep/oABSc1Lvlle
 irjKPMwf3rzh8LI+2bcH9EMwqkagC1fiDI+tA32Q2nT+CjHAyDMROOlM7wvWwNd4Jj5v
 BNRSqMU3ZxIblOuOqx/RguZe5hwOi4qIHdtQ1sxW/bXP3nkKJsUm/yQPvLvuG3IC4lyM
 J9B/8m6q84s2FULy+gT2X1j7X2rwmgZLCGnA5712FL1AbUAZ4yB2YrTYN1iStL6Awtao
 5YR0xpO2C71qtnXTCqOZpKmcH2BbHCFkz12AkvMh+qFiCJm2pBAUXad14DYaEqvRrx7D
 HrxA==
X-Gm-Message-State: AOJu0YyIg0WZnjYPW80+0iiOi6aP7AYmJvW423fU8vjsTkCore5TB1LP
 czFmoJ+f2lMPzJBYIQw7hZhou65dcJpQRfC7sWhfR8e/QOIcs/a9xH06oaZUPxWZxns/zdk/UFE
 JBR6Up1qx14xEcO4+uAmCxqI3kUHNlB2PH33VIiZWq8daEYpkkIgFWjpQVTuDB97bL977Xxy78L
 WaortBP3EaYWwlWARGfY8exm5mkbbpa0kxWg==
X-Received: by 2002:a05:6602:6422:b0:82c:d67d:aa91 with SMTP id
 ca18e2360f4ac-8353d3755d5mr300247039f.1.1728477780556; 
 Wed, 09 Oct 2024 05:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFegXQDOnOHEmm+cTK6FYpgTZ7aLMxJ1N6ar6u4x4PHSJCB1poFE5KRoeApDAVzQgEDiO8C1w==
X-Received: by 2002:a05:6602:6422:b0:82c:d67d:aa91 with SMTP id
 ca18e2360f4ac-8353d3755d5mr300243639f.1.1728477780239; 
 Wed, 09 Oct 2024 05:43:00 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 10/12] tests/migration-test: Wait for cancellation sooner in
 multifd cancel
Date: Wed,  9 Oct 2024 08:42:36 -0400
Message-ID: <20241009124238.371084-11-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

The source QEMU might not finish the cancellation of the migration
before we start setting up the next attempt. During the setup, the
test_migrate_start() function and others might need to interact with the
source in a way that is not possible unless the migration is fully
canceled. For example, setting capabilities when the migration is still
running leads to an error.

By moving the wait before the setup, we ensure this does not happen.

Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20240920161319.2337625-1-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 814ec109a6..95e45b5029 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3267,6 +3267,16 @@ static void test_multifd_tcp_cancel(void)
     qtest_wait_qemu(to);
     qtest_quit(to);
 
+    /*
+     * Ensure the source QEMU finishes its cancellation process before we
+     * proceed with the setup of the next migration. The test_migrate_start()
+     * function and others might want to interact with the source in a way that
+     * is not possible while the migration is not canceled properly. For
+     * example, setting migration capabilities when the migration is still
+     * running leads to an error.
+     */
+    wait_for_migration_status(from, "cancelled", NULL);
+
     args = (MigrateStart){
         .only_target = true,
     };
@@ -3282,8 +3292,6 @@ static void test_multifd_tcp_cancel(void)
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
 
-    wait_for_migration_status(from, "cancelled", NULL);
-
     migrate_ensure_non_converge(from);
 
     migrate_qmp(from, to2, NULL, NULL, "{}");
-- 
2.45.0


