Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0DFC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitGd-0004Dz-PP; Mon, 04 Aug 2025 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uitFR-0002Oc-Gj
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:21:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uitFP-00059R-EY
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:20:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2401b855980so31287545ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754306452; x=1754911252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpmsa2uauy9jtjI3VfCYeYUs5VlkjZKNRdv/ln7sIzQ=;
 b=i6zk020yB1AIjS+gs/Wso629kfTjw1opH2MJvzQP60ldM09AVk3ZyjN2n8lXwhr6su
 LskLdakutgwctwO7y95F4RcZ2aVIi2p1GaQun+isjrANOn2jZ7dmCPaGt2K4n2k+SR9m
 UgOcANVWsfxi3diyYgIQJrDQarSJkjb9HLFonStpy4wHhgyebu+aWuNh65YpNmnR1U00
 CijulJWkQTZxBXs+3DI7eTrahtS92EzatvYCMUcT4OLUs2HoYw+OWRRb4ZZUtSDA/pSB
 YMRyq82/zK13aSRWxAmwjuxF780lxV7dI8FuJDiDSObIdMFSKTuIpy5xEOulkPTbQUIf
 WWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754306452; x=1754911252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpmsa2uauy9jtjI3VfCYeYUs5VlkjZKNRdv/ln7sIzQ=;
 b=S01sxYsoXLWo0TbxsoM0p3j5cKmD1bC8o9W06qnvs3Fimg65EiNap959pjUY9PRqJE
 bpUBk14zNf//bZkK647bTmVCKIgWApGVXfxbX+91Cw4FlV3wyIT0ah7gAvB7EJphU9Od
 C8f6wfAHTQ7aRtz/YmB22U+IaWL2Fn94gDBF31EZE9uvWDrZYEeIP63gqfyCBiqRCQ/h
 DTmsnE4yFzoVYcjYydLmg+VI8jbwy9E2gZ/B4NeDdfTPLzlBkZ/PrSBvBVhwwnRfTWtf
 klhmpNMYnlnm8x0DueaMvoDgJgUCM8xmS7dpB2o+9HuizQ8ZXY+/GP3eV2NyHz4z/0fa
 7Brg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU81o7J5VHKna8GalchTE5G39K0ovqkQmHobtT1TUf/AeJxI84PF8LVYrEtFastjcfAUJDjE77G6UIE@nongnu.org
X-Gm-Message-State: AOJu0YzZ9jH92VTiftCTomONxuuo5cPRxTapceRuiVsff+KCLu0VthU2
 6TQkQqD3S+oPRLAWWFXd3TZ+T+i6j2oWRVBSOBpG1j2GcDsV9/v9Q0jK
X-Gm-Gg: ASbGncu0Z9MBDQzet3kD+/pFhEOdcq2uS1AxFvxa1y6eRti1N6UooLz4E2ElRkPUXbZ
 EuzFeCbmUdWyIWWjjzVf77Wagf6VEyvm1kUvabh8DF7ngWxXQ9eJ6cmvmsY0jA+FxvUxmAJD/02
 AcqQW3D0Y9wRzOtRAipQdLk7oLNINNDnq/bGXEgiaCtJuIbSNnqYnA7xELVZv0VOatffZ8fLVPX
 0tofN/uuWABtdHXANK3LTqfukefu3yIaDjBd/XezGw4IP/pzFF2yXsLD1GE09MUKDXJLknXC9Fx
 DTNHDKlkChDSSE2taFC1xRr0XTUoaC4ZG30bVberPulGh+JNF6ODYCJ3Ymfu8IyuBjFK8pD/w8e
 PbmVVD0qsnxW1Bwkuc7cvqTeSpsETOhpKYrSity8u6w==
X-Google-Smtp-Source: AGHT+IHuMOTswYHZPsJmyM7EIIieoItY9XBWLGMscTCF7DjvUV9dv+8bdquksxKDKnXpeixJZDzjvw==
X-Received: by 2002:a17:903:41c1:b0:234:a139:1206 with SMTP id
 d9443c01a7336-2424703c119mr148977385ad.40.1754306451655; 
 Mon, 04 Aug 2025 04:20:51 -0700 (PDT)
Received: from localhost.localdomain ([106.215.159.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e83esm106901675ad.49.2025.08.04.04.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 04:20:51 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: tanishdesai37@gmail.com,
	qemu-devel@nongnu.org,
	pbonzini@redhat.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 2/2] tracetool/format: remove redundent trace-event checks
Date: Mon,  4 Aug 2025 11:20:39 +0000
Message-Id: <20250804112039.16377-3-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804112039.16377-1-tanishdesai37@gmail.com>
References: <20250804112039.16377-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x633.google.com
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

Remove redundent if(check_trace_event) check
from individual backends.
Adding CHECK_TRACE_EVENT_GET_STATE in log,syslog,
dtrace and simple backend.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/ftrace.py | 4 +---
 scripts/tracetool/backend/log.py    | 6 ++----
 scripts/tracetool/backend/simple.py | 9 ++-------
 scripts/tracetool/backend/syslog.py | 8 ++------
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 5fa30ccc08..b38f527461 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -32,18 +33,15 @@ def generate_h(event, group):
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
         event_filename=event.filename,
         fmt=event.fmt.rstrip("\n"),
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index eb50ceea34..d8406d226b 100644
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
+    out('    if (qemu_loglevel_mask(LOG_TRACE)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
         '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
         '    }',
-        cond=cond,
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


