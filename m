Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE580E81BCD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSAX-00023B-KJ; Mon, 09 Feb 2026 09:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSAV-00022n-C0
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:23:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSAT-00013q-T4
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770646991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZVXOyGDYlLfAH9XxPHfY7t5BGkargz022pEMNWeRliM=;
 b=fc+HII97gDkssPjOnrQ7Ol4wxVt72AUfO5m2G47WOyvnUycDgNPmvG1Cr6KZW3F5lYgdzm
 /wUrNoLn4p56x2Qsc6LYmKQT87vNTot7tGWr7V5K/sBdXgQBG3siCoshPZOqNlwqrfpXnk
 ija9R945cTiJ+hdIwsNq/TyltW8mQMM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-PNvDm_1qOVSkYyXPaEj7tw-1; Mon,
 09 Feb 2026 09:23:09 -0500
X-MC-Unique: PNvDm_1qOVSkYyXPaEj7tw-1
X-Mimecast-MFC-AGG-ID: PNvDm_1qOVSkYyXPaEj7tw_1770646988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A1F18003F6; Mon,  9 Feb 2026 14:23:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4E6D18003F6; Mon,  9 Feb 2026 14:23:07 +0000 (UTC)
Date: Mon, 9 Feb 2026 09:23:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com,
 qemu-devel@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
Message-ID: <20260209142306.GA24854@fedora>
References: <aYI2CAjmHGklh3mi@redhat.com> <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com> <20260205133930.GA36872@fedora>
 <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
 <20260206140809.GA68769@fedora>
 <ba99c16a-f621-49a7-bab4-c262a4f2a2e8@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/1uwn2vVgaXHMJDg"
Content-Disposition: inline
In-Reply-To: <ba99c16a-f621-49a7-bab4-c262a4f2a2e8@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--/1uwn2vVgaXHMJDg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 01:50:00PM +0100, Hannes Reinecke wrote:
> On 2/6/26 15:08, Stefan Hajnoczi wrote:
> > On Fri, Feb 06, 2026 at 01:03:18AM +0100, Hannes Reinecke wrote:
> > > On 2/5/26 14:39, Stefan Hajnoczi wrote:
> [ .. ]
> > > That would make sense, but unfortunately READ KEYS (and READ
> > > RESERVATIONS) requires the same privileges than the other
> > > blkpr functions. Might be an idea to change that, though.
> >=20
> > Making sure I understand:
> >=20
> > blkdev_pr_read_keys() and blkdev_pr_read_reservation() in Linux
> > block/ioctl.c should be adjusted to allow not just BLK_OPEN_WRITE but
> > also BLK_OPEN_READ?
> >=20
> Yes.
>=20
> > I think it's okay from a security perspective: if the application can
> > already read the entire disk, then it's okay for it to read the keys and
> > reservation information. But I'm not 100% sure...
> >=20
> > In any case, I think this idea is orthogonal to the discussion about
> > DM-Multipath <linux/pr.h> support. In terms of permission requirements,
> > <linux/pr.h> already requires fewer permissions (just opening the block
> > device for write) today than libmpathpersist or ioctl(SG_IO). Or do you
> > see a scenario where the application wants to open the block device as
> > root (or CAP_SYS_RAWIO) but read-only, so requiring opening the device
> > with write permissions is a blocker?
> >=20
>=20
> My concern with opening the block device with BLK_OPEN_WRITE is that
> this will trigger udev to 'synthesize' (ie regenerate) an 'add' event
> on close, causing 'interesting' effects as this will cascade down
> through the udev rule chain, triggering blkid, partition scan, you
> name it.
> Horrible, horrible, horrible.
> Don't do it.
>=20
> Especially not as you are only interested in reading information,
> and not changing the disk state in any way.

I see. I will send patches to change blkdev_pr_read_keys()
blkdev_pr_read_reservation() to require only BLK_OPEN_READ.

Stefan

--/1uwn2vVgaXHMJDg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmJ7coACgkQnKSrs4Gr
c8jAhAgAl9PpFsp1HIWLzy1oRGn649+hzUsR3FX7r+qIvcGsF52P3xngROoQR5tg
ZERZ1qkcphbazuBtRAHLzUT5m3JG0hTp39nUXnHidDMxTimjcN4DfUwKLGbPquBN
bZ+TmiCKLWnfoKQPdZKqMb/R/6hQDH9iW3mJSJKhFpLjWliH8/Zj/uiwYMJEdOOW
zYO43FKzd1fa0wNaFUs4NGK34HamYcxUtmabN3DnxpPFwmF/rTAmTZ8ZtzCAfhck
Gv3a76i22SSd14o7hb6VCIYduCrF78ujTd8UEoffA5kCA+EPcMScrJAKnKrDcU+T
3UGvtZCIIs+tzhRCJ+e0Fv4v8vPovg==
=A3NV
-----END PGP SIGNATURE-----

--/1uwn2vVgaXHMJDg--


