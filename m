Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1FDC369A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 14:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u29dS-0003dp-CU; Tue, 08 Apr 2025 10:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u29cw-0003US-GU
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u29cp-0005Vg-T3
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744121306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v8lzZzvqtEcXtKlPbartfdyPYZ0tXh/dRGrCMGyYQYs=;
 b=Uvtx6e0ytA6TWh2cccUXtPm0Bib29bJjy4nMUeMnS3KiQQk6ep/Doauy4G90qOtaMz58rF
 Ur7xhJS5s5gHYqjkLuqu9HjDGBGXDEwQ5QyrdcnNTiyTY4Is6Urgb1D0T1pK5g9LGUnaEH
 +B2UP1N/5KLsFrFtePjc4k+dG81Snvg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-FyzowloWP2q9VJaAEVPFYQ-1; Tue,
 08 Apr 2025 10:08:24 -0400
X-MC-Unique: FyzowloWP2q9VJaAEVPFYQ-1
X-Mimecast-MFC-AGG-ID: FyzowloWP2q9VJaAEVPFYQ_1744121303
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45F881954B39; Tue,  8 Apr 2025 14:08:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C2DE19560AD; Tue,  8 Apr 2025 14:08:22 +0000 (UTC)
Date: Tue, 8 Apr 2025 10:08:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: William Hu <purplearmadillo77@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, kraxel@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui/curses: Fix infinite loop on windows
Message-ID: <20250408140821.GA548630@fedora>
References: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXm1OQMHn4woLDyh"
Content-Disposition: inline
In-Reply-To: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--OXm1OQMHn4woLDyh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 01:07:56AM +0000, William Hu via wrote:
> >From a42046272f0544dd18ed58661e53ea17d1584c2c Mon Sep 17 00:00:00 2001
> From: William Hu <purplearmadillo77@proton.me>
> Date: Wed, 2 Apr 2025 12:00:00 -0400
> Subject: [PATCH] ui/curses: Fix infinite loop on windows
>=20
> Replace -1 comparisons for wint_t with WEOF to fix infinite loop caused b=
y a
> 65535 =3D=3D -1 comparison.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
> Signed-off-by: William Hu <purplearmadillo77@proton.me>
> ---
>  ui/curses.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I have CCed Gerd Hoffmann (git-shortlog(1) shows he is the most frequent
committer to this source file) and Marc-Andr=E9 Lureau (ui/ maintainer
according to the ./MAINTAINERS file) so they can also review your patch.

>=20
> diff --git a/ui/curses.c b/ui/curses.c
> index a39aee8762..3f5c5adf78 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -265,7 +265,12 @@ static int curses2foo(const int _curses2foo[], const=
 int _curseskey2foo[],
> =20
>  static void curses_refresh(DisplayChangeListener *dcl)
>  {
> -    int chr, keysym, keycode, keycode_alt;
> +    /*
> +     * DO NOT MAKE chr AN INT:
> +     * Causes silent conversion errors on Windows where wint_t is unsign=
ed short.
> +     */
> +    wint_t chr =3D 0;
> +    int keysym, keycode, keycode_alt;
>      enum maybe_keycode maybe_keycode =3D CURSES_KEYCODE;
> =20
>      curses_winch_check();
> @@ -284,8 +289,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
>          /* while there are any pending key strokes to process */
>          chr =3D console_getch(&maybe_keycode);
> =20
> -        if (chr =3D=3D -1)
> +        if (chr =3D=3D WEOF) {
>              break;
> +        }

Further below there appears to be another instance of the same bug:

  /* alt or esc key */
  if (keycode =3D=3D 1) {
      enum maybe_keycode next_maybe_keycode =3D CURSES_KEYCODE;
      int nextchr =3D console_getch(&next_maybe_keycode);

      if (nextchr !=3D -1) {
          ^^^^^^^^^^^^^

> =20
>  #ifdef KEY_RESIZE
>          /* this shouldn't occur when we use a custom SIGWINCH handler */
> --=20
> 2.47.0
>=20
>=20

--OXm1OQMHn4woLDyh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf1LdUACgkQnKSrs4Gr
c8goEwf/Y3fWABDxYq6yZvvCk3tdFoT6FPIx+B8voCcNiAkVf8dW88yljhn8Cj8O
Br9wbOJKkRj1GlnvzB+zkrAQIDGRsz1eDWvD/u+Hdy5utspVIIzl4/fHDbGfIHqW
3fAE2bVfbzUfaeNe14/bsS2983UKof2xjyzfAMhHW34xdgjqLDdlf/ZX/KU3W+6a
j7ExnSM/p2OvD6UQ5uPCW1ST43Xmm3lV9B39WTN8C7/BgChAAh2FSMlwn0iXXjeo
ID4CHOWKnj94xfn4gS45uY56g79ZOgJVOIPXJEyGsTBy873rE49zlG+fyZGMHG6J
AaO7fmFsviMc9WvljB4DSojzcjgWdA==
=T2XH
-----END PGP SIGNATURE-----

--OXm1OQMHn4woLDyh--


