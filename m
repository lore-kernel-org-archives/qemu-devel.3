Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F66DC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txiGq-00019V-Cb; Thu, 27 Mar 2025 04:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiGg-00012n-AR
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiGc-00067C-4P
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmC7BeGrHtiYw29etxp23105ZudT3hmL7Ks2UIdZshM=;
 b=f72PEjFsJoZOLIFH3sJxQl+YlsAprFb7kTlwY/kftEjXaBmBWObXJssFw1OcBYXIx6WeVh
 Y3LHJeydZLfdJocZgQGQ6X8GTq/PQsHbLJwjI9tCNnDJE0Pzn1QUthEFH1iY9oNYXdGzDA
 33nMYxGgnndBJ0nTIm8kN5Sk2y2wK0Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-ll-5yHE_NQq0AyFhGZ2VzQ-1; Thu,
 27 Mar 2025 04:06:34 -0400
X-MC-Unique: ll-5yHE_NQq0AyFhGZ2VzQ-1
X-Mimecast-MFC-AGG-ID: ll-5yHE_NQq0AyFhGZ2VzQ_1743062794
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91451801A06
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 08:06:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.126])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 525E619560AD; Thu, 27 Mar 2025 08:06:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/6] tests/functional/test_ppc64_replay: Mark the e500 test as
 flaky
Date: Thu, 27 Mar 2025 09:06:17 +0100
Message-ID: <20250327080622.954388-2-thuth@redhat.com>
In-Reply-To: <20250327080622.954388-1-thuth@redhat.com>
References: <20250327080622.954388-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The test_ppc64_e500 occasionally fails (it just hangs and finally times
out). The same issue could also be reproduced with the former Avocado
test already (especially if the host system is under heavy load), so
it's not a new regression. It's very likely the issue that has been
filed at https://gitlab.com/qemu-project/qemu/-/issues/2523 instead (e.g.
I could not reproduce the issue in older commits before commit 578912ad),
so use this URL for the reasoning in the the decorator.

Message-ID: <20250320065012.309520-1-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_replay.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_ppc64_replay.py b/tests/functional/test_ppc64_replay.py
index 48ce1b7f1e1..e8c9c4bcbf8 100755
--- a/tests/functional/test_ppc64_replay.py
+++ b/tests/functional/test_ppc64_replay.py
@@ -5,7 +5,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipFlakyTest
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +16,7 @@ class Ppc64Replay(ReplayKernelBase):
          'day19.tar.xz'),
         '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
 
+    @skipFlakyTest('https://gitlab.com/qemu-project/qemu/-/issues/2523')
     def test_ppc64_e500(self):
         self.set_machine('ppce500')
         self.cpu = 'e5500'
-- 
2.49.0


