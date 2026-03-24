Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D6FF54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54jq-00015k-Cd; Tue, 24 Mar 2026 12:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jm-000152-Sj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jk-0004jG-L6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774370168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EOmgni/KQ1xseWl4UKQ9gZG1695RjOvpdQ2UFYpGBs=;
 b=Xu78bHEcZBFH9zNq8TW53TN6dJjioy26pBbIO76Hc7y/YXz/qAn1cqAmbQAgm+aG50Ae9o
 W0LuTw1p6TBNh/Jx97KTW4V6iFXP/O7q3LCvShbOcCN+EjR0RhuQcGbBRM0kqcu4xszDWQ
 /QJ/s87izt3dArfzhziFUmi1klM0xL4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-iJz571bEP6m1Yh9mrn7lTA-1; Tue,
 24 Mar 2026 12:36:07 -0400
X-MC-Unique: iJz571bEP6m1Yh9mrn7lTA-1
X-Mimecast-MFC-AGG-ID: iJz571bEP6m1Yh9mrn7lTA_1774370166
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F32E18002CA; Tue, 24 Mar 2026 16:36:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.189])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8C5F180075C; Tue, 24 Mar 2026 16:36:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/4] tests/functional/qemu_test: Silence warnings from pylint
 in tesseract.py
Date: Tue, 24 Mar 2026 17:35:38 +0100
Message-ID: <20260324163543.55503-2-thuth@redhat.com>
In-Reply-To: <20260324163543.55503-1-thuth@redhat.com>
References: <20260324163543.55503-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Pylint complains:

 tesseract.py:1:0: C0114: Missing module docstring (missing-module-docstring)
 tesseract.py:12:0: C0116: Missing function or method docstring (missing-function-docstring)
 tesseract.py:15:11: W1510: 'subprocess.run' used without explicitly defining the value for 'check'. (subprocess-run-check)
 tesseract.py:12:30: W0613: Unused argument 'tesseract_args' (unused-argument)

Thus add the missing bits and remove the unused tesseract_args argument.
While we're at it, also add a SPDX identifier instead of the weird three
dots at the beginning of the file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/tesseract.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index ede6c6501e2..1f955d32b76 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -1,19 +1,24 @@
-# ...
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
+'''
+Tesseract is an program for doing Optical Character Recognition (OCR),
+which can be used in the tests to extract text from screenshots.
+'''
 
 import logging
 from subprocess import run
 
 
-def tesseract_ocr(image_path, tesseract_args=''):
+def tesseract_ocr(image_path):
+    ''' Run the tesseract OCR to extract text from a screenshot '''
     console_logger = logging.getLogger('console')
     console_logger.debug(image_path)
     proc = run(['tesseract', image_path, 'stdout'],
-               capture_output=True, encoding='utf8')
+               capture_output=True, encoding='utf8', check=False)
     if proc.returncode:
         return None
     lines = []
-- 
2.53.0


