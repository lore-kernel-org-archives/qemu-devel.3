Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6348C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEUwT-0001h7-Iv; Mon, 12 May 2025 11:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEUwR-0001g6-EO
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEUwP-0004tM-DW
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747063178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLtxXX1c70EAvIDPVPzdpSEnOyNYQ0OJA9UTf/AoofA=;
 b=H0658byp3wg5434SIkLppWuwAgfVfUgCzKeAiXpJEx0puEE5CZ11RUsIz8bmUTeCNNHy+V
 YwwaL3LgZubhrCmD/gEOVryoTH+tGmZjcGnuNRFc9IY24QtWpEEUO9ZoZSEc9dzZPo6EzC
 wG35/5PYL6iOWhC4pq1ziJo1bcTb75g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-JhKZuQPsNTKubCjYUWftxA-1; Mon,
 12 May 2025 11:19:35 -0400
X-MC-Unique: JhKZuQPsNTKubCjYUWftxA-1
X-Mimecast-MFC-AGG-ID: JhKZuQPsNTKubCjYUWftxA_1747063174
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD7231956051; Mon, 12 May 2025 15:19:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAACC19560A3; Mon, 12 May 2025 15:19:32 +0000 (UTC)
Date: Mon, 12 May 2025 11:19:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sunnyzhyy@qq.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 07/13] mirror: Pass full sync mode rather than bool to
 internals
Message-ID: <20250512151931.GC141177@fedora>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-22-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u0fQhcjDj8Db1U07"
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-22-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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


--u0fQhcjDj8Db1U07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:40:24PM -0500, Eric Blake wrote:
> Out of the five possible values for MirrorSyncMode, INCREMENTAL and
> BITMAP are already rejected up front in mirror_start, leaving NONE,
> TOP, and FULL as the remaining values that the code was collapsing
> into a single bool is_none_mode.  Furthermore, mirror_dirty_init() is
> only reachable for modes TOP and FULL, as further guided by
> s->zero_target.  However, upcoming patches want to further optimize
> the pre-zeroing pass of a sync=3Dfull mirror in mirror_dirty_init(),
> while avoiding that pass on a sync=3Dtop action.  Instead of throwing
> away context by collapsing these two values into
> s->is_none_mode=3Dfalse, it is better to pass s->sync_mode throughout
> the entire operation.  For active commit, the desired semantics match
> sync mode TOP.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> v4: new patch
> ---
>  block/mirror.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u0fQhcjDj8Db1U07
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiEYMACgkQnKSrs4Gr
c8hyaAf9Frzhf6E+2G6x5mv7agTu/Ek84pacV6jCpiPBHpLGkz6w7iQ4OUY0A21K
9VUGvT9eH1Bkll4R9rWHW2VEmTusIhrO2lqvHNLiwVbHgZUMWi/QKnKhhcMFmLUK
BrrxC3zK8dLQZSnFe5Scap8QgD78wI83hPSxNx5wvnSzSOtttWMzP8L99rvXUCrW
iR3BqP78OPENngFR9dKlWlyLVWs9356Nv+sG06VJ6VJXnVN8SLFkVWevEFzhXpKF
/rZWaW46uJufOwp1EcrwvcANX769sVksKXLyUARjY6NNLYdGr00VUlgNjbCKmxGP
HfnoxXu2b0zXu4J9TpBhbo/RmaeDeQ==
=2sq4
-----END PGP SIGNATURE-----

--u0fQhcjDj8Db1U07--


