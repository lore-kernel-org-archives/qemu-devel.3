Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CC9C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TNW-0000bb-K5; Tue, 01 Sep 2026 14:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TNV-0000af-6L
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1TNT-0005ZV-Is
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788287914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqKGcFaVRF9yxFotXsK44yDWpph0RBDX//YCYNkCdMA=;
 b=chedaMIJWJ02GcQwQvCtQToq4KQxrKA1Hlakf8CyiRcDZ++eaAuc5rGlYG95nBFcNl8zd7
 ZuooWFwJRpKeLdy7S1VOv6+uLxdoV5Pn+wDzn+DsiQ+9hv+Zaqhz0GgwarxzGOnBJpXqwM
 qZaFb7T3iyz3CT8I/Jizd1bhWTFsg/Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-6CrzPz9eO1qJ9SqshCPApw-1; Tue,
 01 Sept 2026 14:38:32 -0400
X-MC-Unique: 6CrzPz9eO1qJ9SqshCPApw-1
X-Mimecast-MFC-AGG-ID: 6CrzPz9eO1qJ9SqshCPApw_1788287910
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72BF118011DC; Tue,  1 Sep 2026 18:38:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A93E51803A51; Tue,  1 Sep 2026 18:38:29 +0000 (UTC)
Date: Tue, 1 Sep 2026 14:38:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] file-posix: fix zone write granularity assignment for
 zoned block devices
Message-ID: <20260901183828.GB616149@fedora>
References: <20260811133236.1290092-1-cassel@kernel.org>
 <aoXkRgCp-EArgj26@ryzen>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h4RupjdV20ZtaZo2"
Content-Disposition: inline
In-Reply-To: <aoXkRgCp-EArgj26@ryzen>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--h4RupjdV20ZtaZo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 07:13:42PM +0200, Niklas Cassel wrote:
> On Tue, Aug 11, 2026 at 03:32:36PM +0200, Niklas Cassel wrote:
> > In the ZBC and ZAC specifications, the requirement is that the write
> > granularity matches the physical block size.
> >=20
> > However, in the ZNS specification, the requirement is simply that the
> > write granularity matches the logical block size.
> >=20
> > See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Da805a4fa4fa376bbc145762bb8b09caa2fa8af48
> >=20
> > In Linux, there is a zone_write_granularity sysfs property which abstra=
cts
> > this away, so let's make use of it.
> >=20
> > Currently, it is theoretically possible that QEMU presents an inflated
> > write granularity for NVMe devices where the physical block size is lar=
ger
> > than the logical block size.
> >=20
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointe=
rs")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
>=20
> Stefan,
>=20
> Since you already have another zoned storage fix for file-posix.c queued:
> https://gitlab.com/stefanha/qemu/-/commits/block-next
>=20
> Could you perhaps queue this one as well?

Yes. Kevin is away for a few days and this is a small patch, so I will
merge it.

Applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--h4RupjdV20ZtaZo2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqXG6QACgkQnKSrs4Gr
c8hwjAf8CfgJNomCVEz4cP7YBsvVl8OnBmNSOIbvd8kcZomxY3RxBk1f/kdwmDnr
pX2KYzcNI2jAEJIejyMDBvzdHHtK9hFnnr0kFhwHlSCwl3xljA4LEl6HtKwhKiU7
mE4BgyUA5XB9YIUKB+/fudMux7+kOuFnQh8ptAlKhjgrVqk39RYfddJvn6PMRFME
6WwM0dvNeG3YL3F6wemss8WiTDzJ/wp/6tiRNXa2ZwpH+hYb1Wbzil7gnxoGEdNy
eDhRXiBaEi/BRTbD/rDWPR0BW6eGyI1Q9uonKXJ6g9bt9putbSe991zlyntx7idj
3sVT0+tPBW90YgCZcF2vOyZcGhjCCQ==
=jRBC
-----END PGP SIGNATURE-----

--h4RupjdV20ZtaZo2--


