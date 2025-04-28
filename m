Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9ADC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TKO-00069t-B9; Mon, 28 Apr 2025 14:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9TKN-00069W-BH
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9TKL-0007zk-MP
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745865336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gsYD/Ykhwy1mkdooFa8U40f4W356GzTmDIwhkI++3eg=;
 b=Wc1ZPv09JUs5JFPZ72rWPnNBr1PFQBDDxIb+fZFDf5ciY8I3WXlj5QrJ6KTXG9cI6b91bd
 UnMEXbnseJJcnCLlS8/MwSZXwVfSslRQtvjsiLxG1L+CMAc4QPm9bUhWV3hQeI/YlhUbAi
 qUszheR4CeaBS3g/0eJ8ASyGw3FFQvY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-U5RWNAnCO--ai-hXYzGFqg-1; Mon,
 28 Apr 2025 14:35:33 -0400
X-MC-Unique: U5RWNAnCO--ai-hXYzGFqg-1
X-Mimecast-MFC-AGG-ID: U5RWNAnCO--ai-hXYzGFqg_1745865332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A1181955E79; Mon, 28 Apr 2025 18:35:31 +0000 (UTC)
Received: from localhost (unknown [10.2.17.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9325B180045C; Mon, 28 Apr 2025 18:35:29 +0000 (UTC)
Date: Mon, 28 Apr 2025 14:35:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, surajshirvankar@gmail.com,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/3] aio-posix: treat io_uring setup failure as fatal
Message-ID: <20250428183527.GB636885@fedora>
References: <20250401142721.280287-1-stefanha@redhat.com>
 <20250401142721.280287-2-stefanha@redhat.com>
 <aAuvjznKfL1qg2J7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xFZowiveMw/yNuEo"
Content-Disposition: inline
In-Reply-To: <aAuvjznKfL1qg2J7@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--xFZowiveMw/yNuEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 05:51:43PM +0200, Kevin Wolf wrote:
> Am 01.04.2025 um 16:27 hat Stefan Hajnoczi geschrieben:
> > In the early days of io_uring it was possible for io_uring_setup(2) to
> > fail due to exhausting RLIMIT_MEMLOCK. QEMU's solution was to fall back
> > to epoll(7) or ppoll(2) when io_uring could not be used in an
> > AioContext.
> >=20
> > Nowadays io_uring memory is accounted differently so io_uring_setup(2)
> > won't fail. Treat failure as a fatal error. Keep it simple: io_uring is
> > available if and only if CONFIG_LINUX_IO_URING is defined.
> >=20
> > Upcoming features that rely on io_uring won't need to handle the case
> > where a subset of AioContexts lacks io_uring. This will simplify the
> > aio_add_sqe() API introduced in the next commit.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> While making failure to set up io_uring for an AioContext a hard error
> feels fine to me, I feel a bit uneasy about having fatal errors like
> this in functions that aren't only called during startup. This function
> is also called when adding an iothread object at runtime. The failure
> mode that I would expect there is that object-add returns an error, not
> that the whole QEMU process exits.

Thanks for bringing this up. I'll fix it in the next revision.

Stefan

--xFZowiveMw/yNuEo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgPym8ACgkQnKSrs4Gr
c8gG6Qf/XYO5swuBI+Hv2Swju+jJLrYM7RHekXDTEeA0rcQqHpJf1G1ek3fwmNxu
xUk9Dk+NFNQ62UsBxSy3hSNMHgSAr3Kftju1ltLBOLBhaL2S0KtOjDMd4Ygbyd5F
CxWeZgOKUe/dK2Z54bvnFbnjODiJo7Sp79fajLEgrgpnw43C4Ma0sR7jj0mbP8Py
vpnMlfT8ku491TcUTHAgB9SVHGAyRZbdtaNqJdDMwGDQ6IYAppoPl6xyCblVtJCJ
yDmMQlr0imD4yqaj3hW+tJp2msLM1JbQuDhYJMBYk5UT8+E/q7ohoM+AMztzmux9
54ABxjKBcNz2TrdMzQqWmafrV8FsCw==
=aeOk
-----END PGP SIGNATURE-----

--xFZowiveMw/yNuEo--


