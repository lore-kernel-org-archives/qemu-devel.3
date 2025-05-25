Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C90C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJD9X-0005kz-1J; Sun, 25 May 2025 11:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uJD9R-0005gb-Bm
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uJD9P-0007EB-97
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748186432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z3LiA80BnhvqJAqPfyDnsPR6GAW91TqhNbQzzrMd2Hk=;
 b=LHuntPyrbgoNvOGOz06RNl2m+HNCj5uPCq18gSo3qcxJFfyqYXJWCchnJ8z6PicCcVmZfy
 PEt0j4DQrSVmAE2kb/bZGc9xJMdVx+nDKvWL0InuPCSt3DPNNeQxMyz9CedMgeK5HakPCX
 eoeibm8c9hZbBj+GYO+qd7NHGuKEQgs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-dKxKT2HVO5GgVae_ZuCItQ-1; Sun,
 25 May 2025 11:20:30 -0400
X-MC-Unique: dKxKT2HVO5GgVae_ZuCItQ-1
X-Mimecast-MFC-AGG-ID: dKxKT2HVO5GgVae_ZuCItQ_1748186429
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 836011956087
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 15:20:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F88519560AB; Sun, 25 May 2025 15:20:28 +0000 (UTC)
Date: Sun, 25 May 2025 11:20:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: Re: [PULL 00/19] Ui patches
Message-ID: <20250525152026.GA68441@fedora>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P7lMs4jm2tu1c1fA"
Content-Disposition: inline
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--P7lMs4jm2tu1c1fA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--P7lMs4jm2tu1c1fA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgzNToACgkQnKSrs4Gr
c8hYRgf+NG0doCHH6Z4rFuzyeGW/pi/1rb4V5oBoo3WTG1JKCgnsUfY/yAOTIrdb
A9x82WriRZGUnKZw442m1V1ALkHiOw1MndTKRO0ATcjfbOSqjmIEWMD63G9WkjLp
Yia4a/Qo2T/1HbbvuvaNW1AG1CADZe4L1PYcoq+Wz2nDtyyYkK8wt8T+/O1b/LT7
0DJfic4w6hB8db8XUeRnyVHjGpEU7w4XbnMPQSxocWp637niqKKbEIR1YcDwviIp
8SqjNihQs8gh90ggU0CmJwE6oFL1+aBGRtFmRQd0j7jLo+WVQaCLzCSx4nfvoG9W
93vsFC1lHbopacGLFo56S1I1Pt4vBg==
=XPg/
-----END PGP SIGNATURE-----

--P7lMs4jm2tu1c1fA--


