Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE138CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhv5S-0004Pq-R9; Mon, 19 Jan 2026 14:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhv5Q-0004PI-VK
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhv5P-0006D5-GQ
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768851531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Z9+6YDo+lr0CTenV+8mGtka2EAIj9PRKALvLNUhezs=;
 b=AfjcZCSAGfqTp5n1+fO72Ak77lPMwNSTlsPr5P4KjaoG6GDRh8sqnhEkWdd8LY/fVXGDkz
 7ku+4bxVamE1p0dtNX0RMq/pD6JJ1Mo/zEcHLevwSvOxDO3BitTDHuXziD8gCZacZr3Psz
 FG+9WlCwrITB146wmck0cBIvicLmxhc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-l4lH3rqFOq2OyrkZz37jaA-1; Mon,
 19 Jan 2026 14:38:47 -0500
X-MC-Unique: l4lH3rqFOq2OyrkZz37jaA-1
X-Mimecast-MFC-AGG-ID: l4lH3rqFOq2OyrkZz37jaA_1768851526
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D2D01956096; Mon, 19 Jan 2026 19:38:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22BB51800285; Mon, 19 Jan 2026 19:38:44 +0000 (UTC)
Date: Mon, 19 Jan 2026 14:38:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net
Subject: Re: [RFC v2 0/6] block/io: avoid failure caused by misaligned
 BLKZEROOUT ioctl
Message-ID: <20260119193844.GD834718@fedora>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T9z4guv+dBc0knVd"
Content-Disposition: inline
In-Reply-To: <20260109120837.2772961-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--T9z4guv+dBc0knVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 01:08:27PM +0100, Fiona Ebner wrote:
> Previous discussion here:
> https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@proxmo=
x.com/
>=20
> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
> certain 'qemu-img convert' invocations, because of a pre-existing
> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
> the request is shorter than the block size of the block device.
>=20
> Stefan suggested prioritizing bl.pwrite_zeroes_alignment in
> bdrv_co_do_zero_pwritev(). This RFC explores that approach and the
> issues with qcow2 I encountered, where
> bl.pwrite_zeroes_alignment =3D s->subcluster_size;
> I would be happy to discuss potential solutions and whether we should
> use this approach after all.

These issues are a headache, but I think it's important for us to
consider them. They indicate that QEMU does not properly distinguish
between read/write and pwrite_zeroes constraints.

If we can agree on how the block layer should handle pwrite_zeroes
constraints in a consistent way that makes the tests pass, then that
should serve the QEMU block layer well in the future.

I will mention this patch series to Kevin as well so we can get his
opinion.

>=20
> For example, in iotest 154 and 271, there are assertion failures,
> because the padded request extends beyond the end of the image:
> Assertion `offset + bytes <=3D bs->total_sectors * BDRV_SECTOR_SIZE ||
> child->perm & BLK_PERM_RESIZE' failed.
> The total image length is not necessarily aligned to the cluster size.
> This could be solved by shortening the relevant requests in
> bdrv_co_do_zero_pwritev() and submitting them without the
> BDRV_REQ_ZERO_WRITE flag and with bl.request_alignment as the
> alignment see patch 5/6.
>=20
> For iotest 179, I would need to avoid clearing BDRV_REQ_ZERO_WRITE for
> the head and tail parts as long as the buffer is fully zero.
> Otherwise, we end up with more 'data' sectors in the target map. See
> patch 6/6. With or without that, iotests 154 and 271 produces
> different output (I think it might be expected, but haven't checked in
> detail yet).
>=20
> Another issue is exposed by iotest 177, where the (sub-)cluster size
> is 1MiB, but max-transfer is only 64KiB leading to assertion failures,
> because max_transfer =3D
> QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX), align);
> evaluates to 0 (because align > bs->bl.max_transfer). This could be
> fixed by safeguarding doing the QEMU_ALIGN_DOWN only if the value is
> bigger than align, see patch 4/6.
>=20
> I'm also not sure what to do about iotest 204 and 177 which use
> 'opt-write-zero=3D15M' for the blkdebug driver (which assigns that value
> to pwrite_zeroes_alignment) making an is_power_of_2(align) assertion
> fail.
>=20
> Yet another issue is the 'detect_zeroes' option. If the option is set,
> bdrv_aligned_pwritev() might set the BDRV_REQ_ZERO_WRITE flag even if
> the request is not aligned to pwrite_zeroes_alignment and the original
> bug could resurface.
>=20
> Best Regards,
> Fiona
>=20
>=20
> Fiona Ebner (6):
>   block/io: pass alignment to bdrv_init_padding()
>   block/io: add 'bytes' parameter to bdrv_padding_rmw_read()
>   block/io: honor pwrite_zeroes_alignment in bdrv_co_do_zero_pwritev()
>   block/io: safeguard max transfer calculation in bdrv_aligned_pwritev()
>   block/io: handle image length not aligned to write zeroes alignment in
>     bdrv_co_do_zero_pwritev()
>   block/io: keep zero flag for head/tail parts of misaligned zero write
>     when possible
>=20
>  block/io.c | 78 ++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 23 deletions(-)
>=20
> --=20
> 2.47.3
>=20
>=20

--T9z4guv+dBc0knVd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmluiEMACgkQnKSrs4Gr
c8hORggAv9GRNWrtQC1bx5+NZxmQfeawhbEOTDRECUxvFPmmAzqx6WUYfvzdVdpa
Wru/E6UDCADeRJvUtY4yuqAGAQfYEha5G6DfpJhuDnENrydH26XfLAFq7v1SmBWM
GkO2aPYG3eOQSBiEN8BiZMOqhRdzgtfcoiMcHo5e/+rOo+Tt1p31ERi9zJ8fsuxj
n6IaaP1qnRjf4gj+ESvFNZ3JY+xWani7mOUWoLQbJxhayPhwzlGXuqfgVGu0hosV
BSEjjJ2zu1HK947VymoTaAzw3VpTUjz67sjRXc1YIbZwAhvbqA60s9rwwamss/Z0
CfIMsxEW8fU/nsRR/gKQNfn0IyeF1w==
=Zc/u
-----END PGP SIGNATURE-----

--T9z4guv+dBc0knVd--


