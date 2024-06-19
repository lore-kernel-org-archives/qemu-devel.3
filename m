Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pl-0001to-Jc; Wed, 19 Jun 2024 18:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pk-0001tL-Hj
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pj-0008R3-4o
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDX+BRT7uTcZoq/ChEkBCspRZIFbadf0mqmyYyfPnsg=;
 b=SuuK63vIgM1jkeKkvTuthrVXzccRWyoIEAtEXWlD8AtUTl4+KN1wEnEPfMSaqrS8E4LTLJ
 Z5Ivrjutkwubl+wpD+r+3q1FcGrRcm5O+xUkscMe4DSrLzpwnT1bqhIpHSimlTCpyQz09z
 rZAcdS/NDiqRFtrwuDtjy0Jr9MHXCvg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-SJ90yNxQN46a7FIBho6uWQ-1; Wed, 19 Jun 2024 18:31:13 -0400
X-MC-Unique: SJ90yNxQN46a7FIBho6uWQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5b970b125fcso45216eaf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836272; x=1719441072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDX+BRT7uTcZoq/ChEkBCspRZIFbadf0mqmyYyfPnsg=;
 b=olAlHXvVBElNeJnsoSARaV7EsO0gEqFJ4CiJg7NHzWuCGWBi3qlms/rNWy6gE6sb12
 FGj6TtfKeIOiwBephgz6SvWQQmt+9xVwuWcr8Z/c5GWepNkW1WO2dbxSK1GTVWisV9Yk
 7ZuS8OmnTmb8ef1JdCE4OnZj505GVub17IkaICJueb2B7/F8UiTPiyItckAUdtNX262H
 A9C07BVq3f4xPHzO3HeBLpOLcanL0mmRNJdnlspbsVsUIIr8xskWxi9sOfg2tQnrZV2+
 cBT1SC9o3V9jUiwoB9ERHIPiFURmPTQKM+nDCTHIsslYoqyHDww/KymkUH0PqB959oZj
 +ZKA==
X-Gm-Message-State: AOJu0YzggBgJ/JaptPdFDQIaJlxrG7SEO4WHA5CY2xhciK6KtjM0HP3y
 6XbLQBzZ2dJrHKN0pLQ1f9O82/tbZSnmZK0xiybyJiic23GbPRoSNQoUAsoA6+LnZLdD/QvmzJX
 IINaik3G6EWBdBu+2EFCk+a//icnEIRuz4C1s2Hh7JIMRt8scCLZHvmOLSzTBPqG3oFuDr/x/2A
 +jryRKw8VDNvQN1wYlFobeUSBGDyhzIjXRJg==
X-Received: by 2002:a05:6830:2b26:b0:6fb:97fb:8d09 with SMTP id
 46e09a7af769-700733764afmr4202056a34.1.1718836271681; 
 Wed, 19 Jun 2024 15:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSyuTT/IdPzWkqHVui5o8WhFEehjxYkdSqtjZmbgbMSSaTXmFptTg59j7yX6MStwaydXENJA==
X-Received: by 2002:a05:6830:2b26:b0:6fb:97fb:8d09 with SMTP id
 46e09a7af769-700733764afmr4201955a34.1.1718836269041; 
 Wed, 19 Jun 2024 15:31:09 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:31:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 10/11] tests/migration-tests: Verify postcopy-recover-setup
 status
Date: Wed, 19 Jun 2024 18:30:45 -0400
Message-ID: <20240619223046.1798968-11-peterx@redhat.com>
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

Making sure the postcopy-recover-setup status is present in the postcopy
failure unit test.  Note that it only applies to src QEMU not dest.

This also introduces the tiny but helpful migration_event_wait() helper.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c015e801ac..de81e28088 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1412,6 +1412,12 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     migrate_recover(to, "fd:fd-mig");
     migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
+    /*
+     * Source QEMU has an extra RECOVER_SETUP phase, dest doesn't have it.
+     * Make sure it appears along the way.
+     */
+    migration_event_wait(from, "postcopy-recover-setup");
+
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
      * kicking them out using migrate-pause.
-- 
2.45.0


