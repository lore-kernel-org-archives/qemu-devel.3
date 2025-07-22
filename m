Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65741C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 15:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueFFu-0001vq-KW; Tue, 22 Jul 2025 11:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueEWo-0002lE-Uu
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueEWk-0000JA-HW
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753196612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bu8CGoHO7/SEyFw5fKKRMjpzD8KOdRCSnJABlZwSpOE=;
 b=LJ/eR26L/rl5xdtyMEu8cTF7b/WSkptlhPpa06CmSrU/9CRHUDQe+4H5UGibzEAPJeI230
 /o1MKwWNcMxU3vM25e8/XBNA8//9LPzfoUuTs1bu/yIY8ZtdGHIfArnTVHjBgkl4y266Wu
 aDKit23x6GkOLFACI4ALdWe3j3ZRnpI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-SXYuTdvEPrehwMlpTZd0FQ-1; Tue,
 22 Jul 2025 11:03:28 -0400
X-MC-Unique: SXYuTdvEPrehwMlpTZd0FQ-1
X-Mimecast-MFC-AGG-ID: SXYuTdvEPrehwMlpTZd0FQ_1753196607
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8850A18001DD; Tue, 22 Jul 2025 15:03:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99358180045B; Tue, 22 Jul 2025 15:03:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PULL 1/1] tracetool: removed the unused vcpu property
Date: Tue, 22 Jul 2025 11:03:22 -0400
Message-ID: <20250722150322.20372-2-stefanha@redhat.com>
In-Reply-To: <20250722150322.20372-1-stefanha@redhat.com>
References: <20250722150322.20372-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
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

The vcpu property is no longer used in these backends. Removing it avoids
unnecessary checks and simplifies the code generation for these trace
backends.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Message-id: 20250722114352.3624-1-tanishdesai37@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py       | 2 +-
 scripts/tracetool/backend/log.py    | 6 +-----
 scripts/tracetool/backend/simple.py | 6 +-----
 scripts/tracetool/backend/syslog.py | 6 +-----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 6dfcbf71e1..2ae2e562d6 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -219,7 +219,7 @@ class Event(object):
                       r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
                       r"\s*")
 
-    _VALID_PROPS = set(["disable", "vcpu"])
+    _VALID_PROPS = set(["disable"])
 
     def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
                  event_trans=None, event_exec=None):
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 17ba1cd90e..5c9d09dd11 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -29,11 +29,7 @@ def generate_h(event, group):
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
index 5a3a00fe31..3f82e54aab 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -28,11 +28,7 @@ def generate_h(event, group):
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
2.50.1


