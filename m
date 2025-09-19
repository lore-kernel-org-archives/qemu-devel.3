Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6696CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZFw-0001ST-MR; Fri, 19 Sep 2025 07:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFj-00019Z-PZ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFd-000175-2R
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qC/oc9ByBmOmIWG6qdhlMU6ELlFitIqUwb1IKWEE4CE=;
 b=W424sAOnpftYpEflM3qdaixFXOE5kxrVylEErG+we4tIw7tCWYlZb+eAHZo+z/h9IB+H0N
 f0VbfZBcMoo/t3bVi3V1bVO2ywsT01CtMGn0kvsYuNzCPo92E7dY6PSAy45Oqeb2/NTTXo
 N3ki8EHswtTnl+SoA3d0DmtRWSMeBuI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-6VlCPdZBNX6_AA_fEgmr2A-1; Fri,
 19 Sep 2025 07:25:57 -0400
X-MC-Unique: 6VlCPdZBNX6_AA_fEgmr2A-1
X-Mimecast-MFC-AGG-ID: 6VlCPdZBNX6_AA_fEgmr2A_1758281156
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A04A719560AD; Fri, 19 Sep 2025 11:25:56 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0268430002C5; Fri, 19 Sep 2025 11:25:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 03/16] treewide: remove unnessary "coding" header
Date: Fri, 19 Sep 2025 13:25:23 +0200
Message-ID: <20250919112536.141782-4-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The "-*- coding: utf-8 -*-" header was needed in Python 2,
but in Python 3 UTF-8 is already the default encoding of
source files.

It is even less necessary in .css files that do not have UTF-8
sequences at all.

Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/conf.py                                   | 2 --
 docs/sphinx-static/theme_overrides.css         | 3 +--
 scripts/analyse-locks-simpletrace.py           | 1 -
 scripts/modinfo-collect.py                     | 1 -
 scripts/modinfo-generate.py                    | 1 -
 scripts/oss-fuzz/minimize_qtest_trace.py       | 1 -
 scripts/oss-fuzz/output_reproducer.py          | 1 -
 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py | 1 -
 scripts/probe-gdb-support.py                   | 1 -
 scripts/qapi/error.py                          | 2 --
 scripts/qapi/expr.py                           | 2 --
 scripts/qapi/gen.py                            | 2 --
 scripts/qapi/parser.py                         | 2 --
 scripts/qapi/schema.py                         | 2 --
 scripts/qemu-plugin-symbols.py                 | 1 -
 scripts/qemugdb/tcg.py                         | 2 --
 scripts/qemugdb/timers.py                      | 1 -
 scripts/replay-dump.py                         | 1 -
 scripts/tracetool.py                           | 1 -
 scripts/tracetool/__init__.py                  | 2 --
 scripts/tracetool/backend/__init__.py          | 2 --
 scripts/tracetool/backend/dtrace.py            | 2 --
 scripts/tracetool/backend/ftrace.py            | 2 --
 scripts/tracetool/backend/log.py               | 2 --
 scripts/tracetool/backend/simple.py            | 2 --
 scripts/tracetool/backend/syslog.py            | 2 --
 scripts/tracetool/backend/ust.py               | 2 --
 scripts/tracetool/format/__init__.py           | 2 --
 scripts/tracetool/format/c.py                  | 2 --
 scripts/tracetool/format/d.py                  | 2 --
 scripts/tracetool/format/h.py                  | 2 --
 scripts/tracetool/format/log_stap.py           | 2 --
 scripts/tracetool/format/simpletrace_stap.py   | 2 --
 scripts/tracetool/format/stap.py               | 2 --
 scripts/tracetool/format/ust_events_c.py       | 2 --
 scripts/tracetool/format/ust_events_h.py       | 2 --
 36 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index e09769e5f83..0c9ec74097f 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QEMU documentation build configuration file, created by
 # sphinx-quickstart on Thu Jan 31 16:40:14 2019.
 #
diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index b225bf706f5..f312e9b57e4 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -1,5 +1,4 @@
-/* -*- coding: utf-8; mode: css -*-
- *
+/*
  * Sphinx HTML theme customization: read the doc
  * Based on Linux Documentation/sphinx-static/theme_overrides.css
  */
diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks-simpletrace.py
index d650dd71408..bd04cd43c94 100755
--- a/scripts/analyse-locks-simpletrace.py
+++ b/scripts/analyse-locks-simpletrace.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 #
 # Analyse lock events and compute statistics
 #
diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
index 48bd92bd618..6ebaea989db 100644
--- a/scripts/modinfo-collect.py
+++ b/scripts/modinfo-collect.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 import os
 import sys
diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index b1538fcced7..aaf23544c46 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 import os
 import sys
diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
index d1f3990c16a..414a6d91dd8 100755
--- a/scripts/oss-fuzz/minimize_qtest_trace.py
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 This takes a crashing qtest trace and tries to remove superfluous operations
diff --git a/scripts/oss-fuzz/output_reproducer.py b/scripts/oss-fuzz/output_reproducer.py
index e8ef76b3413..0df96cf9587 100755
--- a/scripts/oss-fuzz/output_reproducer.py
+++ b/scripts/oss-fuzz/output_reproducer.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 Convert plain qtest traces to C or Bash reproducers
diff --git a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
index b154a25508f..8af0d5d9c4e 100755
--- a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
+++ b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 Use this to convert qtest log info from a generic fuzzer input into a qtest
diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 6bcadce1500..43c70302873 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# coding: utf-8
 #
 # Probe gdb for supported architectures.
 #
diff --git a/scripts/qapi/error.py b/scripts/qapi/error.py
index e35e4ddb26a..f73bc553db6 100644
--- a/scripts/qapi/error.py
+++ b/scripts/qapi/error.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # Copyright (c) 2017-2019 Red Hat Inc.
 #
 # Authors:
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index cae0a083591..f40b247f8b6 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # Copyright IBM, Corp. 2011
 # Copyright (c) 2013-2021 Red Hat Inc.
 #
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index d3c56d45c89..0c9b8db3b02 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QAPI code generation
 #
 # Copyright (c) 2015-2019 Red Hat Inc.
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 2529edf81aa..9fbf80a5410 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QAPI schema parser
 #
 # Copyright IBM, Corp. 2011
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 3abddea3525..8d88b40de2e 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QAPI schema internal representation
 #
 # Copyright (c) 2015-2019 Red Hat Inc.
diff --git a/scripts/qemu-plugin-symbols.py b/scripts/qemu-plugin-symbols.py
index e285ebb8f9e..69644979c19 100755
--- a/scripts/qemu-plugin-symbols.py
+++ b/scripts/qemu-plugin-symbols.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 #
 # Extract QEMU Plugin API symbols from a header file
 #
diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
index 16c03c06a94..22529c72775 100644
--- a/scripts/qemugdb/tcg.py
+++ b/scripts/qemugdb/tcg.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # GDB debugging support, TCG status
 #
 # Copyright 2016 Linaro Ltd
diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 46537b27cf0..5714f92cc21 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -1,4 +1,3 @@
-# -*- coding: utf-8 -*-
 # GDB debugging support
 #
 # Copyright 2017 Linaro Ltd
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 4ce7ff51cc7..097636570dd 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 #
 # Dump the contents of a recorded execution stream
 #
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 5de9ce96d30..0fdc9cb9477 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 Command-line wrapper for the tracetool machinery.
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index afa889e759e..4f262d3394d 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Machinery for generating tracing-related intermediate files.
 """
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 6c6344deddb..70401309196 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Backend management.
 
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index e17edc9b9d8..4835454193d 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 DTrace/SystemTAP backend.
 """
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 5fa30ccc08e..e6317ca4bfb 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Ftrace built-in backend.
 """
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index eb50ceea34c..9842522b184 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Stderr built-in backend.
 """
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 7c84c06b200..066e5e9f11f 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Simple built-in backend.
 """
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 3f82e54aabf..74af0380899 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Syslog built-in backend.
 """
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index c857516f212..6cc651646dd 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 LTTng User Space Tracing backend.
 """
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 042fe7d103c..94a37bfce9f 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Format management.
 
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index e473fb6c6eb..3c4398c2373 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-tracers.c
 """
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index a5e096e214b..684598c1835 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-tracers.dtrace (DTrace only).
 """
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index bd9e0ca7f23..2119753be10 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-tracers.h
 """
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 710d62bffe4..c6577b52c3a 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Generate .stp file that printfs log messages (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index 72971133bf0..863187c806e 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Generate .stp file that outputs simpletrace binary traces (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 4d77fbc11a9..04c7a35a25f 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Generate .stp file (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index 569754a3048..ea5f0ae99fa 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-ust.c
 """
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 2a31fefeca1..242c9814fdc 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-ust-provider.h
 """
-- 
2.51.0



