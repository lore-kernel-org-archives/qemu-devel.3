Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527E8C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzxOl-0008Kk-4S; Thu, 25 Apr 2024 07:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1rzxOb-0008Il-6w
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:36:11 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1rzxOV-0007Ca-Tx
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:36:07 -0400
DKIM-Signature: a=rsa-sha256; bh=v8UJPYu6wU8IESiKO3NcKLnDtX/nat/Y1wSkSU4hglI=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To; 
 q=dns/txt; s=20240113; t=1714044444; v=1;
 b=g04I0Wg3oo1ToB7Alf7y1pH/BLDbERynQ88PkbErAUbrAfCpsX0Ga8LHI4Le5nIo71Pw5tpU
 0oyaBtQhgvGXoOqiGxDAYJQUiA6OK/b3q15KzXU5Adz++ad+i+O1XttIT6d3KdcbTnjFCD1C3gP
 K5f0V+kEle9mb2NkQDB0/MWc5qmMCmZnGlOjhWzYQOY+DEw5QnYnRpcGlaQQLoxFvGSS8UVydag
 1tkxW3FrFZEtz9RNIFRNroKWJvxdUiDRrr8Yp95mhH1nSqBcedORPROSTSq6EjY4oBWfYVK1C1A
 HjJ5x1vqiRK+eAcxLiO9KQx8XckpvA7WOz60Lo5JjJc3w==
