Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2F2C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 12:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUPHJ-00029S-5Q; Wed, 25 Jun 2025 08:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uUPHF-00024r-T7
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 08:30:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uUPH8-0004NC-SP
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 08:30:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-747fc77bb2aso5069930b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750854647; x=1751459447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iybPHy+/aqTStcYoAUMHOeTdjWjYmal2zwFcitOTZ2Q=;
 b=Hhjs0qeokl5mQIvP8kJwHXEFHxLDNFFOhxBGUyaGVLwxckHoEFkVgmK0wK4pdzPoZ5
 1M6njn5Hu/exceCWq8ek77Zv0ORT+knktjfLI7ToCCukixRGDoHjfyM60DbAZFKg9Zuj
 lqNKS0IBLtmy6RU8RwPKhIihRxO1xqDjqk+4LKKEQABVY/gWZ7TVT7R/NtU/jICEunJ/
 c7MAtwXjML1r6zHOoR2toW+g+bFsxRbgQVNN+tQI2XpiNZrcbxhEjw0pBmUsZgn7Ck9m
 SnYgi6VFXEzLQsaJy3Oug39XgxhMOhFgjjLFII75IoAqvif1tdASVmXnzqAUD6IDdE82
 wIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750854647; x=1751459447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iybPHy+/aqTStcYoAUMHOeTdjWjYmal2zwFcitOTZ2Q=;
 b=jgmQ+LvKB1u53m4ctJ0hJM9HEIyTJuDiR1Moov8NVYHHpfCVqjay35bLmubdg4SSp6
 e/cB0pESTNDU8OQ019VSH80jyBVY7awa9BG1jb23srYsg6KqLi15KpcXibCgjwBtmDSY
 Lyaz+J/U0thXzEoOY2G/yc2r74hrAFCDNlM+gAaN/S1HAJWhovdH3gqs+4h/CgoAZg2H
 3gI6VGrDdS5ohJnHxJlImpfXb6URL+C4Bb4iJQt4tBne06pgoCTpdYFS7hCNvMMrKYCf
 sKYucAH7LbVau5FY+mdzb2HdYRqig/C3W5bmP/FpOZ5uuzJb+Lc6HAR7WK1cmKqOPTLL
 kdng==
X-Gm-Message-State: AOJu0YxWJnnVhYt+60JdBWcFvk1bK6W8lBx64d6ilzOIV3x5Hv7TdjZ0
 OIp7uq7goUSHM4U7mc8VLQ3/YAnG555GCK6Fm/oDkelQIdVA28/X83f+gS3I2p0bds2LZQ==
X-Gm-Gg: ASbGnctoG3ymQhT2SPeDnWmnOYSHe8yof2mP3zpsLVzsxMe5R+rrNy+ALO6b7opBQZn
 swuPVYs94K6Dv/8BeizOaXQMsOGHIwGiAtd1130cdBOhqjHPfVLRqZwu8Ue7p7bBDJBL1c9BgIb
 3hkLy7gC9rsAPnECdMvR+eh9k/lUyreZdq8G/fAwn3ZymoVClxDiC9+ANqtLGxzk9qbgwE5XnbS
 tZoTdn2hHP2WQ39FIg05PiITgH64A5fqpywXtblmN5RM8rJb/A0U0s+fSkXGkO8rDnoc7OTMp0n
 XrZqhvBdZ/wfDqs+avkm6BAVToo1vy2g0m7zj9ELLCLkISPEY7Sjr5LnMflHXgMvl+sUKWH06v1
 CSgJt
X-Google-Smtp-Source: AGHT+IHjJam3zhApJNcuiWR5KlAE2y08kzwJQdJyOdXXUOcSBEz2xOiC0PfSNj7Udwb+iQezNxHDOQ==
X-Received: by 2002:a05:6a00:2195:b0:736:54c9:df2c with SMTP id
 d2e1a72fcca58-74ad455caeemr4248117b3a.15.1750854646734; 
 Wed, 25 Jun 2025 05:30:46 -0700 (PDT)
Received: from ubuntu.. ([106.196.27.209]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d1csm4401123b3a.13.2025.06.25.05.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 05:30:45 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mads@ynddal.dk, pbonzini@redhat.com,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH v3] tracetool: generates conitional checks when needed
Date: Wed, 25 Jun 2025 12:30:23 +0000
Message-Id: <20250625123023.33428-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624190336.GA19307@fedora>
References: <20250624190336.GA19307@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds generate_conditional, allowing backends to wrap generate()
output in a trace_event_get_state(...) check if needed.

