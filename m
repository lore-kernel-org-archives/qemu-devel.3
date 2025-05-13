Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCC8C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEq3E-0001Hr-9F; Tue, 13 May 2025 09:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEq37-0001Gw-LW
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEq32-0001kr-1F
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747144313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u71QUGF+wv5hJ6F1s1Mid1pdlzn9vihyorwuiVBmgvc=;
 b=gUVsNlMQwlwAB7yQe+wqeO75iOnGvv13IckSSOJWH2iJ59zTgSQ4ioFVpGVD7A77/gnHBF
 LOsUWF32MwdbDGC0ZMGfne3oRNXh9+7nvj0AeP96w3/0AyyUvBedgkgSH74Gr5p8ZyxyOg
 53LkjwKamOY427inlKknKo80By+0Wb0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-6sudEH2DNraB5TuMurKFdQ-1; Tue,
 13 May 2025 09:51:52 -0400
X-MC-Unique: 6sudEH2DNraB5TuMurKFdQ-1
X-Mimecast-MFC-AGG-ID: 6sudEH2DNraB5TuMurKFdQ_1747144311
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07B6E180087F; Tue, 13 May 2025 13:51:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.166])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A8661955E74; Tue, 13 May 2025 13:51:49 +0000 (UTC)
Date: Tue, 13 May 2025 09:51:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 bmarzins@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <20250513135148.GB227327@fedora>
References: <20250513113730.37404-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tb0TCTHDk9mdm4rt"
Content-Disposition: inline
In-Reply-To: <20250513113730.37404-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Tb0TCTHDk9mdm4rt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 01:37:30PM +0200, Kevin Wolf wrote:
> When scsi-block is used on a host multipath device, it runs into the
> problem that the kernel dm-mpath doesn't know anything about SCSI or
> SG_IO and therefore can't decide if a SG_IO request returned an error
> and needs to be retried on a different path. Instead of getting working
> failover, an error is returned to scsi-block and handled according to
> the configured error policy. Obviously, this is not what users want,
> they want working failover.
>=20
> QEMU can parse the SG_IO result and determine whether this could have
> been a path error, but just retrying the same request could just send it
> to the same failing path again and result in the same error.
>=20
> With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> block devices (queued in the device mapper tree for Linux 6.16), we can
> tell the kernel to probe all paths and tell us if any usable paths
> remained. If so, we can now retry the SG_IO ioctl and expect it to be
> sent to a working path.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 82 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)

Maybe the probability of retry success would be higher with a delay so
that intermittent issues have time to resolve themselves. Either way,
the patch looks good.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Tb0TCTHDk9mdm4rt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgjTnQACgkQnKSrs4Gr
c8gLcwgAspZ6tFEEB/fdfpGq32m61kemzNqjOSGk0SgFDeCn1yIrctb+fNCxmJW6
r9PqyXaEr3rY9jwxYOnQ5t6Pera4u/se7mX4M1Pfr4aqjDMf//NhfN+oW9tn1hhz
EtDUsPP1pa2PaCc0hwlZJRSzD7Tf2dIUZCx6Gi3EdLYDUk4wlcWeexB8XTtv9PH6
jR3DzkPzYNxF8uJ+0UE4ONHGqZjBFToy+qeFR5d8lmpZ38sQbZEK5mrBBrOzTqWL
bjvrT1D9IfiXlDgsmufo3hC0MfSDm7qJqcJEmWWQXw6Kvov8BTpEqMK6/7y6sNJ/
t6KhuBn9Ih8yi4PbszKRmV8DekoGIw==
=nMDJ
-----END PGP SIGNATURE-----

--Tb0TCTHDk9mdm4rt--


