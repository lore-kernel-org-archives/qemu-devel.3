Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E984CC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7OF-0002jN-DH; Tue, 12 Mar 2024 15:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OC-0002h9-80
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OA-0005HK-OS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oSDtm5zvcwto5PRbuw1B3KDgHFY5VH5ss8AqxSTgCoE=;
 b=Pa5vOd4tHl05+3cohqIKuMWuA2oGWkDZIrpGaEljZFWV8piKJDJiR0ea2qejhpVeEHBAG4
 L6pdXN2OwtWQchfek0a8TEowIaK4aazH/mwb6pEH49mYEUwTE67Ou7/a1QH7ct7xuHl+w6
 Sw123SAHvlzNwvYVb5cIYAqVd0enXSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-4hCAqajhPEeccnKzIewVOg-1; Tue, 12 Mar 2024 15:02:10 -0400
X-MC-Unique: 4hCAqajhPEeccnKzIewVOg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89C65800268;
 Tue, 12 Mar 2024 19:02:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2D9C492BC7;
 Tue, 12 Mar 2024 19:02:08 +0000 (UTC)
Date: Tue, 12 Mar 2024 14:50:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/2] tracetool: remove redundant --target-type /
 --target-name args
Message-ID: <20240312185057.GE389553@fedora>
References: <20240108171356.1037059-1-berrange@redhat.com>
 <20240108171356.1037059-2-berrange@redhat.com>
 <CAFn=p-bJNzH7_iFDjV-Fwg_yO3HPvwaSSxBnuhXD-T6tCTR1Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="osJ9JKGD4wSD0OZh"
Content-Disposition: inline
In-Reply-To: <CAFn=p-bJNzH7_iFDjV-Fwg_yO3HPvwaSSxBnuhXD-T6tCTR1Fg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--osJ9JKGD4wSD0OZh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:50:40PM -0500, John Snow wrote:
> On Mon, Jan 8, 2024 at 12:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
> >
> > The --target-type and --target-name args are used to construct
> > the default probe prefix if '--probe-prefix' is not given. The
> > meson.build will always pass '--probe-prefix', so the other args
> > are effectively redundant.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Fine by me, provided there's no reason anyone is calling tracetool
> manually for some reason I haven't thought about. I assume we'll hear
> about it if so...

That's okay. tracetool.py is internal to QEMU so we're free to change
the command-line options.

Stefan

--osJ9JKGD4wSD0OZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwpBEACgkQnKSrs4Gr
c8h21gf/SMcf9XIyW6TAT3xx+rVCmOoopASAeLxXrcrKRH4Nk9CJUZ2L+qwUYdrB
/VgBPi+qKiayKtJQkMHTzqU39Gz9hDY0m6aFW7p6TPPJu8TrWzzJtyKOXCSsnX/H
Qvt5/OSklzTLGOHtpY6xcEJ8L77W16ARvlYAMlKJOkm/wuwQAVJ2Dvahd6jetB5P
5+5f0UCi/ouD9XpJ1KWvZ5B9kFepb0UYCXCeUfpiliZVcPp34a01XdqlwucXoDg9
cw1bnsxOJEzdkF5rc8brR0wUXSfSPl1BHsK0Vu5dkYgJ60g0Rj5oN6dCx1lSrNpX
vxxdSv8NzM/qWX5HNc6ASMvL43sygA==
=EOJr
-----END PGP SIGNATURE-----

--osJ9JKGD4wSD0OZh--


