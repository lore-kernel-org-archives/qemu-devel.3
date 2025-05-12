Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E83AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV1k-0005mi-AS; Mon, 12 May 2025 11:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEV1e-0005b8-Sy
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEV1c-0005gJ-W1
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747063504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qy1Y4eaUU1ZAtjuVy27OmIzUJAawbMNPkuRiCLoUKQ=;
 b=G+A+IDH35bY3+JnewTfrI0a0TDwTqgkHUvhaAa2RLVRwJ7CzDuLBDtiw9WqaF2adCW78cB
 DHpCfah3laDk+g+nS4h0y8HUwIPAfhXnlkE3s9/qRn7PF3cFVMh3Il97tfmDRczDnNavJP
 pOwRUHr/HPGbxfWFr+HeONcvLKS9v3M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-ZpR2qurkMwmlGID68BEmNQ-1; Mon,
 12 May 2025 11:25:00 -0400
X-MC-Unique: ZpR2qurkMwmlGID68BEmNQ-1
X-Mimecast-MFC-AGG-ID: ZpR2qurkMwmlGID68BEmNQ_1747063499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FD881955D78; Mon, 12 May 2025 15:24:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB5CE1800359; Mon, 12 May 2025 15:24:58 +0000 (UTC)
Date: Mon, 12 May 2025 11:24:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sunnyzhyy@qq.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 09/13] mirror: Drop redundant zero_target parameter
Message-ID: <20250512152457.GE141177@fedora>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-24-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="epsIZn34KWyvIxu2"
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-24-eblake@redhat.com>
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


--epsIZn34KWyvIxu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:40:26PM -0500, Eric Blake wrote:
> The two callers to a mirror job (drive-mirror and blockdev-mirror) set
> zero_target precisely when sync mode =3D=3D FULL, with the one exception
> that drive-mirror skips zeroing the target if it was newly created and
> reads as zero.  But given the previous patch, that exception is
> equally captured by target_is_zero.  And since we recently updated
> things to pass the sync mode all the way through to
> mirror_dirty_init(), we can now reconstruct the same conditionals
> without the redundant parameter.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> v4: new patch
> ---
>  include/block/block_int-global-state.h |  3 +--
>  block/mirror.c                         | 13 +++++--------
>  blockdev.c                             | 15 ++++-----------
>  tests/unit/test-block-iothread.c       |  2 +-
>  4 files changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--epsIZn34KWyvIxu2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiEskACgkQnKSrs4Gr
c8jhjQf8DQrT1EEF5P2++ZMqPaXNQnZV3xbrrueRqzvwqt69mZTtPJ/UtgOBr2bA
KN8t0M3u9+OrXg/h+rA65zZjA9wY9ZFvIgnpsHwMgb0ADX9pDVrmkS9tYF7GdLbl
ULuZkEQ29bvTirWR+Bxqsl4AuqXO+YyGw7azSC+fs+DNSDEjcSdi8WZCwuiksED/
bcVEel/sBAHZRhWEXKfACsm+FjHdk51QquAwCOo70p+dl1+YFT8HLrNXgddcsM+U
zLLz9ohWhvWZddepIMOwS9VnAIb6Ln2kMEQ6KKwwQmb5/+l01tFNbnFYq1tebXVR
yo1RDdGj2PgwIO+2peYZMOwknV5C+w==
=TQCt
-----END PGP SIGNATURE-----

--epsIZn34KWyvIxu2--


