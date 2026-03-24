Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B69F54AD7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54k1-00018S-RR; Tue, 24 Mar 2026 12:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54k0-00017m-9j
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jy-0004lJ-9d
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774370185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8d/kSXFJPxolA+ehSZUAyNS+VNAQPa/4/QOaVllsHk=;
 b=COppT6AzS2EE0Y+xVHKyW9i8p/npCdlJaXke76hh6vnjGrGTIooEw22wR3WFmdXDROOHNI
 Tv8ssnUhywI8Nx/MU3qF2jJQA1HSVISjH1gnFcxG7PYdFFT7xsKJfCPunq3tACvvoohuc7
 L8uHzYVgBuBKNKw446tvUSb4NHODsxc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-ZPQ3JTGMOuGSaid7EIB0xw-1; Tue,
 24 Mar 2026 12:36:23 -0400
X-MC-Unique: ZPQ3JTGMOuGSaid7EIB0xw-1
X-Mimecast-MFC-AGG-ID: ZPQ3JTGMOuGSaid7EIB0xw_1774370182
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EC6F18002CA; Tue, 24 Mar 2026 16:36:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.189])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CB471800107; Tue, 24 Mar 2026 16:36:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4/4] tests/functional/qemu_test: Silence warnings from pylint
 in config.py
Date: Tue, 24 Mar 2026 17:35:41 +0100
Message-ID: <20260324163543.55503-5-thuth@redhat.com>
In-Reply-To: <20260324163543.55503-1-thuth@redhat.com>
References: <20260324163543.55503-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pylint complains here:

 config.py:1:0: C0114: Missing module docstring (missing-module-docstring)
 config.py:28:4: W0719: Raising too general exception: Exception (broad-exception-raised)

Add a module description and replace the general Exception to fix this.
And while we're at it, and since we've got a proper module description
string now, also replace the copy-n-pasted comment at the top of the file
with a proper SPDX identifier.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/config.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index e0893f630ee..5d44b6fa4c0 100644
--- a/tests/functional/qemu_test/config.py
+++ b/tests/functional/qemu_test/config.py
@@ -1,4 +1,4 @@
-# Test class and utilities for functional tests
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright 2018, 2024 Red Hat, Inc.
 #
@@ -10,6 +10,9 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
+'''
+Functions related to the configuration of the tests and of the host system
+'''
 
 import os
 from pathlib import Path
@@ -25,9 +28,9 @@ def _build_dir():
     if root is not None:
         return Path(root)
 
-    raise Exception("Missing MESON_BUILD_ROOT environment variable. " +
-                    "Please use the '<BUILD-DIR>/run' script if invoking " +
-                    "directly instead of via make/meson")
+    raise RuntimeError("Missing MESON_BUILD_ROOT environment variable. " +
+                       "Please use the '<BUILD-DIR>/run' script if invoking " +
+                       "directly instead of via make/meson")
 
 BUILD_DIR = _build_dir()
 
-- 
2.53.0


