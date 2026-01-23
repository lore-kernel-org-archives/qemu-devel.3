Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB790D74EE2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIpL-0002No-98; Fri, 23 Jan 2026 10:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInI-00072q-OV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInE-00030s-72
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so2016477f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180987; x=1769785787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zZSRW6WNJcEIE6bCFEC7d0OtJZfhOn3I22/VeIsAwlk=;
 b=R8M1Z5PWnvhz83VDaThD0hUJ1VPE8UAg9Y8o4aQ5peiZZT+winRan5oXO3EutRRz3u
 9rNvVPHi0kj8cr6TB4jK75Vqh8ycOLNSciBGjj1PhwYwb9XUpbhNMureXLvkHyAr0Nil
 JFAG+ut9W3BugC3HxC3+v5Zaikcd8ocJLNOBUspFsZZV11KghpBShnYjBLdadopiMmeG
 AuyafkDWz9OO9tdQfU3ZHMypP8ZBh4zY0GNcy+V4/8iZpbhPu2Z+F9tgtL9oGK9ToN1d
 cgvWMUS/pNHezDc307Hdf+sNldxOaADFoaGiyDiEJNOzs5AwcEYVmXaLfyNuVlFbcir2
 U9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180987; x=1769785787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zZSRW6WNJcEIE6bCFEC7d0OtJZfhOn3I22/VeIsAwlk=;
 b=NQt2+7Kyk26BI0+3Dn8cYBOjaxxMD9M6HlcXBE+00tbu85iKb33saHBQj8Ij4jzt3c
 09jEffBnFkCqOhLk8A0fKI1SUeb1kLExn5lClio79s8MW7kp7z5SmV7sP76b7M1msOpE
 S6k9Qtaoj3ffAgAeEo+44mYPVE3HhzzosjFo8ZWhmWQXM8ouUwWB7e2vJ996X+8eZynJ
 yW2Awc9EXEeUrM1f1rx5SBiEoebCKC9fkYnzNMvOsSlSuyzytIgywADFgWgCIv/fhcJ1
 L6yMKskDCvhQpBI1x1PQwL07g2PoT+5tpVLlwYFZTEYtQ/RSDnaoYu8hqdqZFolaAwgt
 F9mg==
X-Gm-Message-State: AOJu0YzjxF10egkGjd461/Mn90mFIiSvWPCTFszVI21nJXIANdzWZQIi
 Wk3PAd1/bwH+82zWpforslqj9P5yur1htE2W7Xgw4ImJcbvA2UvHVPk284hcEcP44nc/Vs6oWrJ
 epBq9Yqs=
X-Gm-Gg: AZuq6aLfoLORVDEMMdxFg1BGeyr75qssBb4N0tooje9gkYkOPS0ZjDDKPVyQBjkXWHG
 nGq2Hz1/+iLIsA9BVwHR9bpYIrcl+pUAx2h7HPvrsXBwR3jS9iTBnVUnoy2x9OEU4+6QsVAMP1K
 858XcOLTcXqJru6MXDFG0uNl1MjVC2yQ3awDYVkbEDA6mG7EQ4fCtTs1T8SkXD0CGkUKnfEkEkO
 BBZkp6rktHm7pM5XoVXPZ5JtqhcunFyaY4Z0gdxVb0FD8Etltx2sG3XF9NPSUMeVRmlC0cPrKbF
 M2jZCORHObq1cxl3zUsfRyCDbeI1rWlJ77aoMeCR06/wUdAKIpMaajufGOnZSr130c6MAlOyEqG
 nQY6exDDeUnu1f76cAgoRJdjKvZKhQJdQU/fnQitXounhaMs+ILOggLfeS4RptDghfArJaGUh+A
 z0JPj+TjMdoQvSMETsmj/m9uZaRadrUJsCsytpNrG7/zJoDEZoRLRLrxZ+CNDXBOs=
X-Received: by 2002:a05:6000:4210:b0:430:f437:5a6d with SMTP id
 ffacd0b85a97d-435b1594135mr5903437f8f.22.1769180985269; 
 Fri, 23 Jan 2026 07:09:45 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/22] kernel-doc.py: sync with upstream Kernel v6.19-rc4
Date: Fri, 23 Jan 2026 15:09:21 +0000
Message-ID: <20260123150941.1877768-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The changes here are aligned up to this Linux changeset:
	f64c7e113dc9 ("scripts: docs: kdoc_files.py: don't consider symlinks as directories")

On other words, everything that it is there, except for the
patch moving the library to tools/lib/python.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 54dec248994abf37c4b5b9e48d5ab8f0f8df6f2d.1767716928.git.mchehab+huawei@kernel.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/lib/kdoc/kdoc_files.py  |  11 +-
 scripts/lib/kdoc/kdoc_item.py   |   3 +-
 scripts/lib/kdoc/kdoc_output.py |  93 +++-
 scripts/lib/kdoc/kdoc_parser.py | 901 ++++++++++++++++----------------
 scripts/lib/kdoc/kdoc_re.py     |  24 +-
 5 files changed, 556 insertions(+), 476 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 9e09b45b02..85365cc316 100644
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -49,7 +49,7 @@ def _parse_dir(self, dirname):
             for entry in obj:
                 name = os.path.join(dirname, entry.name)
 
-                if entry.is_dir():
+                if entry.is_dir(follow_symlinks=False):
                     yield from self._parse_dir(name)
 
                 if not entry.is_file():
@@ -64,7 +64,7 @@ def _parse_dir(self, dirname):
 
     def parse_files(self, file_list, file_not_found_cb):
         """
-        Define an interator to parse all source files from file_list,
+        Define an iterator to parse all source files from file_list,
         handling directories if any
         """
 
@@ -229,7 +229,7 @@ def out_msg(self, fname, name, arg):
         Return output messages from a file name using the output style
         filtering.
 
-        If output type was not handled by the syler, return None.
+        If output type was not handled by the styler, return None.
         """
 
         # NOTE: we can add rules here to filter out unwanted parts,
@@ -275,7 +275,10 @@ def msg(self, enable_lineno=False, export=False, internal=False,
                 self.config.log.warning("No kernel-doc for file %s", fname)
                 continue
 
-            for arg in self.results[fname]:
+            symbols = self.results[fname]
+            self.out_style.set_symbols(symbols)
+
+            for arg in symbols:
                 m = self.out_msg(fname, arg.name, arg)
 
                 if m is None:
diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
index b3b2257645..19805301cb 100644
--- a/scripts/lib/kdoc/kdoc_item.py
+++ b/scripts/lib/kdoc/kdoc_item.py
@@ -5,8 +5,9 @@
 #
 
 class KdocItem:
-    def __init__(self, name, type, start_line, **other_stuff):
+    def __init__(self, name, fname, type, start_line, **other_stuff):
         self.name = name
+        self.fname = fname
         self.type = type
         self.declaration_start_line = start_line
         self.sections = {}
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 39fa872dfc..25de79ea6b 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -8,7 +8,7 @@
 Implement output filters to print kernel-doc documentation.
 
 The implementation uses a virtual base class (OutputFormat) which
-contains a dispatches to virtual methods, and some code to filter
+contains dispatches to virtual methods, and some code to filter
 out output messages.
 
 The actual implementation is done on one separate class per each type
@@ -59,7 +59,7 @@ class OutputFormat:
     OUTPUT_EXPORTED     = 2 # output exported symbols
     OUTPUT_INTERNAL     = 3 # output non-exported symbols
 
-    # Virtual member to be overriden at the  inherited classes
+    # Virtual member to be overridden at the inherited classes
     highlights = []
 
     def __init__(self):
@@ -85,7 +85,7 @@ def set_config(self, config):
     def set_filter(self, export, internal, symbol, nosymbol, function_table,
                    enable_lineno, no_doc_sections):
         """
