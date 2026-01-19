Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB48FCCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhucM-0002DK-No; Mon, 19 Jan 2026 14:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhucE-00027i-7J
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhucA-0000ux-If
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768849717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+Zs1MQT076hrWr8oPohlhJ/KZenoAoXSpTdwuz04yA=;
 b=YO+H4B9FXVi6nRLmloI3PzYc0RuyLAWtBziPcK/HaFhZGHmeBbd26321PTD2gse/v7lmu7
 3C32pMZtupw4ZF98fXjf4WL/pADh2wAC7l7wYX+0DbJVOhOzqVBvrpevh8/mi4JJoTq1xQ
 LMKqYoJYcwN5NwvnLZI6rKjchM3eUO0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-R9fBAaTRNn2rsdUgqGtSmw-1; Mon,
 19 Jan 2026 14:08:34 -0500
X-MC-Unique: R9fBAaTRNn2rsdUgqGtSmw-1
X-Mimecast-MFC-AGG-ID: R9fBAaTRNn2rsdUgqGtSmw_1768849713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55E9819560A1; Mon, 19 Jan 2026 19:08:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFFF8180049F; Mon, 19 Jan 2026 19:08:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Richard Henderson <rth@twiddle.net>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 4/8] tracetool: add type annotations
Date: Mon, 19 Jan 2026 14:08:19 -0500
Message-ID: <20260119190823.867761-5-stefanha@redhat.com>
In-Reply-To: <20260119190823.867761-1-stefanha@redhat.com>
References: <20260119190823.867761-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Created with a profiling-based tool, righttyper.  I used this script:

  python -m righttyper --generate-stubs --no-sampling --overwrite  -- ./tracetool.py --help
  find . -name "*.pyi" | while read fname; do
    merge-pyi --in-place -b bak.$fmt ${fname%i} $fname
  done

  for fmt in c h rs d log-stap simpletrace-stap stap ust-events-c ust-events-h; do
    find . -name '*.pyi*' | xargs rm
    python -m righttyper --generate-stubs --no-sampling --overwrite ./tracetool.py \
      --format=$fmt --backends=ust,simple,syslog,ftrace,dtrace,log --group=testsuite \
      --binary=qemu --probe-prefix=qemu ../tests/tracetool/trace-events outfile.$fmt
    find . -name "*.pyi" | while read fname; do
      merge-pyi --in-place -b bak.$fmt ${fname%i} $fname
    done
  done

  python -m isort $(find tracetool -name "*.py")

Running the script took about 5 minutes.  The errors were mostly
due to misunderstanding the "try_import" function:

  tracetool/backend/__init__.py:83: error: Incompatible types in assignment (expression has type Module, variable has type "tuple[bool, Module]")  [assignment]
  tracetool/backend/__init__.py:117: error: Incompatible types in assignment (expression has type Module, variable has type "str")  [assignment]
  tracetool/__init__.py:543: error: Incompatible return value type (got "tuple[bool, None]", expected "tuple[bool, Module]")  [return-value]
  tracetool/format/__init__.py:60: error: Incompatible types in assignment (expression has type Module, variable has type "tuple[bool, Module]")  [assignment]
  tracetool/format/__init__.py:85: error: Argument 2 to "try_import" has incompatible type "str"; expected "None"  [arg-type]
  tracetool/format/__init__.py:88: error: Module not callable  [operator]

On top of this I fixed a little weirdness, while leaving the unannotated
functions unchanged.  Being profiling-based, righttyper did not annotate
anything not covered by the check-tracetool testsuite:
- error cases
- PRIxxx macros

It also reported list[Never] for always-empty lists, which is incorrect.
Righttyper also has a few limitations: it does not annotate nested functions
(there were only four of them), or "*args" argument lists.  These are fixed
in the next patch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251008063546.376603-5-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool.py                         |  5 +-
 scripts/tracetool/__init__.py                | 54 ++++++++++----------
 scripts/tracetool/backend/__init__.py        | 19 +++----
 scripts/tracetool/backend/dtrace.py          | 16 +++---
 scripts/tracetool/backend/ftrace.py          | 10 ++--
 scripts/tracetool/backend/log.py             | 10 ++--
 scripts/tracetool/backend/simple.py          | 16 +++---
 scripts/tracetool/backend/syslog.py          | 10 ++--
 scripts/tracetool/backend/ust.py             |  8 +--
 scripts/tracetool/format/__init__.py         |  7 +--
 scripts/tracetool/format/c.py                |  5 +-
 scripts/tracetool/format/d.py                |  5 +-
 scripts/tracetool/format/h.py                |  5 +-
 scripts/tracetool/format/log_stap.py         |  7 +--
 scripts/tracetool/format/rs.py               |  5 +-
 scripts/tracetool/format/simpletrace_stap.py |  5 +-
 scripts/tracetool/format/stap.py             |  7 +--
 scripts/tracetool/format/ust_events_c.py     |  5 +-
 scripts/tracetool/format/ust_events_h.py     |  5 +-
 19 files changed, 109 insertions(+), 95 deletions(-)

diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 390f1a371b..0688c9cf5f 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -16,6 +16,7 @@
 
 import getopt
 import sys
+from typing import NoReturn
 
 import tracetool.backend
 import tracetool.format
@@ -23,7 +24,7 @@
 
 _SCRIPT = ""
 
-def error_opt(msg = None):
+def error_opt(msg: str | None = None) -> NoReturn:
     if msg is not None:
         error_write("Error: " + msg + "\n")
 
@@ -58,7 +59,7 @@ def error_opt(msg = None):
     else:
         sys.exit(1)
 
-def main(args):
+def main(args: list[str]) -> None:
     global _SCRIPT
     _SCRIPT = args[0]
 
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 0316f3f852..f2692de477 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -17,13 +17,15 @@
 import os
 import re
 import sys
+from io import TextIOWrapper
 from pathlib import PurePath
+from typing import Any, Iterator
 
 import tracetool.backend
 import tracetool.format
 
 
-def error_write(*lines):
+def error_write(*lines) -> None:
     """Write a set of error lines."""
     sys.stderr.writelines("\n".join(lines) + "\n")
 
@@ -48,7 +50,7 @@ def error(*lines):
     'MAX': 'j',
 }
 
-def expand_format_string(c_fmt, prefix=""):
+def expand_format_string(c_fmt: str, prefix: str="") -> str:
     def pri_macro_to_fmt(pri_macro):
         assert pri_macro.startswith("PRI")
         fmt_type = pri_macro[3]  # 'd', 'i', 'u', or 'x'
@@ -80,12 +82,12 @@ def pri_macro_to_fmt(pri_macro):
 out_filename = '<none>'
 out_fobj = sys.stdout
 
-def out_open(filename):
+def out_open(filename: str) -> None:
     global out_filename, out_fobj
     out_filename = posix_relpath(filename)
     out_fobj = open(filename, 'wt')
 
-def out(*lines, **kwargs):
+def out(*lines, **kwargs) -> None:
     """Write a set of output lines.
 
     You can use kwargs as a shorthand for mapping variables when formatting all
@@ -177,7 +179,7 @@ def out(*lines, **kwargs):
     "bool",
 }
 
-def validate_type(name):
+def validate_type(name: str) -> None:
     bits = name.split(" ")
     for bit in bits:
         bit = re.sub(r"\*", "", bit)
@@ -192,7 +194,7 @@ def validate_type(name):
                              "other complex pointer types should be "
                              "declared as 'void *'" % name)
 
-def c_type_to_rust(name):
+def c_type_to_rust(name: str) -> str:
     ptr = False
     const = False
     name = name.rstrip()
@@ -227,7 +229,7 @@ def c_type_to_rust(name):
 class Arguments:
     """Event arguments description."""
 
-    def __init__(self, args):
+    def __init__(self, args: list[tuple[str, str]]) -> None:
         """
         Parameters
         ----------
@@ -242,7 +244,7 @@ def __init__(self, args):
                 self._args.append(arg)
 
     @staticmethod
