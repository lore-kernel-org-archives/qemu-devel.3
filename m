Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082CAC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQTa-0006Re-A9; Tue, 18 Aug 2026 16:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwQTW-0006OY-QW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwQTT-0003v4-A8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787085112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e0ahbyj5c+IG7nYHDlbXPS38LTYjzjMpWUbomvqbZnQ=;
 b=dSpSMMSpA7wxMmdTqQrIXdYUA3J+Tpvg5QMS25RGNs8m2l+kP6YUuw4na6WEncYuVP3egD
 o3ZH1A91QXoKtpC6exb0n7HgjC/e8TD26M/EDmjkMTMMXtfCwBaW3l72fsB7sJuO1COGaV
 pVAyoFEcdn/h5/UfreaTwCHNwSwq4Yc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-Md-a6bMKNsOgnCW5_domRQ-1; Tue,
 18 Aug 2026 16:31:49 -0400
X-MC-Unique: Md-a6bMKNsOgnCW5_domRQ-1
X-Mimecast-MFC-AGG-ID: Md-a6bMKNsOgnCW5_domRQ_1787085108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26168195609F; Tue, 18 Aug 2026 20:31:48 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B336180034C; Tue, 18 Aug 2026 20:31:47 +0000 (UTC)
Date: Tue, 18 Aug 2026 16:31:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V12 03/15] iothread: track users with holder name
Message-ID: <20260818203145.GA222512@fedora>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-4-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4qz7LdB7jRQGj7yw"
Content-Disposition: inline
In-Reply-To: <20260814174830.1691540-4-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--4qz7LdB7jRQGj7yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 01:48:17AM +0800, Zhang Chen wrote:
> Introduce iothread_ref_and_get_aio_context() with a holder argument
> and its counterpart iothread_unref_and_put_aio_context().
>=20
> Previously, users of an IOThread AioContext did not explicitly record
> their identity, making it difficult to debug which devices or
> subsystems were pinning an IOThread.
>=20
> Registering a holder takes an IOThread object reference so that the
> IOThread and its AioContext stay alive until the matching put
> operation. Document the ownership and BQL requirements.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h | 22 ++++++++++++++++++++++
>  iothread.c                | 24 +++++++++++++++++++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4qz7LdB7jRQGj7yw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqEwTEACgkQnKSrs4Gr
c8jqvggAjviwgvl1VMB2uXdp3yM/SFcgdVbGO10A9b9By2m9pyhgDXLLIjZSH6tx
CpTHaOmyzPdhnAbyyLOjoDX3ba5wtazNkquw1NAdOpR+TlKuf8mzGpX7EN0VERj/
gcf8gbOtb2034i5uZt9MDNVeakijdLbcaoWoC5dOKz1aZQNkFOug3kunPcpoX869
dFVgXipKFg5lSZuSW6+xQEtWN86d4RPGEbDjcsaHphRGE5FdxqjSB2of6fqtrGgo
wCjuxgBzeR2QdQOj/KmEqtDw7WnoDVHcWn3HT1k0x4dxP4O/gZj4mLIgX2aFm8AD
txRSsglI2T9CkVx9NJ0QzgLrSISIbA==
=HXRP
-----END PGP SIGNATURE-----

--4qz7LdB7jRQGj7yw--


