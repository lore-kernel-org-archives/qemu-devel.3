Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4300DC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLGI-0000ru-D9; Tue, 04 Feb 2025 10:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfLGH-0000rY-22
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfLGF-0001lC-IR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738684489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQ6o7Uym7CH8tM7anl0uioVziJ5rtO6uCDoTw8lwG+o=;
 b=RXt7ya9Hmgtg6z2n+Zlb6f9CA7ZoUK495iXZ/IWukvO5GpYO0F9E76w3PrXanIGVxkyseu
 lEGi9B2EsE59BI1k8xZCLVSDAoeasKzbaypKue2aMoFIsduJQKzFnCum/34wpvQlzZzxIl
 GGofhH0ije0zbuWhEubIgwByC2kusA8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-BJQsdVVHMXGS0mJ5rkEDMQ-1; Tue,
 04 Feb 2025 10:54:48 -0500
X-MC-Unique: BJQsdVVHMXGS0mJ5rkEDMQ-1
X-Mimecast-MFC-AGG-ID: BJQsdVVHMXGS0mJ5rkEDMQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FCCC1833488; Tue,  4 Feb 2025 15:54:44 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.100])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3CBA30001BE; Tue,  4 Feb 2025 15:54:40 +0000 (UTC)
Date: Tue, 4 Feb 2025 16:54:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/15] block/export: Don't ignore image activation
 error in blk_exp_add()
Message-ID: <Z6I4PlsguBevU5sU@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-1-kwolf@redhat.com>
 <20250203185804.GL268514@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cN1ahqfXcFfrTa/8"
Content-Disposition: inline
In-Reply-To: <20250203185804.GL268514@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--cN1ahqfXcFfrTa/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.02.2025 um 19:58 hat Stefan Hajnoczi geschrieben:
> On Fri, Jan 31, 2025 at 10:50:46AM +0100, Kevin Wolf wrote:
> > Currently, block jobs can't handle inactive images correctly. Incoming
>=20
> Did you mean "block exports" instead of "block jobs"? If it's really
> "block jobs", please give an example scenario of the iteraction between
> jobs and exports.

Yes, just a typo, it should be "block exports". Will fix.

Kevin

--cN1ahqfXcFfrTa/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmeiOD4ACgkQfwmycsiP
L9a9mA/9GKpshSaTNgvs6Y931lr8G5eSgDwLzO2N9FacD7VnYl7y7g2UbuQ4B34Q
WLYwCZaILVgNrAVKx3M4GiP+JG9hmjnURP3arPORO1DwIlquR8QZpP9dXx4Cmpaf
oR56MK8W/6EmtLJMjjXNePPqjOrePopZ7Y2XVWOEyHpU9IehAhp4cwvYejpdWuC5
tzRFUE9tJBoKCC+7Tpax7rHdjvJ8GO3Elwrl6sIRP3c1qKDX7YAigb7fwyrOB/7g
gtPB1tKXaBG2gkNvo4rycnmbzdGnGlSuSUbxUjsRELcEKOkMuqJCRgwmBHQqArVC
rEMYWRcrBT3ghZD4BecCypKZigL7IHNq3djmtv9hW1qfzKqlT1RrHfTZitqfL+1D
aj/d3jlzyoj0JdUknnRUdr1d4P4KYyjLrllEJNUq6uxGwshtsXOgNjnQtJQ3wx/Q
QMgIY/1cmgEwRAt+FLOfwh1lXPraVrDnplMfqQDD2SI8s9dsGcjCuJVFs3QPMvm7
JQXlOKZk74930WkoyoI3sNuOqy/riwdSOaBjBvo3SS5dd5+mfaeB/AweLERhM347
BvQBJIPoVHq/EQ2N9Za2aVmFTMuYzzmtyaEORs9vIAIb9wXVPSxY/4OUWYio7Vx8
tgD1eJHY17b3jYjYyS0Fz2QrnDJbQ8J4ntFFUCCvPmnWjiRdzZ8=
=Mtug
-----END PGP SIGNATURE-----

--cN1ahqfXcFfrTa/8--


