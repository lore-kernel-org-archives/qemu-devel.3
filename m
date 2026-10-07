Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBA1CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUch-0004LZ-Np; Wed, 07 Oct 2026 12:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbW-00030M-7h
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbP-0006NK-Qn
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6fhptgUdVvtvxa3uKCowlnqh4v+Zi6Ke3pq4yfrjzo=;
 b=BcdFmAFn/7KbLsXRi847DC3WwNJH2fEGtYp/f7t2jmopyiYckdy5oLdwhqKYfgKb34jpG8
 6/UL0jmpRji7wRrDWYm4TPiuUMEVltxzRfUV4T3NGQJ8DhdTjCfWI+gxZ8N94oU4nKETcP
 ACoAvQocL2Q9z+vWx3+HGmoNiflofE0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-u4MjMR1HMNu2zZJTSrIOiA-1; Wed,
 07 Oct 2026 12:34:43 -0400
X-MC-Unique: u4MjMR1HMNu2zZJTSrIOiA-1
X-Mimecast-MFC-AGG-ID: u4MjMR1HMNu2zZJTSrIOiA_1791390882
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C53819772EC; Wed,  7 Oct 2026 16:34:42 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF1521956087; Wed,  7 Oct 2026 16:34:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/21] iotests: annotate TestRunner.shared_self for mypy 2.4
Date: Wed,  7 Oct 2026 18:32:57 +0200
Message-ID: <20261007163302.332250-17-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tim Pambor <timpambor@gmail.com>

mypy 2.4.0 infers the unannotated class attribute "shared_self = None"
as having type "None" and rejects the later assignment of a TestRunner
instance in run_tests_pool():

  testrunner.py:126: error: Incompatible types in assignment
  (expression has type "TestRunner", variable has type "None")

Earlier mypy versions treated the attribute as a partial type and
accepted the assignment. Give the attribute an explicit
Optional['TestRunner'] annotation so both old and new mypy agree.

Fixes tests/linters.py::TestLinters::test_mypy_iotests with mypy >= 2.4.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
Message-ID: <20261002-mypy-2-4-v1-1-185c406d1cbd@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/testrunner.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index cc36867719d..729680da4aa 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -108,7 +108,7 @@ def __init__(self, status: str, description: str = '',
 
 
 class TestRunner(contextlib.AbstractContextManager['TestRunner']):
-    shared_self = None
+    shared_self: Optional['TestRunner'] = None
 
     @staticmethod
     def proc_run_test(test: str, test_field_width: int) -> TestResult:
-- 
2.56.0


