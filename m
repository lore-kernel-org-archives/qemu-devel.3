Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E66BC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdjL-00064E-1g; Fri, 21 Jun 2024 08:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1sKdjJ-00063q-HI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:51:01 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1sKdjF-0007g6-Fe
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peterdavehello.org;
 s=protonmail2; t=1718974251; x=1719233451;
 bh=sbkQqmj5R/wyPTFlofpymgWRSAdeUgeXkyu/R5RI7io=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Xfxqegt7geapvbg0IKOxawK9D1vK3NfltYCIbMWayWFyd7KKs2bufevBWwd5r/naz
 eIYLZ/fsz8yTr6nGeIO6jnHw5/kjcZQhAvKf97PU2QhxUiz2SZ1GfIr98wfG5L5Rmb
 BUF4I8YCreQXJkocbhe+K3x3Gmh+UkcAD/eIeQEhOXA4ehVnl50aE9YqU+ZLc5aaJe
 +8eEnQYGmttv2PHRgkr4QZ27fZM5HnELaAQz/H4JZnwSURb+rKftLjbRC9SBkQPmN6
 SD/1fhtrbZ7SMrfk2rT2sbcJa6GOJlBamwLIHjOmrze9ejDx11omwzMFTR9vD9+31N
 +9lEdLVQ0mdLQ==
Date: Fri, 21 Jun 2024 12:50:47 +0000
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
From: Peter Dave Hello <hsu@peterdavehello.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <5qJ0Q0ZnUCu-VdtMQOwzj54wLBfeXb9ozncO8PjFiOlXbu4RHQeVCZyn7ZMWq89yqqE7GZX3Bsuk9YqWugHmx-Wu4Oh1GZ5wboTuZ-QUk8k=@peterdavehello.org>
In-Reply-To: <Fu0jQm-Z4E7D_J11oxIlfRJ9ZYK_QDKMYOs-9NNVX_jH9_aS5_9cyysois3SaVVtuTqR-H77MiwWLaa5RkPTEnCEdy0NvUmOuwqyirCbdhY=@peterdavehello.org>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com> <Zh6oIH8Ihyn-9RwT@redhat.com>
 <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
 <ZiCDzzFDRmQGPtDD@intel.com>
 <Fu0jQm-Z4E7D_J11oxIlfRJ9ZYK_QDKMYOs-9NNVX_jH9_aS5_9cyysois3SaVVtuTqR-H77MiwWLaa5RkPTEnCEdy0NvUmOuwqyirCbdhY=@peterdavehello.org>
Feedback-ID: 93059541:user:proton
X-Pm-Message-ID: 32c98823db243db23d25aad580765fb742d38c2d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=hsu@peterdavehello.org;
 helo=mail-4018.proton.ch
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

Hi there,

I'm not sure if the previous mail has been dropped. I would really apprecia=
te it if anyone could give me some advice. Thanks a lot!

Best,
Peter


On Wednesday, April 24th, 2024 at AM 2:20, Peter Dave Hello <hsu@peterdaveh=
ello.org> wrote:

> Hi PMM, Zhao & Daniel,
>=20
> Thank you for all your help; I wonder if the copyright can just belong to=
 this project because the copyright to me personally in the open source wor=
ld just to deal with somebody violets the license. Otherwise, I'm more copy=
left. What do you think?
>=20
> Best,
> Peter
>=20
>=20
>=20
>=20
> On Thursday, April 18th, 2024 at AM 10:08, Zhao Liu zhao1.liu@intel.com w=
rote:
>=20
> > Hi Perter HSU,
> >=20
> > On Wed, Apr 17, 2024 at 01:07:17PM +0000, Peter Dave Hello wrote:
> >=20
> > > Date: Wed, 17 Apr 2024 13:07:17 +0000
> > > From: Peter Dave Hello hsu@peterdavehello.org
> > > Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
> > >=20
> > > Hi all,
> > >=20
> > > Thank you all for the feedback. I've updated the patch to address mos=
t of the suggestions, but only the copyright part. I'm not sure how to deal=
 with it. BTW, should I directly paste the revised patch below? Sorry that =
I'm not familiar with the process here. Thanks for your help again.
> >=20
> > New patch should be sent separately to avoid replying directly to
> > previous mail thread. And the tag of the SUBJECT for your v2 patch need=
s
> > to be changed to "[PATCH v2]".
> >=20
> > > From: Peter Dave Hello hsu@peterdavehello.org
> > > Date: Tue, 16 Apr 2024 00:43:29 +0800
> > > Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation
> > >=20
> > > This patch adds a basic zh_TW translation file for Taiwan Traditional
> > > Chinese users.
> > >=20
> > > Signed-off-by: Peter Dave Hello hsu@peterdavehello.org
> > > ---
> > > po/LINGUAS | 1 +
> > > po/zh_TW.po | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
> > > 2 files changed, 75 insertions(+)
> > > create mode 100644 po/zh_TW.po
> > >=20
> > > diff --git a/po/LINGUAS b/po/LINGUAS
> > > index 9b33a36..08163e8 100644
> > > --- a/po/LINGUAS
> > > +++ b/po/LINGUAS
> > > @@ -7,3 +7,4 @@ sv
> > > tr
> > > uk
> > > zh_CN
> > > +zh_TW
> > > diff --git a/po/zh_TW.po b/po/zh_TW.po
> > > new file mode 100644
> > > index 0000000..e6d2c07
> > > --- /dev/null
> > > +++ b/po/zh_TW.po
> > > @@ -0,0 +1,74 @@
> > > +# Chinese translations for QEMU package.
> > > +# Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER
> >=20
> > Refer to this file /po/bg.po or any other source code of QEMU, copyrigh=
t
> > belongs to you or your company.
> >=20
> > > +# This file is distributed under the same license as the QEMU packag=
e.
> >=20
> > You can declare the license by:
> > "SPDX-License-Identifier: GPL-2.0-or-later".
> >=20
> > And put this license under the author line.
> >=20
> > > +# Peter Dave Hello hsu@peterdavehello.org, 2024.
> > > +#
> >=20
> > Others look good to me. Pls go ahead and respin your v2.
> >=20
> > Thanks,
> > Zhao