-        Initialize filter variables according with the requested mode.
+        Initialize filter variables according to the requested mode.
 
         Only one choice is valid between export, internal and symbol.
 
@@ -208,13 +208,16 @@ def msg(self, fname, name, args):
             return self.data
 
         # Warn if some type requires an output logic
-        self.config.log.warning("doesn't now how to output '%s' block",
+        self.config.log.warning("doesn't know how to output '%s' block",
                                 dtype)
 
         return None
 
     # Virtual methods to be overridden by inherited classes
     # At the base class, those do nothing.
+    def set_symbols(self, symbols):
+        """Get a list of all symbols from kernel_doc"""
+
     def out_doc(self, fname, name, args):
         """Outputs a DOC block"""
 
@@ -577,6 +580,7 @@ def __init__(self, modulename):
 
         super().__init__()
         self.modulename = modulename
+        self.symbols = []
 
         dt = None
         tstamp = os.environ.get("KBUILD_BUILD_TIMESTAMP")
@@ -593,6 +597,69 @@ def __init__(self, modulename):
 
         self.man_date = dt.strftime("%B %Y")
 
+    def arg_name(self, args, name):
+        """
+        Return the name that will be used for the man page.
+
+        As we may have the same name on different namespaces,
+        prepend the data type for all types except functions and typedefs.
+
+        The doc section is special: it uses the modulename.
+        """
+
+        dtype = args.type
+
+        if dtype == "doc":
+            return self.modulename
+
+        if dtype in ["function", "typedef"]:
+            return name
+
+        return f"{dtype} {name}"
+
+    def set_symbols(self, symbols):
+        """
+        Get a list of all symbols from kernel_doc.
+
+        Man pages will uses it to add a SEE ALSO section with other
+        symbols at the same file.
+        """
+        self.symbols = symbols
+
+    def out_tail(self, fname, name, args):
+        """Adds a tail for all man pages"""
+
+        # SEE ALSO section
+        self.data += f'.SH "SEE ALSO"' + "\n.PP\n"
+        self.data += (f"Kernel file \\fB{args.fname}\\fR\n")
+        if len(self.symbols) >= 2:
+            cur_name = self.arg_name(args, name)
+
+            related = []
+            for arg in self.symbols:
+                out_name = self.arg_name(arg, arg.name)
+
+                if cur_name == out_name:
+                    continue
+
+                related.append(f"\\fB{out_name}\\fR(9)")
+
+            self.data += ",\n".join(related) + "\n"
+
+        # TODO: does it make sense to add other sections? Maybe
+        # REPORTING ISSUES? LICENSE?
+
+    def msg(self, fname, name, args):
+        """
+        Handles a single entry from kernel-doc parser.
+
+        Add a tail at the end of man pages output.
+        """
+        super().msg(fname, name, args)
+        self.out_tail(fname, name, args)
+
+        return self.data
+
     def output_highlight(self, block):
         """
         Outputs a C symbol that may require being highlighted with
@@ -618,7 +685,9 @@ def out_doc(self, fname, name, args):
         if not self.check_doc(name, args):
             return
 
-        self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        out_name = self.arg_name(args, name)
+
+        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
@@ -627,7 +696,9 @@ def out_doc(self, fname, name, args):
     def out_function(self, fname, name, args):
         """output function in man"""
 
-        self.data += f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
+        out_name = self.arg_name(args, name)
+
+        self.data += f'.TH "{name}" 9 "{out_name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -671,7 +742,9 @@ def out_function(self, fname, name, args):
             self.output_highlight(text)
 
     def out_enum(self, fname, name, args):
-        self.data += f'.TH "{self.modulename}" 9 "enum {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        out_name = self.arg_name(args, name)
+
+        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"enum {name} \\- {args['purpose']}\n"
@@ -703,8 +776,9 @@ def out_enum(self, fname, name, args):
     def out_typedef(self, fname, name, args):
         module = self.modulename
         purpose = args.get('purpose')
+        out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"typedef {name} \\- {purpose}\n"
@@ -717,8 +791,9 @@ def out_struct(self, fname, name, args):
         module = self.modulename
         purpose = args.get('purpose')
         definition = args.get('definition')
+        out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{args.type} {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"{args.type} {name} \\- {purpose}\n"
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 32b4356292..b2b790d6b8 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -22,8 +22,8 @@
 #
 # Regular expressions used to parse kernel-doc markups at KernelDoc class.
 #
-# Let's declare them in lowercase outside any class to make easier to
-# convert from the python script.
+# Let's declare them in lowercase outside any class to make it easier to
+# convert from the Perl script.
 #
 # As those are evaluated at the beginning, no need to cache them
 #
@@ -46,7 +46,7 @@
 known_section_names = 'description|context|returns?|notes?|examples?'
 known_sections = KernRe(known_section_names, flags = re.I)
 doc_sect = doc_com + \
-    KernRe(r'\s*(\@[.\w]+|\@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
+    KernRe(r'\s*(@[.\w]+|@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
            flags=re.I, cache=False)
 
 doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
@@ -54,13 +54,11 @@
 doc_inline_sect = KernRe(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=False)
 doc_inline_end = KernRe(r'^\s*\*/\s*$', cache=False)
 doc_inline_oneline = KernRe(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$', cache=False)
-attribute = KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
-               flags=re.I | re.S, cache=False)
 
 export_symbol = KernRe(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
 export_symbol_ns = KernRe(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
 
-type_param = KernRe(r"\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+type_param = KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
 
 #
 # Tests for the beginning of a kerneldoc block in its various forms.
@@ -74,6 +72,137 @@
                         r'(?:[-:].*)?$',		# description (not captured)
                         cache = False)
 
+#
+# Here begins a long set of transformations to turn structure member prefixes
+# and macro invocations into something we can parse and generate kdoc for.
+#
+struct_args_pattern = r'([^,)]+)'
+
+struct_xforms = [
+    # Strip attributes
+    (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
+    (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__packed\s*', re.S), ' '),
+    (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
+    (KernRe(r'\s*__private', re.S), ' '),
+    (KernRe(r'\s*__rcu', re.S), ' '),
+    (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
+    (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
+    (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
+    #
+    # Unwrap struct_group macros based on this definition:
+    # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
+    # which has variants like: struct_group(NAME, MEMBERS...)
+    # Only MEMBERS arguments require documentation.
+    #
+    # Parsing them happens on two steps:
+    #
+    # 1. drop struct group arguments that aren't at MEMBERS,
+    #    storing them as STRUCT_GROUP(MEMBERS)
+    #
+    # 2. remove STRUCT_GROUP() ancillary macro.
+    #
+    # The original logic used to remove STRUCT_GROUP() using an
+    # advanced regex:
+    #
+    #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
+    #
+    # with two patterns that are incompatible with
+    # Python re module, as it has:
+    #
+    #   - a recursive pattern: (?1)
+    #   - an atomic grouping: (?>...)
+    #
+    # I tried a simpler version: but it didn't work either:
+    #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
+    #
+    # As it doesn't properly match the end parenthesis on some cases.
+    #
+    # So, a better solution was crafted: there's now a NestedMatch
+    # class that ensures that delimiters after a search are properly
+    # matched. So, the implementation to drop STRUCT_GROUP() will be
+    # handled in separate.
+    #
+    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
+    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
+    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
+    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+    #
+    # Replace macros
+    #
+    # TODO: use NestedMatch for FOO($1, $2, ...) matches
+    #
+    # it is better to also move those to the NestedMatch logic,
+    # to ensure that parentheses will be properly matched.
+    #
+    (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
+     r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+    (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
+     r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+    (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+            re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+    (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+            re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
+    (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
+            r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+    (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
+            struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+    (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
+            struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
+    (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
+    (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+]
+#
+# Regexes here are guaranteed to have the end delimiter matching
+# the start delimiter. Yet, right now, only one replace group
+# is allowed.
+#
+struct_nested_prefixes = [
+    (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
+]
+
+#
+# Transforms for function prototypes
+#
+function_xforms  = [
+    (KernRe(r"^static +"), ""),
+    (KernRe(r"^extern +"), ""),
+    (KernRe(r"^asmlinkage +"), ""),
+    (KernRe(r"^inline +"), ""),
+    (KernRe(r"^__inline__ +"), ""),
+    (KernRe(r"^__inline +"), ""),
+    (KernRe(r"^__always_inline +"), ""),
+    (KernRe(r"^noinline +"), ""),
+    (KernRe(r"^__FORTIFY_INLINE +"), ""),
+    (KernRe(r"QEMU_[A-Z_]+ +"), ""),
+    (KernRe(r"__init +"), ""),
+    (KernRe(r"__init_or_module +"), ""),
+    (KernRe(r"__deprecated +"), ""),
+    (KernRe(r"__flatten +"), ""),
+    (KernRe(r"__meminit +"), ""),
+    (KernRe(r"__must_check +"), ""),
+    (KernRe(r"__weak +"), ""),
+    (KernRe(r"__sched +"), ""),
+    (KernRe(r"_noprof"), ""),
+    (KernRe(r"__always_unused *"), ""),
+    (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
+    (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
+    (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
+    (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+    (KernRe(r"__attribute_const__ +"), ""),
+    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
+]
+
+#
+# Apply a set of transforms to a block of text.
+#
+def apply_transforms(xforms, text):
+    for search, subst in xforms:
+        text = search.sub(subst, text)
+    return text
+
 #
 # A little helper to get rid of excess white space
 #
@@ -81,6 +210,21 @@
 def trim_whitespace(s):
     return multi_space.sub(' ', s.strip())
 
+#
+# Remove struct/enum members that have been marked "private".
+#
+def trim_private_members(text):
+    #
+    # First look for a "public:" block that ends a private region, then
+    # handle the "private until the end" case.
+    #
+    text = KernRe(r'/\*\s*private:.*?/\*\s*public:.*?\*/', flags=re.S).sub('', text)
+    text = KernRe(r'/\*\s*private:.*', flags=re.S).sub('', text)
+    #
+    # We needed the comments to do the above, but now we can take them out.
+    #
+    return KernRe(r'\s*/\*.*?\*/\s*', flags=re.S).sub('', text).strip()
+
 class state:
     """
     State machine enums
@@ -114,8 +258,9 @@ class state:
 
 class KernelEntry:
 
-    def __init__(self, config, ln):
+    def __init__(self, config, fname, ln):
         self.config = config
+        self.fname = fname
 
         self._contents = []
         self.prototype = ""
@@ -134,6 +279,8 @@ def __init__(self, config, ln):
 
         self.leading_space = None
 
+        self.fname = fname
+
         # State flags
         self.brcount = 0
         self.declaration_start_line = ln + 1
@@ -148,9 +295,11 @@ def contents(self):
         return '\n'.join(self._contents) + '\n'
 
     # TODO: rename to emit_message after removal of kernel-doc.pl
-    def emit_msg(self, log_msg, warning=True):
+    def emit_msg(self, ln, msg, *, warning=True):
         """Emit a message"""
 
+        log_msg = f"{self.fname}:{ln} {msg}"
+
         if not warning:
             self.config.log.info(log_msg)
             return
@@ -196,7 +345,7 @@ def dump_section(self, start_new=True):
                 # Only warn on user-specified duplicate section names
                 if name != SECTION_DEFAULT:
                     self.emit_msg(self.new_start_line,
-                                  f"duplicate section name '{name}'\n")
+                                  f"duplicate section name '{name}'")
                 # Treat as a new paragraph - add a blank line
                 self.sections[name] += '\n' + contents
             else:
