Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E906C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 13:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txn4E-0003p8-7Q; Thu, 27 Mar 2025 09:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1txn4A-0003op-7o
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1txn48-0003pb-3o
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743081274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j8svGuwX1uhbeMrXOwrSAcAQ2OoCr1qq4OA4R0KoQH4=;
 b=hcJ25pNqpeqGd9Ud9ZtEtrNUo+ZXk9KYGlW13+Ng2/EYlVOTzb1LdyIctSveLuXYi6ssfi
 YN9rGros+0dl1iNIIfEzEn8hwcOf6dmGXO0YjaYSXbI2VaSAalcP5mWZO8HzEK1a+J1LFl
 Imqen2BeNEDHYOPEWqQILB4TSYZUEJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-jnE9f3d0OnyiI5sc8PFFSA-1; Thu,
 27 Mar 2025 09:14:32 -0400
X-MC-Unique: jnE9f3d0OnyiI5sc8PFFSA-1
X-Mimecast-MFC-AGG-ID: jnE9f3d0OnyiI5sc8PFFSA_1743081271
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4021F18007E1; Thu, 27 Mar 2025 13:14:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 570F919541A5; Thu, 27 Mar 2025 13:14:27 +0000 (UTC)
Date: Thu, 27 Mar 2025 14:14:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: ~h0lyalg0rithm <surajshirvankar@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH qemu 1/1] Add IOURING_SETUP_SINGLE_ISSUER flag to improve
 iouring performance
Message-ID: <Z-VPMWmneXR69C8P@redhat.com>
References: <174293621917.22751.11381319865102029969-0@git.sr.ht>
 <174293621917.22751.11381319865102029969-1@git.sr.ht>
 <Z-Q1yDqmS3gniW4X@redhat.com> <20250326174629.GA909841@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bq8TZ4KeNslzNZGN"
Content-Disposition: inline
In-Reply-To: <20250326174629.GA909841@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--bq8TZ4KeNslzNZGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.03.2025 um 18:46 hat Stefan Hajnoczi geschrieben:
> On Wed, Mar 26, 2025 at 06:13:44PM +0100, Kevin Wolf wrote:
> > Am 25.03.2025 um 21:49 hat ~h0lyalg0rithm geschrieben:
> > > From: Suraj Shirvankar <surajshirvankar@gmail.com>
> > >=20
> > > Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
> > > ---
> > >  util/fdmon-io_uring.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > As Stefan already mentioned, the commit message should say why we want
> > to set this flag and why it is correct to do so.
> >=20
> > Is there a reason why you change the io_uring_queue_init() call in
> > util/fdmon-io_uring.c, but not the one in block/io_uring.c?
>=20
> I only asked Suraj to look at util/fdmon-io_uring.c because I expect
> block/io_uring.c's io_uring context to go away soon.
>=20
> In my local io_uring branches I have prepared commits that replace the
> io_uring context in block/io_uring.c with aio_add_sqe() calls that use
> the AioContext's fdmon-io_uring.c io_uring context.

Then we should either document this intention in the commit message or
make this one Based-on your changes.

Kevin

--bq8TZ4KeNslzNZGN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmflTzEACgkQfwmycsiP
L9aUZg//eIgAtMsCmdjsNoPTH/vjx69qLzKtB+I6N/KsBcbaA0g83zetxwH1xWS1
kmP+5gj7TENi0KuTJBW/dABXwKapGZ630lWwsi3Lm+VzOc/OviseEltcddbZw6xF
IZKOHpc7YzmnG8J6vkyabeU2g0OQwYeiLkhAKCPNMUHNSiFjF8e2DnQIJVt7sIlG
ddlk9LyIiJGq09udFX4PP9EHZqOVkadk6HbLuB2SLe/JDjkNEe3GptfIeLpBcuaf
euI9Gm/WXOj3WOFA10DQDJxr3sHRNAjnCB5YylUrh0wyvC9MAaIs+heN3kKPPoM3
NX43h0rIpUCqGUIGUek88xx3/O/fI1O+b00KU89+Y8eE8GQ+04tTMwTmPX8Bk2zF
cNsiCrT+Pv6ljWeHI3VFHufUYsjeaejIcGBM9ehsGQxbVfauZS8cnkr18LFpH999
SBGoko+L/euO4voZSpb7oAUBuLFTltXa5tvm2MomP6y9ZKjm1F1KZu+U7qj1ee/O
ixXaReN+kvjqzTJDQhBhGwImJ/YyC1WkIab+BbLxMuL8XGFDbIhQPC6wTrDf1mot
0HpL7IPk5xVGBqHwrzqHNpf4J06ueTckkzWYuanBus20/vZLfZKSzk9TVO/E29tK
tAmClgqh77TMoAhPQ9Hy4W0Sst+3rxI0sxmpSvvCDGYxzUL7+og=
=L+fO
-----END PGP SIGNATURE-----

--bq8TZ4KeNslzNZGN--


