Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57329CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9V-0001D6-BH; Mon, 29 Sep 2025 11:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G9G-00015l-P5
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8x-0000d1-3x
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgeZwtZ6+urHNeNIRfbFDXvW6hsniO1LNpDBTG/PzSo=;
 b=S3Wn58ESIbmad/9zo24Yndre5v2HriwrVGxzDilVwIu27Fxb+R9A0uwD3QoCcRwLBhWgqq
 6YtP237ccNo8OV5VFzUYABy8hGGZ37xitZTWe+mQbKsF0N6sDAjAKKmtBC3AACzHFDsf2g
 ca5VbsC1QTMphUgRxhogxs5xj81XSDA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-pqZV3g3ZNoOy4BWnmB-v7g-1; Mon, 29 Sep 2025 11:50:14 -0400
X-MC-Unique: pqZV3g3ZNoOy4BWnmB-v7g-1
X-Mimecast-MFC-AGG-ID: pqZV3g3ZNoOy4BWnmB-v7g_1759161013
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-636260bcc31so1984710a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161012; x=1759765812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgeZwtZ6+urHNeNIRfbFDXvW6hsniO1LNpDBTG/PzSo=;
 b=CnGSc7UoOYWopnILzxwKoUzjb6tUHWOpXZDEwx4yuB6afEyqQDg9w0xC+FwBe83j6f
 Ms2dja0tjmVA0GeGBD+k/f3TkoHcyahDiu1bH4ygGYxeVw+9KLHgtICJpbPc8nNY5CJN
 CrJbst1+T6/qlMAxywOJfq4HIuhU9KKHqj3BQCYeBc/9mA/3kF+u7T9950jKyx2erCmc
 Kipsqbb7MsKsI8PXG7HujLmmeKFXvFeB19sOrs1ELTYIYbJItmQpYsL/e+5qjiGitIH/
 AhGE1v5ctmXfE+0buxPek4fPNQFyxtmHl5BjPcZe2GbiPrm2OZ3/SmNaYdSb2L4heOVx
 4kLA==
X-Gm-Message-State: AOJu0YyTpua0W6xfE7/y7/XicdrL8i70dSEoHSxYYxSjUGarT4pZRMiI
 FJan8yNO++Q3oFVG96Zh/OOer9hWLQk7cn6TrPHTeVsjiXSgAKlft8nEmfOJXiGJAG2kARIf8Cg
 JZwGU5YLPbVN02DygRhBS7o3gW6xTKk0MK5OrqfZtuXcQoeUjIUmYyPp4u7Vzi7p/tqm5Veq0KG
 cyrorYxMUeqPkDGYnmrjDUIDWT0y5qpXv7S/IaR1Zl
X-Gm-Gg: ASbGncuslIUu4WL6eGdIcArTP6UpmKxSKz77lND4VgZMYe9SY3C0SU9L8441JzdJpFn
 5Tqh42KN8KT2xL0UShxE6vrxJfGoYcR9PmwaAi8LDvjvMjVweJlU0+CTDvbLyxuP7iBCIXsH1Fr
 tmdoV/CLlEG6c/ENJYUUnaCDh9nQJHNNyFGIMBCn1Ggor5YO4W7dDFzXMYIyEW1UAyXWgthmdCs
 s1Mcoky41dCvjw9Q1AlNXzcqppTzB6XXhnxFzdCHWNwloqcMGJyiLS8ID8RTgtFeHjeiED9Yu0L
 jrQKlnABXg+JVRf6fegP/cI0JHm7nEAqPWTKJGAK48hD4nUPy6YFvSENYSyvDhBTo8TmXXPLAq8
 dHNG3p5v+hMn3E6tWpi7gK/0JsgDONP445EIQdzj5W8xIOw==
X-Received: by 2002:a17:906:6a0c:b0:b3f:a16d:da7b with SMTP id
 a640c23a62f3a-b3fa16ddfd2mr338144366b.8.1759161012576; 
 Mon, 29 Sep 2025 08:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3jWHmTgmkjus/DPpqJcmXBoTx4EXB8vKy6gsv6LkxkeSrL5dDo40U8Pvy4Hq5RkvH9JBF1w==
X-Received: by 2002:a17:906:6a0c:b0:b3f:a16d:da7b with SMTP id
 a640c23a62f3a-b3fa16ddfd2mr338139766b.8.1759161012037; 
 Mon, 29 Sep 2025 08:50:12 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d277598bdsm332944966b.3.2025.09.29.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 12/16] tracetool/simple: add Rust support
Date: Mon, 29 Sep 2025 17:49:34 +0200
Message-ID: <20250929154938.594389-13-pbonzini@redhat.com>
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
 scripts/tracetool/backend/simple.py |  7 +++++
 tests/tracetool/simple.rs           | 40 +++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py   |  2 ++
 3 files changed, 49 insertions(+)
 create mode 100644 tests/tracetool/simple.rs

diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index b5a6b7205a3..b131e4fc194 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -98,3 +98,10 @@ def generate_c(event, group):
     out('    trace_record_finish(&rec);',
         '}',
         '')
+
+def generate_rs(event, group):
+    out('        extern "C" { fn _simple_%(api)s(%(rust_args)s); }',
+        '        unsafe { _simple_%(api)s(%(args)s); }',
+        api=event.api(),
+        rust_args=event.args.rust_decl_extern(),
+        args=event.args.rust_call_extern())
diff --git a/tests/tracetool/simple.rs b/tests/tracetool/simple.rs
new file mode 100644
index 00000000000..9ee39495e38
--- /dev/null
+++ b/tests/tracetool/simple.rs
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
+        extern "C" { fn _simple_trace_test_blah(_context: *mut (), _filename: *const std::ffi::c_char); }
+        unsafe { _simple_trace_test_blah(_context, _filename.as_ptr()); }
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        extern "C" { fn _simple_trace_test_wibble(_context: *mut (), _value: std::ffi::c_int); }
+        unsafe { _simple_trace_test_wibble(_context, _value); }
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 65430fdedc1..3e37890476d 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,6 +14,8 @@ def get_formats(backend):
         "c",
         "h",
     ]
+    if backend in {"simple"}:
+        formats += ["rs"]
     if backend == "dtrace":
         formats += [
             "d",
-- 
2.51.0


