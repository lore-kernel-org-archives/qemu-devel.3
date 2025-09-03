Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E2BCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk7I-0006yY-9e; Wed, 03 Sep 2025 05:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utk7D-0006tZ-7i
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utk7B-0001L4-Bb
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756892954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HHMuG/ubf7QR4150GbYF3U76I8nyrdV1IZLpMXxZh5I=;
 b=JPe4YTADKZiwJ5UMEe/wkday0uBkxbu9CgBsiwjrGpazKy4sBuTCU7ojw8/7ULk9lDfKZs
 zzZx3m6O+TA5XkKd/4rlnG9Ezu+nzQKDjrdVlSFcw15xWY1opo5sTf8zWHaPsqab+4zkx4
 qjd9qDipbNuDGgAXpGp4G9xVwoqSVcM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-2hR7wc7KM_K0bbdfwUM8Sg-1; Wed,
 03 Sep 2025 05:49:11 -0400
X-MC-Unique: 2hR7wc7KM_K0bbdfwUM8Sg-1
X-Mimecast-MFC-AGG-ID: 2hR7wc7KM_K0bbdfwUM8Sg_1756892950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 268731956094; Wed,  3 Sep 2025 09:49:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD5E918003FC; Wed,  3 Sep 2025 09:49:08 +0000 (UTC)
Date: Wed, 3 Sep 2025 11:49:07 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 0/4] export/fuse: Add FUSE-over-io_uring for Storage
 Exports
Message-ID: <20250903094907.GA106431@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <CAKWCU7VusNOUskuxc3RMTd+aLY6bSX+de-LiUhe9xpdmbzkn-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TdlqfZfmZcK46Bp7"
Content-Disposition: inline
In-Reply-To: <CAKWCU7VusNOUskuxc3RMTd+aLY6bSX+de-LiUhe9xpdmbzkn-Q@mail.gmail.com>
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


--TdlqfZfmZcK46Bp7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 08:00:00AM -0400, Brian Song wrote:
> We used fio to test a 1=E2=80=AFGB file under both traditional FUSE and
> FUSE-over-io_uring modes. The experiments were conducted with the
> following iodepth and numjobs configurations: 1-1, 64-1, 1-4, and 64-4,
> with 70% read and 30% write, resulting in a total of eight test cases,
> measuring both latency and throughput.
>=20
> Test results:
>=20
> https://gist.github.com/hibriansong/a4849903387b297516603e83b53bbde4

Hanna: You benchmarked the FUSE export coroutine implementation a little
while ago. What do you think about these results with
FUSE-over-io_uring?

What stands out to me is that iodepth=3D1 numjobs=3D4 already saturates the
system, so increasing iodepth to 64 does not improve the results much.

Brian: What is the qemu-storage-daemon command-line for the benchmark
and what are the details of /mnt/tmp/ (e.g. a preallocated 10 GB file
with an XFS file system mounted from the FUSE image)?

Thanks,
Stefan

>=20
>=20
>=20
>=20
> On 8/29/25 10:50 PM, Brian Song wrote:
> > Hi all,
> >
> > This is a GSoC project. More details are available here:
> > https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_exp=
orts
> >
> > This patch series includes:
> > - Add a round-robin mechanism to distribute the kernel-required Ring
> > Queues to FUSE Queues
> > - Support multiple in-flight requests (multiple ring entries)
> > - Add tests for FUSE-over-io_uring
> >
> > More detail in the v2 cover letter:
> > https://lists.nongnu.org/archive/html/qemu-block/2025-08/msg00140.html
> >
> > And in the v1 cover letter:
> > https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00280.html
> >
> >
> > Brian Song (4):
> >    export/fuse: add opt to enable FUSE-over-io_uring
> >    export/fuse: process FUSE-over-io_uring requests
> >    export/fuse: Safe termination for FUSE-uring
> >    iotests: add tests for FUSE-over-io_uring
> >
> >   block/export/fuse.c                  | 838 +++++++++++++++++++++------
> >   docs/tools/qemu-storage-daemon.rst   |  11 +-
> >   qapi/block-export.json               |   5 +-
> >   storage-daemon/qemu-storage-daemon.c |   1 +
> >   tests/qemu-iotests/check             |   2 +
> >   tests/qemu-iotests/common.rc         |  45 +-
> >   util/fdmon-io_uring.c                |   5 +-
> >   7 files changed, 717 insertions(+), 190 deletions(-)
> >
>=20

--TdlqfZfmZcK46Bp7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi4DxMACgkQnKSrs4Gr
c8iK1Af/bJRa0Qz7zmmamIXJCfr2F+o3DKSjFGgdLm/DN8fO5weHIVYTPPwE/8vh
OcEhVjaICU2RH6XnYSDv1jmdTIkpXt6b8lNDYM0TwAgq1vPyPGxvKYOuAiU/TVfa
jG/PfLITJMUSzCQEDpwjlr1ox/LS47QZeejElvyavl0VpJsMKgy0IDCpv4UtoH66
dnyRY8RPlapj9+FnhVdj1hfUB7AlBtiMjBEACBw+6742KDcNqtf7N9QkDNfu6Ln/
GTvqVjL756f5YdclIgW15wgo6WLeQ1knzUBMA+4za59Tum48PptZ8RzYE48hGG+y
pQ88FTdLNFwnZnLL8Jixx+skBv4MVw==
=JXEY
-----END PGP SIGNATURE-----

--TdlqfZfmZcK46Bp7--


