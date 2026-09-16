Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE70C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCu-0002rX-0W; Mon, 21 Sep 2026 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCs-0002rM-7P
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCq-0002kD-Ro
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vsf5qLyYHsdytF9EY+N5ou1jqhbNOX/dgztdIEkrxaE=;
 b=LzI5Plk8X2zMT/U1kVvAMrM0aaLix1D+IM+DTc+VdseRNnLnI+OC6wVLTddM+f8OzHwdSn
 DV0NXLsMeVXSFNveudK68NFC5SdVXe/7VtjycvTTg7uO8xAdiaMDI4mMODowSJDalZ8Gv8
 fSyDYNDsQM63iwTPfydyY4L4obrf/fc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-nNL2xCiFM9yvOgvSXiLFrg-1; Mon,
 21 Sep 2026 09:37:12 -0400
X-MC-Unique: nNL2xCiFM9yvOgvSXiLFrg-1
X-Mimecast-MFC-AGG-ID: nNL2xCiFM9yvOgvSXiLFrg_1789997830
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 780231964CC1; Mon, 21 Sep 2026 13:37:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE09676A; Mon, 21 Sep 2026 13:37:09 +0000 (UTC)
Date: Wed, 16 Sep 2026 15:56:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 10/13] xen-block: Update tracking iothread users with
 holder name
Message-ID: <20260916195628.GG162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-11-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="flP3lSlL1EUh7luC"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-11-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--flP3lSlL1EUh7luC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 06:16:52PM +0800, Zhang Chen wrote:
> Replace raw object_ref/unref calls with
> iothread_ref_and_get/unref_and_put_aio_context.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--flP3lSlL1EUh7luC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq9GwACgkQnKSrs4Gr
c8hU7wf/REkB44h3Iv69ZdquPMvDSV3wYdsBx1FeDVL6HYsa8bp/wPXAq9vC9uDC
5lCKRA7Jlj1i6X64a/bYLbH75hB+mTRby5Q9KmwkDFQH27rB6ZWFVunvYaJduE8c
1DuWQjfpWmDg4hOiuMiVtTC7PuFKl8P2YAhGBRvzHPbgLkktnEExI1oCO8qZkpMJ
fBauE9okvWKM0i7nOf5Ih8912rcbuMGyTHRWuQSAntFzpff+skucVcJxbHeOHZAd
3sYIXLvJiJuC+x8dBD6YYEh7lAUmYclF38rHv4AVqaTWAcNzZXMRSaYC0NnuvZNz
+PR2CbMr8FnQWC4Khsa+lPBaVlPMQg==
=9W+J
-----END PGP SIGNATURE-----

--flP3lSlL1EUh7luC--


