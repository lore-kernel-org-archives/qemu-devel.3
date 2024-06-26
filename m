Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B18C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbyk-0000i2-Oz; Wed, 26 Jun 2024 19:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbyc-0000eh-Q1
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbyZ-0002qW-S5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719444174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXnieYXmBiBT140D1yWQStaAtYrvr8Ze4CKBLC3cBsg=;
 b=CTDA/+Z8pjB5FmRHRzERYT7WYfMi1H4eX3SCK7hFJ1iFhKDovte7ruNp3254dp0H0h1Zzx
 74eQWSxjRcRelZOdH6hRanXvFQAPN5WX82WsAaq0j1YFN/asEnAcxy2C13Q/FUHWxoVcSw
 7kTHOC9MKR5a2HOr5vAw12Y8OYJU69c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-AlG6fPNKNredV7WJE-XCjQ-1; Wed,
 26 Jun 2024 19:22:50 -0400
X-MC-Unique: AlG6fPNKNredV7WJE-XCjQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC8F11955F0D; Wed, 26 Jun 2024 23:22:47 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.58])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BD1C19560AB; Wed, 26 Jun 2024 23:22:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 3/4] iotests: Change imports for Python 3.13
Date: Wed, 26 Jun 2024 19:22:29 -0400
Message-ID: <20240626232230.408004-4-jsnow@redhat.com>
In-Reply-To: <20240626232230.408004-1-jsnow@redhat.com>
References: <20240626232230.408004-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Python 3.13 isn't out yet, but it's in beta and Fedora is ramping up to
make it the default system interpreter for Fedora 41.

They moved our cheese for where ContextManager lives; add a conditional
to locate it while we support both pre-3.9 and 3.13+.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/testenv.py    | 7 ++++++-
 tests/qemu-iotests/testrunner.py | 9 ++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 588f30a4f14..96d69e56963 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -25,7 +25,12 @@
 import random
 import subprocess
 import glob
-from typing import List, Dict, Any, Optional, ContextManager
+from typing import List, Dict, Any, Optional
+
+if sys.version_info >= (3, 9):
+    from contextlib import AbstractContextManager as ContextManager
+else:
+    from typing import ContextManager
 
 DEF_GDB_OPTIONS = 'localhost:12345'
 
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 7b322272e92..2e236c8fa39 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -27,11 +27,14 @@
 import shutil
 import sys
 from multiprocessing import Pool
-from typing import List, Optional, Any, Sequence, Dict, \
-        ContextManager
-
+from typing import List, Optional, Any, Sequence, Dict
 from testenv import TestEnv
 
+if sys.version_info >= (3, 9):
+    from contextlib import AbstractContextManager as ContextManager
+else:
+    from typing import ContextManager
+
 
 def silent_unlink(path: Path) -> None:
     try:
-- 
2.45.0


