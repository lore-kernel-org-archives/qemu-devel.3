Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5E7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7OE-0002j6-9q; Tue, 12 Mar 2024 15:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OC-0002hD-GZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OB-0005HM-3x
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1z20Ola8WoNHbTJ59KLrXnejzZoAY332/4KgkDEhWUw=;
 b=OvBc0k6CtnCOwmYxIdI4erkT53HUGnykXKyH91Au3H84rm8JzalciSyWvBGKOo6F0sHDE3
 i8JTKoN2Vfso13R6QHzTZBqCEkjND9pG6EU1dvZma4tVRmAcN0qDiqjC+UKQ7HJLw3txk+
 3SOXrdg+f9cw9QoFTfzxgeTsY0rrx4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-FuCg1KHPNM6z3QYm8uR9kA-1; Tue, 12 Mar 2024 15:02:12 -0400
X-MC-Unique: FuCg1KHPNM6z3QYm8uR9kA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB0CD101A523;
 Tue, 12 Mar 2024 19:02:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35A7F202451F;
 Tue, 12 Mar 2024 19:02:11 +0000 (UTC)
Date: Tue, 12 Mar 2024 14:52:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/2] trace: fix ability to use systemtap with qemu tools
Message-ID: <20240312185224.GF389553@fedora>
References: <20240108171356.1037059-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pGRfHWUUOmRa2zHb"
Content-Disposition: inline
In-Reply-To: <20240108171356.1037059-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--pGRfHWUUOmRa2zHb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 05:13:54PM +0000, Daniel P. Berrang=E9 wrote:
> Currently we're only generating .stp definitions for the system and
> user emulators forgetting all about the tools which support tracing
> too.
>=20
> Daniel P. Berrang=E9 (2):
>   tracetool: remove redundant --target-type / --target-name args
>   meson: generate .stp files for tools too
>=20
>  docs/devel/tracing.rst |  3 +-
>  meson.build            | 63 +++++++++++++++++++++++++++---------------
>  scripts/tracetool.py   | 24 ++++------------
>  3 files changed, 46 insertions(+), 44 deletions(-)
>=20
> --=20
> 2.43.0
>=20

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--pGRfHWUUOmRa2zHb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwpGgACgkQnKSrs4Gr
c8gUSQf8CkAj/ccw905J7D4xixpAmFHIOeU3QBnGAX6dqrJwNOHgo6YwKs1Rx5+j
MXr5GDp+hOx9cwnclnvzUxyfJHjDeHZnVHMgyMtrhS3D1IhMjPNMxCSP1ziUdUkI
VNV9/jD9cD4fzvt05IMlM5HUaoNR1iJQSe6PcrkK5pQrMbukIoEi+KC5/1PgVHxs
yqhZfj1ar5TPUj4O0OPh48dG+m5tERC5s2LINhzfnvkUSsIhmJxZc6O0xUw873l3
4rBKi7isz6TQVYrAvum3LSmysduDVjpc09+6DqFza+3A7w8mVlsyZLrRP85X5PSI
hl0k7agEspaPt5bFQPRLTx5xOK8Izg==
=Q3aI
-----END PGP SIGNATURE-----

--pGRfHWUUOmRa2zHb--


