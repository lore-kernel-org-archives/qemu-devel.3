Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52150CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnjn-0000EU-BA; Fri, 31 Oct 2025 07:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEnjQ-0008FN-VO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:55:51 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEnj9-0006HI-8m
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:55:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BF4FF80949;
 Fri, 31 Oct 2025 14:55:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JteCMd0FtqM0-ajlbdRpA; Fri, 31 Oct 2025 14:55:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761911720;
 bh=SwHuwFnOy0I3k3Cs0w00DYpDUa/PBuK5DTTs/Tdc+88=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=M0rS+/W7gJswzTG9P6OzEJjs7Af04XVQ4ZhRkA6TF+uIt3ycV8IfLRCu0Dswf9Lc8
 7gaUAT6EWCMm9zhm/795ovPlFQHyac+aUEB4h9cL9TFkUuc7tJnSYrdUG/VPObcvOO
 oSaiDuqN66hHGlF222tgU6WHyiURd27deMWwQFfw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: michael.roth@amd.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v4] qapi: Add documentation format validation
Date: Fri, 31 Oct 2025 14:55:17 +0300
Message-ID: <20251031115517.79032-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all!

v4: apply suggestions by Markus:
 - smart regexps
 - simpler error messages
 - hack to move cursor at the place of error
 - support :: blocks

This is based on
[PATCH 0/8] A QAPI schema doc markup fix, and style cleanup
Based-on: <20251031094751.2817932-1-armbru@redhat.com>

 scripts/qapi/parser.py | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9fbf80a541..2c244a3608 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -108,6 +108,10 @@ def __init__(self,
         self.exprs: List[QAPIExpression] = []
         self.docs: List[QAPIDoc] = []
 
+        # State for tracking qmp-example blocks and simple
+        # :: literal blocks.
+        self._literal_mode = False
+
         # Showtime!
         self._parse()
 
@@ -423,12 +427,50 @@ def get_doc_line(self) -> Optional[str]:
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
+        elif self._literal_mode and line and not line.startswith(' '):
+            # ReST directives stop at first non-blank non-indented line
+            self._literal_mode = False
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
+                 self, "Use two spaces between sentences")
 
     @staticmethod
     def _match_at_name_colon(string: str) -> Optional[Match[str]]:
-- 
2.48.1


