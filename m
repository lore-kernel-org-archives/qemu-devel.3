Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB48CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G8y-0000x4-D0; Mon, 29 Sep 2025 11:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8e-0000md-ED
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8S-0000LA-Nm
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCOPbYu7ryKrm76CAIdUgFO9Ove0c1exWjeI/Cavblo=;
 b=ieLIDOCraSGi0c+JhFP5Sgkg1E3oz4YhibRtK7vq1S6MFJdlfersinj4il/ZTTWOrpT6pc
 l3tEQTAksYjupEVigbDiMRJR1jWjay+294YdC0ksVUUsJz4g0BVRHv72C3/Q9KaYsCBuwl
 XPuXlXXRfei6ymK70fuj3ohcfSPc8xg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-yjX9C4c4PCeg14XRkqaQYg-1; Mon, 29 Sep 2025 11:49:53 -0400
X-MC-Unique: yjX9C4c4PCeg14XRkqaQYg-1
X-Mimecast-MFC-AGG-ID: yjX9C4c4PCeg14XRkqaQYg_1759160992
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6344e493258so4307515a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160991; x=1759765791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCOPbYu7ryKrm76CAIdUgFO9Ove0c1exWjeI/Cavblo=;
 b=R6YTmepVJ1YhIqIn3UH9JdF6JQZpQWxCFWK2wtXN3NMU5hd2x7FXHlMxETuLWUG6eo
 2ciCVvXXypmP3zm/eJK00w6vCeyAM+GULe0+PX7O3xtRmG2F+AuLOpP5TU2b/CUDUm7K
 fpFCfqLqTsuDIt8h1Ug2GVbov9ybao/w1wz4LOdGhKGHgJksbkl0bzABi8a6yk/T9GhB
 h1ildBgiGus7Kfoab53GntAZT+zC0MKLnboMegY6q9g4aX/lHV6LYDbykl5uaBejzpjt
 po8AFmzy995NONk9xRQSHWS5k/IPfJvJ72bjIZ8uPP9k4znW6l0DCyhumqbsZYd8tV/p
 yoJQ==
X-Gm-Message-State: AOJu0Yzwld4HSOikY/gOMl11t5di9WrzbXSEemQSm6rz9CHsz8J4TBJX
 WyS2qfFtO1kYXZS3D3nsu0XrMcz8yghtvRp8jFjaJZnkAP4Phq+cbbSwJx9R2Zvf0DcaucMehgL
 5DGZGi0ed+REV3Lg4ipzqr2CtP312tDIkEX6SXFaBZK6V4XQGdJcTCCQ+MjcneBRV0wFZAqxDPD
 AlsQZ7U5jawk5l6qdDcWaKf3JjI2Pqd9Mi+9vML5GS
X-Gm-Gg: ASbGncu4M2mPXwsxDPTDqk+6BdiOMnB9dRDVfaw8LXoxA2kfnkz3m18v+/ZUiLYxwTS
 4rYE1HSOQtp6YpVxOGyHVbKxPS2m6464qaU8qAH1fLum3OTU6IObwRrXu0R2JBSv8Ank2hW5GSB
 X6QdQ9cflryosL8ILCI+gnqu3ZJybrlA94vKTotKpOgHNKKIxFlVXncARHo+o11sgGvNRfD+pcR
 LWfEo+KvO/bHJpJp43dcCls9VTU7vceid1W3pZezpUWjQPYmwT0imPJvTOQCIFGhjJqZt6zcck+
 sBKYNQuSDEfH24gQeJ+3jtolXFpbk13+2FtJf1/fOl7Ky6CGLWEWpO3wiyd7nq7Zvm4ygtLEzbU
 WDf/rxGLEVuKaZZKo5p6Q7oVf1iazWbSdItjeviqCkrUX2A==
X-Received: by 2002:a05:6402:291:b0:634:544b:a756 with SMTP id
 4fb4d7f45d1cf-6349fa9464fmr12376234a12.32.1759160991331; 
 Mon, 29 Sep 2025 08:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG89lNt93/2CJxTZEWvqqvBpk4mU0wvXqR/CQaewsWXrhs+63GrZJGh6xBTe/G+o5aUNjIwmw==
X-Received: by 2002:a05:6402:291:b0:634:544b:a756 with SMTP id
 4fb4d7f45d1cf-6349fa9464fmr12376196a12.32.1759160990823; 
 Mon, 29 Sep 2025 08:49:50 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634c4b96ff6sm5541900a12.46.2025.09.29.08.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:49:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 04/16] tracetool: add SPDX headers
Date: Mon, 29 Sep 2025 17:49:26 +0200
Message-ID: <20250929154938.594389-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
index 9dd8ec27e15..c4fa0f74e6f 100644
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
index 02f23bfb8d2..259303a189d 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
 """
 Generate .stp file that printfs log messages (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index 3c3584a9318..c7bde97a855 100644
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


