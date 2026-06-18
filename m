Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF01CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGw8-0001A7-6q; Thu, 18 Jun 2026 13:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGw5-0000wA-P9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGw4-0008JV-D3
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781805231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DefQIjhe+enNM4rz7P5Hbws+QPAB7VwH7BUyznaFvkA=;
 b=PN98fQDcgkDz2H/Tz/20jCm68nex2kjvcl4+JOIFNd2bdtAJj61MZ+cufJjKUfg3RGB9dX
 k6bjEEy/V40sjqVp5HCRZQmNmwrEJabivwk2psxOj0qjfWOoygnYVP7Etwyz+koVqyWsgg
 thy5Q0vMAYd+x6ngGNfHBTNzXw3iQoo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-xRHFeCZxNWK6yVsvjfNSeg-1; Thu,
 18 Jun 2026 13:53:46 -0400
X-MC-Unique: xRHFeCZxNWK6yVsvjfNSeg-1
X-Mimecast-MFC-AGG-ID: xRHFeCZxNWK6yVsvjfNSeg_1781805225
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D94418005BC; Thu, 18 Jun 2026 17:53:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95AD430000DB; Thu, 18 Jun 2026 17:53:43 +0000 (UTC)
Date: Thu, 18 Jun 2026 13:53:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PULL 0/3] 9p queue 2026-06-17
Message-ID: <20260618175342.GA748555@fedora>
References: <cover.1781710785.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6qeKlUe0Am8TnL9b"
Content-Disposition: inline
In-Reply-To: <cover.1781710785.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--6qeKlUe0Am8TnL9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--6qeKlUe0Am8TnL9b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0MKYACgkQnKSrs4Gr
c8hWrgf7Bd6kbv+XDPQ77k8dt/vz67tUZ2+EMqrBvG+GLnR2lCTsv+5JhqKOgKWr
p0s4O/nraKJ7rBG1HFnPjWPhaB+/ccSjtuQ/lpowqmU6v7+pfy6abTl8pGuCH5eM
/zEjsi6zfFfgjxWNdu04MXW0s3MIrl6mwAJSlpLZ872kNByTMpy+FxIkIvKh2XzF
P8X8yzQOHLOarKLU5CWTXk10lT36QdcPzGJiRV9bhHuecxDZK304BH/YhGe0HU7c
dPq8A7y1uUxmyrPBZcMWzOkUgQLzyv7k2Nx76e27MbDJoA44i/ronXc4xEK4oifh
G8i8LlaM5cuZk576pRjAKiXmpFGxag==
=/jsM
-----END PGP SIGNATURE-----

--6qeKlUe0Am8TnL9b--


