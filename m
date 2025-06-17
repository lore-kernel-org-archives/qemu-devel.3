Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A57BC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 18:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRbB0-00081I-GD; Tue, 17 Jun 2025 14:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRbAy-00080r-9o
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:36:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRbAw-0006Qj-MM
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:36:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23633a6ac50so88203615ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750185408; x=1750790208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSeq3zKyvNEH98Ef19TGp9ugIdv9/k6rVRDQBz3u+ao=;
 b=RPIy4a7Bgac1RbNH2MXWwGDbYQJ+5VP7uJ13EoZkIOIFVRKpgOyqKHG3oLhYJZx+Dy
 j5F02ZgMHhu3jpcyfEviRATl6/M6R6XKv1IfyH37sbzBAFBVIm0JCvv8Bq0A3XScu/PO
 nEEf1XJCmQ0oIQ8SQup3azdVwg9QwfvuaCPbhdqYphBucn5riCXeKix4UEyLK5SpyiDd
 Rbw3QYjgtOUbmikhiIbTSOriHkNNO+ZkVgWbqxuwlgQoUfMpvjrVVoEmRr1ZupgiupUN
 LKBeGMLfZqJQRXLwarvKgm7LEiRQ61xGuuSmmiq8v5+ECVVC3etgpb1DlGTaqOkwyRqt
 CnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750185408; x=1750790208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSeq3zKyvNEH98Ef19TGp9ugIdv9/k6rVRDQBz3u+ao=;
 b=US9H96NiabQfODys5uq/PmlzR5RBpE7OAiF+mSaMZb8358uZniyoaWRPyZCJuCI+/N
 vVyXEnF73d3wMeyXrLWZk0HO3P9vzfQQrwFF6G/FZ+N2Djb7nD294vj5AGPJ7GTj1kLz
 QVgUKEmAFtxvY+/ejIU7FuffVoP1yMqJ+K7CPu5bi5x1BlxeSxn76AGcX8RpQO9imNEn
 l5DM0J33tHlVkYtIsNEuD1RhMbCt0EOjzI72rFVjWxHlFMxj4ZXndwoEIKcL7MXLHl0l
 SRfDT3B9rv5Jy7e8B9M4I8AOqoT7ywPY6K9flb9MUZvGG3cTSMRXA28BxwpW0LzpuuTT
 t3wQ==
X-Gm-Message-State: AOJu0YzGRvXXOG2aA9jOkmaFla45dDn2wImlFNInRVYuQGdh0kmZ+lBt
 uVd4Pd/KTEpx3DomsXSvrL/675f9Hr+tXHHcm7lcpARy2fDmxwzkMakIkr8WHJ+O3s8ovA==
X-Gm-Gg: ASbGncsZ7wnIfMKkKAf8Gv5Ad8ydj3HGUSssiH8Q0s0cXocBcXgZdthQeQSuaqZqz+R
 jc1Mk3D1x/XZuq3jOiUuYEHbhcS5wjoq2Av4rd16BXqe1zCawIf9n14+HEbGnFn4zDgCi/sYnze
 4ogy27tofmbOk3LXvuDSuMP7CGKgdH9rxzbWuu7EQfdI7FNYHw7cAEEXdlPPdoj/Dh6v0gkpyw1
 tGaXLaVllMu6bdtJnPyqFezlXIM9hhoSxVSoo3HKIWgfRE4hHK+2OIHQ/fSZnJHaYVis+7WNNn9
 GHlFWPbOYpnCXT6YdGs7ZWZh5sTU78PDoCUvHhkkHZHHoHGEyJYaExDcAP9maW+CVPRymThU
X-Google-Smtp-Source: AGHT+IH5naVHOtCGNaWkBPJNIa7tBveQWc4NTRX5A1oXQk8YygQe+HIM1Mg/oCRFL8kZzRg2PFnYAA==
X-Received: by 2002:a17:902:dacf:b0:235:f1e4:3383 with SMTP id
 d9443c01a7336-2366b337fddmr180100125ad.7.1750185407932; 
 Tue, 17 Jun 2025 11:36:47 -0700 (PDT)
Received: from ubuntu.. ([49.207.59.144]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de78565sm83584295ad.124.2025.06.17.11.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 11:36:47 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mads@ynddal.dk, stefanha@redhat.com,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH v2] tracetool: removed the unused vcpu property
Date: Tue, 17 Jun 2025 18:36:19 +0000
Message-Id: <20250617183619.13581-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617140725.GA117267@fedora>
References: <20250617140725.GA117267@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x629.google.com
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

The vcpu property is no longer used in these backends. Removing it avoids
unnecessary checks and simplifies the code generation for these trace backends.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/__init__.py       | 6 +++---
 scripts/tracetool/backend/log.py    | 6 +-----
 scripts/tracetool/backend/simple.py | 6 +-----
 scripts/tracetool/backend/syslog.py | 6 +-----
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index bc03238c0f..e86c898a1e 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -216,9 +216,9 @@ class Event(object):
                       r"\s*"
                       r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
                       r"\s*")
-
-    _VALID_PROPS = set(["disable", "vcpu"])
-
+    
+    _VALID_PROPS = set(["disable"])
+    
     def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
                  event_trans=None, event_exec=None):
         """
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62e..f24acad74c 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -31,11 +31,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
+    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
         '        if (message_with_timestamp) {',
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 2688d4b64b..7c84c06b20 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -37,11 +37,7 @@ def generate_h_begin(events, group):
 
 def generate_h(event, group):
     event_id = 'TRACE_' + event.name.upper()
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % event_id
+    cond = "trace_event_get_state(%s)" % event_id
     out('    if (%(cond)s) {',
         '        _simple_%(api)s(%(args)s);',
         '    }',
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 012970f6cc..6fdc1142fb 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -30,11 +30,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
+    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-- 
2.34.1


