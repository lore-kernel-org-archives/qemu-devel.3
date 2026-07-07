Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BAFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0ah-0003yu-GK; Tue, 07 Jul 2026 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wh0ae-0003wt-Af
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:51:37 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1wh0aa-0000uM-9j
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:51:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8134618A6;
 Tue,  7 Jul 2026 07:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E2A1F000E9;
 Tue,  7 Jul 2026 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783410686;
 bh=SUkqFQHAChEnyb0j7i20Q/Ia/HvMxsq9XrMf3R1nvN0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fwYM/HfGGFIih7tJF7UcjNWX43LPfCn/iPDWojcN8HBlaTRKGE2C1aljSwCkGF704
 mXCD3hPfg9y5n+vCOkbNZNqfpEJWoplVATVf0H1B8lKRU5aSnUN1e1ju9pcR7NEOLe
 LHjwt1/XFarRiBwKhKPNA3GYRzKhuYUybqKwdpmAhLAQ1s4cn0JGpVe6eq+pT8Pbfm
 n706p9QLwrblWCcZvYWtOhe6wN1t2GyGhZNF4+YnSV0y6n7Hv2+AKbTA7CGaa5QsAG
 oYvkgFSxLzWYFVlpQBe5QncLFq5O3Avu8i1i3vgRksVnegfSe9kos6tHy7GJRc6YiL
 0FbEO607AecWQ==
Date: Tue, 7 Jul 2026 09:51:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Alex Williamson <alex@shazbot.org>, Paolo
 Bonzini <pbonzini@redhat.com>, zhenwei pi <zhenwei.pi@linux.dev>, "Gonglei
 (Arei)" <arei.gonglei@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Alex =?UTF-8?B?QmVu?=
 =?UTF-8?B?bsOpZQ==?= <alex.bennee@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Remove linux-edac
Message-ID: <20260707095119.4d1107af@foz.lan>
In-Reply-To: <20260703152529.GBakfUaQdmKSLZfqrt@fat_crate.local>
References: <20260629213624.936258-1-jsnow@redhat.com>
 <20260629230756.GCakL6zDDd_g8DIeGD@fat_crate.local>
 <akN99Ov2ngf2BwbG@redhat.com>
 <20260630192154.GBakQXUjMfaPrpc6-u@fat_crate.local>
 <20260703152529.GBakfUaQdmKSLZfqrt@fat_crate.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Boris,

On Fri, 3 Jul 2026 08:25:29 -0700
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Jun 30, 2026 at 12:21:54PM -0700, Borislav Petkov wrote:
> > On Tue, Jun 30, 2026 at 09:27:32AM +0100, Daniel P. Berrang=C3=A9 wrote=
: =20
> > > > Why is this thread CCing linux-edac?
> > > >=20
> > > > I don't see any relation here... =20
> > >=20
> > > The linux-edac list was recently added to the QEMU MAINTAINERS
> > > file:
> > >=20
> > >   https://gitlab.com/qemu-project/qemu/-/commit/4c5e70b9a42744401fc10=
b17cc61820586ba4a13
> > >=20
> > > and the entry matches the qapi/acpi-hest.json file that John has
> > > modified, so gets auto-CC'd.
> > >=20
> > > Admittedly the content in this series is not especially relevant
> > > to the liunux-edac list in this case, but the patch submission
> > > tools are just following the declared MAINTAINERS file entry. =20
> >=20
> > Thanks for letting me know.
> >=20
> > @Mauro, please remove a linux-kernel mailing list from being CCed with =
qemu
> > patches. This is only going to cause a huuuge confusion as it is already
> > showing.

I was in vacations, so I only noticed this patch today.

We use linux-edac for userspace at least since Rasdaemon beginning,
so it was never a kernel-only ML. What happened in practice on the
recent times is that rasdaemon patches are usually pushed as PR
requests at github. Yet, still today, it is recommended to also
submit them to linux-edac ML:

	https://github.com/mchehab/rasdaemon#submitting-patches

Yet, I agree that having a separate ML for userspace RAS tools
makes sense. I'll check on a separate thread if we can create
one such list at vger.

> >=20
> > Please do a separate list only for qemu RAS stuff.=20

Instead of adding a patch removing it, better to wait for the ML=20
creation and then apply a QEMU patch changing it, and another one
to rasdaemon.

Regards,
Mauro

>=20
> ---
>=20
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Fri, 3 Jul 2026 08:19:53 -0700
> Subject: [PATCH] MAINTAINERS: Remove linux-edac
>=20
> The commit
>=20
>   4c5e70b9a427 ("MAINTAINERS: update HEST maintainership entries")
>=20
> added a linux kernel mailing list (linux-edac) which gets CCed
> automatically with qemu patches. This is absolutely confusing and it
> should not happen. Qemu should have its own ras mailing list where stuff
> like that goes.
>=20
> Drop that list.
>=20
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97dcc78ded61..3664c0d67677 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2274,7 +2274,6 @@ F: docs/devel/testing/acpi-bits.rst
> =20
>  ACPI/HEST/GHES
>  M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> -L: linux-edac@vger.kernel.org
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/acpi/ghes.c



Thanks,
Mauro

