Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A71EF3717
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzW42-000423-A7; Mon, 09 Mar 2026 04:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzW40-0003zw-TE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzW3v-0006c0-6r
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773045233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TtAW2lXzsRzS7/I5t7yFbkzEhILckkTzD88/GKLoroo=;
 b=clZISSJqtCkdoDFWzqddAZIjY09Kiu4jKy7UREhEwrc+zmD+0zgNNwfVxnXbtlBGayeXsJ
 aojvq/w3YBZfn2QJKEe594HS+BszGhauesJjyEnEIINVA52M8OEABaYGOofHHam3JSewfH
 bTTdmF+K3Wan4qtvS84BwrbDyHT4GGY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-8_mZvtueNn2zDlxW-cXxXQ-1; Mon,
 09 Mar 2026 04:33:52 -0400
X-MC-Unique: 8_mZvtueNn2zDlxW-cXxXQ-1
X-Mimecast-MFC-AGG-ID: 8_mZvtueNn2zDlxW-cXxXQ_1773045231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AA17180034E; Mon,  9 Mar 2026 08:33:51 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA0F31956095; Mon,  9 Mar 2026 08:33:49 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:33:46 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 03/13] iothread: tracking iothread users with holder
 name
Message-ID: <20260309083346.GF39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-4-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uhlulaZax1ZA20kJ"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-4-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--uhlulaZax1ZA20kJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:24:49PM +0800, Zhang Chen wrote:
> Introduce iothread_get_aio_context() with a 'holder' argument and its
> counterpart iothread_put_aio_context().
>=20
> Previously, users of an IOThread's AioContext did not explicitly
> record their identity, making it difficult to debug which devices or
> subsystems were pinning an IOThread.
>=20
> This patch enhances the reference counting mechanism by:
> 1. Automatically incrementing the object reference count when a context
>    is retrieved.
> 2. Tracking holders by name using iothread_ref() and iothread_unref().
>=20
> In iothread_instance_finalize(), we now retrieve the source name from
> the GMainContext to correctly unref the initial internal holder.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h |  3 ++-
>  iothread.c                | 28 ++++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index 21a76bd70d..595abeefbe 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -47,7 +47,8 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> =20
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
> -AioContext *iothread_get_aio_context(IOThread *iothread);
> +AioContext *iothread_get_aio_context(IOThread *iothread, const char *hol=
der);

This commit breaks all iothread_get_aio_context() callers because they
are not yet converted. The build will fail here.

Every commit must build and pass the tests. This is necessary so that
git-bisect(1) works and it also makes backporting patches much easier
when there are no implicit dependencies between commits.

Please structure this patch series in a way that keeps the build and
tests passing. One way to do this is to give the new API a different
name like:

  AioContext *iothread_get_aio_context(IOThread *iothread);
+ AioContext *iothread_ref_and_get_aio_context(IOThread *iothread, const ch=
ar *holder);

That name also makes clear that a reference will be taken on the
IOThread. You could then require callers to call iothread_unref()
directly instead of iothread_put_aio_context().

One of the last commits in the patch series could remove the old
iothread_get_aio_context() after everything has been converted.

--uhlulaZax1ZA20kJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmuheoACgkQnKSrs4Gr
c8guJgf+ONyGkPNnTMB0npIJAhjP9rsjmVeaXsgZ7OSjTWPVlRGAfAZROp8ggbg6
mw3zNPBS+yuNAgccxWchGGlqNUT9eJfvlu82SZeW9YNMTpV4sTBpl4k0JDfP9HWa
0trwZ0R1f2Q/I0sefLHPTaKlrx8iFwyv77Y81coFoin22aUocauyZTdskMGl3QwT
kQ244kynrS93ugtY1vo1ZKxh7JNZF6jAFBvMAQJurQzuK3nCSvsBgXYybQp9ZblN
iR+YvY+2WHmR1kwSScalvMBllhpg0yDEE7o2WBL+gc32/kv1HNqT53Dhv0yX9DKe
CWvav5AbCwb+Razb2pu8DpXdVNU1og==
=A7Bq
-----END PGP SIGNATURE-----

--uhlulaZax1ZA20kJ--


