Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7E3D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUVu-0006Kx-NE; Thu, 29 Jan 2026 11:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlUVs-0006J3-IQ
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:04:56 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlUVo-00055A-1V
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:04:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 56B814423F;
 Thu, 29 Jan 2026 16:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8181BC19422;
 Thu, 29 Jan 2026 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769702690;
 bh=+ZQIZgE5598Gk3449gBfwYAGRpDT4vo7wCP23OX4MAE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YDO89oAznJl8IAJDySggfXCEI245V/KJR6NLHWywMHEMtwzdDBYjzbqa42X2KfY9+
 PLxsdp/kE2yiCgbMCSjGnImKLyWXMDMo2VgE/pHkt2HufMOQ+YaFvcEPaj0LXNCRpE
 C5m50aXSMzmbRXHWZmHw/xniRpO5eXVV2c9jkYhVuQPFAFmtLPTZB5Sdpi4ZHiHmrk
 d4QyT7XnZ/HCpJ/BlLXXJ19/m/QugCbeSvXKYs8MfxJ+n560EdmS8lOFNlNKQk1u1a
 8yZBPMv9XTLkBJkMht5jasa5ete1msuun4UkcnYJyuMKKvsuvZfXzA6wMO9w9ugakz
 xJ3lsmE7ghZaA==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlUVj-0000000FNz9-2fJs; Thu, 29 Jan 2026 17:04:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/1] scripts: Import Python kerneldoc from Linux kernel
Date: Thu, 29 Jan 2026 17:04:06 +0100
Message-ID: <c3d61656687b0ea179267cc120bd82a84bad8ffe.1769701431.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769701431.git.mchehab+huawei@kernel.org>
References: <cover.1769701431.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sync QEMU kernel-doc with the latest upsteam version from
linux-next, plus a set of 31 patches from myself addressing
some issues with macro expansions and with changes specifically
made to make easier to keep QEMU version in sync:

- there is now a separate module containing all macro
  expansions, at xforms_lists.py;
- such transforms can now be passed as a parameter when
  calling KernelFiles().

Such changes allow QEMU to easily override this class.

While here, also override the ReST output format class.

With that, all QEMU-specific changes are located on a single
file (scripts/kernel-doc.py).

On this patch, a note was added to scripts/kernel-doc.py
to sum-up the differences between QEMU and Linux Kernel.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py                  | 177 +++++++--
 scripts/lib/kdoc/__init__.py           |   0
 scripts/lib/kdoc/enrich_formatter.py   |  80 ++++
 scripts/lib/kdoc/kdoc_files.py         |  37 +-
 scripts/lib/kdoc/kdoc_item.py          |  18 +
 scripts/lib/kdoc/kdoc_output.py        | 120 ++++--
 scripts/lib/kdoc/kdoc_parser.py        | 432 +++++++++++----------
 scripts/lib/kdoc/kdoc_re.py            | 231 +++++++++---
 scripts/lib/kdoc/latex_fonts.py        | 184 +++++++++
 scripts/lib/kdoc/parse_data_structs.py | 498 +++++++++++++++++++++++++
 scripts/lib/kdoc/python_version.py     | 190 ++++++++++
 scripts/lib/kdoc/xforms_lists.py       | 105 ++++++
 12 files changed, 1711 insertions(+), 361 deletions(-)
 create mode 100644 scripts/lib/kdoc/__init__.py
 create mode 100644 scripts/lib/kdoc/enrich_formatter.py
 create mode 100755 scripts/lib/kdoc/latex_fonts.py
 create mode 100755 scripts/lib/kdoc/parse_data_structs.py
 create mode 100644 scripts/lib/kdoc/python_version.py
 create mode 100644 scripts/lib/kdoc/xforms_lists.py

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index fc3d46ef519f..54bb3c38e54b 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -1,8 +1,29 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
-# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# Copyright(c) 2025-2026: Mauro Carvalho Chehab <mchehab@kernel.org>.
 #
-# pylint: disable=C0103,R0915
+# pylint: disable=C0103,R0912,R0914,R0915
+
+###############################################################################
+# NOTE:
+###############################################################################
+#       DON'T BLINDLY COPY THE LINUX KERNEL VERSION OF THIS FILE.
+#
+#       This version contains QEMU-specific fork from Linux Kernel kernel-doc.
+#
+#       Differences against Linux Kernel upstream:
+#       - dropped python3 version checks;
+#       - the location of kernel-doc modules is different at QEMU tree;
+#       - the CTransforms class is overriden to add QEMU macros;
+#       - the RestFormat class is overriden to use some different regexes
+#         to match the way enum, struct, typedef, and union works on QEMU
+#
+#       With such changes, syncing kernel-doc with a new kernel version
+#       should be as simple as:
+#
+#           cp <linux_dir>/docs/tools/lib/python/kdoc/*.py scripts/lib/kdoc/
+###############################################################################
+
 #
 # Converted from the kernel-doc script originally written in Perl
 # under GPLv2, copyrighted since 1998 by the following authors:
@@ -79,19 +100,16 @@
 #    Yujie Liu <yujie.liu@intel.com>
 
 """
-kernel_doc
-==========
-
-Print formatted kernel documentation to stdout
+Print formatted kernel documentation to stdout.
 
 Read C language source or header FILEs, extract embedded
 documentation comments, and print formatted documentation
 to standard output.
 
-The documentation comments are identified by the "/**"
+The documentation comments are identified by the ``/**``
 opening comment mark.
 
-See Documentation/doc-guide/kernel-doc.rst for the
+See Linux Kernel Documentation/doc-guide/kernel-doc.rst for the
 documentation comment syntax.
 """
 
@@ -102,13 +120,72 @@
 
 # Import Python modules
 
