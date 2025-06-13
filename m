Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D107BC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ7Ls-00076M-6L; Fri, 13 Jun 2025 12:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7Lb-0006te-Ef
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:33:46 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQ7LY-0005Iu-Nq
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749832417;
 bh=4fGj5rVwW6MUVvCdGIWAv/+R6GQKpiJ3T++WbBrx4lU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SOQiaZ0zF2hISybKVSFALXRC6EDG/E9iiSlBq5WQ68pLoK7VGFz0MLy588Ke+Hrd4
 9m3qYUGwwafhX5tX2uN9KwJ9wynKaTGlP5eJkcgx+Nc0oshXuIi8FAzB7W+iY4kzd/
 fu6zp2S6ybp3aOaw4hQQjblCZCLpMTVcmJfezXIQFtFy5492BkkxTVWtafK8YBfy5R
 SB57iGYwKz7vOhcDD78Gn5zWoWfH+khlMINYly4jt3yOCRrV7+abua2qSQ3j396AcE
 XhO014+GhsOTPjdeyA75vMBqUkDHaBdw6l5HtRWMN+9dHQIGarXQPTpY+4l1Ygd5Ha
 Gs/CDoMTmJhOg==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id B71E654C8;
 Sat, 14 Jun 2025 00:33:35 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 01/12] COPYING: replace FSF postal address with licenses URL
Date: Fri, 13 Jun 2025 12:33:10 -0400
Message-ID: <20250613.qemu.patch.01@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.patch@sean.taipei>
References: <20250613.qemu.patch@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The license text in COPYING (GPLv2), COPYING.LIB (LGPLv2.1),
and the linux-headers/LICENSES/preferred/GPL-2.0 file are
referenced to the obsolete FSF postal address.

Replace it with the canonical GNU licenses URL recommended by the FSF:
https://www.gnu.org/licenses/

Signed-off-by: Sean Wei <me@sean.taipei>
---
 COPYING                                  | 5 ++---
 COPYING.LIB                              | 5 ++---
 linux-headers/LICENSES/preferred/GPL-2.0 | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/COPYING b/COPYING
index 00ccfbb628..8095135d50 100644
--- a/COPYING
+++ b/COPYING
@@ -2,7 +2,7 @@
 		       Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -304,8 +304,7 @@ the "copyright" line and a pointer to where the full notice is found.
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+    with this program; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
diff --git a/COPYING.LIB b/COPYING.LIB
index 4362b49151..99f47575b5 100644
--- a/COPYING.LIB
+++ b/COPYING.LIB
@@ -2,7 +2,7 @@
                        Version 2.1, February 1999
 
  Copyright (C) 1991, 1999 Free Software Foundation, Inc.
- 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -484,8 +484,7 @@ convey the exclusion of warranty; and each file should have at least the
     Lesser General Public License for more details.
 
     You should have received a copy of the GNU Lesser General Public
-    License along with this library; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+    License along with this library; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
diff --git a/linux-headers/LICENSES/preferred/GPL-2.0 b/linux-headers/LICENSES/preferred/GPL-2.0
index ff0812fd89..10248a619e 100644
--- a/linux-headers/LICENSES/preferred/GPL-2.0
+++ b/linux-headers/LICENSES/preferred/GPL-2.0
@@ -21,7 +21,7 @@ License-Text:
 		       Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -323,8 +323,7 @@ the "copyright" line and a pointer to where the full notice is found.
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+    along with this program; if not, see <https://www.gnu.org/licenses/>.
 
 
 Also add information on how to contact you by electronic and paper mail.
-- 
2.49.0


