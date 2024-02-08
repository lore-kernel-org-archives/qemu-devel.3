Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE98C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulG-0008An-Rl; Wed, 07 Feb 2024 22:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXul8-0007is-7g
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXul6-0004UI-FN
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yyTNfUk5Njdt3gYz4rbQl9fF1WbnjVbxLHTtUtcj4A=;
 b=d0i+T2KYJGNVVa5zi4CNTptKTIH4Caj0mQEkqew+w5pDJXcmZu3/AIWBxiuxCQZj86Z8d6
 TN46zliLvg44xMIcpLXtTSghjYK3pL3s8x5fXefbklUymBHh2Sdxup3S8lKCb8n6z6Dqhs
 4C14W19j84KfP8rsvbSETpCIloFoGoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-986EsJx0Ogedimj4tAckZw-1; Wed, 07 Feb 2024 22:07:23 -0500
X-MC-Unique: 986EsJx0Ogedimj4tAckZw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65C8E101FA2D;
 Thu,  8 Feb 2024 03:07:23 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AAA9492BC7;
 Thu,  8 Feb 2024 03:07:20 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 34/34] ci: Update comment for migration-compat-aarch64
Date: Thu,  8 Feb 2024 11:05:28 +0800
Message-ID: <20240208030528.368214-35-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Link: https://lore.kernel.org/r/20240207005403.242235-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfe95c1b17..f56df59c94 100644
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


