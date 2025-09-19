Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4554CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZFy-0001bm-VT; Fri, 19 Sep 2025 07:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFj-00019I-0b
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFg-00017U-PT
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsX3ehLIekzk9S1dI+eEKr3gFdTAOOk/k5p38t88fGY=;
 b=CBApmfZ+5quSTfN5fxSXZypOT7TZYNsjV0AIs5GOk3GC5GXiFv1axaO6SWLABXXMS3eW3o
 +jvYMrj//FuI5t0p/PUpt4WrnMIF4FaJavXCBTSdLs7vI9VCfvf+GubqRJg53ggVv1q1Hb
 ToI4lwF5Q5ya+D6W/NZctfk0k1iRYZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-u4ftFW8TPqGqYevVEKhRrA-1; Fri,
 19 Sep 2025 07:26:02 -0400
X-MC-Unique: u4ftFW8TPqGqYevVEKhRrA-1
X-Mimecast-MFC-AGG-ID: u4ftFW8TPqGqYevVEKhRrA_1758281161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B192180028D; Fri, 19 Sep 2025 11:26:01 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6608A30002C5; Fri, 19 Sep 2025 11:25:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 04/16] tracetool: add SPDX headers
Date: Fri, 19 Sep 2025 13:25:24 +0200
Message-ID: <20250919112536.141782-5-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 4f262d3394d..a58d7938658 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Machinery for generating tracing-related intermediate files.
 """
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 70401309196..bf91e443e99 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Backend management.
 
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index 4835454193d..b4af403025c 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 DTrace/SystemTAP backend.
 """
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index e6317ca4bfb..a14aafcee62 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Ftrace built-in backend.
 """
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 9842522b184..faacec46105 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Stderr built-in backend.
 """
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 066e5e9f11f..97e40495ee9 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Simple built-in backend.
 """
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 74af0380899..78ee67136b8 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Syslog built-in backend.
 """
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 6cc651646dd..3aa9bb1da29 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 LTTng User Space Tracing backend.
 """
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 94a37bfce9f..7b9d1b57826 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Format management.
 
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 3c4398c2373..50e03313cbf 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-tracers.c
 """
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index 684598c1835..e9e33dfe30a 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-tracers.dtrace (DTrace only).
 """
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 2119753be10..be7f32e67b9 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-tracers.h
 """
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index c6577b52c3a..e45d614ed47 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Generate .stp file that printfs log messages (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index 863187c806e..d33bae757ff 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Generate .stp file that outputs simpletrace binary traces (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 04c7a35a25f..285c9203ba7 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Generate .stp file (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index ea5f0ae99fa..074226bfd37 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 trace/generated-ust.c
 """
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 242c9814fdc..cee7970a403 100644
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



