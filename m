Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B69CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvblB-0001Os-4f; Mon, 08 Sep 2025 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvbl2-0001Lj-9m
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvbki-0000XY-12
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757337457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5qWH9TMTaG9lJt9PiY+JdP+la3NCB9Ucn2lx9FlQUU=;
 b=TtQEE1n5hF+ymtjzHl8PP3WtCcdV+JyW7KMjPxSF++tBfkeXrG9mIOEPnzyqEVQPo8qi7I
 stpkvAqD9wzu7k9vFRjQG1miNXxKOflNj25rJGLj4dr677LVWd5JEP4rEIfmUXdAQr5qH4
 GnMPjUIc03SwtJGNoFeY+qAQ1UQUgm4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-08QmncAPNXm3c1fLVv7teQ-1; Mon,
 08 Sep 2025 09:17:33 -0400
X-MC-Unique: 08QmncAPNXm3c1fLVv7teQ-1
X-Mimecast-MFC-AGG-ID: 08QmncAPNXm3c1fLVv7teQ_1757337451
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D6591956094; Mon,  8 Sep 2025 13:17:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDD621955F24; Mon,  8 Sep 2025 13:17:29 +0000 (UTC)
Date: Thu, 4 Sep 2025 21:50:21 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, dlemoal@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Message-ID: <20250904195021.GC122855@fedora>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-5-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OBAg2XDKRMxVUYZy"
Content-Disposition: inline
In-Reply-To: <20250904031058.367667-5-wilfred.opensource@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--OBAg2XDKRMxVUYZy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 01:10:57PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  hw/nvme/ctrl.c       | 213 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h       |   5 +
>  include/block/nvme.h |  15 +++
>  3 files changed, 232 insertions(+), 1 deletion(-)

Aside from my comment about spdm_socket fd numbers:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

I did not review the NVMe or SPDM specifics, just general device
emulation coding aspects.

--OBAg2XDKRMxVUYZy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi57X0ACgkQnKSrs4Gr
c8jvuAf/crn17ZSpQxP8Pfqfy/ixamaNACd8uDsLubzJA5D27czQRrD3Eoxw324F
ULcTp3pAEDeqgfR8aM1i0jkX8fDw2pjM2Wr+XbUKTeGLvNp7YHKlMxHceE2bxtS+
WbtyoZSp8qL+78M2jCICZbdjQq6v/Xhi/UqQkNBhQFx7+5X15YPNds4ssOtGvqlj
yn7e9lXe2Y0zRoKIswSZZcrhQOoLwQOYQL+Evz5bT25b1WN7MVXQcaW6GWkKZ1Sb
IMDdfyywsgX9EOiGqPAxGOSD9xin2xjR9X58zPfFZBs4yBz0xySqX/QH6WzElEYy
fUQ0X+89BxlargMzHF0cAXzWZD+MQQ==
=IOGM
-----END PGP SIGNATURE-----

--OBAg2XDKRMxVUYZy--


