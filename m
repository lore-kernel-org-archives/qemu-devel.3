Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2462BCD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUNvw-00050a-3r; Tue, 02 Jun 2026 08:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUNvh-0004yA-Ft
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 08:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUNvf-0005MR-9o
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 08:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780402144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXirT6D+twMqikisX0u2ln/KMF/8TWJBgh3wzw8SNHA=;
 b=L3JQSToRkckCP3e5xPL0R0qok59LJhOy6gT3GwEXglO6FVFOvMQB/I5tQhQIZQoV0QJdQk
 yahH7OPlEdfGqW2coL9EgvDCLPQ2k7NHtEtuZitn28jP45H0oZjND2NBMMkn9XRETvmCrd
 hh0ao2+Qwbkkvtr/5Xpowbbt/n52eK8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-MULYT-PrO9q8Pmct9ZFTQw-1; Tue,
 02 Jun 2026 08:09:00 -0400
X-MC-Unique: MULYT-PrO9q8Pmct9ZFTQw-1
X-Mimecast-MFC-AGG-ID: MULYT-PrO9q8Pmct9ZFTQw_1780402139
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC9C18002C8; Tue,  2 Jun 2026 12:08:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D649719560A7; Tue,  2 Jun 2026 12:08:56 +0000 (UTC)
Date: Tue, 2 Jun 2026 08:08:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Message-ID: <20260602120855.GA548610@fedora>
References: <017dc767-90e3-4983-8417-e541b3fb04f6@proxmox.com>
 <20260427191343.GD218226@fedora>
 <317ab384-f8c2-49af-89c4-407bb2f5617c@proxmox.com>
 <20260428161927.GB278591@fedora>
 <9b11dec1-f27c-4c69-8dfc-34ef0bdc7e8f@proxmox.com>
 <20260601172043.GB458909@fedora>
 <ddaae8e8-cfd5-4fdc-8ada-014258c2d9d6@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z3qcwLbu62f33Z35"
Content-Disposition: inline
In-Reply-To: <ddaae8e8-cfd5-4fdc-8ada-014258c2d9d6@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--z3qcwLbu62f33Z35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 10:41:11AM +0200, Fiona Ebner wrote:
> Am 01.06.26 um 7:20 PM schrieb Stefan Hajnoczi:
> > On Wed, Apr 29, 2026 at 10:00:34AM +0200, Fiona Ebner wrote:
> >> Am 28.04.26 um 6:18 PM schrieb Stefan Hajnoczi:
> >>> On Tue, Apr 28, 2026 at 02:10:02PM +0200, Fiona Ebner wrote:
> >>>> Hi Stefan,
> >>>>
> >>>> Am 27.04.26 um 9:12 PM schrieb Stefan Hajnoczi:
> >>>>> On Fri, Apr 24, 2026 at 12:25:41PM +0200, Fiona Ebner wrote:
> >>>>>> Dear maintainers,
> >>>>>>
> >>>>>> since QEMU 10.2, if io_uring is enabled, it will be used for the e=
vent
> >>>>>> loop of iothreads and this causes an IO pressure stall value of ne=
arly
> >>>>>> 100 when idle.
> >>>>>>
> >>>>>> The issue was also reported on the kernel mailing list [0]. The
> >>>>>> suggestion from Jens Axboe was to just turn off the iowait account=
ing
> >>>>>> completely. But since (for block/file-posix.c), there is actual IO
> >>>>>> submitted via the same ring, I wasn't sure if that is the right ap=
proach.
> >>>>>>
> >>>>>> So the idea was to keep track of whether the event loop is otherwi=
se
> >>>>>> idle and only use the IORING_ENTER_NO_IOWAIT flag in that case [1].
> >>>>>>
> >>>>>> However, doing so would only help for block/file-posix.c, which su=
bmits
> >>>>>> IO via luring_co_submit() -> fdmon_io_uring_add_sqe(). For example=
, for
> >>>>>> block/rbd.c, only a poll SQE for the AioHandler node's fd is used.=
 When
> >>>>>> submitting that poll SQE in the iothread, we would need to be able=
 to
