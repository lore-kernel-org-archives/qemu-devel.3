Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85B2C4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmbCs-0003cU-DX; Wed, 22 Jul 2026 13:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmbCr-0003cI-Cb
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmbCp-00011d-68
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784743084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eV39lK99lfLDJQgLxT7jAsKocKsG5opFvMjmPdk9WQM=;
 b=U3LaUgGbT9A9OFC/r0JajYe7Ixj7B2XjsVwj8gtE4qQ10845yVhC1eoXyC3qmbA0llWlrr
 dqjnpCuDEOM8v602uh2kBbbsXhyIdhef8YrtheONFyLFsIL0lWPiss/HgnYrXUoWY7HlSd
 HH+36e/YM7RSOf55/VntMkpPv93Ljn4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-1IfJ4BAwNzGEvvMZ35zw3w-1; Wed,
 22 Jul 2026 13:58:01 -0400
X-MC-Unique: 1IfJ4BAwNzGEvvMZ35zw3w-1
X-Mimecast-MFC-AGG-ID: 1IfJ4BAwNzGEvvMZ35zw3w_1784743079
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EFC61956065; Wed, 22 Jul 2026 17:57:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.130])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0280E1800286; Wed, 22 Jul 2026 17:57:57 +0000 (UTC)
Date: Wed, 22 Jul 2026 13:57:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 0/5] Misc patches
Message-ID: <20260722175754.GA316991@fedora>
References: <20260721155554.128840-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fQ1fquBFk9zF3unv"
Content-Disposition: inline
In-Reply-To: <20260721155554.128840-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

--fQ1fquBFk9zF3unv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--fQ1fquBFk9zF3unv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmphBKIACgkQnKSrs4Gr
c8i+ewgAgXUmO8rwLkBcAUqWZ80sdOMnpdhd7+M4IdZJmJ/EcMey2B+ITO60444O
ao6vAXh+VG/k5aP6VNqJoCm6w65o8snnHZmOQJ6jr9TE6EbaWhnDZ63IFOE6bAx8
3BD11oq9OZvINwUOJ7tzcM3XumuCkYKoGnBdaoV2Rq5fOPa6+Vw0Yz2Sf8FAlA33
lkYUny8MryYE0G/ViGq2iFmc+0/bfxNWoy5wJM7F0qL5DxYjZW39JpgbkPK4GkME
OnJ3jAnvoHwRS7xzakYROLKgEhGst1NIN90AsD5MPF7A35kmzrFv+WKWPNr8EL7z
45cRpokbdFie7NeTxC8f/7AlpupuHA==
=gbOZ
-----END PGP SIGNATURE-----

--fQ1fquBFk9zF3unv--


