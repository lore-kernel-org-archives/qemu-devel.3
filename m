Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA94FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjT-0007uJ-KS; Mon, 27 Apr 2026 05:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjL-0007lC-0q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjI-00087W-UG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5Jxuf5erNRILrW2WQrAEsFYkX/kGsStLYVOgq23PFw=;
 b=LmGwmrCHhpt9xyF7R5/vd2u3IUNUmnLy1/XOj3xDEvrMiN7lCaMRCt7thdTIy1fPZKzo9Z
 syDYrgh4Ws06wlcBWDQSnOlcD/SFribHXNIuE5I+H49GkiBe0rD8GAWYU3KxuwWGd2o6lN
 NU6oR4Gs5zeKhW3XY4hUECAdxVN2t2Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-sm1ka78GM3aL_57NMqH5hg-1; Mon,
 27 Apr 2026 05:58:14 -0400
X-MC-Unique: sm1ka78GM3aL_57NMqH5hg-1
X-Mimecast-MFC-AGG-ID: sm1ka78GM3aL_57NMqH5hg_1777283893
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 959C719560AF; Mon, 27 Apr 2026 09:58:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E71503000C20; Mon, 27 Apr 2026 09:58:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/10] tests/functional/qemu_test: Silence warnings from pylint
 in tesseract.py
Date: Mon, 27 Apr 2026 11:57:43 +0200
Message-ID: <20260427095747.1070244-7-thuth@redhat.com>
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
dots at the beginning of the file, and drop the license boilerplate text.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260422071145.244820-1-thuth@redhat.com>
---
 tests/functional/qemu_test/tesseract.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index 862faec2d2e..9d98181cb45 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -1,19 +1,21 @@
-# ...
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2019 Philippe Mathieu-Daudé
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


