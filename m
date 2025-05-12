Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE370C3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEY5p-0005T8-E6; Mon, 12 May 2025 14:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEY5T-0005Nx-SY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEY5L-0004c1-O6
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747075263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giEm6KTYvaMPaFAiw6r2pxGrb25kccnv4p+hJDugP0w=;
 b=RmMHbhrBr9YSvZNDgRzZuQk9QiY6HV7tRdtf/H/HramtiIeRYJz1y2voDwcuiEvferpT6T
 qq1e3qsGMa2hCqcb+fi3Gt9sAyvJPe+rGSrsBOsmrHIuwv34Ec0ONosyytaNcCpgbU5umw
 +33ece/weZ2nWXicu2Hs5OyEySzGJjU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-JZ1Be_QQNuqo9tlQv8iTLg-1; Mon,
 12 May 2025 14:41:00 -0400
X-MC-Unique: JZ1Be_QQNuqo9tlQv8iTLg-1
X-Mimecast-MFC-AGG-ID: JZ1Be_QQNuqo9tlQv8iTLg_1747075259
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D201918001EA; Mon, 12 May 2025 18:40:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E95161940EB0; Mon, 12 May 2025 18:40:56 +0000 (UTC)
Date: Mon, 12 May 2025 14:40:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sunnyzhyy@qq.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v4 10/13] mirror: Skip pre-zeroing destination if it is
 already zero
Message-ID: <20250512184055.GF141177@fedora>
References: <20250509204341.3553601-15-eblake@redhat.com>
 <20250509204341.3553601-25-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1s9xHEsGJDIjvJTK"
Content-Disposition: inline
In-Reply-To: <20250509204341.3553601-25-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--1s9xHEsGJDIjvJTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:40:27PM -0500, Eric Blake wrote:
> When doing a sync=3Dfull mirroring, we can skip pre-zeroing the
> destination if it already reads as zeroes and we are not also trying
> to punch holes due to detect-zeroes.  With this patch, there are fewer
> scenarios that have to pass in an explicit target-is-zero, while still
> resulting in a sparse destination remaining sparse.
>=20
> A later patch will then further improve things to skip writing to the
> destination for parts of the image where the source is zero; but even
> with just this patch, it is possible to see a difference for any
> source that does not report itself as fully allocated, coupled with a
> destination BDS that can quickly report that it already reads as zero.
> (For a source that reports as fully allocated, such as a file, the
> rest of mirror_dirty_init() still sets the entire dirty bitmap to
> true, so even though we avoided the pre-zeroing, we are not yet
> avoiding all redundant I/O).
>=20
> Iotest 194 detects the difference made by this patch: for a file
> source (where block status reports the entire image as allocated, and
> therefore we end up writing zeroes everywhere in the destination
> anyways), the job length remains the same.  But for a qcow2 source and
> a destination that reads as all zeroes, the dirty bitmap changes to
> just tracking the allocated portions of the source, which results in
> faster completion and smaller job statistics.  For the test to pass
> with both ./check -file and -qcow2, a new python filter is needed to
> mask out the now-varying job amounts (this matches the shell filters
> _filter_block_job_{offset,len} in common.filter).  A later test will
> also be added which further validates expected sparseness, so it does
> not matter that 194 is no longer explicitly looking at how many bytes
> were copied.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> v3: add exemption for "detect-zeroes":"unmap" on destination
> v4: Rebase later in series, revise logic for pre-zeroing [Sunny], add
> in python filter
> ---
>  block/mirror.c                | 24 ++++++++++++++++--------
>  tests/qemu-iotests/194        |  6 ++++--
>  tests/qemu-iotests/194.out    |  4 ++--
>  tests/qemu-iotests/iotests.py | 12 +++++++++++-
>  4 files changed, 33 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1s9xHEsGJDIjvJTK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiQLcACgkQnKSrs4Gr
c8ig+AgAjvUHcA7ZAFBhBR2yXtmlu8CvQxgkqYxf6jEq7nwNPlNoEu/8te3O4MTK
8ISeB/j1Isp6xSlF+MCHffz73qzbESPAoelk5QcGFHF9SGYanm7d2XVJKwX/Pm1i
dgPCDA6LSyZn+mWXCUL9nLXdb75kR4yZAQNrsJdyIwhrLC+7OI14/ueV9zkySeTx
ejX+XwhHzMJxAV8uf5qmk1yBv0bZb6j0N3L5pW+PbLNg2Fnd/seKHgPn0jXQk2K6
y0/gMdx69wBQpGD8AUzu+/JB0AdnAZAuv2/rl73R55olDyc75fywOi3SIAHWNems
xMD/aSUCdFgz2+s0Lr7Btd9ug2cbVQ==
=nhlu
-----END PGP SIGNATURE-----

--1s9xHEsGJDIjvJTK--


