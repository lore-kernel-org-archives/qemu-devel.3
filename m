Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59792FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHlA8-0001BT-M2; Tue, 28 Apr 2026 12:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHlA3-0001Ac-6o
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHl9u-0006bR-3Q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777393177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IVSDw2zGTZWYIR2cd0nlpFEiVuzNcfJADVRIocbRDdA=;
 b=QL/vveo9vKMVNgcgEAOcwXbfV5kAlMESN/oji8PmKXPN8zxuzjRn/07JVY4z+lfTHyAbZQ
 aa60jCYtiXCp3RrmnlhIimKlcwVWb7BMg5y1jLpbPN3kuZY4Do9YAcox2F+595xc9If4g6
 t3jr5G5dBhYDyNQUw6UXlp5NKYBw+Dc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-3tmm5QfZP7iQmsMdWtcKRg-1; Tue,
 28 Apr 2026 12:19:33 -0400
X-MC-Unique: 3tmm5QfZP7iQmsMdWtcKRg-1
X-Mimecast-MFC-AGG-ID: 3tmm5QfZP7iQmsMdWtcKRg_1777393171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CA511955F68; Tue, 28 Apr 2026 16:19:31 +0000 (UTC)
Received: from localhost (unknown [10.44.33.158])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2135119560AB; Tue, 28 Apr 2026 16:19:29 +0000 (UTC)
Date: Tue, 28 Apr 2026 12:19:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Message-ID: <20260428161927.GB278591@fedora>
References: <017dc767-90e3-4983-8417-e541b3fb04f6@proxmox.com>
 <20260427191343.GD218226@fedora>
 <317ab384-f8c2-49af-89c4-407bb2f5617c@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n4oZOOcMhEtnZQOq"
Content-Disposition: inline
In-Reply-To: <317ab384-f8c2-49af-89c4-407bb2f5617c@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--n4oZOOcMhEtnZQOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 02:10:02PM +0200, Fiona Ebner wrote:
> Hi Stefan,
>=20
> Am 27.04.26 um 9:12 PM schrieb Stefan Hajnoczi:
> > On Fri, Apr 24, 2026 at 12:25:41PM +0200, Fiona Ebner wrote:
> >> Dear maintainers,
> >>
> >> since QEMU 10.2, if io_uring is enabled, it will be used for the event
> >> loop of iothreads and this causes an IO pressure stall value of nearly
> >> 100 when idle.
> >>
> >> The issue was also reported on the kernel mailing list [0]. The
> >> suggestion from Jens Axboe was to just turn off the iowait accounting
> >> completely. But since (for block/file-posix.c), there is actual IO
> >> submitted via the same ring, I wasn't sure if that is the right approa=
ch.
> >>
> >> So the idea was to keep track of whether the event loop is otherwise
> >> idle and only use the IORING_ENTER_NO_IOWAIT flag in that case [1].
> >>
> >> However, doing so would only help for block/file-posix.c, which submits
> >> IO via luring_co_submit() -> fdmon_io_uring_add_sqe(). For example, for
> >> block/rbd.c, only a poll SQE for the AioHandler node's fd is used. When
> >> submitting that poll SQE in the iothread, we would need to be able to
> >> know if IO for RBD is currently in-flight or not to be able to decide
> >> whether to use the IORING_ENTER_NO_IOWAIT flag or not. Is there a good
> >> way to do this (in a general way)?
> >>
> >> Or should the flag really always be used (if supported by the kernel)?
> >> Is there a way to tell io_uring/kernel that we are an event loop and o=
ur
> >> waiting should only be accounted for when there is actual IO in-flight?
> >>
> >> Happy to hear your opinions and suggestions!
> >>
> >> [0]:
> >> https://lore.kernel.org/io-uring/14bc6266-5bc9-4454-9518-d1016bfe417b@=
proxmox.com/T/
> >=20
> > Hi Fiona,
> > Jens replied yesterday confirmed your suspicion that the number of
> > inflight requests is not being tracked correctly.
> >=20
> > Is there still a problem after fixing the kernel's inflight counting? If
> > not, then no QEMU change is necessary and that seems like the cleanest
> > solution anyway. The kernel should know whether there is I/O in flight
> > and so it doesn't seem right that userspace needs to hint this.
>=20
>=20
> unfortunately, yes. Even with the kernel fix [2], the real problem with
> poll SQEs described above remains. I'm still seeing high IO pressure
> stall values when using QEMU. In add_poll_add_sqe(), QEMU submits poll
> SQEs for the AioHandler node fd, and that does count as pending IO. A
> small reproducer modeling this [3].

Does the kernel account POLL_ADD SQEs as blocking I/O activity?

That behavior is inconsistent if select(2)/poll(2)/epoll_wait(2)
syscalls do not count as blocking I/O activity. The kernel io_uring code
should account them correctly and not rely on a userspace hint.

Stefan

>=20
> So the question from above, how to deal with this for block drivers not
> going through file-posix.c remains.
>=20
> Best Regards,
> Fiona
>=20
> [2]:
> https://lore.kernel.org/io-uring/b4d2aa36-8301-4e58-be3e-1451267b8c43@pro=
xmox.com/T/
>=20
> [3]:
>=20
> #include <assert.h>
> #include <errno.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <liburing.h>
> #include <sys/eventfd.h>
>=20
> int main(void) {
>     int fd;
>     int ret;
>     struct io_uring ring;
>     struct io_uring_sqe *sqe;
>=20
>     fd =3D eventfd(0, 0);
>     assert(fd >=3D 0);
>=20
>     ret =3D io_uring_queue_init(128, &ring, 0);
>     assert(ret =3D=3D 0);
>=20
>     sqe =3D io_uring_get_sqe(&ring);
>     assert(sqe);
>=20
>     io_uring_prep_poll_add(sqe, fd, 1);
>=20
>     ret =3D io_uring_submit_and_wait(&ring, 1);
>     printf("got ret %d\n", ret);
>=20
>     io_uring_queue_exit(&ring);
>=20
>     return 0;
> }
>=20
>=20

--n4oZOOcMhEtnZQOq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnw3g8ACgkQnKSrs4Gr
c8jJpwf+NdH4eWaCUZID5mf6PCr/eJGtWlavDaDJVYdbgHEbpU9vahTGMvz0+Y+7
TdcF10u9T7f91a64AFIJdniW9dqBNh59oEJFUtrKol4wHXPgiMYQZIRTl141zdI5
Ywdhy3wQBmVN/VucwoHg0Fbzg+L9HporDLtq2Ug3a8rmNk0zsnBRJmYUDCU7ciDu
iwi9AJlNfEE4ruv3rsLht8XRv8TAJMgpeOTCfX+9U9efVRAEPTW1dEGcPUnzqqEy
t6hy8Hl7JFfxfi6HnLrTqRodrBOwQTTI2RPY7oNPLJJLBWCkqFa0njSxv4rW9QYo
YR1fHP3f8/qLykPUi/OWHrhc2zSrqw==
=u3ZY
-----END PGP SIGNATURE-----

--n4oZOOcMhEtnZQOq--