Removes no_check by inlining its logic into trace_foo(...).
Also ensures the generated code is formatted properly.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/__init__.py |  3 +++
 scripts/tracetool/backend/ftrace.py   | 16 +++++++-------
 scripts/tracetool/backend/log.py      | 26 +++++++++++++----------
 scripts/tracetool/backend/simple.py   |  4 ++++
 scripts/tracetool/backend/syslog.py   |  4 ++++
 scripts/tracetool/format/h.py         | 30 ++++++++++-----------------
 6 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index c4456a5efd..dc0806f8d0 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -118,6 +118,9 @@ def generate_begin(self, events, group):
     def generate(self, event, group):
         self._run_function("generate_%s", event, group)
 
+    def generate_conditional(self, hasCondition):
+        self._run_function("generate_%s_conditional", hasCondition)
+    
     def generate_unconditional(self, event, group):
         self._run_function("generate_%s_unconditional", event, group)
     
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 2d6d608add..d579139532 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -30,17 +30,15 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    {',
-        '        char ftrace_buf[MAX_TRACE_STRLEN];',
+    out('        char ftrace_buf[MAX_TRACE_STRLEN];',
         '        int unused __attribute__ ((unused));',
         '        int trlen;',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
-        '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
+        '        trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
+        '                         "%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
-        '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '    }',
+        '        trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
+        '        unused = write(trace_marker_fd, ftrace_buf, trlen);',
         name=event.name,
         args=event.args,
         event_lineno=event.lineno,
@@ -52,3 +50,7 @@ def generate_h(event, group):
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
+
+
+def generate_h_conditional(hasCondition):
+    hasCondition[0] = hasCondition[0] or True
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 35a3aeee55..119e24af04 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -31,22 +31,22 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    if (qemu_loglevel_mask(LOG_TRACE)) {',
-        '        if (message_with_timestamp) {',
-        '            struct timeval _now;',
-        '            gettimeofday(&_now, NULL);',
+    out('        if (qemu_loglevel_mask(LOG_TRACE)) {',
+        '            if (message_with_timestamp) {',
+        '                struct timeval _now;',
+        '                gettimeofday(&_now, NULL);',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
-        '                     qemu_get_thread_id(),',
-        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
-        '                     %(argnames)s);',
+        '                qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
+        '                         qemu_get_thread_id(),',
+        '                         (size_t)_now.tv_sec, (size_t)_now.tv_usec',
+        '                         %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        } else {',
+        '            } else {',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
+        '                qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
+        '            }',
         '        }',
-        '    }',
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         name=event.name,
@@ -57,3 +57,7 @@ def generate_h(event, group):
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
+
+    
+def generate_h_conditional(hasCondition):
+    hasCondition[0] = hasCondition[0] or True
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index ce8036f5da..316f39727b 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -97,3 +97,7 @@ def generate_c(event, group):
     out('    trace_record_finish(&rec);',
         '}',
         '')
+
+
+def generate_h_conditional(hasCondition):
+    hasCondition[0] = hasCondition[0] or True
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index f84cec641c..a224bd1922 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -43,3 +43,7 @@ def generate_h(event, group):
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
+
+
+def generate_h_conditional(hasCondition):
+    hasCondition[0] = hasCondition[0] or True
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 7bbe6d3148..7a5a32d518 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -59,21 +59,10 @@ def generate(events, backend, group):
 
         out('    false)')
 
-        # tracer without checks
-        out('',
-            'static inline void %(api)s(%(args)s)',
-            '{',
-            api=e.api(e.QEMU_TRACE_NOCHECK),
-            args=e.args)
-
-        if "disable" not in e.properties:
-            backend.generate(e, group)
-
-        out('}')
-
         event_id = 'TRACE_' + e.name.upper()
         cond = "trace_event_get_state(%s)" % event_id
-
+        hasCondition = [False]
+        backend.generate_conditional(hasCondition)
         out('',
             'static inline void %(api)s(%(args)s)',
             '{',
@@ -83,13 +72,16 @@ def generate(events, backend, group):
         if "disable" not in e.properties:
             backend.generate_unconditional(e, group)
 
-        out('    if (%(cond)s) {',
-            '        %(api_nocheck)s(%(names)s);',
-            '    }',
-            '}',
-            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
-            names=", ".join(e.args.names()),
+        if hasCondition[0]:
+            out('    if (%(cond)s) {',
             cond=cond)
+        
+        if "disable" not in e.properties:
+            backend.generate(e, group)
+
+        if hasCondition[0]:
+            out('    }')
+        out('}')
 
     backend.generate_end(events, group)
 
-- 
2.34.1


