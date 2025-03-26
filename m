Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2D0C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 17:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txUpz-0000XS-DV; Wed, 26 Mar 2025 13:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txUpu-0000WT-1N
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txUps-0006J9-5u
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743011199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u3iIZQ1bQlGpgGnlFkW1x0J+ijLDY61xtufX+Vg/IQY=;
 b=H20WduOR0nZIR6fAKFX0BKIKBZ/tvEB9WcHgNIWed3pp6he8xp0FwweTRLbKaUAT5lljWt
 9gR02TvhnKM39GmGk6BZ+wS1/pvf8pMR/3BYcR/FupgWFF546b3DdiIMAqdJl2a3dBtG6Z
 guRVqeh5YVJeLvDV/wpDxlDrt8Mt4gc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-1XCfcm5JN2CiAyuUavEoKw-1; Wed,
 26 Mar 2025 13:46:33 -0400
X-MC-Unique: 1XCfcm5JN2CiAyuUavEoKw-1
X-Mimecast-MFC-AGG-ID: 1XCfcm5JN2CiAyuUavEoKw_1743011192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B40C196B356; Wed, 26 Mar 2025 17:46:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.113])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21EBC180B48B; Wed, 26 Mar 2025 17:46:30 +0000 (UTC)
Date: Wed, 26 Mar 2025 13:46:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: ~h0lyalg0rithm <surajshirvankar@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH qemu 1/1] Add IOURING_SETUP_SINGLE_ISSUER flag to improve
 iouring performance
Message-ID: <20250326174629.GA909841@fedora>
References: <174293621917.22751.11381319865102029969-0@git.sr.ht>
 <174293621917.22751.11381319865102029969-1@git.sr.ht>
 <Z-Q1yDqmS3gniW4X@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pRyw0oLiMdVf6SQX"
Content-Disposition: inline
In-Reply-To: <Z-Q1yDqmS3gniW4X@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--pRyw0oLiMdVf6SQX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 06:13:44PM +0100, Kevin Wolf wrote:
> Am 25.03.2025 um 21:49 hat ~h0lyalg0rithm geschrieben:
> > From: Suraj Shirvankar <surajshirvankar@gmail.com>
> >=20
> > Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
> > ---
> >  util/fdmon-io_uring.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> As Stefan already mentioned, the commit message should say why we want
> to set this flag and why it is correct to do so.
>=20
> Is there a reason why you change the io_uring_queue_init() call in
> util/fdmon-io_uring.c, but not the one in block/io_uring.c?

I only asked Suraj to look at util/fdmon-io_uring.c because I expect
block/io_uring.c's io_uring context to go away soon.

In my local io_uring branches I have prepared commits that replace the
io_uring context in block/io_uring.c with aio_add_sqe() calls that use
the AioContext's fdmon-io_uring.c io_uring context.

Stefan

>=20
> If so, please document it in the commit message, too.
>=20
> Kevin
>=20

--pRyw0oLiMdVf6SQX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfkPXUACgkQnKSrs4Gr
c8ioBQf/XehQSy9Xy2T3lC3LykG6ez4kWekGJ/hVPYaoaOh9z8iJVt7qlKo6vtDi
5A4aYX/guEOxCEBEb2wytUttJyr6bXN+I9YC2WCnqReXCyDzG8fSSTwka5SqLkf2
bsqPZ5pOus4tk559Ts+WfSMkG4mHfRgMUToJNuSy5rsHLnhWm2oWYlHOkM83oNST
A7mMsBRI8yYVanpuskTNDSsCKrJjrMym0xzjHWm54bEqmczMp4U9suvWY9DgHIRn
iijNXfvovkMagnvgeHp7vKK+X3MCj5IvtU5E9DoZvN9UoCu71h8jTDTHYicP0Y4A
mQKdSpjw91hW44L572P41EDmH8uJvQ==
=zRrH
-----END PGP SIGNATURE-----

--pRyw0oLiMdVf6SQX--


