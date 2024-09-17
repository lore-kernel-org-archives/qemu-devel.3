Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C789AC35FEE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 07:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSsS-0008DX-Hm; Tue, 17 Sep 2024 03:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqSsQ-0008Cv-PM
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqSsP-00084i-1p
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726559034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OWvYZfw4fFOOibTuln75x/VR4zkX7lG0PO0UJ9Iox+o=;
 b=PRSLjIQKxoE64ZGHTVcA1Q4ainRAyiE/bBNw3YTSHamWi3HdCEujFUHjHDaMe9fLueL/Mx
 9vHcBG32snYowG2queYtnv6sIMYUVbx4OaqRd/JtJODZ8arRZ0eWky5kXTAPxJdBIij6Vn
 pA77rcAtfTFlniHGiC+4tPUeTi3QKdc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-2xIGKPZKNoi8MMBVe9PDKA-1; Tue,
 17 Sep 2024 03:43:52 -0400
X-MC-Unique: 2xIGKPZKNoi8MMBVe9PDKA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81DE8195394C; Tue, 17 Sep 2024 07:43:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1046630001A1; Tue, 17 Sep 2024 07:43:48 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:43:47 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240917074347.GA575885@fedora.redhat.com>
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240916175720.GG521955@fedora.home>
 <CADSE00JqsgsgcniDoeaWZ7yETNm1wBa7MgrkfmOwACRCERM23A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BxmMLRnVL8n/BJCF"
Content-Disposition: inline
In-Reply-To: <CADSE00JqsgsgcniDoeaWZ7yETNm1wBa7MgrkfmOwACRCERM23A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--BxmMLRnVL8n/BJCF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 09:05:34AM +0200, Albert Esteve wrote:
> On Mon, Sep 16, 2024 at 7:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
>=20
> > This patch series could use tests. The first two patches seem broken and
> > testing would have revealed that the memory allocation and pointers are
> > not quite right.
> >
>=20
> My bad. Previous version of the patch I did test with a device that I've
> been working on that utilizes the map/unmap messages. But I skipped it
> for this one. I will test it for any coming versions.
>=20
>=20
> >
> > One testing approach is to write a test device using libvhost-user that
> > exposes VIRTIO Shared Memory Regions, launch QEMU in qtest mode with
> > --device vhost-user-device, and then use the qtest API to enumerate and
> > access the VIRTIO Shared Memory Regions. Unfortunately this involves
> > writing quite a bit of test code. I can explain it in more detail if you
> > want.
> >
>=20
> If we want to have tests covering the feature within qemu, I can try
> to do this. I'm also more comfortable if there are tests in place.
> As I mentioned, before this patch I was verifying with an
> external device myself.

Good, automated tests will continue to be protected by tests after it is
merged.

QEMU's qtest framework (tests/qtest/) launches QEMU in the special qtest
mode where the guest does not execute CPU instructions. The test case
can send commands like reading and writing guest RAM and hardware
registers so it can remote-control QEMU as if it were a running guest.
https://www.qemu.org/docs/master/devel/testing/qtest.html

qtest is low-level but there are VIRTIO qtest APIs that offer something
similar to a VIRTIO driver API. You could extend that API to support
VIRTIO Shared Memory Regions over virtio-pci
(tests/qtest/libqos/virtio-pci.c).

A vhost-user device is also required. You could implement a dummy device
with libvhost-user that has a few VIRTIO Shared Memory Regions and
nothing else (no virtqueues, etc). The dummy device would create a
shared memory file descriptor and send the SHMEM_MAP message.

Then a qtest test case can be written that launches the dummy vhost-user
device and QEMU with --device vhost-user-device. Using the qtest VIRTIO
API you can initialize the device, enumerate VIRTIO Shared Memory
Regions (using the new qtest API you added), and test that
loading/storing to the VIRTIO Shared Memory Region works.

It would also be possible to test more advanced cases like 256 VIRTIO
Shared Memory Regions, skipping regions with 0 size, MAP/UNMAP sequences
including rejecting partial UNMAP and overlapping MAP, etc.

Stefan

--BxmMLRnVL8n/BJCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbpMzMACgkQnKSrs4Gr
c8h9qwgAgRMzFJbwV75mH0vVyNSfHGnZ4gJHRcm0vnPgtQeDPUZVW5+KALlY2ZD9
AqJRU22bSuy8WIzfxhQjXqLSEDvC+ZmH523zj7PeUwRAZ9arq0gf6N4iE5xvzscB
pmsoYWhjQGrBJFQxBOe+pdz3B1SYpaxULLpXDr2vRszC2Os0zuw2Q2Ng3ujhj9sn
b38QJulgnKhm+z/LlvzCtUGvqPMABogioQS8Erkxxbmnw2BaHapMz8eXmDE19AaO
5CT+fUue2kAQAo4RIdzZDzLfw+bP7PudJ9H/MJhIiT1dZTV8eJMgM7T3ANXh10oc
K3nu9iksY1MDQ3uE4HEtNg3vXdzXSw==
=FSl8
-----END PGP SIGNATURE-----

--BxmMLRnVL8n/BJCF--


