Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835D1C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOj6-00033G-KQ; Tue, 06 Feb 2024 11:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXOj4-00031H-5E
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXOj2-00084t-G2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707238511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvQzN05da4wwhxICLYzXe/1B8t+DmJTqNKrrKkFE74Y=;
 b=iBTaouc2fIK3HS3G3ZhQsSj79LT5gi7jIOYV34TH1KmNTqETD1u+XJ0VsZ+ih3Uv824yq4
 AwIdKPi/NIkliLa9TPc4LTc5Ss0BAdhbXJvLDnvHsk1QW/eTV8483ivWVRbY+Bek9HVaQq
 ddPB1Xfo26hk/om9d4EWy713ODzMsI8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-Tuh223oONtirBKI2bQTM6A-1; Tue,
 06 Feb 2024 11:55:09 -0500
X-MC-Unique: Tuh223oONtirBKI2bQTM6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAC311C06914;
 Tue,  6 Feb 2024 16:55:08 +0000 (UTC)
Received: from localhost (unknown [10.39.195.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42CF11103A;
 Tue,  6 Feb 2024 16:55:07 +0000 (UTC)
Date: Tue, 6 Feb 2024 11:55:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/2] block-backend: Allow concurrent context changes
Message-ID: <20240206165506.GC66397@fedora>
References: <20240202144755.671354-1-hreitz@redhat.com>
 <20240202144755.671354-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jiE0927v/rD3BNII"
Content-Disposition: inline
In-Reply-To: <20240202144755.671354-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--jiE0927v/rD3BNII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 03:47:54PM +0100, Hanna Czenczek wrote:
> Since AioContext locks have been removed, a BlockBackend's AioContext
> may really change at any time (only exception is that it is often
> confined to a drained section, as noted in this patch).  Therefore,
> blk_get_aio_context() cannot rely on its root node's context always
> matching that of the BlockBackend.
>=20
> In practice, whether they match does not matter anymore anyway: Requests
> can be sent to BDSs from any context, so anyone who requests the BB's
> context should have no reason to require the root node to have the same
> context.  Therefore, we can and should remove the assertion to that
> effect.
>=20
> In addition, because the context can be set and queried from different
> threads concurrently, it has to be accessed with atomic operations.
>=20
> Buglink: https://issues.redhat.com/browse/RHEL-19381
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/block-backend.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jiE0927v/rD3BNII
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXCZGoACgkQnKSrs4Gr
c8iyBAf9ES+FOTDPQmSG66PM44gspR8ETnNX1rtNfaaMUgntdY8YZcH/P6xrbRl8
p5qHNNhw50Y+HZ27JbwkYXsqLMY+Yl4Ip4V0bDob/UyvE3StQA3ghDbgr68hKnpi
WSFOoCmr6DLdBTX5H4iv+aa9wnl2lYY1hlkZRas0U1eE6VUBdiD1ADwuFtO9XglB
OJewLY64hAMP7U68v+H2Hq8GIu5e6O1hWizMehq+XCEZRJVcGfYMt82yLiy395RN
QnOxIRzm34mLMaPyRVQ31y612rKBvvMyVLXVqrxu+lEoP1TbVtCLFQ1SrRbFjrah
dk/HlMrbauPyT2hB4nj54FNZzbGw4w==
=uf+K
-----END PGP SIGNATURE-----

--jiE0927v/rD3BNII--


