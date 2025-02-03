Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02189C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1YM-0002Yo-2K; Mon, 03 Feb 2025 13:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1YJ-0002UJ-V4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1YI-0005bv-Ko
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738608730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Y/AoclE7HgPsEOgf4dh4I5/WfiZz6+HymwOKJ96Tsk=;
 b=fE1MOYhRAsO+71ETLchQNqNyJTa4N3Ptjrp2hV5RJ3Ir3U61uI9XLOaSbNrY8zk/FILHlo
 SfZL5IWILLoaf4kCr9qXbNYgEmwqainSZ3ML7J+pYQGYkwf8hNgS09ngfwf9iA1qFIo1zo
 BH3irlV7LS/bodC68WKdrFu0RbeD4Mc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-ymFdgch6PP2z5LHgbnWqMw-1; Mon,
 03 Feb 2025 13:52:06 -0500
X-MC-Unique: ymFdgch6PP2z5LHgbnWqMw-1
X-Mimecast-MFC-AGG-ID: ymFdgch6PP2z5LHgbnWqMw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AEFC195608D; Mon,  3 Feb 2025 18:52:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F18641800360; Mon,  3 Feb 2025 18:52:04 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:52:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com,
 peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/15] block: Fix crash on block_resize on inactive node
Message-ID: <20250203185203.GH268514@fedora>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xksxgsysQwUcb37a"
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-7-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--xksxgsysQwUcb37a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 06:12:37PM +0100, Kevin Wolf wrote:
> In order for block_resize to fail gracefully on an inactive node instead
> of crashing with an assertion failure in bdrv_co_write_req_prepare()
> (called from bdrv_co_truncate()), we need to check for inactive nodes
> also when they are attached as a root node and make sure that
> BLK_PERM_RESIZE isn't among the permissions allowed for inactive nodes.
> To this effect, don't enumerate the permissions that are incompatible
> with inactive nodes any more, but allow only BLK_PERM_CONSISTENT_READ
> for them.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 7 +++++++
>  block/block-backend.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xksxgsysQwUcb37a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehEFMACgkQnKSrs4Gr
c8gkNQf/fNDZT/lRlzNQHWt4H2KV1UtfPM6+zXiw4MouR1xPrjiuyHDnRTcZ6VXd
IIZWXeUmu06vF4LN2I+29ZFZq+EBtLjKCDtxikWLe2q0Wdui5FQD6uwMpbMY6tLI
6b3Kk6ra2LlLnUrL+BWOAWm2IO71xRNZMtG6sDgxpb5Xw8KGDmCFdSQK8s6YmWGB
zx5nklxYAmfiVSZ/oc1EIJYuYk8fxxF1yXbikHv1chOqjFDXaJO/KXCAC0CV8qQI
2Ps12/fYc1e2jgxE9K0kHxTFji6jkl5WmEe9d7+Z43di1DTv3vE0TiXYMdy0Sz9l
rJKBFpPk0rejt8Dt3tVaY2wbtrPgPA==
=iyrp
-----END PGP SIGNATURE-----

--xksxgsysQwUcb37a--


