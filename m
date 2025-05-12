Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324A5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEY8w-0007pe-G5; Mon, 12 May 2025 14:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEY8e-0007gM-Ue
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEY8a-0004vl-Mb
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747075467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AS4si+kasNk3AH0R+8jul30FYoW1+HGUKMmgDXHfc8o=;
 b=VU3vOgmFy9IAGKyrLOZCY9i1Mlx5cHOmXN+TywyhYlbptt39vT5+mX96VxXX0pqwkXclVQ
 EXH2pxsXwm4bceYOVSIp+l0Wvt2xz8IeRKE62TabgOHjgxV7RNeeNnlAa35Dku1YmPnrt5
 ahCpSTFoobvQMkzzmtEl2/iuJ6AwfHA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-58b5028ZORapcjCDGIkYyw-1; Mon,
 12 May 2025 14:44:24 -0400
X-MC-Unique: 58b5028ZORapcjCDGIkYyw-1
X-Mimecast-MFC-AGG-ID: 58b5028ZORapcjCDGIkYyw_1747075463
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D7601800EC9; Mon, 12 May 2025 18:44:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADB8F1801390; Mon, 12 May 2025 18:44:22 +0000 (UTC)
Date: Mon, 12 May 2025 14:44:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sunnyzhyy@qq.com,
 vsementsov@yandex-team.ru, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 13/13] tests: Add iotest mirror-sparse for recent
 patches
Message-ID: <20250512184421.GH141177@fedora>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-28-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jwiHnwN6ES5PaHEI"
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-28-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--jwiHnwN6ES5PaHEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:40:30PM -0500, Eric Blake wrote:
> Prove that blockdev-mirror can now result in sparse raw destination
> files, regardless of whether the source is raw or qcow2.  By making
> this a separate test, it was possible to test effects of individual
> patches for the various pieces that all have to work together for a
> sparse mirror to be successful.
>=20
> Note that ./check -file produces different job lengths than ./check
> -qcow2 (the test uses a filter to normalize); that's because when
> deciding how much of the image to be mirrored, the code looks at how
> much of the source image was allocated (for qcow2, this is only the
> written clusters; for raw, it is the entire file).  But the important
> part is that the destination file ends up smaller than 3M, rather than
> the 20M it used to be before this patch series.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> v3: Improve test with more cases
> v4: drop -machine q35 from command line [Stefan], update to
> match rework in rest of series
> ---
>  tests/qemu-iotests/tests/mirror-sparse     | 125 +++++++
>  tests/qemu-iotests/tests/mirror-sparse.out | 365 +++++++++++++++++++++
>  2 files changed, 490 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/mirror-sparse
>  create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jwiHnwN6ES5PaHEI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiQYUACgkQnKSrs4Gr
c8hMgQgAqr9GLNLfwxxO8HPMt3zIcSjIQSzwVa2N2+D6CY/6OcdicvmVMQKT42Uc
/T6SyF6pxmDXdmQf10GZxGYi8f7F9zv6EpatoZ+Se1hweJxqBVn4/GqQhQIoWvBX
ODGLrty1IdHIr5WfHuYw4HMU/fBSiscn1VjB+tlpqjws5+BcofSAp1YdV8+dxj8P
GdTEMUbOlzkN0rhIfwoQuS3TMcZAF4120RZHHnE4L7eQCiZD54HDqig/XCPVfPsr
xqG4CYo1Zu+/uYmwQMh13Pt6CtIkaqsdDlTs+i+lUsAU5zRHhne1JHexc5dZ7yl5
Apbo3y44WRlERRBch+q2R4xZNAgpLg==
=dtW/
-----END PGP SIGNATURE-----

--jwiHnwN6ES5PaHEI--


