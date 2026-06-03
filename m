Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A84DCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUofH-00016p-57; Wed, 03 Jun 2026 12:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUofE-00016Y-RD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUofD-0003Mp-4u
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780504911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSo7tGBM92IyBniXOlUDxVq20YScnTbMJtX7LWwRKbw=;
 b=VUVn+vbLPGCclljPq0WhUXjqr+Zsdo+DEH4z7pi65zZcRmPDCrbhGhd0h+j56LcuKva1k5
 rVb0UJtvtojqalcjnWfK+G2XUFIYh+KwYE2tP5hceqGOiUYveDTUEdYpnaeQNTYG/c39y6
 SLd+grbMmqhdp3ASzVi38qRRLy808cE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-5VXiKVjkPwOteIXVKtFZlQ-1; Wed,
 03 Jun 2026 12:41:48 -0400
X-MC-Unique: 5VXiKVjkPwOteIXVKtFZlQ-1
X-Mimecast-MFC-AGG-ID: 5VXiKVjkPwOteIXVKtFZlQ_1780504907
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A9401956095; Wed,  3 Jun 2026 16:41:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73201180049F; Wed,  3 Jun 2026 16:41:45 +0000 (UTC)
Date: Wed, 3 Jun 2026 12:41:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com,
 pierrick.bouvier@oss.qualcomm.com, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 26/38] MAINTAINERS: Drop stale F: from "Block I/O path"
Message-ID: <20260603164141.GA59214@fedora>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-27-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hBg83Lnc/2w4OaN3"
Content-Disposition: inline
In-Reply-To: <20260603064032.3733394-27-armbru@redhat.com>
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


--hBg83Lnc/2w4OaN3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 08:40:20AM +0200, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we deleted
> tests/unit/test-fdmon-epoll.c.  Update it now.
>=20
> Fixes: 60f782b6b7 (aio: remove aio_disable_external() API, 2023-05-16)
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hBg83Lnc/2w4OaN3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmogWUQACgkQnKSrs4Gr
c8hRUggAl9exAQDB8tQhPT1VTezOMBCEr1FK3OZvi1EOYIZPsn5AgQrGQWIgR04C
4qX0bBBjkflkbG9SbC1o3C56E9cDeL2Qb5MJsiaDwbnbfF4bTbxz4227KC7P4yYt
jPET2QjqR+hpl1DtuuFLwrva0PXiNzZk17nvGFDf5JbOeWSX2DV5uXBuqXVmltn3
N8BRrA2xp21XET5zZ3HHCt6y1tvjIw8sus8dXf6635/CP8J09QPXqNdDOmeASo88
56Dwo/X8iQPjj9FWvHxJPY/bBhCKeemwqj1NZAQqRWjG8QqC92+h/AzjRbBnIB1e
nnqqX312Zw3EsqcQs1UVWc6F4RN/nw==
=C0Xg
-----END PGP SIGNATURE-----

--hBg83Lnc/2w4OaN3--


