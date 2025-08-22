Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7244CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrb-0004qh-7L; Fri, 22 Aug 2025 08:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrZ-0004q8-T1
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrT-0002PV-4T
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHrA/UsW2DzabHAW3AoasOy3GBNC6W8fjR2RtT6A+zs=;
 b=DjatiRTE5HfHMX+LtMR7fouUF494X7jcrDEpMGk/6bftUncQ70a4nSDNL7/WOtp7gRL9UA
 mrztnqtBkBBtikuSV5RSjKCnObAeQYB+7g+a83d1pzjfXTQAA2/LT2lAUFopEA5AbkExir
 02wHaSjUGRsv1lmu9LhNBgiRh04QsrU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-wpQCJlxxNtWea6T_f1PdMQ-1; Fri, 22 Aug 2025 08:27:12 -0400
X-MC-Unique: wpQCJlxxNtWea6T_f1PdMQ-1
X-Mimecast-MFC-AGG-ID: wpQCJlxxNtWea6T_f1PdMQ_1755865631
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0cb0aaso16100085e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865630; x=1756470430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHrA/UsW2DzabHAW3AoasOy3GBNC6W8fjR2RtT6A+zs=;
 b=OOmHiqSLi+xUp0ek9nQqaaIhSUgSN7X5urxaEHxkHnCUe2Hwda3nFSFnqMyAvTFvtC
 afvMt/LW5nnKn67ZCaTjXVkDmxDlREg/qsvyCGMf3Vwxk2C/ZSff3OHPsOzpBtqrlHjh
 5ZqlbnrAm1OHIMBYILmhRinscngWKfEicVbHdrYQZj2vqpyfa4hA7Qr0WrNc+7fUFknu
 sK01YgvGpH+Xr9KWCpG1FiA7F+/KcdqrTMhdBODU6dfB9I4QuztgrTO6EXYdgJm7Fz6f
 PhgouYrlmi7Q8JUsyC1wGxjKTfa6n3qLib67NfOy0CJuJ7pA/Asy0MwRvbmR7PsXqtVe
 csqQ==
X-Gm-Message-State: AOJu0Yzujjln7UeQOUPGhmGvx8dpmP2u77gHuOvpDwWXFHVoggFQq35x
 07HyqkCdzdVKs4uYoANi+z7G6mO79o4t/wEx+S/hSPcfkyYkc2y2H+7hhSmM600sfw8gmuax7Dk
 5KL97Dg7zMe4PpflCl7L99wa9AUJW1MW6vc+/EWNKta5PpztekFujjtiW9uKAQjrRsJOZcmIXt5
 ni2ByAOg0yJ6wzP1WsuIEnRO/Ibxm8nftlgfpP9GfE
X-Gm-Gg: ASbGncvdm30PfbaTTps5tt8/GXvEBFr3MGzwMw5TYGVFXFL2M2v84hsC6pz3Rk1pd5l
 i8vZsQ9+UyglH8IWzBMCdUSUSMEwhwMmbKhqZIN5wQjvoy3VRAsr9cBBs4/8hYFKYBE0aqRn5mG
 SignaiZPMIz0gZ/JVJSu74PAQU4QoXaLBzwnO1ChjZgKKFiXPPfV13RCe56qMwFqSQY60mAO3ol
 2DweeDbKi6f3HWzUu6jnaTPjDNgbOfYZ9BgMqOcdsctetcjNu4dLzjbPSLPmfjdR+DE6JJ0StCu
 PTJnQexH+nNFbrtYDdxCtXMqU962xjcTssRFi5d4b+qxnoC1DYyj+J/u3dPonOeQzeewsoXmE2N
 qNedYJGy8GYOtodJnZMHiP3FlvXvaeCxOPfOKphm+2A==
X-Received: by 2002:a05:600c:c87:b0:459:dd34:52fb with SMTP id
 5b1f17b1804b1-45b5179ebb2mr26048735e9.12.1755865630527; 
 Fri, 22 Aug 2025 05:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUb4hAy9c5J9cOEAHkKQBB5FTbnN9DtgPHEf5YCMRJxxP+C1M/9T/eeYANdUFFxP9gTPWUkA==
X-Received: by 2002:a05:600c:c87:b0:459:dd34:52fb with SMTP id
 5b1f17b1804b1-45b5179ebb2mr26048395e9.12.1755865630046; 
 Fri, 22 Aug 2025 05:27:10 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50e11ab8sm36112395e9.24.2025.08.22.05.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 05/14] tracetool/backend: remove redundant trace event checks
Date: Fri, 22 Aug 2025 14:26:46 +0200
Message-ID: <20250822122655.1353197-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Tanish Desai <tanishdesai37@gmail.com>

Use CHECK_TRACE_EVENT_GET_STATE in log, syslog, dtrace and simple
backend, so that the "if (trace_event_get_state)" is created from common
code and unified when multiple backends are active.

When a single backend is active there is no code change (except
for the log backend, as shown in tests/tracetool/log.h), but the
code in the backends is simpler.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
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
index a07f8a9dfd8..432f216ea2b 100644
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
index eb50ceea34c..2aa180f4b47 100644
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
index 7c84c06b200..a8afc977a20 100644
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
index 3f82e54aabf..04ec85717a3 100644
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
2.50.1


