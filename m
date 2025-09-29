Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D8BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9i-0001Xu-Il; Mon, 29 Sep 2025 11:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G9G-00015k-Or
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8y-0000dv-Pf
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX+XQG34QhW2M9FAgGQpzvALM9UdWisnSbHk4sV3OZ4=;
 b=Lg/eyYfY5V6F+V1cONep3QtYowA4CfzM12h5Br8oXSt9RV+YSU8i1oVUnpCi9n3uOt5ykt
 +nMQE1fbaQpsJQNU/CB3lLvu3gOp9ml9XXIPMCWSL3bytl2TKe/JRO7lucdz3GiUNb+Q5a
 pk7y4CoMdsHTP9IbheOZKgVUKWQSvWE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-9lyRtTBEPMmKHF9iZPLzJw-1; Mon, 29 Sep 2025 11:50:24 -0400
X-MC-Unique: 9lyRtTBEPMmKHF9iZPLzJw-1
X-Mimecast-MFC-AGG-ID: 9lyRtTBEPMmKHF9iZPLzJw_1759161023
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-634741fccc9so3630350a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161022; x=1759765822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GX+XQG34QhW2M9FAgGQpzvALM9UdWisnSbHk4sV3OZ4=;
 b=g3ySkzrQYKpUv7nHniF47ephQG0H9iZc2vvpfcOB8tUeVjq4qpyUmUJzN5LWnyqSNJ
 SF6munjMQFWhTCc5M6FKHY6PS/EGI09bV1Xbg3/3bUweHQq+nGZ1UG2Hkd69aW//6Wrh
 /ZOGOc+1dpE0GwGWWav35n3Zp5Hwddd7weAkVoUmNbgsQrHqGfzDjH6CdY3QERNET7c6
 YXfMPEUR9cuh7EzJ2vgUJ+gy9OHPu4L9amYrzx3rG2n+z8LLUu3uDXoLkHuTqlK/5yab
 XVgYTBItuzP8ZSeqh5fm4R7uBebvBOGTipWuqNp8mH8ZHROo0BAhEKK3UJZ71eB82ptJ
 C9yw==
X-Gm-Message-State: AOJu0YzTfYrYLGvLavgnLOaLOGppCJxdlh9ixW7HmxBeGyJcJB2gxrTp
 AwTc1ov/hPkZtRdPNlJqfkoOL55agd9auAqqC4ktNscRKfmfeTctP94n/4AOEs72XgVAl7ggqg/
 G567mJP8txRN7lDHPG/PPWxo9Ep31NK8D+UWmbK/S7oP89hBYKjdVe9UzmDZHmuTCzF9P5l/Qr4
 GZ+asaK/0g24k1eJXWVAqg2Op9p7DzZzmtzLkO+7PJ
X-Gm-Gg: ASbGncsZVSZDVhmcs/U1RBbKOIsre2HxxNqbTORIyoL2Fq6xWjMctCH5Zf9JwDx+OLu
 sz3pvUfZZRD1Lm/2HszrPvRcq8mNl22l97rN4HcL4roPkM79cxvAxULeGxOAjjCOzPtmUbaac8m
 zA0x6Eny0n61SfhLdujyDcQFmsYFJNk9GJN1ZqHjkcGk//4E5cjDFLsFxfqTKOnMw/KF4fG02/c
 8OEhcxTsWYjpw4P/T0I5Flj0LXKj8dQAxQIQk4hw5N6An3k8UFmX/UX3n9mKMHXRfTJxmzZG6zY
 AwgKENYGJuHJOR4KxUM0fV/IbZ8YDNdDAA8TZv3UWoJ7XAUSCYSD9t3DA1H38hPvfhA5D5iSYWQ
 ZyVhBoS0BUex55jXm8xKqWApFs9LbAkLf7Zq1gA6XwIaQDA==
X-Received: by 2002:a05:6402:42ca:b0:634:b3d1:8f92 with SMTP id
 4fb4d7f45d1cf-634b3d19125mr13731503a12.0.1759161021702; 
 Mon, 29 Sep 2025 08:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHil11YGZNHe1Fxy80YdYgyHyNUXK7wTZ4TppgrKlVqH8WKnrUnKiuWjhaadDHCTs6Ay2F8kg==
X-Received: by 2002:a05:6402:42ca:b0:634:b3d1:8f92 with SMTP id
 4fb4d7f45d1cf-634b3d19125mr13731483a12.0.1759161021251; 
 Mon, 29 Sep 2025 08:50:21 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a362986dsm7912106a12.1.2025.09.29.08.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 16/16] tracetool/syslog: add Rust support
Date: Mon, 29 Sep 2025 17:49:38 +0200
Message-ID: <20250929154938.594389-17-pbonzini@redhat.com>
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

From: Tanish Desai <tanishdesai37@gmail.com>

The syslog backend needs the syslog function from libc and the LOG_INFO enum
value; they are re-exported as "::trace::syslog" and "::trace::LOG_INFO"
so that device crates do not all have to add the libc dependency, but
otherwise there is nothing special.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                     |  3 +++
 rust/trace/Cargo.toml               |  3 +++
 rust/trace/src/lib.rs               |  4 +++
 scripts/tracetool/backend/syslog.py |  7 ++++-
 tests/tracetool/syslog.rs           | 40 +++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py   |  2 +-
 6 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 tests/tracetool/syslog.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index f84a3dd0764..444ef516a70 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -262,6 +262,9 @@ dependencies = [
 [[package]]
 name = "trace"
 version = "0.1.0"
+dependencies = [
+ "libc",
+]
 
 [[package]]
 name = "unicode-ident"
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
index 13ac0b33d6f..fc81bce5803 100644
--- a/rust/trace/Cargo.toml
+++ b/rust/trace/Cargo.toml
@@ -12,5 +12,8 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
+[dependencies]
+libc = { workspace = true }
+
 [lints]
 workspace = true
diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
index 0955461573d..e03bce43c47 100644
--- a/rust/trace/src/lib.rs
+++ b/rust/trace/src/lib.rs
@@ -3,6 +3,10 @@
 //! This crate provides macros that aid in using QEMU's tracepoint
 //! functionality.
 
+#[doc(hidden)]
+/// Re-exported item to avoid adding libc as a dependency everywhere.
+pub use libc::{syslog, LOG_INFO};
+
 #[macro_export]
 /// Define the trace-points from the named directory (which should have slashes
 /// replaced by underscore characters) as functions in a module called `trace`.
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 177414d56a6..12b826593db 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -12,7 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import out, expand_format_string
 
 
 PUBLIC = True
@@ -38,6 +38,11 @@ def generate_h(event, group):
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
 
+def generate_rs(event, group):
+    out('        let format_string = c"%(fmt)s";',
+        '        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, %(args)s);}',
+        fmt=expand_format_string(event.fmt),
+        args=event.args.rust_call_varargs())
 
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
diff --git a/tests/tracetool/syslog.rs b/tests/tracetool/syslog.rs
new file mode 100644
index 00000000000..9d3675a0b57
--- /dev/null
+++ b/tests/tracetool/syslog.rs
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
+        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"Wibble context=%p value=%d";
+        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 3341fb18f90..786083ad7fb 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,7 +14,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"ftrace", "log", "simple"}:
+    if backend in {"ftrace", "log", "simple", "syslog"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.51.0


