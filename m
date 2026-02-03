Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73DAE87850
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 18:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnKlc-0004mk-Om; Tue, 03 Feb 2026 13:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnKla-0004ls-Ki
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnKlY-0005ll-SK
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770141882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yliCht6fNJIMe8mPnn3hP7yEz4DGzTdVPu8eipS+JZM=;
 b=FniJsx7DuOZUHwd5Tlz2ugymGaOPrKjUPwx2PYvzSmu68GFCItSfJmLtI0XLmisFo6kx5z
 SECl/ut5gi/DLIDYAYW/z/cqplRrTJ0JHwB/y+h3vBD6oh0Zp8U8GFx8DHWPfeyjv9fSxR
 5fwGU6635KUh2DNfqroW73LdFA0tu3M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-V4m7pchkPr-XzfxTWwh-lA-1; Tue,
 03 Feb 2026 13:04:41 -0500
X-MC-Unique: V4m7pchkPr-XzfxTWwh-lA-1
X-Mimecast-MFC-AGG-ID: V4m7pchkPr-XzfxTWwh-lA_1770141880
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A20A619560B2; Tue,  3 Feb 2026 18:04:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3780E30001A7; Tue,  3 Feb 2026 18:04:39 +0000 (UTC)
Date: Tue, 3 Feb 2026 13:04:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>, Martin Wilck <mwilck@suse.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260203180437.GA527989@fedora>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xNf4TCGDHELYMfpk"
Content-Disposition: inline
In-Reply-To: <aYI2CAjmHGklh3mi@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--xNf4TCGDHELYMfpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 12:53:12PM -0500, Benjamin Marzinski wrote:
> On Tue, Feb 03, 2026 at 10:09:39AM -0500, Stefan Hajnoczi wrote:
> > On Tue, Jan 27, 2026 at 04:06:03PM -0500, Benjamin Marzinski wrote:
> > > On Tue, Jan 27, 2026 at 01:47:43PM -0500, Stefan Hajnoczi wrote:
> > > > Hi Benjamin and Paolo,
> > > > I would like to discuss changes to DM-Multipath and qemu-pr-helper =
to
> > > > handle SCSI Persistent Reservations in QEMU without privileged code.
> > > >=20
> > > > SCSI Persistent Reservations support in QEMU is built on the
> > > > qemu-pr-helper daemon that performs PERSISTENT RESERVATION IN and
> > > > PERSISTENT RESERVATION OUT commands on behalf of the guest. The
> > > > qemu-pr-helper process provides privilege separation for ioctl(SG_I=
O)'s
> > > > CAP_SYS_RAWIO and libmpathpersist's root privileges since the main =
QEMU
> > > > process should not have those privileges.
> > > >=20
> > > > There are issues with the current approach:
> > > > - Privileged code is a security attack surface.
> > > > - A bunch of code is required for privilege separation and for mana=
gement
> > > >   tools to set up qemu-pr-helper with access to multipathd.
> > > > - The interface is SCSI-specific and does not support NVMe.
> > > >=20
> > > > Several of us have pondered a different approach that I will summar=
ize
> > > > here. The <linux/pr.h> ioctl interface provides an alternative to
> > > > ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
> > > > SCSI and NVMe. Since privileges are not required, there would be no=
 need