-    def build(arg_str):
+    def build(arg_str: str) -> Arguments:
         """Build and Arguments instance from an argument string.
 
         Parameters
@@ -275,15 +277,15 @@ def __getitem__(self, index):
         else:
             return self._args[index]
 
-    def __iter__(self):
+    def __iter__(self) -> Iterator[tuple[str, str]]:
         """Iterate over the (type, name) pairs."""
         return iter(self._args)
 
-    def __len__(self):
+    def __len__(self) -> int:
         """Number of arguments."""
         return len(self._args)
 
-    def __str__(self):
+    def __str__(self) -> str:
         """String suitable for declaring function arguments."""
         def onearg(t, n):
             if t[-1] == '*':
@@ -300,11 +302,11 @@ def __repr__(self):
         """Evaluable string representation for this object."""
         return "Arguments(\"%s\")" % str(self)
 
-    def names(self):
+    def names(self) -> list[str]:
         """List of argument names."""
         return [ name for _, name in self._args ]
 
-    def types(self):
+    def types(self) -> list[str]:
         """List of argument types."""
         return [ type_ for type_, _ in self._args ]
 
@@ -312,12 +314,12 @@ def casted(self):
         """List of argument names casted to their type."""
         return ["(%s)%s" % (type_, name) for type_, name in self._args]
 
-    def rust_decl_extern(self):
+    def rust_decl_extern(self) -> str:
         """Return a Rust argument list for an extern "C" function"""
         return ", ".join((f"_{name}: {c_type_to_rust(type_)}"
                           for type_, name in self._args))
 
-    def rust_decl(self):
+    def rust_decl(self) -> str:
         """Return a Rust argument list for a tracepoint function"""
         def decl_type(type_):
             if type_ == "const char *":
@@ -327,7 +329,7 @@ def decl_type(type_):
         return ", ".join((f"_{name}: {decl_type(type_)}"
                           for type_, name in self._args))
 
-    def rust_call_extern(self):
+    def rust_call_extern(self) -> str:
         """Return a Rust argument list for a call to an extern "C" function"""
         def rust_cast(name, type_):
             if type_ == "const char *":
@@ -336,7 +338,7 @@ def rust_cast(name, type_):
 
         return ", ".join((rust_cast(name, type_) for type_, name in self._args))
 
-    def rust_call_varargs(self):
+    def rust_call_varargs(self) -> str:
         """Return a Rust argument list for a call to a C varargs function"""
         def rust_cast(name, type_):
             if type_ == "const char *":
@@ -379,7 +381,7 @@ class Event(object):
 
     _VALID_PROPS = set(["disable"])
 
-    def __init__(self, name, props, fmt, args, lineno, filename):
+    def __init__(self, name: str, props: list[str], fmt: str, args: Arguments, lineno: int, filename: str) -> None:
         """
         Parameters
         ----------
@@ -415,7 +417,7 @@ def __init__(self, name, props, fmt, args, lineno, filename):
 
 
     @staticmethod
-    def build(line_str, lineno, filename):
+    def build(line_str: str, lineno: int, filename: str) -> Event:
         """Build an Event instance from a string.
 
         Parameters
@@ -457,7 +459,7 @@ def __repr__(self):
     # arguments with that format, hence the non-greedy version of it.
     _FMT = re.compile(r"(%[\d\.]*\w+|%.*?PRI\S+)")
 
-    def formats(self):
+    def formats(self) -> list[str]:
         """List conversion specifiers in the argument print format string."""
         return self._FMT.findall(self.fmt)
 
@@ -468,13 +470,13 @@ def formats(self):
     QEMU_BACKEND_DSTATE      = "TRACE_%(NAME)s_BACKEND_DSTATE"
     QEMU_EVENT               = "_TRACE_%(NAME)s_EVENT"
 
-    def api(self, fmt=None):
+    def api(self, fmt: str|None=None) -> str:
         if fmt is None:
             fmt = Event.QEMU_TRACE
         return fmt % {"name": self.name, "NAME": self.name.upper()}
 
 
-def read_events(fobj, fname):
+def read_events(fobj: TextIOWrapper, fname: str) -> list[Event]:
     """Generate the output for the given (format, backends) pair.
 
     Parameters
@@ -513,7 +515,7 @@ class TracetoolError (Exception):
     pass
 
 
-def try_import(mod_name, attr_name=None, attr_default=None):
+def try_import(mod_name: str, attr_name: str | None=None, attr_default: Any=None) -> tuple[bool, Any]:
     """Try to import a module and get an attribute from it.
 
     Parameters
@@ -539,8 +541,8 @@ def try_import(mod_name, attr_name=None, attr_default=None):
         return False, None
 
 
-def generate(events, group, format, backends,
-             binary=None, probe_prefix=None):
+def generate(events: list[Event], group: str, format: str, backends: list[str],
+             binary: str|None=None, probe_prefix: str|None=None) -> None:
     """Generate the output for the given (format, backends) pair.
 
     Parameters
