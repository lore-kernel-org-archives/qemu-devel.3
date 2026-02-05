Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62AEEC1EBB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzaN-0005eZ-QY; Thu, 05 Feb 2026 08:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnza9-0005cm-42
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnza5-0007V7-HX
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770298776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=43Pl6VVpoucYWDhLditxSpS40NK6l++RsukU4AMmf/o=;
 b=XJ6objt2Xqu/LB80pn8NDedAWE0GjDvZ91x2OLLL45cY+qVyhvnvQnHQcVVRKfbuFXJEcv
 fiupR6Yeccr5HSnSUCo5KsUMcqoBujFuuArJ219kaV6vUZYZ/8V1MmLDCw+pgrfTVKaOVb
 Zq0atTXvAJGuwZgZd7MJZ8Kcd5jiB7s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-FtxnuaNMPqiqIaxNzg7JNg-1; Thu,
 05 Feb 2026 08:39:33 -0500
X-MC-Unique: FtxnuaNMPqiqIaxNzg7JNg-1
X-Mimecast-MFC-AGG-ID: FtxnuaNMPqiqIaxNzg7JNg_1770298772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46A09195608E; Thu,  5 Feb 2026 13:39:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53CAC18003F6; Thu,  5 Feb 2026 13:39:31 +0000 (UTC)
Date: Thu, 5 Feb 2026 08:39:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260205133930.GA36872@fedora>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RkHMEBw0D8U8PPdz"
Content-Disposition: inline
In-Reply-To: <aYSGia2Zy_g5iop5@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--RkHMEBw0D8U8PPdz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 12:01:13PM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Feb 05, 2026 at 12:52:33PM +0100, Martin Wilck wrote:
> > On Wed, 2026-02-04 at 13:32 -0500, Stefan Hajnoczi wrote:
> > > On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> > > > Hi Stefan,
> > > >=20
> > > > So the ioctls will pass through qemu into the kernel, to be
> > > > intercepted
> > > > by the dm-mpath driver, which will use an upcall to have them
> > > > handled
> > > > by mpathpersistd (for the actual command) and multipathd (for the
> > > > path
> > > > registrations).
> > > >=20
> > > > I don't fully understand the advantage, security and complexity-
> > > > wise,
> > > > of this concept, compared to intercepting them qemu and using a
> > > > socket
> > > > to talk to mpathpersistd directly. If we did this, we could even
> > > > support both generic and SCSI PR commands.
> > >=20
> > > Hi Martin,
> > > The simplification and security benefits are on the application side,
> > > not on the DM-Multipath side, so I can see what you're getting at.
> > > From
> > > the DM-Multipath perspective things get a little more complex.
> > >=20
> > > From an application perspective, a single API that works across block
> > > device types (SCSI, NVMe, DM-Multipath) and requires no privileges or
> > > sockets (they are a pain in container environments) is the most
> > > convenient. The <linux/pr.h> ioctl API offers exactly this.
> >=20
> > I may be missing something, but AFAICS the PR ioctls require having a
> > block device open for writing, which does either require root
> > privileges, or some file descriptor previously opened with privileges
> > and forwarded to another, less privileged process. No?
>=20
> While QEMU is run unprivileged, libvirt will grant QEMU access any block
> devices that have been configured for the guest in question. On Linux,
> libvirt will create a new /dev tmpfs populated with the allow-list of
> device nodes the guest is permitted to access, with suitable file
> permissions, ownership & SELinux labels set.

Ultimately something does require privileges to give an unprivileged
application access to a block device. That could be udev rules, it could
be libvirt, etc.

I would say the real distinction is between the privileges needed so the
application can access the block device vs the privileges needed to
perform PR operations. If udev or libvirt has set up block device nodes,
an unprivileged application can open them for read/write access. But it
would require CAP_SYS_RAWIO for SG_IO PR operations on top of that
whereas <linux/pr.h> ioctls do not require that.

Therefore there is a real advantages regarding privileges when using
<linux/pr.h> ioctls vs libmpathpersist.

Stefan

--RkHMEBw0D8U8PPdz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmEnZEACgkQnKSrs4Gr
c8jJVgf/Xk9V4k7V5KTUyHppS/5yHdL41QnwkWqJVI6KAOJDjuijEugBOcfr52VW
FKYoQHO/rJyhs34KS2RyonCy1W/7wZZ3LvqmKdFn748P5FfNYhH+Oe4FeB/mdSfR
MlUHWTVh83kPhe9GfWY55467qBWpOBoI/CQLCo/Q0S9wFYMI2hiXJdtDgr2Drv72
kI9IwEDbbYp2rqNfngdiEMBJvVlhKYbMI0fQuV/xwqouPBcaFz8ISa2M12/hekzY
EiZO/R6saWydO00GF4SM4zMpl1Msar8Fq57gsBgFSZzkX4zVIrBJ8lCdB98Gophz
G20rja6XhmjCzRWkL3xOJwnpDBkwLQ==
=0rYN
-----END PGP SIGNATURE-----

--RkHMEBw0D8U8PPdz--


