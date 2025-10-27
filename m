Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A592DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLKZ-0004YC-7L; Mon, 27 Oct 2025 07:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDLKV-0004WA-AF
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDLKQ-0002AJ-FZ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761564235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dKpn1vEgIXfzf7xx4xzs4yYZeqJRzcWZp7pBSPtwSQc=;
 b=TkYxYX7Fgp6+aB0SMyrA9P2MvfBYQGGgVoL4khMpQGZHV3n2j4ypzuvsTaQwHnpOwvGPSE
 2bj5IfCH7qH6B8AwRTsZ4CkpCneG+tlGE7/V6VeqO6ip+VRCXtVp88m0Cs09H2h/gwGpT3
 8guhC+DR6wK8QG9wpXNu41lOu6T8J9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-cuQrY0YNN92enOrCCwer8w-1; Mon,
 27 Oct 2025 07:23:52 -0400
X-MC-Unique: cuQrY0YNN92enOrCCwer8w-1
X-Mimecast-MFC-AGG-ID: cuQrY0YNN92enOrCCwer8w_1761564231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 568DF180034C; Mon, 27 Oct 2025 11:23:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F3C31955F1B; Mon, 27 Oct 2025 11:23:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] tests/functional/migration: Fix bad indentation
Date: Mon, 27 Oct 2025 12:23:47 +0100
Message-ID: <20251027112347.54190-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

pylint complains about bad indentation in two lines. Use 12 spaces
instead of 11 spaces to get it right.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 07395544832..2bfb1f77901 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -30,11 +30,11 @@ def assert_migration(self, src_vm, dst_vm):
 
         end = time.monotonic() + self.timeout
         while time.monotonic() < end and not self.migration_finished(src_vm):
-           time.sleep(0.1)
+            time.sleep(0.1)
 
         end = time.monotonic() + self.timeout
         while time.monotonic() < end and not self.migration_finished(dst_vm):
-           time.sleep(0.1)
+            time.sleep(0.1)
 
         self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
-- 
2.51.0


