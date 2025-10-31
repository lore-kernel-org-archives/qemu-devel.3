Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C74CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtuv-0003Jz-Ln; Fri, 31 Oct 2025 14:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEtut-0003JM-2d
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:32:03 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEtue-0005uT-04
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:31:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CBE12C0157;
 Fri, 31 Oct 2025 21:31:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UVld3d0Gj4Y0-etopZuYF; Fri, 31 Oct 2025 21:31:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761935492;
 bh=UhMiifSzE8VpldrM1dkSvTWfFrj4YgW6TUkb0IkBTvA=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=VbqO0cx6JlHIYKxm9PN7fNgMCYbklOpyOkxczsYuOD0ec5lXjsMr57x3ky6iqo6/m
 rv0yUVo44I/XEVzqWY18vNGo8OotBiplQUZDVLBYzrX9Knyi6jJk10EIe9+64aUJ4z
 PDDW7ZGFWYKyYPgF39FNNZ9MhsCtZjOzAJYE1s/c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: michael.roth@amd.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v5] qapi: Add documentation format validation
Date: Fri, 31 Oct 2025 21:31:29 +0300
Message-ID: <20251031183129.246814-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add explicit validation for QAPI documentation formatting rules:

1. Lines must not exceed 70 columns in width (including '# ' prefix)
2. Sentences must be separated by two spaces

Example sections and literal :: blocks (seldom case) are excluded, we
don't require them to be <= 70, that would be too restrictive. Anyway,
they share common 80-columns recommendations (not requirements).

Add two simple tests, illustrating the change.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all!

v5: - break "literal" block at any decreasing the indent,
      not only at no-indent
    - add two simple tests

This is based on
[PATCH 0/8] A QAPI schema doc markup fix, and style cleanup
Based-on: <20251031094751.2817932-1-armbru@redhat.com>

 scripts/qapi/parser.py                     | 52 +++++++++++++++++++++-
 tests/qapi-schema/doc-bad-long-line.err    |  1 +
 tests/qapi-schema/doc-bad-long-line.json   |  6 +++
 tests/qapi-schema/doc-bad-long-line.out    |  0
 tests/qapi-schema/doc-bad-whitespaces.err  |  2 +
 tests/qapi-schema/doc-bad-whitespaces.json |  6 +++
 tests/qapi-schema/doc-bad-whitespaces.out  |  0
 tests/qapi-schema/meson.build              |  2 +
 8 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 tests/qapi-schema/doc-bad-long-line.err
 create mode 100644 tests/qapi-schema/doc-bad-long-line.json
 create mode 100644 tests/qapi-schema/doc-bad-long-line.out
 create mode 100644 tests/qapi-schema/doc-bad-whitespaces.err
 create mode 100644 tests/qapi-schema/doc-bad-whitespaces.json
 create mode 100644 tests/qapi-schema/doc-bad-whitespaces.out

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9fbf80a541..ffb149850d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -108,6 +108,11 @@ def __init__(self,
         self.exprs: List[QAPIExpression] = []
         self.docs: List[QAPIDoc] = []
 
+        # State for tracking qmp-example blocks and simple
+        # :: literal blocks.
+        self._literal_mode = False
+        self._literal_mode_indent = 0
+
         # Showtime!
         self._parse()
 
@@ -423,12 +428,57 @@ def get_doc_line(self) -> Optional[str]:
             if self.val != '##':
                 raise QAPIParseError(
                     self, "junk after '##' at end of documentation comment")
+            self._literal_mode = False
             return None
         if self.val == '#':
             return ''
         if self.val[1] != ' ':
             raise QAPIParseError(self, "missing space after #")
-        return self.val[2:].rstrip()
+
+        line = self.val[2:].rstrip()
+
+        if re.match(r'(\.\. +qmp-example)? *::$', line):
+            self._literal_mode = True
+            self._literal_mode_indent = 0
+        elif self._literal_mode and line:
+            indent = re.match(r'^ *', line).end()
+            if self._literal_mode_indent == 0:
+                self._literal_mode_indent = indent
+            elif indent < self._literal_mode_indent:
+                # ReST directives stop at decreasing indentation
+                self._literal_mode = False
+
+        if not self._literal_mode:
+            self._validate_doc_line_format(line)
+
+        return line
+
+    def _validate_doc_line_format(self, line: str) -> None:
+        """
+        Validate documentation format rules for a single line:
+        1. Lines should not exceed 70 columns
+        2. Sentences should be separated by two spaces
+        """
+        full_line_length = len(line) + 2  # "# " = 2 characters
+        if full_line_length > 70:
+            # Skip URL lines - they can't be broken
+            if re.match(r' *(https?|ftp)://[^ ]*$', line):
+                pass
+            else:
+                raise QAPIParseError(
+                    self, "documentation line exceeds 70 columns"
+                )
+
+        single_space_pattern = r'(\be\.g\.|^ *\d\.|([.!?])) [A-Z0-9(]'
+        for m in list(re.finditer(single_space_pattern, line)):
+            if not m.group(2):
+                continue
+            # HACK so the error message points to the offending spot
+            self.pos = self.line_pos + 2 + m.start(2) + 1
+            raise QAPIParseError(
+                self, "Use two spaces between sentences\n"
+                "If this not the end of a sentence, please report the bug",
+            )
 
     @staticmethod
     def _match_at_name_colon(string: str) -> Optional[Match[str]]:
diff --git a/tests/qapi-schema/doc-bad-long-line.err b/tests/qapi-schema/doc-bad-long-line.err
new file mode 100644
index 0000000000..611a3b1fef
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-long-line.err
@@ -0,0 +1 @@
+doc-bad-long-line.json:4:1: documentation line exceeds 70 columns
diff --git a/tests/qapi-schema/doc-bad-long-line.json b/tests/qapi-schema/doc-bad-long-line.json
new file mode 100644
index 0000000000..d7f887694d
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-long-line.json
@@ -0,0 +1,6 @@
+##
+# @foo:
+#
+# This line has exactly 71 characters, including spaces and punctuation!
+##
+{ 'command': 'foo' }
diff --git a/tests/qapi-schema/doc-bad-long-line.out b/tests/qapi-schema/doc-bad-long-line.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-whitespaces.err b/tests/qapi-schema/doc-bad-whitespaces.err
new file mode 100644
index 0000000000..5cca1954c0
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-whitespaces.err
@@ -0,0 +1,2 @@
+doc-bad-whitespaces.json:4:48: Use two spaces between sentences
+If this not the end of a sentence, please report the bug
diff --git a/tests/qapi-schema/doc-bad-whitespaces.json b/tests/qapi-schema/doc-bad-whitespaces.json
new file mode 100644
index 0000000000..b0c318c670
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-whitespaces.json
@@ -0,0 +1,6 @@
+##
+# @foo:
+#
+# Sentences should be split by two whitespaces. But here is only one.
+##
+{ 'command': 'foo' }
diff --git a/tests/qapi-schema/doc-bad-whitespaces.out b/tests/qapi-schema/doc-bad-whitespaces.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c47025d16d..b24b27db21 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -61,8 +61,10 @@ schemas = [
   'doc-bad-event-arg.json',
   'doc-bad-feature.json',
   'doc-bad-indent.json',
+  'doc-bad-long-line.json',
   'doc-bad-symbol.json',
   'doc-bad-union-member.json',
+  'doc-bad-whitespaces.json',
   'doc-before-include.json',
   'doc-before-pragma.json',
   'doc-duplicate-features.json',
-- 
2.48.1


