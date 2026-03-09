Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3157BEF36F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVN9-00060X-JY; Mon, 09 Mar 2026 03:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVN8-00060P-O7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 03:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzVN5-00015S-58
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 03:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773042585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6t2vZXFBYRyZtMDVP8V4qv14WPv1qlEGKq7oktKWkqM=;
 b=XZLhhVaQXNcemw3sl+EEUAZ2woJdnWmVDdVyho2T8c+HLmupmJUsdCN2eRP590WKQfMduE
 8WE9NH31uet+v7ZdLY+06ucO42yLSDcJaS4j5ZbR8ETucD7dG20IIpTP+egz5N4cl6I9SB
 b1Tk8YVN+l+x5ejEdVQzt1WnNbLSNH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-7Bl0qbJtOwScCShGOd-aeg-1; Mon,
 09 Mar 2026 03:49:41 -0400
X-MC-Unique: 7Bl0qbJtOwScCShGOd-aeg-1
X-Mimecast-MFC-AGG-ID: 7Bl0qbJtOwScCShGOd-aeg_1773042580
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A2E5180034F; Mon,  9 Mar 2026 07:49:40 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD701800671; Mon,  9 Mar 2026 07:49:38 +0000 (UTC)
Date: Mon, 9 Mar 2026 15:49:35 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 02/13] iothread: introduce iothread_ref/unref to track
 attached devices
Message-ID: <20260309074935.GA39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-3-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k8SU7NQ8yA55EHL7"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-3-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--k8SU7NQ8yA55EHL7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:24:48PM +0800, Zhang Chen wrote:
> Currently, IOThreads do not maintain a record of which devices are
> associated with them. This makes it difficult to monitor the
> workload distribution of IOThreads, especially in complex
> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
>=20
> This patch introduces a reference counting and tracking mechanism
> within the IOThread object:
>=20
> - iothread_ref(): Prepends the device's QOM path to a list.
>   Note: The IOThread takes ownership of the passed 'holder' string.

This is outdated, the patch duplicates the string and the caller still
owns the holder argument:

  iothread->holders =3D g_list_prepend(iothread->holders, g_strdup(holder));

> - iothread_unref(): Searches for the device path using a custom
>   string comparison (g_strcmp0), releases the associated memory
>   upon a successful match.
> - holders: A GList storing the QOM paths of attached devices
>   for runtime introspection.
>=20
> This infrastructure allows management tools and QMP commands to
> query the attachment status of IOThreads.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h |  1 +
>  iothread.c                | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index e26d13c6c7..21a76bd70d 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -33,6 +33,7 @@ struct IOThread {
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> +    GList *holders;             /* an array of QOM paths for attached de=
vices */
> =20
>      /* AioContext poll parameters */
>      int64_t poll_max_ns;
> diff --git a/iothread.c b/iothread.c
> index caf68e0764..80a8cf4b32 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -36,6 +36,34 @@
>  #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
>  #endif
> =20
> +/*
> + * Add holder device path to the list.
> + */
> +static void iothread_ref(IOThread *iothread, const char *holder)
> +{
> +    iothread->holders =3D g_list_prepend(iothread->holders, g_strdup(hol=
der));
> +}
> +
> +/*
> + * Delete holder device path from the list.
> + */
> +static void iothread_unref(IOThread *iothread, const char *holder)
> +{
> +    if (iothread->holders) {

g_list_find_customer(NULL, ...) returns NULL rather than crashing, so
there is no need for if (iothread->holders).

> +        GList *link =3D g_list_find_custom(iothread->holders, holder,
> +                                         (GCompareFunc)g_strcmp0);
> +
> +        if (link) {

assert(link) is usually used in QEMU instead. If the reference has
already been released then the program is in an invalid state and it's
not safe to continue running.

Please also add assert(iothread->holders =3D=3D NULL) to
iothread_instance_finalize() so that leaked references are caught.

> +            g_free(link->data);
> +            iothread->holders =3D g_list_delete_link(iothread->holders, =
link);
> +        } else {
> +            error_report("iothread_unref can't find the holder %s", hold=
er);
> +        }
> +    } else {
> +        error_report("iohtread_unref iothread is not held by any devices=
");

iohtread -> iothread

--k8SU7NQ8yA55EHL7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmue48ACgkQnKSrs4Gr
c8jDIwf/djm9zXm4JDGQ4U4hS0l8E82S9eAR0YHEVI2X6K8Xknx02RhOfD1eubvg
U/DpNcntvqQVdkJSfxU7Ifyx5SMYn4PGvU6Ci4W5dRkQFEVLPTdWZ+ATLQKGuWUe
Yol8ljNaXoZEzafU9mBERqfDfWoBjVUMgPFwYsHs77TE8HasbxX1KhIshkSVXoaQ
asYkN3YEs5yEKZF5z4NBvfUc6tXe5R/48WFNQ8sSD9P+dxtFFDfeXOr4zTIonzzm
eYRz1IBDMmyD78zgSzKhPVlK5ZhofYHzKSRvdzOjbuxHe4VHA82tPizUp1UPBGVE
FhD/A/BixFZEFgnRIfFu5Ig7GJVeQg==
=JafH
-----END PGP SIGNATURE-----

--k8SU7NQ8yA55EHL7--


