Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57917CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4p9-00012Y-CW; Thu, 21 May 2026 10:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ4p3-0000y2-5g
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ4p1-0002b7-RH
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779375387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1RYzJbjCiBvBs+vBjTpj3ysBtdHV7GoeIaSHzADXK24=;
 b=V2xvRNgLys/CMr0HOA1/WHoZ23Zv/cAmoYxN5TGZ4Y6AOQHT4Jqx6+EbejnBnl5a8p4S8N
 I7dWsBljQWJFwX6BRgyJcrKYYUI5Fy9bbTy/9RuZCMz9FaBw4uJ1VTiEYipO94PSYVG7zg
 Hkfn56DRlD93bqhtZTLZDlfBCZUAS3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-YvStum0_NEuq8y4HoMgDpg-1; Thu,
 21 May 2026 10:56:18 -0400
X-MC-Unique: YvStum0_NEuq8y4HoMgDpg-1
X-Mimecast-MFC-AGG-ID: YvStum0_NEuq8y4HoMgDpg_1779375377
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E861B19560B7; Thu, 21 May 2026 14:56:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A2E01800762; Thu, 21 May 2026 14:56:15 +0000 (UTC)
Date: Thu, 21 May 2026 10:56:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 27/39] MAINTAINERS: Drop stale F: from "Block I/O path"
Message-ID: <20260521145614.GC464582@fedora>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-28-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aGS4M20/R4rVCFiT"
Content-Disposition: inline
In-Reply-To: <20260521080511.999266-28-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--aGS4M20/R4rVCFiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:04:59AM +0200, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we deleted
> tests/unit/test-fdmon-epoll.c.  Update it now.
>=20
> Fixes: 60f782b6b7 (aio: remove aio_disable_external() API, 2023-05-16)
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--aGS4M20/R4rVCFiT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoPHQ4ACgkQnKSrs4Gr
c8gRQggAvlvKS7DWS4T0kcoCkN5Za31qyg1c3QMs3mdkcUlgbu+gv38QgSZM8efr
h9uxb5yDFHhJKfztRY8r3sKtObcQ47Q24mV4Hf3pyMwOde9oiphPkMKBTFkbcYVt
BW8YTRdssZv9xIcQi/j+F1SwTCPn8I36zGrm26WehnsvIUKqwC56cstkfsuaI5t0
QR0TIBp7oCXxbQWnPLYC8Ued2OglmUIpdSGzBwT2lpudG2dqFPnqJF/wHhqE35Yb
/bmxmsX/fRHWpPSPcAbGhL7BNRzniiphY/e20SF0Apuv0RieAh76BwwIklI/N24m
iTGEsrYDGGeFBXQvflxvnFjMqp23+w==
=KMqu
-----END PGP SIGNATURE-----

--aGS4M20/R4rVCFiT--


