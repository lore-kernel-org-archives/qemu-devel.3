Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886AACA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 17:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0kXV-00065r-Vh; Mon, 22 Sep 2025 13:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0kXQ-000627-Va
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0kXI-0002ln-TM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758562868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nXFSQFfFrZpRtChBIpM2jWEsZ8T0rL8oOJnIanWHGAs=;
 b=GRRbsFu/7lSZ/l4wZWv+8J9gbo4YWUs8VIoFjLkyeXwNCs2dBlI5ZFYXQxzx2P/uIs3jRx
 mWh0ei1J4pmfxtknjTu5A9hg+hNYkfbhnL8BQZKhUM+voxalfMGvaXlH5xgx3sdCeGFqBO
 Znr2A9QtGuWBV8/tP2yWznkS1mXzBa0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-VXgDHsFdPYywFdhvhnRBzQ-1; Mon,
 22 Sep 2025 13:41:04 -0400
X-MC-Unique: VXgDHsFdPYywFdhvhnRBzQ-1
X-Mimecast-MFC-AGG-ID: VXgDHsFdPYywFdhvhnRBzQ_1758562863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA14A195608B; Mon, 22 Sep 2025 17:41:02 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA37D3000198; Mon, 22 Sep 2025 17:41:01 +0000 (UTC)
Date: Mon, 22 Sep 2025 13:41:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: bernd@bsbernd.com
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hibriansong@gmail.com
Subject: Re: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
Message-ID: <20250922174100.GB362784@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-4-hibriansong@gmail.com>
 <20250909193358.GE218449@fedora>
 <CAKWCU7VFbJius06j1pXvP_5aSpmhmaJq6Z41H4efWFmeMjr4OQ@mail.gmail.com>
 <ef822991-5af9-4ac7-9bcd-15f521579f8f@redhat.com>
 <00777028-aaf4-4607-80a7-d91ea9e9685a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1QYue+6liwDkriV/"
Content-Disposition: inline
In-Reply-To: <00777028-aaf4-4607-80a7-d91ea9e9685a@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--1QYue+6liwDkriV/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 06:06:55PM -0400, Brian Song wrote:
>=20
>=20
> On 9/17/25 9:01 AM, Hanna Czenczek wrote:
> > On 15.09.25 07:43, Brian Song wrote:
> > > Hi Hanna,
> >=20
> > Hi Brian!
> >=20
> > (Thanks for your heads-up!)
> >=20
> > > Stefan raised the above issue and proposed a preliminary solution: ke=
ep
> > > closing the file descriptor in the delete section, but perform
> > > umount separately for FUSE uring and traditional FUSE in the shutdown
> > > and delete sections respectively. This approach avoids the race
> > > condition on the file descriptor.
> > >=20
> > > In the case of FUSE uring, umount must be performed in the shutdown
> > > section. The reason is that the kernel currently lacks an interface to
> > > explicitly cancel submitted SQEs. Performing umount forces the kernel=
 to
> > > flush all pending SQEs and return their CQEs. Without this step, CQEs
> > > may arrive after the export has already been deleted, and invoking the
> > > CQE handler at that point would dereference freed memory and trigger a
> > > segmentation fault.
> >=20
> > The commit message says that incrementing the BB reference would be
> > enough to solve the problem (i.e. deleting is delayed until all requests
> > are done).=C2=A0 Why isn=E2=80=99t it?
>=20
> Hanna:
>=20
> If we place umount in the delete section instead of the shutdown section,
> the kernel FUSE driver will continue waiting for user FUSE requests and
> therefore won't return CQEs to userspace. As a result, the BB reference
> remains held (since the reference is acquired during registration and
> submission and only released once the CQE returns), preventing the delete
> operation from being invoked (invoked once the reference is decreased to =
0).
> This is why umount must be placed in the shutdown section.
>=20
> >=20
> > > I=E2=80=99m curious about traditional FUSE: is it strictly necessary =
to perform
> > > umount in the delete section, or could it also be done in shutdown?
> >=20
> > Looking into libfuse, fuse_session_unmount() (in fuse_kern_unmount())
> > closes the FUSE FD.=C2=A0 I can imagine that might result in the potent=
ial
> > problems Stefan described.
> >=20
> > > Additionally, what is the correct ordering between close(fd) and
> > > umount, does one need to precede the other?
> >=20
> > fuse_kern_unmount() closes the (queue 0) FD first before actually
> > unmounting, with a comment: =E2=80=9CNeed to close file descriptor, oth=
erwise
> > synchronous umount would recurse into filesystem, and deadlock.=E2=80=9D
> >=20
> > Given that, I assume the FDs should all be closed before unmounting.
> >=20
> > (Though to be fair, before looking into it now, I don=E2=80=99t think I=
=E2=80=99ve ever
> > given it much thought=E2=80=A6)
> >=20
> > Hanna
> >=20
> Stefan:
>=20
> I roughly went through the umount and close system calls:
>=20
> umount:
> fuse_kill_sb_anon -> fuse_sb_destroy -> fuse_abort_conn
>=20
> close:
> __fput -> file->f_op->release(inode, file) -> fuse_dev_release ->
> fuse_abort_conn
> (this only runs after all /dev/fuse FDs have been closed).
>=20
> And as Hanna mentioned, libfuse points out: =E2=80=9CNeed to close file d=
escriptor,
> otherwise synchronous umount would recurse into filesystem, and deadlock.=
=E2=80=9D
>=20
> So ideally, we should close each queue FD first, then call umount at the =
end
> =E2=80=94 even though calling umount directly also works. The root issue =
is that the
> kernel doesn't provide an interface to cancel already submitted SQEs.

