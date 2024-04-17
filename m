Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36E8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 13:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx51J-0001d5-5j; Wed, 17 Apr 2024 09:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1rx51H-0001cl-Gq
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 09:08:12 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1rx51E-0000sz-9c
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 09:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peterdavehello.org;
 s=protonmail; t=1713359274; x=1713618474;
 bh=KEHa0fX+0FFBWtK5WJS/XBvuFSu9Rwb1hBLfR1JCyVY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=OIc1STm0lxk1xVQsg2Eu9QlEzAxEEweccRBHTWWT2s4NZXsPVf/diPbEKpfmvQWvj
 FKHGpvcX4NlPdXVC/j6DDDqjGXs1UjevY9n0CN6KjIWpmtktm8PB7kRh/fvxV9djKW
 d1st+Ycnuw05GU4w8btDBsh+PWCkMHcSKa4JievN7hRwe/aV76XvjcSgxcgejyz6No
 6h/+G93mEtHd/2f79Qa0d4RvF+RtvfGC2aQfVqIBl34kenVBxGJW/n6yJ6QHYTfSGF
 o8IHDFcD3Bpr2bkFUoWxQh0/nHmIuXyZYoHmoNYmJw1iMZAognPqO1t2lvVXzEWw9J
 yIQVFi6sErN1w==
Date: Wed, 17 Apr 2024 13:07:17 +0000
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
From: Peter Dave Hello <hsu@peterdavehello.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
In-Reply-To: <Zh6oIH8Ihyn-9RwT@redhat.com>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com> <Zh6oIH8Ihyn-9RwT@redhat.com>
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

Hi all,

Thank you all for the feedback. I've updated the patch to address most of t=
he suggestions, but only the copyright part. I'm not sure how to deal with =
it. BTW, should I directly paste the revised patch below? Sorry that I'm no=
t familiar with the process here. Thanks for your help again.

From: Peter Dave Hello <hsu@peterdavehello.org>
Date: Tue, 16 Apr 2024 00:43:29 +0800
Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation

This patch adds a basic zh_TW translation file for Taiwan Traditional
Chinese users.

Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
---
 po/LINGUAS  |  1 +
 po/zh_TW.po | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
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
index 0000000..e6d2c07
--- /dev/null
+++ b/po/zh_TW.po
@@ -0,0 +1,74 @@
+# Chinese translations for QEMU package.
+# Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the QEMU package.
+# Peter Dave Hello <hsu@peterdavehello.org>, 2024.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: QEMU 9.1\n"
+"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
+"POT-Creation-Date: 2024-04-16 17:52+0800\n"
+"PO-Revision-Date: 2024-04-16 17:52+0800\n"
+"Last-Translator: Peter Dave Hello <hsu@peterdavehello.org>\n"
+"Language-Team: Chinese (traditional)\n"
+"Language: zh_TW\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+msgid " - Press Ctrl+Alt+G to release grab"
+msgstr " - =E6=8C=89=E4=B8=8B Ctrl+Alt+G =E4=BB=A5=E9=87=8B=E6=94=BE=
=E9=8E=96=E5=AE=9A"
+
+msgid " [Paused]"
+msgstr " [=E5=B7=B2=E6=9A=AB=E5=81=9C]"
+
+msgid "_Pause"
+msgstr "=E6=9A=AB=E5=81=9C(_P)"
+
+msgid "_Reset"
+msgstr "=E9=87=8D=E8=A8=AD(_R)"
+
+msgid "Power _Down"
+msgstr "=E9=97=9C=E6=A9=9F(_D)"
+
+msgid "_Quit"
+msgstr "=E7=B5=90=E6=9D=9F(_Q)"
+
+msgid "_Fullscreen"
+msgstr "=E5=85=A8=E8=9E=A2=E5=B9=95(_F)"
+
+msgid "_Copy"
+msgstr "=E8=A4=87=E8=A3=BD(_C)"
+
+msgid "Zoom _In"
+msgstr "=E6=94=BE=E5=A4=A7(_I)"
+
+msgid "Zoom _Out"
+msgstr "=E7=B8=AE=E5=B0=8F(_O)"
+
+msgid "Best _Fit"
+msgstr "=E6=9C=80=E4=BD=B3=E5=B0=BA=E5=AF=B8(_F)"
+
+msgid "Zoom To _Fit"
+msgstr "=E8=AA=BF=E6=95=B4=E8=87=B3=E6=9C=80=E4=BD=B3=E5=A4=A7=E5=B0=8F(_F=
)"
+
+msgid "Grab On _Hover"
+msgstr "=E6=BB=91=E9=81=8E=E6=99=82=E9=8E=96=E5=AE=9A(_H)"
+
+msgid "_Grab Input"
+msgstr "=E9=8E=96=E5=AE=9A=E8=BC=B8=E5=85=A5(_G)"
+
+msgid "Show _Tabs"
+msgstr "=E9=A1=AF=E7=A4=BA=E5=88=86=E9=A0=81(_T)"
+
+msgid "Detach Tab"
+msgstr "=E5=88=86=E9=9B=A2=E5=88=86=E9=A0=81"
+
+msgid "Show Menubar"
+msgstr "=E9=A1=AF=E7=A4=BA=E5=8A=9F=E8=83=BD=E8=A1=A8=E5=88=97(_M)"
+
+msgid "_Machine"
+msgstr "=E6=A9=9F=E5=99=A8(_M)"
+
+msgid "_View"
+msgstr "=E6=AA=A2=E8=A6=96(_V)"
--=20
2.25.1

