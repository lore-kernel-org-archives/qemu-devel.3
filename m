Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41C5CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6Gs-0002TY-CG; Mon, 01 Jun 2026 13:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU6Gk-0002T3-Fq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU6Gi-0002P0-A5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780334258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8C3KQNIXRRELWeguN6ZOaWoiwIHhws8Plj2GkOduosE=;
 b=iPtQd/pN0vPUtiUub+RXIEKIHxCjEexMhXCGi/bP9cXxJn196+HPp8/qGNNtJSyw3nZoC1
 Shs5u4JHN5eSjjgD2CXJ02U8Ym1J+mQZ9RtWcqn32jlYFnO5qkoGqFdzPDmZJnj0rEppYV
 EGe53DX8YZizy6qBuYonXiFj2QHI83w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-KLZ9t49yOEKcXm9BvWpWDw-1; Mon,
 01 Jun 2026 13:17:37 -0400
X-MC-Unique: KLZ9t49yOEKcXm9BvWpWDw-1
X-Mimecast-MFC-AGG-ID: KLZ9t49yOEKcXm9BvWpWDw_1780334256
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84BEF18005B8; Mon,  1 Jun 2026 17:17:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87A6B1800465; Mon,  1 Jun 2026 17:17:34 +0000 (UTC)
Date: Mon, 1 Jun 2026 13:17:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net
Subject: Re: [PATCH] block/io: fallback to bounce buffer if BLKZEROOUT is not
 supported because of alignment
Message-ID: <20260601171733.GA458909@fedora>
References: <20260105143416.737482-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HwfMOKvbmJ3/P17U"
Content-Disposition: inline
In-Reply-To: <20260105143416.737482-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--HwfMOKvbmJ3/P17U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 03:29:55PM +0100, Fiona Ebner wrote:
> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
> certain 'qemu-img convert' invocations, because of a pre-existing
> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
> the request is shorter than the block size of the block device.
> Fallback to the bounce buffer, similar to when the ioctl is not
> supported at all, rather than treating such an error as fatal.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3257
> Resolves: https://bugzilla.proxmox.com/show_bug.cgi?id=3D7197
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my block tree with a TODO comment about
taking the write_zeroes_alignment limit into account:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--HwfMOKvbmJ3/P17U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodvq0ACgkQnKSrs4Gr
c8iR4gf6Av/pkKoIBNPTw9cMRRPGxl8RUbhyH6Nm3fTEDuyUYxuW+377tyNkqB0x
XbGRyMPqZcl1YdhNZ6jLNp7ACQkSQhjMC/obHRBu5wLTllo/AsLQgZtYfcvLR9Dj
et8q/qGyK0ZH34CsikiXUPP5Betk9z/moMG3ZhJwfeAhKtPtof2WJ/a6lwlW12a1
WlOdvVDX9NsNdtTdKAFF0gBPbcTkJgv8VJ0sGjM7kITl2NnNZq4f0yCfz/ApwEe5
e9h1rmxJ0FSPscHY3J9M7jQ941fa9hdHxTY4SEerCrNyoVAHhr/2RbBqgMwpfLgf
Vidr3it0GutPGkIgmrft4Q8AKJxAMw==
=5zg4
-----END PGP SIGNATURE-----

--HwfMOKvbmJ3/P17U--