@@ -210,6 +359,7 @@ def dump_section(self, start_new=True):
             self.section = SECTION_DEFAULT
             self._contents = []
 
+python_warning = False
 
 class KernelDoc:
     """
@@ -243,19 +393,23 @@ def __init__(self, config, fname):
         # We need Python 3.7 for its "dicts remember the insertion
         # order" guarantee
         #
-        if sys.version_info.major == 3 and sys.version_info.minor < 7:
+        global python_warning
+        if (not python_warning and
+            sys.version_info.major == 3 and sys.version_info.minor < 7):
+
             self.emit_msg(0,
                           'Python 3.7 or later is required for correct results')
+            python_warning = True
 
-    def emit_msg(self, ln, msg, warning=True):
+    def emit_msg(self, ln, msg, *, warning=True):
         """Emit a message"""
 
-        log_msg = f"{self.fname}:{ln} {msg}"
-
         if self.entry:
-            self.entry.emit_msg(log_msg, warning)
+            self.entry.emit_msg(ln, msg, warning=warning)
             return
 
+        log_msg = f"{self.fname}:{ln} {msg}"
+
         if warning:
             self.config.log.warning(log_msg)
         else:
@@ -277,7 +431,8 @@ def output_declaration(self, dtype, name, **args):
         The actual output and output filters will be handled elsewhere
         """
 
