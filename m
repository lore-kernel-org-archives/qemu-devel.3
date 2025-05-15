Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBF2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFa72-0007mN-MW; Thu, 15 May 2025 11:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFa6v-0007ga-7M
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFa6s-00082R-EV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747321376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h39UO8uiCVl5PbQb7q0ZgbKsbC0VZkkOwxcAdeMl5pY=;
 b=ZKriKAnAU6LLeKqN+6h9Fe7TRkh3TWfrbUJgJyVdhIfQh6SH6kSk09n976fmkcpbm792g2
 e+4KpYoq7g8c1OLqS53Ojyl3BChYDt6LqnKbjzSNHwlHv5Y5tf1WUs2vZQpYliAy3h+Wgt
 QmPjnLACIGv3f+Fx58M40eNE3epvzd0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-H0W-zXVQPSeoxDfaGZAClQ-1; Thu,
 15 May 2025 11:02:53 -0400
X-MC-Unique: H0W-zXVQPSeoxDfaGZAClQ-1
X-Mimecast-MFC-AGG-ID: H0W-zXVQPSeoxDfaGZAClQ_1747321372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 787691955F44; Thu, 15 May 2025 15:02:52 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.242])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EACC9180087A; Thu, 15 May 2025 15:02:49 +0000 (UTC)
Date: Thu, 15 May 2025 17:02:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 bmarzins@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <aCYCFrh_As6XuPQj@redhat.com>
References: <20250513113730.37404-1-kwolf@redhat.com>
 <20250513135148.GB227327@fedora> <aCWiuYUWiwKJz4_j@redhat.com>
 <20250515140142.GA333399@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iC1n4dozRk9Hs1l1"
Content-Disposition: inline
In-Reply-To: <20250515140142.GA333399@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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


--iC1n4dozRk9Hs1l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.05.2025 um 16:01 hat Stefan Hajnoczi geschrieben:
> On Thu, May 15, 2025 at 10:15:53AM +0200, Kevin Wolf wrote:
> > Am 13.05.2025 um 15:51 hat Stefan Hajnoczi geschrieben:
> > > On Tue, May 13, 2025 at 01:37:30PM +0200, Kevin Wolf wrote:
> > > > When scsi-block is used on a host multipath device, it runs into the
> > > > problem that the kernel dm-mpath doesn't know anything about SCSI or
> > > > SG_IO and therefore can't decide if a SG_IO request returned an err=
or
> > > > and needs to be retried on a different path. Instead of getting wor=
king
> > > > failover, an error is returned to scsi-block and handled according =
to
> > > > the configured error policy. Obviously, this is not what users want,
> > > > they want working failover.
> > > >=20
> > > > QEMU can parse the SG_IO result and determine whether this could ha=
ve
> > > > been a path error, but just retrying the same request could just se=
nd it
> > > > to the same failing path again and result in the same error.
> > > >=20
> > > > With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mp=
ath
> > > > block devices (queued in the device mapper tree for Linux 6.16), we=
 can
> > > > tell the kernel to probe all paths and tell us if any usable paths
> > > > remained. If so, we can now retry the SG_IO ioctl and expect it to =
be
> > > > sent to a working path.
> > > >=20
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > ---
> > > >  block/file-posix.c | 82 ++++++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 81 insertions(+), 1 deletion(-)
> > >=20
> > > Maybe the probability of retry success would be higher with a delay so
> > > that intermittent issues have time to resolve themselves. Either way,
> > > the patch looks good.
> >=20
> > I don't think adding a delay here would be helpful. The point of
> > multipath isn't that you wait until a bad path comes back, but that you
> > just switch to a different path until it is restored.
>=20
> That's not what this loop does. DM_MPATH_PROBE_PATHS probes all paths
> and fails when no paths are available. The delay would only apply in the
> case when there are no paths available.
>=20
> If the point is not to wait until some path comes back, then why loop at
> all?

DM_MPATH_PROBE_PATHS can only send I/O to paths in the active path
group, so it doesn't fail over to different path groups. If there are no
usable paths left in the current path group, but there are some in
another one, then the ioctl returns 0 and the next SG_IO would switch to
a different path group, which may or may not succeed. If it fails, we
have to probe the paths in that group, too.

> > Ideally, calling DM_MPATH_PROBE_PATHS would just remove all the bad
> > paths instantaneously and we would either be able to send the request
> > using one of the remaining good paths, or know that we have to fail. In
> > practice, the ioctl will probably have to wait for a timeout, so you get
> > a delay anyway.
>=20
> True, if the read requests themselves time out rather than failing with
> an immediate error, then no delay is required. I guess both cases can
> happen and userspace has no visibility aside from measuring the time
> spent in the ioctl.

Right. But if they fail with an immediate error, that's really what we
want because it means no I/O that is stuck for a long time.

Kevin

--iC1n4dozRk9Hs1l1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmgmAhYACgkQfwmycsiP
L9awqhAApNwMYdMjFlxCNBTaZ4D2VzuSzk/OyTdllsxv4k0bU8wg/mddwV/t/SlD
zobIfjJ/VDjKw79d5a0pYwq0dUUqPDk2WTOHquHO32ZvPeYCU9bHpPYJm04tw2AG
6cqRDCL0S5DyFBUWKFwSws8rbOV76sqGgZzYma4rck7NFeKfget4oiMTqwsZqhm+
vFWsXWLhOzJ3mFZdsk6AiTL1/3CicX0BHpJQVgG3eP/xVO1m3PKsQyTpWCpzNnUv
u4RqGJtIQh4GlM+WJwlI7OJYy8nUf1E4qfgn8Z+XiP5psWYiOEw+v/qUJF2vx9H7
t+ZWuyEpi66N5tbxqdHq94+orkgGTuGzxoWB1vI/PFRxMLibZQoWfWSqMEvByulZ
AHshTG1J8v3tbu+0SGG42y9HaKt6FNher7wAS6aycBx2wH+Nk6tpJ+nP70mkqK99
4HvSrSgghc1LglQpyB3D2f2O2t0kbhHpXBsMCBb1YH6Urm6i+A4bp7DtVNZflcGR
Bx8L+e2sYPP3CKrNQJ5Q1Qncxl2cGv8Tcjd4uZUEWPWVo1KFOF3C3JKOlV0Q/N/v
pNNnMtFXCTlkodCPCCusBUE+vTgPwUT3B2Jr/JJgxoRz19wTYhKaqmQrIVxIjYGZ
OiUkkmHdYSuSXaGsoVEjLULqKhScH9sK8B6byF9l1b7lItlBPE8=
=ryR8
-----END PGP SIGNATURE-----

--iC1n4dozRk9Hs1l1--


