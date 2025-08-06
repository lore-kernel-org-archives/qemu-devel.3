Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566FCC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujg7B-0004sw-QA; Wed, 06 Aug 2025 11:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujfiL-0005Ox-HX
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:06:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujfiH-0005Rj-9E
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:06:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23fc5aedaf0so48614465ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754492754; x=1755097554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9e4jbvypX+M6FUAntNiqWMyPc7ZVYluPgHcinlKRnI=;
 b=jXm9p03UeYMVCNOZC2wX08/DPSUc8o+K8wq8kZdwYywaE5rlYWRDo0djMV1a3F9A6P
 5tCmpIQiKPvLcGqOQyvDOKyUrwR0Vy+tlWtzActVtuHrBtIpa8kiIjBT9S62XZFkbPP9
 6TFnMXqWdrhqm1zwcY/9ecV+eABAVPqAJ40Fzt8vQ9V9F2fMEMJtcxGGN0WK8gzEIecn
 t7fyPGVYfagOwLUj6UdPDzo8mWQkM9uWVR/Z3oWKRiNkveuaSNSihJj5kAAsAmkRntci
 TFirUe5FRcJlp5rquPc6OFSYzH3jMV2ng+qYx5l3vkI/zuWVIC0J8+b43IMGoW/jWb1j
 9DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492754; x=1755097554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9e4jbvypX+M6FUAntNiqWMyPc7ZVYluPgHcinlKRnI=;
 b=BGngochwvSxNbI6AhKLz8Vl2Z6/v+igD2rfpf+p6rdIcaDpISB8pBc6vOLF1x3PJCE
 /do1qXQJTWQZHFvh+3r8AgIU9jtMGAUWd3Ozojyf0hrSvzUxQiG7Oxh9FWOYyfJ3+uDt
 jkYD61QVmcHCrhCJeAAhdMDiQXr3cq4ttpXhXhA/dMlpdmB+lpk6KDJZn6KVPF5mXwun
 oF5UseG5gWz4KgAetZvzImigqhWPCBWmArM97mpOItb6aXvgN8A9lo4WqsbQUP05pYJT
 w9W0fJwM4nRqsGpj4K7MWuQUQ4iTnCIkd026Kpef0nOf9looyaoV+g3C6E6brEctQprg
 fz6Q==
X-Gm-Message-State: AOJu0YwmW02X2roAyqnS4faIq5DJV2uWmeX1gSaedhCGTvpvtfZwB8hk
 XaQyNoAROSHIuLU5T5Ga0vaxdZTcmPQ/SBZHkZ2fPitLKina+UnhVeU70PUfQCAiUqQ=
X-Gm-Gg: ASbGnctgX0zWILTOe1vkZOemTsVrau6PeZHp3s6qxifV0MDmoq0ThotywG9pY79pvWA
 1SK4W+tG63kRCsJPXx66glTJbKn4KzcE7H5+BfZHqodxEVJ4l77B+Ly2foLkDmnkDlvnj70Boo0
 Cy8aCA4X+FqY3cllzNVgpmJKaOoKU1YY4dLtAdfuVFmOAlzuyFAQDTrRqzxYtHcDmslORo2An2E
 /Ut2zMTpjdvf0KqMzvZyYRHWyCPOEcbPTDYpctkiy7PMEkYLxkpPbJvfRiqHzPvk2srQxyMM6Lr
 IyB46EALidh3ovI2vqRyWKjjAJHeLx5l2FkHLCpFv727WARSsciA3i8pGo4BkaC7XFptex2PYHW
 oLJ5DGWzo60FbCEvWY5QJxU//
X-Google-Smtp-Source: AGHT+IHh8H8W5zK7NgZH6xjNxocBXrqfxAJwwZk9hsl81Csu5MCuViseH8F3QAVZy7Yp2nAfBBhyXg==
X-Received: by 2002:a17:903:298b:b0:23f:8d03:c4ac with SMTP id
 d9443c01a7336-2429f523e24mr46856285ad.2.1754492752339; 
 Wed, 06 Aug 2025 08:05:52 -0700 (PDT)
Received: from ubuntu.. ([106.215.156.228]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d21dsm160107365ad.139.2025.08.06.08.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:05:51 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	tanishdesai37@gmail.com
Cc: Mads Ynddal <mads@ynddal.dk>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/2] tracetool/format: remove redundent trace-event checks
Date: Wed,  6 Aug 2025 15:05:39 +0000
Message-Id: <20250806150539.2871-3-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806150539.2871-1-tanishdesai37@gmail.com>
References: <20250806150539.2871-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Remove redundent if(check_trace_event) check
from individual backends.
Adding CHECK_TRACE_EVENT_GET_STATE in log,syslog,
dtrace and simple backend.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/ftrace.py | 12 +++++-------
 scripts/tracetool/backend/log.py    | 10 ++++------
 scripts/tracetool/backend/simple.py |  9 ++-------
 scripts/tracetool/backend/syslog.py |  8 ++------
 4 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 5fa30ccc08..c65d3b89b3 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -28,11 +29,10 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    {',
-        '        char ftrace_buf[MAX_TRACE_STRLEN];',
-        '        int unused __attribute__ ((unused));',
-        '        int trlen;',
-        '        if (trace_event_get_state(%(event_id)s)) {',
+    out('        {',
+        '            char ftrace_buf[MAX_TRACE_STRLEN];',
+        '            int unused __attribute__ ((unused));',
+        '            int trlen;',
         '#line %(event_lineno)d "%(event_filename)s"',
         '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
         '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
@@ -40,10 +40,8 @@ def generate_h(event, group):
         '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
         '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
         '        }',
-        '    }',
         name=event.name,
         args=event.args,
-        event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
         event_filename=event.filename,
         fmt=event.fmt.rstrip("\n"),
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index eb50ceea34..2aa180f4b4 100644
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
index 7c84c06b20..623ea7d8ed 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -16,7 +16,7 @@
 
 
 PUBLIC = True
-
+CHECK_TRACE_EVENT_GET_STATE = True
 
 def is_string(arg):
     strtype = ('const char*', 'char*', 'const char *', 'char *')
@@ -36,13 +36,8 @@ def generate_h_begin(events, group):
 
 
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
index 3f82e54aab..04ec85717a 100644
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
2.34.1