-        item = KdocItem(name, dtype, self.entry.declaration_start_line, **args)
+        item = KdocItem(name, self.fname, dtype,
+                        self.entry.declaration_start_line, **args)
         item.warnings = self.entry.warnings
 
         # Drop empty sections
@@ -300,7 +455,14 @@ def reset_state(self, ln):
         variables used by the state machine.
         """
 
-        self.entry = KernelEntry(self.config, ln)
+        #
+        # Flush the warnings out before we proceed further
+        #
+        if self.entry and self.entry not in self.entries:
+            for log_msg in self.entry.warnings:
+                self.config.log.warning(log_msg)
+
+        self.entry = KernelEntry(self.config, self.fname, ln)
 
         # State flags
         self.state = state.NORMAL
@@ -318,36 +480,26 @@ def push_parameter(self, ln, decl_type, param, dtype,
 
         param = KernRe(r'[\[\)].*').sub('', param, count=1)
 
-        if dtype == "" and param.endswith("..."):
-            if KernRe(r'\w\.\.\.$').search(param):
-                # For named variable parameters of the form `x...`,
-                # remove the dots
-                param = param[:-3]
-            else:
-                # Handles unnamed variable parameters
-                param = "..."
-
-            if param not in self.entry.parameterdescs or \
-                not self.entry.parameterdescs[param]:
-
-                self.entry.parameterdescs[param] = "variable arguments"
-
-        elif dtype == "" and (not param or param == "void"):
-            param = "void"
-            self.entry.parameterdescs[param] = "no arguments"
-
-        elif dtype == "" and param in ["struct", "union"]:
-            # Handle unnamed (anonymous) union or struct
-            dtype = param
-            param = "{unnamed_" + param + "}"
-            self.entry.parameterdescs[param] = "anonymous\n"
-            self.entry.anon_struct_union = True
-
-        # Handle cache group enforcing variables: they do not need
-        # to be described in header files
-        elif "__cacheline_group" in param:
-            # Ignore __cacheline_group_begin and __cacheline_group_end
-            return
+        #
+        # Look at various "anonymous type" cases.
+        #
+        if dtype == '':
+            if param.endswith("..."):
+                if len(param) > 3: # there is a name provided, use that
+                    param = param[:-3]
+                if not self.entry.parameterdescs.get(param):
+                    self.entry.parameterdescs[param] = "variable arguments"
+
+            elif (not param) or param == "void":
+                param = "void"
+                self.entry.parameterdescs[param] = "no arguments"
+
+            elif param in ["struct", "union"]:
+                # Handle unnamed (anonymous) union or struct
+                dtype = param
+                param = "{unnamed_" + param + "}"
+                self.entry.parameterdescs[param] = "anonymous\n"
+                self.entry.anon_struct_union = True
 
         # Warn if parameter has no description
         # (but ignore ones starting with # as these are not parameters
@@ -389,9 +541,6 @@ def create_parameter_list(self, ln, decl_type, args,
             args = arg_expr.sub(r"\1#", args)
 
         for arg in args.split(splitter):
-            # Strip comments
-            arg = KernRe(r'\/\*.*\*\/').sub('', arg)
-
             # Ignore argument attributes
             arg = KernRe(r'\sPOS0?\s').sub(' ', arg)
 
@@ -407,81 +556,76 @@ def create_parameter_list(self, ln, decl_type, args,
                 # Treat preprocessor directive as a typeless variable
                 self.push_parameter(ln, decl_type, arg, "",
                                     "", declaration_name)
-
+            #
+            # The pointer-to-function case.
+            #
             elif KernRe(r'\(.+\)\s*\(').search(arg):
-                # Pointer-to-function
-
                 arg = arg.replace('#', ',')
-
-                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
+                r = KernRe(r'[^\(]+\(\*?\s*'  # Everything up to "(*"
+                           r'([\w\[\].]*)'    # Capture the name and possible [array]
+                           r'\s*\)')	      # Make sure the trailing ")" is there
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_msg(ln, f"Invalid param: {arg}")
                     param = arg
-
-                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
-                self.push_parameter(ln, decl_type, param, dtype,
-                                    arg, declaration_name)
-
+                dtype = arg.replace(param, '')
+                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
+            #
+            # The array-of-pointers case.  Dig the parameter name out from the middle
+            # of the declaration.
+            #
             elif KernRe(r'\(.+\)\s*\[').search(arg):
-                # Array-of-pointers
-
-                arg = arg.replace('#', ',')
-                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                r = KernRe(r'[^\(]+\(\s*\*\s*'		# Up to "(" and maybe "*"
+                           r'([\w.]*?)'			# The actual pointer name
+                           r'\s*(\[\s*\w+\s*\]\s*)*\)') # The [array portion]
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_msg(ln, f"Invalid param: {arg}")
                     param = arg
-
-                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
-
-                self.push_parameter(ln, decl_type, param, dtype,
-                                    arg, declaration_name)
-
+                dtype = arg.replace(param, '')
+                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
             elif arg:
+                #
+                # Clean up extraneous spaces and split the string at commas; the first
+                # element of the resulting list will also include the type information.
+                #
                 arg = KernRe(r'\s*:\s*').sub(":", arg)
                 arg = KernRe(r'\s*\[').sub('[', arg)
-
                 args = KernRe(r'\s*,\s*').split(arg)
-                if args[0] and '*' in args[0]:
-                    args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
-
-                first_arg = []
-                r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
-                if args[0] and r.match(args[0]):
-                    args.pop(0)
-                    first_arg.extend(r.group(1))
-                    first_arg.append(r.group(2))
+                args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
+                #
+                # args[0] has a string of "type a".  If "a" includes an [array]
+                # declaration, we want to not be fooled by any white space inside
+                # the brackets, so detect and handle that case specially.
+                #
+                r = KernRe(r'^([^[\]]*\s+)(.*)$')
+                if r.match(args[0]):
+                    args[0] = r.group(2)
+                    dtype = r.group(1)
                 else:
-                    first_arg = KernRe(r'\s+').split(args.pop(0))
-
-                args.insert(0, first_arg.pop())
-                dtype = ' '.join(first_arg)
+                    # No space in args[0]; this seems wrong but preserves previous behavior
+                    dtype = ''
 
+                bitfield_re = KernRe(r'(.*?):(\w+)')
                 for param in args:
-                    if KernRe(r'^(\*+)\s*(.*)').match(param):
-                        r = KernRe(r'^(\*+)\s*(.*)')
-                        if not r.match(param):
-                            self.emit_msg(ln, f"Invalid param: {param}")
-                            continue
-
-                        param = r.group(1)
-
+                    #
+                    # For pointers, shift the star(s) from the variable name to the
+                    # type declaration.
+                    #
+                    r = KernRe(r'^(\*+)\s*(.*)')
+                    if r.match(param):
                         self.push_parameter(ln, decl_type, r.group(2),
                                             f"{dtype} {r.group(1)}",
                                             arg, declaration_name)
-
-                    elif KernRe(r'(.*?):(\w+)').search(param):
-                        r = KernRe(r'(.*?):(\w+)')
-                        if not r.match(param):
-                            self.emit_msg(ln, f"Invalid param: {param}")
-                            continue
-
+                    #
+                    # Perform a similar shift for bitfields.
+                    #
+                    elif bitfield_re.search(param):
                         if dtype != "":  # Skip unnamed bit-fields
-                            self.push_parameter(ln, decl_type, r.group(1),
-                                                f"{dtype}:{r.group(2)}",
+                            self.push_parameter(ln, decl_type, bitfield_re.group(1),
+                                                f"{dtype}:{bitfield_re.group(2)}",
                                                 arg, declaration_name)
                     else:
                         self.push_parameter(ln, decl_type, param, dtype,
@@ -520,13 +664,11 @@ def check_return_section(self, ln, declaration_name, return_type):
             self.emit_msg(ln,
                           f"No description found for return value of '{declaration_name}'")
 
-    def dump_struct(self, ln, proto):
-        """
-        Store an entry for an struct or union
-        """
-
+    #
+    # Split apart a structure prototype; returns (struct|union, name, members) or None
+    #
+    def split_struct_proto(self, proto):
         type_pattern = r'(struct|union)'
-
         qualifiers = [
             "__attribute__",
             "__packed",
@@ -534,288 +676,202 @@ def dump_struct(self, ln, proto):
             "____cacheline_aligned_in_smp",
             "____cacheline_aligned",
         ]
-
         definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
-        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
-
-        # Extract struct/union definition
-        members = None
-        declaration_name = None
-        decl_type = None
 
         r = KernRe(type_pattern + r'\s+(\w+)\s*' + definition_body)
         if r.search(proto):
-            decl_type = r.group(1)
-            declaration_name = r.group(2)
-            members = r.group(3)
+            return (r.group(1), r.group(2), r.group(3))
         else:
             r = KernRe(r'typedef\s+' + type_pattern + r'\s*' + definition_body + r'\s*(\w+)\s*;')
-
             if r.search(proto):
-                decl_type = r.group(1)
-                declaration_name = r.group(3)
-                members = r.group(2)
-
-        if not members:
-            self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
-            return
-
-        if self.entry.identifier != declaration_name:
-            self.emit_msg(ln,
-                          f"expecting prototype for {decl_type} {self.entry.identifier}. Prototype was for {decl_type} {declaration_name} instead\n")
-            return
-
-        args_pattern = r'([^,)]+)'
-
-        sub_prefixes = [
-            (KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | re.I), ''),
-            (KernRe(r'\/\*\s*private:.*', re.S | re.I), ''),
-
-            # Strip comments
-            (KernRe(r'\/\*.*?\*\/', re.S), ''),
-
-            # Strip attributes
-            (attribute, ' '),
-            (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-            (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-            (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-            (KernRe(r'\s*__packed\s*', re.S), ' '),
-            (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
-            (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
-            (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-
-            # Unwrap struct_group macros based on this definition:
-            # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
-            # which has variants like: struct_group(NAME, MEMBERS...)
-            # Only MEMBERS arguments require documentation.
-            #
-            # Parsing them happens on two steps:
-            #
-            # 1. drop struct group arguments that aren't at MEMBERS,
-            #    storing them as STRUCT_GROUP(MEMBERS)
-            #
-            # 2. remove STRUCT_GROUP() ancillary macro.
-            #
-            # The original logic used to remove STRUCT_GROUP() using an
-            # advanced regex:
-            #
-            #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
-            #
-            # with two patterns that are incompatible with
-            # Python re module, as it has:
-            #
-            #   - a recursive pattern: (?1)
-            #   - an atomic grouping: (?>...)
-            #
-            # I tried a simpler version: but it didn't work either:
-            #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
-            #
-            # As it doesn't properly match the end parenthesis on some cases.
-            #
-            # So, a better solution was crafted: there's now a NestedMatch
-            # class that ensures that delimiters after a search are properly
-            # matched. So, the implementation to drop STRUCT_GROUP() will be
-            # handled in separate.
-
-            (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-            (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-            (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-            (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
-
-            # Replace macros
-            #
-            # TODO: use NestedMatch for FOO($1, $2, ...) matches
-            #
-            # it is better to also move those to the NestedMatch logic,
-            # to ensure that parenthesis will be properly matched.
-
-            (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-            (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-            (KernRe(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-            (KernRe(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-            (KernRe(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
-            (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
-            (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\1 \2[]'),
-            (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-            (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S), r'__u32 \1'),
-            (KernRe(r'VIRTIO_DECLARE_FEATURES\s*\(' + args_pattern + r'\)', re.S), r'u64 \1; u64 \1_array[VIRTIO_FEATURES_DWORDS]'),
-        ]
-
-        # Regexes here are guaranteed to have the end limiter matching
-        # the start delimiter. Yet, right now, only one replace group
-        # is allowed.
-
-        sub_nested_prefixes = [
-            (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
-        ]
-
-        for search, sub in sub_prefixes:
-            members = search.sub(sub, members)
-
-        nested = NestedMatch()
-
-        for search, sub in sub_nested_prefixes:
-            members = nested.sub(search, sub, members)
-
-        # Keeps the original declaration as-is
-        declaration = members
-
-        # Split nested struct/union elements
-        #
-        # This loop was simpler at the original kernel-doc perl version, as
-        #   while ($members =~ m/$struct_members/) { ... }
-        # reads 'members' string on each interaction.
-        #
-        # Python behavior is different: it parses 'members' only once,
-        # creating a list of tuples from the first interaction.
+                return (r.group(1), r.group(3), r.group(2))
+        return None
+    #
+    # Rewrite the members of a structure or union for easier formatting later on.
+    # Among other things, this function will turn a member like:
+    #
+    #  struct { inner_members; } foo;
+    #
+    # into:
+    #
+    #  struct foo; inner_members;
+    #
+    def rewrite_struct_members(self, members):
         #
-        # On other words, this won't get nested structs.
+        # Process struct/union members from the most deeply nested outward.  The
+        # trick is in the ^{ below - it prevents a match of an outer struct/union
+        # until the inner one has been munged (removing the "{" in the process).
         #
-        # So, we need to have an extra loop on Python to override such
-        # re limitation.
-
-        while True:
-            tuples = struct_members.findall(members)
-            if not tuples:
-                break
-
+        struct_members = KernRe(r'(struct|union)'   # 0: declaration type
+                                r'([^\{\};]+)' 	    # 1: possible name
+                                r'(\{)'
+                                r'([^\{\}]*)'       # 3: Contents of declaration
+                                r'(\})'
+                                r'([^\{\};]*)(;)')  # 5: Remaining stuff after declaration
+        tuples = struct_members.findall(members)
+        while tuples:
             for t in tuples:
                 newmember = ""
-                maintype = t[0]
-                s_ids = t[5]
-                content = t[3]
-
-                oldmember = "".join(t)
-
-                for s_id in s_ids.split(','):
+                oldmember = "".join(t) # Reconstruct the original formatting
+                dtype, name, lbr, content, rbr, rest, semi = t
+                #
+                # Pass through each field name, normalizing the form and formatting.
+                #
+                for s_id in rest.split(','):
                     s_id = s_id.strip()
-
-                    newmember += f"{maintype} {s_id}; "
+                    newmember += f"{dtype} {s_id}; "
+                    #
+                    # Remove bitfield/array/pointer info, getting the bare name.
+                    #
                     s_id = KernRe(r'[:\[].*').sub('', s_id)
                     s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
-
+                    #
+                    # Pass through the members of this inner structure/union.
+                    #
                     for arg in content.split(';'):
                         arg = arg.strip()
-
-                        if not arg:
-                            continue
-
-                        r = KernRe(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)')
+                        #
+                        # Look for (type)(*name)(args) - pointer to function
+                        #
+                        r = KernRe(r'^([^\(]+\(\*?\s*)([\w.]*)(\s*\).*)')
                         if r.match(arg):
+                            dtype, name, extra = r.group(1), r.group(2), r.group(3)
                             # Pointer-to-function
-                            dtype = r.group(1)
-                            name = r.group(2)
-                            extra = r.group(3)
-
-                            if not name:
-                                continue
-
                             if not s_id:
                                 # Anonymous struct/union
                                 newmember += f"{dtype}{name}{extra}; "
                             else:
                                 newmember += f"{dtype}{s_id}.{name}{extra}; "
-
+                        #
+                        # Otherwise a non-function member.
+                        #
                         else:
-                            arg = arg.strip()
-                            # Handle bitmaps
+                            #
+                            # Remove bitmap and array portions and spaces around commas
+                            #
                             arg = KernRe(r':\s*\d+\s*').sub('', arg)
-
-                            # Handle arrays
                             arg = KernRe(r'\[.*\]').sub('', arg)
-
-                            # Handle multiple IDs
                             arg = KernRe(r'\s*,\s*').sub(',', arg)
-
+                            #
+                            # Look for a normal decl - "type name[,name...]"
+                            #
                             r = KernRe(r'(.*)\s+([\S+,]+)')
-
                             if r.search(arg):
-                                dtype = r.group(1)
-                                names = r.group(2)
+                                for name in r.group(2).split(','):
+                                    name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name)
+                                    if not s_id:
+                                        # Anonymous struct/union
+                                        newmember += f"{r.group(1)} {name}; "
+                                    else:
+                                        newmember += f"{r.group(1)} {s_id}.{name}; "
                             else:
                                 newmember += f"{arg}; "
-                                continue
-
-                            for name in names.split(','):
-                                name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
-
-                                if not name:
-                                    continue
-
-                                if not s_id:
-                                    # Anonymous struct/union
-                                    newmember += f"{dtype} {name}; "
-                                else:
-                                    newmember += f"{dtype} {s_id}.{name}; "
-
+                #
+                # At the end of the s_id loop, replace the original declaration with
+                # the munged version.
+                #
                 members = members.replace(oldmember, newmember)
+            #
+            # End of the tuple loop - search again and see if there are outer members
+            # that now turn up.
+            #
+            tuples = struct_members.findall(members)
+        return members
 
-        # Ignore other nested elements, like enums
-        members = re.sub(r'(\{[^\{\}]*\})', '', members)
-
-        self.create_parameter_list(ln, decl_type, members, ';',
-                                   declaration_name)
-        self.check_sections(ln, declaration_name, decl_type)
-
-        # Adjust declaration for better display
+    #
+    # Format the struct declaration into a standard form for inclusion in the
+    # resulting docs.
+    #
+    def format_struct_decl(self, declaration):
+        #
+        # Insert newlines, get rid of extra spaces.
+        #
         declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
         declaration = KernRe(r'\}\s+;').sub('};', declaration)
-
-        # Better handle inlined enums
-        while True:
-            r = KernRe(r'(enum\s+\{[^\}]+),([^\n])')
-            if not r.search(declaration):
-                break
-
+        #
+        # Format inline enums with each member on its own line.
+        #
+        r = KernRe(r'(enum\s+\{[^\}]+),([^\n])')
+        while r.search(declaration):
             declaration = r.sub(r'\1,\n\2', declaration)
-
+        #
+        # Now go through and supply the right number of tabs
+        # for each line.
+        #
         def_args = declaration.split('\n')
         level = 1
         declaration = ""
         for clause in def_args:
+            clause = KernRe(r'\s+').sub(' ', clause.strip(), count=1)
+            if clause:
+                if '}' in clause and level > 1:
+                    level -= 1
+                if not clause.startswith('#'):
+                    declaration += "\t" * level
+                declaration += "\t" + clause + "\n"
+                if "{" in clause and "}" not in clause:
+                    level += 1
+        return declaration
 
-            clause = clause.strip()
-            clause = KernRe(r'\s+').sub(' ', clause, count=1)
-
-            if not clause:
-                continue
-
-            if '}' in clause and level > 1:
-                level -= 1
 
-            if not KernRe(r'^\s*#').match(clause):
-                declaration += "\t" * level
+    def dump_struct(self, ln, proto):
+        """
+        Store an entry for a struct or union
+        """
+        #
+        # Do the basic parse to get the pieces of the declaration.
+        #
+        struct_parts = self.split_struct_proto(proto)
+        if not struct_parts:
+            self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
+            return
+        decl_type, declaration_name, members = struct_parts
 
-            declaration += "\t" + clause + "\n"
-            if "{" in clause and "}" not in clause:
-                level += 1
+        if self.entry.identifier != declaration_name:
+            self.emit_msg(ln, f"expecting prototype for {decl_type} {self.entry.identifier}. "
+                          f"Prototype was for {decl_type} {declaration_name} instead\n")
+            return
+        #
+        # Go through the list of members applying all of our transformations.
+        #
+        members = trim_private_members(members)
+        members = apply_transforms(struct_xforms, members)
 
+        nested = NestedMatch()
+        for search, sub in struct_nested_prefixes:
+            members = nested.sub(search, sub, members)
+        #
+        # Deal with embedded struct and union members, and drop enums entirely.
+        #
+        declaration = members
+        members = self.rewrite_struct_members(members)
+        members = re.sub(r'(\{[^\{\}]*\})', '', members)
+        #
+        # Output the result and we are done.
+        #
+        self.create_parameter_list(ln, decl_type, members, ';',
+                                   declaration_name)
+        self.check_sections(ln, declaration_name, decl_type)
         self.output_declaration(decl_type, declaration_name,
-                                definition=declaration,
+                                definition=self.format_struct_decl(declaration),
                                 purpose=self.entry.declaration_purpose)
 
     def dump_enum(self, ln, proto):
         """
         Stores an enum inside self.entries array.
         """
-
-        # Ignore members marked private
-        proto = KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', flags=re.S).sub('', proto)
-        proto = KernRe(r'\/\*\s*private:.*}', flags=re.S).sub('}', proto)
-
-        # Strip comments
-        proto = KernRe(r'\/\*.*?\*\/', flags=re.S).sub('', proto)
-
-        # Strip #define macros inside enums
+        #
+        # Strip preprocessor directives.  Note that this depends on the
+        # trailing semicolon we added in process_proto_type().
+        #
         proto = KernRe(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flags=re.S).sub('', proto)
-
         #
         # Parse out the name and members of the enum.  Typedef form first.
         #
         r = KernRe(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
         if r.search(proto):
             declaration_name = r.group(2)
-            members = r.group(1).rstrip()
+            members = trim_private_members(r.group(1))
         #
         # Failing that, look for a straight enum
         #
@@ -823,7 +879,7 @@ def dump_enum(self, ln, proto):
             r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
             if r.match(proto):
                 declaration_name = r.group(1)
-                members = r.group(2).rstrip()
+                members = trim_private_members(r.group(2))
         #
         # OK, this isn't going to work.
         #
@@ -867,7 +923,7 @@ def dump_enum(self, ln, proto):
         for k in self.entry.parameterdescs:
             if k not in member_set:
                 self.emit_msg(ln,
-                              f"Excess enum value '%{k}' description in '{declaration_name}'")
+                              f"Excess enum value '@{k}' description in '{declaration_name}'")
 
         self.output_declaration('enum', declaration_name,
                                 purpose=self.entry.declaration_purpose)
@@ -889,66 +945,34 @@ def dump_declaration(self, ln, prototype):
 
     def dump_function(self, ln, prototype):
         """
