Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD130CD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVB5w-0000tK-VZ; Thu, 04 Jun 2026 12:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVB5v-0000t2-KB
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVB5u-00053s-0L
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780591136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEqxy6bPJHc7f6eon7qXhL3J9B/CEDNM2ITtdKSqNps=;
 b=c5zVYE4yvy6dCgIEm3tl8aKvZDIcaiR9OYQ5FREui3Wqvp4OG/8Yd9EeqSVx57scyQ+VJj
 yNrwUIRGToHRTw+HftCjmcBER72dRWLZ0aIRq82zmvtlp00q0DBWUzdFPaJkQ3NsKbaifi
 PXwcVcc9NJQMXsA4CTvHIAyb/a149Zg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-9dKQPmbXMEWYDGmud3LBXg-1; Thu,
 04 Jun 2026 12:38:54 -0400
X-MC-Unique: 9dKQPmbXMEWYDGmud3LBXg-1
X-Mimecast-MFC-AGG-ID: 9dKQPmbXMEWYDGmud3LBXg_1780591133
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B53719560A1; Thu,  4 Jun 2026 16:38:53 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E9E4180049F; Thu,  4 Jun 2026 16:38:52 +0000 (UTC)
Date: Thu, 4 Jun 2026 10:29:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com, qemu-block@nongnu.org
Subject: Re: [PATCH v2 34/38] MAINTAINERS: Drop stale F: from "Linux io_uring"
Message-ID: <20260604142919.GA115597@fedora>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-35-armbru@redhat.com>
 <aiF6lwircL8PCske@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l9iLVPOMQ8sQStEr"
Content-Disposition: inline
In-Reply-To: <aiF6lwircL8PCske@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--l9iLVPOMQ8sQStEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 03:17:52PM +0200, Stefano Garzarella wrote:
> On Wed, Jun 03, 2026 at 08:40:28AM +0200, Markus Armbruster wrote:
> > We neglected to update MAINTAINERS when we dropped stubs/io_uring.c.
> > Update it now.
> >=20
> > Fixes: 047dabef97 (block/io_uring: use aio_add_sqe(), 2025-11-03)
> > Cc: Julia Suvorova <jusual@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Cc: qemu-block@nongnu.org
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > MAINTAINERS | 1 -
> > 1 file changed, 1 deletion(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 71383b9807..c5b6985767 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4331,7 +4331,6 @@ R: Stefano Garzarella <sgarzare@redhat.com>
> > L: qemu-block@nongnu.org
> > S: Maintained
> > F: block/io_uring.c
> > -F: stubs/io_uring.c
>=20
> Should we add `util/fdmon-io_uring.c` in this list ?

No, this section is under "Block drivers" and is specifically for qcow2,
iscsi, raw, etc.

util/fdmon-io_uring.c is covered by util/fdmon-*.c in "Block I/O path",
which is where AioContext and QEMU's event loop lives. The name "Block
I/O path" is not the best fit anymore and maybe it should be changed to
"AioContext event loop".

>=20
> BTW this is unrelated to this patch that LGTM:
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> >=20
> > qcow2
> > M: Kevin Wolf <kwolf@redhat.com>
> > --=20
> > 2.54.0
> >=20
>=20

--l9iLVPOMQ8sQStEr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmohi78ACgkQnKSrs4Gr
c8jyJQf+J2gQMUsaB69Bw3AJIOje5M2meSKnBeElw31n6VMTPshW5bpinwKCi0vt
CgzjRSD19s8ovntiXIAmli9vD6E+M/IKOJAoKamxhbvR+gb35H2cwBIAIB22OQTP
If3FOaOew+t4pybE2fGyjsiZbN7IaAVOs3YbT3FCdyNe8Jc1kz1uLkYmDTugBnel
h+2dNpqoo24V3jGiT2xLx8w9zPFLEA4+uKnO8cTvjd3WRD+AEO+gHNbYHLGbViYg
zY2hOYznfpUPQ/kizGbTjAM65REdmGaD0b2InBMEOwGeax4kV/A+HZ5ftX28ncDY
h0f0PWOcrTe2/d6n8WdJBI5W9rAWdA==
=R/Ke
-----END PGP SIGNATURE-----

--l9iLVPOMQ8sQStEr--


