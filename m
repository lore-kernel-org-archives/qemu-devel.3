Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E985CC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScsQ-0000Kv-CW; Fri, 20 Jun 2025 10:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScs7-0000IL-1A
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:41 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScs2-0001jP-W8
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:37 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so1391654a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750430252; x=1751035052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmgSEfeN8Rj2llj00/Kzt6ONzAD2UZfzQQNsTGfLFsw=;
 b=ZgxM3jPni/bRTipBHdriDL11w+Ec38jBy4kNXl91GoNZnbgkQtlNHKCHH8bFYrV26/
 tdf09h5F9ClNq1PQDD6gRLr/+WKNEf36AIur8SxbPt1QkiRG39l2a4pJ13z7NA06V6E4
 kbbdG/XSuB0bdhjtnI+iE9lERvod3M2Em9A4VOPp7onwVdDKMpVdT25uM8jSf+TfFwSV
 gz+f6TDxwkzUeg6FpVMb+Qp1wNDqRPVsRBPsa4D82DdesrkkQ+vBqWlGbCq8qzSbZXNQ
 QyyZgoP7B9t18FFHUamVKaSi0R/0V0KOaIzq4htrGsYmxj4st6mk3Ey3FOwYYjpFhL7T
 GRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430252; x=1751035052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmgSEfeN8Rj2llj00/Kzt6ONzAD2UZfzQQNsTGfLFsw=;
 b=v0aJjd7NrbWJSC2B1h6Lqw7X3glbIIohkqDVFhjN84TQSge2fupqzVxHVu2XOz6nio
 igoqERHW/vpqzzt0Z4lnbm+A+2BW4ab7v1K4lr07i5Zxu0HaRtrOE7keECJn0Kq5OaFe
 zRsPt0WfYF4sl5RVp/mjaXn7IoL5cOczmTgIa2W+8RmvxfJ+k+kwMxN+zeOsDCri1bED
 TWxl7L3YSEMnNUX4USqhjo5QPlVeNeftsZj4rNopTy7hNu5i0dDfqIMJDYKljxIfe2kA
 XVnAF7oVR+awY7C9RYehyrWzQRu/7jAo3MMFbyjzUMiDoeDwEs+HwPBi09STLibWyE+A
 FsZw==
X-Gm-Message-State: AOJu0Yyijhq9YEDvISQqAinwx+DjckzMtNBxvZho7AXCRcsN2nBDBXBL
 4IGz9hubSPm+2B22lUYlAFX3juGhBmpMJk1dTMZkHRbhsitj7Xotvi+twwqwKV5F2Eu9Iw==
X-Gm-Gg: ASbGncv4rMU851ZpYVCg3r7UTja54/jBVhOYP1dWtfifVDc0o0lGJ1Vkgf5Ygr2TS0l
 lA3Bpm6HGkk2bb5CHLDZ1gTfyoL3Sesmeg9vUKZm5FSL+tXYYA7IHrMi/V2A5prq7jMi6CGruyJ
 PeKDnFWDlNE3dPksSftDlPDINmqeEi4TXJRqY6Yz4w0jNKlrQwc8W6TRc1TDIWjoM1QiY23bL4f
 cax8VC5bvfjJ+usWUtFngLW+aJblGqH887lCqrEuS7Nq1/evs/79BbXsSgLaTCg1stb4egn4u05
 IyEXaVABg0B0GU3u8yuxzEsGNwAvVWNXCqHjeLG0soSF18QU2dVf9es4rBam7kRm9gyc1sBl
X-Google-Smtp-Source: AGHT+IEk5cHIAeMx1rk5pi/nMZube8xkjZVXwrMsrLXfs1uN7epP8x/wRy4qidlNWOTy/DX73mzq0A==
X-Received: by 2002:a17:90b:5826:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-3159d64432cmr5389429a91.8.1750430252213; 
 Fri, 20 Jun 2025 07:37:32 -0700 (PDT)
Received: from ubuntu.. ([27.61.32.140]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a2f0cf5sm4368820a91.26.2025.06.20.07.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:37:31 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH v2 3/3] tracetool: remove redundant event_get_state checks
Date: Fri, 20 Jun 2025 14:37:20 +0000
Message-Id: <20250620143720.3143-4-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620143720.3143-1-tanishdesai37@gmail.com>
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pg1-x534.google.com
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

Moved trace_event_get_state check from _no_check_trace_foo to trace_foo,
and removed if (true) checks.

The _no_check_trace_foo now only emits backend-specific core
logic, avoiding trace event conditionals entirely.

This brings conditional logic in format/h.py, reducing duplication across
backends and simplifying their code generation. 

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/ftrace.py | 3 ---
 scripts/tracetool/backend/log.py    | 5 +----
 scripts/tracetool/backend/simple.py | 7 +------
 scripts/tracetool/backend/syslog.py | 7 +------
 scripts/tracetool/format/h.py       | 3 ++-
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index baed2ae61c..2d6d608add 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -34,18 +34,15 @@ def generate_h(event, group):
         '        char ftrace_buf[MAX_TRACE_STRLEN];',
         '        int unused __attribute__ ((unused));',
         '        int trlen;',
-        '        if (trace_event_get_state(%(event_id)s)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
         '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
         '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
         '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
         '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '        }',
         '    }',
         name=event.name,
         args=event.args,
-        event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         fmt=event.fmt.rstrip("\n"),
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index f24acad74c..35a3aeee55 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -31,9 +31,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
-
-    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
+    out('    if (qemu_loglevel_mask(LOG_TRACE)) {',
         '        if (message_with_timestamp) {',
         '            struct timeval _now;',
         '            gettimeofday(&_now, NULL);',
@@ -49,7 +47,6 @@ def generate_h(event, group):
         '#line %(out_next_lineno)d "%(out_filename)s"',
         '        }',
         '    }',
-        cond=cond,
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         name=event.name,
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 7c84c06b20..ce8036f5da 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
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
index 6fdc1142fb..f84cec641c 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -30,14 +30,9 @@ def generate_h(event, group):
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
         event_filename=os.path.relpath(event.filename),
         name=event.name,
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 89d54b9aff..7bbe6d3148 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -71,7 +71,8 @@ def generate(events, backend, group):
 
         out('}')
 
-        cond = "true"
+        event_id = 'TRACE_' + e.name.upper()
+        cond = "trace_event_get_state(%s)" % event_id
 
         out('',
             'static inline void %(api)s(%(args)s)',
-- 
2.34.1


