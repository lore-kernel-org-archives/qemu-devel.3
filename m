Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3B4CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU6Jy-0005YI-8N; Mon, 01 Jun 2026 13:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU6Jw-0005UZ-DI
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU6Jt-0003Dq-6B
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780334454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DbEnFaH7BT7ohQUSwcMWr2vKSxjSdVU1IqDPrRh05mg=;
 b=T6MEdWyYw7XG7FfChTodWv0/x0YIWgbteObwjMJf67PmFfzs9ni8rvsToIaxzB3wMEN+bj
 SkCQnbtzkYyITDr26qDt7pOofT6F9Si4c5EtTbdjoEUzKRPT1QdY4q5mc37372SU611xjr
 Aq0Pr65EQrG3JCxr+aelNB5bUwTeHiQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-cjq9BEgEMjedh0GxwGi4uQ-1; Mon,
 01 Jun 2026 13:20:47 -0400
X-MC-Unique: cjq9BEgEMjedh0GxwGi4uQ-1
X-Mimecast-MFC-AGG-ID: cjq9BEgEMjedh0GxwGi4uQ_1780334446
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8BA7195608F; Mon,  1 Jun 2026 17:20:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E54391684; Mon,  1 Jun 2026 17:20:44 +0000 (UTC)
Date: Mon, 1 Jun 2026 13:20:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Message-ID: <20260601172043.GB458909@fedora>
References: <017dc767-90e3-4983-8417-e541b3fb04f6@proxmox.com>
 <20260427191343.GD218226@fedora>
 <317ab384-f8c2-49af-89c4-407bb2f5617c@proxmox.com>
 <20260428161927.GB278591@fedora>
 <9b11dec1-f27c-4c69-8dfc-34ef0bdc7e8f@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vzItGSfQCP1+5cK4"
Content-Disposition: inline
In-Reply-To: <9b11dec1-f27c-4c69-8dfc-34ef0bdc7e8f@proxmox.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--vzItGSfQCP1+5cK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 10:00:34AM +0200, Fiona Ebner wrote:
> Am 28.04.26 um 6:18 PM schrieb Stefan Hajnoczi:
> > On Tue, Apr 28, 2026 at 02:10:02PM +0200, Fiona Ebner wrote:
> >> Hi Stefan,
> >>
> >> Am 27.04.26 um 9:12 PM schrieb Stefan Hajnoczi:
> >>> On Fri, Apr 24, 2026 at 12:25:41PM +0200, Fiona Ebner wrote:
> >>>> Dear maintainers,
> >>>>
> >>>> since QEMU 10.2, if io_uring is enabled, it will be used for the eve=
nt
> >>>> loop of iothreads and this causes an IO pressure stall value of near=
ly
> >>>> 100 when idle.
> >>>>
> >>>> The issue was also reported on the kernel mailing list [0]. The
> >>>> suggestion from Jens Axboe was to just turn off the iowait accounting
> >>>> completely. But since (for block/file-posix.c), there is actual IO
> >>>> submitted via the same ring, I wasn't sure if that is the right appr=
oach.
> >>>>
> >>>> So the idea was to keep track of whether the event loop is otherwise
> >>>> idle and only use the IORING_ENTER_NO_IOWAIT flag in that case [1].
> >>>>
> >>>> However, doing so would only help for block/file-posix.c, which subm=
its
> >>>> IO via luring_co_submit() -> fdmon_io_uring_add_sqe(). For example, =
for
> >>>> block/rbd.c, only a poll SQE for the AioHandler node's fd is used. W=
hen
> >>>> submitting that poll SQE in the iothread, we would need to be able to
> >>>> know if IO for RBD is currently in-flight or not to be able to decide
> >>>> whether to use the IORING_ENTER_NO_IOWAIT flag or not. Is there a go=
od
> >>>> way to do this (in a general way)?
> >>>>
> >>>> Or should the flag really always be used (if supported by the kernel=
)?
> >>>> Is there a way to tell io_uring/kernel that we are an event loop and=
 our
> >>>> waiting should only be accounted for when there is actual IO in-flig=
ht?
> >>>>
> >>>> Happy to hear your opinions and suggestions!
> >>>>
> >>>> [0]:
> >>>> https://lore.kernel.org/io-uring/14bc6266-5bc9-4454-9518-d1016bfe417=
b@proxmox.com/T/
> >>>
> >>> Hi Fiona,
> >>> Jens replied yesterday confirmed your suspicion that the number of
> >>> inflight requests is not being tracked correctly.
> >>>
> >>> Is there still a problem after fixing the kernel's inflight counting?=
 If
> >>> not, then no QEMU change is necessary and that seems like the cleanest
> >>> solution anyway. The kernel should know whether there is I/O in flight
> >>> and so it doesn't seem right that userspace needs to hint this.
> >>
> >>
> >> unfortunately, yes. Even with the kernel fix [2], the real problem with
> >> poll SQEs described above remains. I'm still seeing high IO pressure
> >> stall values when using QEMU. In add_poll_add_sqe(), QEMU submits poll
> >> SQEs for the AioHandler node fd, and that does count as pending IO. A
> >> small reproducer modeling this [3].
> >=20
> > Does the kernel account POLL_ADD SQEs as blocking I/O activity?
>=20
> Apparently yes. See the C program below [3].
>=20
> > That behavior is inconsistent if select(2)/poll(2)/epoll_wait(2)
> > syscalls do not count as blocking I/O activity. The kernel io_uring code
> > should account them correctly and not rely on a userspace hint.
>=20
> @Jens Axboe: should there be a separate internal counter for
> poll/timeout SQEs and have them not count towards IO wait by default?

Hi Fiona,
Any update on this issue? Was it resolved in io_uring or is a QEMU patch
still needed?

Thanks,
Stefan

--vzItGSfQCP1+5cK4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodv2sACgkQnKSrs4Gr
c8h1Ogf+MY0IAs5W0OTAH9/5yyOxzgBib8G1Z9Q0cgjGTqCXGuH8qQDKNN5pTfLt
TiMUMkNhwwsfqpCJ/p/jLnbseX1AfVYMPVfVSWnAYY7/fEItPZOoU4Nq0Paxeaev
NotJ9EbOZSQ7qjB1SyEZinEUosCCkeKghhOycb5TKalPitgbs4tiMOkuQvOlnogZ
wkyvUFm38IZm6RT6LgpOwAsmBZg+6ycr9oR937r+240IH2PxAVYSG09LTioMR/6Y
L2kqE68uNWHy/HCcpNvNCXfnz02gWdHLyIJLTVdJIjE5f9imn3lwtyvK3XS6Dixn
hjJBx3fyqdkn6N5H8PujLAqOrlNZUw==
=1eF5
-----END PGP SIGNATURE-----

--vzItGSfQCP1+5cK4--


