Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62986CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUOA-0002A1-Nb; Thu, 30 Oct 2025 11:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUO8-00028K-Fk
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUNm-0005XQ-Ba
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eab2tx2w5QXiUqXcIAbs5awDyQgrZ3ZVoJUi/axt7sY=;
 b=SWPex6BnFXOHOQikm1Ngd8ZCmfL5UUHnJyJ09v55vZSRKq5eexlJLEEGnRW7t75bTc/zqq
 uinTL077vrGC7St0hrmC3440pnWlfKi+qgXRNHC8iexz1qeq+vOMEAw18JQtjd78fYrFAH
 EQrz/juE51/HC8ZGKM3zNFzYk1PE5SU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-g7RDu2_7PIOKlV8XeQuzqw-1; Thu,
 30 Oct 2025 11:15:45 -0400
X-MC-Unique: g7RDu2_7PIOKlV8XeQuzqw-1
X-Mimecast-MFC-AGG-ID: g7RDu2_7PIOKlV8XeQuzqw_1761837345
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C97E019560B2; Thu, 30 Oct 2025 15:15:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5944219560BC; Thu, 30 Oct 2025 15:15:44 +0000 (UTC)
Date: Thu, 30 Oct 2025 11:15:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 hibriansong@gmail.com, qemu-block@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com
Subject: Re: [PATCH v5 00/12] aio: add the aio_add_sqe() io_uring API
Message-ID: <20251030151543.GA462334@fedora>
References: <20251029203411.445852-1-stefanha@redhat.com>
 <aQN5q47Lw2Bv8I_X@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BSRB53UMvLFCYZXL"
Content-Disposition: inline
In-Reply-To: <aQN5q47Lw2Bv8I_X@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--BSRB53UMvLFCYZXL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 03:43:55PM +0100, Kevin Wolf wrote:
> Am 29.10.2025 um 21:33 hat Stefan Hajnoczi geschrieben:
> > v5:
> > - Explain how fdmon-io_uring.c differs from other fdmon implementations
> >   in commit message [Kevin]
> > - Move test-nested-aio-poll aio_get_g_source() removal into commit that=
 touches test case [Kevin]
> > - Avoid g_source_add_poll() use-after-free in fdmon_poll_update() [Kevi=
n]
> > - Avoid duplication in fdmon_epoll_gsource_dispatch(), use fdmon_epoll_=
wait() [Kevin]
> > - Drop unnecessary revents checks in fdmon_poll_gsource_dispatch() [Kev=
in]
> > - Mention in commit message that fdmon-io_uring.c is the new default [K=
evin]
> > - Add comments explaining how to clean up resources in error paths [Kev=
in]
> > - Indicate error in return value from function with Error *errp arg [Ke=
vin]
> > - Add patch to unindent fdmon_io_uring_destroy() [Kevin]
> > - Add patch to introduce FDMonOps->dispatch() callback [Kevin]
> > - Drop patch with hacky BH optimization for fdmon-io_uring.c [Kevin]
> > - Replace cqe_handler_bh with FDMonOps->dispatch() [Kevin]
> > - Rename AioHandler->cqe_handler field to ->internal_cqe_handler [Kevin]
> > - Consolidate fdmon-io_uring.c trace-events changes into this commit
> > - Reduce #ifdef HAVE_IO_URING_PREP_WRITEV2 code duplication [Kevin]
>=20
> Actually the whole last patch that contained the duplication seems to be
> missing. Did you accidentally remove it?

Yes. I'll resend in a few moments.

Stefan

--BSRB53UMvLFCYZXL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkDgR8ACgkQnKSrs4Gr
c8iXggf/dX64dCKSe98EoBIM64LdWgxIJHo5K/DJjOxCTdT+FG51ukX+7akEtjEj
MPpCXNqUK3Cc90wSNMUPNWvi0euE/+ytJmw6qOE+5N6rvyTT+hZQSSmIe+l0+zME
Ddvdo98cCvm1hwFmDLBpMvEEvRYtmIjnRDq/lRpjyeuUAAWWc+mUx4wSX+RTn/F9
xvpoG4mEf9vXmvXKAxMPBDd/mMDnv93Sa9RZwcLu0AGstypb0jL6AfP+4zw4cRup
7wsBYDjFnb+r6mxT808pVLw3pgwsgGrmXKVVFy2gbpecnEJIvdt7atsbmznaNMks
jq7YJu5/GiCtqzxdInxf3iMJiTO7zw==
=rZTo
-----END PGP SIGNATURE-----

--BSRB53UMvLFCYZXL--


