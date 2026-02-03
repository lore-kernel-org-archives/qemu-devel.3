Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF52E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI2I-0003uV-4H; Tue, 03 Feb 2026 10:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnI2G-0003ts-Cb
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:09:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnI2E-000360-HP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770131384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nx+LawhTEcmbqQbKHD9rrKlj9ScD8w47RthvmH+nvAE=;
 b=D+L1JT4166jl41NZkrd79W2k5fyzpaOUZK0YOlwcmZaMdSYlIyLzZ91OEr2i+gQ4ES+D44
 eou55UN9mYeIbZo08/CN33h3Vufr+XYDLI6LZiO8GiKimlgZPv2Yf9BPOKfyx3ZLa3Obzu
 r9jC345xXk1KlnAWgaGb8pedsZDSvHM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-6dyw5K35Oey3TOnrlyA6oA-1; Tue,
 03 Feb 2026 10:09:42 -0500
X-MC-Unique: 6dyw5K35Oey3TOnrlyA6oA-1
X-Mimecast-MFC-AGG-ID: 6dyw5K35Oey3TOnrlyA6oA_1770131382
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8343D180060F; Tue,  3 Feb 2026 15:09:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B20B21800109; Tue,  3 Feb 2026 15:09:40 +0000 (UTC)
Date: Tue, 3 Feb 2026 10:09:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260203150939.GB445116@fedora>
References: <20260127184743.GA77765@fedora>
 <aXkou8f97EvxK2K8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8pQN5XioLymWQyER"
Content-Disposition: inline
In-Reply-To: <aXkou8f97EvxK2K8@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--8pQN5XioLymWQyER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 04:06:03PM -0500, Benjamin Marzinski wrote:
> On Tue, Jan 27, 2026 at 01:47:43PM -0500, Stefan Hajnoczi wrote:
> > Hi Benjamin and Paolo,
> > I would like to discuss changes to DM-Multipath and qemu-pr-helper to
> > handle SCSI Persistent Reservations in QEMU without privileged code.
> >=20
> > SCSI Persistent Reservations support in QEMU is built on the
> > qemu-pr-helper daemon that performs PERSISTENT RESERVATION IN and
> > PERSISTENT RESERVATION OUT commands on behalf of the guest. The
> > qemu-pr-helper process provides privilege separation for ioctl(SG_IO)'s
> > CAP_SYS_RAWIO and libmpathpersist's root privileges since the main QEMU
> > process should not have those privileges.
> >=20
> > There are issues with the current approach:
> > - Privileged code is a security attack surface.
> > - A bunch of code is required for privilege separation and for manageme=
nt
> >   tools to set up qemu-pr-helper with access to multipathd.
> > - The interface is SCSI-specific and does not support NVMe.
> >=20
> > Several of us have pondered a different approach that I will summarize
> > here. The <linux/pr.h> ioctl interface provides an alternative to
> > ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
> > SCSI and NVMe. Since privileges are not required, there would be no need
> > for the qemu-pr-helper daemon anymore.
> >=20
> > The blocker is that <linux/pr.h> is not usable in multipath
> > environments. The Linux DM-Multipath driver has an incomplete ioctl
> > implementation that falls short of what libmpathpersist and multipathd
> > do in userspace. Kernel changes are necessary to fix this.
> >=20
> > My suggestion is to implement <linux/pr.h> via upcalls from DM-Multipath
> > to multipathd. That way applications like QEMU can consistently use
> > <linux/pr.h> across block device types and no longer have to go through
> > the privileged libmpathpersist interface.
>=20
> This would take intercepting the pr commands to multipath devices right
> at the start of dm_call_pr(). In order to make some persistent
> reservation commands seem atomic, libmpathpersist needs to suspend the
> multipath device in certain situations. So device-mapper cannot call
> dm_get_live_table(), since this will block suspends. This should be o.k.
> Libmpathpersist is designed to handle the possiblity that the multipath
> device gets reloaded with different paths while it is running. And since
> the multipath target is an immutable singleton target, there is no
> possibility of it turning into another target type because of a table
> reload during suspend.
>=20
> Also, just to clarify, the kernel code can't interface directly with
> multipathd. Most of the code for handling persistent reservations is in
> libmpathpersist, which just needs multipathd to do things like make sure
> that paths that are added in the furture get registered properly. There
> would likely need to be some new program (that is just a thin wrapper
> around libmpathpersist) which can be called with call_usermodehelper().

Hi everyone,
I'm starting to work on the DM-Multipath changes. Some more details on
how I am approaching this:

- multipath-tools will create multipath device-mapper targets with a new
  ctr argument (pr_netlink) when this feature is enabled. When the
  feature is disabled, everything remains backwards compatible. With the
  pr_netlink ctr argument, the multipath target sends a netlink
  multicast group notification instead of handling PR operations (e.g.
  IOC_PR_* ioctls) in the kernel.

- There will be a new program in multipath-tools called mpathpersistd
  that listens on the netlink multicast group for notifications. The
  notification tells it which multipath device has a pending PR
  operation. It fetches the PR operation parameters by sending a netlink
  message, performs the persistent reservation operation via
  libmpathpersist, and then sends a response to the kernel via another
  netlink message.

- The multipath device-mapper target completes the PR operation upon
  receiving the netlink response.

I ended up choosing netlink because call_usermodehelper() seems less
appropriate for an operation triggered by untrusted userspace processes.

Your input is welcome. Let me know if a different approach would be
better.

Thanks,
Stefan

--8pQN5XioLymWQyER
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmCD7MACgkQnKSrs4Gr
c8gwxwgAqU+Qh1uc2FizYWmVruSoVMdy/m8H318kZbgxiwj+wG/yR891z6BO8U1v
hu48Hta1BEKhbRk7EZQGCMijgOPMwVip8HEkjiEoJkf/CPNFFeSSe2OdGJ0dGvbX
46YiGgwZebtO5e4/Cx1IJl813UwPIyvsuzMWMUtLjVjfc5vkajalO5Ew4oQQqh4E
7jERKutYGXWwDqlg8OxAsUS/ihI1BNh7v4PHOBo++TEaJvx9+JYPhx4x750wWAhR
du+B1NdAbvGfk5UNYy4j8z/UoJK4wBwnio1WppVMXKfs3Me6li9zZ9YIikQx+oem
nQBPnBu7EAUPWAKL2ZyL3E6lk2EaTQ==
=6obN
-----END PGP SIGNATURE-----

--8pQN5XioLymWQyER--


