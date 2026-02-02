Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72F6E7FDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2E5-0003IR-Pr; Mon, 02 Feb 2026 17:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vn2Du-0002w5-Vc
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vn2Dt-0004D3-ED
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770070601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ogb4Jh1H3Y3EM60xBVtbpW82EvlnPjHBuRhczNvwOw0=;
 b=TLVbkfi7wfecWz4Uy670BszgPuH8zlwrgW+rsTXFjoXSU78Ao/dpWekSuYjVjR68zsnJOU
 NKo5BRH5PFtaadkBnC2n2oRb9HKOHXLwCAi5hQdTWDAlgYiPRv7hYXfAgx6u7+vhv57+q0
 nD5VVeKjQ/yexUUmmqAKQS9fDJ4eKks=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-bUvZkUL6PXCJKuLTc2g6gQ-1; Mon,
 02 Feb 2026 17:16:38 -0500
X-MC-Unique: bUvZkUL6PXCJKuLTc2g6gQ-1
X-Mimecast-MFC-AGG-ID: bUvZkUL6PXCJKuLTc2g6gQ_1770070597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A31418003FC; Mon,  2 Feb 2026 22:16:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.238])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC50F18002A6; Mon,  2 Feb 2026 22:16:35 +0000 (UTC)
Date: Mon, 2 Feb 2026 17:16:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net
Subject: Re: [RFC v2 0/6] block/io: avoid failure caused by misaligned
 BLKZEROOUT ioctl
Message-ID: <20260202221634.GB429972@fedora>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZucKMVebwz6IpsyF"
Content-Disposition: inline
In-Reply-To: <20260109120837.2772961-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--ZucKMVebwz6IpsyF
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

Hi Fiona,
I wanted to continue this discussion. My thoughts are that making
bdrv_co_do_zero_pwritev() use bl.pwrite_zeroes_alignment is the right
long-term solution to keep all the padding logic in one place.

On the other hand, your series shows it involves fixing a bunch of test
failures and that's not fun. The original bug that is being solved here
is my doing, so feel free to hand this over to me if you decide you
don't want to work on it.

Stefan

--ZucKMVebwz6IpsyF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmBIkIACgkQnKSrs4Gr
c8jdJAf+Kw8FDw/FZCeboZtPj481GVW92qiqtVZ6U6lzmwb6/SpmvnFt1sdc+i2A
fr90r2X0TljYA7B0ErJ0bv4AW2xJZfUxZ1gerTDZMuWA2dc4NVdmq91RxyW3zTub
QOoPmBoC3nyqA89ncVFYtPfpwW9hUj5JmE9YwnCmSi8kI5iUVetMyz89gVwus8qZ
QusAijADgtSd7xAb/FSGQmiGzHUpkGluhJmbMS4yMyqLckX2kyvKogwRMpBVtX54
iuWkwAg2WyPnQAVYhcMCvCrCuP/EoJnzYJwBeYSwAwuS6TPTAXdeji+ffJSBwt5L
IgSFtA/38069FFf8md+LD8T5zOIzBw==
=PJ7a
-----END PGP SIGNATURE-----

--ZucKMVebwz6IpsyF--


