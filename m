Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714A4EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhfh-0007UB-MA; Wed, 04 Feb 2026 13:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnhff-0007TE-WE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:32:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnhfd-0003Cx-GI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770229928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eHgjEq++QKxnVUH4c7Njw+76PaDzNVSUitYr9lRnKnI=;
 b=GsEo66E22TZzLCA22vjY49H5ChxuI5kis1e9j7h6ZXjRVQD4DKZDCf+DPob/wepp8dBAXL
 S0DOtCjUidlPtiIWGBsNYPINrqVCG8Na7hWFSjTWl+xSajobc+tFS08YP/6fzw71Z93lOC
 OAPk/90M8abDBEm3wJpvTZgzVspx2nM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-DzxXGJ4bOmaViYyhU9mDrQ-1; Wed,
 04 Feb 2026 13:32:04 -0500
X-MC-Unique: DzxXGJ4bOmaViYyhU9mDrQ-1
X-Mimecast-MFC-AGG-ID: DzxXGJ4bOmaViYyhU9mDrQ_1770229923
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 220C11956053; Wed,  4 Feb 2026 18:32:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.153])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2127830001BB; Wed,  4 Feb 2026 18:32:01 +0000 (UTC)
Date: Wed, 4 Feb 2026 13:32:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260204183201.GB610283@fedora>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jtSO5w/CS6eK19eI"
Content-Disposition: inline
In-Reply-To: <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
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


--jtSO5w/CS6eK19eI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> Hi Stefan,
>=20
> On Tue, 2026-02-03 at 13:04 -0500, Stefan Hajnoczi wrote:
> > On Tue, Feb 03, 2026 at 12:53:12PM -0500, Benjamin Marzinski wrote:
> > > On Tue, Feb 03, 2026 at 10:09:39AM -0500, Stefan Hajnoczi wrote:
> > > > On Tue, Jan 27, 2026 at 04:06:03PM -0500, Benjamin Marzinski
> > > > wrote:
> > > > > On Tue, Jan 27, 2026 at 01:47:43PM -0500, Stefan Hajnoczi
> > > > > wrote:
> > > > > > Hi Benjamin and Paolo,
> > > > > > I would like to discuss changes to DM-Multipath and qemu-pr-
> > > > > > helper to
> > > > > > handle SCSI Persistent Reservations in QEMU without
> > > > > > privileged code.
> > > > > >=20
> > > > > > SCSI Persistent Reservations support in QEMU is built on the
> > > > > > qemu-pr-helper daemon that performs PERSISTENT RESERVATION IN
> > > > > > and
> > > > > > PERSISTENT RESERVATION OUT commands on behalf of the guest.
> > > > > > The
> > > > > > qemu-pr-helper process provides privilege separation for
> > > > > > ioctl(SG_IO)'s
> > > > > > CAP_SYS_RAWIO and libmpathpersist's root privileges since the
> > > > > > main QEMU
> > > > > > process should not have those privileges.
> > > > > >=20
> > > > > > There are issues with the current approach:
> > > > > > - Privileged code is a security attack surface.
> > > > > > - A bunch of code is required for privilege separation and
> > > > > > for management
> > > > > > =A0 tools to set up qemu-pr-helper with access to multipathd.
> > > > > > - The interface is SCSI-specific and does not support NVMe.
> > > > > >=20
> > > > > > Several of us have pondered a different approach that I will
> > > > > > summarize
> > > > > > here. The <linux/pr.h> ioctl interface provides an
> > > > > > alternative to
> > > > > > ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It
> > > > > > supports both
> > > > > > SCSI and NVMe. Since privileges are not required, there would
> > > > > > be no need
> > > > > > for the qemu-pr-helper daemon anymore.
> > > > > >=20
> > > > > > The blocker is that <linux/pr.h> is not usable in multipath
> > > > > > environments. The Linux DM-Multipath driver has an incomplete
> > > > > > ioctl
> > > > > > implementation that falls short of what libmpathpersist and
> > > > > > multipathd
> > > > > > do in userspace. Kernel changes are necessary to fix this.
> > > > > >=20
> > > > > > My suggestion is to implement <linux/pr.h> via upcalls from
> > > > > > DM-Multipath
> > > > > > to multipathd. That way applications like QEMU can
> > > > > > consistently use
> > > > > > <linux/pr.h> across block device types and no longer have to
> > > > > > go through
> > > > > > the privileged libmpathpersist interface.
> > > > >=20
> > > > > This would take intercepting the pr commands to multipath
> > > > > devices right
> > > > > at the start of dm_call_pr(). In order to make some persistent
> > > > > reservation commands seem atomic, libmpathpersist needs to
> > > > > suspend the
> > > > > multipath device in certain situations. So device-mapper cannot
> > > > > call
> > > > > dm_get_live_table(), since this will block suspends. This
> > > > > should be o.k.
> > > > > Libmpathpersist is designed to handle the possiblity that the
> > > > > multipath
> > > > > device gets reloaded with different paths while it is running.
> > > > > And since
> > > > > the multipath target is an immutable singleton target, there is
> > > > > no
> > > > > possibility of it turning into another target type because of a
> > > > > table
> > > > > reload during suspend.
> > > > >=20
> > > > > Also, just to clarify, the kernel code can't interface directly
> > > > > with
> > > > > multipathd. Most of the code for handling persistent
> > > > > reservations is in
> > > > > libmpathpersist, which just needs multipathd to do things like
> > > > > make sure
> > > > > that paths that are added in the furture get registered
> > > > > properly. There
> > > > > would likely need to be some new program (that is just a thin
> > > > > wrapper
> > > > > around libmpathpersist) which can be called with
> > > > > call_usermodehelper().
> > >=20
> > > Adding Martin Wilck, since he will also be looking at these
> > > changes.
> > > =A0
> > > > Hi everyone,
> > > > I'm starting to work on the DM-Multipath changes. Some more
> > > > details on
> > > > how I am approaching this:
> > > >=20
> > > > - multipath-tools will create multipath device-mapper targets
> > > > with a new
> > > > =A0 ctr argument (pr_netlink) when this feature is enabled. When
> > > > the
> > > > =A0 feature is disabled, everything remains backwards compatible.
> > > > With the
> > > > =A0 pr_netlink ctr argument, the multipath target sends a netlink
> > > > =A0 multicast group notification instead of handling PR operations
> > > > (e.g.
> > > > =A0 IOC_PR_* ioctls) in the kernel.
> > > >=20
> > > > - There will be a new program in multipath-tools called
> > > > mpathpersistd
> > > > =A0 that listens on the netlink multicast group for notifications.
> > > > The
> > > > =A0 notification tells it which multipath device has a pending PR
> > > > =A0 operation. It fetches the PR operation parameters by sending a
> > > > netlink
> > > > =A0 message, performs the persistent reservation operation via
> > > > =A0 libmpathpersist, and then sends a response to the kernel via
> > > > another
> > > > =A0 netlink message.
> > > >=20
> > > > - The multipath device-mapper target completes the PR operation
> > > > upon
> > > > =A0 receiving the netlink response.
> > > >=20
> > > > I ended up choosing netlink because call_usermodehelper() seems
> > > > less
> > > > appropriate for an operation triggered by untrusted userspace
> > > > processes.
> > > >=20
> > > > Your input is welcome. Let me know if a different approach would
> > > > be
> > > > better.
> > >=20
> > > Is the netlink interface going to be a generic persistent
> > > reservation
> > > upcall interface, or it this just for dm multipath? I'm not sure if
> > > there would ever be another user, and I don't have enough
> > > experience
> > > with the netlink code to know how ugly it might be to route
> > > communications from different kernel drivers to different userspace
> > > daemons through the same generic netlink family. But if there's not
> > > much extra complexity in building a generic interface, it seems
> > > like
> > > it would be preferable to a multipath specific one.
> >=20
> > It can be generic. The messages will contain the block device
> > major:minor as well as information to describe <linux/pr.h> requests.
>=20
> So the ioctls will pass through qemu into the kernel, to be intercepted
> by the dm-mpath driver, which will use an upcall to have them handled
> by mpathpersistd (for the actual command) and multipathd (for the path
> registrations).
>=20
> I don't fully understand the advantage, security and complexity-wise,
> of this concept, compared to intercepting them qemu and using a socket
> to talk to mpathpersistd directly. If we did this, we could even
> support both generic and SCSI PR commands.

