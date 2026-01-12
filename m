Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFCCC9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHld-0001Xo-1n; Mon, 12 Jan 2026 08:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlJ-0001Dn-0T
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlG-0002VG-3A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjMKzPxFT+2U5k7E3jIkUOtPx8Xv7ycoeQSEjk6D25k=;
 b=R8ii/bZ3DwI4Tkm4JElBVMdl+jdd+g5gFNCXIOOlGFXdh6yoYDCZyBHggk7/kDAW61NYji
 2d4WgRl/zejsm7C7EmIJD2lITxInJw5lXP1FDgyuXon9nd4rnKZi0/sT7F2cF/s7G4xFtr
 nz4A6UAYnJG20vCmQIkzMbloEEfzu6s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-LHkOQguxMHmwwNRbHagQPQ-1; Mon,
 12 Jan 2026 08:15:04 -0500
X-MC-Unique: LHkOQguxMHmwwNRbHagQPQ-1
X-Mimecast-MFC-AGG-ID: LHkOQguxMHmwwNRbHagQPQ_1768223703
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DDFB19540D7; Mon, 12 Jan 2026 13:15:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2478830001A2; Mon, 12 Jan 2026 13:15:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/15] tests/functional: Add a pylintrc file
Date: Mon, 12 Jan 2026 14:14:43 +0100
Message-ID: <20260112131457.67128-2-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Add a pylintrc file that can be used for checking the python code of
the functional tests. For the beginning, we use some rather lax settings.
We still can refine them later if we think that there's a need for it.

Message-Id: <20251119082636.43286-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS               |  1 +
 tests/functional/pylintrc | 84 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 tests/functional/pylintrc

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a46c7fd0b0..a6168cb46f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4461,6 +4461,7 @@ F: docs/devel/testing/functional.rst
 F: scripts/clean_functional_cache.py
 F: tests/functional/meson.build
 F: tests/functional/generic/meson.build
+F: tests/functional/pylintrc
 F: tests/functional/qemu_test/
 
 Windows Hosted Continuous Integration
diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
new file mode 100644
index 00000000000..049c3e76f12
--- /dev/null
+++ b/tests/functional/pylintrc
@@ -0,0 +1,84 @@
+# Config file for checking the functional tests with pylint
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+[DESIGN]
+
+# Maximum number of arguments for function / method.
+max-args=9
+
+# Maximum number of attributes for a class (see R0902).
+max-attributes=7
+
+# Maximum number of boolean expressions in an if statement (see R0916).
+max-bool-expr=5
+
+# Maximum number of branch for function / method body.
+max-branches=12
+
+# Maximum number of locals for function / method body.
+max-locals=15
+
+# Maximum number of parents for a class (see R0901).
+max-parents=7
+
+# Maximum number of positional arguments for function / method.
+max-positional-arguments=7
+
+# Maximum number of public methods for a class (see R0904).
+max-public-methods=20
+
+# Maximum number of return / yield for function / method body.
+max-returns=6
+
+# Maximum number of statements in function / method body.
+max-statements=50
+
+# Minimum number of public methods for a class (see R0903).
+min-public-methods=2
+
+
+[MESSAGES CONTROL]
+
+# Only show warnings with the listed confidence levels. Leave empty to show
+# all. Valid levels: HIGH, CONTROL_FLOW, INFERENCE, INFERENCE_FAILURE,
+# UNDEFINED.
+confidence=HIGH,
+           CONTROL_FLOW,
+           INFERENCE,
+           INFERENCE_FAILURE
+
+# Disable the message, report, category or checker with the given id(s). You
+# can either give multiple identifiers separated by comma (,) or put this
+# option multiple times (only on the command line, not in the configuration
+# file where it should appear only once). You can also use "--disable=all" to
+# disable everything first and then re-enable specific checks. For example, if
+# you want to run only the similarities checker, you can use "--disable=all
+# --enable=similarities". If you want to run only the classes checker, but have
+# no Warning level messages displayed, use "--disable=all --enable=classes
+# --disable=W".
+disable=bad-inline-option,
+        consider-using-f-string,
+        file-ignored,
+        fixme,
+        import-outside-toplevel,
+        locally-disabled,
+        logging-fstring-interpolation,
+        logging-not-lazy,
+        missing-function-docstring,
+        missing-module-docstring,
+        missing-class-docstring,
+        raw-checker-failed,
+        suppressed-message,
+        too-many-locals,
+        too-many-statements,
+        use-implicit-booleaness-not-comparison-to-string,
+        use-implicit-booleaness-not-comparison-to-zero,
+        use-symbolic-message-instead,
+        useless-suppression,
+
+
+[SIMILARITIES]
+
+# Minimum lines number of a similarity.
+min-similarity-lines=20
-- 
2.52.0


