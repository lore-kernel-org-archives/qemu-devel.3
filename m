Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF50AC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcr9-0006gi-Un; Tue, 01 Apr 2025 10:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcr2-0006dJ-RG
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzcr1-0007OD-2X
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743518677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oRfi7+aOO90UlCp+zMuuVC/PfEnq+pSP3PfBa4bDqOk=;
 b=LwAGKVrMOczaVrtzj5qduBQDVwH9DYjWjDN0wFEgQFIvcR6JFUVgcX0Jl/bkzDlBBFOkfA
 kTdHhuOVs2FRCNFs5r4VOVvkoL80hMLYQOca3BKh0i5mK+jNZMxGFIITTfb+10Z3tT8FCW
 WHdu0P/K4WLTcLuM6qthGB+WE+zkBRU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-7hW_8cIPMJq9gp3HnAjWvg-1; Tue,
 01 Apr 2025 10:44:34 -0400
X-MC-Unique: 7hW_8cIPMJq9gp3HnAjWvg-1
X-Mimecast-MFC-AGG-ID: 7hW_8cIPMJq9gp3HnAjWvg_1743518674
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B01619560AB; Tue,  1 Apr 2025 14:44:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22F1B1955BEF; Tue,  1 Apr 2025 14:44:32 +0000 (UTC)
Date: Tue, 1 Apr 2025 10:44:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: ~h0lyalg0rithm <surajshirvankar@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH qemu 1/1] Add IOURING_SETUP_SINGLE_ISSUER flag to improve
 iouring performance
Message-ID: <20250401144431.GC277986@fedora>
References: <174293621917.22751.11381319865102029969-0@git.sr.ht>
 <174293621917.22751.11381319865102029969-1@git.sr.ht>
 <Z-Q1yDqmS3gniW4X@redhat.com> <20250326174629.GA909841@fedora>
 <Z-VPMWmneXR69C8P@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="559c3d6BVJuAIZ6+"
Content-Disposition: inline
In-Reply-To: <Z-VPMWmneXR69C8P@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
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


--559c3d6BVJuAIZ6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 02:14:25PM +0100, Kevin Wolf wrote:
> Am 26.03.2025 um 18:46 hat Stefan Hajnoczi geschrieben:
> > On Wed, Mar 26, 2025 at 06:13:44PM +0100, Kevin Wolf wrote:
> > > Am 25.03.2025 um 21:49 hat ~h0lyalg0rithm geschrieben:
> > > > From: Suraj Shirvankar <surajshirvankar@gmail.com>
> > > >=20
> > > > Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
> > > > ---
> > > >  util/fdmon-io_uring.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >=20
> > > As Stefan already mentioned, the commit message should say why we want
> > > to set this flag and why it is correct to do so.
> > >=20
> > > Is there a reason why you change the io_uring_queue_init() call in
> > > util/fdmon-io_uring.c, but not the one in block/io_uring.c?
> >=20
> > I only asked Suraj to look at util/fdmon-io_uring.c because I expect
> > block/io_uring.c's io_uring context to go away soon.
> >=20
> > In my local io_uring branches I have prepared commits that replace the
> > io_uring context in block/io_uring.c with aio_add_sqe() calls that use
> > the AioContext's fdmon-io_uring.c io_uring context.
>=20
> Then we should either document this intention in the commit message or
> make this one Based-on your changes.

Hi Suraj,
Please rebase your patch on my branch here:
https://gitlab.com/stefanha/qemu/-/tree/aio_add_sqe

My series removes the io_uring context from block/io_uring.c, unifying
it with util/fdmon-io_uring.c. That way there's no need to duplicate
io_uring context setup and your SINGLE_ISSUER change only needs to be
done in util/fdmon-io_uring.c.

The email thread for my series is here:
https://lore.kernel.org/qemu-devel/20250401142721.280287-1-stefanha@redhat.=
com/T/#t

You can add "Based-on: 20250401142721.280287-1-stefanha@redhat.com" to
the cover letter of your patch to indicate that this does not apply to
qemu.git/master but on top of my patch series.

Stefan

--559c3d6BVJuAIZ6+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfr+88ACgkQnKSrs4Gr
c8h4dgf+O57JFah1j0QFQWoU4+5HfNVhm6lHTVUN75ieelrd3yVTgl69Ld11vNBo
3CRIC+nRK1MBpNmxqcTSTYo/6B0X1A7TIKYVqWG+je1O0d8oUOLOWgdm34BVmi0R
MouEHvxJlDg3zWjZucGS3gAzenZ98yjMYp1n+W4qMQdSMvnS6B/eF7MjaCGenx+g
5I1XsPKF8AUYre3T27hjBZFCl8N5m99agVijOa3vhkpdytMx9LJgJnoUW/V7PWrb
TTTl1jLBgpr9y4+jYnZb89juUaCD0L7nc15kkKU5m77phc+xVub/VEJjdfAPqpnn
jFpucFSfzd3IWQI6oM+yK4yosU9+vg==
=PFlw
-----END PGP SIGNATURE-----

--559c3d6BVJuAIZ6+--


