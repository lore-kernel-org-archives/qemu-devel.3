Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C45CCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVm9-0008WG-Rt; Mon, 11 May 2026 14:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMVm5-0008Vp-Qe
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMVm4-0003jh-4Y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778525678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQ0rhOpOg4b8i0WgDYbaNUubjpGuYo+2A2n6Sz+K/cw=;
 b=cAfcA4cqXA32uhZYSD5LguR2x3pl8dgvxddjpirkB1juiTTO+mmaBbsgSiqkOvm3pKYBNm
 KY2D/rwyOsGCYNJTaw+iKqg6ch/Aa5jTmEIKeQMwJambPdIyb6cbXZRPxBu2PVLj60S4CT
 cIMB8gWaC5d443Z9zzzeMWBCnnUNEG4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-7lH2-hRmM1GpInG3yGZTYg-1; Mon,
 11 May 2026 14:54:33 -0400
X-MC-Unique: 7lH2-hRmM1GpInG3yGZTYg-1
X-Mimecast-MFC-AGG-ID: 7lH2-hRmM1GpInG3yGZTYg_1778525672
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32430180034E; Mon, 11 May 2026 18:54:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55AAC3002D31; Mon, 11 May 2026 18:54:31 +0000 (UTC)
Date: Mon, 11 May 2026 14:54:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V7 03/14] iothread: tracking iothread users with holder
 name
Message-ID: <20260511185430.GE536999@fedora>
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-4-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gkAxvd6gqo/jOQUn"
Content-Disposition: inline
In-Reply-To: <20260511140416.28271-4-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--gkAxvd6gqo/jOQUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:04:05PM +0800, Zhang Chen wrote:
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
>  include/system/iothread.h |  3 +++
>  iothread.c                | 33 +++++++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index 2871b06edc..313ef61124 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -70,6 +70,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
>  AioContext *iothread_get_aio_context(IOThread *iothread);
> +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> +                                             const char *holder);
> +void iothread_put_aio_context(IOThread *iothread, const char *holder);
>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> =20
>  /*
> diff --git a/iothread.c b/iothread.c
> index b805e4f97d..5d6f46d286 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -44,6 +44,12 @@ static void iothread_ref(IOThread *iothread, const cha=
r *holder)
>      }
> =20
>      iothread->holders =3D g_list_prepend(iothread->holders, h);
> +
> +    /*
> +     * This guarantees that the IOThread and its AioContext remain alive
> +     * as long as there is a holder.
> +     */
> +    object_ref(OBJECT(iothread));
>  }
> =20
>  static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> @@ -83,6 +89,8 @@ static void iothread_unref(IOThread *iothread, const ch=
ar *holder)
>      IoThreadHolder *h =3D (IoThreadHolder *)link->data;
>      qapi_free_IoThreadHolder(h);
>      iothread->holders =3D g_list_delete_link(iothread->holders, link);
> +
> +    object_unref(OBJECT(iothread));
>  }
> =20
>  static void *iothread_run(void *opaque)
> @@ -200,7 +208,7 @@ static void iothread_init_gcontext(IOThread *iothread=
, const char *thread_name)
>      g_autofree char *name =3D g_strdup_printf("%s aio-context", thread_n=
ame);
> =20
>      iothread->worker_context =3D g_main_context_new();
> -    source =3D aio_get_g_source(iothread_get_aio_context(iothread));
> +    source =3D aio_get_g_source(iothread->ctx);
>      g_source_set_name(source, name);
>      g_source_attach(source, iothread->worker_context);
>      g_source_unref(source);
> @@ -419,13 +427,30 @@ char *iothread_get_id(IOThread *iothread)
> =20
>  AioContext *iothread_get_aio_context(IOThread *iothread)
>  {
> -    /* Remove in next patch for build */
> -    iothread_ref(iothread, "tmp");
> -    iothread_unref(iothread, "tmp");
> +    return iothread->ctx;
> +}
> +
> +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> +                                             const char *holder)
> +{
> +    /*
> +     * In some cases, iothread user need the ctx to clearup other resour=
ce.
> +     * When holder is empty, back to the legacy way.

Let's avoid referring to the legacy way. Developers working on the code
after this series has been merged may not know what the legacy way was.=20

If an API to fetch iothread->ctx without taking a reference is needed,
then it should probably be a separate API.
iothread_ref_and_get_aio_context() calls should have a matching
iothread_put_aio_context() call. That's not the case when
iothread_ref_and_get_aio_context(iothread, NULL) is allowed.

> +     */
> +    if (holder) {
> +        /* Add holder device path to the list */
> +        iothread_ref(iothread, holder);
> +    }
> =20
>      return iothread->ctx;
>  }
> =20
> +void iothread_put_aio_context(IOThread *iothread, const char *holder)
> +{
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

--gkAxvd6gqo/jOQUn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoCJeYACgkQnKSrs4Gr
c8hUjQf+OE01VuI5Qdjrb9M8KkUnEHJJX1WiFKNRPgld2xUBxaJ3yzVgy/b6kNou
2x9NcPDy1WPVSjaOPsYQGtTmrUdCO25pi6w1fm4XDA8AW/MVBrz8MfCCzhM1NOnW
r0eTLoAGf3xGpMbabpsayJbrh62Y7iUmM+Bt9sXaOsaOqCWUNKUH+h3TfII8sVIx
r2qMkvonvd/gysnENHgb/fBUv5Vx/br2HXAcoO9Qv17zIqVIgWPtCbQzAoOvNL3L
61Kg3sw2wamg1nkyaUvLTIDVtJxhPwi1T9+oIIMQDHTVCk9Ex0KeDSWh0aet8oRT
tS4QyudH7VCKmO+wu+Z25B/ek6QfCA==
=zxx5
-----END PGP SIGNATURE-----

--gkAxvd6gqo/jOQUn--


