Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B5BCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMo5b-0007BL-4P; Tue, 12 May 2026 10:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMo5V-00073l-5J
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:27:59 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMo5S-000508-9J
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1778596072; x=1779200872; i=lukasstraub2@web.de;
 bh=OuT8vN/YijsiykUc7FfDszrmkHX1KaSTXnhP5FC201U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iZDZ5RPN0u7IiqwEe9LzTxGuIcRAQYBo5f+JmbcDzL1x5i2yxpkWSGgwwro7AgSY
 jEKjl2FgxUg6WgG8enzGpM8aPmb11K78qKXUAue1j3nQRXpFRuLML8HlA9IWsC8uG
 q+vZNJyekZbBDququ00uXyOu4fvF/V2q8FoRsoGw/OfwLbaRRQuyBz7duxpjKT4Ym
 3y3msRD89lpzecjZpo9ZyQDbvXY4AwUjT2cX+JIgAcHxv+CMgmssGu5TNjGsOGjk5
 OBEUoyg08viBy1rX8499v7PGF0tXw4NMrGpIN+JGqTWGmcPz8QDSYVWjl5Cecuebv
 zIiEBzQWWhUxYcH1BA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvslx-1xE5jL34qt-010PiW; Tue, 12
 May 2026 16:27:52 +0200
Date: Tue, 12 May 2026 16:27:51 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 07/15] tests/qtest/migration: Defer by default in
 precopy_common
Message-ID: <20260512162751.489c3739@penguin>
In-Reply-To: <20260505160915.25558-8-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E0b95z22VZSltD_+qh1WHd4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:scq7VUJ09zQ1IWcJ9J/7hhDudLbtwAq8PTaNWLejDoghrYZM9Kk
 2pyylCjKC7whbmKP8qe7+v1yyuCenC+0MPuFCOs7dDGTsJk5Ulb+60jhUKhcQJNo68tET8q
 xfVe4gpUfLlpudPn/JtzLfGPOcSH2LQbgBnZ6bjjpvCdxZeHNEbbLlP8qD3WARmv2HT8Sz0
 yZq3B3UQMPYXuAzJVACuw==
UI-OutboundReport: notjunk:1;M01:P0:/EKJVJFj6TA=;XjS/LjdqyYontd3h/zGS+w7hdnq
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/E0b95z22VZSltD_+qh1WHd4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 May 2026 13:09:06 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> As a design direction, we're restricting the usage of the command line
> option -incoming <URI>. The alternative -incoming defer should be used
> instead.
>=20
> Make all precopy_common tests defer by default.
>=20
> Using the defer option means that QEMU will not start the incoming
> migration automatically. Add the incoming QMP command. With the added
> command, the invocation at the multifd_common hook becomes redundant,
> so remove it.
>=20
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/colo-tests.c        | 12 ++++--------
>  tests/qtest/migration/compression-tests.c |  6 ------
>  tests/qtest/migration/framework.c         | 15 ++++++++-------
>  tests/qtest/migration/precopy-tests.c     | 11 +----------
>  tests/qtest/migration/tls-tests.c         | 15 +--------------
>  5 files changed, 14 insertions(+), 45 deletions(-)

For migration/colo-tests.c:
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

--Sig_/E0b95z22VZSltD_+qh1WHd4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmoDOOcACgkQNasLKJxd
sljQuxAAgh6qnp2O5rL438GdTwLqb5W5Lc12j0RWiloRu/VdNq6zxbXOAo6WtYzV
cjdOBfdLV9Wu/LiF0/10ErvOMYbLvfw4D+fTnoLNRWq8RWc8SqgXsMEXwOEplmv6
jCsmqD+DLwz7WJazQnbkA+HvwmEQ+jUfnZHWyKYLSBO0R1Jywp7q1KtkrFu0JQqK
Mur4Yts0Im0mz3xJ03rMf/s1uVTocQ6b4LHHggixihsRsqzrqnOUaDDyuRryG43n
cqks6E9+CG+iMCX6d8OdVc0Ow0HLxpQpOcmLKn0B6pQYrwsJPSyJ5nTZH3cqoYVN
S4FS3HU/M2hO2cmhNAqCEuvLKJtwbYNerIR7IYZToviHVGAX7EIjIeI0N0GZy6Tv
kPuw4PHudVxSqdXaBhV2On39xz3hNBQZRNO2j9Mn7iI2suF0/jkWrSVZdVx3iKX6
e1NpXHn+8XmMworFXuUWOHcdqIu1eGNbRh3l9aOU0FQJ8PJP5BPlFzW8zkBqaWXa
g7N+D7VQuEBtqVaIxsct3VW2UXV0avkJN7ScniAg6DPqLwID//nr5ruqW8WzLimv
gxKcX4qW4kCzrnaHUK3gGCGvsZLazsfEUFpe07EX9RwapBkSZSt4XbPMe4Zzev0B
fpftWx60oFAQUo5wk21lRfWNxbt/5VALVjB2U6TvUxIsIJDVWNY=
=ua/l
-----END PGP SIGNATURE-----

--Sig_/E0b95z22VZSltD_+qh1WHd4--

