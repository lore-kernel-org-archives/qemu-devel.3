Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5638FCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhXg-0000f7-JN; Mon, 05 Oct 2026 08:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVc-00065w-BD
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVZ-0004kc-N4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XptdnMcgHGdu1/lmgFxJUF6pokh0YQ6oA7erL5axQOg=;
 b=NNl8WPSJArw1rKb66KyPHFH8QxHTUBOMJy+6UrAxc1kIQl7iF6/q0u+zbsx7AZ6c976LYc
 Adott3SoT6+rEcUWqr78oh/Skjey/Y3NgUqL/JWclYqn+kTuKyV1Mne2rQDLzDUOzfpuyd
 AeqQ/TQPQ0VISPvPsIO1UltAEl+UZRI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-alGZ7olYMPyHtl05szBA3A-1; Mon,
 05 Oct 2026 08:09:26 -0400
X-MC-Unique: alGZ7olYMPyHtl05szBA3A-1
X-Mimecast-MFC-AGG-ID: alGZ7olYMPyHtl05szBA3A_1791202165
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F71519772DD; Mon,  5 Oct 2026 12:09:25 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 141F63001D2F; Mon,  5 Oct 2026 12:09:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 15/24] trace: add missing newline in ftrace Rust format
 string
Date: Mon,  5 Oct 2026 13:08:46 +0100
Message-ID: <20261005120855.421973-16-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The ftrace_write() method expects the caller to provide the
newline.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/backend/ftrace.py | 2 +-
 tests/tracetool/all.rs              | 4 ++--
 tests/tracetool/ftrace.rs           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index ba2a0c83770..e304ef21999 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -45,7 +45,7 @@ def generate_h_backend_dstate(event, group):
         event_id="TRACE_" + event.name.upper())
 
 def generate_rs(event, group):
-    out('        let format_string = c"%(fmt)s";',
+    out('        let format_string = c"%(fmt)s\\n";',
         '        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, %(args)s);}',
         fmt=expand_format_string(event.fmt, event.name + " "),
         args=event.args.rust_call_varargs())
diff --git a/tests/tracetool/all.rs b/tests/tracetool/all.rs
index 14afd86281e..f48bdf4aab5 100644
--- a/tests/tracetool/all.rs
+++ b/tests/tracetool/all.rs
@@ -47,7 +47,7 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 {
     ::trace::probe!(qemu, test_blah, _context, _filename.as_ptr());
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
-        let format_string = c"test_blah Blah context=%p filename=%s";
+        let format_string = c"test_blah Blah context=%p filename=%s\n";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
         let format_string = c"test_blah Blah context=%p filename=%s\n";
         if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
@@ -75,7 +75,7 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
 {
     ::trace::probe!(qemu, test_wibble, _context, _value);
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
-        let format_string = c"test_wibble Wibble context=%p value=%d";
+        let format_string = c"test_wibble Wibble context=%p value=%d\n";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
         let format_string = c"test_wibble Wibble context=%p value=%d\n";
         if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
index 39959d3fdd1..1ad13172b17 100644
--- a/tests/tracetool/ftrace.rs
+++ b/tests/tracetool/ftrace.rs
@@ -36,7 +36,7 @@ pub fn trace_test_blah_enabled() -> bool
 pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 {
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
-        let format_string = c"test_blah Blah context=%p filename=%s";
+        let format_string = c"test_blah Blah context=%p filename=%s\n";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
     }
 }
@@ -54,7 +54,7 @@ pub fn trace_test_wibble_enabled() -> bool
 pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
 {
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
-        let format_string = c"test_wibble Wibble context=%p value=%d";
+        let format_string = c"test_wibble Wibble context=%p value=%d\n";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
     }
 }
-- 
2.55.0