@@ -580,7 +582,7 @@ def generate(events, group, format, backends,
 
     tracetool.format.generate(events, format, backend, group)
 
-def posix_relpath(path, start=None):
+def posix_relpath(path: str, start: str|None=None) -> str:
     try:
         path = os.path.relpath(path, start)
     except ValueError:
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 8cc9c82138..645e78ece0 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -60,11 +60,12 @@
 
 
 import os
+from typing import Any, Iterator
 
 import tracetool
 
 
-def get_list(only_public = False):
+def get_list(only_public: bool = False) -> list[tuple[str, str]]:
     """Get a list of (name, description) pairs."""
     res = [("nop", "Tracing disabled.")]
     modnames = []
@@ -93,7 +94,7 @@ def get_list(only_public = False):
     return res
 
 
-def exists(name):
+def exists(name: str) -> bool:
     """Return whether the given backend exists."""
     if len(name) == 0:
         return False
@@ -104,7 +105,7 @@ def exists(name):
 
 
 class Wrapper:
-    def __init__(self, backends, format):
+    def __init__(self, backends: list[str], format: str) -> None:
         self._backends = [backend.replace("-", "_") for backend in backends]
         self._format = format.replace("-", "_")
         self.check_trace_event_get_state = False
@@ -115,13 +116,13 @@ def __init__(self, backends, format):
             check_trace_event_get_state = getattr(backend, "CHECK_TRACE_EVENT_GET_STATE", False)
             self.check_trace_event_get_state = self.check_trace_event_get_state or check_trace_event_get_state
 
-    def backend_modules(self):
+    def backend_modules(self) -> Iterator[Any]:
         for backend in self._backends:
              module = tracetool.try_import("tracetool.backend." + backend)[1]
              if module is not None:
                  yield module
 
-    def _run_function(self, name, *args, check_trace_event_get_state=None, **kwargs):
+    def _run_function(self, name: str, *args, check_trace_event_get_state: bool | None=None, **kwargs) -> None:
         for backend in self.backend_modules():
             func = getattr(backend, name % self._format, None)
             if func is not None and \
@@ -129,14 +130,14 @@ def _run_function(self, name, *args, check_trace_event_get_state=None, **kwargs)
                  check_trace_event_get_state == getattr(backend, 'CHECK_TRACE_EVENT_GET_STATE', False)):
                     func(*args, **kwargs)
 
-    def generate_begin(self, events, group):
+    def generate_begin(self, events: list[tracetool.Event], group: str) -> None:
         self._run_function("generate_%s_begin", events, group)
 
-    def generate(self, event, group, check_trace_event_get_state=None):
+    def generate(self, event: tracetool.Event, group: str, check_trace_event_get_state: bool | None=None) -> None:
         self._run_function("generate_%s", event, group, check_trace_event_get_state=check_trace_event_get_state)
 
-    def generate_backend_dstate(self, event, group):
+    def generate_backend_dstate(self, event: tracetool.Event, group: str) -> None:
         self._run_function("generate_%s_backend_dstate", event, group)
 
-    def generate_end(self, events, group):
+    def generate_end(self, events: list[tracetool.Event], group: str) -> None:
         self._run_function("generate_%s_end", events, group)
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index c21a04c653..2ad607c551 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -14,28 +14,28 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
 
 PUBLIC = True
 
 
-PROBEPREFIX = None
+PROBEPREFIX: str|None = None
 
-def probeprefix():
+def probeprefix() -> str:
     if PROBEPREFIX is None:
         raise ValueError("you must set PROBEPREFIX")
     return PROBEPREFIX
 
 
-BINARY = None
+BINARY: str|None = None
 
-def binary():
+def binary() -> str:
     if BINARY is None:
         raise ValueError("you must set BINARY")
     return BINARY
 
 
-def generate_h_begin(events, group):
+def generate_h_begin(events: list[Event], group: str) -> None:
     if group == "root":
         header = "trace-dtrace-root.h"
     else:
@@ -62,13 +62,13 @@ def generate_h_begin(events, group):
             '#endif',
             uppername=e.name.upper())
 
-def generate_h(event, group):
+def generate_h(event: Event, group: str) -> None:
     out('    QEMU_%(uppername)s(%(argnames)s);',
         uppername=event.name.upper(),
         argnames=", ".join(event.args.names()))
 
 
-def generate_h_backend_dstate(event, group):
+def generate_h_backend_dstate(event: Event, group: str) -> None:
     out('    QEMU_%(uppername)s_ENABLED() || \\',
         uppername=event.name.upper())
 
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 40bb323f5e..fa4a40d44a 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -14,18 +14,18 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import expand_format_string, out
+from tracetool import Event, expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
 
 
-def generate_h_begin(events, group):
+def generate_h_begin(events: list[Event], group: str) -> None:
     out('#include "trace/ftrace.h"',
         '')
 
 
