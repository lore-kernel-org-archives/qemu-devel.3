Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F49E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwtJ-0001JQ-Dj; Wed, 04 Dec 2024 16:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tIwtG-0001Iw-Iy
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:26:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tIwt9-0006wn-6j
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733347584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qTfuGYTQszXAqrmYlTDVLi4K7c2Rdre26VxDtLD+7w=;
 b=LUs1sFGQaB44doBP1nUh/hvMAkgUkXjIc12WGGJ80vFlzMmLPooLBZfsLwZ1To7le81Gp6
 VqZof3l8B4W8cWIXoHQkFEO9g8I03fhjG/QBjbRYzrp2T2gX4tUP5wBkEahYp/haisQrqY
 MpsODojNcmvKMD9aIlT7HNuAKTZwSWA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-KdQ_AVozNjqXTPco00Mb1w-1; Wed,
 04 Dec 2024 16:26:23 -0500
X-MC-Unique: KdQ_AVozNjqXTPco00Mb1w-1
X-Mimecast-MFC-AGG-ID: KdQ_AVozNjqXTPco00Mb1w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 365C8195608C; Wed,  4 Dec 2024 21:26:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DF5C19560A2; Wed,  4 Dec 2024 21:26:21 +0000 (UTC)
Date: Wed, 4 Dec 2024 16:26:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: QEMU wiki theme table of contents changes
Message-ID: <20241204212619.GE48585@fedora>
References: <ZzXV-KyYLa-7yNdV@redhat.com>
 <CAJSP0QUkfSO3uXPjZCxNfCfVwwWBBy6u5a=PjqqnMZSxE95YpA@mail.gmail.com>
 <ZzcMQeHfBTm2iEsc@redhat.com>
 <CAJSP0QVPiibdfs1YsYMe0Mk-DX-Xy7f+utG=W4eSpBkdzaodGg@mail.gmail.com>
 <ZzejHlGw3RJzc-Jk@redhat.com> <20241119195429.GE340853@fedora>
 <Zz9WPMgmY1aAfw8x@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DwatL3pcGLxsdi+C"
Content-Disposition: inline
In-Reply-To: <Zz9WPMgmY1aAfw8x@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--DwatL3pcGLxsdi+C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 03:48:12PM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Nov 19, 2024 at 02:54:29PM -0500, Stefan Hajnoczi wrote:
> > On Fri, Nov 15, 2024 at 07:38:06PM +0000, Daniel P. Berrang=E9 wrote:
> > > On Fri, Nov 15, 2024 at 02:21:12PM -0500, Stefan Hajnoczi wrote:
> > > > On Fri, 15 Nov 2024 at 03:54, Daniel P. Berrang=E9 <berrange@redhat=
=2Ecom> wrote:
> > > > >
> > > > > On Thu, Nov 14, 2024 at 02:04:35PM -0500, Stefan Hajnoczi wrote:
> > > > > > On Thu, 14 Nov 2024 at 05:51, Daniel P. Berrang=E9 <berrange@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > Looking at
> > > > > > >
> > > > > > >   https://wiki.qemu.org/ChangeLog/9.2
> > > > > > >
> > > > > > > I'm thinking that I'm sure there used to be a table of conten=
ts present
> > > > > > > at the top of pages, but none is to be seen..... until I even=
tually
> > > > > > > discover that there's a bare noticable, fully collapsed ToC i=
n the left
> > > > > > > hand nav panel below all the general wiki nav links, partiall=
y off the
> > > > > > > bottom of the page :-(
> > > > > > >
> > > > > > > If going to https://wiki.qemu.org/Special:Preferences, "Appea=
rance" and
> > > > > > > selecting "Vector legacy (2010)" as the "Skin" instad of "Vec=
tor (2022)"
> > > > > > > then the full ToC re-appears at the top of page in the main b=
ody content.
> > > > > > >
> > > > > > > I'm presuming this style change was triggered by a software u=
pgrade that
> > > > > > > was done on the wiki at some point.
> > > > > > >
> > > > > > > IMHO this is quite a significant visual/usability regression.
> > > > > > >
> > > > > > > On wikipedia, they do have the same theme, with ToC in the le=
ft hand
> > > > > > > panel, but their ToC is expanded by default, and there's no o=
ther general
> > > > > > > navigation in the left hand panel that's displacing the ToC o=
ff the bottom
> > > > > > > of the page. That is fairly effective as a layout.
> > > > > > >
> > > > > > > We can do something to the QEMU skin to improve this ? Swappi=
ng order
> > > > > > > of the ToC & general nav blocks in the left hand panel would =
be a
> > > > > > > improvement, as well making it expand at least 1 further leve=
l by
> > > > > > > default.
> > > > > > >
> > > > > > > If we're going to have background colour set for the general =
nav block,
> > > > > > > we should also probably do similar for the ToC nav block to m=
ake it
> > > > > > > visually stand out to the same degree.
> > > > > >
> > > > > > Yes, that sounds good. The quickest would be for you to:
> > > > > > 1. Run https://hub.docker.com/_/mediawiki/ in a container on yo=
ur machine.
> > > > > > 2. Adjust the theme CSS until you are happy.
> > > > > > 3. Send me the tweaks and I will apply them to wiki.qemu.org.
> > > > >
> > > > > Is the current QEMU mediawiki code (or just theme) published anyw=
here
> > > > > that I can base work off ?
> > > >=20
> > > > The QEMU wiki runs from the vanilla mediawiki 1.39 container image.
> > > > The Vector (2022) theme comes with Mediawiki and there are no
> > > > QEMU-specific customizations.
> > > >=20
> > > > You can get the same look with the vanilla Mediawiki container image
> > > > with the following in LocalSettings.php:
> > > > $wgDefaultSkin =3D "vector-2022";
> > > > wfLoadSkin('Vector');
> > >=20
> > > Hmm, I'm wondering where the QEMU specific left nav bar content
> > > and styling comes from then... ?=20
> >=20
> > I'm not sure but unless there is something stored in the database, I
> > can't imagine any customizations because there aren't any config files,
> > themes, CSS overrides, etc to speak of in QEMU's MediaWiki installation.
> > It's just running the vanilla container image.
>=20
> Ah, I found out  we've done it with the side-bar addon
>=20
>   https://wiki.qemu.org/MediaWiki:Sidebar

Is there a fix I can apply to the wiki configuration?

Stefan

--DwatL3pcGLxsdi+C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdQyPsACgkQnKSrs4Gr
c8g54AgAuv/5wG9QXqAp8MStB0HaWlvXuEqovAeMuD0nKRm0kfq6syOFdqqUdX3C
KEO8mkDHHGkolUQYQx3pXadlK44kKZkfvAi+J+17vWAEoyIppBcPaE47HwSFjWkK
lHUlDLa9Q9vFgXx9UCqGCvDRG4WI0xgrcZBHcFQiVctwX7QhENYec3N2eKQyxuth
HcpXWoaetDRyufrHWXkpPmp3YUdHxxDaNxqmNhIdCuWaXnK7uiINGLE/KhaoAE1C
XA6OXiBub9fUXlFoLSs2Mf7/9BiT1p7b4Zli9jsJn5QxfLOIujqu6r60svH/ZHyb
b59c1eQW1xjieaYYnHm9lsMj54MZlA==
=kGUu
-----END PGP SIGNATURE-----

--DwatL3pcGLxsdi+C--


