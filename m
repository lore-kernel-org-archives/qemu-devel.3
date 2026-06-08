Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41462CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZGB-00043c-KO; Mon, 08 Jun 2026 08:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWZFk-0003QF-Cc
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWZFi-00014s-Gr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780922328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zcWeHKU1fPlhIQxYh59uYZrKFmpNKRgVOtVY0IQnMao=;
 b=F5oQ1uCSppxOS86OZzm2KWDaSgQSe+MaynYMdHi8ANWpSYymR/oguIq4SuEcPo1LU1BH2p
 1LKJqbfFgp7Fb3crit6lrt3vVPGWXczuFu2J1OMRH2g7ny61yAXkfMIi+FMT7PoqfMk4ZX
 I55sepg7Ng2hH2L6V7SRM2csVz14D1c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-U-nsg1haMIe57eH-DOSdog-1; Mon,
 08 Jun 2026 08:38:46 -0400
X-MC-Unique: U-nsg1haMIe57eH-DOSdog-1
X-Mimecast-MFC-AGG-ID: U-nsg1haMIe57eH-DOSdog_1780922325
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2508D1800623
 for <qemu-devel@nongnu.org>; Mon,  8 Jun 2026 12:38:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3F163008B39; Mon,  8 Jun 2026 12:38:44 +0000 (UTC)
Date: Mon, 8 Jun 2026 08:38:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove Julia Suvorova from Linux io_uring
Message-ID: <20260608123843.GA463760@fedora>
References: <20260603194732.79041-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OE1xnSy4mw4f2u6G"
Content-Disposition: inline
In-Reply-To: <20260603194732.79041-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--OE1xnSy4mw4f2u6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 03:47:32PM -0400, Stefan Hajnoczi wrote:
> Julia's email is bouncing because she no longer works for Red Hat. She
> has not responded to when asked whether she wishes to update her email
> address. Remove her old email address for now.
>=20
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--OE1xnSy4mw4f2u6G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmomt9MACgkQnKSrs4Gr
c8h2NAgAsquxfOB1j+CulP6WRrluUoBw2dk1/3ts5MaI9/uzkVulRyIa0PSG77RB
3W2xH+K+9vUp0CHdP2DwpAmhru4FxaFkR2Cs+s5gA+NGBP/neSXeWJHLp3gn4cZg
GqBdSr48t7PDjYDQxXZBWHSV7h2puDbofMGQD5YHrPW9nQbb15+DwOykbW2SYj/u
AR7HaTqUvpMtTAmg6YXYx997wkF12M/ZUaAbxbWQLGJWj26srsTgqGDB8APHZbH5
qKuJxlEdAL5CIEkR3assIHeBKrWBWXZMbmLPoCSHQK4XyAXHX5kyO4LAk0I8KXkw
Wpdsk7whGCF5uefHAXn39ZNV1OhJhA==
=Y19L
-----END PGP SIGNATURE-----

--OE1xnSy4mw4f2u6G--


