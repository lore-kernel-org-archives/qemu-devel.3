Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5C9C982F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCr-0002rA-Sx; Mon, 21 Sep 2026 09:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCp-0002qt-OX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCo-0002jw-9E
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NVzOKWipDJEPm4BxDQuNka1HGHWeIwMFNBIL/uTjwtM=;
 b=Xy4sS3vXqUdtjCPHY0OH1NU9Hxi4N4tqfQSC2E6AqWO0Zu5czcXLZL/GEAWyOV5mvZqC+L
 +xHdK503OdZ5kKDfym5Ja0cCJoOM+/JyvA40UWKU4dCfp/5Y4Pea1VkMrx6cgjHGcM1U5C
 9U5NIFCaoYIsydFpaYvmpjvmsUH71/0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-uuJ2YKHDMxunmQWSN7YJYA-1; Mon,
 21 Sep 2026 09:37:09 -0400
X-MC-Unique: uuJ2YKHDMxunmQWSN7YJYA-1
X-Mimecast-MFC-AGG-ID: uuJ2YKHDMxunmQWSN7YJYA_1789997828
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62750183044C; Mon, 21 Sep 2026 13:37:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8B8D41D; Mon, 21 Sep 2026 13:37:07 +0000 (UTC)
Date: Wed, 16 Sep 2026 15:54:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 09/13] vfio-user/proxy: Update tracking iothread
 users with holder name
Message-ID: <20260916195426.GF162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-10-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iZ1m58KQ1LOxKDkb"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-10-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--iZ1m58KQ1LOxKDkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2026 at 06:16:51PM +0800, Zhang Chen wrote:
> @@ -917,6 +918,11 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>      proxy = g_malloc0(sizeof(VFIOUserProxy));
>      proxy->sockname = g_strdup_printf("unix:%s", sockname);
>      proxy->ioc = ioc;
> +    path = object_get_canonical_path(OBJECT(proxy->ioc));

What does this path look like when you test this? I took a quick look at
the code and it looks like this object has no parent, so path will be
NULL?

--iZ1m58KQ1LOxKDkb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq8/IACgkQnKSrs4Gr
c8jVUgf/RTVAiFXiWp4rvPuH7i0UG8FtILkX9Kxy5pEN7bH1oXFHJQYP14FBYO7u
qfIjxLL3yie1ZVIKBr0+cKHfHbUov+kqZGVf5vxbsrVxQp7t2sCXDtv6JdZ6msRT
7lgCqXELtckNiDL4quF+x4eJ7rtN2dl82rRYONseLLV9yyL66lozsZrnTY6g15wR
KRJtWZmUry25D1+DqqmzoRNqXJgWC3vchNRbWN2P40lH6T+A7VCxlO4za/7W7ump
h1TTFHuFSVU0tHNoeZe4Ee0aonRrlqWu7fOEySgkDFc+zmUFgzQwi8jh4AI5a4Qf
zThZ+wBBmFoMHlgmSuc+V7eDRA5fsQ==
=jxcr
-----END PGP SIGNATURE-----

--iZ1m58KQ1LOxKDkb--


