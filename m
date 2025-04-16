Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E05DC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 10:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u50Ew-0004r3-JW; Wed, 16 Apr 2025 06:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u50Em-0004pY-8T
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 06:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u50Ei-0003V1-7U
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 06:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744800198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I1SNf4k1vkbPSdFHGZM7Talbjfhoph3u3m0MzlCZPjs=;
 b=WSSf/qQGpqOICbvJQB9TOhctC+/qUUGRVQyCnRUHPbHaJk0TOrsB+E3z3orrrwcPHVmL8F
 JAfrv6hqBqe/P2GxAyZ/2APO8mcQUDGCQpeY2rY3fxfjOrRIiJtARuE9Xg9S9HD1EJXhRn
 xtr4FGlgatQkskzKSm1JGI+5FkrssTk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-UCMIg48JOcqnPxJO4C3TDA-1; Wed,
 16 Apr 2025 06:43:14 -0400
X-MC-Unique: UCMIg48JOcqnPxJO4C3TDA-1
X-Mimecast-MFC-AGG-ID: UCMIg48JOcqnPxJO4C3TDA_1744800193
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C538F1956096; Wed, 16 Apr 2025 10:43:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4152B19560A3; Wed, 16 Apr 2025 10:43:09 +0000 (UTC)
Date: Wed, 16 Apr 2025 12:43:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/2] file-posix: probe discard alignment on Linux
 block devices
Message-ID: <Z_-JuzabVntIfGgm@redhat.com>
References: <20250410184103.23385-1-stefanha@redhat.com>
 <20250410184103.23385-2-stefanha@redhat.com>
 <c7b9ddb4-10de-4c66-9f2f-c964d77275e0@redhat.com>
 <20250414153451.GC117758@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5UgUjOQKq5WOGByV"
Content-Disposition: inline
In-Reply-To: <20250414153451.GC117758@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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


--5UgUjOQKq5WOGByV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.04.2025 um 17:34 hat Stefan Hajnoczi geschrieben:
> On Fri, Apr 11, 2025 at 10:15:13AM +0200, Hanna Czenczek wrote:
> > On 10.04.25 20:41, Stefan Hajnoczi wrote:
> > > Populate the pdiscard_alignment block limit so the block layer is able
> > > align discard requests correctly.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >   block/file-posix.c | 56 +++++++++++++++++++++++++++++++++++++++++++=
++-
> > >   1 file changed, 55 insertions(+), 1 deletion(-)
> >=20
> > Ah, I didn=E2=80=99t know sysfs is actually fair game.=C2=A0 Should we =
not also get the
> > maximum discard length then, too?
>=20
> The maximum discard length behaves differently: the Linux block layer
> splits requests according to the maximum discard length. If the guest
> submits a discard request that is too large for the host, the host block
> layer will split it and the request succeeds. That is why I didn't make
> any changes to the maximum discard length in this series.

Do we need to do something with it for SCSI passthrough? Similar to how
we expose bs->bl.max_hw_transfer/iov in the block limits VPD page?

Kevin

--5UgUjOQKq5WOGByV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmf/iboACgkQfwmycsiP
L9ap9RAAr7XW58GMMYNJLUaWfYIMiqV9q1tSgkPy/SWTIw/W/lvfkNZuthUV6YyU
KQV7wlrsxd9+aC7Tj9hZ0TeHviL2iD/7aApquHVnyKNzEBTCIbBupyP29CrYSwFk
n/xSAqrqM9TkfKRkgpDFXZDvfkRYZV9ZfOPViuafxLPci6E4FTU/WdiD1LttNUyt
Nqh2xLqCsSsK4EDfzrGwF6+Er2QLaIKVupyVbd2FENRLgn1uvnzNg77pFfjWAe1Z
sUkZKzeD8eRqb6Rfd+0Z84fvomoY0aJJln6tlzU0H55icfQSFLM6upkFX6XuCc50
K1bg5421XZuj338TyKseFcDnpE4qmB5YvwKH0f1fv2tEZ6aoNV2WlhrjRpjH2r6u
VA2O1FZWti3jqCAQJMKvtoLs1I/c6xVG8OQ0KifrcNWybvK1rM/xew4TUlQaZSY0
ujDt9ovv1/52SQ+Hp2pbCA6+9EKuIO711HRfY8SgScgRZRKOrg+Iw85JSsTs6ivA
w4PoOGD1ovGYbuZQxtCMYofpNBeR/nB65Hs7MpXZgmNssSWZ8fvIuWMW0HDuNPij
6+mTI/jMyt/d4OW9n+l396YBNt/skol2zAOdbbZsXcXenWJrgSkz7FKzFe3fW0Di
VQNeOVj1WyDakV3KjT1bDxzmm5JxOdMIZ+xq2+LJYO5LVoO3x5c=
=oq3m
-----END PGP SIGNATURE-----

--5UgUjOQKq5WOGByV--


