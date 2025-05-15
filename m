Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A47AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTlX-0007bH-9f; Thu, 15 May 2025 04:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFTl8-0006k3-OY
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFTl5-00022q-Oe
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747296961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QxJJqD6Nk2boVin/GG2QwQ8ZJ4QNjDOOMbg+NaNF+9Q=;
 b=LeiTzMEvnpfF0WzQlrzShoZMhGqjmYrQQUrxUS946hoh/Rdr0TKiHpHAy0h7t7MqmWeF95
 spQlXnVASUwC4Rw2NSlJ3feFBJfggDz49DV9KRRTk975NHCK1dbN/e+/boVTajODGjeOad
 tmA0CJ9uccHXcwD9rhmoh4slMkbsB5Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-dWhR9TMPMSCLtN4qQiZMBw-1; Thu,
 15 May 2025 04:15:59 -0400
X-MC-Unique: dWhR9TMPMSCLtN4qQiZMBw-1
X-Mimecast-MFC-AGG-ID: dWhR9TMPMSCLtN4qQiZMBw_1747296958
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1F5E180048E; Thu, 15 May 2025 08:15:58 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.242])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 541CF30075D4; Thu, 15 May 2025 08:15:55 +0000 (UTC)
Date: Thu, 15 May 2025 10:15:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 bmarzins@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <aCWiuYUWiwKJz4_j@redhat.com>
References: <20250513113730.37404-1-kwolf@redhat.com>
 <20250513135148.GB227327@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r4OBl1l6r6mSxIWy"
Content-Disposition: inline
In-Reply-To: <20250513135148.GB227327@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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


--r4OBl1l6r6mSxIWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.05.2025 um 15:51 hat Stefan Hajnoczi geschrieben:
> On Tue, May 13, 2025 at 01:37:30PM +0200, Kevin Wolf wrote:
> > When scsi-block is used on a host multipath device, it runs into the
> > problem that the kernel dm-mpath doesn't know anything about SCSI or
> > SG_IO and therefore can't decide if a SG_IO request returned an error
> > and needs to be retried on a different path. Instead of getting working
> > failover, an error is returned to scsi-block and handled according to
> > the configured error policy. Obviously, this is not what users want,
> > they want working failover.
> >=20
> > QEMU can parse the SG_IO result and determine whether this could have
> > been a path error, but just retrying the same request could just send it
> > to the same failing path again and result in the same error.
> >=20
> > With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> > block devices (queued in the device mapper tree for Linux 6.16), we can
> > tell the kernel to probe all paths and tell us if any usable paths
> > remained. If so, we can now retry the SG_IO ioctl and expect it to be
> > sent to a working path.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/file-posix.c | 82 +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 81 insertions(+), 1 deletion(-)
>=20
> Maybe the probability of retry success would be higher with a delay so
> that intermittent issues have time to resolve themselves. Either way,
> the patch looks good.

I don't think adding a delay here would be helpful. The point of
multipath isn't that you wait until a bad path comes back, but that you
just switch to a different path until it is restored.

Ideally, calling DM_MPATH_PROBE_PATHS would just remove all the bad
paths instantaneously and we would either be able to send the request
using one of the remaining good paths, or know that we have to fail. In
practice, the ioctl will probably have to wait for a timeout, so you get
a delay anyway.

What could potentially be useful is a new error policy [rw]error=3Dretry
with a configurable delay. This wouldn't be in file-posix, but in the
devices after file-posix came to the conclusion that there is currently
no usable path. On the other hand, retrying indefinitely is probably not
what you want either, so that could quickly become rather complex.

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks.

Kevin

--r4OBl1l6r6mSxIWy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmglorkACgkQfwmycsiP
L9Y/dg/+MUWCXGjyeNPMiiXIIYlRVMglzuZMdUMsY1GKbLfjgcY2u9mGyKt8XViV
hMQONWqiMuzsaOGS6+mOewSJ5KJrIGsmZE/rU9sNLm2gygf1Mw1vb9NOdDOxdEso
C1H1qzFx2MGQSatGmR30PNjiwOWKdSYphxFl4AqsbIDzprhpsLl5doF9eeCXft5b
WBkGFYkwZLgs6z4KYVsGXo8W7aPof9MwChM3cRJRt9m0uU4vDeiHZWQQfxxdyNFm
A0dca+A70okSBfxxYPUJl/hZSiS85EyQN3UcbteFtSOHMl3LnKcTB2eCY4PDOD9G
sRE647GjDnV2wPEjXh3/I2Ti4yi1KxV97WIdnVSHN0a1C177RIS+lG+Hcbn4DyBn
Uq5b5L/cFVXlGDeY+BKbt7eDGeCcVNBSCKrXg5MPWNzWJxyddXO0RS2JjMMFGKr6
XLp0F6PLCCjtgFRHxubi3rQc8oZekpg04SMwnVc2Iuc1/Z7QJln1TZMnqDJjSz/H
ELzQlKNHIi4pPjmy1krvAg+yq8IvIKCb5Vpyomz312ZVwadTzS6w5mLO9WqkB0ro
Ykr6nHxINIiqmhMOGaWBhmxS6QMSuY+FlbtQ+lBmONlg0T4H7f0Z0MbBjtDbl3da
LbFzjBmelqGRyEMzM5DbeK0N7akwJN5wMFgcwnVxbLvgkKqzwQ8=
=qkj6
-----END PGP SIGNATURE-----

--r4OBl1l6r6mSxIWy--