-def generate_h(event, group):
+def generate_h(event: Event, group: str) -> None:
     argnames = ", ".join(event.args.names())
     if len(event.args) > 0:
         argnames = ", " + argnames
@@ -41,11 +41,11 @@ def generate_h(event, group):
         argnames=argnames)
 
 
-def generate_h_backend_dstate(event, group):
+def generate_h_backend_dstate(event: Event, group: str) -> None:
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
 
-def generate_rs(event, group):
+def generate_rs(event: Event, group: str) -> None:
     out('        let format_string = c"%(fmt)s";',
         '        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, %(args)s);}',
         fmt=expand_format_string(event.fmt),
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index d346a19e40..39d777218b 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -14,18 +14,18 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import expand_format_string, out
+from tracetool import Event, expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
 
 
-def generate_h_begin(events, group):
+def generate_h_begin(events: list[Event], group: str) -> None:
     out('#include "qemu/log-for-trace.h"',
         '')
 
 
-def generate_h(event, group):
+def generate_h(event: Event, group: str) -> None:
     argnames = ", ".join(event.args.names())
     if len(event.args) > 0:
         argnames = ", " + argnames
@@ -42,11 +42,11 @@ def generate_h(event, group):
         argnames=argnames)
 
 
-def generate_h_backend_dstate(event, group):
+def generate_h_backend_dstate(event: Event, group: str) -> None:
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
 
