Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7958ACCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhv21-0002kg-Mp; Mon, 19 Jan 2026 14:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhv1p-0002fu-4R
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:35:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhv1m-0005nN-Ev
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768851305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kglsyJ/EEW9ertICdR9hPO2CeCmGxxU7LTwapg51F4g=;
 b=BvgCl7JBajA6BjG8V52XnM5WrZG9zX86j0YdXIhA0Dloeg5xYSLUifEUxP11M0edVtXs/X
 VKwlok6l2xA/dEk2+Q9iEANPf8cNvae7Yio2iiZJ+qr9gnLenVQ9NT6qOHm0ax+gZAaDNF
 quLkIcZvAYYuul9krmy1ZAAKVfAEZxc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-SJoNYL5wMNC4eHMubUWiGA-1; Mon,
 19 Jan 2026 14:35:01 -0500
X-MC-Unique: SJoNYL5wMNC4eHMubUWiGA-1
X-Mimecast-MFC-AGG-ID: SJoNYL5wMNC4eHMubUWiGA_1768851300
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40ECC19560B9; Mon, 19 Jan 2026 19:35:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9DC319560AB; Mon, 19 Jan 2026 19:34:59 +0000 (UTC)
Date: Mon, 19 Jan 2026 14:34:52 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net
Subject: Re: [PATCH 4/6] block/io: safeguard max transfer calculation in
 bdrv_aligned_pwritev()
Message-ID: <20260119193452.GC834718@fedora>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260109120837.2772961-5-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8QH/FGS/1dW9jQju"
Content-Disposition: inline
In-Reply-To: <20260109120837.2772961-5-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--8QH/FGS/1dW9jQju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 01:08:31PM +0100, Fiona Ebner wrote:
> This partially fixes iotest 177 with qcow2, where max_transfer is
> 64KiB, but the cluster size and thus pwrite_zeroes_alignment is 1MiB.
> Previously, max_transfer would be calculated as 0, triggering an
> assertion later.
>=20
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/io.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 12dc153573..233b2617ea 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2087,8 +2087,10 @@ bdrv_aligned_pwritev(BdrvChild *child, BdrvTracked=
Request *req,
>      assert(is_power_of_2(align));
>      assert((offset & (align - 1)) =3D=3D 0);
>      assert((bytes & (align - 1)) =3D=3D 0);
> -    max_transfer =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, I=
NT_MAX),
> -                                   align);
> +    max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX);
> +    if (max_transfer > align) {
> +        max_transfer =3D QEMU_ALIGN_DOWN(max_transfer, align);
> +    }

max_transfer < align seems paradoxical. It's a situation where the
largest allowed I/O request cannot meet alignment requirements.

Every other place that uses max_transfer in QEMU would also need to cope
with this.

block/blkdebug.c:blkdebug_open() fails if max_transfer is not aligned,
indicating that there are assumptions at least in some places that
max_transfer is aligned.

I hesitate to make this change because I fear it will break more things.
Why was max_transfer 64KB while pwrite_zeroes_alignment was 1MiB? Either
max_transfer should fit the alignment or pwrite_zeroes code needs to
distinguish between actual write zeroes operations and read-write-modify
I/O (which is plain read/write and not subject to
pwrite_zeroes_alignment).

Stefan

--8QH/FGS/1dW9jQju
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmluh1wACgkQnKSrs4Gr
c8jbtwgAsaTatgC3GRiflkteqbsfJ2y/NhfBQc59tzsjYQRnZJ4+X9FG0lPsEe0V
5Zi6+XGTwbQoAA4UkIZDYIULb93udR/xWyQhybLPRN1Acj2ScoMaWZzOaeEfXhYf
t+wDvnSrlrW7XjBRXfpiyZpIKburcEhwuO7TTNNHPDq4h3Rgj69R7oEHoyvFnXGA
6bgfsAANzWWBN3KW1gbe4PIgJBtryOz/kc3Q9y2zAqnwzhpPtJuR4uH5WorN1/kx
SmMeaODInV3Jaemnm+xdVdI3WVPqphHkZ8dB05wsfJlOIhH60W6P+La+J6YOMpRJ
EgRuMzT4CQP0F5921FOG8bVNqAC7AA==
=q2p8
-----END PGP SIGNATURE-----

--8QH/FGS/1dW9jQju--