-        Stores a function of function macro inside self.entries array.
+        Stores a function or function macro inside self.entries array.
         """
 
-        func_macro = False
+        found = func_macro = False
         return_type = ''
         decl_type = 'function'
-
-        # Prefixes that would be removed
-        sub_prefixes = [
-            (r"^static +", "", 0),
-            (r"^extern +", "", 0),
-            (r"^asmlinkage +", "", 0),
-            (r"^inline +", "", 0),
-            (r"^__inline__ +", "", 0),
-            (r"^__inline +", "", 0),
-            (r"^__always_inline +", "", 0),
-            (r"^noinline +", "", 0),
-            (r"^__FORTIFY_INLINE +", "", 0),
-            (r"QEMU_[A-Z_]+ +", "", 0),
-            (r"__init +", "", 0),
-            (r"__init_or_module +", "", 0),
-            (r"__deprecated +", "", 0),
-            (r"__flatten +", "", 0),
-            (r"__meminit +", "", 0),
-            (r"__must_check +", "", 0),
-            (r"__weak +", "", 0),
-            (r"__sched +", "", 0),
-            (r"_noprof", "", 0),
-            (r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +", "", 0),
-            (r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +", "", 0),
-            (r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +", "", 0),
-            (r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)", r"\1, \2", 0),
-            (r"__attribute_const__ +", "", 0),
-
-            # It seems that Python support for re.X is broken:
-            # At least for me (Python 3.13), this didn't work
-#            (r"""
-#              __attribute__\s*\(\(
-#                (?:
-#                    [\w\s]+          # attribute name
-#                    (?:\([^)]*\))?   # attribute arguments
-#                    \s*,?            # optional comma at the end
-#                )+
-#              \)\)\s+
-#             """, "", re.X),
-
-            # So, remove whitespaces and comments from it
-            (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+", "", 0),
-        ]
-
-        for search, sub, flags in sub_prefixes:
-            prototype = KernRe(search, flags).sub(sub, prototype)
-
-        # Macros are a special case, as they change the prototype format
+        #
+        # Apply the initial transformations.
+        #
+        prototype = apply_transforms(function_xforms, prototype)
+        #
+        # If we have a macro, remove the "#define" at the front.
+        #
         new_proto = KernRe(r"^#\s*define\s+").sub("", prototype)
         if new_proto != prototype:
