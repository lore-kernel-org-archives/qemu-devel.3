Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66902C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMkZ-0007RC-Sj; Tue, 05 Aug 2025 14:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujMkU-0007Qs-AN
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujMkO-0001qf-PN
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754419839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtexMaHpgqDijbN1HxJZm642G9CEkdtnnSkHs0xbylM=;
 b=VUIruMQnyPoWqTaFen2FH6LkxKY+bEarml4ruEPhKhEkyVe1KqBulOyKEVvFfTb0jQ4k9r
 8MpuuiHDjNrxc9MlQ+ohQcBGrNNHhhphDyUAyMsrvW/Bn7YrNMzDjCuRerofz0SAohD8uU
 iypFCo+NXU5A0UVkHQcImQ12Rxk0ZjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-ovlV87itN3G1yo1qe712nQ-1; Tue,
 05 Aug 2025 14:50:38 -0400
X-MC-Unique: ovlV87itN3G1yo1qe712nQ-1
X-Mimecast-MFC-AGG-ID: ovlV87itN3G1yo1qe712nQ_1754419837
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 328DB180035F; Tue,  5 Aug 2025 18:50:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.205])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BDA81800EEC; Tue,  5 Aug 2025 18:50:34 +0000 (UTC)
Date: Tue, 5 Aug 2025 14:50:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial v2] tests/qemu-iotests/tests/mirror-sparse: skip
 if O_DIRECT is not supported
Message-ID: <20250805185033.GA21348@fedora>
References: <20250805181731.282677-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kL1u8aRzbLQtzvdo"
Content-Disposition: inline
In-Reply-To: <20250805181731.282677-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--kL1u8aRzbLQtzvdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2025 at 09:17:30PM +0300, Michael Tokarev wrote:
> This test uses cache.direct=3Dtrue, but does not check if O_DIRECT
> is supported by the underlying filesystem, and fails, for example,
> on a tmpfs (which is rather common on various auto-builders, in CI,
> etc).
>=20
> Fix this by using `_supported_cache_modes none directsync`.
>=20
> Fixes: c0ddcb2cbc146e "tests: Add iotest mirror-sparse for recent patches"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v2: use `_supported_cache_modes none directsync` instead of _require_o_di=
rect
>     as suggested by Philippe.
>=20
>  tests/qemu-iotests/tests/mirror-sparse | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kL1u8aRzbLQtzvdo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiSUngACgkQnKSrs4Gr
c8g5IQgArXm/5R5bVtNLP12ZzuxEEqPFMh2KH+s40zXHZJtBstF+mHRqGGHMR69O
qafBby1r5kIgnmjtRN5Zb7WJKgAPBkyWJ3wqLRmFfLj6u2vo4MDk5n2Z+MSeHuB9
z5Wsyec7h/8iQTXeV1wYUrhjGZhV9dbRNjcNLbyHyu2xXOTH7o3iftXHqXin+HU/
oGJEDwUibnJj6VVjko9WPPSu+E4C6OpWRDxLtOi/2XKmxum4gvL3A5IsfxHYRmHj
UmcZ8GoR3gzeFpRSUymx6hCYPjTNkSvUYNgfGeGNs3GEzn0QH4XAjgCHw77vgoss
hb04n2uKnR8hqJ6tuNUCsszjEgE15A==
=4NGq
-----END PGP SIGNATURE-----

--kL1u8aRzbLQtzvdo--


