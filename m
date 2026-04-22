Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6550F94CDB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFRkc-0002y3-A3; Wed, 22 Apr 2026 03:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFRka-0002xv-RX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 03:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFRkZ-00057t-4N
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 03:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776841913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eaQlHeS2B66KtbBSpxPnHICsU0t6joucprHWFKyGHjg=;
 b=H508fXlJDjuUV0bVDDF1yIlEQgvw/To1ScgeV5IRn6NQhMiC2MB8wfSUKltEPfsfAkASKZ
 Pe3AY/+QOdAl/3fDR6aFORohqcst+LA/5YgcFTAyfnk3z/mqkFQNBe4YsTZufXGO2EiooS
 xGFkf3yait2LhtO/5w3/qY/YNli7vr4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-4xHnqB1bMSei_E1DCU-t6A-1; Wed,
 22 Apr 2026 03:11:49 -0400
X-MC-Unique: 4xHnqB1bMSei_E1DCU-t6A-1
X-Mimecast-MFC-AGG-ID: 4xHnqB1bMSei_E1DCU-t6A_1776841908
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F9891800358; Wed, 22 Apr 2026 07:11:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25397180047F; Wed, 22 Apr 2026 07:11:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] tests/functional/qemu_test: Silence warnings from pylint
 in tesseract.py
Date: Wed, 22 Apr 2026 09:11:44 +0200
Message-ID: <20260422071145.244820-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
dots at the beginning of the file, and drop the license boilerplate text.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Drop the license boilerplate text as suggested by Philippe.

 tests/functional/qemu_test/tesseract.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index ede6c6501e2..2e84c1975c2 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -1,19 +1,21 @@
-# ...
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
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


