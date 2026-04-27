Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26DAFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRQB-0003XN-0d; Mon, 27 Apr 2026 15:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHRQ7-0003V1-45
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHRQ5-0007w8-Hi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777317297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GzCoUmQfwF52lVUNcbTkL98hAKKr5E5vwutLOWos/k=;
 b=ckxJcmG0rji+BTf6GnFCcx/XKZQCjbQ5AeQfoLhIHTczrbLxRFQQwU54PJQe9FpSUdcWg8
 ypKusZ0vCwk4jM0w1ORuVeBuCo+ICmXEnOW3QarzjrXoxmMIw5M98oDQVQLNoR9jEt05Vj
 BsVL2wfS9eKcpaE80xtqn1LkXmc89ng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-G5mjfjjbPZKijTKHIaeirw-1; Mon,
 27 Apr 2026 15:14:52 -0400
X-MC-Unique: G5mjfjjbPZKijTKHIaeirw-1
X-Mimecast-MFC-AGG-ID: G5mjfjjbPZKijTKHIaeirw_1777317292
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEF7019560AE; Mon, 27 Apr 2026 19:14:51 +0000 (UTC)
Received: from localhost (unknown [10.44.34.59])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEB8C196B8FB; Mon, 27 Apr 2026 19:14:50 +0000 (UTC)
Date: Mon, 27 Apr 2026 15:14:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] scsi: handle reservation changes across migration
Message-ID: <20260427191445.GE218226@fedora>
References: <20260415232906.212349-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2zA7mnbRb6Q0M9sF"
Content-Disposition: inline
In-Reply-To: <20260415232906.212349-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--2zA7mnbRb6Q0M9sF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 07:29:04PM -0400, Stefan Hajnoczi wrote:
> The SCSI Persistent Reservation code can fail if another node has interfe=
red
> with the reservation (e.g. by sending a PERSISTENT RESERVE OUT command wi=
th a
> PREEMPT or CLEAR service action). This is rare but can happen if the
> application or clustering framework performs recovery and wants to take a=
way
> the guest's reservation.
>=20
> This patch series adds an extra step when loading device state that
> synchronizes the transferred vmstate against the actual reservation state=
 of
> the disk before moving the reservation. This way we can gracefully handle
> changes to reservations that were performed externally.
>=20
> Stefan Hajnoczi (2):
>   scsi: change buf_size to unsigned int in scsi_SG_IO()
>   scsi: handle reservation changes across migration
>=20
>  include/hw/scsi/scsi.h |   3 +-
>  hw/scsi/scsi-generic.c | 175 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 152 insertions(+), 26 deletions(-)

Ping.

Stefan

--2zA7mnbRb6Q0M9sF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnvtaUACgkQnKSrs4Gr
c8gSjAf/ei7HFlvBC0K8THyt87PKKIvobHB9L8kFyzFTb54Up0DqPJ0Kvmte0dS4
NGWeFH/dcpqPptP/LMNG0dxda7hv7eOVG12JzWCrBYvjaqFTT5T77dUWhSUa312G
LkbG1FJss49DfbJjxiGHmvG+b7gYhw2zcPSjiWvspMWlYOkevVyAS21YQdqMQUu0
M7h+zifSVxxfikC9h+LC/Ryito/yffeuBhZdZXOCL++uy6dsWXpQbEs8jFTjf1v9
A+MLO4IjnIdSMxhp+6XW7J4PUP/tBfhI9FU2aeYTwae4GK1t1BO58Mv6eOV9M08n
crna8yO5/Xc0/UAxCIIVnTy5sCaF2Q==
=NW1B
-----END PGP SIGNATURE-----

--2zA7mnbRb6Q0M9sF--


