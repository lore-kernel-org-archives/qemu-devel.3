Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9076FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 16:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI7h2-0006fI-2g; Wed, 29 Apr 2026 12:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7h0-0006f1-BR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7gx-00077c-U9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777479794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k4JBnhnOQVZ59+WCDeRVvVnFK6ZX1DKMC/nmo4SoLzg=;
 b=ifUcugIXglZnimxEItmjCWdMWV2yWH17tCinii4J9IPsxiz+rAIEaaiVno/+CYH8D+0Drq
 Q+dvfAYWhxHDOrWV4bcmTK1KpSrbmZNPix0oWH57CUBIANUe1SUHvq4Nl3OwS3l8UfZhep
 YhGyHtjtw/UPs/W+3yjv/4coDzPPwdo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-yZlloE12NwqpeNKpf3x5zA-1; Wed,
 29 Apr 2026 12:23:10 -0400
X-MC-Unique: yZlloE12NwqpeNKpf3x5zA-1
X-Mimecast-MFC-AGG-ID: yZlloE12NwqpeNKpf3x5zA_1777479789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C5A719560B5; Wed, 29 Apr 2026 16:23:09 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68ED419560AB; Wed, 29 Apr 2026 16:23:08 +0000 (UTC)
Date: Wed, 29 Apr 2026 12:23:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@gmail.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL v2 00/15] UI patches
Message-ID: <20260429162306.GA120965@fedora>
References: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lp5AUJ+u7ZIqutrS"
Content-Disposition: inline
In-Reply-To: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Lp5AUJ+u7ZIqutrS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Lp5AUJ+u7ZIqutrS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnyMGoACgkQnKSrs4Gr
c8iSRgf/VdAGDQh5mdqqHysYLEcj5A4rhxKq6CVQNlf2yAPzQmSFU08ftsjnU2Gy
H+lkSMCOImJOd2O5WLY5VAAnadrn1gd/2IOldagPavdZu60N0/yhxuPEqqEZwJjC
HCEOOXzJh2+XRlyIWLxOOyuHTxveqqnzF/X9QbWNNLEvM8k0z6Lug5oC0gfXLtpF
j5UIihtaTNidcu6nQLzVU0it8SvsWN/Cp5xojKSFsuX+7dv3Ej83OPHWwjMsWdKj
BDUaRYwmjXxtwlXOXho58nzfbWWRB+ShlJf4MT2pVq1E0Lre3IU829KgAVrwt/F7
D+PF55xfLmhuOgdt8U6Yzs7td63bzA==
=fW6p
-----END PGP SIGNATURE-----

--Lp5AUJ+u7ZIqutrS--


