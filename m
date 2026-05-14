Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7668CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNahk-0005Jq-A3; Thu, 14 May 2026 14:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahh-0005J8-Vq
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahf-0002lP-Ip
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778782946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kiIXHnEo7ybEZDmxevhbV7o4pBkrQ7akyfNtekpSUb8=;
 b=e/dszjBOcf6H9xXwQD3lFTfqL2QjwnhQtOckIxCcSDYNU6g59igmSzQnKxB7aA9l//tFEp
 aI0alH2bt0vNPU4RW0jkrG49WitfqOQ17jZlii+SmHL410CJO2ySdQk4nT1t2LwIaaKyej
 EFAF04L9aNRURU5xpEDbk220WUJPJgg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-phsK1ylkPsyg2q8q0zRrSA-1; Thu,
 14 May 2026 14:22:25 -0400
X-MC-Unique: phsK1ylkPsyg2q8q0zRrSA-1
X-Mimecast-MFC-AGG-ID: phsK1ylkPsyg2q8q0zRrSA_1778782944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 122FD1956096; Thu, 14 May 2026 18:22:24 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFD4C1800762; Thu, 14 May 2026 18:22:23 +0000 (UTC)
Date: Thu, 14 May 2026 12:27:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] Qtest patches for 2026-05-12
Message-ID: <20260514162750.GA1485105@fedora>
References: <20260512211221.3173-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ouPO+nyDC8HQKOtI"
Content-Disposition: inline
In-Reply-To: <20260512211221.3173-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--ouPO+nyDC8HQKOtI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ouPO+nyDC8HQKOtI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoF+AYACgkQnKSrs4Gr
c8jI/ggArbisDAZM08R1dv67Ib8rN+wFxX9qJLw53P+3K966/Xg/ZmVgQl9j8RkV
sj84Pp5y8jZAIM0prAdTGLBInZLt5tj2ezJn4PQWslIa4+2lV0GhSdx4F7Ucqa7S
YzpI5VPKzI8MLeptsJRi2AHvMo1D2MwGLO2A6F0PLixnV9N2H9GdgnjKESdIPlMF
jyxfkdNzY3EhyjcEVupQ53RpGj0c6OhH8Z4ZfekT9HpZe/oZQ7GdL/fTY46cgE8B
MyRUEy774nJLaRkhk1ohWG9VZRw3Uagn/8IVHqyAnBupgINoah0mxDLUOW2wdqUX
8mToARr6ZSS5bLbStcAByICCg3VvfA==
=uZlk
-----END PGP SIGNATURE-----

--ouPO+nyDC8HQKOtI--


