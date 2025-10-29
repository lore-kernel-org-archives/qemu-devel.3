Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521E7CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA1D-0001Fz-6L; Wed, 29 Oct 2025 13:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEA19-0001Dr-Fb
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:31:27 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEA12-0002Xp-0h
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:31:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4DFCEC0122;
 Wed, 29 Oct 2025 20:31:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:842::1:3a])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1Vi5X50FDW20-sTuDMZTE; Wed, 29 Oct 2025 20:31:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761759061;
 bh=f5MHWZjzxmQpPW1w2m9n4SbY19rufB/FUYtbPgZ0ooA=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=nLQYN9+Y7Ior7vi/j2G7fmNJxpNozDj1xr2kY+oBGoTMFPfA6r+6vt7weMN0rHSeU
 qjKz2MJ12jL8zHuru2971uE3o2Kh0Afx09P0dP5Y6QG1kzBE8jkNZSdlLVBSAE0Y6d
 wq/IiBrz3DPk8YQh6j9a5vAm1pIS5Z7tg6uk5OWo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: michael.roth@amd.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v3] qapi: Add documentation format validation
Date: Wed, 29 Oct 2025 20:30:59 +0300
Message-ID: <20251029173059.378607-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Example sections are excluded, we don't require them to be <= 70,
that would be too restrictive.

Example sections share common 80-columns recommendations (not
requirements).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all!

This substitutes my previous attempt
  "[PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences"
Supersedes: <20251011140441.297246-1-vsementsov@yandex-team.ru>

v3:
01: ignore example sections
other commits: dropped :)

Of course, this _does not_ build on top of current master. v3 is
to be based on top of coming soon doc-cleanup series by Markus.

 scripts/qapi/parser.py | 46 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9fbf80a541..b9d76fff39 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -108,6 +108,9 @@ def __init__(self,
         self.exprs: List[QAPIExpression] = []
         self.docs: List[QAPIDoc] = []
 
+        # State for tracking qmp-example blocks
+        self._in_qmp_example = False
+
         # Showtime!
         self._parse()
 
@@ -423,12 +426,53 @@ def get_doc_line(self) -> Optional[str]:
             if self.val != '##':
                 raise QAPIParseError(
                     self, "junk after '##' at end of documentation comment")
+            self._in_qmp_example = False
             return None
         if self.val == '#':
             return ''
         if self.val[1] != ' ':
             raise QAPIParseError(self, "missing space after #")
-        return self.val[2:].rstrip()
+
+        line = self.val[2:].rstrip()
+
+        if line.startswith('.. qmp-example::'):
+            self._in_qmp_example = True
+
+        if not self._in_qmp_example:
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
+            stripped_line = line.strip()
+            if (stripped_line.startswith(('http://', 'https://', 'ftp://')) and
+                ' ' not in stripped_line):
+                pass
+            else:
+                raise QAPIParseError(
+                    self, f"documentation line exceeds 70 columns "
+                    f"({full_line_length} columns): {line[:50]}..."
+                )
+
+        single_space_pattern = r'[.!?] [A-Z0-9]'
+        for m in list(re.finditer(single_space_pattern, line)):
+            left = line[0:m.start() + 1]
+            # Ignore abbreviations and numbered lists
+            if left.endswith('e.g.') or re.fullmatch(r' *\d\.', left):
+                continue
+            raise QAPIParseError(
+                 self, f"documentation has single space after sentence "
+                 f"ending. Use two spaces between sentences: "
+                 f"...{line[m.start()-5:m.end()+5]}..."
+            )
 
     @staticmethod
     def _match_at_name_colon(string: str) -> Optional[Match[str]]:
-- 
2.48.1


