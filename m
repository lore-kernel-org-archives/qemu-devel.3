Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D24CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 12:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruWth-00017w-0C; Wed, 10 Apr 2024 08:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1ruWtd-00017m-Rn
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:17:45 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1ruWta-0003db-LE
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:17:45 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4VF1zr0ntxz8PbP;
 Wed, 10 Apr 2024 08:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=date:from
 :to:cc:subject:message-id:mime-version:content-type; s=default;
 bh=mjomqxX4kZsqTBWrRGONlduxXGQ=; b=VrLbV6vO9UBPNAGEu9e9i/f8QLwv
 xYWIw3SYBMPTZIp18DfwaUjPz0jwXRHXF0k4tt8+Pie/ljxR9aSiITYoC7FbPL0j
 zuhtR+V69+J3zVH4YYK6Q/mCjq80vowRchChSrXlYoV8KvzfBdR/aWJXIBYKSOH1
 WH1TV9mdZa8byEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=CyCFJEUdbn7uKrHmZum/CTJ0hkr+KggUaocpYPyRFHbjvHeXCr9JS
 azJC5F3YniQLz/E8AbNs59fNI3KAeDETHp2S65HxQ2QVN+VbVSX/KYhSUMBkZFBc
 3C14FkK6H/VuRrZYbPIw/svbN0jbkkHfajt4S6nJbmRrhOAgMFtFX0=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:6a28:68e1:b56c:66b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4VF1zq5rhDz8PbN;
 Wed, 10 Apr 2024 08:17:27 -0400 (EDT)
Date: Wed, 10 Apr 2024 08:17:26 -0400
From: Brad Smith <brad@comstyle.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH] tests/vm: update openbsd image to 7.5
Message-ID: <ZhaDVpNjq_ZifvPT@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

tests/vm: update openbsd to release 7.5

Signed-off-by: Brad Smith <brad@comstyle.com>
---
This exposes a further issue with Clang 16 and
the ROP exploits flag usage at the moment..

https://gitlab.com/qemu-project/qemu/-/issues/2278

 tests/vm/openbsd | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 85c9863633..5e646f7c51 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.4/amd64/install74.iso"
-    csum = "a1001736ed9fe2307965b5fcdb426ae11f9b80d26eb21e404a705144a0a224a0"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.5/amd64/install75.iso"
+    csum = "034435c6e27405d5a7fafb058162943c194eb793dafdc412c08d49bb56b3892a"
     size = "20G"
     pkgs = [
         # tools
@@ -124,7 +124,7 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait_send("Allow root ssh login",    "yes\n")
         self.console_wait_send("timezone",                "UTC\n")
         self.console_wait_send("root disk",               "\n")
-        self.console_wait_send("Encrypt the root disk with a passphrase", "no\n")
+        self.console_wait_send("Encrypt the root disk with a (p)assphrase", "no\n")
         self.console_wait_send("(W)hole disk",            "\n")
         self.console_wait_send("(A)uto layout",           "c\n")
 
-- 
2.44.0