-def generate_rs(event, group):
+def generate_rs(event: Event, group: str) -> None:
     out('        let format_string = c"%(fmt)s\\n";',
         '        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {',
         '            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, %(args)s);}',
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 9c691dc231..519f7a09e5 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -14,13 +14,13 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
 
 
-def is_string(arg):
+def is_string(arg: str) -> bool:
     strtype = ('const char*', 'char*', 'const char *', 'char *')
     arg_strip = arg.lstrip()
     if arg_strip.startswith(strtype) and arg_strip.count('*') == 1:
@@ -29,7 +29,7 @@ def is_string(arg):
         return False
 
 
-def generate_h_begin(events, group):
+def generate_h_begin(events: list[Event], group: str) -> None:
     for event in events:
         out('void _simple_%(api)s(%(args)s);',
             api=event.api(),
@@ -37,25 +37,25 @@ def generate_h_begin(events, group):
     out('')
 
 
-def generate_h(event, group):
+def generate_h(event: Event, group: str) -> None:
     out('        _simple_%(api)s(%(args)s);',
         api=event.api(),
         args=", ".join(event.args.names()))
 
 
-def generate_h_backend_dstate(event, group):
+def generate_h_backend_dstate(event: Event, group: str) -> None:
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
 
 
-def generate_c_begin(events, group):
+def generate_c_begin(events: list[Event], group: str) -> None:
     out('#include "qemu/osdep.h"',
         '#include "trace/control.h"',
         '#include "trace/simple.h"',
         '')
 
 
-def generate_c(event, group):
+def generate_c(event: Event, group: str) -> None:
     out('void _simple_%(api)s(%(args)s)',
         '{',
         '    TraceBufferRecord rec;',
@@ -100,7 +100,7 @@ def generate_c(event, group):
         '}',
         '')
 
-def generate_rs(event, group):
+def generate_rs(event: Event, group: str) -> None:
     out('        extern "C" { fn _simple_%(api)s(%(rust_args)s); }',
         '        unsafe { _simple_%(api)s(%(args)s); }',
         api=event.api(),
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 9311453c5a..dd39df6af6 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -14,18 +14,18 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import expand_format_string, out
+from tracetool import Event, expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
 
 
-def generate_h_begin(events, group):
+def generate_h_begin(events: list[Event], group: str) -> None:
     out('#include <syslog.h>',
         '')
 
 
-def generate_h(event, group):
+def generate_h(event: Event, group: str) -> None:
     argnames = ", ".join(event.args.names())
     if len(event.args) > 0:
         argnames = ", " + argnames
@@ -39,12 +39,12 @@ def generate_h(event, group):
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
 
-def generate_rs(event, group):
+def generate_rs(event: Event, group: str) -> None:
     out('        let format_string = c"%(fmt)s";',
         '        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, %(args)s);}',
         fmt=expand_format_string(event.fmt),
         args=event.args.rust_call_varargs())
 
-def generate_h_backend_dstate(event, group):
+def generate_h_backend_dstate(event: Event, group: str) -> None:
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index f227072512..a26cd7ace6 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -14,12 +14,12 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
 
 PUBLIC = True
 
 
-def generate_h_begin(events, group):
+def generate_h_begin(events: list[Event], group: str) -> None:
     header = 'trace-ust-' + group + '.h'
     out('#include <lttng/tracepoint.h>',
         '#include "%s"' % header,
@@ -31,7 +31,7 @@ def generate_h_begin(events, group):
         '')
 
 
-def generate_h(event, group):
+def generate_h(event: Event, group: str) -> None:
     argnames = ", ".join(event.args.names())
     if len(event.args) > 0:
         argnames = ", " + argnames
@@ -41,6 +41,6 @@ def generate_h(event, group):
         tp_args=argnames)
 
 
-def generate_h_backend_dstate(event, group):
+def generate_h_backend_dstate(event: Event, group: str) -> None:
     out('    tracepoint_enabled(qemu, %(name)s) || \\',
         name=event.name)
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 4c606d5757..c287e93ed3 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -40,9 +40,10 @@
 import os
 
 import tracetool
+from tracetool.backend import Wrapper
 
 
-def get_list():
+def get_list() -> list[tuple[str, str]]:
     """Get a list of (name, description) pairs."""
     res = []
     modnames = []
@@ -67,7 +68,7 @@ def get_list():
     return res
 
 
-def exists(name):
+def exists(name: str) -> bool:
     """Return whether the given format exists."""
     if len(name) == 0:
         return False
@@ -75,7 +76,7 @@ def exists(name):
     return tracetool.try_import("tracetool.format." + name)[0]
 
 
-def generate(events, format, backend, group):
+def generate(events: list[tracetool.Event], format: str, backend: Wrapper, group: str) -> None:
     if not exists(format):
         raise ValueError("unknown format: %s" % format)
     format = format.replace("-", "_")
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 5b3459f2be..e8848c5105 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -14,10 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     active_events = [e for e in events
                      if "disable" not in e.properties]
 
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index dda80eeb76..2abf8bc24b 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -16,7 +16,8 @@
 
 from sys import platform
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 
 # Reserved keywords from
 # https://wikis.oracle.com/display/DTrace/Types,+Operators+and+Expressions
@@ -31,7 +32,7 @@
 )
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     events = [e for e in events
               if "disable" not in e.properties]
 
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index d04cabc63e..2324234dd2 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -14,10 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     header = "trace/control.h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 6551444203..d7ad0bb6a7 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -15,7 +15,8 @@
 
 import re
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 from tracetool.backend.dtrace import binary, probeprefix
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
@@ -30,7 +31,7 @@ def c_macro_to_format(macro):
 
     raise Exception("Unhandled macro '%s'" % macro)
 
-def c_fmt_to_stap(fmt):
+def c_fmt_to_stap(fmt: str) -> str:
     state = 0
     bits = []
     literal = ""
@@ -85,7 +86,7 @@ def c_fmt_to_stap(fmt):
     fmt = re.sub(r"%(\d*)(l+|z)(x|u|d)", r"%\1\3", "".join(bits))
     return fmt
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
index 1dc43a3b34..41e4636d97 100644
--- a/scripts/tracetool/format/rs.py
+++ b/scripts/tracetool/format/rs.py
@@ -14,10 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     out('// SPDX-License-Identifier: GPL-2.0-or-later',
         '// This file is @generated by tracetool, do not edit.',
         '',
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index eb58b4b959..c76cf42685 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -14,13 +14,14 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 from tracetool.backend.dtrace import probeprefix
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 808fb478b5..af98f3c44a 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -14,7 +14,8 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 from tracetool.backend.dtrace import binary, probeprefix
 
 # Technically 'self' is not used by systemtap yet, but
@@ -27,14 +28,14 @@
     )
 
 
-def stap_escape(identifier):
+def stap_escape(identifier: str) -> str:
     # Append underscore to reserved keywords
     if identifier in RESERVED_WORDS:
         return identifier + '_'
     return identifier
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     events = [e for e in events
               if "disable" not in e.properties]
 
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index fa7d543798..2c8256ed7a 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -14,10 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     events = [e for e in events
               if "disabled" not in e.properties]
 
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 1057d02577..f0ffcae694 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -14,10 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import Event, out
+from tracetool.backend import Wrapper
 
 
-def generate(events, backend, group):
+def generate(events: list[Event], backend: Wrapper, group: str) -> None:
     events = [e for e in events
               if "disabled" not in e.properties]
 
-- 
2.52.0


