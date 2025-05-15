Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A737FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 14:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFZAZ-0004E2-K8; Thu, 15 May 2025 10:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFZ9o-0003pj-Hz
 for qemu-devel@nongnu.org; Thu, 15 May 2025 10:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFZ9k-000896-1T
 for qemu-devel@nongnu.org; Thu, 15 May 2025 10:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747317710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKplkudCQQeev75cQQnxtQKnjfU6fBv/8/4p03hIWn0=;
 b=EZb8wa4zugk/R35jcarl7gOoBsdqxx+8ubnW7oTPQEaXfszDO7NveXOOKi+OTyPgvOh3Fx
 PQ4aYA6iXGGTPKe7yxZ0XbkOisNEHpHAq9AagJUT1vtcoo7bcdDVfJuOJT3ymFDRPu3mK8
 9wv5w0GanpzUQtqkb9dCBnqFxUcgV2Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-sBi451pTNqm5EOSbPos8yQ-1; Thu,
 15 May 2025 10:01:45 -0400
X-MC-Unique: sBi451pTNqm5EOSbPos8yQ-1
X-Mimecast-MFC-AGG-ID: sBi451pTNqm5EOSbPos8yQ_1747317704
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB7A31801A15; Thu, 15 May 2025 14:01:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.170])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C7B9195608D; Thu, 15 May 2025 14:01:43 +0000 (UTC)
Date: Thu, 15 May 2025 10:01:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 bmarzins@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <20250515140142.GA333399@fedora>
References: <20250513113730.37404-1-kwolf@redhat.com>
 <20250513135148.GB227327@fedora> <aCWiuYUWiwKJz4_j@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MOCXL0TR7BkIAWtm"
Content-Disposition: inline
In-Reply-To: <aCWiuYUWiwKJz4_j@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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


--MOCXL0TR7BkIAWtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:15:53AM +0200, Kevin Wolf wrote:
> Am 13.05.2025 um 15:51 hat Stefan Hajnoczi geschrieben:
> > On Tue, May 13, 2025 at 01:37:30PM +0200, Kevin Wolf wrote:
> > > When scsi-block is used on a host multipath device, it runs into the
> > > problem that the kernel dm-mpath doesn't know anything about SCSI or
> > > SG_IO and therefore can't decide if a SG_IO request returned an error
> > > and needs to be retried on a different path. Instead of getting worki=
ng
> > > failover, an error is returned to scsi-block and handled according to
> > > the configured error policy. Obviously, this is not what users want,
> > > they want working failover.
> > >=20
> > > QEMU can parse the SG_IO result and determine whether this could have
> > > been a path error, but just retrying the same request could just send=
 it
> > > to the same failing path again and result in the same error.
> > >=20
> > > With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> > > block devices (queued in the device mapper tree for Linux 6.16), we c=
an
> > > tell the kernel to probe all paths and tell us if any usable paths
> > > remained. If so, we can now retry the SG_IO ioctl and expect it to be
> > > sent to a working path.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block/file-posix.c | 82 ++++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 81 insertions(+), 1 deletion(-)
> >=20
> > Maybe the probability of retry success would be higher with a delay so
> > that intermittent issues have time to resolve themselves. Either way,
> > the patch looks good.
>=20
> I don't think adding a delay here would be helpful. The point of
> multipath isn't that you wait until a bad path comes back, but that you
> just switch to a different path until it is restored.

That's not what this loop does. DM_MPATH_PROBE_PATHS probes all paths
and fails when no paths are available. The delay would only apply in the
case when there are no paths available.

If the point is not to wait until some path comes back, then why loop at
all?

> Ideally, calling DM_MPATH_PROBE_PATHS would just remove all the bad
> paths instantaneously and we would either be able to send the request
> using one of the remaining good paths, or know that we have to fail. In
> practice, the ioctl will probably have to wait for a timeout, so you get
> a delay anyway.

True, if the read requests themselves time out rather than failing with
an immediate error, then no delay is required. I guess both cases can
happen and userspace has no visibility aside from measuring the time
spent in the ioctl.

> What could potentially be useful is a new error policy [rw]error=3Dretry
> with a configurable delay. This wouldn't be in file-posix, but in the
> devices after file-posix came to the conclusion that there is currently
> no usable path. On the other hand, retrying indefinitely is probably not
> what you want either, so that could quickly become rather complex.

Yes, it will be complex. I have no objection to this patch as-is.

Stefan

--MOCXL0TR7BkIAWtm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgl88YACgkQnKSrs4Gr
c8jKjggAk7dp1gz+BITrYQH15on3Yq2ucW8EyD0Gcbv7lTPkyJtwG57ZCwICtTkt
0uhJ+lkGpMn3WCCORHzsliY2+L23hQbgTnJIcfjHP6NDDj+ZwDcrhmpCpSo1Cvrv
NadJ+ebp2xiV+GJswRH8kg//Gnbwylwm5WLFq01s7HnVnuNhNS0a0XtDd8Yv7/+t
kKUSP04XsNU7ZjkeFOMfZeBKz2oNHJpfwamU7IXvQlfrSu7A3j6U+l5+j/MtCA0I
wa2RF6/yzrmbJJrUQa3b/J2ylywJRrWVs2trmmnVQua92tp5BMtISCknaKf5SHzM
rJnW532Met/EmkCZu9HnoM2SZwWfSw==
=0bym
-----END PGP SIGNATURE-----

--MOCXL0TR7BkIAWtm--


