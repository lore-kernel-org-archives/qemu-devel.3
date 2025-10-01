Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3C8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yo7-0001ax-TU; Wed, 01 Oct 2025 11:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yo4-0001Zt-NW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ynf-0005s2-0A
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtJ6EpZ8mEfHufbAae3PmYl0gMcXLYONGFFms6VXKuo=;
 b=ElF/vVB4qTRMVac1uTYs7PDBYzV3RXZs6DXQvzjYEHTA9t/4eN8HtJbKPZggCEgf6wQrQq
 FHAqvcGZha4uLO2WPThPH3hqaOIvBxrjwEmQkUB0eTqQDE+U5tsxFk7WS6zpx3sDGRe5zu
 Rdz0v3q12KJSrulynVJUjp52XN0RUuo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-GbXTsRWRMvC7OIPX_zFEBA-1; Wed,
 01 Oct 2025 11:31:15 -0400
X-MC-Unique: GbXTsRWRMvC7OIPX_zFEBA-1
X-Mimecast-MFC-AGG-ID: GbXTsRWRMvC7OIPX_zFEBA_1759332672
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD1D1956086; Wed,  1 Oct 2025 15:31:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E134B1800446; Wed,  1 Oct 2025 15:31:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bandan Das <bsd@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Michael Roth <michael.roth@amd.com>, Mads Ynddal <mads@ynddal.dk>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 04/16] tracetool: add SPDX headers
Date: Wed,  1 Oct 2025 11:30:47 -0400
Message-ID: <20251001153059.194991-5-stefanha@redhat.com>
In-Reply-To: <20251001153059.194991-1-stefanha@redhat.com>
References: <20251001153059.194991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20250929154938.594389-5-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py                | 2 ++
 scripts/tracetool/backend/__init__.py        | 2 ++
 scripts/tracetool/backend/dtrace.py          | 2 ++
 scripts/tracetool/backend/ftrace.py          | 2 ++
 scripts/tracetool/backend/log.py             | 2 ++
 scripts/tracetool/backend/simple.py          | 2 ++
 scripts/tracetool/backend/syslog.py          | 2 ++
 scripts/tracetool/backend/ust.py             | 2 ++
 scripts/tracetool/format/__init__.py         | 2 ++
 scripts/tracetool/format/c.py                | 2 ++
 scripts/tracetool/format/d.py                | 2 ++
 scripts/tracetool/format/h.py                | 2 ++
 scripts/tracetool/format/log_stap.py         | 2 ++
 scripts/tracetool/format/simpletrace_stap.py | 2 ++
 scripts/tracetool/format/stap.py             | 2 ++
 scripts/tracetool/format/ust_events_c.py     | 2 ++
 scripts/tracetool/format/ust_events_h.py     | 2 ++
 17 files changed, 34 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 9dd8ec27e1..c4fa0f74e6 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Machinery for generating tracing-related intermediate files.
 """
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 7040130919..bf91e443e9 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Backend management.
 
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index 4835454193..b4af403025 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 DTrace/SystemTAP backend.
 """
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index e6317ca4bf..a14aafcee6 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Ftrace built-in backend.
 """
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 9842522b18..faacec4610 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Stderr built-in backend.
 """
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 066e5e9f11..97e40495ee 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Simple built-in backend.
 """
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 74af038089..78ee67136b 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Syslog built-in backend.
 """
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 6cc651646d..3aa9bb1da2 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 LTTng User Space Tracing backend.
 """
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 94a37bfce9..7b9d1b5782 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Format management.
 
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 3c4398c237..50e03313cb 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-tracers.c
 """
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index 684598c183..e9e33dfe30 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-tracers.dtrace (DTrace only).
 """
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 2119753be1..be7f32e67b 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-tracers.h
 """
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 02f23bfb8d..259303a189 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Generate .stp file that printfs log messages (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index 3c3584a931..c7bde97a85 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Generate .stp file that outputs simpletrace binary traces (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 04c7a35a25..285c9203ba 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Generate .stp file (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index ea5f0ae99f..074226bfd3 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-ust.c
 """
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 242c9814fd..cee7970a40 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-ust-provider.h
 """
-- 
2.51.0


