Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC56CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUSps-0005DI-BF; Tue, 02 Jun 2026 13:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUSpq-0005Ck-La
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUSpp-0002W2-4L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780421003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+Nmt+LVt5TaXzYnac+GMGykHQGvgetr1o4/GJbkcj4=;
 b=YBHDjaqYmr+8pXNV0lY2xLDiNqS06z9Zrb9OmjkfuaWSt8KMlseWfCB9C67NSsmfJM46Kj
 JfMccy3BUXykeG6vhrTUyULoIqEV+LrGRZmZDik00ZvvxjA/rcf4GC3uz8YBK7cCUIuaIk
 hGaVzFFMEenvAiuKmsxHihxBRSEiWsI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-QOLhWg_hNYuQhzRWMMHN1Q-1; Tue,
 02 Jun 2026 13:23:21 -0400
X-MC-Unique: QOLhWg_hNYuQhzRWMMHN1Q-1
X-Mimecast-MFC-AGG-ID: QOLhWg_hNYuQhzRWMMHN1Q_1780421000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A664E19560B0; Tue,  2 Jun 2026 17:23:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C987180034E; Tue,  2 Jun 2026 17:23:20 +0000 (UTC)
Date: Tue, 2 Jun 2026 13:23:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/3] testing hotfixes (Makefile, gitlab, docker)
Message-ID: <20260602172318.GA908484@fedora>
References: <20260601161858.182286-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xP5zsVGv/pOPg+z8"
Content-Disposition: inline
In-Reply-To: <20260601161858.182286-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--xP5zsVGv/pOPg+z8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--xP5zsVGv/pOPg+z8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmofEYYACgkQnKSrs4Gr
c8g2wwgAgZYdtoVfTj0h9CUXP9TyEISMDzpnCKptwVSOLerOezp+nIP0vyqmg0VO
oT9tMT4OfM/Ns8RppcfVFBiKlFRDdl4Je+wS52pL5JOfcQvFwvO1Aj/ycwCWfu9U
UUq9PGhOGSb6hNHFm2guoL4tS8RrBhfCRxsEvxJUZXIzBkzGl6E0ZWnbR7D7isDN
D4+cgfAw5l3grajfultTAv3olN44Op+nwyyNySCSXQ5ZcCodXVvaPjeskgy/ETsM
AdXO/0svtXNW5e1NzsZ9hInfi4c/BASkWO0OAOQQbhwnka4UDA6LbUfEAznv6kLh
JmNzCzMukn6rKXkgvbq11D1rOaXWlg==
=Axtr
-----END PGP SIGNATURE-----

--xP5zsVGv/pOPg+z8--