-LIB_DIR = "lib/kdoc"
+# QEMU: the location of the library directory is different for QEMU
+LIB_DIR = "lib"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-from kdoc_files import KernelFiles                      # pylint: disable=C0413
-from kdoc_output import RestFormat, ManFormat           # pylint: disable=C0413
+from kdoc.kdoc_files import KernelFiles             # pylint: disable=C0415
+from kdoc.kdoc_re   import KernRe                   # pylint: disable=C0415
+from kdoc.kdoc_output import RestFormat, ManFormat  # pylint: disable=C0415
+
+# QEMU: add QEMU-specific xforms
+from kdoc.xforms_lists import CTransforms  # pylint: disable=C0415
+
+class QemuCTransforms(CTransforms):
+    def __init__(self):
+        self.function_xforms += [
+            # Add a handler for QEMU macros
+            (KernRe(r"QEMU_[A-Z_]+ +"), ""),
+        ]
+
+# QEMU prepend cross-references on a different way than the Linux Kernel
+# So, let's redefine the RestFormat highlights
+
+# Those are currently identical to what Linux Kernel does:
+type_constant = KernRe(r"\b``([^\`]+)``\b", cache=False)
+type_constant2 = KernRe(r"\%([-_*\w]+)", cache=False)
+type_func = KernRe(r"(\w+)\(\)", cache=False)
+type_param_ref = KernRe(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+type_fp_param = KernRe(r"\@(\w+)\(\)", cache=False)
+type_fp_param2 = KernRe(r"\@(\w+->\S+)\(\)", cache=False)
+
+# Those are QEMU-specific ones
+type_enum = KernRe(r"#(enum\s*([_\w]+))", cache=False)
+type_struct = KernRe(r"#(struct\s*([_\w]+))", cache=False)
+type_typedef = KernRe(r"#(typedef\s*([_\w]+))", cache=False)
+type_union = KernRe(r"#(union\s*([_\w]+))", cache=False)
+type_member = KernRe(r"#([_\w]+)(\.|->)([_\w]+)", cache=False)
+type_fallback = KernRe(r"#([_\w]+)", cache=False)
+type_member_func = type_member + KernRe(r"\(\)", cache=False)
+
+# QEMU: override ReST highlights
+class QemuRestFormat(RestFormat):
+    # The content here is identical to RestFormat, but it uses the local
+    # static vars above instead of the Kernel ones
+    highlights = [
+        (type_constant, r"``\1``"),
+        (type_constant2, r"``\1``"),
+
+        # Note: need to escape () to avoid func matching later
+        (type_member_func, r":c:type:`\1\2\3\\(\\) <\1>`"),
+        (type_member, r":c:type:`\1\2\3 <\1>`"),
+        (type_fp_param, r"**\1\\(\\)**"),
+        (type_fp_param2, r"**\1\\(\\)**"),
+        (type_func, r"\1()"),
+        (type_enum, r":c:type:`\1 <\2>`"),
+        (type_struct, r":c:type:`\1 <\2>`"),
+        (type_typedef, r":c:type:`\1 <\2>`"),
+        (type_union, r":c:type:`\1 <\2>`"),
+
+        # in rst this can refer to any type
+        (type_fallback, r":c:type:`\1`"),
+        (type_param_ref, r"**\1\2**")
+    ]
+
+
+WERROR_RETURN_CODE = 3
 
 DESC = """
 Read C language source or header FILEs, extract embedded documentation comments,
@@ -126,13 +203,13 @@
 """
 
 EXPORT_DESC = """
-Only output documentation for the symbols that have been
+Only output documentation for symbols that have been
 exported using EXPORT_SYMBOL() and related macros in any input
 FILE or -export-file FILE.
 """
 
 INTERNAL_DESC = """
-Only output documentation for the symbols that have NOT been
+Only output documentation for symbols that have NOT been
 exported using EXPORT_SYMBOL() and related macros in any input
 FILE or -export-file FILE.
 """
@@ -155,28 +232,49 @@
 """
 
 WARN_CONTENTS_BEFORE_SECTIONS_DESC = """
-Warns if there are contents before sections (deprecated).
+Warn if there are contents before sections (deprecated).
 
 This option is kept just for backward-compatibility, but it does nothing,
 neither here nor at the original Perl script.
 """
 
+EPILOG = """
+The return value is:
+
+- 0: success or Python version is not compatible with
+kernel-doc.  If -Werror is not used, it will also
+return 0 if there are issues at kernel-doc markups;
+
+- 1: an abnormal condition happened;
+
+- 2: argparse issued an error;
+
+- 3: When -Werror is used, it means that one or more unfiltered parse
+     warnings happened.
+"""
 
 class MsgFormatter(logging.Formatter):
-    """Helper class to format warnings on a similar way to kernel-doc.pl"""
+    """
+    Helper class to capitalize errors and warnings, the same way
+    the venerable (now retired) kernel-doc.pl used to do.
+    """
 
     def format(self, record):
         record.levelname = record.levelname.capitalize()
         return logging.Formatter.format(self, record)
 
 def main():
-    """Main program"""
+    """
+    Main program.
+
+    """
 
     parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
-                                     description=DESC)
+                                     description=DESC, epilog=EPILOG)
 
+    #
     # Normal arguments
-
+    #
     parser.add_argument("-v", "-verbose", "--verbose", action="store_true",
                         help="Verbose output, more warnings and other information.")
 
@@ -191,8 +289,9 @@ def main():
                         action="store_true",
                         help="Enable line number output (only in ReST mode)")
 
+    #
     # Arguments to control the warning behavior
-
+    #
     parser.add_argument("-Wreturn", "--wreturn", action="store_true",
                         help="Warns about the lack of a return markup on functions.")
 
@@ -213,8 +312,9 @@ def main():
     parser.add_argument("-export-file", "--export-file", action='append',
                         help=EXPORT_FILE_DESC)
 
+    #
     # Output format mutually-exclusive group
-
+    #
     out_group = parser.add_argument_group("Output format selection (mutually exclusive)")
 
     out_fmt = out_group.add_mutually_exclusive_group()
@@ -226,8 +326,9 @@ def main():
     out_fmt.add_argument("-N", "-none", "--none", action="store_true",
                          help="Do not output documentation, only warnings.")
 
+    #
     # Output selection mutually-exclusive group
-
+    #
     sel_group = parser.add_argument_group("Output selection (mutually exclusive)")
     sel_mut = sel_group.add_mutually_exclusive_group()
 
@@ -240,12 +341,14 @@ def main():
     sel_mut.add_argument("-s", "-function", "--symbol", action='append',
                          help=FUNCTION_DESC)
 
+    #
     # Those are valid for all 3 types of filter
+    #
     parser.add_argument("-n", "-nosymbol", "--nosymbol", action='append',
                         help=NOSYMBOL_DESC)
 
     parser.add_argument("-D", "-no-doc-sections", "--no-doc-sections",
-                        action='store_true', help="Don't outputt DOC sections")
+                        action='store_true', help="Don't output DOC sections")
 
     parser.add_argument("files", metavar="FILE",
                         nargs="+", help=FILES_DESC)
@@ -271,24 +374,18 @@ def main():
 
     logger.addHandler(handler)
 
-    python_ver = sys.version_info[:2]
-    if python_ver < (3,6):
-        logger.warning("Python 3.6 or later is required by kernel-doc")
-
-        # Return 0 here to avoid breaking compilation
-        sys.exit(0)
-
-    if python_ver < (3,7):
-        logger.warning("Python 3.7 or later is required for correct results")
+    #
+    # Import kernel-doc libraries only after checking the Python version
+    #
 
     if args.man:
         out_style = ManFormat(modulename=args.modulename)
     elif args.none:
         out_style = None
     else:
-        out_style = RestFormat()
+        out_style = QemuRestFormat()
 
-    kfiles = KernelFiles(verbose=args.verbose,
+    kfiles = KernelFiles(verbose=args.verbose, xforms=QemuCTransforms(),
                          out_style=out_style, werror=args.werror,
                          wreturn=args.wreturn, wshort_desc=args.wshort_desc,
                          wcontents_before_sections=args.wcontents_before_sections)
@@ -308,18 +405,16 @@ def main():
         sys.exit(0)
 
     if args.werror:
-        print(f"{error_count} warnings as errors")
-        sys.exit(error_count)
+        print("%s warnings as errors" % error_count)    # pylint: disable=C0209
+        sys.exit(WERROR_RETURN_CODE)
 
     if args.verbose:
-        print(f"{error_count} errors")
-
-    if args.none:
-        sys.exit(0)
-
-    sys.exit(error_count)
+        print("%s errors" % error_count)                # pylint: disable=C0209
 
+    sys.exit(0)
 
+#
 # Call main method
+#
 if __name__ == "__main__":
     main()
diff --git a/scripts/lib/kdoc/__init__.py b/scripts/lib/kdoc/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/scripts/lib/kdoc/enrich_formatter.py b/scripts/lib/kdoc/enrich_formatter.py
new file mode 100644
index 000000000000..d1be4e5e1962
--- /dev/null
+++ b/scripts/lib/kdoc/enrich_formatter.py
@@ -0,0 +1,80 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 by Mauro Carvalho Chehab <mchehab@kernel.org>.
+
+"""
+Ancillary argparse HelpFormatter class that works on a similar way as
+argparse.RawDescriptionHelpFormatter, e.g. description maintains line
+breaks, but it also implement transformations to the help text. The
+actual transformations ar given by enrich_text(), if the output is tty.
+
+Currently, the follow transformations are done:
+
+    - Positional arguments are shown in upper cases;
+    - if output is TTY, ``var`` and positional arguments are shown prepended
+      by an ANSI SGR code. This is usually translated to bold. On some
+      terminals, like, konsole, this is translated into a colored bold text.
+"""
+
+import argparse
+import re
+import sys
+
+class EnrichFormatter(argparse.HelpFormatter):
+    """
+    Better format the output, making easier to identify the positional args
+    and how they're used at the __doc__ description.
+    """
+    def __init__(self, *args, **kwargs):
+        """
+        Initialize class and check if is TTY.
+        """
+        super().__init__(*args, **kwargs)
+        self._tty = sys.stdout.isatty()
+
+    def enrich_text(self, text):
+        r"""
+        Handle ReST markups (currently, only \`\`text\`\` markups).
+        """
+        if self._tty and text:
+            # Replace ``text`` with ANSI SGR (bold)
+            return re.sub(r'\`\`(.+?)\`\`',
+                          lambda m: f'\033[1m{m.group(1)}\033[0m', text)
+        return text
+
+    def _fill_text(self, text, width, indent):
+        """
+        Enrich descriptions with markups on it.
+        """
+        enriched = self.enrich_text(text)
+        return "\n".join(indent + line for line in enriched.splitlines())
+
+    def _format_usage(self, usage, actions, groups, prefix):
+        """
+        Enrich positional arguments at usage: line.
+        """
+
+        prog = self._prog
+        parts = []
+
+        for action in actions:
+            if action.option_strings:
+                opt = action.option_strings[0]
+                if action.nargs != 0:
+                    opt += f" {action.dest.upper()}"
+                parts.append(f"[{opt}]")
+            else:
+                # Positional argument
+                parts.append(self.enrich_text(f"``{action.dest.upper()}``"))
+
+        usage_text = f"{prefix or 'usage: '} {prog} {' '.join(parts)}\n"
+        return usage_text
+
+    def _format_action_invocation(self, action):
+        """
+        Enrich argument names.
+        """
+        if not action.option_strings:
+            return self.enrich_text(f"``{action.dest.upper()}``")
+
+        return ", ".join(action.option_strings)
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 85365cc316d6..c35e033cf123 100644
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -5,7 +5,8 @@
 # pylint: disable=R0903,R0913,R0914,R0917
 
 """
-Parse lernel-doc tags on multiple kernel source files.
+Classes for navigating through the files that kernel-doc needs to handle
+to generate documentation.
 """
 
 import argparse
@@ -13,8 +14,9 @@
 import os
 import re
 
-from kdoc_parser import KernelDoc
-from kdoc_output import OutputFormat
+from kdoc.kdoc_parser import KernelDoc
+from kdoc.xforms_lists import CTransforms
+from kdoc.kdoc_output import OutputFormat
 
 
 class GlobSourceFiles:
@@ -43,7 +45,7 @@ def __init__(self, srctree=None, valid_extensions=None):
         self.srctree = srctree
 
     def _parse_dir(self, dirname):
-        """Internal function to parse files recursively"""
+        """Internal function to parse files recursively."""
 
         with os.scandir(dirname) as obj:
             for entry in obj:
@@ -65,7 +67,7 @@ def _parse_dir(self, dirname):
     def parse_files(self, file_list, file_not_found_cb):
         """
         Define an iterator to parse all source files from file_list,
-        handling directories if any
+        handling directories if any.
         """
 
         if not file_list:
@@ -91,18 +93,18 @@ class KernelFiles():
 
     There are two type of parsers defined here:
         - self.parse_file(): parses both kernel-doc markups and
-          EXPORT_SYMBOL* macros;
-        - self.process_export_file(): parses only EXPORT_SYMBOL* macros.
+          ``EXPORT_SYMBOL*`` macros;
+        - self.process_export_file(): parses only ``EXPORT_SYMBOL*`` macros.
     """
 
     def warning(self, msg):
-        """Ancillary routine to output a warning and increment error count"""
+        """Ancillary routine to output a warning and increment error count."""
 
         self.config.log.warning(msg)
         self.errors += 1
 
     def error(self, msg):
-        """Ancillary routine to output an error and increment error count"""
+        """Ancillary routine to output an error and increment error count."""
 
         self.config.log.error(msg)
         self.errors += 1
@@ -116,7 +118,7 @@ def parse_file(self, fname):
         if fname in self.files:
             return
 
-        doc = KernelDoc(self.config, fname)
+        doc = KernelDoc(self.config, fname, self.xforms)
         export_table, entries = doc.parse_kdoc()
 
         self.export_table[fname] = export_table
@@ -128,7 +130,7 @@ def parse_file(self, fname):
 
     def process_export_file(self, fname):
         """
-        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
+        Parses ``EXPORT_SYMBOL*`` macros from a single Kernel source file.
         """
 
         # Prevent parsing the same file twice if results are cached
@@ -152,12 +154,12 @@ def file_not_found_cb(self, fname):
 
         self.error(f"Cannot find file {fname}")
 
-    def __init__(self, verbose=False, out_style=None,
+    def __init__(self, verbose=False, out_style=None, xforms=None,
                  werror=False, wreturn=False, wshort_desc=False,
                  wcontents_before_sections=False,
                  logger=None):
         """
-        Initialize startup variables and parse all files
+        Initialize startup variables and parse all files.
         """
 
         if not verbose:
@@ -191,6 +193,11 @@ def __init__(self, verbose=False, out_style=None,
         self.config.wshort_desc = wshort_desc
         self.config.wcontents_before_sections = wcontents_before_sections
 
+        if xforms:
+            self.xforms = xforms
+        else:
+            self.xforms = CTransforms()
+
         if not logger:
             self.config.log = logging.getLogger("kernel-doc")
         else:
@@ -213,7 +220,7 @@ def __init__(self, verbose=False, out_style=None,
 
     def parse(self, file_list, export_file=None):
         """
-        Parse all files
+        Parse all files.
         """
 
         glob = GlobSourceFiles(srctree=self.config.src_tree)
@@ -242,7 +249,7 @@ def msg(self, enable_lineno=False, export=False, internal=False,
             filenames=None, export_file=None):
         """
         Interacts over the kernel-doc results and output messages,
-        returning kernel-doc markups on each interaction
+        returning kernel-doc markups on each interaction.
         """
 
         self.out_style.set_config(self.config)
diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
index 19805301cb2c..2b8a93f79716 100644
--- a/scripts/lib/kdoc/kdoc_item.py
+++ b/scripts/lib/kdoc/kdoc_item.py
@@ -4,7 +4,16 @@
 # then pass into the output modules.
 #
 
+"""
+Data class to store a kernel-doc Item.
+"""
+
 class KdocItem:
+    """
+    A class that will, eventually, encapsulate all of the parsed data that we
+    then pass into the output modules.
+    """
+
     def __init__(self, name, fname, type, start_line, **other_stuff):
         self.name = name
         self.fname = fname
@@ -24,6 +33,9 @@ def __init__(self, name, fname, type, start_line, **other_stuff):
         self.other_stuff = other_stuff
 
     def get(self, key, default = None):
+        """
+        Get a value from optional keys.
+        """
         return self.other_stuff.get(key, default)
 
     def __getitem__(self, key):
@@ -33,10 +45,16 @@ def __getitem__(self, key):
     # Tracking of section and parameter information.
     #
     def set_sections(self, sections, start_lines):
+        """
+        Set sections and start lines.
+        """
         self.sections = sections
         self.section_start_lines = start_lines
 
     def set_params(self, names, descs, types, starts):
+        """
+        Set parameter list: names, descriptions, types and start lines.
+        """
         self.parameterlist = names
         self.parameterdescs = descs
         self.parametertypes = types
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 25de79ea6bcd..4210b91dde5f 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -5,22 +5,24 @@
 # pylint: disable=C0301,R0902,R0911,R0912,R0913,R0914,R0915,R0917
 
 """
-Implement output filters to print kernel-doc documentation.
+Classes to implement output filters to print kernel-doc documentation.
 
-The implementation uses a virtual base class (OutputFormat) which
+The implementation uses a virtual base class ``OutputFormat``. It
 contains dispatches to virtual methods, and some code to filter
 out output messages.
 
 The actual implementation is done on one separate class per each type
-of output. Currently, there are output classes for ReST and man/troff.
+of output, e.g. ``RestFormat`` and ``ManFormat`` classes.
+
+Currently, there are output classes for ReST and man/troff.
 """
 
 import os
 import re
 from datetime import datetime
 
-from kdoc_parser import KernelDoc, type_param
-from kdoc_re import KernRe
+from kdoc.kdoc_parser import KernelDoc, type_param
+from kdoc.kdoc_re import KernRe
 
 
 function_pointer = KernRe(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
@@ -38,12 +40,12 @@
 type_fp_param2 = KernRe(r"\@(\w+->\S+)\(\)", cache=False)
 
 type_env = KernRe(r"(\$\w+)", cache=False)
-type_enum = KernRe(r"#(enum\s*([_\w]+))", cache=False)
-type_struct = KernRe(r"#(struct\s*([_\w]+))", cache=False)
-type_typedef = KernRe(r"#(([A-Z][_\w]*))", cache=False)
-type_union = KernRe(r"#(union\s*([_\w]+))", cache=False)
-type_member = KernRe(r"#([_\w]+)(\.|->)([_\w]+)", cache=False)
-type_fallback = KernRe(r"((?!))", cache=False) # this never matches
+type_enum = KernRe(r"\&(enum\s*([_\w]+))", cache=False)
+type_struct = KernRe(r"\&(struct\s*([_\w]+))", cache=False)
+type_typedef = KernRe(r"\&(typedef\s*([_\w]+))", cache=False)
+type_union = KernRe(r"\&(union\s*([_\w]+))", cache=False)
+type_member = KernRe(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
+type_fallback = KernRe(r"\&([_\w]+)", cache=False)
 type_member_func = type_member + KernRe(r"\(\)", cache=False)
 
 
@@ -54,16 +56,19 @@ class OutputFormat:
     """
 
     # output mode.
-    OUTPUT_ALL          = 0 # output all symbols and doc sections
-    OUTPUT_INCLUDE      = 1 # output only specified symbols
-    OUTPUT_EXPORTED     = 2 # output exported symbols
-    OUTPUT_INTERNAL     = 3 # output non-exported symbols
+    OUTPUT_ALL          = 0 #: Output all symbols and doc sections.
+    OUTPUT_INCLUDE      = 1 #: Output only specified symbols.
+    OUTPUT_EXPORTED     = 2 #: Output exported symbols.
+    OUTPUT_INTERNAL     = 3 #: Output non-exported symbols.
 
-    # Virtual member to be overridden at the inherited classes
+    #: Highlights to be used in ReST format.
     highlights = []
 
+    #: Blank line character.
+    blankline = ""
+
     def __init__(self):
-        """Declare internal vars and set mode to OUTPUT_ALL"""
+        """Declare internal vars and set mode to ``OUTPUT_ALL``."""
 
         self.out_mode = self.OUTPUT_ALL
         self.enable_lineno = None
@@ -128,7 +133,7 @@ def out_warnings(self, args):
             self.config.warning(log_msg)
 
     def check_doc(self, name, args):
-        """Check if DOC should be output"""
+        """Check if DOC should be output."""
 
         if self.no_doc_sections:
             return False
@@ -177,7 +182,7 @@ def check_declaration(self, dtype, name, args):
 
     def msg(self, fname, name, args):
         """
-        Handles a single entry from kernel-doc parser
+        Handles a single entry from kernel-doc parser.
         """
 
         self.data = ""
@@ -199,6 +204,10 @@ def msg(self, fname, name, args):
             self.out_enum(fname, name, args)
             return self.data
 
+        if dtype == "var":
+            self.out_var(fname, name, args)
+            return self.data
+
         if dtype == "typedef":
             self.out_typedef(fname, name, args)
             return self.data
@@ -216,27 +225,31 @@ def msg(self, fname, name, args):
     # Virtual methods to be overridden by inherited classes
     # At the base class, those do nothing.
     def set_symbols(self, symbols):
-        """Get a list of all symbols from kernel_doc"""
+        """Get a list of all symbols from kernel_doc."""
 
     def out_doc(self, fname, name, args):
-        """Outputs a DOC block"""
+        """Outputs a DOC block."""
 
     def out_function(self, fname, name, args):
-        """Outputs a function"""
+        """Outputs a function."""
 
     def out_enum(self, fname, name, args):
-        """Outputs an enum"""
+        """Outputs an enum."""
+
+    def out_var(self, fname, name, args):
+        """Outputs a variable."""
 
     def out_typedef(self, fname, name, args):
-        """Outputs a typedef"""
+        """Outputs a typedef."""
 
     def out_struct(self, fname, name, args):
-        """Outputs a struct"""
+        """Outputs a struct."""
 
 
 class RestFormat(OutputFormat):
-    """Consts and functions used by ReST output"""
+    """Consts and functions used by ReST output."""
 
+    #: Highlights to be used in ReST format
     highlights = [
         (type_constant, r"``\1``"),
         (type_constant2, r"``\1``"),
@@ -256,9 +269,13 @@ class RestFormat(OutputFormat):
         (type_fallback, r":c:type:`\1`"),
         (type_param_ref, r"**\1\2**")
     ]
+
     blankline = "\n"
 
+    #: Sphinx literal block regex.
     sphinx_literal = KernRe(r'^[^.].*::$', cache=False)
+
+    #: Sphinx code block regex.
     sphinx_cblock = KernRe(r'^\.\.\ +code-block::', cache=False)
 
     def __init__(self):
@@ -273,7 +290,7 @@ def __init__(self):
         self.lineprefix = ""
 
     def print_lineno(self, ln):
-        """Outputs a line number"""
+        """Outputs a line number."""
 
         if self.enable_lineno and ln is not None:
             ln += 1
@@ -282,7 +299,7 @@ def print_lineno(self, ln):
     def output_highlight(self, args):
         """
         Outputs a C symbol that may require being converted to ReST using
-        the self.highlights variable
+        the self.highlights variable.
         """
 
         input_text = args
@@ -472,6 +489,25 @@ def out_enum(self, fname, name, args):
         self.lineprefix = oldprefix
         self.out_section(args)
 
+    def out_var(self, fname, name, args):
+        oldprefix = self.lineprefix
+        ln = args.declaration_start_line
+        full_proto = args.other_stuff["full_proto"]
+
+        self.lineprefix = "  "
+
+        self.data += f"\n\n.. c:macro:: {name}\n\n{self.lineprefix}``{full_proto}``\n\n"
+
+        self.print_lineno(ln)
+        self.output_highlight(args.get('purpose', ''))
+        self.data += "\n"
+
+        if args.other_stuff["default_val"]:
+            self.data += f'{self.lineprefix}**Initialization**\n\n'
+            self.output_highlight(f'default: ``{args.other_stuff["default_val"]}``')
+
+        self.out_section(args)
+
     def out_typedef(self, fname, name, args):
 
         oldprefix = self.lineprefix
@@ -544,7 +580,7 @@ def out_struct(self, fname, name, args):
 
 
 class ManFormat(OutputFormat):
-    """Consts and functions used by man pages output"""
+    """Consts and functions used by man pages output."""
 
     highlights = (
         (type_constant, r"\1"),
@@ -561,6 +597,7 @@ class ManFormat(OutputFormat):
     )
     blankline = ""
 
+    #: Allowed timestamp formats.
     date_formats = [
         "%a %b %d %H:%M:%S %Z %Y",
         "%a %b %d %H:%M:%S %Y",
@@ -627,7 +664,7 @@ def set_symbols(self, symbols):
         self.symbols = symbols
 
     def out_tail(self, fname, name, args):
-        """Adds a tail for all man pages"""
+        """Adds a tail for all man pages."""
 
         # SEE ALSO section
         self.data += f'.SH "SEE ALSO"' + "\n.PP\n"
@@ -663,7 +700,7 @@ def msg(self, fname, name, args):
     def output_highlight(self, block):
         """
         Outputs a C symbol that may require being highlighted with
-        self.highlights variable using troff syntax
+        self.highlights variable using troff syntax.
         """
 
         contents = self.highlight_block(block)
@@ -694,7 +731,6 @@ def out_doc(self, fname, name, args):
             self.output_highlight(text)
 
     def out_function(self, fname, name, args):
-        """output function in man"""
 
         out_name = self.arg_name(args, name)
 
@@ -773,6 +809,26 @@ def out_enum(self, fname, name, args):
             self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(text)
 
+    def out_var(self, fname, name, args):
+        out_name = self.arg_name(args, name)
+        full_proto = args.other_stuff["full_proto"]
+
+        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+
+        self.data += ".SH NAME\n"
+        self.data += f"{name} \\- {args['purpose']}\n"
+
+        self.data += ".SH SYNOPSIS\n"
+        self.data += f"{full_proto}\n"
+
+        if args.other_stuff["default_val"]:
+            self.data += f'.SH "Initialization"' + "\n"
+            self.output_highlight(f'default: {args.other_stuff["default_val"]}')
+
+        for section, text in args.sections.items():
+            self.data += f'.SH "{section}"' + "\n"
+            self.output_highlight(text)
+
     def out_typedef(self, fname, name, args):
         module = self.modulename
         purpose = args.get('purpose')
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index b2b790d6b837..a280fe581937 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -5,19 +5,16 @@
 # pylint: disable=C0301,C0302,R0904,R0912,R0913,R0914,R0915,R0917,R1702
 
 """
-kdoc_parser
-===========
-
-Read a C language source or header FILE and extract embedded
-documentation comments
+Classes and functions related to reading a C language source or header FILE
+and extract embedded documentation comments from it.
 """
 
 import sys
 import re
 from pprint import pformat
 
-from kdoc_re import NestedMatch, KernRe
-from kdoc_item import KdocItem
+from kdoc.kdoc_re import CFunction, KernRe
+from kdoc.kdoc_item import KdocItem
 
 #
 # Regular expressions used to parse kernel-doc markups at KernelDoc class.
@@ -53,7 +50,7 @@
 doc_inline_start = KernRe(r'^\s*/\*\*\s*$', cache=False)
 doc_inline_sect = KernRe(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=False)
 doc_inline_end = KernRe(r'^\s*\*/\s*$', cache=False)
-doc_inline_oneline = KernRe(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$', cache=False)
+doc_inline_oneline = KernRe(r'^\s*/\*\*\s*(@\s*[\w][\w\.]*\s*):\s*(.*)\s*\*/\s*$', cache=False)
 
 export_symbol = KernRe(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
 export_symbol_ns = KernRe(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
@@ -64,7 +61,7 @@
 # Tests for the beginning of a kerneldoc block in its various forms.
 #
 doc_block = doc_com + KernRe(r'DOC:\s*(.*)?', cache=False)
-doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*)", cache = False)
+doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|var)\b\s*(\w*)", cache = False)
 doc_begin_func = KernRe(str(doc_com) +			# initial " * '
                         r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
                         r'(?:define\s+)?' + 		# possible "define" (not captured)
@@ -78,143 +75,22 @@
 #
 struct_args_pattern = r'([^,)]+)'
 
-struct_xforms = [
-    # Strip attributes
-    (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
-    (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__packed\s*', re.S), ' '),
-    (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
-    (KernRe(r'\s*__private', re.S), ' '),
-    (KernRe(r'\s*__rcu', re.S), ' '),
-    (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
-    (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-    (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
-    #
-    # Unwrap struct_group macros based on this definition:
-    # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
-    # which has variants like: struct_group(NAME, MEMBERS...)
-    # Only MEMBERS arguments require documentation.
-    #
-    # Parsing them happens on two steps:
-    #
-    # 1. drop struct group arguments that aren't at MEMBERS,
-    #    storing them as STRUCT_GROUP(MEMBERS)
-    #
-    # 2. remove STRUCT_GROUP() ancillary macro.
-    #
-    # The original logic used to remove STRUCT_GROUP() using an
-    # advanced regex:
-    #
-    #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
-    #
-    # with two patterns that are incompatible with
-    # Python re module, as it has:
-    #
-    #   - a recursive pattern: (?1)
-    #   - an atomic grouping: (?>...)
-    #
-    # I tried a simpler version: but it didn't work either:
-    #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
-    #
-    # As it doesn't properly match the end parenthesis on some cases.
-    #
-    # So, a better solution was crafted: there's now a NestedMatch
-    # class that ensures that delimiters after a search are properly
-    # matched. So, the implementation to drop STRUCT_GROUP() will be
-    # handled in separate.
-    #
-    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
-    #
-    # Replace macros
-    #
-    # TODO: use NestedMatch for FOO($1, $2, ...) matches
-    #
-    # it is better to also move those to the NestedMatch logic,
-    # to ensure that parentheses will be properly matched.
-    #
-    (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
-     r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-    (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
-     r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-    (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-            re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-    (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-            re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-    (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
-            r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-    (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
-            struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-    (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
-            struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
-    (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-    (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
-]
-#
-# Regexes here are guaranteed to have the end delimiter matching
-# the start delimiter. Yet, right now, only one replace group
-# is allowed.
-#
-struct_nested_prefixes = [
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
-]
 
 #
-# Transforms for function prototypes
+# Ancillary functions
 #
-function_xforms  = [
-    (KernRe(r"^static +"), ""),
-    (KernRe(r"^extern +"), ""),
-    (KernRe(r"^asmlinkage +"), ""),
-    (KernRe(r"^inline +"), ""),
-    (KernRe(r"^__inline__ +"), ""),
-    (KernRe(r"^__inline +"), ""),
-    (KernRe(r"^__always_inline +"), ""),
-    (KernRe(r"^noinline +"), ""),
-    (KernRe(r"^__FORTIFY_INLINE +"), ""),
-    (KernRe(r"QEMU_[A-Z_]+ +"), ""),
-    (KernRe(r"__init +"), ""),
-    (KernRe(r"__init_or_module +"), ""),
-    (KernRe(r"__deprecated +"), ""),
-    (KernRe(r"__flatten +"), ""),
-    (KernRe(r"__meminit +"), ""),
-    (KernRe(r"__must_check +"), ""),
-    (KernRe(r"__weak +"), ""),
-    (KernRe(r"__sched +"), ""),
-    (KernRe(r"_noprof"), ""),
-    (KernRe(r"__always_unused *"), ""),
-    (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
-    (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
-    (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
-    (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
-    (KernRe(r"__attribute_const__ +"), ""),
-    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
-]
 
-#
-# Apply a set of transforms to a block of text.
-#
-def apply_transforms(xforms, text):
-    for search, subst in xforms:
-        text = search.sub(subst, text)
-    return text
-
-#
-# A little helper to get rid of excess white space
-#
 multi_space = KernRe(r'\s\s+')
 def trim_whitespace(s):
+    """
+    A little helper to get rid of excess white space.
+    """
     return multi_space.sub(' ', s.strip())
 
-#
-# Remove struct/enum members that have been marked "private".
-#
 def trim_private_members(text):
-    #
+    """
+    Remove ``struct``/``enum`` members that have been marked "private".
+    """
     # First look for a "public:" block that ends a private region, then
     # handle the "private until the end" case.
     #
@@ -227,20 +103,21 @@ def trim_private_members(text):
 
 class state:
     """
-    State machine enums
+    States used by the parser's state machine.
     """
 
     # Parser states
-    NORMAL        = 0        # normal code
-    NAME          = 1        # looking for function name
-    DECLARATION   = 2        # We have seen a declaration which might not be done
-    BODY          = 3        # the body of the comment
-    SPECIAL_SECTION = 4      # doc section ending with a blank line
-    PROTO         = 5        # scanning prototype
-    DOCBLOCK      = 6        # documentation block
-    INLINE_NAME   = 7        # gathering doc outside main block
-    INLINE_TEXT   = 8	     # reading the body of inline docs
+    NORMAL        = 0        #: Normal code.
+    NAME          = 1        #: Looking for function name.
+    DECLARATION   = 2        #: We have seen a declaration which might not be done.
+    BODY          = 3        #: The body of the comment.
+    SPECIAL_SECTION = 4      #: Doc section ending with a blank line.
+    PROTO         = 5        #: Scanning prototype.
+    DOCBLOCK      = 6        #: Documentation block.
+    INLINE_NAME   = 7        #: Gathering doc outside main block.
+    INLINE_TEXT   = 8	     #: Reading the body of inline docs.
 
+    #: Names for each parser state.
     name = [
         "NORMAL",
         "NAME",
@@ -254,9 +131,12 @@ class state:
     ]
 
 
-SECTION_DEFAULT = "Description"  # default section
+SECTION_DEFAULT = "Description"  #: Default section.
 
 class KernelEntry:
+    """
+    Encapsulates a Kernel documentation entry.
+    """
 
     def __init__(self, config, fname, ln):
         self.config = config
@@ -289,14 +169,16 @@ def __init__(self, config, fname, ln):
     # Management of section contents
     #
     def add_text(self, text):
+        """Add a new text to the entry contents list."""
         self._contents.append(text)
 
     def contents(self):
+        """Returns a string with all content texts that were added."""
         return '\n'.join(self._contents) + '\n'
 
     # TODO: rename to emit_message after removal of kernel-doc.pl
     def emit_msg(self, ln, msg, *, warning=True):
-        """Emit a message"""
+        """Emit a message."""
 
         log_msg = f"{self.fname}:{ln} {msg}"
 
@@ -310,10 +192,10 @@ def emit_msg(self, ln, msg, *, warning=True):
         self.warnings.append(log_msg)
         return
 
-    #
-    # Begin a new section.
-    #
     def begin_section(self, line_no, title = SECTION_DEFAULT, dump = False):
+        """
+        Begin a new section.
+        """
         if dump:
             self.dump_section(start_new = True)
         self.section = title
@@ -367,18 +249,21 @@ class KernelDoc:
     documentation comments.
     """
 
-    # Section names
-
+    #: Name of context section.
     section_context = "Context"
+
+    #: Name of return section.
     section_return = "Return"
 
+    #: String to write when a parameter is not described.
     undescribed = "-- undescribed --"
 
-    def __init__(self, config, fname):
+    def __init__(self, config, fname, xforms):
         """Initialize internal variables"""
 
         self.fname = fname
         self.config = config
+        self.xforms = xforms
 
         # Initial state for the state machines
         self.state = state.NORMAL
@@ -417,7 +302,7 @@ def emit_msg(self, ln, msg, *, warning=True):
 
     def dump_section(self, start_new=True):
         """
-        Dumps section contents to arrays/hashes intended for that purpose.
+        Dump section contents to arrays/hashes intended for that purpose.
         """
 
         if self.entry:
@@ -426,9 +311,9 @@ def dump_section(self, start_new=True):
     # TODO: rename it to store_declaration after removal of kernel-doc.pl
     def output_declaration(self, dtype, name, **args):
         """
-        Stores the entry into an entry array.
+        Store the entry into an entry array.
 
-        The actual output and output filters will be handled elsewhere
+        The actual output and output filters will be handled elsewhere.
         """
 
         item = KdocItem(name, self.fname, dtype,
@@ -449,24 +334,50 @@ def output_declaration(self, dtype, name, **args):
 
         self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
 
+    def emit_unused_warnings(self):
+        """
+        When the parser fails to produce a valid entry, it places some
+        warnings under `entry.warnings` that will be discarded when resetting
+        the state.
+
+        Ensure that those warnings are not lost.
+
+        .. note::
+
+              Because we are calling `config.warning()` here, those
+              warnings are not filtered by the `-W` parameters: they will all
+              be produced even when `-Wreturn`, `-Wshort-desc`, and/or
+              `-Wcontents-before-sections` are used.
+
+              Allowing those warnings to be filtered is complex, because it
+              would require storing them in a buffer and then filtering them
+              during the output step of the code, depending on the
+              selected symbols.
+        """
+        if self.entry and self.entry not in self.entries:
+            for log_msg in self.entry.warnings:
+                self.config.warning(log_msg)
+
     def reset_state(self, ln):
         """
         Ancillary routine to create a new entry. It initializes all
         variables used by the state machine.
         """
 
-        #
-        # Flush the warnings out before we proceed further
-        #
-        if self.entry and self.entry not in self.entries:
-            for log_msg in self.entry.warnings:
-                self.config.log.warning(log_msg)
+        self.emit_unused_warnings()
 
         self.entry = KernelEntry(self.config, self.fname, ln)
 
         # State flags
         self.state = state.NORMAL
 
+    def apply_transforms(self, xforms, text):
+        """Apply a set of transforms to a block of text."""
+        for search, subst in xforms:
+            text = search.sub(subst, text)
+
+        return text.strip()
+
     def push_parameter(self, ln, decl_type, param, dtype,
                        org_arg, declaration_name):
         """
@@ -664,10 +575,12 @@ def check_return_section(self, ln, declaration_name, return_type):
             self.emit_msg(ln,
                           f"No description found for return value of '{declaration_name}'")
 
-    #
-    # Split apart a structure prototype; returns (struct|union, name, members) or None
-    #
     def split_struct_proto(self, proto):
+        """
+        Split apart a structure prototype; returns (struct|union, name,
+        members) or ``None``.
+        """
+
         type_pattern = r'(struct|union)'
         qualifiers = [
             "__attribute__",
@@ -686,21 +599,26 @@ def split_struct_proto(self, proto):
             if r.search(proto):
                 return (r.group(1), r.group(3), r.group(2))
         return None
-    #
-    # Rewrite the members of a structure or union for easier formatting later on.
-    # Among other things, this function will turn a member like:
-    #
-    #  struct { inner_members; } foo;
-    #
-    # into:
-    #
-    #  struct foo; inner_members;
-    #
+
     def rewrite_struct_members(self, members):
+        """
+        Process ``struct``/``union`` members from the most deeply nested
+        outward.
+
+        Rewrite the members of a ``struct`` or ``union`` for easier formatting
+        later on. Among other things, this function will turn a member like::
+
+          struct { inner_members; } foo;
+
+        into::
+
+          struct foo; inner_members;
+        """
+
         #
-        # Process struct/union members from the most deeply nested outward.  The
-        # trick is in the ^{ below - it prevents a match of an outer struct/union
-        # until the inner one has been munged (removing the "{" in the process).
+        # The trick is in the ``^{`` below - it prevents a match of an outer
+        # ``struct``/``union`` until the inner one has been munged
+        # (removing the ``{`` in the process).
         #
         struct_members = KernRe(r'(struct|union)'   # 0: declaration type
                                 r'([^\{\};]+)' 	    # 1: possible name
@@ -778,11 +696,12 @@ def rewrite_struct_members(self, members):
             tuples = struct_members.findall(members)
         return members
 
-    #
-    # Format the struct declaration into a standard form for inclusion in the
-    # resulting docs.
-    #
     def format_struct_decl(self, declaration):
+        """
+        Format the ``struct`` declaration into a standard form for inclusion
+        in the resulting docs.
+        """
+
         #
         # Insert newlines, get rid of extra spaces.
         #
@@ -816,7 +735,7 @@ def format_struct_decl(self, declaration):
 
     def dump_struct(self, ln, proto):
         """
-        Store an entry for a struct or union
+        Store an entry for a ``struct`` or ``union``
         """
         #
         # Do the basic parse to get the pieces of the declaration.
@@ -835,11 +754,8 @@ def dump_struct(self, ln, proto):
         # Go through the list of members applying all of our transformations.
         #
         members = trim_private_members(members)
-        members = apply_transforms(struct_xforms, members)
+        members = self.apply_transforms(self.xforms.struct_xforms, members)
 
-        nested = NestedMatch()
-        for search, sub in struct_nested_prefixes:
-            members = nested.sub(search, sub, members)
         #
         # Deal with embedded struct and union members, and drop enums entirely.
         #
@@ -858,7 +774,7 @@ def dump_struct(self, ln, proto):
 
     def dump_enum(self, ln, proto):
         """
-        Stores an enum inside self.entries array.
+        Store an ``enum`` inside self.entries array.
         """
         #
         # Strip preprocessor directives.  Note that this depends on the
@@ -928,9 +844,85 @@ def dump_enum(self, ln, proto):
         self.output_declaration('enum', declaration_name,
                                 purpose=self.entry.declaration_purpose)
 
+    def dump_var(self, ln, proto):
+        """
+        Store variables that are part of kAPI.
+        """
+        VAR_ATTRIBS = [
+            "extern",
+        ]
+        OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+
+        #
+        # Store the full prototype before modifying it
+        #
+        full_proto = proto
+        declaration_name = None
+
+        #
+        # Handle macro definitions
+        #
+        macro_prefixes = [
+            KernRe(r"DEFINE_[\w_]+\s*\(([\w_]+)\)"),
+        ]
+
+        for r in macro_prefixes:
+            match = r.search(proto)
+            if match:
+                declaration_name = match.group(1)
+                break
+
+        #
+        # Drop comments and macros to have a pure C prototype
+        #
+        if not declaration_name:
+            proto = self.apply_transforms(self.xforms.var_xforms, proto)
+
+        proto = proto.rstrip()
+
+        #
+        # Variable name is at the end of the declaration
+        #
+
+        default_val = None
+
+        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        if r.match(proto):
+            if not declaration_name:
+                declaration_name = r.group(1)
+
+            default_val = r.group(2)
+
+            self.config.log.debug("Variable proto parser: %s from '%s'",
+                                  r.groups(), proto)
+
+        else:
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_\s]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+
+            if r.match(proto):
+                default_val = r.group(1)
+
+        if default_val:
+            self.config.log.debug("default: '%s'", default_val)
+
+        if not declaration_name:
+           self.emit_msg(ln,f"{proto}: can't parse variable")
+           return
+
+        if default_val:
+            default_val = default_val.lstrip("=").strip()
+
+        self.config.log.debug("'%s' variable prototype: '%s', default: %s",
+                              declaration_name, proto, default_val)
+
+        self.output_declaration("var", declaration_name,
+                                full_proto=full_proto,
+                                default_val=default_val,
+                                purpose=self.entry.declaration_purpose)
+
     def dump_declaration(self, ln, prototype):
         """
-        Stores a data declaration inside self.entries array.
+        Store a data declaration inside self.entries array.
         """
 
         if self.entry.decl_type == "enum":
@@ -939,22 +931,21 @@ def dump_declaration(self, ln, prototype):
             self.dump_typedef(ln, prototype)
         elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
+        elif self.entry.decl_type == "var":
+            self.dump_var(ln, prototype)
         else:
             # This would be a bug
             self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')
 
     def dump_function(self, ln, prototype):
         """
-        Stores a function or function macro inside self.entries array.
+        Store a function or function macro inside self.entries array.
         """
 
         found = func_macro = False
         return_type = ''
         decl_type = 'function'
-        #
-        # Apply the initial transformations.
-        #
-        prototype = apply_transforms(function_xforms, prototype)
+
         #
         # If we have a macro, remove the "#define" at the front.
         #
@@ -973,6 +964,12 @@ def dump_function(self, ln, prototype):
                 declaration_name = r.group(1)
                 func_macro = True
                 found = True
+        else:
+            #
+            # Apply the initial transformations.
+            #
+            prototype = self.apply_transforms(self.xforms.function_xforms,
+                                              prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
@@ -1046,7 +1043,7 @@ def dump_function(self, ln, prototype):
 
     def dump_typedef(self, ln, proto):
         """
-        Stores a typedef inside self.entries array.
+        Store a ``typedef`` inside self.entries array.
         """
         #
         # We start by looking for function typedefs.
@@ -1100,7 +1097,7 @@ def dump_typedef(self, ln, proto):
     @staticmethod
     def process_export(function_set, line):
         """
-        process EXPORT_SYMBOL* tags
+        process ``EXPORT_SYMBOL*`` tags
 
         This method doesn't use any variable from the class, so declare it
         with a staticmethod decorator.
@@ -1131,7 +1128,7 @@ def process_export(function_set, line):
 
     def process_normal(self, ln, line):
         """
-        STATE_NORMAL: looking for the /** to begin everything.
+        STATE_NORMAL: looking for the ``/**`` to begin everything.
         """
 
         if not doc_start.match(line):
@@ -1221,10 +1218,10 @@ def process_name(self, ln, line):
         else:
             self.emit_msg(ln, f"Cannot find identifier on line:\n{line}")
 
-    #
-    # Helper function to determine if a new section is being started.
-    #
     def is_new_section(self, ln, line):
+        """
+        Helper function to determine if a new section is being started.
+        """
         if doc_sect.search(line):
             self.state = state.BODY
             #
@@ -1256,10 +1253,10 @@ def is_new_section(self, ln, line):
             return True
         return False
 
-    #
-    # Helper function to detect (and effect) the end of a kerneldoc comment.
-    #
     def is_comment_end(self, ln, line):
+        """
+        Helper function to detect (and effect) the end of a kerneldoc comment.
+        """
         if doc_end.search(line):
             self.dump_section()
 
@@ -1278,7 +1275,7 @@ def is_comment_end(self, ln, line):
 
     def process_decl(self, ln, line):
         """
-        STATE_DECLARATION: We've seen the beginning of a declaration
+        STATE_DECLARATION: We've seen the beginning of a declaration.
         """
         if self.is_new_section(ln, line) or self.is_comment_end(ln, line):
             return
@@ -1307,7 +1304,7 @@ def process_decl(self, ln, line):
 
     def process_special(self, ln, line):
         """
-        STATE_SPECIAL_SECTION: a section ending with a blank line
+        STATE_SPECIAL_SECTION: a section ending with a blank line.
         """
         #
         # If we have hit a blank line (only the " * " marker), then this
@@ -1397,7 +1394,7 @@ def process_inline_text(self, ln, line):
 
     def syscall_munge(self, ln, proto):         # pylint: disable=W0613
         """
-        Handle syscall definitions
+        Handle syscall definitions.
         """
 
         is_void = False
@@ -1436,7 +1433,7 @@ def syscall_munge(self, ln, proto):         # pylint: disable=W0613
 
     def tracepoint_munge(self, ln, proto):
         """
-        Handle tracepoint definitions
+        Handle tracepoint definitions.
         """
 
         tracepointname = None
@@ -1472,7 +1469,7 @@ def tracepoint_munge(self, ln, proto):
         return proto
 
     def process_proto_function(self, ln, line):
-        """Ancillary routine to process a function prototype"""
+        """Ancillary routine to process a function prototype."""
 
         # strip C99-style comments to end of line
         line = KernRe(r"//.*$", re.S).sub('', line)
@@ -1517,7 +1514,9 @@ def process_proto_function(self, ln, line):
             self.reset_state(ln)
 
     def process_proto_type(self, ln, line):
-        """Ancillary routine to process a type"""
+        """
+        Ancillary routine to process a type.
+        """
 
         # Strip C99-style comments and surrounding whitespace
         line = KernRe(r"//.*$", re.S).sub('', line).strip()
@@ -1571,7 +1570,7 @@ def process_proto(self, ln, line):
             self.process_proto_type(ln, line)
 
     def process_docblock(self, ln, line):
-        """STATE_DOCBLOCK: within a DOC: block."""
+        """STATE_DOCBLOCK: within a ``DOC:`` block."""
 
         if doc_end.search(line):
             self.dump_section()
@@ -1583,7 +1582,7 @@ def process_docblock(self, ln, line):
 
     def parse_export(self):
         """
-        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
+        Parses ``EXPORT_SYMBOL*`` macros from a single Kernel source file.
         """
 
         export_table = set()
@@ -1600,10 +1599,7 @@ def parse_export(self):
 
         return export_table
 
-    #
-    # The state/action table telling us which function to invoke in
-    # each state.
-    #
+    #: The state/action table telling us which function to invoke in each state.
     state_actions = {
         state.NORMAL:			process_normal,
         state.NAME:			process_name,
@@ -1665,6 +1661,8 @@ def parse_kdoc(self):
                         # Hand this line to the appropriate state handler
                         self.state_actions[self.state](self, ln, line)
 
+            self.emit_unused_warnings()
+
         except OSError:
             self.config.log.error(f"Error: Cannot open file {self.fname}")
 
diff --git a/scripts/lib/kdoc/kdoc_re.py b/scripts/lib/kdoc/kdoc_re.py
index 2dfa1bf83d64..294051dbc050 100644
--- a/scripts/lib/kdoc/kdoc_re.py
+++ b/scripts/lib/kdoc/kdoc_re.py
@@ -51,6 +51,30 @@ def __str__(self):
         """
         return self.regex.pattern
 
+    def __repr__(self):
+        """
+        Returns a displayable version of the class init.
+        """
+
+        flag_map = {
+            re.IGNORECASE: "re.I",
+            re.MULTILINE: "re.M",
+            re.DOTALL: "re.S",
+            re.VERBOSE: "re.X",
+        }
+
+        flags = []
+        for flag, name in flag_map.items():
+            if self.regex.flags & flag:
+                flags.append(name)
+
+        flags_name = " | ".join(flags)
+
+        if flags_name:
+            return f'KernRe("{self.regex.pattern}", {flags_name})'
+        else:
+            return f'KernRe("{self.regex.pattern}")'
+
     def __add__(self, other):
         """
         Allows adding two regular expressions into one.
@@ -61,7 +85,7 @@ def __add__(self, other):
 
     def match(self, string):
         """
-        Handles a re.match storing its results
+        Handles a re.match storing its results.
         """
 
         self.last_match = self.regex.match(string)
@@ -69,40 +93,64 @@ def match(self, string):
 
     def search(self, string):
         """
-        Handles a re.search storing its results
+        Handles a re.search storing its results.
         """
 
         self.last_match = self.regex.search(string)
         return self.last_match
 
+    def finditer(self,  string):
+        """
+        Alias to re.finditer.
+        """
+
+        return self.regex.finditer(string)
+
     def findall(self, string):
         """
-        Alias to re.findall
+        Alias to re.findall.
         """
 
         return self.regex.findall(string)
 
     def split(self, string):
         """
-        Alias to re.split
+        Alias to re.split.
         """
 
         return self.regex.split(string)
 
     def sub(self, sub, string, count=0):
         """
-        Alias to re.sub
+        Alias to re.sub.
         """
 
         return self.regex.sub(sub, string, count=count)
 
     def group(self, num):
         """
-        Returns the group results of the last match
+        Returns the group results of the last match.
         """
 
         return self.last_match.group(num)
 
+    def groups(self):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.groups()
+
+#: Nested delimited pairs (brackets and parenthesis)
+DELIMITER_PAIRS = {
+    '{': '}',
+    '(': ')',
+    '[': ']',
+}
+
+#: compiled delimiters
+RE_DELIM = KernRe(r'[\{\}\[\]\(\)]')
+
 
 class NestedMatch:
     """
@@ -110,7 +158,7 @@ class NestedMatch:
     even harder on Python with its normal re module, as there are several
     advanced regular expressions that are missing.
 
-    This is the case of this pattern:
+    This is the case of this pattern::
 
             '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
 
@@ -121,6 +169,7 @@ class NestedMatch:
     replace nested expressions.
 
     The original approach was suggested by:
+
         https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
 
     Although I re-implemented it to make it more generic and match 3 types
@@ -128,38 +177,10 @@ class NestedMatch:
     will ignore the search string.
     """
 
-    # TODO: make NestedMatch handle multiple match groups
-    #
-    # Right now, regular expressions to match it are defined only up to
-    #       the start delimiter, e.g.:
-    #
-    #       \bSTRUCT_GROUP\(
-    #
-    # is similar to: STRUCT_GROUP\((.*)\)
-    # except that the content inside the match group is delimiter-aligned.
-    #
-    # The content inside parentheses is converted into a single replace
-    # group (e.g. r`\1').
-    #
-    # It would be nice to change such definition to support multiple
-    # match groups, allowing a regex equivalent to:
-    #
-    #   FOO\((.*), (.*), (.*)\)
-    #
-    # it is probably easier to define it not as a regular expression, but
-    # with some lexical definition like:
-    #
-    #   FOO(arg1, arg2, arg3)
+    def __init__(self, regex):
+        self.regex = KernRe(regex)
 
-    DELIMITER_PAIRS = {
-        '{': '}',
-        '(': ')',
-        '[': ']',
-    }
-
-    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
-
-    def _search(self, regex, line):
+    def _search(self, line):
         """
         Finds paired blocks for a regex that ends with a delimiter.
 
@@ -180,25 +201,46 @@ def _search(self, regex, line):
         """
 
         stack = []
+        start = 0
+        offset = 0
+        pos = 0
 
-        for match_re in regex.finditer(line):
+        for match_re in self.regex.finditer(line):
             start = match_re.start()
             offset = match_re.end()
+            string_char = None
+            escape = False
 
             d = line[offset - 1]
-            if d not in self.DELIMITER_PAIRS:
+            if d not in DELIMITER_PAIRS:
                 continue
 
-            end = self.DELIMITER_PAIRS[d]
+            end = DELIMITER_PAIRS[d]
             stack.append(end)
 
-            for match in self.RE_DELIM.finditer(line[offset:]):
+            for match in RE_DELIM.finditer(line[offset:]):
                 pos = match.start() + offset
 
                 d = line[pos]
 
-                if d in self.DELIMITER_PAIRS:
-                    end = self.DELIMITER_PAIRS[d]
+                if escape:
+                    escape = False
+                    continue
+
+                if string_char:
+                    if d == '\\':
+                        escape = True
+                    elif d == string_char:
+                        string_char = None
+
+                    continue
+
+                if d in ('"', "'"):
+                    string_char = d
+                    continue
+
+                if d in DELIMITER_PAIRS:
+                    end = DELIMITER_PAIRS[d]
 
                     stack.append(end)
                     continue
@@ -211,7 +253,12 @@ def _search(self, regex, line):
                         yield start, offset, pos + 1
                         break
 
-    def search(self, regex, line):
+        # When /* private */ is used, it may end the end delimiterq
+        if stack:
+            stack.pop()
+            yield start, offset, len(line) + 1
+
+    def search(self, line):
         """
         This is similar to re.search:
 
@@ -219,19 +266,73 @@ def search(self, regex, line):
         returning occurrences only if all delimiters are paired.
         """
 
-        for t in self._search(regex, line):
+        for t in self._search(line):
 
             yield line[t[0]:t[2]]
 
-    def sub(self, regex, sub, line, count=0):
+    @staticmethod
+    def _split_args(all_args, delim=","):
+        """
+        Helper method to split comma-separated function arguments
+        or struct elements, if delim is set to ";".
+
+        It returns a list of arguments that can be used later on by
+        the sub() method.
+        """
+        args = [all_args]
+        stack = []
+        arg_start = 0
+        string_char = None
+        escape = False
+
+        for idx, d in enumerate(all_args):
+            if escape:
+                escape = False
+                continue
+
+            if string_char:
+                if d == '\\':
+                    escape = True
+                elif d == string_char:
+                    string_char = None
+
+                continue
+
+            if d in ('"', "'"):
+                string_char = d
+                continue
+
+            if d in DELIMITER_PAIRS:
+                end = DELIMITER_PAIRS[d]
+
+                stack.append(end)
+                continue
+
+            if stack and d == stack[-1]:
+                stack.pop()
+                continue
+
+            if d == delim and not stack:
+                args.append(all_args[arg_start:idx].strip())
+                arg_start = idx + 1
+
+        # Add the last argument (if any)
+        last = all_args[arg_start:].strip()
+        if last:
+            args.append(last)
+
+        return args
+
+    def sub(self, sub, line, count=0):
         """
         This is similar to re.sub:
 
         It matches a regex that it is followed by a delimiter,
         replacing occurrences only if all delimiters are paired.
 
-        if r'\1' is used, it works just like re: it places there the
-        matched paired data with the delimiter stripped.
+        if r'\0' is used, it works on a similar way of using re.group(0):
+        it places the entire args of the matched paired data, with the
+        delimiter stripped.
 
         If count is different than zero, it will replace at most count
         items.
@@ -241,22 +342,22 @@ def sub(self, regex, sub, line, count=0):
         cur_pos = 0
         n = 0
 
-        for start, end, pos in self._search(regex, line):
+        for start, end, pos in self._search(line):
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \1 at the sub string, if \1 is used there
+            # replace arguments
             new_sub = sub
-            new_sub = new_sub.replace(r'\1', value)
+            if "\\" in sub:
+                args = self._split_args(value)
+
+                new_sub = re.sub(r'\\(\d+)',
+                                 lambda m: args[int(m.group(1))], new_sub)
 
             out += new_sub
 
-            # Drop end ';' if any
-            if line[pos] == ';':
-                pos += 1
-
             cur_pos = pos
             n += 1
 
@@ -268,3 +369,21 @@ def sub(self, regex, sub, line, count=0):
         out += line[cur_pos:l]
 
         return out
+
+    def __repr__(self):
+        """
+        Returns a displayable version of the class init.
+        """
+
+        return f'NestedMatch("{self.regex.regex.pattern}")'
+
+
+class CFunction(NestedMatch):
+    r"""
+    Variant of NestedMatch.
+
+    It overrides the init method to ensure that the regular expression will
+    start with a ``\b`` and end with a C function delimiter (open parenthesis).
+    """
+    def __init__(self, regex):
+        self.regex = KernRe(r"\b" + regex + r"\s*\(")
diff --git a/scripts/lib/kdoc/latex_fonts.py b/scripts/lib/kdoc/latex_fonts.py
new file mode 100755
index 000000000000..1d04cbda169f
--- /dev/null
+++ b/scripts/lib/kdoc/latex_fonts.py
@@ -0,0 +1,184 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) Akira Yokosawa, 2024
+#
+# Ported to Python by (c) Mauro Carvalho Chehab, 2025
+
+"""
+Detect problematic Noto CJK variable fonts
+==========================================
+
+For ``make pdfdocs``, reports of build errors of translations.pdf started
+arriving early 2024 [1]_ [2]_.  It turned out that Fedora and openSUSE
+tumbleweed have started deploying variable-font [3]_ format of "Noto CJK"
+fonts [4]_ [5]_.  For PDF, a LaTeX package named xeCJK is used for CJK
+(Chinese, Japanese, Korean) pages.  xeCJK requires XeLaTeX/XeTeX, which
+does not (and likely never will) understand variable fonts for historical
+reasons.
+
+The build error happens even when both of variable- and non-variable-format
+fonts are found on the build system.  To make matters worse, Fedora enlists
+variable "Noto CJK" fonts in the requirements of langpacks-ja, -ko, -zh_CN,
+-zh_TW, etc.  Hence developers who have interest in CJK pages are more
+likely to encounter the build errors.
+
+This script is invoked from the error path of "make pdfdocs" and emits
+suggestions if variable-font files of "Noto CJK" fonts are in the list of
+fonts accessible from XeTeX.
+
+.. [1] https://lore.kernel.org/r/8734tqsrt7.fsf@meer.lwn.net/
+.. [2] https://lore.kernel.org/r/1708585803.600323099@f111.i.mail.ru/
+.. [3] https://en.wikipedia.org/wiki/Variable_font
+.. [4] https://fedoraproject.org/wiki/Changes/Noto_CJK_Variable_Fonts
+.. [5] https://build.opensuse.org/request/show/1157217
+
+Workarounds for building translations.pdf
+-----------------------------------------
+
+* Denylist "variable font" Noto CJK fonts.
+
+  - Create $HOME/deny-vf/fontconfig/fonts.conf from template below, with
+    tweaks if necessary.  Remove leading "".
+
+  - Path of fontconfig/fonts.conf can be overridden by setting an env
+    variable FONTS_CONF_DENY_VF.
+
+    * Template::
+
+        <?xml version="1.0"?>
+        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
+        <fontconfig>
+        <!--
+        Ignore variable-font glob (not to break xetex)
+        -->
+            <selectfont>
+                <rejectfont>
+                    <!--
+                        for Fedora
+                    -->
+                    <glob>/usr/share/fonts/google-noto-*-cjk-vf-fonts</glob>
+                    <!--
+                        for openSUSE tumbleweed
+                    -->
+                    <glob>/usr/share/fonts/truetype/Noto*CJK*-VF.otf</glob>
+                </rejectfont>
+            </selectfont>
+        </fontconfig>
+
+    The denylisting is activated for "make pdfdocs".
+
+* For skipping CJK pages in PDF
+
+  - Uninstall texlive-xecjk.
+    Denylisting is not needed in this case.
+
+* For printing CJK pages in PDF
+
+  - Need non-variable "Noto CJK" fonts.
+
+    * Fedora
+
+      - google-noto-sans-cjk-fonts
+      - google-noto-serif-cjk-fonts
+
+    * openSUSE tumbleweed
+
+      - Non-variable "Noto CJK" fonts are not available as distro packages
+        as of April, 2024.  Fetch a set of font files from upstream Noto
+        CJK Font released at:
+
+          https://github.com/notofonts/noto-cjk/tree/main/Sans#super-otc
+
+        and at:
+
+          https://github.com/notofonts/noto-cjk/tree/main/Serif#super-otc
+
+        then uncompress and deploy them.
+      - Remember to update fontconfig cache by running fc-cache.
+
+.. caution::
+    Uninstalling "variable font" packages can be dangerous.
+    They might be depended upon by other packages important for your work.
+    Denylisting should be less invasive, as it is effective only while
+    XeLaTeX runs in "make pdfdocs".
+"""
+
+import os
+import re
+import subprocess
+import textwrap
+import sys
+
+class LatexFontChecker:
+    """
+    Detect problems with CJK variable fonts that affect PDF builds for
+    translations.
+    """
+
+    def __init__(self, deny_vf=None):
+        if not deny_vf:
+            deny_vf = os.environ.get('FONTS_CONF_DENY_VF', "~/deny-vf")
+
+        self.environ = os.environ.copy()
+        self.environ['XDG_CONFIG_HOME'] = os.path.expanduser(deny_vf)
+
+        self.re_cjk = re.compile(r"([^:]+):\s*Noto\s+(Sans|Sans Mono|Serif) CJK")
+
+    def description(self):
+        """
+        Returns module description.
+        """
+        return __doc__
+
+    def get_noto_cjk_vf_fonts(self):
+        """
+        Get Noto CJK fonts.
+        """
+
+        cjk_fonts = set()
+        cmd = ["fc-list", ":", "file", "family", "variable"]
+        try:
+            result = subprocess.run(cmd,stdout=subprocess.PIPE,
+                                    stderr=subprocess.PIPE,
+                                    universal_newlines=True,
+                                    env=self.environ,
+                                    check=True)
+
+        except subprocess.CalledProcessError as exc:
+            sys.exit(f"Error running fc-list: {repr(exc)}")
+
+        for line in result.stdout.splitlines():
+            if 'variable=True' not in line:
+                continue
+
+            match = self.re_cjk.search(line)
+            if match:
+                cjk_fonts.add(match.group(1))
+
+        return sorted(cjk_fonts)
+
+    def check(self):
+        """
+        Check for problems with CJK fonts.
+        """
+
+        fonts = textwrap.indent("\n".join(self.get_noto_cjk_vf_fonts()), "    ")
+        if not fonts:
+            return None
+
+        rel_file = os.path.relpath(__file__, os.getcwd())
+
+        msg = "=" * 77 + "\n"
+        msg += 'XeTeX is confused by "variable font" files listed below:\n'
+        msg += fonts + "\n"
+        msg += textwrap.dedent(f"""
+                For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
+                Or, CJK pages can be skipped by uninstalling texlive-xecjk.
+
+                For more info on denylisting, other options, and variable font, run:
+
+                    tools/docs/check-variable-fonts.py -h
+            """)
+        msg += "=" * 77
+
+        return msg
diff --git a/scripts/lib/kdoc/parse_data_structs.py b/scripts/lib/kdoc/parse_data_structs.py
new file mode 100755
index 000000000000..9941cd19032e
--- /dev/null
+++ b/scripts/lib/kdoc/parse_data_structs.py
@@ -0,0 +1,498 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2016-2025 by Mauro Carvalho Chehab <mchehab@kernel.org>.
+# pylint: disable=R0912,R0915
+
+"""
+Parse a source file or header, creating ReStructured Text cross references.
+
+It accepts an optional file to change the default symbol reference or to
+suppress symbols from the output.
+
+It is capable of identifying ``define``, function, ``struct``, ``typedef``,
+``enum`` and ``enum`` symbols and create cross-references for all of them.
+It is also capable of distinguish #define used for specifying a Linux
+ioctl.
+
+The optional rules file contains a set of rules like::
+
+    ignore ioctl VIDIOC_ENUM_FMT
+    replace ioctl VIDIOC_DQBUF vidioc_qbuf
+    replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
+"""
+
+import os
+import re
+import sys
+
+
+class ParseDataStructs:
+    """
+    Creates an enriched version of a Kernel header file with cross-links
+    to each C data structure type.
+
+    It is meant to allow having a more comprehensive documentation, where
+    uAPI headers will create cross-reference links to the code.
+
+    It is capable of identifying ``define``, function, ``struct``, ``typedef``,
+    ``enum`` and ``enum`` symbols and create cross-references for all of them.
+    It is also capable of distinguish #define used for specifying a Linux
+    ioctl.
+
+    By default, it create rules for all symbols and defines, but it also
+    allows parsing an exception file. Such file contains a set of rules
+    using the syntax below:
+
+    1. Ignore rules::
+
+        ignore <type> <symbol>`
+
+    Removes the symbol from reference generation.
+
+    2. Replace rules::
+
+        replace <type> <old_symbol> <new_reference>
+
+       Replaces how old_symbol with a new reference. The new_reference can be:
+
+        - A simple symbol name;
+        - A full Sphinx reference.
+
+    3. Namespace rules::
+
+        namespace <namespace>
+
+       Sets C namespace to be used during cross-reference generation. Can
+       be overridden by replace rules.
+
+    On ignore and replace rules, ``<type>`` can be:
+        - ``ioctl``: for defines that end with ``_IO*``, e.g. ioctl definitions
+        - ``define``: for other defines
+        - ``symbol``: for symbols defined within enums;
+        - ``typedef``: for typedefs;
+        - ``enum``: for the name of a non-anonymous enum;
+        - ``struct``: for structs.
+
+    Examples::
+
+        ignore define __LINUX_MEDIA_H
+        ignore ioctl VIDIOC_ENUM_FMT
+        replace ioctl VIDIOC_DQBUF vidioc_qbuf
+        replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
+
+        namespace MC
+    """
+
+    #: Parser regex with multiple ways to capture enums.
+    RE_ENUMS = [
+        re.compile(r"^\s*enum\s+([\w_]+)\s*\{"),
+        re.compile(r"^\s*enum\s+([\w_]+)\s*$"),
+        re.compile(r"^\s*typedef\s*enum\s+([\w_]+)\s*\{"),
+        re.compile(r"^\s*typedef\s*enum\s+([\w_]+)\s*$"),
+    ]
+
+    #: Parser regex with multiple ways to capture structs.
+    RE_STRUCTS = [
+        re.compile(r"^\s*struct\s+([_\w][\w\d_]+)\s*\{"),
+        re.compile(r"^\s*struct\s+([_\w][\w\d_]+)$"),
+        re.compile(r"^\s*typedef\s*struct\s+([_\w][\w\d_]+)\s*\{"),
+        re.compile(r"^\s*typedef\s*struct\s+([_\w][\w\d_]+)$"),
+    ]
+
+    # NOTE: the original code was written a long time before Sphinx C
+    # domain to have multiple namespaces. To avoid to much turn at the
+    # existing hyperlinks, the code kept using "c:type" instead of the
+    # right types. To change that, we need to change the types not only
+    # here, but also at the uAPI media documentation.
+
+    #: Dictionary containing C type identifiers to be transformed.
+    DEF_SYMBOL_TYPES = {
+        "ioctl": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":ref",
+            "description": "IOCTL Commands",
+        },
+        "define": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":ref",
+            "description": "Macros and Definitions",
+        },
+        # We're calling each definition inside an enum as "symbol"
+        "symbol": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":ref",
+            "description": "Enumeration values",
+        },
+        "typedef": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":c:type",
+            "description": "Type Definitions",
+        },
+        # This is the description of the enum itself
+        "enum": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":c:type",
+            "description": "Enumerations",
+        },
+        "struct": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":c:type",
+            "description": "Structures",
+        },
+    }
+
+    def __init__(self, debug: bool = False):
+        """Initialize internal vars"""
+        self.debug = debug
+        self.data = ""
+
+        self.symbols = {}
+
+        self.namespace = None
+        self.ignore = []
+        self.replace = []
+
+        for symbol_type in self.DEF_SYMBOL_TYPES:
+            self.symbols[symbol_type] = {}
+
+    def read_exceptions(self, fname: str):
+        """
+        Read an optional exceptions file, used to override defaults.
+        """
+
+        if not fname:
+            return
+
+        name = os.path.basename(fname)
+
+        with open(fname, "r", encoding="utf-8", errors="backslashreplace") as f:
+            for ln, line in enumerate(f):
+                ln += 1
+                line = line.strip()
+                if not line or line.startswith("#"):
+                    continue
+
+                # ignore rules
+                match = re.match(r"^ignore\s+(\w+)\s+(\S+)", line)
+
+                if match:
+                    self.ignore.append((ln, match.group(1), match.group(2)))
+                    continue
+
+                # replace rules
+                match = re.match(r"^replace\s+(\S+)\s+(\S+)\s+(\S+)", line)
+                if match:
+                    self.replace.append((ln, match.group(1), match.group(2),
+                                         match.group(3)))
+                    continue
+
+                match = re.match(r"^namespace\s+(\S+)", line)
+                if match:
+                    self.namespace = match.group(1)
+                    continue
+
+                sys.exit(f"{name}:{ln}: invalid line: {line}")
+
+    def apply_exceptions(self):
+        """
+        Process exceptions file with rules to ignore or replace references.
+        """
+
+        # Handle ignore rules
+        for ln, c_type, symbol in self.ignore:
+            if c_type not in self.DEF_SYMBOL_TYPES:
+                sys.exit(f"{name}:{ln}: {c_type} is invalid")
+
+            d = self.symbols[c_type]
+            if symbol in d:
+                del d[symbol]
+
+        # Handle replace rules
+        for ln, c_type, old, new in self.replace:
+            if c_type not in self.DEF_SYMBOL_TYPES:
+                sys.exit(f"{name}:{ln}: {c_type} is invalid")
+
+            reftype = None
+
+            # Parse reference type when the type is specified
+
+            match = re.match(r"^\:c\:(\w+)\:\`(.+)\`", new)
+            if match:
+                reftype = f":c:{match.group(1)}"
+                new = match.group(2)
+            else:
+                match = re.search(r"(\:ref)\:\`(.+)\`", new)
+                if match:
+                    reftype = match.group(1)
+                    new = match.group(2)
+
+            # If the replacement rule doesn't have a type, get default
+            if not reftype:
+                reftype = self.DEF_SYMBOL_TYPES[c_type].get("ref_type")
+                if not reftype:
+                    reftype = self.DEF_SYMBOL_TYPES[c_type].get("real_type")
+
+            new_ref = f"{reftype}:`{old} <{new}>`"
+
+            # Change self.symbols to use the replacement rule
+            if old in self.symbols[c_type]:
+                (_, ln) = self.symbols[c_type][old]
+                self.symbols[c_type][old] = (new_ref, ln)
+            else:
+                print(f"{name}:{ln}: Warning: can't find {old} {c_type}")
+
+    def store_type(self, ln, symbol_type: str, symbol: str,
+                   ref_name: str = None, replace_underscores: bool = True):
+        """
+        Store a new symbol at self.symbols under symbol_type.
+
+        By default, underscores are replaced by ``-``.
+        """
+        defs = self.DEF_SYMBOL_TYPES[symbol_type]
+
+        prefix = defs.get("prefix", "")
+        suffix = defs.get("suffix", "")
+        ref_type = defs.get("ref_type")
+
+        # Determine ref_link based on symbol type
+        if ref_type or self.namespace:
+            if not ref_name:
+                ref_name = symbol.lower()
+
+            # c-type references don't support hash
+            if ref_type == ":ref" and replace_underscores:
+                ref_name = ref_name.replace("_", "-")
+
+            # C domain references may have namespaces
+            if ref_type.startswith(":c:"):
+                if self.namespace:
+                    ref_name = f"{self.namespace}.{ref_name}"
+
+            if ref_type:
+                ref_link = f"{ref_type}:`{symbol} <{ref_name}>`"
+            else:
+                ref_link = f"`{symbol} <{ref_name}>`"
+        else:
+            ref_link = symbol
+
+        self.symbols[symbol_type][symbol] = (f"{prefix}{ref_link}{suffix}", ln)
+
+    def store_line(self, line):
+        """
+        Store a line at self.data, properly indented.
+        """
+        line = "    " + line.expandtabs()
+        self.data += line.rstrip(" ")
+
+    def parse_file(self, file_in: str, exceptions: str = None):
+        """
+        Read a C source file and get identifiers.
+        """
+        self.data = ""
+        is_enum = False
+        is_comment = False
+        multiline = ""
+
+        self.read_exceptions(exceptions)
+
+        with open(file_in, "r",
+                  encoding="utf-8", errors="backslashreplace") as f:
+            for line_no, line in enumerate(f):
+                self.store_line(line)
+                line = line.strip("\n")
+
+                # Handle continuation lines
+                if line.endswith(r"\\"):
+                    multiline += line[-1]
+                    continue
+
+                if multiline:
+                    line = multiline + line
+                    multiline = ""
+
+                # Handle comments. They can be multilined
+                if not is_comment:
+                    if re.search(r"/\*.*", line):
+                        is_comment = True
+                    else:
+                        # Strip C99-style comments
+                        line = re.sub(r"(//.*)", "", line)
+
+                if is_comment:
+                    if re.search(r".*\*/", line):
+                        is_comment = False
+                    else:
+                        multiline = line
+                        continue
+
+                # At this point, line variable may be a multilined statement,
+                # if lines end with \ or if they have multi-line comments
+                # With that, it can safely remove the entire comments,
+                # and there's no need to use re.DOTALL for the logic below
+
+                line = re.sub(r"(/\*.*\*/)", "", line)
+                if not line.strip():
+                    continue
+
+                # It can be useful for debug purposes to print the file after
+                # having comments stripped and multi-lines grouped.
+                if self.debug > 1:
+                    print(f"line {line_no + 1}: {line}")
+
+                # Now the fun begins: parse each type and store it.
+
+                # We opted for a two parsing logic here due to:
+                # 1. it makes easier to debug issues not-parsed symbols;
+                # 2. we want symbol replacement at the entire content, not
+                #    just when the symbol is detected.
+
+                if is_enum:
+                    match = re.match(r"^\s*([_\w][\w\d_]+)\s*[\,=]?", line)
+                    if match:
+                        self.store_type(line_no, "symbol", match.group(1))
+                    if "}" in line:
+                        is_enum = False
+                    continue
+
+                match = re.match(r"^\s*#\s*define\s+([\w_]+)\s+_IO", line)
+                if match:
+                    self.store_type(line_no, "ioctl", match.group(1),
+                                    replace_underscores=False)
+                    continue
+
+                match = re.match(r"^\s*#\s*define\s+([\w_]+)(\s+|$)", line)
+                if match:
+                    self.store_type(line_no, "define", match.group(1))
+                    continue
+
+                match = re.match(r"^\s*typedef\s+([_\w][\w\d_]+)\s+(.*)\s+([_\w][\w\d_]+);",
+                                 line)
+                if match:
+                    name = match.group(2).strip()
+                    symbol = match.group(3)
+                    self.store_type(line_no, "typedef", symbol, ref_name=name)
+                    continue
+
+                for re_enum in self.RE_ENUMS:
+                    match = re_enum.match(line)
+                    if match:
+                        self.store_type(line_no, "enum", match.group(1))
+                        is_enum = True
+                        break
+
+                for re_struct in self.RE_STRUCTS:
+                    match = re_struct.match(line)
+                    if match:
+                        self.store_type(line_no, "struct", match.group(1))
+                        break
+
+        self.apply_exceptions()
+
+    def debug_print(self):
+        """
+        Print debug information containing the replacement rules per symbol.
+        To make easier to check, group them per type.
+        """
+        if not self.debug:
+            return
+
+        for c_type, refs in self.symbols.items():
+            if not refs:  # Skip empty dictionaries
+                continue
+
+            print(f"{c_type}:")
+
+            for symbol, (ref, ln) in sorted(refs.items()):
+                print(f"  #{ln:<5d} {symbol} -> {ref}")
+
+            print()
+
+    def gen_output(self):
+        """Write the formatted output to a file."""
+
+        # Avoid extra blank lines
+        text = re.sub(r"\s+$", "", self.data) + "\n"
+        text = re.sub(r"\n\s+\n", "\n\n", text)
+
+        # Escape Sphinx special characters
+        text = re.sub(r"([\_\`\*\<\>\&\\\\:\/\|\%\$\#\{\}\~\^])", r"\\\1", text)
+
+        # Source uAPI files may have special notes. Use bold font for them
+        text = re.sub(r"DEPRECATED", "**DEPRECATED**", text)
+
+        # Delimiters to catch the entire symbol after escaped
+        start_delim = r"([ \n\t\(=\*\@])"
+        end_delim = r"(\s|,|\\=|\\:|\;|\)|\}|\{)"
+
+        # Process all reference types
+        for ref_dict in self.symbols.values():
+            for symbol, (replacement, _) in ref_dict.items():
+                symbol = re.escape(re.sub(r"([\_\`\*\<\>\&\\\\:\/])", r"\\\1", symbol))
+                text = re.sub(fr'{start_delim}{symbol}{end_delim}',
+                              fr'\1{replacement}\2', text)
+
+        # Remove "\ " where not needed: before spaces and at the end of lines
+        text = re.sub(r"\\ ([\n ])", r"\1", text)
+        text = re.sub(r" \\ ", " ", text)
+
+        return text
+
+    def gen_toc(self):
+        """
+        Create a list of symbols to be part of a TOC contents table.
+        """
+        text = []
+
+        # Sort symbol types per description
+        symbol_descriptions = []
+        for k, v in self.DEF_SYMBOL_TYPES.items():
+            symbol_descriptions.append((v['description'], k))
+
+        symbol_descriptions.sort()
+
+        # Process each category
+        for description, c_type in symbol_descriptions:
+
+            refs = self.symbols[c_type]
+            if not refs:  # Skip empty categories
+                continue
+
+            text.append(f"{description}")
+            text.append("-" * len(description))
+            text.append("")
+
+            # Sort symbols alphabetically
+            for symbol, (ref, ln) in sorted(refs.items()):
+                text.append(f"- LINENO_{ln}: {ref}")
+
+            text.append("")  # Add empty line between categories
+
+        return "\n".join(text)
+
+    def write_output(self, file_in: str, file_out: str, toc: bool):
+        """
+        Write a ReST output file.
+        """
+
+        title = os.path.basename(file_in)
+
+        if toc:
+            text = self.gen_toc()
+        else:
+            text = self.gen_output()
+
+        with open(file_out, "w", encoding="utf-8", errors="backslashreplace") as f:
+            f.write(".. -*- coding: utf-8; mode: rst -*-\n\n")
+            f.write(f"{title}\n")
+            f.write("=" * len(title) + "\n\n")
+
+            if not toc:
+                f.write(".. parsed-literal::\n\n")
+
+            f.write(text)
diff --git a/scripts/lib/kdoc/python_version.py b/scripts/lib/kdoc/python_version.py
new file mode 100644
index 000000000000..4ddb7ead5f56
--- /dev/null
+++ b/scripts/lib/kdoc/python_version.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2017-2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+"""
+Handle Python version check logic.
+
+Not all Python versions are supported by scripts. Yet, on some cases,
+like during documentation build, a newer version of python could be
+available.
+
+This class allows checking if the minimal requirements are followed.
+
+Better than that, PythonVersion.check_python() not only checks the minimal
+requirements, but it automatically switches to a the newest available
+Python version if present.
+
+"""
+
+import os
+import re
+import subprocess
+import shlex
+import sys
+
+from glob import glob
+from textwrap import indent
+
+class PythonVersion:
+    """
+    Ancillary methods that checks for missing dependencies for different
+    types of types, like binaries, python modules, rpm deps, etc.
+    """
+
+    def __init__(self, version):
+        """
+        Ïnitialize self.version tuple from a version string.
+        """
+        self.version = self.parse_version(version)
+
+    @staticmethod
+    def parse_version(version):
+        """
+        Convert a major.minor.patch version into a tuple.
+        """
+        return tuple(int(x) for x in version.split("."))
+
+    @staticmethod
+    def ver_str(version):
+        """
+        Returns a version tuple as major.minor.patch.
+        """
+        return ".".join([str(x) for x in version])
+
+    @staticmethod
+    def cmd_print(cmd, max_len=80):
+        """
+        Outputs a command line, repecting maximum width.
+        """
+
+        cmd_line = []
+
+        for w in cmd:
+            w = shlex.quote(w)
+
+            if cmd_line:
+                if not max_len or len(cmd_line[-1]) + len(w) < max_len:
+                    cmd_line[-1] += " " + w
+                    continue
+                else:
+                    cmd_line[-1] += " \\"
+                    cmd_line.append(w)
+            else:
+                cmd_line.append(w)
+
+        return "\n  ".join(cmd_line)
+
+    def __str__(self):
+        """
+        Return a version tuple as major.minor.patch from self.version.
+        """
+        return self.ver_str(self.version)
+
+    @staticmethod
+    def get_python_version(cmd):
+        """
+        Get python version from a Python binary. As we need to detect if
+        are out there newer python binaries, we can't rely on sys.release here.
+        """
+
+        kwargs = {}
+        if sys.version_info < (3, 7):
+            kwargs['universal_newlines'] = True
+        else:
+            kwargs['text'] = True
+
+        result = subprocess.run([cmd, "--version"],
+                                stdout = subprocess.PIPE,
+                                stderr = subprocess.PIPE,
+                                **kwargs, check=False)
+
+        version = result.stdout.strip()
+
+        match = re.search(r"(\d+\.\d+\.\d+)", version)
+        if match:
+            return PythonVersion.parse_version(match.group(1))
+
+        print(f"Can't parse version {version}")
+        return (0, 0, 0)
+
+    @staticmethod
+    def find_python(min_version):
+        """
+        Detect if are out there any python 3.xy version newer than the
+        current one.
+
+        Note: this routine is limited to up to 2 digits for python3. We
+        may need to update it one day, hopefully on a distant future.
+        """
+        patterns = [
+            "python3.[0-9][0-9]",
+            "python3.[0-9]",
+        ]
+
+        python_cmd = []
+
+        # Seek for a python binary newer than min_version
+        for path in os.getenv("PATH", "").split(":"):
+            for pattern in patterns:
+                for cmd in glob(os.path.join(path, pattern)):
+                    if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
+                        version = PythonVersion.get_python_version(cmd)
+                        if version >= min_version:
+                            python_cmd.append((version, cmd))
+
+        return sorted(python_cmd, reverse=True)
+
+    @staticmethod
+    def check_python(min_version, show_alternatives=False, bail_out=False,
+                     success_on_error=False):
+        """
+        Check if the current python binary satisfies our minimal requirement
+        for Sphinx build. If not, re-run with a newer version if found.
+        """
+        cur_ver = sys.version_info[:3]
+        if cur_ver >= min_version:
+            ver = PythonVersion.ver_str(cur_ver)
+            return
+
+        python_ver = PythonVersion.ver_str(cur_ver)
+
+        available_versions = PythonVersion.find_python(min_version)
+        if not available_versions:
+            print(f"ERROR: Python version {python_ver} is not supported anymore\n")
+            print("       Can't find a new version. This script may fail")
+            return
+
+        script_path = os.path.abspath(sys.argv[0])
+
+        # Check possible alternatives
+        if available_versions:
+            new_python_cmd = available_versions[0][1]
+        else:
+            new_python_cmd = None
+
+        if show_alternatives and available_versions:
+            print("You could run, instead:")
+            for _, cmd in available_versions:
+                args = [cmd, script_path] + sys.argv[1:]
+
+                cmd_str = indent(PythonVersion.cmd_print(args), "  ")
+                print(f"{cmd_str}\n")
+
+        if bail_out:
+            msg = f"Python {python_ver} not supported. Bailing out"
+            if success_on_error:
+                print(msg, file=sys.stderr)
+                sys.exit(0)
+            else:
+                sys.exit(msg)
+
+        print(f"Python {python_ver} not supported. Changing to {new_python_cmd}")
+
+        # Restart script using the newer version
+        args = [new_python_cmd, script_path] + sys.argv[1:]
+
+        try:
+            os.execv(new_python_cmd, args)
+        except OSError as e:
+            sys.exit(f"Failed to restart with {new_python_cmd}: {e}")
diff --git a/scripts/lib/kdoc/xforms_lists.py b/scripts/lib/kdoc/xforms_lists.py
new file mode 100644
index 000000000000..6e917beceb89
--- /dev/null
+++ b/scripts/lib/kdoc/xforms_lists.py
@@ -0,0 +1,105 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2026: Mauro Carvalho Chehab <mchehab@kernel.org>.
+
+import re
+
+from kdoc.kdoc_re import CFunction, KernRe
+
+struct_args_pattern = r'([^,)]+)'
+
+class CTransforms:
+    """
+    Data class containing a long set of transformations to turn
+    structure member prefixes, and macro invocations and variables
+    into something we can parse and generate kdoc for.
+    """
+
+    #: Transforms for structs and unions
+    struct_xforms = [
+        (CFunction("__attribute__"), ' '),
+        (CFunction('__aligned'), ' '),
+        (CFunction('__counted_by'), ' '),
+        (CFunction('__counted_by_(le|be)'), ' '),
+        (CFunction('__guarded_by'), ' '),
+        (CFunction('__pt_guarded_by'), ' '),
+
+        (KernRe(r'\s*__packed\s*', re.S), ' '),
+        (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
+        (KernRe(r'\s*__private', re.S), ' '),
+        (KernRe(r'\s*__rcu', re.S), ' '),
+        (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
+        (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
+
+        (CFunction('__cacheline_group_(begin|end)'), ''),
+
+        (CFunction('struct_group'), r'\2'),
+        (CFunction('struct_group_attr'), r'\3'),
+        (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
+        (CFunction('__struct_group'), r'\4'),
+
+        (CFunction('__ETHTOOL_DECLARE_LINK_MODE_MASK'), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+        (CFunction('DECLARE_PHY_INTERFACE_MASK',), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+        (CFunction('DECLARE_BITMAP'), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+
+        (CFunction('DECLARE_HASHTABLE'), r'unsigned long \1[1 << ((\2) - 1)]'),
+        (CFunction('DECLARE_KFIFO'), r'\2 *\1'),
+        (CFunction('DECLARE_KFIFO_PTR'), r'\2 *\1'),
+        (CFunction('(?:__)?DECLARE_FLEX_ARRAY'), r'\1 \2[]'),
+        (CFunction('DEFINE_DMA_UNMAP_ADDR'), r'dma_addr_t \1'),
+        (CFunction('DEFINE_DMA_UNMAP_LEN'), r'__u32 \1'),
+        (CFunction('VIRTIO_DECLARE_FEATURES'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
+    ]
+
+    #: Transforms for function prototypes
+    function_xforms = [
+        (KernRe(r"^static +"), ""),
+        (KernRe(r"^extern +"), ""),
+        (KernRe(r"^asmlinkage +"), ""),
+        (KernRe(r"^inline +"), ""),
+        (KernRe(r"^__inline__ +"), ""),
+        (KernRe(r"^__inline +"), ""),
+        (KernRe(r"^__always_inline +"), ""),
+        (KernRe(r"^noinline +"), ""),
+        (KernRe(r"^__FORTIFY_INLINE +"), ""),
+        (KernRe(r"__init +"), ""),
+        (KernRe(r"__init_or_module +"), ""),
+        (KernRe(r"__deprecated +"), ""),
+        (KernRe(r"__flatten +"), ""),
+        (KernRe(r"__meminit +"), ""),
+        (KernRe(r"__must_check +"), ""),
+        (KernRe(r"__weak +"), ""),
+        (KernRe(r"__sched +"), ""),
+        (KernRe(r"_noprof"), ""),
+        (KernRe(r"__always_unused *"), ""),
+        (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
+        (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
+        (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
+        (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+        (KernRe(r"__no_context_analysis\s*"), ""),
+        (KernRe(r"__attribute_const__ +"), ""),
+
+        (CFunction("__cond_acquires"), ""),
+        (CFunction("__cond_releases"), ""),
+        (CFunction("__acquires"), ""),
+        (CFunction("__releases"), ""),
+        (CFunction("__must_hold"), ""),
+        (CFunction("__must_not_hold"), ""),
+        (CFunction("__must_hold_shared"), ""),
+        (CFunction("__cond_acquires_shared"), ""),
+        (CFunction("__acquires_shared"), ""),
+        (CFunction("__releases_shared"), ""),
+        (CFunction("__attribute__"), ""),
+    ]
+
+    #: Transforms for variables
+    var_xforms = [
+        (KernRe(r"__read_mostly"), ""),
+        (KernRe(r"__ro_after_init"), ""),
+        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
+        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
+        (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
+        (KernRe(r"(?://.*)$"), ""),
+        (KernRe(r"(?:/\*.*\*/)"), ""),
+        (KernRe(r";$"), ""),
+    ]
-- 
2.52.0


