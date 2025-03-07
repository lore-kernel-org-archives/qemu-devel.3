Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C8FC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWGm-0002Jq-F6; Fri, 07 Mar 2025 06:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGf-0002Im-Eq
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGc-0000Hm-UE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMXYg46E1/EKnELVNv+IsZFJNwROo+euEPEQdc5q1+M=;
 b=c1fKdsmuvneyhqTgn2cVft/QaqiINOhaEQb9LAMdViRTtWur2fydG+Z2MPhTy0SMX3svxW
 WcljG/db9Jc9laRyc1T5wVTmO0jhyxp/mcXbPckDIUyIn+cAd3FhMcQRctpJkNaNPthVpc
 bRcTGlbd0RPk7SucTjFCgTxzBMPcMqQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-rpJTABDjOTmo2DS93rYPhQ-1; Fri,
 07 Mar 2025 06:53:22 -0500
X-MC-Unique: rpJTABDjOTmo2DS93rYPhQ-1
X-Mimecast-MFC-AGG-ID: rpJTABDjOTmo2DS93rYPhQ_1741348401
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF25B19560B3; Fri,  7 Mar 2025 11:53:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A77C1944E45; Fri,  7 Mar 2025 11:53:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/15] tests/functional: remove unused 'bin_prefix' variable
Date: Fri,  7 Mar 2025 12:53:00 +0100
Message-ID: <20250307115314.1096373-2-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This was copied over from avocado but has not been used in the new
functional tests.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250228102738.3064045-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 869f3949fe9..9d5611c4d7f 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -192,7 +192,7 @@ def assets_available(self):
                     return False
         return True
 
-    def setUp(self, bin_prefix):
+    def setUp(self):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
         self.socketdir = None
@@ -254,7 +254,7 @@ def main():
 class QemuUserTest(QemuBaseTest):
 
     def setUp(self):
-        super().setUp('qemu-')
+        super().setUp()
         self._ldpath = []
 
     def add_ldpath(self, ldpath):
@@ -277,7 +277,7 @@ class QemuSystemTest(QemuBaseTest):
     def setUp(self):
         self._vms = {}
 
-        super().setUp('qemu-system-')
+        super().setUp()
 
         console_log = logging.getLogger('console')
         console_log.setLevel(logging.DEBUG)
-- 
2.48.1


