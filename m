Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61516C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 18:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugp0Q-0004u4-Gm; Tue, 29 Jul 2025 14:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugngK-0002ZU-PJ
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugngI-0006p6-Ua
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753808401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+1RPGctOOZUfWhIt8aYTWYEYzCeXsM1Npmm4KZF9dA=;
 b=PobFryMnyLbmBTwv767WSxJN/dOK58N4zw3Y7OCG8msMeTdvO52Q76exBVflwJsHeulRuz
 aiPFnbZDh/BicDK75f2AhQJdyF+K/t1a0VnEw8gryBhncpn34q+u7mNAPoV9ZIOcxD8BVJ
 KB4oJvgeAU62nVDDCTKpzL08TEBHea4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-aSClao3KODS2NjYy99QDTg-1; Tue,
 29 Jul 2025 12:59:57 -0400
X-MC-Unique: aSClao3KODS2NjYy99QDTg-1
X-Mimecast-MFC-AGG-ID: aSClao3KODS2NjYy99QDTg_1753808397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB9F319560A2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 16:59:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.185])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA710180035E; Tue, 29 Jul 2025 16:59:55 +0000 (UTC)
Date: Tue, 29 Jul 2025 12:59:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/5] QAPI patches for 2025-07-29
Message-ID: <20250729165954.GA21690@fedora>
References: <20250729131148.3777401-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z8hQdmdwN20uWSqt"
Content-Disposition: inline
In-Reply-To: <20250729131148.3777401-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--z8hQdmdwN20uWSqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--z8hQdmdwN20uWSqt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiI/goACgkQnKSrs4Gr
c8i8PQf/Yu+IbBrc+PnOHuM32tdlIz3zjb9fA/gMJr0J59NmhgOyHbhZTGlYWKbo
6Y7g1iYPtZ3aJJMzlizfyDeD/r2qne7xfy2GP7gV49htIh5640qiIyBSZhPDQ2tL
UisQChf2bdryTdxsmOksFkGlouDctQXJZwvGcUJLFqx8AjPXRLMJ0Uotj064Ey6O
QYOUh6+9uS8+TWS36jnk4lIIU5UE1MNinHjRryubqqRnivbHSFPlNrRPVV+JjYbM
5ZpMrunJe9JdtbaVMiJ2t8m2i//2S+IEiaLXnC843ckVyGBRSqAwk/P2HyaP/p0e
OOyKEDwuJ2FkdKsv2Haks8H7dVlpEw==
=4MmO
-----END PGP SIGNATURE-----

--z8hQdmdwN20uWSqt--


