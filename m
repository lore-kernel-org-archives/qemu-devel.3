Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E210C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVD9-0000Af-P3; Tue, 17 Sep 2024 06:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqVD0-000052-9k
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqVCy-0003Fh-Rp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726568000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1PB0xsthZELZgvnONivkvEbHUVJiYbvPYU85ovXyz1E=;
 b=IMALBcEnhNlWw/P8nkLBE1ALdKaW7xNtaOnVGmUtwhEwXQxfGryhARmhprP5VC98aXSp5Q
 i94zrdj7pOtC9TMidedg11yh44dFQDboYTXRw2UdA/WLDOtX6G+BlI4JrOXsmYK2FPcD8N
 D74jxPpYgN7PK5DCIIDfX2Z4jj7Gyrs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-l80SYyS1OfmqbAJfqhn9Hg-1; Tue,
 17 Sep 2024 06:13:14 -0400
X-MC-Unique: l80SYyS1OfmqbAJfqhn9Hg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2BFE19560AB; Tue, 17 Sep 2024 10:13:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2B6C30001A4; Tue, 17 Sep 2024 10:13:09 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:13:08 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH] hw/block: fix uint32 overflow
Message-ID: <20240917101308.GA591744@fedora.redhat.com>
References: <20240917080356.270576-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t+LP5SZ+888D42wA"
Content-Disposition: inline
In-Reply-To: <20240917080356.270576-2-frolov@swemel.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--t+LP5SZ+888D42wA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 11:03:18AM +0300, Dmitry Frolov wrote:
> The product bs->bl.zone_size * (bs->bl.nr_zones - 1) may overflow
> uint32.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  hw/block/virtio-blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--t+LP5SZ+888D42wA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbpVjMACgkQnKSrs4Gr
c8jdPgf/fse8zPASYpHHT4vbqtuxwIRhg4Kyh0BiXYt0mRLj/y52hm8Kf42MdKHp
dQtACuDMHGLbbHR5PLWN5lizGdx+8deNZNu49/atq7CkRc7K3gwCihEBtaBfgHIp
5kPmIdTT+g5VCIVLeW+LDnN1Se5mhZ13bxHU1UY89RcKVkBsn26lU0NhbH7LISy2
bqQbfM7L0u37wOi/DPIwGT8Lf+CKAtdOhmE3z5hBdytOVqX0htwpb6C1aHMoqqjv
coFTNkh5zQL1GifsfCmP9zmD8gxMlt25+qJr3JD9XVLFOlhyqMmSqEyr9bHQafA2
pRcEJ9jCg8wsect0FVtiZuBGTYXHsQ==
=psDM
-----END PGP SIGNATURE-----

--t+LP5SZ+888D42wA--


