Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54197C48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 03:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHww-0004En-B6; Sun, 28 Jan 2024 22:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwv-0004Ee-9T
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwt-0002cl-AP
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5O48hzm3gfL1t5vlHM4mhcRlYYJEH9P+E36O4VJdn9I=;
 b=KkqCIJENU+KFLXCOzsBDevFK/oLvC/kgRG7JBPX4HDu4caG6+MLmcwaoEc/GuX7U9QaOWE
 jBlfb21IPhrQ1fLOYMWGkb/rz0GjCf6gr0IulUtJ9dtT7s8RcRft0pqJD5NuoVWRRjozxV
 ZwBpLBCVH/zYfAknywPl06EqrPqK2oM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-VFgd9EeHOjWaYj5QJAU2Eg-1; Sun, 28 Jan 2024 22:04:35 -0500
X-MC-Unique: VFgd9EeHOjWaYj5QJAU2Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3DEE185A780;
 Mon, 29 Jan 2024 03:04:34 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 500401121306;
 Mon, 29 Jan 2024 03:04:31 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 07/14] ci: Disable migration compatibility tests for aarch64
Date: Mon, 29 Jan 2024 11:03:58 +0800
Message-ID: <20240129030405.177100-8-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fabiano Rosas <farosas@suse.de>

Until 9.0 is out, we need to keep the aarch64 job disabled because the
tests always use the n-1 version of migration-test. That happens to be
broken for aarch64 in 8.2. Once 9.0 is out, it will become the n-1
version and it will bring the fixed tests.

We can revert this patch when 9.0 releases.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240118164951.30350-4-farosas@suse.de
[peterx: use _SKIPPED rather than _OPTIONAL]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f0b0edc634..79bbc8585b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -217,10 +217,14 @@ build-previous-qemu:
     - QTEST_QEMU_BINARY_DST=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
 
+# This job is disabled until we release 9.0. The existing
+# migration-test in 8.2 is broken on aarch64. The fix was already
+# commited, but it will only take effect once 9.0 is out.
 migration-compat-aarch64:
   extends: .migration-compat-common
   variables:
     TARGET: aarch64
+    QEMU_JOB_SKIPPED: 1
 
 migration-compat-x86_64:
   extends: .migration-compat-common
-- 
2.43.0


