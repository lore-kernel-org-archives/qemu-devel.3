Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EE2CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9f-0001Qu-0X; Mon, 29 Sep 2025 11:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8s-0000qT-L3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8b-0000M7-VL
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XE480yyfhzYbFzSjQEPQSJUuYLlL1XqwbZWj8rCIyyA=;
 b=W/ExqNW9rpwr7xFMgWlw/pZsd4RqPMbqUTskTr25Nw+gMTMPlv4WX1uFe16z0KmlLegG3j
 HO/hmNP0v+IezxNZe9jBnRSsFhOyvjODgxTgfJiKJNWzB7KdKflB4GyaOpjcO5df9FbAIN
 4M/wKFB7GXmJia/XkB63dkz2VwUlREo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-xZSvEbDnMSyd-5895AJw-Q-1; Mon, 29 Sep 2025 11:49:59 -0400
X-MC-Unique: xZSvEbDnMSyd-5895AJw-Q-1
X-Mimecast-MFC-AGG-ID: xZSvEbDnMSyd-5895AJw-Q_1759160998
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-634700fe857so6483801a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160998; x=1759765798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XE480yyfhzYbFzSjQEPQSJUuYLlL1XqwbZWj8rCIyyA=;
 b=M2oZWqM5oLxVXV03WRD6X31kFhSoxbGIQ55vlkUx8Gbw7OSgdZZXefMsENGIe4R3Ij
 xyTyh3RAnXGf5v3rhm9JZNW/4tvj8XOPYgJbHv+fuC1PsGRWAacAFCvXL/9wCw7Nkop3
 wslI0yGQxIoROz+CJih3q0JxZ+bdUtPjfGWNZMJRuEums3w1eYZGSQO9LYbSzsjyKvWA
 U2GHXrLI9RbWkIlVe/wOH5tl1cCrwkxd7P1lhn9O7wNmGj1TT+0Z82EDwZ2uB0KzSIf1
 zjSPW/FQZTeGBLBW+I0dFEUS5qHG+emHO2T2EREEOcgWmMsWGefydJIqfHRKr6es3Rsu
 fpWw==
X-Gm-Message-State: AOJu0Yw4t7/Z9TOQ0tsGV1lK1jf+6hn/duH25mcljicV04+O6QQGvW/7
 8bUNP2IbO79fmpF176BWHRY8FhROp13yh7/4PQTRgyG/6T45OuZPauzfOCaIzzR5KRMt9hDtq4a
 qG00+vcB4Z35E8vZFD9cu8971YLs37OnqqmGWL18LajiGUEy/Cx+FnoyrBPPnP3n58tvix/cH2W
 kDYZq+KTCSATxEcjTjZNabTTyhpJJ7+yWM2IsqAcaZ
X-Gm-Gg: ASbGncuodqlYsSMhS5rRdEo/E+n5C8ryGm3sTDNopV/JdSxEtI5W6p337izMQhsxYI8
 KbPPSgjWXzqejWTXnHZeEhB0wUsBOCEUBfnchK5rxZDiVe6Tn8c6vSixY9TkAHZ5mb9ng7S876P
 0U575s2lYcg4EE0UjhMFlMjgAuNGxH1LWdPhSELEyhp3IK+Qe2S8jt6P+mlc7zophrX6GV1a4O1
 VKxYB1rTNkpofMKe24dZ1GoUgJD9rZ8u6fmnPHm3qqN+yNdkKu/ngBdPKBtyXmM9M+Acnq++URQ
 3Wlx1BGgTaf1YpzTNZuWPOVpjWVIlyuY35Ma2MCvss5SVLrDNPBzPtWViCdvQzNJQyOymwoptqJ
 /5If6Lo7cdG7C8cWI5UsWNkm5EH5pUrNY9Vg+EeX6jd6A/g==
X-Received: by 2002:a17:907:72cf:b0:b3f:1120:82a5 with SMTP id
 a640c23a62f3a-b413a7e70d9mr106822266b.20.1759160997517; 
 Mon, 29 Sep 2025 08:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG39NgJaEGvGG8aqTB4Gzd3IeTq2Z4iKh6aPJuTq1virL/sLNIB/BE9XZK3/aJG78p7jKX5ew==
