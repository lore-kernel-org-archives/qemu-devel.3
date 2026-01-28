Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DECDD46BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 19:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlBGH-0003Hx-FO; Wed, 28 Jan 2026 14:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vlBG9-0003GP-VB
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vlBG7-0003Jn-BB
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769628676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IvNiMEiXICHXlUvwTUyqZ8NffU8nSW5gnfz/Ck92Dgs=;
 b=K4QfXO1R4zPvqLJEwseU/j8Qp3SO00i4V0jMO1n2i7agMLs6AD/+40TN3kJB4Q8DA2cJps
 1ryi7Ca228A5572fNRUJ4memMmpCaZCbfnvC+msSZAZ5MHwP3aP/Lg0cN0+nyksUYegIXi
 5PgjYeHNslZOu4l2LyV29223y8W3Us0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-PMYeZeiINrm4TeaJxkbezQ-1; Wed,
 28 Jan 2026 14:31:13 -0500
X-MC-Unique: PMYeZeiINrm4TeaJxkbezQ-1
X-Mimecast-MFC-AGG-ID: PMYeZeiINrm4TeaJxkbezQ_1769628673
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A144E1800451; Wed, 28 Jan 2026 19:31:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18EA530002DA; Wed, 28 Jan 2026 19:31:11 +0000 (UTC)
Date: Wed, 28 Jan 2026 11:13:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Faria <afaria@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260128161304.GA120658@fedora>
References: <20260127184743.GA77765@fedora>
 <CABgObfZetG0O5oX+pHCAaPXwaPreWn2NSXuWpJUBdaqdL=a4-w@mail.gmail.com>
 <20260128141838.GA111862@fedora>
 <2fff54ca-00c4-4483-ac1d-2c47b0f8c683@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5B3kprZB4XP9I/M2"
Content-Disposition: inline
In-Reply-To: <2fff54ca-00c4-4483-ac1d-2c47b0f8c683@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--5B3kprZB4XP9I/M2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 04:30:51PM +0100, Hannes Reinecke wrote:
> On 1/28/26 15:18, Stefan Hajnoczi wrote:
> > On Tue, Jan 27, 2026 at 08:45:39PM +0100, Paolo Bonzini wrote:
> > > Il mar 27 gen 2026, 19:47 Stefan Hajnoczi <stefanha@redhat.com> ha sc=
ritto:
> > >=20
> > > > Several of us have pondered a different approach that I will summar=
ize
> > > > here. The <linux/pr.h> ioctl interface provides an alternative to
> > > > ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
> > > > SCSI and NVMe. Since privileges are not required, there would be no=
 need
> > > > for the qemu-pr-helper daemon anymore.
> > > >=20
> > >=20
> > > Yes, no problem with that. It's easy to extend QEMU with a new pr-man=
ager
> > > subclass that converts SCSI commands to PR ioctls.
> >=20
> > Yes. It will be possible to go further than that in the future:
> >=20
> > Alberto has been working on QEMU block layer API support for persistent
> > reservations. When that becomes available, SCSI command parsing can
> > happen entirely within hw/scsi/scsi-disk.c for scsi-block and scsi-disk.
> > file-posix.c will then implement the new BlockDriver PR APIs via
> > <linux/pr.h> ioctls and other block drivers can implement them in
> > protocol-specific ways (e.g. iSCSI).
> >=20
> > > My suggestion is to implement <linux/pr.h> via upcalls from DM-Multip=
ath
> > > > to multipathd. That way applications like QEMU can consistently use
> > > > <linux/pr.h> across block device types and no longer have to go thr=
ough
> > > > the privileged libmpathpersist interface.
> > > >=20
> > >=20
> > > What do you have in mind for the upcall protocol? Does it need to be =
done
> > > with multipathd or can it be a separate daemon for privilege separati=
on? I
> > > am not sure if there is any channel between dm-mpath and multipathd t=
hat
> > > can be extended (I think it only uses uevent?); maybe it would make s=
ense
> > > to reuse qemu-pr-helper's protocol even.
> >=20
> > I don't have a strong opinion on the protocol. My thought was to do a
> > traditional upcall with call_usermodehelper() with an execve argv/envp
> > protocol. That way there is no need to register a file descriptor. The
> > downside is that this approach is less efficient and more likely to fail
> > when the host is under memory pressure, but PR operations are not that
> > frequent.
> >=20
> gnaa. call_usermodehelper() is _evil_. It might be executed with any
> arbitrary fs context, and you better hope the executable is present
> there ...
>=20
> Maybe look at the handshake daemon. That's solving a very similar issue
> which we had for TLS.

Netlink is the most complex approach. I had a hard to understanding what
was going from looking at drivers/nvme/host/ and net/handshake/. But if
netlink is the way to do this, I'm sure it can be done.

Stefan

--5B3kprZB4XP9I/M2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml6NZAACgkQnKSrs4Gr
c8iJzgf5Ab88QDLKfqZKS2Te7aG5U7CzMbfWqKXzlDtBQjv/AfautAWG38moaQBk
s1PI4yQ1Cm2Z7O6oMvjoibW4PT0Vh3yynL9A2BdZK5kW+n9fnFNGAYnZB0dNIWoC
tcwdEQwBYOoS2mK61MgtNMgfpufpSy+Lfe3E8L7x/SR312ecPfGq7pSbsFJRbjKY
47zZRxFJCjTof+rU+623Eeo/nOt5YwQKqagF5PXKLR5a4mu9nXLXTvI3tBzh1DcR
65rRBxlFBikApg2p/K8pvBepkwHhbQ1u7mB6IV0SFtCrbPpiQu2VGWsQldpOgXgh
0X9I2TQjwSjQic+dm7OrXRXXssuWPg==
=X5FA
-----END PGP SIGNATURE-----

--5B3kprZB4XP9I/M2--


