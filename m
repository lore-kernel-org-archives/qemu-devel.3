Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D49D32D9C
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 11:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tApSO-0005Tg-Gd; Tue, 12 Nov 2024 06:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tApSM-0005TY-8U
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 06:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tApSK-0002DP-My
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 06:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731412390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jH7VR/ZL+/BrSMhgn2dLYEoyqhJ1fXW3y7DynU3Iq8A=;
 b=cdCbaIuhet+cckvqLXApsGC8Me8bJi78JiFU/6vmrnmfgv7QwrM6dSd49znBWYWgo3dFbE
 fXjeXAeIhnkhEw7QiYkMiB048rE/F43AK8rLacgvLzbjUYOlAuIXuHgCSEuvtohO7DFHVM
 gmyEyXPdDLWbJtwqAFRGvY1wyOJIc+A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-xL8S0qoGMc2jOn9TSIyDUQ-1; Tue,
 12 Nov 2024 06:53:08 -0500
X-MC-Unique: xL8S0qoGMc2jOn9TSIyDUQ-1
X-Mimecast-MFC-AGG-ID: xL8S0qoGMc2jOn9TSIyDUQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A02C7195608C; Tue, 12 Nov 2024 11:53:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C1FA1956086; Tue, 12 Nov 2024 11:53:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] docs/devel/testing/functional: Clarify that we have to use
 the build folder
Date: Tue, 12 Nov 2024 12:53:02 +0100
Message-ID: <20241112115302.470527-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

Make it clear that the commands have to be run from the folder with the
build, and use the python3 from our pyvenv to make sure that the
pycotap module is available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index bf6f1bb81e..7f55177a9e 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -59,11 +59,12 @@ To run a single test file without the meson test runner, you can also
 execute the file directly by specifying two environment variables first,
 the PYTHONPATH that has to include the python folder and the tests/functional
 folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
-to the QEMU binary that should be used for the test, for example::
+to the QEMU binary that should be used for the test. The current working
+directory should be your build folder. For example::
 
   $ export PYTHONPATH=../python:../tests/functional
   $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
-  $ python3 ../tests/functional/test_file.py
+  $ pyvenv/bin/python3 ../tests/functional/test_file.py
 
 Overview
 --------
-- 
2.47.0


