Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4755AD7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9Lp-0001rj-SJ; Thu, 21 Nov 2024 10:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tE9Li-0001Ms-3e
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tE9Lg-00012q-5N
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwbBZEkDVpbzaOGfFlWC+zQ+bQ/y755X58iI0FRHKCw=;
 b=eRXu6oPRXCFhS8t/21bMn+krijTkiKPRorAGeZuUyoT/QAioBFvqs32dv2gklPDLptNcIX
 g4Z1lO4kDm/S4YBnDEnUGwSP/vFITdytE6Lhco6YTVkDGg3mFPfzV2h/meH2dF7qIuFNox
 VdnaLlUB8PeRlqIemoB0srhcsjRcxaU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-aEM72FWBMWueplix5TUgCw-1; Thu,
 21 Nov 2024 10:43:58 -0500
X-MC-Unique: aEM72FWBMWueplix5TUgCw-1
X-Mimecast-MFC-AGG-ID: aEM72FWBMWueplix5TUgCw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B941955F10; Thu, 21 Nov 2024 15:43:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8265B195607C; Thu, 21 Nov 2024 15:43:56 +0000 (UTC)
Date: Tue, 19 Nov 2024 14:54:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: QEMU wiki theme table of contents changes
Message-ID: <20241119195429.GE340853@fedora>
References: <ZzXV-KyYLa-7yNdV@redhat.com>
 <CAJSP0QUkfSO3uXPjZCxNfCfVwwWBBy6u5a=PjqqnMZSxE95YpA@mail.gmail.com>
 <ZzcMQeHfBTm2iEsc@redhat.com>
 <CAJSP0QVPiibdfs1YsYMe0Mk-DX-Xy7f+utG=W4eSpBkdzaodGg@mail.gmail.com>
 <ZzejHlGw3RJzc-Jk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XKDU5ZMcT+u7bwlH"
Content-Disposition: inline
In-Reply-To: <ZzejHlGw3RJzc-Jk@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.14, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--XKDU5ZMcT+u7bwlH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 07:38:06PM +0000, Daniel P. Berrang=E9 wrote:
> On Fri, Nov 15, 2024 at 02:21:12PM -0500, Stefan Hajnoczi wrote:
> > On Fri, 15 Nov 2024 at 03:54, Daniel P. Berrang=E9 <berrange@redhat.com=
> wrote:
> > >
> > > On Thu, Nov 14, 2024 at 02:04:35PM -0500, Stefan Hajnoczi wrote:
> > > > On Thu, 14 Nov 2024 at 05:51, Daniel P. Berrang=E9 <berrange@redhat=
=2Ecom> wrote:
> > > > >
> > > > > Looking at
> > > > >
> > > > >   https://wiki.qemu.org/ChangeLog/9.2
> > > > >
> > > > > I'm thinking that I'm sure there used to be a table of contents p=
resent
> > > > > at the top of pages, but none is to be seen..... until I eventual=
ly
> > > > > discover that there's a bare noticable, fully collapsed ToC in th=
e left
> > > > > hand nav panel below all the general wiki nav links, partially of=
f the
> > > > > bottom of the page :-(
> > > > >
> > > > > If going to https://wiki.qemu.org/Special:Preferences, "Appearanc=
e" and
> > > > > selecting "Vector legacy (2010)" as the "Skin" instad of "Vector =
(2022)"
> > > > > then the full ToC re-appears at the top of page in the main body =
content.
> > > > >
> > > > > I'm presuming this style change was triggered by a software upgra=
de that
> > > > > was done on the wiki at some point.
> > > > >
> > > > > IMHO this is quite a significant visual/usability regression.
> > > > >
> > > > > On wikipedia, they do have the same theme, with ToC in the left h=
and
> > > > > panel, but their ToC is expanded by default, and there's no other=
 general
> > > > > navigation in the left hand panel that's displacing the ToC off t=
he bottom
> > > > > of the page. That is fairly effective as a layout.
> > > > >
> > > > > We can do something to the QEMU skin to improve this ? Swapping o=
rder
> > > > > of the ToC & general nav blocks in the left hand panel would be a
> > > > > improvement, as well making it expand at least 1 further level by
> > > > > default.
> > > > >
> > > > > If we're going to have background colour set for the general nav =
block,
> > > > > we should also probably do similar for the ToC nav block to make =
it
> > > > > visually stand out to the same degree.
> > > >
> > > > Yes, that sounds good. The quickest would be for you to:
> > > > 1. Run https://hub.docker.com/_/mediawiki/ in a container on your m=
achine.
> > > > 2. Adjust the theme CSS until you are happy.
> > > > 3. Send me the tweaks and I will apply them to wiki.qemu.org.
> > >
> > > Is the current QEMU mediawiki code (or just theme) published anywhere
> > > that I can base work off ?
> >=20
> > The QEMU wiki runs from the vanilla mediawiki 1.39 container image.
> > The Vector (2022) theme comes with Mediawiki and there are no
> > QEMU-specific customizations.
> >=20
> > You can get the same look with the vanilla Mediawiki container image
> > with the following in LocalSettings.php:
> > $wgDefaultSkin =3D "vector-2022";
> > wfLoadSkin('Vector');
>=20
> Hmm, I'm wondering where the QEMU specific left nav bar content
> and styling comes from then... ?=20

I'm not sure but unless there is something stored in the database, I
can't imagine any customizations because there aren't any config files,
themes, CSS overrides, etc to speak of in QEMU's MediaWiki installation.
It's just running the vanilla container image.

Stefan

--XKDU5ZMcT+u7bwlH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmc87PUACgkQnKSrs4Gr
c8jqpgf/eXgIypkJmBnr6s5wIJ2Ss3asX5vffOyckiy4wliKN3Syvwh5jHruPdNz
5mWgt44khGoG+VhuUUX8FMUYmfqJEV0ibJCHlASa6eN/Yp9DlCu59At76EzI2G6t
hfSd1hgc4hHUag752GGEKJnaENWWPNu0+PrOC/aiJmxS0KbcRr9MhwcBGL5FdV4i
EjS/f81u3nN5jRGW92FRr+cyZ2wPq2u/VocBiipduxfBXJHLqWcJBwhUS9Z1j0aJ
ZUC93nXs+5/Vegf1j9xKzpbd6YT1f+QsLbSagPV/EKSGBUdzW2gqADjrEl+WX1nE
j8nlIOk8avqAWCwiCledd0DyEsmg/g==
=bJ18
-----END PGP SIGNATURE-----

--XKDU5ZMcT+u7bwlH--


