Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2CBF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBIF4-0008L8-Q4; Fri, 10 Apr 2026 16:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wBIF3-0008KF-Co
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wBIF1-0002bZ-7p
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775852048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bv1kZQYoNQMOACvLFLwx7bKNC/uh0+2uZldXHUG+19U=;
 b=JD70p87fK9WHUcktjyxnYEZf8yZvREKtPVXrZ/mu9u+oordY/pJ5GxkFBXKteqGQhhBMXk
 9eVxeVNl/bU9SKnzsDhAYrTCUe4TkyX5FQd9wRHw+zbyJQ8maX6Zl3OlsWBkE7qG9YZaXx
 rv5c/8XnizZUA+TgDhnFQgaDc8QAtaY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-pwc8rsMFOpyQFvzlxnITJA-1; Fri,
 10 Apr 2026 16:14:07 -0400
X-MC-Unique: pwc8rsMFOpyQFvzlxnITJA-1
X-Mimecast-MFC-AGG-ID: pwc8rsMFOpyQFvzlxnITJA_1775852045
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21127195606C; Fri, 10 Apr 2026 20:14:05 +0000 (UTC)
Received: from localhost (unknown [10.44.48.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C773919560AB; Fri, 10 Apr 2026 20:14:03 +0000 (UTC)
Date: Fri, 10 Apr 2026 16:14:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Matthieu Rolla <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>
Subject: Re: [PATCH v3] hw/nvme: add namespace hotplug support
Message-ID: <20260410201401.GA501153@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260410143000.86708-1-matthieu@min.io>
 <CAPSO8Mx2pXp1UGvrsqTL86b=920os62MYSGn-ryv-YV4kRN4NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JRps01L0QAbPgrLX"
Content-Disposition: inline
In-Reply-To: <CAPSO8Mx2pXp1UGvrsqTL86b=920os62MYSGn-ryv-YV4kRN4NA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--JRps01L0QAbPgrLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 04:33:47PM +0200, Matthieu Rolla wrote:
> Hello @Stefan Hajnoczi <stefanha@redhat.com> ,
>=20
>=20
> Thanks for the review! v3 sent.
>=20
>=20
> Wording: Fixed in v3, no more "physical PCIe slot" claim. Now describes it
> as NVMe namespace-level hotplug.
>=20
>=20
> I/O drain: Moved nvme_ns_drain() to the start of the unplug handler so
> in-flight I/O completes before detach. Tested under warp load (16
> concurrent 1MiB uploads via MinIO/DirectPV)  device_del returns in ~400ms
> with clean removal, no use-after-free.
>=20
>=20
> Symmetry:  moved subsys->namespaces[nsid] =3D NULL into nvme_ns_unrealize=
()
> so the namespace lifecycle is complete (mirrors what nvme_ns_realize() se=
ts
> up).
>=20
>=20
> I don't have a working Windows test setup, I'd really appreciate if you
> could test it next week as you offered.
>=20
> Thanks again for your time

Awesome, thanks!

I will give Windows Server a spin next week. I'm not an expert in
hw/nvme/ but the patch looks good to me:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JRps01L0QAbPgrLX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnZWgkACgkQnKSrs4Gr
c8ghzQgAwnln6L2lwz4lopqtfPudrA1U8ucDpjhT4VXJ62bVCWxGf5p/HlpelCqw
oV5/8jiIVDQgwlqYieCTUB2PKkuxwWdJRbhABoh6tMhuzWGwstrjGFugpq6eYjLP
KfipmusxxnWAyx4i8k3Bikxa+4+wasQw38AIQ9u4ib18TyHNSOgUFceGgVhzW+bi
OjfmPk18CAZ4y/MM1dUZ74xm4efgYhenyRTaVuOQRzQKvzis2NufjXp3UUxBt4W3
rA/ajQI/3iHjZJggrJPH5gJBhSRkHO5UDYrgIWaIsDyQ/wr1KHwfsJPI6+2xbEi9
WYSM9JSSDJUyDMuRX4OtgsJElmv2AQ==
=kPx7
-----END PGP SIGNATURE-----

--JRps01L0QAbPgrLX--


