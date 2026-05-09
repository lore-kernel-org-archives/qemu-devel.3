Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F8CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 09:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLeIh-0000Hx-6G; Sat, 09 May 2026 05:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@uchout.moe>) id 1wLeIg-0000Hp-0j
 for qemu-devel@nongnu.org; Sat, 09 May 2026 05:48:46 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@uchout.moe>) id 1wLeIe-0002K3-Ap
 for qemu-devel@nongnu.org; Sat, 09 May 2026 05:48:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1778320113; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=f7noN0AlkqF5VsK5jW9xKyaS5hUoNdt1Lf7QuSuncIiEe2hsH2zWesS9NQo5UQu5VxKyrEtbYa2rCFR2UW5LlZeTDN6TSoBN737hlBcpxOTGvyprMz8rwySqdjogvC6/44Nbym0kjRUXK/mql6QWtm+r9ZPp7yVZBJJYXbsZqbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778320113;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=g7UzUMU7Hoix1F4/XlEH6P/E78ekdB61P+kZ54NWkWA=; 
 b=hUeL52rGHxMarW26A3bsEhXiN3vzf8Bv+PMs+q5/r+mozojkbzjnUjBD9ytg81+xJWMIarwqFpDgEAMK2dLLfr4p1SCypsGqZ/X8IP1Jmqel95wTnECtIbNZcdvVVSkxoCz1mcHbmszPKowWA3URc/QFHSiWyvNpc/sHsriIyP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=uchout.moe;
 spf=pass  smtp.mailfrom=i@uchout.moe;
 dmarc=pass header.from=<i@uchout.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778320113; 
 s=zmail; d=uchout.moe; i=i@uchout.moe;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=g7UzUMU7Hoix1F4/XlEH6P/E78ekdB61P+kZ54NWkWA=;
 b=bL8Sw7Klt44qb1GSruAA0U1ND0TRIyiPTG4bHobNk9xTIDOx0apTi8tqE6CBDcD1
 7bGgCZGoNN0JYRIN70EmNpzziRx9DeZ0KcRYck3fBIWJWJPaZdL1F1PVlOokTpjrCHT
 rxJhziQtTUREzgZn0dIxXLu8i6ugH3HbaWvFnwlc=
Received: by mx.zohomail.com with SMTPS id 1778320111830126.54014503254109;
 Sat, 9 May 2026 02:48:31 -0700 (PDT)
From: uchouT <i@uchout.moe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 uchouT <i@uchout.moe>
Subject: [PATCH] qemu-options: document -chardev dbus
Date: Sat,  9 May 2026 17:48:01 +0800
Message-ID: <20260509094801.111103-1-i@uchout.moe>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=i@uchout.moe;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Document the dbus backend introduced in commit 3e301c8d7ef0 ("ui/dbus:
add chardev backend & interface")

Signed-off-by: uchouT <i@uchout.moe>
---
 qemu-options.hx | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5566da41a3..59ff62aa7b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4077,6 +4077,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
 #if defined(CONFIG_SPICE)
     "-chardev spicevmc,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
     "-chardev spiceport,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
+#endif
+#if defined(CONFIG_DBUS_DISPLAY)
+    "-chardev dbus,id=id,name=name[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
 #endif
     , QEMU_ARCH_ALL
 )
@@ -4088,8 +4091,8 @@ The general form of a character device option is:
     Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``hub``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
-    ``spicevmc``, ``spiceport``. The specific backend will determine the
-    applicable options.
+    ``spicevmc``, ``spiceport``, ``dbus``. The specific backend will
+    determine the applicable options.
 
     Use ``-chardev help`` to print all available chardev backend types.
 
@@ -4396,6 +4399,15 @@ The available backends are:
 
     Connect to a spice port, allowing a Spice client to handle the
     traffic identified by a name (preferably a fqdn).
+
+``-chardev dbus,id=id,name=name``
+    ``dbus`` is only available when D-Bus display support is built in.
+
+    ``name`` name of the chardev as exported on the D-Bus display
+    interface
+
+    Export the character device on the D-Bus display interface, so that
+    a D-Bus client can connect to it.
 ERST
 
 DEFHEADING()
-- 
2.54.0


