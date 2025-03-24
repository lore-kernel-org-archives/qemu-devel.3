Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996F1C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmIB-0002aO-V3; Mon, 24 Mar 2025 14:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twmIA-0002Zx-8w
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twmI8-0004H3-AZ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742839970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKhB18Cek92V2nGHHwD6m9Adcuf8cpkp56Pu+RdaoXA=;
 b=AdW83w+cCkEhySe7PtRd0YFCjxawCLCkW0rnsvtJYgpUrNkrFqlztGWeDxR5PvnXChpvHD
 whR4J9C7pIzOkp/G/MQ0/V67xwXK/IzDHDXBaYLp7/g5gflTJnFeNi2l8GHnLQUCwpkrZz
 ccmpAtrcscenKiDOQsimQ1f+zVCDKqU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-AaRJItl_NrygrC4i45r78A-1; Mon,
 24 Mar 2025 14:12:43 -0400
X-MC-Unique: AaRJItl_NrygrC4i45r78A-1
X-Mimecast-MFC-AGG-ID: AaRJItl_NrygrC4i45r78A_1742839961
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27B2718EBE88; Mon, 24 Mar 2025 18:12:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF38C180B48C; Mon, 24 Mar 2025 18:12:39 +0000 (UTC)
Date: Mon, 24 Mar 2025 14:12:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 hreitz@redhat.com, alex.chen@huawei.com, chenjianfei3@huawei.com,
 eric.fangyi@huawei.com, luolongmin@huawei.com,
 mujinsheng@huawei.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, renxuming@huawei.com,
 suxiaodong1@huawei.com, wangjian161@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com, zhuyangyang14@huawei.com
Subject: Re: [PATCH v2 2/2] qapi/throttle: add timeout parameter for
 qmp_block_set_io_throttle()
Message-ID: <20250324181233.GI64982@fedora>
References: <20250321070917.2889854-1-zoudongjie@huawei.com>
 <20250321070917.2889854-3-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lGbyohPnbRQ7aWrs"
Content-Disposition: inline
In-Reply-To: <20250321070917.2889854-3-zoudongjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--lGbyohPnbRQ7aWrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 03:09:17PM +0800, zoudongjie wrote:
> From: Zhu Yangyang <zhuyangyang14@huawei.com>
>=20
> Calling qmp_block_set_io_throttle() will be blocked for a long time
> when a network disk is configured and the network failure is just about
> to occur.
>=20
> Therefore, we add a timeout parameter for qmp_block_set_io_throttle to co=
ntrol
> its execution duration.
>=20
> The default value of timeout is 0, that is infinite wait, consistent with
> previous behavior.
>=20
> Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> ---
>  block/block-backend.c                       | 14 +++++++++++++-
>  block/qapi-system.c                         | 10 +++++++++-
>  include/system/block-backend-global-state.h |  1 +
>  qapi/block-core.json                        |  5 ++++-
>  4 files changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lGbyohPnbRQ7aWrs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfhoJEACgkQnKSrs4Gr
c8hdcQgAvKKmAzjrN4WetaIsjwW3/8HJ/xQiepv027SWJGkyPrctSmF3Kjn3xVLo
xX2GUsHBMWymrt1moq3w3u7qfvqR7ROGGIGfLXcJXPbTBtpuKtwzrR51hvH94VwS
PvA6EyR5yhFXKPNB+nOmci9DgWhuG/3iWIhU2lahFQ6o/0kyIiv0OgEBKlNT6P7X
2zbQVwuw/yk4cfK3G+z9uqPSJUawJABR5SXoEkV095EuqZZ8eaJaU844+BrxfC46
rvu2cV8JuQvxaC/NMhpAqsHjUhKD9kJyDTo83oaxOHcqsovqer9shADuKd495tlH
s21ignEpnTjE3OnrER60jsd/dWZQ0A==
=KGED
-----END PGP SIGNATURE-----

--lGbyohPnbRQ7aWrs--


