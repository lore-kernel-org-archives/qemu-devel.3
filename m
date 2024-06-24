Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F962C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 16:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLmFK-0001q1-MK; Mon, 24 Jun 2024 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sLmFH-0001pd-K4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sLmFD-0007eW-OU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719245318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1l6Txhxh6/qgaiSYJZjNquQiKgZq3TS74TTkfmTFghQ=;
 b=eLhvGSgYHUI21xkzpyXCzxWR/LRBgVqMDyRWxgWqQng7whPBK3jChOZaqW1+FgxO5CG/jl
 gRODndhc7R3N+CBkPYYlUUnfwvLwmW+hH0c9fFVguTVLOqPz7zb58CeVvXIQMfeqN+9OWO
 3Lg9CkeuRIoB37CiMdzldHy3NomAoaU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-W5V5i7MpOdehR7IfoBDa7g-1; Mon,
 24 Jun 2024 12:08:32 -0400
X-MC-Unique: W5V5i7MpOdehR7IfoBDa7g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B784019560AE; Mon, 24 Jun 2024 16:08:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 538E219560BF; Mon, 24 Jun 2024 16:08:28 +0000 (UTC)
Date: Mon, 24 Jun 2024 18:08:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
Message-ID: <ZnmZ-m38IAHg0UdX@redhat.com>
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
 <20240624152302.GA2402845@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oreNmGh9Mt/AvTwB"
Content-Disposition: inline
In-Reply-To: <20240624152302.GA2402845@fedora.redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--oreNmGh9Mt/AvTwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:
> On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> > Tested using:
>=20
> Hi Nir,
> This looks like a good candidate for the qemu-iotests test suite. Adding
> it to the automated tests will protect against future regressions.
>=20
> Please add the script and the expected output to
> tests/qemu-iotests/test/write-zeroes-unmap and run it using
> `(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.
>=20
> See the existing test cases in tests/qemu-iotests/ and
> tests/qemu-iotests/tests/ for examples. Some are shell scripts and
> others are Python. I think shell makes sense for this test case. You
> can copy the test framework boilerplate from an existing test case.

'du' can't be used like this in qemu-iotests because it makes
assumptions that depend on the filesystem. A test case replicating what
Nir did manually would likely fail on XFS with its preallocation.

Maybe we could operate on a file exposed by the FUSE export that is
backed by qcow2, and then you can use 'qemu-img map' on that qcow2 image
to verify the allocation status. Somewhat complicated, but I think it
could work.

Kevin

--oreNmGh9Mt/AvTwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmZ5mfoACgkQfwmycsiP
L9YPBBAAw/Tm7gF9WNRuXcFzGa3Su8qgZeAppugdN88xFIJ/yFkepQTf1v9cViTW
xanxIAk4pkUKZofUQAy/SIdPzdXfb2USsjUO3EqpnsBUSKUeZY3Oh/1lGEqs48sX
g/LR7jqZ/AJVq2uyGORJHiO04tsptkvoKkeoMz9H1jE0VnLs7hwHc/7TCeZZN8iY
/hNhkEzypqCfGpdTTtVUPj9uhYSk1i3YsUS8yQlLKZF8UyaVaxzBuYbQMRIEH+Rx
54rnI6yZGViooZN5dQYZgmmTTFqiS31d0Tj0oBuGaXBBVbc7dZDV99BTBJZbHoCK
pu3MGXEoFoMdCPCe1+t9MpJtgz9IMJtqeSeWxWof8KXjkOuPIq0yCAaXtmCEcbjS
Clkc8Y0AYcTf9a6ctklU+Nd0QiwKqADHpQQRj1gVOYHWap8blCEQnpFuywhGyA4V
CfmYMW0VFbNsWpH0ywbbKh7nl2HO4k1QYxvQCUltdPCw+K0haPkUTW6nfp2761l2
dic3XdFoc9C+vf0MZD5qJKhyoRzNX/PXSC6vhmCdCbTokp591z9O3ehvAoAnZ6i9
4/JCWu1CnptmF9DlKs8KWITAptFgtjlMve9miIp08e+dVsEiO8eAXIo0TncGjJ45
zn5zQQESeTVjwdwLJFsy5DrGTMWvJBRrizmZlVMc5apSIM/ZCVE=
=Nqkq
-----END PGP SIGNATURE-----

--oreNmGh9Mt/AvTwB--