Best,
Peter


On Wednesday, April 17th, 2024 at AM 12:32, Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:

> On Wed, Apr 17, 2024 at 12:41:16AM +0800, Zhao Liu wrote:
>=20
> > Hi Peter,
> >=20
> > On Tue, Apr 16, 2024 at 02:27:45PM +0100, Peter Maydell wrote:
> >=20
> > > Date: Tue, 16 Apr 2024 14:27:45 +0100
> > > From: Peter Maydell peter.maydell@linaro.org
> > > Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
> > >=20
> > > On Tue, 16 Apr 2024 at 14:00, Peter Dave Hello hsu@peterdavehello.org=
 wrote:
> > >=20
> > > > From: Peter Dave Hello hsu@peterdavehello.org
> > > > Date: Tue, 16 Apr 2024 00:43:29 +0800
> > > > Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation
> > > >=20
> > > > This patch adds a basic zh_TW translation file for Taiwan Tradition=
al
> > > > Chinese users.
> > > >=20
> > > > Signed-off-by: Peter Dave Hello hsu@peterdavehello.org
> > >=20
> > > This name in your Signed-off-by line doesn't match the
> > > name you use in the .po file...
> > >=20
> > > > ---
> > > > po/LINGUAS | 1 +
> > > > po/zh_TW.po | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
> > > > 2 files changed, 94 insertions(+)
> > > > create mode 100644 po/zh_TW.po
> > > >=20
> > > > diff --git a/po/LINGUAS b/po/LINGUAS
> > > > index 9b33a36..08163e8 100644
> > > > --- a/po/LINGUAS
> > > > +++ b/po/LINGUAS
> > > > @@ -7,3 +7,4 @@ sv
> > > > tr
> > > > uk
> > > > zh_CN
> > > > +zh_TW
> > > > diff --git a/po/zh_TW.po b/po/zh_TW.po
> > > > new file mode 100644
> > > > index 0000000..d25557e
> > > > --- /dev/null
> > > > +++ b/po/zh_TW.po
> > > > @@ -0,0 +1,93 @@
> > > > +# Chinese translations for PACKAGE package.
> > > > +# Copyright (C) 2024 THE PACKAGE'S COPYRIGHT HOLDER
> > > > +# This file is distributed under the same license as the PACKAGE p=
ackage.
> > >=20
> > > Can you replace all these placeholder ALLCAPS items
> > > with the right values, please?
> > >=20
> > > > +# Peter Hsu hsu@peterdavehello.org, 2024.
> > > > +#
> >=20
> > Open source license is missing here.
> >=20
> > And I checked the other .po files and found that none of them declare
> > the open source license, are they missing it? Or does this case default
> > to "GPL-2.0-or-later"?
>=20
>=20
> Best practice is for every file to mention its license, ideally
> using the "SPDX-Identifier" tag syntax for new files.
>=20
> If any file is missing a license header statement, then implicitly it
> falls under the LICENSE file rules, which is GPL-2.0-or-later.
>=20
> With regards,
> Daniel
> --
> |: https://berrange.com -o- https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org -o- https://fstop138.berrange.com :|
> |: https://entangle-photo.org -o- https://www.instagram.com/dberrange :|

