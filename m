Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8E4C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIjW-0000Hp-5F; Wed, 26 Aug 2026 14:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wzIjU-0000HT-D5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wzIjS-0004Jk-RU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787770336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z4fpmqORZSds6G0og89ecYmURogcAzF3g0k3fZSHiHc=;
 b=J+qqszNrQ5J/1Xj9cYDX66e53V3HwAoGyD7s/Xj95vAmJ7OUAuZkaWHjgvvEyHoe+GgGE1
 8u2jZBX0C8/jiBR+TnMd9XerFW5AC4tn7vRf+oiS1A3RGUj0mlkzG0fi/nctjMptm2yU+s
 x3m4A4Ltg4wg2c6hPUj6rzFb7nr+YgE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-FYCbOFzaOrK7snKFr0HjXQ-1; Wed,
 26 Aug 2026 14:52:14 -0400
X-MC-Unique: FYCbOFzaOrK7snKFr0HjXQ-1
X-Mimecast-MFC-AGG-ID: FYCbOFzaOrK7snKFr0HjXQ_1787770333
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4180119774F7; Wed, 26 Aug 2026 18:52:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FDBD195608A; Wed, 26 Aug 2026 18:52:12 +0000 (UTC)
Date: Wed, 26 Aug 2026 14:52:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH 0/2] scsi-disk: fix race between WRITE SAME and MODE SELECT
Message-ID: <20260826185211.GA330950@fedora>
References: <20260826181725.849718-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dy6O6Ry/IXOC9p2o"
Content-Disposition: inline
In-Reply-To: <20260826181725.849718-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--dy6O6Ry/IXOC9p2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 08:17:23PM +0200, Paolo Bonzini wrote:
> A guest with an attached scsi-hd can force QEMU's SCSI disk emulation
> to read roughly 60 KiB past the end of a heap buffer, copying that out
> of bounds host memory into the guest's own disk image.
>=20
> This is due to a race between WRITE SAME and an obscure MODE SELECT
> feature which can be restricted to the Q800 machine.
>=20
> Paolo
>=20
> Paolo Bonzini (2):
>   scsi-disk: fix out-of-bound read in WRITE SAME
>   scsi: hide MODE SELECT block size change behind a quirk
>=20
>  include/hw/scsi/scsi.h |  1 +
>  hw/m68k/q800.c         |  2 ++
>  hw/scsi/scsi-disk.c    | 17 +++++++++++++----
>  3 files changed, 16 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.55.0
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dy6O6Ry/IXOC9p2o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqPNdsACgkQnKSrs4Gr
c8jVmAf/Y88SclbIJacMw7E+7Q2QuTsuMYEBnY8ZqfI0OW6k/TZ20d7R+PrVuLkj
HKBS+yt8RUSbTXqwrHVFcl9Ww/Uec7nUn/8gBTunT96V0J5SdPYrVKH2utDt4097
CJbZ2SGhLzpC6F7obaeGrckE7CelztKGiVqe1yYhbIGNbqzqSsGZID8HsYA1DG9y
iF47ri+48qW9aR8bgHrm5WLGhuKg0Tq5/ezKORpRNdsYBeEkFHoLusIVmMLwi5kk
VPd5MVWU/w0XVd+K69ULHBnDMqrUqyYOuPnMrlUcC7kA7EhFcwDwyzIYDzNuI0S3
yoez4hotQrQQxbwF0fhBXjGv3ZBDXQ==
=mnQn
-----END PGP SIGNATURE-----

--dy6O6Ry/IXOC9p2o--