Hi Martin,
The simplification and security benefits are on the application side,
not on the DM-Multipath side, so I can see what you're getting at. From
the DM-Multipath perspective things get a little more complex.

=46rom an application perspective, a single API that works across block
device types (SCSI, NVMe, DM-Multipath) and requires no privileges or
sockets (they are a pain in container environments) is the most
convenient. The <linux/pr.h> ioctl API offers exactly this.

Unfortunately, DM-Multipath currently does not fully support
<linux/pr.h>. It sends PR operations down each path, but that is only a
subset of libmpathpersist's logic and multipathd is not kept in sync.

My impression is that libmpathpersist and multipathd logic cannot be
easily moved into the kernel. This is where the upcall idea comes from.
Let's notify multipath-tools from DM-Multipath so it can do its work in
userspace.

Getting back to the application vs DM-Multipath advantages: I think it's
worth simplifying things for applications because there are many
applications and only one DM-Multipath.

Thanks,
Stefan

--jtSO5w/CS6eK19eI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmDkKEACgkQnKSrs4Gr
c8i9lQgAud8oLItw8VnaaMVUuStKKBpzE+qOq9DtSBoCi1wo+w9n8pipHmPH9JsH
k1mYsYBM77GCapymsY0+Yu2V1YI+G0oMasFP2YJkmNhHgPILrDFWNyJRKNLDcgKz
pTWAatjhl93bGsUcMVjOC85N+WYmHzD5XB1V/mXW06GyqVCLAfvU1cVaduS0Hn4D
x8MANXtqr2nBWvd56mvSsackmHjhUoFJBYP7B56qTV8GQp9M8P2EUmXcNENpSFln
cq9n3UW2CUL/o9NQ25kwIC7NuSsjFJOHWfrTZdprXtMsyBTio/py1cMZofqvrAyo
M4UXLPIofyDgNeZSLRoVV9RQqNNW6g==
=Y+a0
-----END PGP SIGNATURE-----

--jtSO5w/CS6eK19eI--


