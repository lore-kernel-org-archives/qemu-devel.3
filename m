Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D9CC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 06:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXF0E-0003vr-2z; Tue, 06 Feb 2024 01:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXF0B-0003vU-VD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 01:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXF0A-0006NQ-JH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 01:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707201133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5t41Qhy458Hyt5dhGbHHdP0wlL1cuvLJ7L+HinGkTHs=;
 b=UD5eQ4jGsorzNNfv2n6H6xPjlD5DdiPB1r8VEhCqBC7oI2QS5F9iq2Z2CoPQjML2BxxfX/
 wY7ViRx+z3IMk002ieqU02PvRfILxau2rXm15bfPfGOi0mADSu0HAPm5IpW+7HrHbv56EB
 IOuB3Hzyew4P23hXyqriguqGWfLz6oE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-8d0OReONPUG-tBAKvIPYmg-1; Tue, 06 Feb 2024 01:32:12 -0500
X-MC-Unique: 8d0OReONPUG-tBAKvIPYmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF2E0185A785;
 Tue,  6 Feb 2024 06:32:11 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D3E61C060AF;
 Tue,  6 Feb 2024 06:32:07 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 3/3] ci: Update comment for migration-compat-aarch64
Date: Tue,  6 Feb 2024 14:31:51 +0800
Message-ID: <20240206063151.215986-4-peterx@redhat.com>
In-Reply-To: <20240206063151.215986-1-peterx@redhat.com>
References: <20240206063151.215986-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

It turns out that we may not be able to enable this test even for the
upcoming v9.0.  Document what we're still missing.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index df48c9d31d..f01d6d0cdf 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -219,9 +219,10 @@ build-previous-qemu:
     - QTEST_QEMU_BINARY_DST=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
 
-# This job is disabled until we release 9.0. The existing
-# migration-test in 8.2 is broken on aarch64. The fix was already
-# commited, but it will only take effect once 9.0 is out.
+# This job needs to be disabled until we can have an aarch64 CPU model that
+# will both (1) support both KVM and TCG, and (2) provide a stable ABI.
+# Currently only "-cpu max" can provide (1), however it doesn't guarantee
+# (2).  Mark this test skipped until later.
 migration-compat-aarch64:
   extends: .migration-compat-common
   variables:
-- 
2.43.0


