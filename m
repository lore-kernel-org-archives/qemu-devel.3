Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA4C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp1hk-0006UE-2k; Mon, 03 Mar 2025 04:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp1gp-0005Xv-JG
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:02:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp1gm-0003RX-Ms
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740992534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D0HiAHZ/a1xx4XxpUlCNTDmJBsQFmeOO8ZWnCzm7Rdc=;
 b=g+M/B0n5Q1ftYbiGUkhxJmlGvlb3jERtPjYWApcX8q8uuUzJzOVxRPsMgI4pSpmcId41pv
 RmptuhJ6ZXMAsn1UoTXll0+F46VpIr0Fo/S5huDxognKeywcarZbwAoKX4dMfmQSR7iNmN
 I6D/cSeoSjf3btlR8s+ckcPQYpplyvg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519--aigCcelOK28sGb4AAc6iw-1; Mon,
 03 Mar 2025 04:02:10 -0500
X-MC-Unique: -aigCcelOK28sGb4AAc6iw-1
X-Mimecast-MFC-AGG-ID: -aigCcelOK28sGb4AAc6iw_1740992529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1780619560BC; Mon,  3 Mar 2025 09:02:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B745E1800361; Mon,  3 Mar 2025 09:02:06 +0000 (UTC)
Date: Mon, 3 Mar 2025 16:41:56 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2] iotest: Unbreak 302 with python 3.13
Message-ID: <20250303084156.GB205177@fedora>
References: <20250228195708.48035-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="alOkwjysBy1HZAvS"
Content-Disposition: inline
In-Reply-To: <20250228195708.48035-1-nirsof@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--alOkwjysBy1HZAvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 09:57:08PM +0200, Nir Soffer wrote:
> This test depends on TarFile.addfile() to add tar member header without
> writing the member data, which we write ourself using qemu-nbd. Python
> 3.13 changed the function in a backward incompatible way[1] to require a
> file object for tarinfo with non-zero size, breaking the test:
>=20
>      -[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "of=
fset": 1536, "size": 393216}]
>      +Traceback (most recent call last):
>      +  File "/home/stefanha/qemu/tests/qemu-iotests/302", line 118, in <=
module>
>      +    tar.addfile(disk)
>      +    ~~~~~~~~~~~^^^^^^
>      +  File "/usr/lib64/python3.13/tarfile.py", line 2262, in addfile
>      +    raise ValueError("fileobj not provided for non zero-size regula=
r file")
>      +ValueError: fileobj not provided for non zero-size regular file
>=20
> The new behavior makes sense for most users, but breaks our unusual
> usage. Fix the test to add the member header directly using public but
> undocumented attributes. This is more fragile but the test works again.
>=20
> This also fixes a bug in the previous code - when calling addfile()
> without a fileobject, tar.offset points to the start of the member data
> instead of the end.
>=20
> [1] https://github.com/python/cpython/pull/117988
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  tests/qemu-iotests/302 | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--alOkwjysBy1HZAvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfFa1QACgkQnKSrs4Gr
c8i6WQf+MVKe8xtUnILHTaFZJSbmrQCkEu/iG8m+8soloT+GRMZwISszXJRVYMJJ
xfk9B0vQULQC3tn2Z4Gxisaqqo+SWdwiePxK2AIT2oW+Z8tZ9ZbEUUU4NuvtAnSO
8wpxkiqDieEG5rdAvrzj38iEfw7atUom/etjxiZEWcMAg8js0gBpAifIpKUj/6pj
Fa6pHP1PFgEV0d6y3+4BJcHS3E6EgMQcRtEVX2Tk1aBuLPXUOXUUCQklHt3eNk1h
6XWmo7YXyHlZCFb7E+FUD3TK9KyQt1PmLH/ThTKudKRLLTAzfNbDCuzQMfy2dedr
ld4dZQEMrGT8gfOv0v8HNSX/95ybOw==
=SvpB
-----END PGP SIGNATURE-----

--alOkwjysBy1HZAvS--


