Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F88BCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNai2-0005MN-BK; Thu, 14 May 2026 14:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahi-0005JU-GO
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahf-0002mX-IY
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778782948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmjYGMcM1JWNNo/mH++8huzH06sJRzjZUJBklpSiKOg=;
 b=gfZBSH32wqWjJreNshGuH0DOY/f4wGpIY2LtRtCtwjJS0ny/V4vg/sRqkR1daSFB+JRu8I
 sb66ZfxiAko6Jv+AHUCwMoIdWVypXHmh6KE44/QPZKWxtNW7Zo4JFwbURPXQdbDOW5ErqH
 5LtbzxbVOXBINwfQsOOR08voLrBdMzA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-zOYhCOYoPfWZSYk4JyiIyg-1; Thu,
 14 May 2026 14:22:23 -0400
X-MC-Unique: zOYhCOYoPfWZSYk4JyiIyg-1
X-Mimecast-MFC-AGG-ID: zOYhCOYoPfWZSYk4JyiIyg_1778782942
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C90B18005BB; Thu, 14 May 2026 18:22:22 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 200841955F2D; Thu, 14 May 2026 18:22:21 +0000 (UTC)
Date: Thu, 14 May 2026 12:27:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/41] Misc HW patches for 2026-05-12
Message-ID: <20260514162727.GA1484309@fedora>
References: <20260512203842.4863-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QxyQSgCQaToXWOyw"
Content-Disposition: inline
In-Reply-To: <20260512203842.4863-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--QxyQSgCQaToXWOyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--QxyQSgCQaToXWOyw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoF9+8ACgkQnKSrs4Gr
c8giDAf/b3Mgr7edE/HvGLHKIvvZyQoS9mRjTKurzwq/3IuUU+dh1YBH2iXCnf/g
F5SZK3XCvcJWHX65X/9zH/b7U6NauLddfGmZtd/W9RDNfEaM5S1F9tGs0E7yOxgA
+odhchj2J4YsAE5/LR10onvCwdzXndO+BasJrEu+gPhIKSMYWyJvp673TKF6A5sz
LK0t0vAIm5MifFsCEoSXLEWs1RxfgjWIpAN3/GMlQ49BstX/dVh3r0wS7plaJ0bq
eT2QS2cXlW3STmTXa8B1YlXjaPfnkWre5cUt29iSyMQFicutjgRUvicfisYd87DG
kqKdRHnfIYCtIYrIet0gCWVKrO/ueQ==
=fbOI
-----END PGP SIGNATURE-----

--QxyQSgCQaToXWOyw--


