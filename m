Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA17E6F08C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 20:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6yh1-0001Tf-Jg; Fri, 01 Nov 2024 16:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dUAlZwYKCso746Auxw44w1u.s426u2A-tuBu1343w3A.47w@flex--roqueh.bounces.google.com>)
 id 1t6ygz-0001TN-CC
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:56:25 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dUAlZwYKCso746Auxw44w1u.s426u2A-tuBu1343w3A.47w@flex--roqueh.bounces.google.com>)
 id 1t6ygx-0004Iw-I3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:56:25 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e2e3321aae0so4056968276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730494581; x=1731099381; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MYrsCIc9rC3vw4f/MUeO4v8khFDjT5HOcW09op81Jj8=;
 b=yUTphOO49hkCkg5Km/Ypl9+EidR7Pp03vxB0gxI8UvM+afsRUEGg/8T/qwq7CIRbWm
 tGU34K5lUIRdbA1GeL4yOiNWTNK9GJyJb3TQKygxtC2ci+1/gRPLyyZ1ljuwORgWLpqD
 rKR7HEfRs+x8C0i3wr1iwyyHd8YrehtWPMco5cBG5ZydZDx4P5bxqBLtkUwXohdKD1lU
 dHDnr8BtseqG8YCG1V6pHTvpIvfKNyiFn9U458eB08WkHoW1iEUGvac9WUr85wDcr818
 /ZYa1lH/PFfZh5vjhltmb4YR6AbKSbpvY4CtUkVGb6znTI9qSr4yQRs0IGqQSoRTshpm
 D4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730494581; x=1731099381;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MYrsCIc9rC3vw4f/MUeO4v8khFDjT5HOcW09op81Jj8=;
 b=DVPgIUxd3Y4Wo/q04Rfx1rkByKeEow0yL7kDgpA1C7tCq6an3tkaLfzCJVgbVt6bub
 jIsZN0IVaFMROHx7nHjM7RLqO2LK3UzvzijiojzqpVhrKFfdGucLaeh3PYAKTQIRoOLY
 rbQH+gZPgUXiOhgjoXkKbAuA8FgS5MVOMHMaE7u3hj+h6r6HVV+neu5KIuDBPibdx6CN
 mhiUoDiW2wV3Hcop1aT3v0iov85W4T8arKdH12t39VZPvY/1y5bqva/hpF4R6VkxAvQ+
 vFe99HuYXnb3oQOJnPFURiXwBAmuCEAiTmR3+3RnWD080O2R6VHmtANXFgeWG0eZE9I6
 WmTw==
X-Gm-Message-State: AOJu0YwNkfbNcUfuQAgPv3R40q8v5Rt/nZLTiNhkMTKjzbmXAggxQS3B
 4SWBNCwu9vWtc9pX9/NTvpISMaUs7fhy0lHFvb6GHqofotblsPSeEJjIOxD+7WtoPr4HeGOnzl8
 V3w==
X-Google-Smtp-Source: AGHT+IG0weoXVa6iXafIH1bRgRFDdY/01B3Oev/f/h+oSwQXmnQNbEeQEq98r+5C3Zd/kJauxUeYBZO9Q+A=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a25:b847:0:b0:e30:dfb5:8a8d with
 SMTP id
 3f1490d57ef6-e30e5a03f2fmr4667276.2.1730494581069; Fri, 01 Nov 2024 13:56:21
 -0700 (PDT)
Date: Fri,  1 Nov 2024 20:56:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101205616.3332303-1-roqueh@google.com>
Subject: [PATCH] scripts/tracetool:Use posix paths in trace event generation
From: Roque Arcudia Hernandez <roqueh@google.com>
To: jansene@google.com, stefanha@redhat.com, mads@ynddal.dk
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3dUAlZwYKCso746Auxw44w1u.s426u2A-tuBu1343w3A.47w@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On windows machines the path seperator is '\\' (backslash) which causes
the tracetool generator to output line information in the source code
with the '\\' character. This in turn confuses the compiler, causing
build breaks.

We now will always use posix paths, so the paths will use a '/'
(forward) slash.

Signed-off-by: Erwin Jansen <jansene@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 scripts/tracetool/__init__.py       | 3 ++-
 scripts/tracetool/backend/ftrace.py | 5 +++--
 scripts/tracetool/backend/log.py    | 5 +++--
 scripts/tracetool/backend/syslog.py | 6 +++---
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index bc03238c0f..ccab820532 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -15,6 +15,7 @@
 import re
 import sys
 import weakref
+from pathlib import Path
 
 import tracetool.format
 import tracetool.backend
@@ -55,7 +56,7 @@ def out(*lines, **kwargs):
     for l in lines:
         kwargs['out_lineno'] = out_lineno
         kwargs['out_next_lineno'] = out_lineno + 1
-        kwargs['out_filename'] = out_filename
+        kwargs['out_filename'] = Path(out_filename).as_posix()
         output.append(l % kwargs)
         out_lineno += 1
 
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index baed2ae61c..940c9be980 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -12,7 +12,8 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
+from os.path import relpath
+from pathlib import Path
 
 from tracetool import out
 
@@ -47,7 +48,7 @@ def generate_h(event, group):
         args=event.args,
         event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=Path(relpath(event.filename)).as_posix(),
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
 
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62e..626840eef7 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -12,7 +12,8 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
+from pathlib import Path
+from os.path import relpath
 
 from tracetool import out
 
@@ -55,7 +56,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=Path(relpath(event.filename)).as_posix(),
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 012970f6cc..32e4bba4f9 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -11,8 +11,8 @@
 __maintainer__ = "Stefan Hajnoczi"
 __email__      = "stefanha@redhat.com"
 
-
-import os.path
+from os.path import relpath
+from pathlib import Path
 
 from tracetool import out
 
@@ -43,7 +43,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=Path(relpath(event.filename)).as_posix(),
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
-- 
2.47.0.163.g1226f6d8fa-goog


