Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16733CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZFg-00017s-FC; Fri, 19 Sep 2025 07:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFZ-00014W-2J
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFW-000165-RA
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUo28CHP7FCCXh5r1Z6RrGofUxFzz8ZREv636OwD0Dc=;
 b=R6Mj2U3klgo8BwLVoxg4uE9i81FTVARL16VjqliJNVJ7rptr3afsCgEWT3SiPJgh6y8+4S
 UDZgCpN9OYYlVl+opKyZLdPXwfjqgp5rZrZUTJGkPG7cHBH8BahebYALIMRrHSi41N6W5k
 RJKPglOU4+uOknfzhdYEyL790HyKpjs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-RzMVCz-FOSS3wTJnxOHmiA-1; Fri,
 19 Sep 2025 07:25:53 -0400
X-MC-Unique: RzMVCz-FOSS3wTJnxOHmiA-1
X-Mimecast-MFC-AGG-ID: RzMVCz-FOSS3wTJnxOHmiA_1758281152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32ED11800343; Fri, 19 Sep 2025 11:25:52 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9038230002C8; Fri, 19 Sep 2025 11:25:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 02/16] tracetool: remove dead code
Date: Fri, 19 Sep 2025 13:25:22 +0200
Message-ID: <20250919112536.141782-3-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
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

There are no tcg-exec events anymore and the sub-event functionality was
only used for it.  Excise it from tracetool.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py | 44 +++++------------------------------
 scripts/tracetool/format/h.py |  5 ----
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 1d5238a0843..afa889e759e 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -122,10 +122,6 @@ def __init__(self, args):
             else:
                 self._args.append(arg)
 
-    def copy(self):
-        """Create a new copy."""
-        return Arguments(list(self._args))
-
     @staticmethod
     def build(arg_str):
         """Build and Arguments instance from an argument string.
@@ -222,13 +218,12 @@ class Event(object):
                       r"(?P<name>\w+)"
                       r"\((?P<args>[^)]*)\)"
                       r"\s*"
-                      r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
+                      r"(?P<fmt>\".+)?"
                       r"\s*")
 
     _VALID_PROPS = set(["disable"])
 
-    def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
-                 event_trans=None, event_exec=None):
+    def __init__(self, name, props, fmt, args, lineno, filename):
         """
         Parameters
         ----------
@@ -236,20 +231,14 @@ def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
             Event name.
         props : list of str
             Property names.
-        fmt : str, list of str
-            Event printing format string(s).
+        fmt : str
+            Event printing format string.
         args : Arguments
             Event arguments.
         lineno : int
             The line number in the input file.
         filename : str
             The path to the input file.
-        orig : Event or None
-            Original Event before transformation/generation.
-        event_trans : Event or None
-            Generated translation-time event ("tcg" property).
-        event_exec : Event or None
-            Generated execution-time event ("tcg" property).
 
         """
         self.name = name
@@ -258,29 +247,16 @@ def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
         self.args = args
         self.lineno = int(lineno)
         self.filename = str(filename)
-        self.event_trans = event_trans
-        self.event_exec = event_exec
 
         if len(args) > 10:
             raise ValueError("Event '%s' has more than maximum permitted "
                              "argument count" % name)
 
-        if orig is None:
-            self.original = weakref.ref(self)
-        else:
-            self.original = orig
-
         unknown_props = set(self.properties) - self._VALID_PROPS
         if len(unknown_props) > 0:
             raise ValueError("Unknown properties: %s"
                              % ", ".join(unknown_props))
-        assert isinstance(self.fmt, str) or len(self.fmt) == 2
 
-    def copy(self):
-        """Create a new copy."""
-        return Event(self.name, list(self.properties), self.fmt,
-                     self.args.copy(), self.lineno, self.filename,
-                     self, self.event_trans, self.event_exec)
 
     @staticmethod
     def build(line_str, lineno, filename):
@@ -302,8 +278,7 @@ def build(line_str, lineno, filename):
         name = groups["name"]
         props = groups["props"].split()
         fmt = groups["fmt"]
-        fmt_trans = groups["fmt_trans"]
-        if fmt.find("%m") != -1 or fmt_trans.find("%m") != -1:
+        if fmt.find("%m") != -1:
             raise ValueError("Event format '%m' is forbidden, pass the error "
                              "as an explicit trace argument")
         if fmt.endswith(r'\n"'):
@@ -312,29 +287,22 @@ def build(line_str, lineno, filename):
         if '\\n' in fmt:
             raise ValueError("Event format must not use new line character")
 
-        if len(fmt_trans) > 0:
-            fmt = [fmt_trans, fmt]
         args = Arguments.build(groups["args"])
 
         return Event(name, props, fmt, args, lineno, posix_relpath(filename))
 
     def __repr__(self):
         """Evaluable string representation for this object."""
-        if isinstance(self.fmt, str):
-            fmt = self.fmt
-        else:
-            fmt = "%s, %s" % (self.fmt[0], self.fmt[1])
         return "Event('%s %s(%s) %s')" % (" ".join(self.properties),
                                           self.name,
                                           self.args,
-                                          fmt)
+                                          self.fmt)
     # Star matching on PRI is dangerous as one might have multiple
     # arguments with that format, hence the non-greedy version of it.
     _FMT = re.compile(r"(%[\d\.]*\w+|%.*?PRI\S+)")
 
     def formats(self):
         """List conversion specifiers in the argument print format string."""
-        assert not isinstance(self.fmt, list)
         return self._FMT.findall(self.fmt)
 
     QEMU_TRACE               = "trace_%(name)s"
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index b42a8268a81..bd9e0ca7f23 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -40,11 +40,6 @@ def generate(events, backend, group):
             enabled = 0
         else:
             enabled = 1
-        if "tcg-exec" in e.properties:
-            # a single define for the two "sub-events"
-            out('#define TRACE_%(name)s_ENABLED %(enabled)d',
-                name=e.original.name.upper(),
-                enabled=enabled)
         out('#define TRACE_%s_ENABLED %d' % (e.name.upper(), enabled))
 
     backend.generate_begin(events, group)
-- 
2.51.0



