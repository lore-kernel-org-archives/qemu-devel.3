Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51868CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9a-0001EI-T3; Mon, 29 Sep 2025 11:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8t-0000rN-2M
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8d-0000YY-Qr
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXiQoLVud16zJS++9JVhoT2jq7OgO1shPqm/dnBddzo=;
 b=SjUo9hvjX7kLXGvQ3/FxJjlYrJyq012S4H/eyaJsWJ21zQ8RmhOBE3kEMMtaumDUoOjGMh
 VKoRfJoj3WQqINsONtnVkYFciYI/p/vyTrPFnxkuwp//UaJA8TGRvTfZBgZWeuFi7vRaD9
 gX+MU2Y2aFntR5SCwdYFJeqEXU5SoU0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-NAV1bgbnMGyYaJTn5eGlgQ-1; Mon, 29 Sep 2025 11:50:01 -0400
X-MC-Unique: NAV1bgbnMGyYaJTn5eGlgQ-1
X-Mimecast-MFC-AGG-ID: NAV1bgbnMGyYaJTn5eGlgQ_1759161000
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-634c48a0ce7so3885166a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160999; x=1759765799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXiQoLVud16zJS++9JVhoT2jq7OgO1shPqm/dnBddzo=;
 b=CwREv8+yWo3lAtk6pEPNVUD+5DpRgQQMfhP2C/TnT2yl8KOMQswOUL4EeMTrc6M0oC
 3EXxiq2enohpgvyJcN/nPj0gy4KMINoo7JLKgEfpKASn2VL7IOs2UqUqTZw1+6KkoeTL
 Fj2d4nLU2760C4KzsQoVlBH9nika0PjtwxlUU8Hj3TgmZhLQJOXfXJunkDwHbiftGBUA
 6UBuAlXls1VttcwOgt+8LCLMihGHJhPAdlz8Iqc0NGBMuJ/MKxqp7Ugsru78o21b7Tcx
 IglLAzucVp7bMonAhziro7uzq3QmwUxn2/JTIsrTSehwyY/jux0RWo4COLGKXpVi41J0
 cEyg==
X-Gm-Message-State: AOJu0YwfIEAJkdOJukRbkIUXY+SEOI6k7NpzQCmwQfrhkIktkPR3rcWY
 WnFhUByblbO6ABHoDO8YmP3zG3ht0KI0PHzaHa2PiBPGnoqPeoxmyQWezfDwgaDoFz1+e9alMRc
 EfNaty5HGHmie8pxmQkTKeEwvuUZiqqJxVdcBgf59RJCxwTlW9dxBXFNIldir/w832hZ8/PlEI8
 kZ0uEjPSw/9NwAamaHTo+QcPwfYV5urLQv8LhCPBbG
X-Gm-Gg: ASbGncsDaoWYgpertRDUP5gnnQah24fiqckmIpQ1XTlsyabbnlg1yyLX3IvKUxAJ93A
 p/cLRSgSC5r0LZ2yqUlrO0rOAFclmIf9d4+l0CzT9cHdMGFMw3ddGdAmr2567IYPT8VRRXwJR5e
 ssCW9UMXP6AfFw79syzDNMPQubmrwWn7jZGgw4BViyrOtCU+hrZPmITVwljb03pdFWGb3vapyxm
 jJwqTwJWBQOnL+qLXikGTPtcEiDcRkkz1QgEuEhYx+fjf/6yMrR14BxkVerHawF/wSOVfC/JI3g
 GHTXFOqyEyFQYQY87IiuPvH7iuuP3MZISFdNMh2EFYTdaMptf4IGUckjrq+KaUmH7PmuKpJMNUT
 ScmvgRJV5zy1YiQEW4e4YJppqLSK8Hgsx6StvQ7mRsFqKVQ==
X-Received: by 2002:a05:6402:4412:b0:631:6713:3ac2 with SMTP id
 4fb4d7f45d1cf-6349fabb58bmr15560837a12.38.1759160999505; 
 Mon, 29 Sep 2025 08:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZxxwsuUtbggYL5aOlrGiwf5w+UORwVlsBCtdVLYK9eI9LpaPDy14vpQw9wK3Zo/85HtWwow==
X-Received: by 2002:a05:6402:4412:b0:631:6713:3ac2 with SMTP id
 4fb4d7f45d1cf-6349fabb58bmr15560810a12.38.1759160999052; 
 Mon, 29 Sep 2025 08:49:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a364fedesm7967787a12.14.2025.09.29.08.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:49:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 07/16] tracetool/backend: remove redundant trace event checks
Date: Mon, 29 Sep 2025 17:49:29 +0200
Message-ID: <20250929154938.594389-8-pbonzini@redhat.com>
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

Use CHECK_TRACE_EVENT_GET_STATE in log, syslog, dtrace and simple
backend, so that the "if (trace_event_get_state)" is created from common
code and unified when multiple backends are active.

When a single backend is active there is no code change (except
for the log backend, as shown in tests/tracetool/log.h), but the
code in the backends is simpler.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tracetool/log.h               | 16 ++++++++++------
 scripts/tracetool/backend/ftrace.py |  6 ++----
 scripts/tracetool/backend/log.py    | 10 ++++------
 scripts/tracetool/backend/simple.py |  8 ++------
 scripts/tracetool/backend/syslog.py |  8 ++------
 5 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index edcc7f9d47c..c7795871f85 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -21,10 +21,12 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH) && qemu_loglevel_mask(LOG_TRACE)) {
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+        if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
-        qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
-#line 28 "log.h"
+            qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
+#line 29 "log.h"
+        }
     }
 }
 
@@ -34,10 +36,12 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE) && qemu_loglevel_mask(LOG_TRACE)) {
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+        if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 5 "trace-events"
-        qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
-#line 41 "log.h"
+            qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
+#line 44 "log.h"
+        }
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 8c0ce3f23a0..7ddd5d11a66 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -28,14 +29,11 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    if (trace_event_get_state(%(event_id)s)) {',
-        '#line %(event_lineno)d "%(event_filename)s"',
+    out('#line %(event_lineno)d "%(event_filename)s"',
         '        ftrace_write("%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '    }',
         name=event.name,
         args=event.args,
-        event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
         event_filename=event.filename,
         fmt=event.fmt.rstrip("\n"),
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index faacec46105..d01d234289f 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -28,14 +29,11 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
-
-    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
+    out('        if (qemu_loglevel_mask(LOG_TRACE)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
+        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '    }',
-        cond=cond,
+        '        }',
         event_lineno=event.lineno,
         event_filename=event.filename,
         name=event.name,
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 97e40495ee9..b5a6b7205a3 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def is_string(arg):
@@ -36,13 +37,8 @@ def generate_h_begin(events, group):
 
 
 def generate_h(event, group):
-    event_id = 'TRACE_' + event.name.upper()
-    cond = "trace_event_get_state(%s)" % event_id
-    out('    if (%(cond)s) {',
-        '        _simple_%(api)s(%(args)s);',
-        '    }',
+    out('        _simple_%(api)s(%(args)s);',
         api=event.api(),
-        cond=cond,
         args=", ".join(event.args.names()))
 
 
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 78ee67136b8..177414d56a6 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -28,14 +29,9 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
-
-    out('    if (%(cond)s) {',
-        '#line %(event_lineno)d "%(event_filename)s"',
+    out('#line %(event_lineno)d "%(event_filename)s"',
         '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '    }',
-        cond=cond,
         event_lineno=event.lineno,
         event_filename=event.filename,
         name=event.name,
-- 
2.51.0