> > > > for the qemu-pr-helper daemon anymore.
> > > >=20
> > > > The blocker is that <linux/pr.h> is not usable in multipath
> > > > environments. The Linux DM-Multipath driver has an incomplete ioctl
> > > > implementation that falls short of what libmpathpersist and multipa=
thd
> > > > do in userspace. Kernel changes are necessary to fix this.
> > > >=20
> > > > My suggestion is to implement <linux/pr.h> via upcalls from DM-Mult=
ipath
> > > > to multipathd. That way applications like QEMU can consistently use
> > > > <linux/pr.h> across block device types and no longer have to go thr=
ough
> > > > the privileged libmpathpersist interface.
> > >=20
> > > This would take intercepting the pr commands to multipath devices rig=
ht
> > > at the start of dm_call_pr(). In order to make some persistent
> > > reservation commands seem atomic, libmpathpersist needs to suspend the
> > > multipath device in certain situations. So device-mapper cannot call
> > > dm_get_live_table(), since this will block suspends. This should be o=
=2Ek.
> > > Libmpathpersist is designed to handle the possiblity that the multipa=
th
> > > device gets reloaded with different paths while it is running. And si=
nce
> > > the multipath target is an immutable singleton target, there is no
> > > possibility of it turning into another target type because of a table
> > > reload during suspend.
> > >=20
> > > Also, just to clarify, the kernel code can't interface directly with
> > > multipathd. Most of the code for handling persistent reservations is =
in
> > > libmpathpersist, which just needs multipathd to do things like make s=
ure
> > > that paths that are added in the furture get registered properly. The=
re
> > > would likely need to be some new program (that is just a thin wrapper
> > > around libmpathpersist) which can be called with call_usermodehelper(=
).
>=20
> Adding Martin Wilck, since he will also be looking at these changes.
> =20
> > Hi everyone,
> > I'm starting to work on the DM-Multipath changes. Some more details on
> > how I am approaching this:
> >=20
> > - multipath-tools will create multipath device-mapper targets with a new
> >   ctr argument (pr_netlink) when this feature is enabled. When the
> >   feature is disabled, everything remains backwards compatible. With the
> >   pr_netlink ctr argument, the multipath target sends a netlink
> >   multicast group notification instead of handling PR operations (e.g.
> >   IOC_PR_* ioctls) in the kernel.
> >=20
> > - There will be a new program in multipath-tools called mpathpersistd
> >   that listens on the netlink multicast group for notifications. The
> >   notification tells it which multipath device has a pending PR
> >   operation. It fetches the PR operation parameters by sending a netlink
> >   message, performs the persistent reservation operation via
> >   libmpathpersist, and then sends a response to the kernel via another
> >   netlink message.
> >=20
> > - The multipath device-mapper target completes the PR operation upon
> >   receiving the netlink response.
> >=20
> > I ended up choosing netlink because call_usermodehelper() seems less
> > appropriate for an operation triggered by untrusted userspace processes.
> >=20
> > Your input is welcome. Let me know if a different approach would be
> > better.
>=20
> Is the netlink interface going to be a generic persistent reservation
> upcall interface, or it this just for dm multipath? I'm not sure if
> there would ever be another user, and I don't have enough experience
> with the netlink code to know how ugly it might be to route
> communications from different kernel drivers to different userspace
> daemons through the same generic netlink family. But if there's not
> much extra complexity in building a generic interface, it seems like
> it would be preferable to a multipath specific one.

It can be generic. The messages will contain the block device
major:minor as well as information to describe <linux/pr.h> requests.

Stefan

--xNf4TCGDHELYMfpk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmCOLUACgkQnKSrs4Gr
c8jt+wf+N0rZnbjqHNmErDNmxDBXptWbaLqVPS5pyqcTBX15ihL5zL9ocaLkEgXD
QFMjX8hrLx/AwWrHnMjyZXmyWWvgoZj3tadh/eW+cWVpOJIniBUM2+qIf5UQ/oFx
v/xFL9K9NFpcSxKNIpB30Tr+tvExQSWLfPp5E10V0v+7ziuEO5hoG1UOTHninNSP
0Sx8OVDcYQaAWOKvpxR2M7V8KdYwcqAbTEhzJThG0WJlp7MOA3MQaQM7w0N6k0Pg
/L9NQDs74eISlCehFotLwBk9JiWU3g9Ds8nI3jj5TR0A4GCLN/3Tuj69Kfz7Oy82
tVcPeaos/QyHE1v/fDur4K17JNol3g==
=eaGe
-----END PGP SIGNATURE-----

--xNf4TCGDHELYMfpk--


