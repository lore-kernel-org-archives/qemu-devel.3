Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EBCC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uScs9-0000IH-B9; Fri, 20 Jun 2025 10:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScs1-0000Gd-9L
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:33 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uScry-0001il-Ho
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:37:32 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3138d31e40aso1795211a91.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750430248; x=1751035048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EOZuE27rMxCbmFwxycMCT8+sPkrS3/sMxJ+gWLILdM=;
 b=T+EjG4OBJsymbS10IpQwhLwP7XrfgYyeOFqK7qxQ+nz6G7H6CBrAzO2OkXOltp3pl9
 AxgdxUxGTb0inmghy7L+/pVNdTo9gi1GXi3EGALJFRNDmuKnRLD7OJ9eHKXHJlFspoMD
 9pm9wHlTGmqd3diYydXTNcHYr4cR+QMDxzp+M5OzE48KXLhkE84M4zqQVO7X5WCRoGd4
 cet012UyGC/WGbtxxA64WKdF4zETKO2Q3/X7bKp2XfgE48Yvx80/Ly5OsZWlkr6oqyLz
 JEe6ZoVTKF6jU1wQC4LiO1AFAO+SML2GoWbC1DFjzIZki3gkEDza7Apwao0u7wV62xcz
 aRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430248; x=1751035048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EOZuE27rMxCbmFwxycMCT8+sPkrS3/sMxJ+gWLILdM=;
 b=oM4fIswZsaZTN0vokl0ZLCzAKgNuAQncQVubiC68ysn8zNqCqRnZZsm6XtOl7a3gG6
 oy4Pwc56aaZ26lYQCgoSsAp9qHDYoWYuw6CUkp4FRBk4srgZKQyVPQwoLhdBNygkGp1D
 meUsqwSuOWTiRlavh00n5LIHukh3OtdeSbqLeaPE6G7dWQTlx0y7/3qpFrKdNfQQdvT6
 WDmMjPaXMNnmsse1fu8vfYdzTgg6+jjqDXrTTlUNKukT0mWbrEpnxzU6oMZ8bxu9gkXZ
 ACgUIJJsweIbhXbLkkF6sIrKjYwR8elMB8Yxb0LSfx+mbwZKrZsHqWH+W2rdzc4VKb0T
 p0qA==
X-Gm-Message-State: AOJu0YzoFwRBNOhdyvoa5adPNzdU9h8Aoq14nrN4YEXZpvyWV9IqQInF
 m6QZ44kRL/+Vku/nq2iVxYJ6Ho+/Gm2S4WW+PM6N9oWTU0yeNnGOJzid8I5ns6Gn6OPfMg==
X-Gm-Gg: ASbGncvgV8sFUaBGBB1IcYyz9NNbrllg5IL/n34N0ZBNZJ5d9uiCA7lJveKy9QQImZv
 nEf7asRAJywsSwO32vp+P4lV5iXm42drKmAlSQ4LHzK+QbwdfC91wrhRRj9HNkc7UIbM+fLLOiT
 WrmFHTBG74bhfP6f1XvJq6b0aYSFc1TMbvpgw0C6x/vkL7rMsXC0rza8LVUAnu6oC67N5utwFAl
 9sk1evM681J9a++TtHk8TVOZgt8c+Er8j5cyLOIzgDQE36dleWYIbKAqjPp6cnJp7lx2CM/RZzD
 0lmUIDoiblEJ7aUTUR2a4qRNumeKI03C3p/bmWkQy7gS5RuqdjoscNBlBWxnkpc6u9thriFGdMO
 xbxUd/KU=
X-Google-Smtp-Source: AGHT+IEqjeD7EaC0kCRHoLPhXmQabmXgc4btLqBTNHVhO9iI3S6Mw8TLcjM09yQpGkJ4SXykUv62Yg==
X-Received: by 2002:a17:90b:5105:b0:311:a314:c2ca with SMTP id
 98e67ed59e1d1-3159d620720mr4522924a91.6.1750430247691; 
 Fri, 20 Jun 2025 07:37:27 -0700 (PDT)
Received: from ubuntu.. ([27.61.32.140]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a2f0cf5sm4368820a91.26.2025.06.20.07.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:37:27 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH v2 1/3] tracetool: removed the unused vcpu property
Date: Fri, 20 Jun 2025 14:37:18 +0000
Message-Id: <20250620143720.3143-2-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620143720.3143-1-tanishdesai37@gmail.com>
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pj1-x102f.google.com
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
unnecessary checks and simplifies the code generation for these trace
backends.

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