X-Received: by 2002:a17:907:72cf:b0:b3f:1120:82a5 with SMTP id
 a640c23a62f3a-b413a7e70d9mr106818266b.20.1759160996550; 
 Mon, 29 Sep 2025 08:49:56 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b35446f7681sm949061266b.58.2025.09.29.08.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:49:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 06/16] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Date: Mon, 29 Sep 2025 17:49:28 +0200
Message-ID: <20250929154938.594389-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Tanish Desai <tanishdesai37@gmail.com>

Add a new attribute CHECK_TRACE_EVENT_GET_STATE to the backends.
When present and True, the code generated by the generate function
is wrapped in a conditional that checks whether the event is enabled;
this removes the need for repeating the same conditional in multiple
backends.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/__init__.py | 39 ++++++++++++++++++---------
 scripts/tracetool/format/h.py         | 11 +++++---
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index bf91e443e99..9109a783c72 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -19,11 +19,15 @@
 Backend attributes
 ------------------
 
-========= ====================================================================
-Attribute Description
-========= ====================================================================
-PUBLIC    If exists and is set to 'True', the backend is considered "public".
-========= ====================================================================
+=========================== ====================================================
+Attribute                   Description
+=========================== ====================================================
+PUBLIC                      If exists and is set to 'True', the backend is
+                            considered "public".
+CHECK_TRACE_EVENT_GET_STATE If exists and is set to 'True', the backend-specific
+                            code inside the tracepoint is emitted within an
+                            ``if trace_event_get_state()`` conditional.
+=========================== ====================================================
 
 
 Backend functions
@@ -101,22 +105,33 @@ class Wrapper:
     def __init__(self, backends, format):
         self._backends = [backend.replace("-", "_") for backend in backends]
         self._format = format.replace("-", "_")
+        self.check_trace_event_get_state = False
         for backend in self._backends:
             assert exists(backend)
         assert tracetool.format.exists(self._format)
+        for backend in self.backend_modules():
+            check_trace_event_get_state = getattr(backend, "CHECK_TRACE_EVENT_GET_STATE", False)
+            self.check_trace_event_get_state = self.check_trace_event_get_state or check_trace_event_get_state
 
-    def _run_function(self, name, *args, **kwargs):
+    def backend_modules(self):
         for backend in self._backends:
-            func = tracetool.try_import("tracetool.backend." + backend,
-                                        name % self._format, None)[1]
-            if func is not None:
-                func(*args, **kwargs)
+             module = tracetool.try_import("tracetool.backend." + backend)[1]
+             if module is not None:
+                 yield module
+
+    def _run_function(self, name, *args, check_trace_event_get_state=None, **kwargs):
+        for backend in self.backend_modules():
+            func = getattr(backend, name % self._format, None)
+            if func is not None and \
+                (check_trace_event_get_state is None or
+                 check_trace_event_get_state == getattr(backend, 'CHECK_TRACE_EVENT_GET_STATE', False)):
+                    func(*args, **kwargs)
 
     def generate_begin(self, events, group):
         self._run_function("generate_%s_begin", events, group)
 
-    def generate(self, event, group):
-        self._run_function("generate_%s", event, group)
+    def generate(self, event, group, check_trace_event_get_state=None):
+        self._run_function("generate_%s", event, group, check_trace_event_get_state=check_trace_event_get_state)
 
     def generate_backend_dstate(self, event, group):
         self._run_function("generate_%s_backend_dstate", event, group)
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index be7f32e67b9..dd58713a158 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -55,7 +55,6 @@ def generate(events, backend, group):
 
         out('    false)')
 
-        # tracer without checks
         out('',
             'static inline void %(api)s(%(args)s)',
             '{',
@@ -63,11 +62,17 @@ def generate(events, backend, group):
             args=e.args)
 
         if "disable" not in e.properties:
-            backend.generate(e, group)
+            backend.generate(e, group, check_trace_event_get_state=False)
 
+            if backend.check_trace_event_get_state:
+                event_id = 'TRACE_' + e.name.upper()
+                cond = "trace_event_get_state(%s)" % event_id
+                out('    if (%(cond)s) {',
+                        cond=cond)
+                backend.generate(e, group, check_trace_event_get_state=True)
+                out('    }')
         out('}')
 
-
     backend.generate_end(events, group)
 
     out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
-- 
2.51.0