-            is_define_proto = True
             prototype = new_proto
-        else:
-            is_define_proto = False
+            #
+            # Dispense with the simple "#define A B" case here; the key
+            # is the space after the name of the symbol being defined.
+            # NOTE that the seemingly misnamed "func_macro" indicates a
+            # macro *without* arguments.
+            #
+            r = KernRe(r'^(\w+)\s+')
+            if r.search(prototype):
+                return_type = ''
+                declaration_name = r.group(1)
+                func_macro = True
+                found = True
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
@@ -966,91 +990,73 @@ def dump_function(self, ln, prototype):
         # - atomic_set (macro)
         # - pci_match_device, __copy_to_user (long return type)
 
-        name = r'[a-zA-Z0-9_~:]+'
-        prototype_end1 = r'[^\(]*'
-        prototype_end2 = r'[^\{]*'
-        prototype_end = fr'\(({prototype_end1}|{prototype_end2})\)'
-
-        # Besides compiling, Perl qr{[\w\s]+} works as a non-capturing group.
-        # So, this needs to be mapped in Python with (?:...)? or (?:...)+
-
+        name = r'\w+'
         type1 = r'(?:[\w\s]+)?'
         type2 = r'(?:[\w\s]+\*+)+'
-
-        found = False
-
-        if is_define_proto:
-            r = KernRe(r'^()(' + name + r')\s+')
-
-            if r.search(prototype):
-                return_type = ''
-                declaration_name = r.group(2)
-                func_macro = True
-
-                found = True
-
+        #
+        # Attempt to match first on (args) with no internal parentheses; this
+        # lets us easily filter out __acquires() and other post-args stuff.  If
+        # that fails, just grab the rest of the line to the last closing
+        # parenthesis.
+        #
+        proto_args = r'\(([^\(]*|.*)\)'
+        #
+        # (Except for the simple macro case) attempt to split up the prototype
+        # in the various ways we understand.
+        #
         if not found:
             patterns = [
-                rf'^()({name})\s*{prototype_end}',
-                rf'^({type1})\s+({name})\s*{prototype_end}',
-                rf'^({type2})\s*({name})\s*{prototype_end}',
+                rf'^()({name})\s*{proto_args}',
+                rf'^({type1})\s+({name})\s*{proto_args}',
+                rf'^({type2})\s*({name})\s*{proto_args}',
             ]
 
             for p in patterns:
                 r = KernRe(p)
