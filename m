Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A816ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru7Lg-0005Sz-57; Tue, 09 Apr 2024 05:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsa+renesas@sang-engineering.com>)
 id 1ru7Lb-0005Og-7g
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:00:55 -0400
Received: from www.zeus03.de ([194.117.254.33] helo=mail.zeus03.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsa+renesas@sang-engineering.com>)
 id 1ru7LX-0000Rl-Ij
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=Iyme
 9HxgZC43VAExZR7UTQhNjAwis5OYRyDJ0X1McdI=; b=F1NqmPrfIw3jtHy5c0UZ
 HRQc/yx1pjStB3upJP0r9avYOLgeVxLc765HH9ToRULiMiuKbkThB/SKQK9JUTKZ
 E3j8JoB2yW6PU79+OFMJRVPYBpMGBUvH/ooqTRT8wH8KxvczjbuxzBKzugNcc1WT
 uYw8furNebznh0ZZJoeZo7jZ2eT4HThTSj3XI38E8u/0ItIHoeDJqisMoHRfZBM8
 wdsWD2rGThUdMAJ3PHeMouf056ZkDLyQqvbMRvSH0LkfYLVKFZUyH9wq5Rwg8dmH
 BtVjRSAxgfuRFkbXMik+gax+sMvllc7qiSzjmtxxVvipd8bEySUObjUGykDDcMRh
 lg==
Received: (qmail 165770 invoked from network); 9 Apr 2024 11:00:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 9 Apr 2024 11:00:45 +0200
X-UD-Smtp-Session: l3s3148p1@HvJQKKYVyI8gAwDPXwE9APSWg5D5lDs4
Date: Tue, 9 Apr 2024 11:00:45 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1 3/4] hw/i2c: Convert to spec v7 terminology
 (automatically)
Message-ID: <r3quxwh5gx6kyibynicadf462udtk3celghvatp4msevxwfn7s@rdmyfua4znny>
References: <20240408213339.83149-1-philmd@linaro.org>
 <20240408213339.83149-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e22hveyjxyuuxosk"
Content-Disposition: inline
In-Reply-To: <20240408213339.83149-4-philmd@linaro.org>
Received-SPF: pass client-ip=194.117.254.33;
 envelope-from=wsa+renesas@sang-engineering.com; helo=mail.zeus03.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--e22hveyjxyuuxosk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> One of the biggest change from I2C spec v6 -> v7 is:
>=20
>   =E2=80=A2 Updated the terms "master/slave" to "controller/target"
>=20
> Since it follows the inclusive terminology from the "Conscious
> Language in your Open Source Projects" guidelines [*], replace
> the I2C terminology.

=2E..

> Inspired-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Cool, I am glad that I could inspire you to do this for QEMU.

Good luck with the series,

   Wolfram


--e22hveyjxyuuxosk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYVA7kACgkQFA3kzBSg
KbaFhxAAp2yJTz3u0JdyuSdFIhd8X3sN4pDGxMDTtmWfp0VnFi0G51P0tvmM04qs
2YKL1GZ0Dat1zgz4HCcGZMdXWqiri+IgSFmjXMl1BFcNO+UZUFeU58poVjx2SqKk
3RwVLvsfYdG14DVYztJipD0YwoX4OyuVM7hwfua23ioKJLA/dsNuIdqNU65hcz6d
ErkztBDELKZcZbVe1OgpVM9KmtlRJUiQSCYqZdDbAX4AxVt9XcZE7t+Xc6wz+VBG
iLpODiOHH4ZDopkSbUzn6V2gqsqnF/4ESTKxKVNZ+/3ROnyoGZ8N9UgqStlYbElV
4zDz4tPWkkz9ml22i9vMj7oYLa3jNQd9jrAoFOa01HA6TyI8pl4izTLu2ew1nB0T
vLZPjGbVso27vbWAQn14e2YtikAdsewu36GR5X8gSLaHjRNhh2Q8vwxjOUQxTu+r
sIp2i8Ib/Ihm6p/tYaZdF8xzWkjzqERfkn8OfmFRQinsMz8npPOlZEtDbeacQIdL
4L911I0rD6uXnsD4OMkG7ZhGXv7+lsblBDXpRSRxBFIL9YD5f4VaA8gQLM+mPZ1m
PqQFEFXNCFVePjDbNvSPaHL35wuAkTP6D5H1e+Sa2E3peFiVkx9IAt09F+K0f7My
PnW/xGZLF4RlRw7ohXZUsFV4fOXfMpGAKgUZcTHD02+t0yVo5Ic=
=gVrt
-----END PGP SIGNATURE-----

--e22hveyjxyuuxosk--

