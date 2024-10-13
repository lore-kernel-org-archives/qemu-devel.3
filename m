Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB963CF258A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 03:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szpPA-0004Tj-Mc; Sat, 12 Oct 2024 23:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1szpP9-0004Ta-Cy
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 23:36:27 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1szpP7-0001jR-HT
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 23:36:26 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4XR5cm0j9Qz8PbP;
 Sat, 12 Oct 2024 23:36:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=xbJ42RmzPDrLEX3CPLu7c+medhLyz95NDX9mXPlq1nY=; b=AQoB
 61bF2EpJm646qKCZscR7s8bTu88iQKC0BFfVK0VwsyFzzL/4BweQ0PFNAMTmA0Cf
 VuwAGYd0giq9Vr1uczeZxew9XDXMRCloA/IUbcXkvbP1kMnwJFT+IBVcYcoaINdw
 kV7px21XPJqN9cDiSLXR5PnWvby7KkCtLJiaDJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=IkA/pO6P3YhGX/pqF1AviEQpNkaPiNjRfLEjwRgaU2Tvs8+56XhRs
 etnchsYfGezJsmItdy3pSzTTujyrom41MHTN2LFvawEg0Ol2wKGIzxvq4QiMRF45
 C3+gyexs4V3Y4qq3Hvs/Er71O77v3EwVV/outn1ovt6Q2CsOsJ6bKE=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:efaf:e9b3:ec5e:48c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4XR5cl5dhnz8PbN;
 Sat, 12 Oct 2024 23:36:23 -0400 (EDT)
Date: Sat, 12 Oct 2024 23:36:22 -0400
From: Brad Smith <brad@comstyle.com>
To: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Alex Benn_e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] tests/vm: update openbsd image to 7.6
Message-ID: <ZwtANoy5IzByoQgU@humpty.home.comstyle.com>
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

tests/vm: update openbsd image to 7.6

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 tests/vm/openbsd | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 49cab08782..dfd11c93f0 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.5/amd64/install75.iso"
-    csum = "034435c6e27405d5a7fafb058162943c194eb793dafdc412c08d49bb56b3892a"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
+    csum = "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
     size = "20G"
     pkgs = [
         # tools
@@ -32,7 +32,6 @@ class OpenBSDVM(basevm.BaseVM):
         "pkgconf",
         "bzip2", "xz",
         "ninja",
-        "py3-tomli",
 
         # gnu tools
         "bash",
@@ -160,6 +159,7 @@ class OpenBSDVM(basevm.BaseVM):
 
         self.print_step("Installation started now, this will take a while")
         self.console_wait_send("Location of sets",        "done\n")
+        self.console_wait_send("Time appears wrong.  Set to", "\n")
 
         self.console_wait("successfully completed")
         self.print_step("Installation finished, rebooting")
-- 
2.46.1


