Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4C4C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC5r-0006L1-AM; Sun, 09 Mar 2025 04:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC5a-00067X-Rr
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC5Y-0001T2-5m
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTnyTcBpC/OVMX6Bu6QPtWsGEQm0cp5L1qOn9B7o+U4=;
 b=jD/Vi7TThx4h8MsWfC8l1IIOwdzNBwWJHtBUPYrZnab4d0FLLpto5rl1AT9d7c7/61shwd
 uFyzBG7iurHc7ux67nyQNHcfLVe/Uc3fwtV6WjziRPPsYcLCtNYDgJd4lMLdc0djxpo0IS
 +PQ9N3oMcw2J5l1wxXG7rdZlEX/QPrM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-lm9lBJCwP6ijZ6mGWOL0pg-1; Sun,
 09 Mar 2025 04:32:41 -0400
X-MC-Unique: lm9lBJCwP6ijZ6mGWOL0pg-1
X-Mimecast-MFC-AGG-ID: lm9lBJCwP6ijZ6mGWOL0pg_1741509160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2339C19560A3; Sun,  9 Mar 2025 08:32:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B04F21828A8A; Sun,  9 Mar 2025 08:32:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 01/62] do-not-merge
Date: Sun,  9 Mar 2025 04:31:24 -0400
Message-ID: <20250309083228.1290253-2-jsnow@redhat.com>
In-Reply-To: <20250309083228.1290253-1-jsnow@redhat.com>
References: <20250309083228.1290253-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

Ad-hoc linting scripts to scrub down the new docs/sphinx files. Should
work with a reasonably modern mypy/pylint/etc, and Sphinx 8.2.0. Older
versions of Sphinx ought to still work at runtime, but may not type
check correctly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi-lint.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100755 scripts/qapi-lint.sh

diff --git a/scripts/qapi-lint.sh b/scripts/qapi-lint.sh
new file mode 100755
index 00000000000..738490352cd
--- /dev/null
+++ b/scripts/qapi-lint.sh
@@ -0,0 +1,57 @@
+#!/usr/bin/env bash
+set -e
+
+if [[ -f qapi/.flake8 ]]; then
+    echo "flake8 --config=qapi/.flake8 qapi/"
+    flake8 --config=qapi/.flake8 qapi/
+fi
+if [[ -f qapi/pylintrc ]]; then
+    echo "pylint --rcfile=qapi/pylintrc qapi/"
+    pylint --rcfile=qapi/pylintrc qapi/
+fi
+if [[ -f qapi/mypy.ini ]]; then
+    echo "mypy --config-file=qapi/mypy.ini qapi/"
+    mypy --config-file=qapi/mypy.ini qapi/
+fi
+
+if [[ -f qapi/.isort.cfg ]]; then
+    pushd qapi
+    echo "isort -c ."
+    isort -c .
+    popd
+fi
+
+if [[ -f ../docs/sphinx/qapi_domain.py ]]; then
+    files="qapi_domain.py"
+fi
+if [[ -f ../docs/sphinx/compat.py ]]; then
+    files="${files} compat.py"
+fi
+if [[ -f ../docs/sphinx/collapse.py ]]; then
+    files="${files} collapse.py"
+fi
+
+if [[ -f ../docs/sphinx/qapi_domain.py ]]; then
+    pushd ../docs/sphinx
+
+    set -x
+    mypy --strict $files
+    flake8 --max-line-length=80 $files qapidoc.py
+    isort -c $files qapidoc.py
+    black --line-length 80 --check $files qapidoc.py
+    PYTHONPATH=../../scripts/ pylint \
+        --rc-file ../../scripts/qapi/pylintrc \
+        $files qapidoc.py
+    set +x
+
+    popd
+fi
+
+pushd ../build
+#make -j13
+make check-qapi-schema
+rm -rf docs/
+#make docs
+#make sphinxdocs
+time pyvenv/bin/sphinx-build -v -j 8 -b html -d docs/manual.p/ ../docs/ docs/manual/;
+popd
-- 
2.48.1


