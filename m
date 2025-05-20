Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD5BC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNZN-00074o-SP; Tue, 20 May 2025 10:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNZK-00070W-W9
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNZJ-0006oq-AA
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n7ixXnJsvvTJitdRsTL9ixhhTWxyWh8J4K6H4I99UJk=;
 b=V5Y9zKOSlXYo89S5OvytWx8ZJ84jOvKd6FR82OX8+2FXAaFhUGR1c3t/hXYo9DDN9BjEV6
 AgiTmqvLXv2hV+1KWymynWL1HxYnAxFz6x5c1XJz2pLXYBqmqm7hREt3Y8xoIOcvAzH3UZ
 jZ8CEtQS7BWnxUeovxnzXmR1qEmGxOo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-eoj-uFIcPq-kJacP4mt_wA-1; Tue,
 20 May 2025 10:03:42 -0400
X-MC-Unique: eoj-uFIcPq-kJacP4mt_wA-1
X-Mimecast-MFC-AGG-ID: eoj-uFIcPq-kJacP4mt_wA_1747749821
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4055718001EA; Tue, 20 May 2025 14:03:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B07CD30001AA; Tue, 20 May 2025 14:03:40 +0000 (UTC)
Date: Tue, 20 May 2025 10:03:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 bmarzins@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <20250520140339.GC82528@fedora>
References: <20250513113730.37404-1-kwolf@redhat.com>
 <20250513135148.GB227327@fedora> <aCWiuYUWiwKJz4_j@redhat.com>
 <20250515140142.GA333399@fedora> <aCYCFrh_As6XuPQj@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m/GStFk1LjxzomWv"
Content-Disposition: inline
In-Reply-To: <aCYCFrh_As6XuPQj@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--m/GStFk1LjxzomWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 05:02:46PM +0200, Kevin Wolf wrote:
> Am 15.05.2025 um 16:01 hat Stefan Hajnoczi geschrieben:
> > On Thu, May 15, 2025 at 10:15:53AM +0200, Kevin Wolf wrote:
> > > Am 13.05.2025 um 15:51 hat Stefan Hajnoczi geschrieben:
> > > > On Tue, May 13, 2025 at 01:37:30PM +0200, Kevin Wolf wrote:
> > > > > When scsi-block is used on a host multipath device, it runs into =
the
> > > > > problem that the kernel dm-mpath doesn't know anything about SCSI=
 or
> > > > > SG_IO and therefore can't decide if a SG_IO request returned an e=
rror
> > > > > and needs to be retried on a different path. Instead of getting w=
orking
> > > > > failover, an error is returned to scsi-block and handled accordin=
g to
> > > > > the configured error policy. Obviously, this is not what users wa=
nt,
> > > > > they want working failover.
> > > > >=20
> > > > > QEMU can parse the SG_IO result and determine whether this could =
have
> > > > > been a path error, but just retrying the same request could just =
send it
> > > > > to the same failing path again and result in the same error.
> > > > >=20
> > > > > With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-=
mpath
> > > > > block devices (queued in the device mapper tree for Linux 6.16), =
we can
> > > > > tell the kernel to probe all paths and tell us if any usable paths
> > > > > remained. If so, we can now retry the SG_IO ioctl and expect it t=
o be
> > > > > sent to a working path.
> > > > >=20
> > > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > > ---
> > > > >  block/file-posix.c | 82 ++++++++++++++++++++++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 81 insertions(+), 1 deletion(-)
> > > >=20
> > > > Maybe the probability of retry success would be higher with a delay=
 so
> > > > that intermittent issues have time to resolve themselves. Either wa=
y,
> > > > the patch looks good.
> > >=20
> > > I don't think adding a delay here would be helpful. The point of
> > > multipath isn't that you wait until a bad path comes back, but that y=
ou
> > > just switch to a different path until it is restored.
> >=20
> > That's not what this loop does. DM_MPATH_PROBE_PATHS probes all paths
> > and fails when no paths are available. The delay would only apply in the
> > case when there are no paths available.
> >=20
> > If the point is not to wait until some path comes back, then why loop at
> > all?
>=20
> DM_MPATH_PROBE_PATHS can only send I/O to paths in the active path
> group, so it doesn't fail over to different path groups. If there are no
> usable paths left in the current path group, but there are some in
> another one, then the ioctl returns 0 and the next SG_IO would switch to
> a different path group, which may or may not succeed. If it fails, we
> have to probe the paths in that group, too.

This wasn't obvious to me, can that be emphasized in the code via naming
or comments? About retrying up to 5 times: is the assumption that there
will be 5 or fewer path groups?

Stefan

--m/GStFk1LjxzomWv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgsi7sACgkQnKSrs4Gr
c8geZAgAytxvZIoiE30pEi6j2+qs50CQluSTjteJIn4lTjQbx6LFZca7GlmxEVWl
3VbC/dJvYRoCadfuXUUtbY4QqAPyauSygJBm1ROn4B6XXxJVrfv3fU6OxKAvshaP
dBHq0l75G5Ib7FjpceC4nuFRV0vYt+UBwZyIxFqQETYB+C7DjKKp3V0Xq7LKA3S7
qJd7fcRWp1fT89TEauM5CfC9VuTLne4LGHCyzrzYcIMNCWPlTS4/grWyfT/wepnl
9K2vtWA875IhK9qt3THr59cHGEiaTITSzTelzmr07BfXCK+GpeRarQc0gm5Vx0nS
2wxCarsn9RTxfsZ64lqkvsVg5Tjqxw==
=zb45
-----END PGP SIGNATURE-----

--m/GStFk1LjxzomWv--


