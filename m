Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA411EF3700
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVZF-0008PF-4g; Mon, 09 Mar 2026 04:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVZD-0008P2-8Q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVZ7-0002pb-S0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773043331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xLE9GozN7puFCauXKzJ7T7rz2TqaJverhm8Fy/HQ584=;
 b=LuqJVnDO/WjUPM1aQHu3tPVe3QskKVMioPzuaqCVGFaG20+I7p0QSumPD/FYDohWznDaWr
 jsBnyVCrIj054BzrOZ2ohzZnNMLz9lpc/kKl/1dHn40ro5m+xa2NmNShdvrtJvMKmH7pNL
 QwrWh1D9Q4Prx81NGzR0P2aKlYdTUIU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-m13lkWZfP8-rMaI0hP2DEg-1; Mon,
 09 Mar 2026 04:02:06 -0400
X-MC-Unique: m13lkWZfP8-rMaI0hP2DEg-1
X-Mimecast-MFC-AGG-ID: m13lkWZfP8-rMaI0hP2DEg_1773043325
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DB38180047F; Mon,  9 Mar 2026 08:02:05 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF5C73002D0D; Mon,  9 Mar 2026 08:02:03 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:02:01 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 03/13] iothread: tracking iothread users with holder
 name
Message-ID: <20260309080201.GB39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-4-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B1x3vOJzU/ro8ZuT"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-4-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--B1x3vOJzU/ro8ZuT
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
> +void iothread_put_aio_context(IOThread *iothread, const char *holder);
>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> =20
>  /*
> diff --git a/iothread.c b/iothread.c
> index 80a8cf4b32..da98fbb9ad 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -172,7 +172,8 @@ static void iothread_init_gcontext(IOThread *iothread=
, const char *thread_name)
>      g_autofree char *name =3D g_strdup_printf("%s aio-context", thread_n=
ame);
> =20
>      iothread->worker_context =3D g_main_context_new();
> -    source =3D aio_get_g_source(iothread_get_aio_context(iothread));
> +    /* No need setup itself as the init holder */
> +    source =3D aio_get_g_source(iothread_get_aio_context(iothread, NULL)=
);

This is cleaner:

  source =3D aio_get_g_source(iothread->ctx);

That way iothread_get_aio_context() doesn't need a special case for
NULL.

>      g_source_set_name(source, name);
>      g_source_attach(source, iothread->worker_context);
>      g_source_unref(source);
> @@ -362,11 +363,34 @@ char *iothread_get_id(IOThread *iothread)
>      return g_strdup(object_get_canonical_path_component(OBJECT(iothread)=
));
>  }
> =20
> -AioContext *iothread_get_aio_context(IOThread *iothread)
> +AioContext *iothread_get_aio_context(IOThread *iothread, const char *hol=
der)
>  {
> +    /*
> +     * In some cases, iothread user need the ctx to clearup other resour=
ce.
> +     * When holder is empty, back to the legacy way.
> +     */
> +    if (holder) {
> +        /*
> +         * This guarantees that the IOThread and its AioContext remain a=
live
> +         * as long as there is a holder.
> +         */
> +        object_ref(OBJECT(iothread));

Can this be done in iothread_ref()/iothread_unref()? That would ensure
that callers always increment the QOM reference count regardless of
whether the iothread_ref() or iothread_get_aio_context() API is used.

> +
> +        /* Add holder device path to the list */
> +        iothread_ref(iothread, holder);
> +    }
> +
>      return iothread->ctx;
>  }
> =20
> +void iothread_put_aio_context(IOThread *iothread, const char *holder)
> +{
> +    object_unref(OBJECT(iothread));
> +
> +    /* Delete holder device path from the list */
> +    iothread_unref(iothread, holder);
> +}
> +
>  static int query_one_iothread(Object *object, void *opaque)
>  {
>      IOThreadInfoList ***tail =3D opaque;
> --=20
> 2.49.0
>=20

--B1x3vOJzU/ro8ZuT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmufnkACgkQnKSrs4Gr
c8gsCAf/Yxru/b/Lu9+LZAejXWMdH09sokk4KS/3rwq7bERl/8O8ZawObsQ+8S/W
rgvRFmQUh5BYweHDXpkAne1RWqMV8PLAm69ANzLFxPy/2Y8gBEZ4M8hb631xRmdb
E5aok4Fx165irn+OMDaNKIMp1CPCNSf51RLfeANRTsZqb8SYvjDt1I8mCgVEyMdx
mYjdTd8cRThTaT0s2N50bA8G1EwDWoAtveE2Be8v0STiTHVqy8kZYQuXxW+4q1G6
SRJUHivBthTQ2kLAz5Lw7/B43NJG1PdxHmAv5f7sj0RIX9I023BOpk5PaIh1ixFu
+nXL5cGr16dPhpRZ8w/eKfE3q/6YXw==
=+ueP
-----END PGP SIGNATURE-----

--B1x3vOJzU/ro8ZuT--