Received: from git.sr.ht (unknown [IPv6:2a03:6000:1813:1337::155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 33F7720415
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 11:27:24 +0000 (UTC)
From: ~norwayfun <norwayfun@git.sr.ht>
Date: Thu, 25 Apr 2024 13:21:53 +0200
Subject: [PATCH qemu1 2/2] po: Add Georgian translation
Message-ID: <171404444411.4173.15963098780730496317-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <171404444411.4173.15963098780730496317-0@git.sr.ht>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~norwayfun <temuri.doghonadze@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: norwayfun <temuri.doghonadze@gmail.com>

---
 po/ka.po | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 po/ka.po

diff --git a/po/ka.po b/po/ka.po
new file mode 100644
index 0000000000..9ac5fd2469
--- /dev/null
+++ b/po/ka.po
@@ -0,0 +1,75 @@
+# Georgian translation for QEMU.
+# This file is put in the public domain.
+# Temuri Doghonadze <temuri.doghonadze@gmail.com>, 2024.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: QEMU\n"
+"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
+"POT-Creation-Date: 2018-07-18 07:56+0200\n"
+"PO-Revision-Date: 2024-04-25 13:01+0200\n"
+"Last-Translator: Temuri Doghonadze <temuri.doghonadze@gmail.com>\n"
+"Language-Team: Georgian\n"
+"Language: ka\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+"X-Generator: Poedit 3.3.2\n"
+
+msgid " - Press Ctrl+Alt+G to release grab"
+msgstr " - =E1=83=A9=E1=83=90=E1=83=AD=E1=83=98=E1=83=93=E1=83=94=E1=83=91=
=E1=83=98=E1=83=A1 =E1=83=9B=E1=83=9D=E1=83=A1=E1=83=90=E1=83=AE=E1=83=A1=E1=
=83=9C=E1=83=94=E1=83=9A=E1=83=90=E1=83=93 =E1=83=93=E1=83=90=E1=83=90=E1=83=
=AC=E1=83=94=E1=83=A5=E1=83=98=E1=83=97: Ctrl+Alt+G"
+
+msgid " [Paused]"
+msgstr " [=E1=83=A8=E1=83=94=E1=83=A9=E1=83=94=E1=83=A0=E1=83=94=E1=83=91=E1=
=83=A3=E1=83=9A=E1=83=98=E1=83=90]"
+
+msgid "_Pause"
+msgstr "_=E1=83=9E=E1=83=90=E1=83=A3=E1=83=96=E1=83=90"
+
+msgid "_Reset"
+msgstr "_=E1=83=92=E1=83=90=E1=83=93=E1=83=90=E1=83=A2=E1=83=95=E1=83=98=E1=
=83=A0=E1=83=97=E1=83=95=E1=83=90"
+
+msgid "Power _Down"
+msgstr "_=E1=83=92=E1=83=90=E1=83=9B=E1=83=9D=E1=83=A0=E1=83=97=E1=83=95=E1=
=83=90"
+
+msgid "_Quit"
+msgstr "=E1=83=92=E1=83=90=E1=83=A1=E1=83=95_=E1=83=9A=E1=83=90"
+
+msgid "_Fullscreen"
+msgstr "=E1=83=9B_=E1=83=97=E1=83=94=E1=83=9A =E1=83=94=E1=83=99=E1=83=A0=E1=
=83=90=E1=83=9C=E1=83=96=E1=83=94"
+
+msgid "_Copy"
+msgstr "_=E1=83=99=E1=83=9D=E1=83=9E=E1=83=98=E1=83=A0=E1=83=94=E1=83=91=E1=
=83=90"
+
+msgid "Zoom _In"
+msgstr "_=E1=83=92=E1=83=90=E1=83=93=E1=83=98=E1=83=93=E1=83=94=E1=83=91=E1=
=83=90"
+
+msgid "Zoom _Out"
+msgstr "=E1=83=93=E1=83=90_=E1=83=9E=E1=83=90=E1=83=A2=E1=83=90=E1=83=A0=E1=
=83=90=E1=83=95=E1=83=94=E1=83=91=E1=83=90"
+
+msgid "Best _Fit"
+msgstr "=E1=83=A1=E1=83=90=E1=83=A3=E1=83=99=E1=83=94=E1=83=97=E1=83=94=E1=
=83=A1=E1=83=9D=E1=83=93 _=E1=83=A9=E1=83=90=E1=83=A2=E1=83=94=E1=83=95=E1=83=
=90"
+
+msgid "Zoom To _Fit"
+msgstr "=E1=83=92=E1=83=90=E1=83=93=E1=83=98=E1=83=93=E1=83=94=E1=83=91=E1=
=83=90 =E1=83=93=E1=83=90=E1=83=9E=E1=83=90_=E1=83=A2=E1=83=90=E1=83=A0=E1=83=
=90=E1=83=95=E1=83=94=E1=83=91=E1=83=90=E1=83=96=E1=83=94"
+
+msgid "Grab On _Hover"
+msgstr "=E1=83=A9=E1=83=90=E1=83=AD=E1=83=98=E1=83=93=E1=83=94=E1=83=91=E1=
=83=90 _=E1=83=92=E1=83=90=E1=83=93=E1=83=90=E1=83=A2=E1=83=90=E1=83=A0=E1=83=
=94=E1=83=91=E1=83=98=E1=83=A1=E1=83=90=E1=83=A1"
+
+msgid "_Grab Input"
+msgstr "=E1=83=A8=E1=83=94=E1=83=A2=E1=83=90=E1=83=9C=E1=83=98=E1=83=A1 _=E1=
=83=A9=E1=83=90=E1=83=AD=E1=83=98=E1=83=93=E1=83=94=E1=83=91=E1=83=90"
+
+msgid "Show _Tabs"
+msgstr "_=E1=83=A9=E1=83=90=E1=83=9C=E1=83=90=E1=83=A0=E1=83=97=E1=83=94=E1=
=83=91=E1=83=98=E1=83=A1 =E1=83=A9=E1=83=95=E1=83=94=E1=83=9C=E1=83=94=E1=83=
=91=E1=83=90"
+
+msgid "Detach Tab"
+msgstr "=E1=83=A9=E1=83=90=E1=83=9C=E1=83=90=E1=83=A0=E1=83=97=E1=83=98=E1=
=83=A1 =E1=83=9B=E1=83=9D=E1=83=AE=E1=83=A1=E1=83=9C=E1=83=90"
+
+msgid "Show Menubar"
+msgstr "=E1=83=9B=E1=83=94=E1=83=9C=E1=83=98=E1=83=A3=E1=83=A1 =E1=83=96=E1=
=83=9D=E1=83=9A=E1=83=98=E1=83=A1 =E1=83=A9=E1=83=95=E1=83=9C=E1=83=94=E1=83=
=91=E1=83=90"
+
+msgid "_Machine"
+msgstr "_=E1=83=9B=E1=83=90=E1=83=9C=E1=83=A5=E1=83=90=E1=83=9C=E1=83=90"
+
+msgid "_View"
+msgstr "_=E1=83=AE=E1=83=94=E1=83=93=E1=83=98"
--=20
2.43.0

