Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3488C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueEK4-0001XW-Vh; Tue, 22 Jul 2025 10:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueEHH-0007be-Fv
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueEHF-0003oh-Gt
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753195651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V21aGfgtRedGK4eXZ9WWzEfFrJCE0djBbVWpDfpgI70=;
 b=HqHTjWDUnCzEM9EoDRH43IVxMh45wTQqJx7h90PedOTy7jWZwb8eAK/S3QpdOqxHEghm9i
 XqMFpMpUX7U0JCyYRK8dfucQK08F5R3cPyH9ZkE5g3MtzW99djSepQaM8NeXn6udwTWwva
 deQZfOrE318FC8ht7JfWwbMbSguwpaA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-ie_8FI_bM0KmqqnZvJPqeg-1; Tue,
 22 Jul 2025 10:47:26 -0400
X-MC-Unique: ie_8FI_bM0KmqqnZvJPqeg-1
X-Mimecast-MFC-AGG-ID: ie_8FI_bM0KmqqnZvJPqeg_1753195645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0482E1800343; Tue, 22 Jul 2025 14:47:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A56418002AF; Tue, 22 Jul 2025 14:47:23 +0000 (UTC)
Date: Tue, 22 Jul 2025 10:47:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bschubert@ddn.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH RFC 0/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <20250722144722.GD8264@fedora>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250720161351.GA32887@fedora>
 <CAKWCU7XqQc=cyn36MR9C7R_0S2ZKEPBdt6eUOZ-LxtRZuegsbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bNkonkB4NXCTuVVZ"
Content-Disposition: inline
In-Reply-To: <CAKWCU7XqQc=cyn36MR9C7R_0S2ZKEPBdt6eUOZ-LxtRZuegsbw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
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


--bNkonkB4NXCTuVVZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 08:00:00AM -0400, Brian Song wrote:
> On 7/20/25 12:13 PM, Stefan Hajnoczi wrote:
> > On Wed, Jul 16, 2025 at 02:38:23PM -0400, Brian Song wrote:
> >> This RFC patch represents an initial implementation of the FUSE-over-
> >> io_uring Exports idea proposed for Google Summer of Code (2025) under
> >> the QEMU community:
> >> https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_ex=
ports
> >>
> >> The implementation approach is primarily borrowed from how libfuse
> >> interacts with the kernel.
> >>
> >> FUSE-over-io_uring (https://docs.kernel.org/next/filesystems/fuse-io-
> >> uring.html) has been officially merged into the Linux kernel. The idea
> >> is to replace the traditional /dev/fuse based communication with a more
> >> efficient io_uring-based approach. In this model, userspace registers
> >> io_uring SQEs via the FUSE_IO_URING_CMD_REGISTER opcode, and then waits
> >> for the kernel to forward FUSE requests as CQEs. These are processed by
> >> the FUSE exports implementation in userspace and then committed back to
> >> the kernel using FUSE_IO_URING_CMD_COMMIT_AND_FETCH.
> >>
> >> To enable this feature in qemu-export-daemon, simply add the uring=3Don
> >> option to the export configuration.
> >
> > For consistency with the --blockdev file,aio=3Dio_uring option, please
> > name it "io_uring=3Don" instead of "uring=3Don".
> >
>=20
> It seems we are not allowed to use '_' here.
>=20
> In file included from ../storage-daemon/qapi/qapi-schema.json:57:
>=20
> ../storage-daemon/qapi/../../qapi/block-export.json: In struct
> 'BlockExportOptionsFuse':
>=20
> ../storage-daemon/qapi/../../qapi/block-export.json:191: name of 'data'
> member '*io_uring' must not use uppercase or '_'

Then "-" is fine, but please use "io<separator>uring" so it is as close
as possible (not "uring", "iouring", etc).

Thanks,
Stefan

>=20
>=20
> >>
> >> As this patch is still in the RFC stage, it currently supports **only
> >> single thread**. Due to protocol requirements in FUSE-over-io_uring,
> >> the number of FUSE threads must match the number of CPUs. Therefore,
> >> this initial version only works on single-core VMs (i.e., QEMU started
> >> with -smp 1) or single core machine.
> >>
> >> Brian Song (1):
> >>    block/export: FUSE-over-io_uring Support for QEMU FUSE Exports
> >>
> >>   block/export/fuse.c                  | 423 +++++++++++++++++++++++++=
--
> >>   docs/tools/qemu-storage-daemon.rst   |  10 +-
> >>   qapi/block-export.json               |   6 +-
> >>   storage-daemon/qemu-storage-daemon.c |   1 +
> >>   util/fdmon-io_uring.c                |   5 +-
> >>   5 files changed, 420 insertions(+), 25 deletions(-)
> >>
> >> --
> >> 2.50.1
> >>
>=20

--bNkonkB4NXCTuVVZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh/pHoACgkQnKSrs4Gr
c8gpWggAw5oNXutaeu6TLIyUCGiQcBmK+6z3VJ52QBwLEbocoXk1i2o21FkRFO8h
p+9Hkw2KVi0Yb+BM446PMyHtVmx5n1SeZrlWyTXRe0VIC4XTJ6/qU8Fq3xwS8zyh
ypZzzJSMs6N99NkXy9UbDJf9JLfbsBjqmjnvFIKNLauRkb8yCgNk9+lsOh0h2rq/
BETf7w3ZREh27DFZA9BV8uJb0KgA/QYgrNCvBusFnEQaXLEi5nd+S42l0S2kLqf/
wtaI+3a0sAK/beKQws0p6SGw5Rz9W+PiXN0c2SMomhrSbkhvN7I/tgq0VM3Snv4y
Mmcy+rlIRqnmorR0Zt0PSabqWdb3ZQ==
=fbcV
-----END PGP SIGNATURE-----

--bNkonkB4NXCTuVVZ--


