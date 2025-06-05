Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D676CC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9xU-0002jA-EA; Thu, 05 Jun 2025 08:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uN9xR-0002iP-F4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uN9xM-0002KK-6g
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749127466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zPD++vxxdQklWRvOVaKUfkaNkQ13FG/7Gqq015tUO0=;
 b=B54dyyv8Mop0zRPPXRbgv/1YJ0cjom5GHlP4/wdLXekdY/dZT3u2km+N5v/OsEFnb+Hou1
 4MzZ+eSlbHHxfZr14K2vJNQbjYlnSY9tzPNQ2NAbXFua0KE22S1173gsQsD1QKbvth0Z8G
 bHgMK2GOqTo7oX1It7YkwLz7iI4hKc8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-dtycRJ66NXyYERA0tDNdHg-1; Thu,
 05 Jun 2025 08:44:22 -0400
X-MC-Unique: dtycRJ66NXyYERA0tDNdHg-1
X-Mimecast-MFC-AGG-ID: dtycRJ66NXyYERA0tDNdHg_1749127462
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EE6F1956095; Thu,  5 Jun 2025 12:44:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E1A71956050; Thu,  5 Jun 2025 12:44:20 +0000 (UTC)
Date: Thu, 5 Jun 2025 08:44:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
Message-ID: <20250605124419.GA417071@fedora>
References: <20250604191843.399309-1-stefanha@redhat.com>
 <aEFWeZUlqqRvHsJT@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dY13t0KVXEG5d4Hc"
Content-Disposition: inline
In-Reply-To: <aEFWeZUlqqRvHsJT@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--dY13t0KVXEG5d4Hc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 09:34:01AM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jun 04, 2025 at 03:18:43PM -0400, Stefan Hajnoczi wrote:
> > Since commit 7ff9ff039380 ("meson: mitigate against use of uninitialize
> > stack for exploits") the -ftrivial-auto-var-init=3Dzero compiler option=
 is
> > used to zero local variables. While this reduces security risks
> > associated with uninitialized stack data, it introduced a measurable
> > bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
> > functions.
> >=20
> > These virtqueue functions are in the hot path. They are called for each
> > element (request) that is popped from a VIRTIO device's virtqueue. Using
> > __attribute__((uninitialized)) on large stack variables in these
> > functions improves fio randread bs=3D4k iodepth=3D64 performance from 3=
04k
> > to 332k IOPS (+9%).
>=20
> IIUC, the 'hwaddr addr' variable is 8k in size, and the 'struct iovec iov'
> array is 16k in size, so we have 24k on the stack that we're clearing and
> then later writing the real value. Makes sense that this would have a
> perf impact in a hotpath.
>=20
> > This issue was found using perf-top(1). virtqueue_split_pop() was one of
> > the top CPU consumers and the "annotate" feature showed that the memory
> > zeroing instructions at the beginning of the functions were hot.
>=20
> When you say you found it with 'perf-top' was that just discovered by
> accident, or was this usage of perf-top in response to users reporting
> a performance degradation vs earlier QEMU ?

By accident. I was looking for ways to optimize my work-in-progress QEMU
io_uring patches and virtqueue_split_pop() stood out in the CPU time
profile.

--dY13t0KVXEG5d4Hc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhBkSIACgkQnKSrs4Gr
c8j+Zgf9HDTCnUBFBkVhHNGMquBv+6RgzPgoZ3BGtGvY6CnLXKnf5+8/fbObbDB4
qmfihbbpFY9fJ8W3k18Z5WIUIF3jc16RUQ4cp1p/tFjKnZuh4PYmYbd1j6tU0ocn
oYa2F496dOH1vPh63FlBwHQatd6yeoR5X9FJ9d5WlfHFeuL70mzYnrDkJHhnJB9V
bx7oZvTtmeulaZRH9PmHKUfKbbHrjXrpryjp/F0+GrIhFKsPJIdId0K8xs4gFVUg
8/rlahHRhA0BM/SXZQfhQbHqQwF1hYIrhob9wKKGwFRDiiYXVLzVDV6M0ODT/fhT
TcX6xIeMc82ZDH/gWZIV5wNiIBhEtQ==
=f6Hq
-----END PGP SIGNATURE-----

--dY13t0KVXEG5d4Hc--


