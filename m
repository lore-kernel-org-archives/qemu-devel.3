Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5647D3F06B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6Nd-0007pU-5g; Wed, 28 Jan 2026 09:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vl6Nb-0007lj-H5
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:18:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vl6NZ-0004w2-IN
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769609922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hm0cldDHHO315mgzohU4gtWXUgugma58f3QVzbUDmAs=;
 b=MjsPNvWKrhTQrns6aqk8aDrHdbc8n0UvLfmWD5G4u3jiUEpnE4cG6frx2QHFWsmrk5NcrS
 B8X/AGQUJjhjlL1xaYj15AOOjP3lRTlcBrTWXEFDrnA6PK9+9pgd/PGUHhdnPHSFWIPKAr
 z8o1jQ9qLhdhPbTWUtYnQoToQ1kIsaE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-KxJno1spOg-DxBz1t0Rd5g-1; Wed,
 28 Jan 2026 09:18:40 -0500
X-MC-Unique: KxJno1spOg-DxBz1t0Rd5g-1
X-Mimecast-MFC-AGG-ID: KxJno1spOg-DxBz1t0Rd5g_1769609920
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEE3E19373F1; Wed, 28 Jan 2026 14:18:39 +0000 (UTC)
Received: from localhost (unknown [10.22.80.221])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3913118002A6; Wed, 28 Jan 2026 14:18:39 +0000 (UTC)
Date: Wed, 28 Jan 2026 09:18:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alberto Faria <afaria@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260128141838.GA111862@fedora>
References: <20260127184743.GA77765@fedora>
 <CABgObfZetG0O5oX+pHCAaPXwaPreWn2NSXuWpJUBdaqdL=a4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SpkJ/LheUkQ/VHPP"
Content-Disposition: inline
In-Reply-To: <CABgObfZetG0O5oX+pHCAaPXwaPreWn2NSXuWpJUBdaqdL=a4-w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--SpkJ/LheUkQ/VHPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 08:45:39PM +0100, Paolo Bonzini wrote:
> Il mar 27 gen 2026, 19:47 Stefan Hajnoczi <stefanha@redhat.com> ha scritt=
o:
>=20
> > Several of us have pondered a different approach that I will summarize
> > here. The <linux/pr.h> ioctl interface provides an alternative to
> > ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
> > SCSI and NVMe. Since privileges are not required, there would be no need
> > for the qemu-pr-helper daemon anymore.
> >
>=20
> Yes, no problem with that. It's easy to extend QEMU with a new pr-manager
> subclass that converts SCSI commands to PR ioctls.

Yes. It will be possible to go further than that in the future:

Alberto has been working on QEMU block layer API support for persistent
reservations. When that becomes available, SCSI command parsing can
happen entirely within hw/scsi/scsi-disk.c for scsi-block and scsi-disk.
file-posix.c will then implement the new BlockDriver PR APIs via
<linux/pr.h> ioctls and other block drivers can implement them in
protocol-specific ways (e.g. iSCSI).

> My suggestion is to implement <linux/pr.h> via upcalls from DM-Multipath
> > to multipathd. That way applications like QEMU can consistently use
> > <linux/pr.h> across block device types and no longer have to go through
> > the privileged libmpathpersist interface.
> >
>=20
> What do you have in mind for the upcall protocol? Does it need to be done
> with multipathd or can it be a separate daemon for privilege separation? I
> am not sure if there is any channel between dm-mpath and multipathd that
> can be extended (I think it only uses uevent?); maybe it would make sense
> to reuse qemu-pr-helper's protocol even.

I don't have a strong opinion on the protocol. My thought was to do a
traditional upcall with call_usermodehelper() with an execve argv/envp
protocol. That way there is no need to register a file descriptor. The
downside is that this approach is less efficient and more likely to fail
when the host is under memory pressure, but PR operations are not that
frequent.

Stefan

--SpkJ/LheUkQ/VHPP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml6Gr4ACgkQnKSrs4Gr
c8gO9QgAu5Aaqxo8P/FyjL7uPtKCZSvUTivGpfQE449dZtmkW1FZJR0O2NGLr6NH
A67JUJpsjYOY78JN1BzpYqYjl4MLXrU7U2Dl2mmUkf1ul1OBBaawVMnoC1Qdfb3a
pb5XINS5D6HW40azrNLmmfIJa2Fh/h5UiiOFeJ5SXl3Ft+cWZhknQRXFhL7rnzFX
U4RYVYxkHZeH3qgZpn2LjPGuVPtO5Wcmb6oainTBZqdISq8azUFuvS5Ikqyejo0x
DnR+DxKhdw/A6JLWBkNK08vEUmcIuWUght/D5vOtsuauY4ERHulZI0aIgjdWCyIB
0H6nsbPNy8bK5A7sAKj+eTySztuW+w==
=ToLe
-----END PGP SIGNATURE-----

--SpkJ/LheUkQ/VHPP--


