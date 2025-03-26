Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973EFC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSL6-0002du-NU; Wed, 26 Mar 2025 11:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txSL2-0002ZK-Qr
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txSKz-0002vV-Ke
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743001596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3rRonVveb6ng06ZVyE/PrPgcb2jEXEF8myNjaRzegiY=;
 b=F8kqEo6V9RAaO/ZabuaaNpGaKgghqSLvh9eJkjc7cQW07wiQG0RjdQXJWSPSqK0nv2FeFI
 73cZaG9lVfrikEfEVJKVtqYdu/zU6JrFpowIXDXGJJH/dRd5F7/X9z032imtkU0iVQ/qZ+
 dgQl/R5yxN0oOam5EIWmSfPF8pRwxms=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-ovfR30d5NKGSJinW8oxsQA-1; Wed,
 26 Mar 2025 11:06:29 -0400
X-MC-Unique: ovfR30d5NKGSJinW8oxsQA-1
X-Mimecast-MFC-AGG-ID: ovfR30d5NKGSJinW8oxsQA_1743001585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DCE3180AB19; Wed, 26 Mar 2025 15:06:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.113])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0B9F1801750; Wed, 26 Mar 2025 15:06:21 +0000 (UTC)
Date: Wed, 26 Mar 2025 11:06:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 hreitz@redhat.com, alex.chen@huawei.com, chenjianfei3@huawei.com,
 eric.fangyi@huawei.com, luolongmin@huawei.com,
 mujinsheng@huawei.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, renxuming@huawei.com,
 suxiaodong1@huawei.com, wangjian161@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com, zhuyangyang14@huawei.com
Subject: Re: [PATCH v3 0/2] qapi/throttle: Fix qmp_block_set_io_throttle
 blocked for too long
Message-ID: <20250326150620.GF783416@fedora>
References: <20250326092634.1691355-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bsOd05ymlpMMikiU"
Content-Disposition: inline
In-Reply-To: <20250326092634.1691355-1-zoudongjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--bsOd05ymlpMMikiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 05:26:32PM +0800, zoudongjie wrote:
> From: Zhu Yangyang <zhuyangyang14@huawei.com>
>=20
> Calling qmp_block_set_io_throttle() will be blocked for a long time
> when a network disk is configured and the network failure is just about
> to occur.
>=20
> This series add a timeout parameter for qmp_block_set_io_throttle to cont=
rol
> its execution duration.
>=20
> Changelog
> v3 ---
>   Unify AIO_WAIT_WHILE_{TIMEOUT/INTERNAL} by replacing AIO_WAIT_WHILE_INT=
ERNAL() with
>   AIO_WAIT_WHILE_TIMEOUT(..., 0).
>=20
> v2 ----
>   1. Support 0 in BDRV_POLL_WHILE_TIMEOUT(), 0 means infinite.
>   2. Use uint64_t timeout_ns instead of int64 timeout to name variables.
>   3. Use timer_pending() to check for expiry instead of explicitly checki=
ng
>      against the deadline for BDRV_POLL_WHILE_TIMEOUT().
>   4. Add documentation for bdrv_drained_begin_timeout(), note that bdrv_d=
rained_end()
>      must be called when -ETIMEDOUT is returned.
>   5. Add a timeout parameter to the qmp_block_set_io_throttle() instead o=
f hardcoding
>      the timeout, and the default value is 0, mean an infinite timeout.
>=20
> v1 patch link:
> https://lore.kernel.org/qemu-devel/20250308101618.721954-1-zoudongjie@hua=
wei.com/
>=20
> Zhu Yangyang (2):
>   io/block: Refactoring the bdrv_drained_begin() function and implement
>     a timeout mechanism.
>   qapi/throttle: add timeout parameter for qmp_block_set_io_throttle()
>=20
>  block/block-backend.c                       | 14 ++++-
>  block/io.c                                  | 58 +++++++++++++++++----
>  block/qapi-system.c                         | 10 +++-
>  include/block/aio-wait.h                    | 47 ++++++++++++-----
>  include/block/block-io.h                    | 22 +++++++-
>  include/system/block-backend-global-state.h |  1 +
>  qapi/block-core.json                        |  5 +-
>  util/aio-wait.c                             |  5 ++
>  8 files changed, 135 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.33.0
>=20

Aside from Markus' comments:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bsOd05ymlpMMikiU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfkF+wACgkQnKSrs4Gr
c8hDSAf+P5eL3gm158iJNBlkfDXrVAJibqSN9znmbs5OmpRh+JBlmUpDZpJhzxzS
s3gwO9zd+xbXDN7CCpdXiFO9XvGLkteK8Cr66xDS7NcFIoiekuykkhneYQQJvDAS
RLVa00Mw0r8XBljEDcSJGnAi3ny9mpBVOZMl7DTpwB85XmD67fvYlKITKCpRuXx5
mY3ZbyiJXoduSAgrPdf12HMErBPxrsNVT391zPh06pYN+wIPCGxf4jOuNs9KarBu
NQ0GMC6h/zEYsMuj3hwAD0Ji6lEs2AtPxsl60rq+nA+jVX3KP+M2McdG5PZ1L1Hu
ax75hbp32+FWiyI71iYlx9vhAlGRoQ==
=5ZsD
-----END PGP SIGNATURE-----

--bsOd05ymlpMMikiU--


