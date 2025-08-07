Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62640C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 15:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk2M1-0005j0-5r; Thu, 07 Aug 2025 11:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk2Lg-0005Mi-K2
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk2Ld-00070t-RO
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754579763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NViIjHssnnDSdVJJF4OqIZPgYNA0IfoPVGS2Jh8UFus=;
 b=IVbIikNMV9FCMTQM6Y2NATmx1/UvkTEH7K9OhK+X/ofil41FnTUROjK/ooJJPsl01sYIC4
 ht++Ij7q2T7Ma1tATLDGCRLFnOR/vDdpvwukJuTIogkdB9j8mU1FGk90rJuCCIRzFolD1d
 Dn8z/vE7p/cXV6p4ykB44hZ+jbS8SD8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-j3b82qRqMxKvMfq7PM2SeA-1; Thu,
 07 Aug 2025 11:15:58 -0400
X-MC-Unique: j3b82qRqMxKvMfq7PM2SeA-1
X-Mimecast-MFC-AGG-ID: j3b82qRqMxKvMfq7PM2SeA_1754579757
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14975180034B; Thu,  7 Aug 2025 15:15:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.191])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 439EF1800291; Thu,  7 Aug 2025 15:15:56 +0000 (UTC)
Date: Thu, 7 Aug 2025 11:15:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Brian Song <hibriansong@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
Message-ID: <20250807151549.GB107244@fedora>
References: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
 <dc326a4b-f6fa-435a-b614-208e03f61556@gmail.com>
 <577bf373-92cb-4160-a49e-e29d3615a308@ddn.com>
 <dbcfecfd-01ab-4ca4-b835-f3a3e6b3686e@gmail.com>
 <0569dd4f-c07a-40bf-8136-c639b41d8053@ddn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gFDD4lsvIJOFuhiz"
Content-Disposition: inline
In-Reply-To: <0569dd4f-c07a-40bf-8136-c639b41d8053@ddn.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--gFDD4lsvIJOFuhiz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 09:05:25AM +0000, Bernd Schubert wrote:
> Hi Brian,
>=20
> sorry for late replies. Totally swamped in work this week and next week
> will be off another week.
>=20
> On 8/5/25 06:11, Brian Song wrote:
> >=20
> >=20
> > On 2025-08-04 7:33 a.m., Bernd Schubert wrote:
> >> Hi Brian,
> >>
> >> sorry for my late reply, just back from vacation and fighting through
> >> my mails.
> >>
> >> On 8/4/25 01:33, Brian Song wrote:
> >>>
> >>>
> >>> On 2025-08-01 12:09 p.m., Brian Song wrote:
> >>>> Hi Bernd,
> >>>>
> >>>> We are currently working on implementing termination support for fus=
e-
> >>>> over-io_uring in QEMU, and right now we are focusing on how to clean=
 up
> >>>> in-flight SQEs properly. Our main question is about how well the ker=
nel
> >>>> supports robust cancellation for these fuse-over-io_uring SQEs. Does=
 it
> >>>> actually implement cancellation beyond destroying the io_uring queue?
> >>>> [...]
> >>>
> >>
> >> I have to admit that I'm confused why you can't use umount, isn't that
> >> the most graceful way to shutdown a connection?
> >>
> >> If you need another custom way for some reasons, we probably need
> >> to add it.
> >>
> >>
> >> Thanks,
> >> Bernd
> >=20
> > Hi Bernd,
> >=20
> > Thanks for your insights!
> >=20
> > I think umount doesn't cancel any pending SQEs, right? From what I see,=
=20
> > the only way to cancel all pending SQEs and transition all entries to=
=20
> > the FRRS_USERSPACE state (unavailable for further fuse requests) in the=
=20
> > kernel is by calling io_uring_files_cancel in do_exit, or=20
> > io_uring_task_cancel in begin_new_exec.
>=20
> There are two umount forms
>=20
> - Forced umount - immediately cancels the connection and aborts
> requests. That also immediately releases pending SQEs.
>=20
> - Normal umount, destroys the connection and completed SQEs at the end
> of umount.
>=20
> >=20
> >  From my understanding, QEMU follows an event-driven model. So if we=20
> > don't cancel the SQEs submitted by a connection when it ends, then=20
> > before QEMU exits =E2=80=94 after the connection is closed and the asso=
ciated=20
> > FUSE data structures have been freed =E2=80=94 any CQE that comes back =
will=20
> > trigger QEMU to invoke a previously deleted CQE handler, leading to a=
=20
> > segfault.
> >=20
> > So if the only way to make all pending entries unavailable in the kerne=
l=20
> > is calling do_exit or begin_new_exec, I think we should do some=20
> > workarounds in QEMU.
>=20
> I guess if we find a good argument why qemu needs to complete SQEs
> before umount is complete a kernel patch would be accepted. Doesn't
> sound that difficult to create patch for that. At least for entries that
> are on state FRRS_AVAILABLE. I can prepare patch, but at best in between
> Saturday and Monday.

Hi Bernd,
QEMU quiesces I/O at certain points, like when the block driver graph is
reconfigured (kind of like changing the device-mapper table in the
kernel) or when threads are reconfigured. This is also used during
termination to stop accepting new I/O and wait until in-flight I/O has
completed.

Ideally io_uring's ASYNC_CANCEL would work on in-flight
FUSE-over-io_uring uring_cmd requests. The REGISTER or COMMIT_AND_FETCH
uring_cmds would complete with -ECANCELED and future FUSE requests would
be queued in the kernel until FUSE-over-io_uring becomes ready again.

If and when userspace becomes ready again, it submits REGISTER
uring_cmds again and queued FUSE requests are then delivered to
userspace.

Thanks for your help!

Stefan

--gFDD4lsvIJOFuhiz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiUwyUACgkQnKSrs4Gr
c8jiqQgAkhIv8x6H/OXRqOQ/quJYgEKV+/LzD0Ca4n15PvzjLDWzSabVHug2MBK/
1latyj4X/VJoDAiLAYREUTxWRA9QDIdsAhj9DtxOyOzet3wafTWDNb0VCYrInNI7
ePZViCH5cu2ADc+9mPLGvKqEDKxxI9s5WDORwpJ1q0B2nc98+Do6pWd40iSOLFh2
aXNXmObXVH5mMbsKBr+KE+PtGMotvmelsAttbFVTU7dAwKmmHufue7JsXe7uYRH3
JJRCrh46HAz3G47+EKoSvBrvHqHKtvSeEmbUNthDNc+lSP9sAmL9FPB/c/j6uHEH
yY+pRTDrN0gI1x8c29gnQYj1dUjYrQ==
=r7DV
-----END PGP SIGNATURE-----

--gFDD4lsvIJOFuhiz--