> >>>>>> know if IO for RBD is currently in-flight or not to be able to dec=
ide
> >>>>>> whether to use the IORING_ENTER_NO_IOWAIT flag or not. Is there a =
good
> >>>>>> way to do this (in a general way)?
> >>>>>>
> >>>>>> Or should the flag really always be used (if supported by the kern=
el)?
> >>>>>> Is there a way to tell io_uring/kernel that we are an event loop a=
nd our
> >>>>>> waiting should only be accounted for when there is actual IO in-fl=
ight?
> >>>>>>
> >>>>>> Happy to hear your opinions and suggestions!
> >>>>>>
> >>>>>> [0]:
> >>>>>> https://lore.kernel.org/io-uring/14bc6266-5bc9-4454-9518-d1016bfe4=
17b@proxmox.com/T/
> >>>>>
> >>>>> Hi Fiona,
> >>>>> Jens replied yesterday confirmed your suspicion that the number of
> >>>>> inflight requests is not being tracked correctly.
> >>>>>
> >>>>> Is there still a problem after fixing the kernel's inflight countin=
g? If
> >>>>> not, then no QEMU change is necessary and that seems like the clean=
est
> >>>>> solution anyway. The kernel should know whether there is I/O in fli=
ght
> >>>>> and so it doesn't seem right that userspace needs to hint this.
> >>>>
> >>>>
> >>>> unfortunately, yes. Even with the kernel fix [2], the real problem w=
ith
> >>>> poll SQEs described above remains. I'm still seeing high IO pressure
> >>>> stall values when using QEMU. In add_poll_add_sqe(), QEMU submits po=
ll
> >>>> SQEs for the AioHandler node fd, and that does count as pending IO. A
> >>>> small reproducer modeling this [3].
> >>>
> >>> Does the kernel account POLL_ADD SQEs as blocking I/O activity?
> >>
> >> Apparently yes. See the C program below [3].
> >>
> >>> That behavior is inconsistent if select(2)/poll(2)/epoll_wait(2)
> >>> syscalls do not count as blocking I/O activity. The kernel io_uring c=
ode
> >>> should account them correctly and not rely on a userspace hint.
> >>
> >> @Jens Axboe: should there be a separate internal counter for
> >> poll/timeout SQEs and have them not count towards IO wait by default?
> >=20
> > Hi Fiona,
> > Any update on this issue? Was it resolved in io_uring or is a QEMU patch
> > still needed?
>=20
> Hi Stefan,
>=20
> I did not proceed with the above, since I did not get an ack from Jens
> regarding the suggested approach.
>=20
> We needed to go ahead with a release downstream, so for the meantime, we
> applied a workaround by Thomas with setting the IORING_ENTER_NO_IOWAIT
> flag when there is no actual IO in-flight [0]. Should it be submitted to
> qemu-devel too?

Pinging Jens: io_uring accounts POLL_ADD SQEs as blocking I/O activity
whereas select(2)/poll(2)/epoll_wait(2) do not. Would it make sense to
follow the same accounting as the syscalls for this operation since that
is probably expected?

Thanks,
Stefan

>=20
> [0]:
> https://git.proxmox.com/?p=3Dpve-qemu.git;a=3Dcommitdiff;h=3D775e41b890a6=
45db75119233fe2b21f139bf8e4f
>=20
> Best Regards,
> Fiona
>=20

--z3qcwLbu62f33Z35
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoex9cACgkQnKSrs4Gr
c8jQ5ggAg8w1XzxNxVJXZjzAh/UHlkDQFO+aSnsutJdWLMmf1EtteRzXrPVafKeI
r/c2qAHlK4khJgVhWjH5/50EF4XlQk1PMQv3IZGU7tcYB02R2pqZLoeM/PNndDw3
WWJZeD9SpFBqqsDGa/dNB7bJr5APiG6mU46+h67fsiiH2qSQEwL2QKX7YoZ/4+pP
t9uNgNeVAui3x1HVhDqpvZ67Xqu5TVQ29/xAQ6IBjgdK2g7ztUzXtLD6BiojGqB4
LKemJnKU3aPyhsKi3t27kSm9rRgVdzfngr3XZDgx1N0KDlUOWV/sFoorDifhkC7p
N07p9LoAFv5zLQNHyXJjb3C5LzB1kQ==
=oVRB
-----END PGP SIGNATURE-----

--z3qcwLbu62f33Z35--


