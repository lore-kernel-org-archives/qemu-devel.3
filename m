Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B818EE20A4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMVQ-0006P1-Gf; Fri, 06 Feb 2026 09:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1voMVO-0006OK-E1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1voMVM-0007kG-RN
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770386896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V3wU6n7LMTpO24f5Ls6eQdoBAEA/Afh6h5yev+pQ/qA=;
 b=SJY4F+vRjhaQ1uUQQ7O3dV7WjuDIv/uZIEvkrxEoCiMuyFFkJx4pysi0A1s+wTYPr+nXNj
 zsfOZaj1WW7npBYRjcwH9unXw/LP5vIHfvOvXzzK4OgvM09chlWV7JecqAygQdxujNR9l1
 9r/Xq8NmF6HboNfbxlRAhBQ7nHX8xHk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-TW0EHZzmMZSxwNmL7ox8ng-1; Fri,
 06 Feb 2026 09:08:13 -0500
X-MC-Unique: TW0EHZzmMZSxwNmL7ox8ng-1
X-Mimecast-MFC-AGG-ID: TW0EHZzmMZSxwNmL7ox8ng_1770386892
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B38DA1955E78; Fri,  6 Feb 2026 14:08:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 135CD3000707; Fri,  6 Feb 2026 14:08:10 +0000 (UTC)
Date: Fri, 6 Feb 2026 09:08:09 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com,
 qemu-devel@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260206140809.GA68769@fedora>
References: <aXkou8f97EvxK2K8@redhat.com> <20260203150939.GB445116@fedora>
 <aYI2CAjmHGklh3mi@redhat.com> <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com> <20260205133930.GA36872@fedora>
 <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VFgerjUu3R9VO3AM"
Content-Disposition: inline
In-Reply-To: <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--VFgerjUu3R9VO3AM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 01:03:18AM +0100, Hannes Reinecke wrote:
> On 2/5/26 14:39, Stefan Hajnoczi wrote:
> > On Thu, Feb 05, 2026 at 12:01:13PM +0000, Daniel P. Berrang=E9 wrote:
> > > On Thu, Feb 05, 2026 at 12:52:33PM +0100, Martin Wilck wrote:
> > > > On Wed, 2026-02-04 at 13:32 -0500, Stefan Hajnoczi wrote:
> > > > > On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> > > > > > Hi Stefan,
> > > > > >=20
> > > > > > So the ioctls will pass through qemu into the kernel, to be
> > > > > > intercepted
> > > > > > by the dm-mpath driver, which will use an upcall to have them
> > > > > > handled
> > > > > > by mpathpersistd (for the actual command) and multipathd (for t=
he
> > > > > > path
> > > > > > registrations).
> > > > > >=20
> > > > > > I don't fully understand the advantage, security and complexity-
> > > > > > wise,
> > > > > > of this concept, compared to intercepting them qemu and using a
> > > > > > socket
> > > > > > to talk to mpathpersistd directly. If we did this, we could even
> > > > > > support both generic and SCSI PR commands.
> > > > >=20
> > > > > Hi Martin,
> > > > > The simplification and security benefits are on the application s=
ide,
> > > > > not on the DM-Multipath side, so I can see what you're getting at.
> > > > > From
> > > > > the DM-Multipath perspective things get a little more complex.
> > > > >=20
> > > > >  From an application perspective, a single API that works across =
block
> > > > > device types (SCSI, NVMe, DM-Multipath) and requires no privilege=
s or
> > > > > sockets (they are a pain in container environments) is the most
> > > > > convenient. The <linux/pr.h> ioctl API offers exactly this.
> > > >=20
> > > > I may be missing something, but AFAICS the PR ioctls require having=
 a
> > > > block device open for writing, which does either require root
> > > > privileges, or some file descriptor previously opened with privileg=
es
> > > > and forwarded to another, less privileged process. No?
> > >=20
> > > While QEMU is run unprivileged, libvirt will grant QEMU access any bl=
ock
> > > devices that have been configured for the guest in question. On Linux,
> > > libvirt will create a new /dev tmpfs populated with the allow-list of
> > > device nodes the guest is permitted to access, with suitable file
> > > permissions, ownership & SELinux labels set.
> >=20
> > Ultimately something does require privileges to give an unprivileged
> > application access to a block device. That could be udev rules, it could
> > be libvirt, etc.
> >=20
> > I would say the real distinction is between the privileges needed so the
> > application can access the block device vs the privileges needed to
> > perform PR operations. If udev or libvirt has set up block device nodes,
> > an unprivileged application can open them for read/write access. But it
> > would require CAP_SYS_RAWIO for SG_IO PR operations on top of that
> > whereas <linux/pr.h> ioctls do not require that.
> >=20
> That would make sense, but unfortunately READ KEYS (and READ
> RESERVATIONS) requires the same privileges than the other
> blkpr functions. Might be an idea to change that, though.

Making sure I understand:

blkdev_pr_read_keys() and blkdev_pr_read_reservation() in Linux
block/ioctl.c should be adjusted to allow not just BLK_OPEN_WRITE but
also BLK_OPEN_READ?

I think it's okay from a security perspective: if the application can
already read the entire disk, then it's okay for it to read the keys and
reservation information. But I'm not 100% sure...

In any case, I think this idea is orthogonal to the discussion about
DM-Multipath <linux/pr.h> support. In terms of permission requirements,
<linux/pr.h> already requires fewer permissions (just opening the block
device for write) today than libmpathpersist or ioctl(SG_IO). Or do you
see a scenario where the application wants to open the block device as
root (or CAP_SYS_RAWIO) but read-only, so requiring opening the device
with write permissions is a blocker?

Stefan

--VFgerjUu3R9VO3AM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmF9ckACgkQnKSrs4Gr
c8gAvwf/VlITUdXCCzANSSkfKMH/BxwUJO+KBYspWyGiB7HyD23Gowq6Ce3o9P0F
Okm8R95eExQPBuBMeyAxlDFC8DpD2d4CUpZv87O4UAo0l77OKjn2mfoSkpHRuPjn
wS2CDaeQuCru9WovtLxhJIputK2ENsQUBhpwVNvmYD7gCtZCV5OsQqSe7DxYWkyw
BATUPswGBNrHkcW0pZLZRco95m4+BedjmekWfnNz6HYUraS58OGSQOrrjuOsPZVP
jfiSbHXIrgndov/idO9miKQPjwOvrLu/sl905+AjA+bOCFPAz+cWLBNKXew7iq4j
PZGKoyxrm3n7pnP79n7SxmUzlagVrw==
=TyOQ
-----END PGP SIGNATURE-----

--VFgerjUu3R9VO3AM--


