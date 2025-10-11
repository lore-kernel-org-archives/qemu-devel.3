Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A5BCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a70-00061A-UC; Sat, 11 Oct 2025 09:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a6x-00060w-W5
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:16 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a6r-0004cN-Cs
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 666D4C0193;
 Sat, 11 Oct 2025 16:57:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-V3WhyNtC; Sat, 11 Oct 2025 16:57:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191077;
 bh=sM4YrvUNO+2zghtH3aLu00wsMr94BOpnclkexE7YIug=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hAw6yIMPaMEPLtOYm+bIhh+ZtNH2iwUkeRmw+iEQ/9+s8JRYkYhdVdvd8rxG7IZVn
 hiheKZStbSbjqYrBGlbmfJTG3eQTafOsn0bMWY1XEDtiX4zyco8qt1W8DHgGXDOZRu
 VGgatDdKiKJBMGCD0HSUDhj7r1U0jhWE01EuKDQg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 01/33] qapi: Add documentation format validation
Date: Sat, 11 Oct 2025 16:56:42 +0300
Message-ID: <20251011135754.294521-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 scripts/qapi/parser.py | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9fbf80a541..2c76686fc4 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -428,7 +428,44 @@ def get_doc_line(self) -> Optional[str]:
             return ''
         if self.val[1] != ' ':
             raise QAPIParseError(self, "missing space after #")
-        return self.val[2:].rstrip()
+
+        line = self.val[2:].rstrip()
+
+        self._validate_doc_line_format(line)
+
+        return line
+
+    def _validate_doc_line_format(self, line: str) -> None:
+        """
+        Validate documentation format rules for a single line:
+        1. Lines should not exceed 70 columns
+        2. Sentences should be separated by two spaces
+        """
+        # Check 70-column width rule
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


