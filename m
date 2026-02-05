Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130ABECD996
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo4Fu-00043o-MQ; Thu, 05 Feb 2026 13:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vo4Ft-00043Y-Fo
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:39:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vo4Fr-0005GI-CD
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770316741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QJbCOgn1gwItCY5Xqtv2HXYdZVDu/lNsWi84EQRKO34=;
 b=g5Xr2Fk98uJz8Jzj8naOid2QkPkKHY+0QFMS3mLnpRuDfGghXWzCcZj6cP+kvNfZPpLS+e
 7OgB6AWUmGetqT9/SNN46MajQ76LprXmW8zJWOLYRieOJfzyc0bH19wOCnDquKKiAlHzd3
 FBXGHZ4ng7RwT3vRalsdVDGEByOJF/0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-OxFaV4RBPouRc3_AfZ6n1A-1; Thu,
 05 Feb 2026 13:38:58 -0500
X-MC-Unique: OxFaV4RBPouRc3_AfZ6n1A-1
X-Mimecast-MFC-AGG-ID: OxFaV4RBPouRc3_AfZ6n1A_1770316737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA5C218005B7; Thu,  5 Feb 2026 18:38:56 +0000 (UTC)
Received: from localhost (unknown [10.2.17.36])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 099B918003F6; Thu,  5 Feb 2026 18:38:55 +0000 (UTC)
Date: Thu, 5 Feb 2026 13:38:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 0/9] single-binary: hw/virtio
Message-ID: <20260205183849.GA50663@fedora>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <571ef1d1-88f1-4f4c-9800-00f114a85e02@linaro.org>
 <20260205014101-mutt-send-email-mst@kernel.org>
 <59bea9ee-d874-446e-9ec3-b14449d856e4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nEMX2TA+MfMLYiOA"
Content-Disposition: inline
In-Reply-To: <59bea9ee-d874-446e-9ec3-b14449d856e4@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--nEMX2TA+MfMLYiOA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 09:17:03AM -0800, Pierrick Bouvier wrote:
> On 2/4/26 10:43 PM, Michael S. Tsirkin wrote:
> > On Wed, Feb 04, 2026 at 09:27:10PM -0800, Pierrick Bouvier wrote:
> > > On 2/3/26 12:56 PM, Pierrick Bouvier wrote:
> > > > This series eliminates target specifics in hw/virtio and replace th=
em with
> > > > runtime functions where needed.
> > > >=20
> > > > Performance has been measured with this automated fio benchmark, wi=
th
> > > > original instructions from Stefan [1].
> > > >=20
> > > > $ git clone https://github.com/pbo-linaro/qemu-linux-stack -b x86_6=
4_io_benchmark
> > > > $ cd qemu-linux-stack
> > > > $ ./build.sh
> > > > $ ./run.sh /path/to/qemu-system-x86_64
> > > >=20
> > > > [1] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedo=
ra/
> > > >=20
> > > > Results are on 20 runs and expressed in kIOPS:
> > > > reference: mean=3D239.2 std_dev=3D3.48
> > > > with_series: mean=3D238.5 std_dev=3D3.46
> > > >=20
> > > > Performance is on par, and within standard deviation.
> > > >=20
> > >=20
> > > Does it look better to you Michael?
> > >=20
> > > Regards,
> > > Pierrick
> >=20
> >=20
> > better for sure. is there a reason you dropped stefanha
> > from CC? he suggested these tests...
> >=20
>=20
> I didn't to that intentionally, it seems like he was not added by default
> from the file set when I posted v4.
>=20
> Stefan, please see cover letter above and let us know if that sounds
> acceptable to you.

Yes, the results you posted look fine. Thanks!

Stefan

--nEMX2TA+MfMLYiOA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmE47kACgkQnKSrs4Gr
c8h28ggAowOUbqYf6pbKmjC/xhrs1jy0L2YrRuwgIR3w495den743PLUDWXFa0DU
93/OsP6qXClwzNVNTjUeWiXqnRxF7Y9PUTAXlhu5RIouk/GxmJThGzTt7GajXNjn
PGWW5lB15kQGlIhQWckFQvRNVtS+AQPouE+LJCsNwhy/RMULG5TQpyIWmSQRFaz+
Zi6Jj4FutH8vY0dG0qD6/sYPJyqRHguKoUgV1ck0DpAxwqZDmhTy68vn0U5bkDKz
hSPEQ2DQiAflrbxp4karMRsZN9/JpGilWYheHpy8oER5zvvD7IpPbszBMYn2bULB
e3DO7QOZegWLR2yO3oWEHopxU2zIYg==
=24BD
-----END PGP SIGNATURE-----

--nEMX2TA+MfMLYiOA--


