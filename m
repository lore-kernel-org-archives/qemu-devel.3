Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AECDC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUvV9-0003GE-U7; Tue, 30 Jan 2024 16:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUvUy-0003Ec-1L
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUvUu-0007yB-G0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706649500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=juo+uB97G7uvUEF2A7sGzP2HrvAvy+uGFwkEZdUorb4=;
 b=eUpbUl7hrHu3cg6vokwwVjmnxmKboQ4qCvkr/MzMCDDn5bQ2WRLC71LwrqQEs5LfdT0KZ9
 +YzPdhXkFnr15TyxEU0g0Eq36JPWf/hWjKhbYn4FLzGxJI0eD/GnGAsZdja8PbcrSvilko
 32QKZ8Ub5x7VnxWX1M6wo81UNpGqrwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-FXn5S3NEPxyzp9iDCIKzxA-1; Tue, 30 Jan 2024 16:18:16 -0500
X-MC-Unique: FXn5S3NEPxyzp9iDCIKzxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A483B868904;
 Tue, 30 Jan 2024 21:18:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B65E10EA6;
 Tue, 30 Jan 2024 21:18:14 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:18:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH] pflash: fix sectors vs bytes confusion in
 blk_pread_nonzeroes()
Message-ID: <20240130211813.GD320474@fedora>
References: <20240130002712.257815-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cba0tdl7Bm/UYdhy"
Content-Disposition: inline
In-Reply-To: <20240130002712.257815-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--cba0tdl7Bm/UYdhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 07:27:12PM -0500, Stefan Hajnoczi wrote:
> The following expression is incorrect because blk_pread_nonzeroes()
> deals in units of bytes, not sectors:
>=20
>   bytes =3D MIN(size - offset, BDRV_REQUEST_MAX_SECTORS)
>                                               ^^^^^^^
>=20
> BDRV_REQUEST_MAX_BYTES is the appropriate constant.
>=20
> Fixes: a4b15a8b9ef2 ("pflash: Only read non-zero parts of backend image")
> Cc: Xiang Zheng <zhengxiang9@huawei.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--cba0tdl7Bm/UYdhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW5Z5UACgkQnKSrs4Gr
c8iDQQgAqHUsLn7HzUu5GgzjSD5S56tSUUrKCHHkt53h7MbwCzUoFX5pax6yRHV3
pipnho/9dYP4C2klVxBE99HQO1yMZsH06SME/1bnU4VBU+pZqMpS0jopEq/0Tq+X
Qobc4R9tgAizULaZbWfj4gFT3eimRCJqhtTzNMaVmJJVkR5cTIFrTt195Z+6jyKO
xRmwKNj1apD0id51HDpOI3PWwnG4O8+hKSwow+7Rjx0/ZrMbQWasR6M9UWPDfuQb
V4gaTC6qMcfxHshyh5+kywxXuXpoB1cBvGcvZLtGE8V2b4t6Sig0GSkohbT8GJU4
bpd0nQz4jVLCxFLlOjfstH3Hec3RqQ==
=uk38
-----END PGP SIGNATURE-----

--cba0tdl7Bm/UYdhy--


