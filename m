Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F000C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 18:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLnAt-00021G-1x; Sun, 01 Jun 2025 14:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAr-00020q-7v
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAp-0002oi-LD
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-747d59045a0so555944b3a.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748801562; x=1749406362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtMYrVMuloYt3Yjr4sNHWX4khJZ7APlMmjLEKIR4VtI=;
 b=IOnfxPpguI6wquYtky79KLaXwrHFDy137NJebL1Hms2H4H0NqUCG2oRzQo8fsM40Be
 0TDhITaTtMZXCZcJAwm6lQ6htiGNJVNdJlVndxwYpjZS0QYTsEuEUZDNwzOwDBUk448H
 7CA/t1t70P0lVSUUwmosz8X8cdabPanB2DPlYmpjxCetGbRGeYXcQA1NQU2irC7+B7o5
 Ngoxt3PcBB1iOfrw1fRrbgM1rUu6/qshXFHTM/3gI2HJvcvZQly6LwJ+v+ZGr01XLFqc
 weiQAxm0GRPZJhnBPqdG8xUTMOaSQ7AOLNtZgrlA2EbCueobhPZfLt7OpLLXIQX4PVWJ
 uUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748801562; x=1749406362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtMYrVMuloYt3Yjr4sNHWX4khJZ7APlMmjLEKIR4VtI=;
 b=KSBLd8rCI7TgdhnhekDfEkDfM3+vFmiI6tUHnyuPQzVxvU40qsPPUvUfgH/i59Me5o
 v4vvoHh7o3L5f9yAFrNSLEuavtxdx92+V5FmmiilCrlRh90d8xZb5j/LxrWc+reBJB1B
 Ce/AqU2QMjDXukIhhRjWb4LPGkwoS1W5IiXBKb+kZ/LlOwbrN9JH8PNiSAifVmjWjkuw
 pByvJhW6CcwIqgiVJlhLx26G7qSNK+B5qbhNDYBC31CE/kNydaVkXk0KHBvR88O87mPH
 BkUmahmJ/zlZlS2GFbxlaE/gTvGEDnf442AjNWv5QyUmlQvY+B/yYUkNedWQy6792xC5
 +ujw==
X-Gm-Message-State: AOJu0YxFWGSc76FHSPrEUHXY4vwUvLS2rN8vhyzWZEkDlo14u34+q0/B
 O2YOz3Ba64ow5uemGcpWjqWpOIeLuK6aIiXH2lQi8zQq62b3+Q1G86Zed13g0zO7P7KsKg==
X-Gm-Gg: ASbGncsyduZowIKP+8naxl4+VPePNahfHyPHq9Fgm753bz28gm/vvku8o8NwjL8ZRiA
 bTNzMVo+Bgwy0JuqNFvbpv1VnGff0KLW7ZX8CBYfqDYGYE+OX87YccOFeohT3NwAyWForoytehW
 dgu9CrtWU11yhSXLyZcetYRakNI3xFxKYc+FbyuwDfbBbAs/h/paW6eBj++cKkSoBobE8azr9nD
 i/60YbouD2mqV5K2x1x1aVBKbzC/ddbXabjnAE0FIc6jTtDIbBJ/1jpsJDWInpC8YDFPo9wrVO1
 sUb67jbpENnA+aqNb/7ZNOyA/jAE9z7HLl66SUBtkkcb/5W58PYkqBiUR2OeSw==
X-Google-Smtp-Source: AGHT+IFoygaaqRZY4MpjSkbKv3SZzU7WJHNsxEBnkzkXypS3wGU5cUJeSySRFnUb0pFpWfG7age/tA==
X-Received: by 2002:a05:6a20:7344:b0:1f5:7c6f:6c8b with SMTP id
 adf61e73a8af0-21adff5ae5bmr15141189637.10.1748801561586; 
 Sun, 01 Jun 2025 11:12:41 -0700 (PDT)
Received: from ubuntu.. ([49.207.58.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afed4bafsm6189191b3a.79.2025.06.01.11.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 11:12:41 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Mads Ynddal <mads@ynddal.dk>, Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
Date: Sun,  1 Jun 2025 18:12:30 +0000
Message-Id: <20250601181231.3461-3-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250601181231.3461-1-tanishdesai37@gmail.com>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pf1-x431.google.com
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

Moved rarely used (cold) code from the header file to the C file to avoid
unnecessary inlining and reduce binary size. This improves code organization
and follows good practices for managing cold paths.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/ftrace.py | 44 +++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index baed2ae61c..c9717d7b42 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -23,6 +23,10 @@
 def generate_h_begin(events, group):
     out('#include "trace/ftrace.h"',
         '')
+    for event in events:
+        out('void _ftrace_%(api)s(%(args)s);',
+            api=event.api(),
+            args=event.args)
 
 
 def generate_h(event, group):
@@ -30,26 +34,42 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    {',
+    out('        if (trace_event_get_state(%(event_id)s)) {',
+        '           _ftrace_%(api)s(%(args)s);',
+        '        }',
+        name=event.name,
+        args=", ".join(event.args.names()),
+        event_id="TRACE_" + event.name.upper(),
+        event_lineno=event.lineno,
+        event_filename=os.path.relpath(event.filename),
+        fmt=event.fmt.rstrip("\n"),
+        argnames=argnames,
+        api=event.api()
+        )
+
+
+def generate_c(event, group):
+        argnames = ", ".join(event.args.names())
+        if len(event.args) > 0:
+            argnames = ", " + argnames
+        out('void _ftrace_%(api)s(%(args)s){',
         '        char ftrace_buf[MAX_TRACE_STRLEN];',
         '        int unused __attribute__ ((unused));',
         '        int trlen;',
-        '        if (trace_event_get_state(%(event_id)s)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
-        '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
+        '       trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
-        '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '        }',
-        '    }',
-        name=event.name,
-        args=event.args,
-        event_id="TRACE_" + event.name.upper(),
+        '                       "%(name)s " %(fmt)s "\\n" %(argnames)s);',
+        '       trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
+        '       unused = write(trace_marker_fd, ftrace_buf, trlen);',
+        '}',
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
+        name=event.name,
         fmt=event.fmt.rstrip("\n"),
-        argnames=argnames)
+        argnames=argnames,
+        api=event.api(),
+        args=event.args)
 
 
 def generate_h_backend_dstate(event, group):
-- 
2.34.1


