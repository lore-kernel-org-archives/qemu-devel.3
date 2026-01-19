Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C7ECCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhucJ-0002C0-Lp; Mon, 19 Jan 2026 14:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhuc9-00023a-CX
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhuc5-0000u9-2l
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768849712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pQtSxw25lsseQxtlDKzKY2GXSF9H+AJrIAZz2l5pKI=;
 b=TB9oXzKnGK8cZxPLUgKieRhYDe0mxwLh3/mRggA/tUXXBHggpFBWnzg2NmkoNTGtxR4Ccj
 KeXs+qsinnyG5tzpyp+qYi2eFUfWhHqzoVcF7WX9fW6R/yBCCFIKSojvHgFy1nByI47kWg
 Ra0/AFxkMGKNxHw7klGrcxMJ+Y9lhVk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-biK80lY4MFOz5hxu5b0EzA-1; Mon,
 19 Jan 2026 14:08:30 -0500
X-MC-Unique: biK80lY4MFOz5hxu5b0EzA-1
X-Mimecast-MFC-AGG-ID: biK80lY4MFOz5hxu5b0EzA_1768849710
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97FE218005B8; Mon, 19 Jan 2026 19:08:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C4FB180049F; Mon, 19 Jan 2026 19:08:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Richard Henderson <rth@twiddle.net>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/8] tracetool: apply isort and add check
Date: Mon, 19 Jan 2026 14:08:17 -0500
Message-ID: <20260119190823.867761-3-stefanha@redhat.com>
In-Reply-To: <20260119190823.867761-1-stefanha@redhat.com>
References: <20260119190823.867761-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Sort imports automatically, to keep the coding style more uniform.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251008063546.376603-3-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 python/tests/tracetool-isort.sh      | 4 ++++
 scripts/tracetool.py                 | 5 ++---
 scripts/tracetool/backend/dtrace.py  | 1 -
 scripts/tracetool/backend/ftrace.py  | 3 +--
 scripts/tracetool/backend/log.py     | 3 +--
 scripts/tracetool/backend/simple.py  | 1 -
 scripts/tracetool/backend/syslog.py  | 3 +--
 scripts/tracetool/backend/ust.py     | 1 -
 scripts/tracetool/format/d.py        | 2 +-
 scripts/tracetool/format/log_stap.py | 1 -
 scripts/tracetool/format/stap.py     | 1 -
 11 files changed, 10 insertions(+), 15 deletions(-)
 create mode 100755 python/tests/tracetool-isort.sh

diff --git a/python/tests/tracetool-isort.sh b/python/tests/tracetool-isort.sh
new file mode 100755
index 0000000000..b23f3d4844
--- /dev/null
+++ b/python/tests/tracetool-isort.sh
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+python3 -m isort --sp . -c ../scripts/tracetool/
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 0fdc9cb947..22fdc29e01 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -12,13 +12,12 @@
 __email__      = "stefanha@redhat.com"
 
 
-import sys
 import getopt
+import sys
 
-from tracetool import error_write, out, out_open
 import tracetool.backend
 import tracetool.format
-
+from tracetool import error_write, out, out_open
 
 _SCRIPT = ""
 
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index f0b58cc158..5f313ddaed 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -14,7 +14,6 @@
 
 from tracetool import out
 
-
 PUBLIC = True
 
 
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index e03698a2ed..0d77bd23a5 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -12,8 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out, expand_format_string
-
+from tracetool import expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 9e3e5046f5..bbfb56911d 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -12,8 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out, expand_format_string
-
+from tracetool import expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index b131e4fc19..b67257ce7e 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -14,7 +14,6 @@
 
 from tracetool import out
 
-
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
 
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 12b826593d..c3efab036c 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -12,8 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out, expand_format_string
-
+from tracetool import expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 3aa9bb1da2..a70e3d83e1 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -14,7 +14,6 @@
 
 from tracetool import out
 
-
 PUBLIC = True
 
 
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index e9e33dfe30..0befd444e8 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -12,9 +12,9 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
 from sys import platform
 
+from tracetool import out
 
 # Reserved keywords from
 # https://wikis.oracle.com/display/DTrace/Types,+Operators+and+Expressions
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 259303a189..99c6181f38 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -18,7 +18,6 @@
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
 
-
 STATE_SKIP = 0
 STATE_LITERAL = 1
 STATE_MACRO = 2
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 285c9203ba..f917bd7545 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -15,7 +15,6 @@
 from tracetool import out
 from tracetool.backend.dtrace import binary, probeprefix
 
-
 # Technically 'self' is not used by systemtap yet, but
 # they recommended we keep it in the reserved list anyway
 RESERVED_WORDS = (
-- 
2.52.0


