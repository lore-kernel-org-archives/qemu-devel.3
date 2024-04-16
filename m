Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EEDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiPB-0007Gy-Vu; Tue, 16 Apr 2024 08:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1rwh2K-0001ny-Tf
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:31:40 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1rwh2H-0007On-IF
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peterdavehello.org;
 s=protonmail; t=1713267093; x=1713526293;
 bh=jB+DsHeLKsoztsHH3i8WfLOpjDZzFWljYEOKwLTu6rw=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=V36zoBvSYPzdmxoyWW1R7ZF8k1VgfCFdTjSkwiqXTot1ySmMIuaZI/nAGloQ2K25J
 cjAiwTyWP5ZbWBJke7C6aja+4pxh0nG6fBYLbIVbRurziw3ijsDcxaQhh0i5iXAhqi
 ZpjND/yZIwO+YvXI0QYX4SQpKXPcbNLHGVaYyCYp5nlJshlRB6DxjrK6wYv55hqCjT
 feuF9qGYSv+Bf5bD0HADtH8LAAfRiqSq9YxyGCzGqo1lAYCzyl0Xoilv9NPLIATVtY
 BahahIfTBsq82ZLxhD0OM6KhGpXxSKBLNwJi+ho+xbY2SU9bR0gj/ffMdEJTsZmpNP
 zV14Aa1uwgXzA==
Date: Tue, 16 Apr 2024 11:31:24 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Peter Dave Hello <hsu@peterdavehello.org>
Subject: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
Feedback-ID: 93059541:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=hsu@peterdavehello.org;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Apr 2024 08:59:19 -0400
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

From: Peter Dave Hello <hsu@peterdavehello.org>
Date: Tue, 16 Apr 2024 00:43:29 +0800
Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation

This patch adds a basic zh_TW translation file for Taiwan Traditional
Chinese users.

Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
---
 po/LINGUAS  |  1 +
 po/zh_TW.po | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 po/zh_TW.po

diff --git a/po/LINGUAS b/po/LINGUAS
index 9b33a36..08163e8 100644
--- a/po/LINGUAS
+++ b/po/LINGUAS
@@ -7,3 +7,4 @@ sv
 tr
 uk
 zh_CN
+zh_TW
diff --git a/po/zh_TW.po b/po/zh_TW.po
new file mode 100644
index 0000000..d25557e
--- /dev/null
+++ b/po/zh_TW.po
@@ -0,0 +1,93 @@
+# Chinese translations for PACKAGE package.
+# Copyright (C) 2024 THE PACKAGE'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the PACKAGE package.
+# Peter Hsu <hsu@peterdavehello.org>, 2024.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2024-04-16 17:52+0800\n"
+"PO-Revision-Date: 2024-04-16 17:52+0800\n"
+"Last-Translator: Peter Hsu <hsu@peterdavehello.org>\n"
+"Language-Team: Chinese (traditional)\n"
+"Language: zh_TW\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DASCII\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: ui/gtk.c:231
+msgid " - Press Ctrl+Alt+G to release grab"
+msgstr " - =E6=8C=89=E4=B8=8B Ctrl+Alt+G =E4=BB=A5=E9=87=8B=E6=94=BE=
=E9=8E=96=E5=AE=9A"
+
+#: ui/gtk.c:235
+msgid " [Paused]"
+msgstr " [=E5=B7=B2=E6=9A=AB=E5=81=9C]"
+
+#: ui/gtk.c:2094
+msgid "_Pause"
+msgstr "=E6=9A=AB=E5=81=9C(_P)"
+
+#: ui/gtk.c:2100
+msgid "_Reset"
+msgstr "=E9=87=8D=E8=A8=AD(_R)"
+
+#: ui/gtk.c:2103
+msgid "Power _Down"
+msgstr "=E9=97=9C=E6=A9=9F(_D)"
+
+#: ui/gtk.c:2109
+msgid "_Quit"
+msgstr "=E7=B5=90=E6=9D=9F(_Q)"
+
+#: ui/gtk.c:2239
+msgid "_Fullscreen"
+msgstr "=E5=85=A8=E8=9E=A2=E5=B9=95(_F)"
+
+#: ui/gtk.c:2242
+msgid "_Copy"
+msgstr "=E8=A4=87=E8=A3=BD(_C)"
+
+#: ui/gtk.c:2256
+msgid "Zoom _In"
+msgstr "=E6=94=BE=E5=A4=A7(_I)"
+
+#: ui/gtk.c:2265
+msgid "Zoom _Out"
+msgstr "=E7=B8=AE=E5=B0=8F(_O)"
+
+#: ui/gtk.c:2272
+msgid "Best _Fit"
+msgstr "=E6=9C=80=E4=BD=B3=E5=B0=BA=E5=AF=B8(_F)"
+
+#: ui/gtk.c:2279
+msgid "Zoom To _Fit"
+msgstr "=E8=AA=BF=E6=95=B4=E8=87=B3=E6=9C=80=E4=BD=B3=E5=A4=A7=E5=B0=8F(_F=
)"
+
+#: ui/gtk.c:2285
+msgid "Grab On _Hover"
+msgstr "=E6=BB=91=E9=81=8E=E6=99=82=E9=8E=96=E5=AE=9A(_H)"
+
+#: ui/gtk.c:2288
+msgid "_Grab Input"
+msgstr "=E9=8E=96=E5=AE=9A=E8=BC=B8=E5=85=A5(_G)"
+
+#: ui/gtk.c:2317
+msgid "Show _Tabs"
+msgstr "=E9=A1=AF=E7=A4=BA=E5=88=86=E9=A0=81(_T)"
+
+#: ui/gtk.c:2320
+msgid "Detach Tab"
+msgstr "=E5=88=86=E9=9B=A2=E5=88=86=E9=A0=81"
+
+#: ui/gtk.c:2324
+msgid "Show Menubar"
+msgstr "=E9=A1=AF=E7=A4=BA=E5=8A=9F=E8=83=BD=E8=A1=A8=E5=88=97(_M)"
+
+#: ui/gtk.c:2346
+msgid "_Machine"
+msgstr "=E6=A9=9F=E5=99=A8(_M)"
+
+#: ui/gtk.c:2351
+msgid "_View"
+msgstr "=E6=AA=A2=E8=A6=96(_V)"
--=20
2.25.1