Hi Bernd,
I wanted to check with you to see if you have thought more about
ASYNC_CANCEL support for FUSE-over-io_uring SQEs?

If you don't have time to implement it, maybe you could share your
thoughts on how one would go about doing this? That would be a nice
starting point if someone else wants to try it out.

Thanks,
Stefan

>=20
> You mentioned that in fuse over io_uring mode we perform close in the
> shutdown path, but at that point the server may still be processing
> requests. While handling requests, it may still write to the FD, but that=
 FD
> might not be /dev/fuse. I=E2=80=99m not sure how this gets triggered, sin=
ce in fuse
> uring mode all FUSE requests are handled by io_uring, and our FUSE reques=
ts
> should be completed via io_uring. After shutdown closes the FD, it may ca=
ll
> fuse_abort_conn, which terminates all request processing in the kernel.
> There=E2=80=99s also locking in place to protect the termination of reque=
sts and the
> subsequent uring cleanup.
>=20
> That=E2=80=99s why I think the best approach for now is:
>=20
> in shutdown, handle close and umount for fuse over io_uring;
>=20
> in delete, handle close and umount for traditional FUSE.
>=20
> > > Thanks,
> > > Brian
> > >=20
> > > On 9/9/25 3:33 PM, Stefan Hajnoczi wrote:
> > > =C2=A0 > On Fri, Aug 29, 2025 at 10:50:24PM -0400, Brian Song wrote:
> > > =C2=A0 >> @@ -901,24 +941,15 @@ static void fuse_export_shutdown(Bloc=
kExport
> > > *blk_exp)
> > > =C2=A0 >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */
> > > =C2=A0 >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 g_hash_table_remove(exports, exp->mountpoint);
> > > =C2=A0 >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0 >> -}
> > > =C2=A0 >> -
> > > =C2=A0 >> -static void fuse_export_delete(BlockExport *blk_exp)
> > > =C2=A0 >> -{
> > > =C2=A0 >> -=C2=A0=C2=A0=C2=A0 FuseExport *exp =3D container_of(blk_ex=
p, FuseExport, common);
> > > =C2=A0 >>
> > > =C2=A0 >> -=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < exp->num_queues; =
i++) {
> > > =C2=A0 >> +=C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i < exp->num_queue=
s; i++) {
> > > =C2=A0 >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 FuseQueue *q =3D &exp->queues[i];
> > > =C2=A0 >>
> > > =C2=A0 >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* Queue 0's FD belongs to the FUSE session */
> > > =C2=A0 >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (i > 0 && q->fuse_fd >=3D 0) {
> > > =C2=A0 >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 close(q->fuse_fd);
> > > =C2=A0 >
> > > =C2=A0 > This changes the behavior of the non-io_uring code. Now all =
fuse
> > > fds and
> > > =C2=A0 > fuse_session are closed while requests are potentially still=
 being
> > > =C2=A0 > processed.
> > > =C2=A0 >
> > > =C2=A0 > There is a race condition: if an IOThread is processing a
> > > request here
> > > =C2=A0 > then it may invoke a system call on q->fuse_fd just after it=
 has been
> > > =C2=A0 > closed but not set to -1. If another thread has also opened a
> > > new file
> > > =C2=A0 > then the fd could be reused, resulting in an accidental writ=
e(2)
> > > to the
> > > =C2=A0 > new file. I'm not sure whether there is a way to trigger thi=
s in
> > > =C2=A0 > practice, but it looks like a problem waiting to happen.
> > > =C2=A0 >
> > > =C2=A0 > Simply setting q->fuse_fd to -1 here doesn't fix the race. It
> > > would be
> > > =C2=A0 > necessary to stop processing fuse_fd in the thread before cl=
osing it
> > > =C2=A0 > here or to schedule a BH in each thread so that fuse_fd can =
be closed
> > > =C2=A0 > in the thread that uses the fd.
> > >=20
> >=20
>=20

--1QYue+6liwDkriV/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjRiiwACgkQnKSrs4Gr
c8ir/wf/ZNUSoAorwq1lD1xjlhHHY/OitHcaGWErD74iVBAfT6YGYH2eToVL+Ebm
cCTE5d+muuUgXdlFbhU6AV9Z5YavSYV/G2UkQt4AI9LMErVND9bppDTdzZaDnzXF
dZOMFtqIprraUeiJwpGeR+ezzgIQ2q8WbJjc+1apriGPbpCYwYTyGDH741ek51gA
HZIE8IJgMPNSi9UBtphGkeg0IjVImCDzZ34lld8NVuJlriHzQ4FRwWkGKyqKnQ50
fvg0eNkNtuJ2Eu49FJkHNL2u9UhUJCMRc2zEoFbJEnWY9Y7QvMB04FJLrn8Zk91m
OiG4f/fGim8OYzYwGWT54gaY875A5w==
=vSYb
-----END PGP SIGNATURE-----

--1QYue+6liwDkriV/--


