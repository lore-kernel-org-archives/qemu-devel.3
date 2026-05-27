Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C6CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 18:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSIna-0003Ig-9l; Wed, 27 May 2026 14:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSInY-0003I3-Ty
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSInX-0001cy-IQ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779905766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POc/+WfHzHWz8k02l7Ni+KisQvIGSX/K+2stjcaJccg=;
 b=O8bXuULdbWDTHA1ZQ7Sr8j3yT+4tLHCjo5Ho4DKjrli/vK82zVvv7e3bPdd9NAWklOVMcN
 Nz90SxuOT9XDC2gsiwT9XvOzbRP+TEA+4oiIhF7irxfuT+R3bQ7Dy78DfWv+vbOvnxvJJP
 bPeuYkLgIPOwj/r0Ma7praOUc4wao5k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-wjVf8s15NUCmQOMcbZpYnw-1; Wed,
 27 May 2026 14:16:01 -0400
X-MC-Unique: wjVf8s15NUCmQOMcbZpYnw-1
X-Mimecast-MFC-AGG-ID: wjVf8s15NUCmQOMcbZpYnw_1779905755
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A88E51955F18; Wed, 27 May 2026 18:15:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.86])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24C231800347; Wed, 27 May 2026 18:15:54 +0000 (UTC)
Date: Wed, 27 May 2026 14:15:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] iotests/136: Test stats-intervals with -blockdev/-device
Message-ID: <20260527181553.GB1762453@fedora>
References: <20260521101854.31997-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2dWyU7yPBErKVlA3"
Content-Disposition: inline
In-Reply-To: <20260521101854.31997-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--2dWyU7yPBErKVlA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 12:18:54PM +0200, Kevin Wolf wrote:
> Commit 9f0c763e introduced the "stats-intervals" qdev property for
> block devices, a setting that was previously only accessible with
> -drive. Extend the corresponding test to include test cases that set the
> property on -device instead, both with -drive and -blockdev.
>=20
> We wouldn't really improve coverage with testing every combination of
> account_invalid and account_failed with all modes to set up statistics,
> so it seems good enough to test all combinations with the old way, and
> only both True or both False with the additional ways.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/136     | 87 ++++++++++++++++++++++++++++++++------
>  tests/qemu-iotests/136.out |  4 +-
>  2 files changed, 77 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2dWyU7yPBErKVlA3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoXNNkACgkQnKSrs4Gr
c8isJQf9E+IdPTKPL/39x1uFehIiPhXAW1gsaqvjVVsseRfsevyf2D8MZ/1h1Wzk
9iABEjLZufQZ3EQqLhncWxp7+sLwNicC2/ID/dH6dB5WFfpFpSFcDL8GDJQ7d7bv
RtpAyEEKQbZ/CgTxA/0HLFhuFFHxV7b3wijZV6K6rSwE3CaHOTsQpgrmbomjaGLJ
F3ODKrHUyp8iRL03KuFiVn0/snVvnO/RWM7Fylafzf/2XNZ743rzpSrB7+uWZjOZ
GuMrmVG4cyP5ZDHcH9xtJoCV7KknhE8UAMms7RzVlJhTZKaL3ijvkUDWeXUcZAhA
JZjIead1zz6PSywt/b/04q3n8Ju5ZA==
=zPjJ
-----END PGP SIGNATURE-----

--2dWyU7yPBErKVlA3--


