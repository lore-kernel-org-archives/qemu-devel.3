Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02E1C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRac9-0005ZQ-Ez; Wed, 10 Jul 2024 12:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRac7-0005YM-VB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRac6-0008SF-6O
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720630575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eVCHgcYzppXb1fTnKhjITqUh89iZ1lDod90+C6nEv7o=;
 b=ORpSSfLEiceJjh0n8QTwrncFeFfXv4dX0RIwXSvSyIDT8t/K1qfR0opP4YJxP5+I0PSalh
 YWnyBQ0bWaomC47eoTPfTCIKdjFLyTey/80TsrMcMIXXGmvA3+Jx+chNuNIwcIRuqyWKIN
 hAN/9KxdEFjY0NWaA7p+eBVJcVPivlg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-zVp2ef5NMW2cxa02yimy4g-1; Wed,
 10 Jul 2024 12:56:11 -0400
X-MC-Unique: zVp2ef5NMW2cxa02yimy4g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73BD1196E0A3; Wed, 10 Jul 2024 16:56:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42D471955F3B; Wed, 10 Jul 2024 16:56:08 +0000 (UTC)
Date: Wed, 10 Jul 2024 18:56:07 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Subject: Re: [RFC] Per-request private data in virtio-block
Message-ID: <20240710165607.GA542210@dynamic-pd01.res.v6.highway.a1.net>
References: <20240710100803.6644-1-dmitry.fleytman@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ae/AOsY9XTSvpKTq"
Content-Disposition: inline
In-Reply-To: <20240710100803.6644-1-dmitry.fleytman@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ae/AOsY9XTSvpKTq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 01:08:03PM +0300, Dmitry Fleytman wrote:
> Hello QEMU-DEVEL! It's been a while=E2=80=A6
>=20
> I work on a solution for "smart" IO caching on the host side.
> The configuration is virtio-block device backed by SPDK with OCF/OpenCAS
> on top of remote storage.
>=20
> To improve decision making for caching, I would like to have an additional
> per-request contextual information from the guest side. It might include
> information about process issuing an IO request, a file this request it t=
ied
> to and so on. In general, I'd like the set of collected information to be
> flexible and configurable.
>=20
> I searched mailing lists and other related sources and surprisingly found=
 no
> mentions of the topic of having custom per-request data in virtio rings.
> This makes me think that either I'm missing an obvious way of doing this
> or the concept itself is severely broken up to the point it's not even
> getting discussed. There is also a possibility that I'm just missing a pr=
oper
> search keywords...
>=20
> I understand there might be be security implications to be considered.
> Also having custom kernel patches to have a flexibility of choosing which
> data to collect is probably not a viable solution.
>=20
> Please share your thoughts.
>=20
> I would like understand what is the right way of doing what I'm looking f=
or.
> If there are new mechanisms to be implemented in virtio or other parts of
> the codebase, I'll gladly work on this for the sake of community.

Hi Dmitry,
Welcome back! The struct virtio_blk_outhdr 32-bit ioprio field is
currently ignored by many device implementations. Is I/O priority
directly related to cache behavior? If yes, your virtio-blk device
implementation could interpret this field. If not, then it's probably
better to add a separate field.

It would be technically possible to add a virtio-blk feature bit for
per-request metadata. Plumbing this new metadata through the stack
requires changes to multiple software components though and might be the
reason why something like this does not exist.

virtio-blk generally sticks to the generic block device model that the
Linux kernel block layer implements. If the Linux block layer doesn't
have the cache metadata concept, then it may require some convincing of
the VIRTIO and Linux communities to add this new concept. Is the concept
of cache metadata (separate from I/O priority in Linux) a thing?

If you can show examples from other storage protocols like NVMe or SCSI,
then that would help in designing a virtio-blk solution too.

Stefan

>=20
> Thank you,
> Dmitry
>=20

--ae/AOsY9XTSvpKTq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaOvScACgkQnKSrs4Gr
c8gwuAgAr5hQ8E1sHLpKm1Xgz8NgE0DSbAfji2TteYDulyD/ADg9XsmQjjVwEfrR
bNyWpmNn9dLl2C7F8KrRhfvtJdOQ1Sj5t6/vVM9J8GfD3BMiR0buvxSe477H16yT
fdm7h/dtUX4xbMpAmWJG4iaKkxwwmlYlIyvEChflgsGIxHjJ8/kNBUqFyj+ZkCfy
z7zsJ7bfLWENoIa6a/JfoUAzmrjDuYXHLB7A9FRzWheadJgS1CA24CUseVObwUHf
YinD7SBsswudFp2t/gvpEQTsjRf9G+77c7tps0BA6FTnDNpVKCpPntNDtphY8bEJ
ORaC229S6TIqjY9L90XET9pMozUQfg==
=ZQ68
-----END PGP SIGNATURE-----

--ae/AOsY9XTSvpKTq--


