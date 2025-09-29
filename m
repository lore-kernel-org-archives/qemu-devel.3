Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BDBCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9h-0001Wu-Ol; Mon, 29 Sep 2025 11:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G9I-00015X-ID
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8v-0000dK-AM
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+cJ9QO2Q0sAQJS568/ENx7YFMeKJSiogImV/H5vK6k=;
 b=IBaX8HgpOGVx5c7dcVhnSazysb5veWEapJWQtoth+t/KzrHVh3Al8VeZSEvD3VGkZvHZsB
 zMwP9FffnNGwgrUEYOUZ0gq1qpErvZOVPVssDyjTI/et5ZebultmL029VPP8Vr7IiGz3QW
 N8CfmHOPYIqG9EZF3cEVQ4xSDHEApyc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-7jFlPzs8Osmw7D12VGwXZA-1; Mon, 29 Sep 2025 11:50:21 -0400
X-MC-Unique: 7jFlPzs8Osmw7D12VGwXZA-1
X-Mimecast-MFC-AGG-ID: 7jFlPzs8Osmw7D12VGwXZA_1759161020
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b36f970e2abso361595566b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161019; x=1759765819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+cJ9QO2Q0sAQJS568/ENx7YFMeKJSiogImV/H5vK6k=;
 b=saGEP/izm721wHTwONVpILVzDrg41CIGDJDZy6biJmFxvxidnAuDZ1BbDtu/lwjMjB
 T2i8oV1cU9GkwCUb1h45hcLaY8kqqjeAA2owLi5KZd+XPIcQOGl5Y9bjeQu8sWTkiJJI
 FC9iFjJkBfvnWZP/x0wjPrV6LKcUbmtVOqjRHLZNXDangqSmc8NVpzYBC6Szbsvs/Rvq
 b71xyxP2FXeaCVZH0145LQnldWMI5jYqWbQzIlN5SlyUW+gGJAFgON6Q+4t/ebCkkF7+
 QJL5nAACx/texRJOOhFAwJqeiLCO+hGW2Za14feHEjFbdwJlSZHdLfHwT5UruWAq7GI+
 nMSQ==
X-Gm-Message-State: AOJu0YwwF7ED6D5L1gMtoMm0pR567BpGkKKSwjG/Qw1p74/eDpnE9E3J
 XHIGCyttn4N1pTdW2l/SPCSVhbQkAVRdrkG/GJAz8Sjz+RqO82ai6STG6eR6GwikHKrpKO68mBx
 owo/OQvBJ0o8LdKXGcItK6ZvvIG+Up2QHdtMS4vlsC0S80p78qkdgLNHZFqd9LNTRcnoop6IQOj
 2xX58AeMUMwFQxyfnzuH32y5MxysYE+TQeHddYCNjy
X-Gm-Gg: ASbGnctfUIXa2rTp49ExFQ1e6nBRJNOkRr2d5qvLV4nbrg31r25YpSe/Adx00AEQXDT
 8yO3teWJl+SntVweA4ifUp4lyyy9TlZ11NIjGgwYuSc7LPkdHsK3RFApHWzj5+pMGBxAjRaSYou
 eDsTGJUpGx+j3Pxvhlln7DVCc8rbS0DZ6TcTQiB3kIiMnvKBxdgrLAl9gAZVHGxF+0Yvu1LRyfY
 qquHVVbv8gHiygNDaOVZQdzQalEP5KhOTXGyz71DKwdbo/YY/HHP864AyjnYZLIS1RklIbqN/Ul
 R+Tgztjs4HoJfd+v1UH8elnH5BR6y86huLKE1oh/ib3Xx0vq2FzDfe2piH9JljAqkRfxDl+NX3A
 kCdic9ki0d9e+ANH+DO7VRJn2XCeNNEd9Aaek6LnvhKDDhg==
X-Received: by 2002:a17:907:3e93:b0:b40:448d:cdb0 with SMTP id
 a640c23a62f3a-b40448df75dmr250786666b.41.1759161019584; 
 Mon, 29 Sep 2025 08:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsI8J36HzZ2hqMoZwqMNJrQRn4zL3+0oxOL7d8wPOdjwUDpKC0BmrdPUFkKf7RKZnQe8Ul1A==
X-Received: by 2002:a17:907:3e93:b0:b40:448d:cdb0 with SMTP id
 a640c23a62f3a-b40448df75dmr250783366b.41.1759161019124; 
 Mon, 29 Sep 2025 08:50:19 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b35446f758csm953275566b.53.2025.09.29.08.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 15/16] tracetool/ftrace: add Rust support
Date: Mon, 29 Sep 2025 17:49:37 +0200
Message-ID: <20250929154938.594389-16-pbonzini@redhat.com>
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

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/ftrace.py |  8 +++++-
 tests/tracetool/ftrace.rs           | 40 +++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py   |  2 +-
 3 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 tests/tracetool/ftrace.rs

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 7ddd5d11a66..e03698a2edf 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -12,7 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import out, expand_format_string
 
 
 PUBLIC = True
@@ -43,3 +43,9 @@ def generate_h(event, group):
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
+
+def generate_rs(event, group):
+    out('        let format_string = c"%(fmt)s";',
+        '        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, %(args)s);}',
+        fmt=expand_format_string(event.fmt),
+        args=event.args.rust_call_varargs())
diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
new file mode 100644
index 00000000000..07b9259cf29
--- /dev/null
+++ b/tests/tracetool/ftrace.rs
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// This file is @generated by tracetool, do not edit.
+
+#[allow(unused_imports)]
+use std::ffi::c_char;
+#[allow(unused_imports)]
+use util::bindings;
+
+#[inline(always)]
+fn trace_event_state_is_enabled(dstate: u16) -> bool {
+    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
+}
+
+extern "C" {
+    static mut trace_events_enabled_count: u32;
+}
+extern "C" {
+    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
+{
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
+        let format_string = c"Blah context=%p filename=%s";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"Wibble context=%p value=%d";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index f58f3b795e7..3341fb18f90 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,7 +14,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"log", "simple"}:
+    if backend in {"ftrace", "log", "simple"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.51.0