-
                 if r.match(prototype):
-
                     return_type = r.group(1)
                     declaration_name = r.group(2)
                     args = r.group(3)
-
                     self.create_parameter_list(ln, decl_type, args, ',',
                                                declaration_name)
-
                     found = True
                     break
+        #
+        # Parsing done; make sure that things are as we expect.
+        #
         if not found:
             self.emit_msg(ln,
                           f"cannot understand function prototype: '{prototype}'")
             return
-
         if self.entry.identifier != declaration_name:
-            self.emit_msg(ln,
-                          f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
+            self.emit_msg(ln, f"expecting prototype for {self.entry.identifier}(). "
+                          f"Prototype was for {declaration_name}() instead")
             return
-
         self.check_sections(ln, declaration_name, "function")
-
         self.check_return_section(ln, declaration_name, return_type)
+        #
+        # Store the result.
+        #
+        self.output_declaration(decl_type, declaration_name,
+                                typedef=('typedef' in return_type),
+                                functiontype=return_type,
+                                purpose=self.entry.declaration_purpose,
+                                func_macro=func_macro)
 
-        if 'typedef' in return_type:
-            self.output_declaration(decl_type, declaration_name,
-                                    typedef=True,
-                                    functiontype=return_type,
-                                    purpose=self.entry.declaration_purpose,
-                                    func_macro=func_macro)
-        else:
-            self.output_declaration(decl_type, declaration_name,
-                                    typedef=False,
-                                    functiontype=return_type,
-                                    purpose=self.entry.declaration_purpose,
-                                    func_macro=func_macro)
 
     def dump_typedef(self, ln, proto):
         """
         Stores a typedef inside self.entries array.
         """
-
-        typedef_type = r'((?:\s+[\w\*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
+        #
+        # We start by looking for function typedefs.
+        #
+        typedef_type = r'typedef((?:\s+[\w*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
         typedef_ident = r'\*?\s*(\w\S+)\s*'
         typedef_args = r'\s*\((.*)\);'
 
-        typedef1 = KernRe(r'typedef' + typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
-        typedef2 = KernRe(r'typedef' + typedef_type + typedef_ident + typedef_args)
-
-        # Strip comments
-        proto = KernRe(r'/\*.*?\*/', flags=re.S).sub('', proto)
+        typedef1 = KernRe(typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
+        typedef2 = KernRe(typedef_type + typedef_ident + typedef_args)
 
         # Parse function typedef prototypes
         for r in [typedef1, typedef2]:
@@ -1066,21 +1072,16 @@ def dump_typedef(self, ln, proto):
                               f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
                 return
 
-            decl_type = 'function'
-            self.create_parameter_list(ln, decl_type, args, ',', declaration_name)
+            self.create_parameter_list(ln, 'function', args, ',', declaration_name)
 
-            self.output_declaration(decl_type, declaration_name,
+            self.output_declaration('function', declaration_name,
                                     typedef=True,
                                     functiontype=return_type,
                                     purpose=self.entry.declaration_purpose)
             return
-
-        # Handle nested parentheses or brackets
-        r = KernRe(r'(\(*.\)\s*|\[*.\]\s*);$')
-        while r.search(proto):
-            proto = r.sub('', proto)
-
-        # Parse simple typedefs
+        #
+        # Not a function, try to parse a simple typedef.
+        #
         r = KernRe(r'typedef.*\s+(\w+)\s*;')
         if r.match(proto):
             declaration_name = r.group(1)
@@ -1179,7 +1180,7 @@ def process_name(self, ln, line):
             #
             else:
                 self.emit_msg(ln,
-                              f"This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n{line}")
+                              f"This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst\n{line}")
                 self.state = state.NORMAL
                 return
             #
@@ -1263,7 +1264,7 @@ def is_comment_end(self, ln, line):
             self.dump_section()
 
             # Look for doc_com + <text> + doc_end:
-            r = KernRe(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
+            r = KernRe(r'\s*\*\s*[a-zA-Z_0-9:.]+\*/')
             if r.match(line):
                 self.emit_msg(ln, f"suspicious ending line: {line}")
 
@@ -1474,7 +1475,7 @@ def process_proto_function(self, ln, line):
         """Ancillary routine to process a function prototype"""
 
         # strip C99-style comments to end of line
-        line = KernRe(r"\/\/.*$", re.S).sub('', line)
+        line = KernRe(r"//.*$", re.S).sub('', line)
         #
         # Soak up the line's worth of prototype text, stopping at { or ; if present.
         #
diff --git a/scripts/lib/kdoc/kdoc_re.py b/scripts/lib/kdoc/kdoc_re.py
index 612223e1e7..2dfa1bf83d 100644
--- a/scripts/lib/kdoc/kdoc_re.py
+++ b/scripts/lib/kdoc/kdoc_re.py
@@ -16,7 +16,7 @@
 
 class KernRe:
     """
-    Helper class to simplify regex declaration and usage,
+    Helper class to simplify regex declaration and usage.
 
     It calls re.compile for a given pattern. It also allows adding
     regular expressions and define sub at class init time.
@@ -27,7 +27,7 @@ class KernRe:
 
     def _add_regex(self, string, flags):
         """
-        Adds a new regex or re-use it from the cache.
+        Adds a new regex or reuses it from the cache.
         """
         self.regex = re_cache.get(string, None)
         if not self.regex:
@@ -114,7 +114,7 @@ class NestedMatch:
 
             '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
 
-    which is used to properly match open/close parenthesis of the
+    which is used to properly match open/close parentheses of the
     string search STRUCT_GROUP(),
 
     Add a class that counts pairs of delimiters, using it to match and
@@ -136,13 +136,13 @@ class NestedMatch:
     #       \bSTRUCT_GROUP\(
     #
     # is similar to: STRUCT_GROUP\((.*)\)
-    # except that the content inside the match group is delimiter's aligned.
+    # except that the content inside the match group is delimiter-aligned.
     #
-    # The content inside parenthesis are converted into a single replace
+    # The content inside parentheses is converted into a single replace
     # group (e.g. r`\1').
     #
     # It would be nice to change such definition to support multiple
-    # match groups, allowing a regex equivalent to.
+    # match groups, allowing a regex equivalent to:
     #
     #   FOO\((.*), (.*), (.*)\)
     #
@@ -168,14 +168,14 @@ def _search(self, regex, line):
         but I ended using a different implementation to align all three types
         of delimiters and seek for an initial regular expression.
 
-        The algorithm seeks for open/close paired delimiters and place them
-        into a stack, yielding a start/stop position of each match  when the
+        The algorithm seeks for open/close paired delimiters and places them
+        into a stack, yielding a start/stop position of each match when the
         stack is zeroed.
 
-        The algorithm shoud work fine for properly paired lines, but will
-        silently ignore end delimiters that preceeds an start delimiter.
+        The algorithm should work fine for properly paired lines, but will
+        silently ignore end delimiters that precede a start delimiter.
         This should be OK for kernel-doc parser, as unaligned delimiters
-        would cause compilation errors. So, we don't need to rise exceptions
+        would cause compilation errors. So, we don't need to raise exceptions
         to cover such issues.
         """
 
@@ -203,7 +203,7 @@ def _search(self, regex, line):
                     stack.append(end)
                     continue
 
-                # Does the end delimiter match what it is expected?
+                # Does the end delimiter match what is expected?
                 if stack and d == stack[-1]:
                     stack.pop()
 
-- 
2.47.3


