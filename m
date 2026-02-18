Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17725E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoYF-0000rd-6j; Wed, 18 Feb 2026 15:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsoYD-0000rP-Nu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsoYB-00006c-Qs
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771448013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4poF0lYSmiKS2vQGo1O0CqqGVC0n49En/q2f+JQRULE=;
 b=FLsOyXFaOCm8rgyXO8KZrymTGrARWTI6HX/CTak+RQqPHkn/XnIUkOKGmsMv0CQM0NrCvW
 RmqYEMrQf+GuYg627eKG+yK/KcKqRqcujhNyZUsdklj0FC4khAay7GiOnunNsUje1+7rap
 MPl3+WyV/cj9mHNHUORHMbFPNQhBCRM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-6GT_c2YuPlKjNWJ0QbNEQg-1; Wed,
 18 Feb 2026 15:53:31 -0500
X-MC-Unique: 6GT_c2YuPlKjNWJ0QbNEQg-1
X-Mimecast-MFC-AGG-ID: 6GT_c2YuPlKjNWJ0QbNEQg_1771448011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD85A1955D8F; Wed, 18 Feb 2026 20:53:30 +0000 (UTC)
Received: from localhost (unknown [10.2.17.113])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2AD51800670; Wed, 18 Feb 2026 20:53:29 +0000 (UTC)
Date: Wed, 18 Feb 2026 15:53:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V4 2/4] iothread: introduce iothread_ref/unref to track
 attached devices
Message-ID: <20260218205328.GB620422@fedora>
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-2-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uM0gKk5omwSRYePj"
Content-Disposition: inline
In-Reply-To: <20260213171622.55629-2-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--uM0gKk5omwSRYePj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 01:16:20AM +0800, Zhang Chen wrote:
> Currently, IOThreads do not maintain a record of which devices are
> associated with them. This makes it difficult to monitor the
> workload distribution of IOThreads, especially in complex
> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
>=20
> This patch introduces a reference counting and tracking mechanism
> within the IOThread object:
>=20
> - iothread_ref(): Increments the attachment counter and prepends the
>   device's QOM path to a list. Note: The IOThread takes ownership of
>   the passed 'holder' string.
> - iothread_unref(): Searches for the device path using a custom
>   string comparison (g_strcmp0), decrements the counter, and
>   releases the associated memory upon a successful match.
> - attached_cnt: Tracks the number of active device attachments.
> - attached_dev: A GList storing the QOM paths of attached devices
>   for runtime introspection.
>=20
> This infrastructure allows management tools and QMP commands to
> query the attachment status of IOThreads.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h |  4 ++++
>  iothread.c                | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index e26d13c6c7..4a2ffdb9bd 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -33,6 +33,8 @@ struct IOThread {
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> +    int attached_cnt;

Is this field necessary given that the user can see the list of holders?

> +    GList *attached_dev;

IOThreads are general eventloop concept in QEMU and not limited to
device emulation. Non-device code may also wish to add itself (e.g.
block/export/export.c). Please call this GList *holders.

This raises questions:
- Is it mandatory for users of the IOThread's AioContext to add
  themselves?
- How does it relate to object_ref()/object_unref()?

I would prefer to set things up as follows:

It is mandatory for users of the IOThread's AioContext to add
themselves. This is enforced by modifying iothread_get_aio_context() to
take a string argument with the name of the holder.

iothread_get_aio_context() is also extended to call
object_ref(OBJECT(iothread)). This guarantees that the IOThread and its
AioContext remain alive as long as there is a holder. (Some users
already do this themselves, so I think it makes sense to build this
behavior into the API so that all users get it automatically.)

A new iothread_put_aio_context() function is introduced to remove the
hold and object_unref(OBJECT(iothread)).

All existing callers of iothread_get_aio_context() need to be updated to
pass in their QOM object path as the name of the holder, remove their own
object_ref() call (if present), and call iothread_put_aio_context() at
the appropriate point.

> =20
>      /* AioContext poll parameters */
>      int64_t poll_max_ns;
> @@ -48,6 +50,8 @@ char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
>  AioContext *iothread_get_aio_context(IOThread *iothread);
>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> +void iothread_ref(IOThread *iothread, const char* holder);
> +void iothread_unref(IOThread *iothread, const char* holder);
> =20
>  /*
>   * Helpers used to allocate iothreads for internal use.  These
> diff --git a/iothread.c b/iothread.c
> index caf68e0764..b869637497 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -36,6 +36,41 @@
>  #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
>  #endif
> =20
> +/*
> + * Increment iothread's reference count,
> + * and add holder device path to the list.
> + */
> +void iothread_ref(IOThread *iothread, const char *holder)
> +{
> +    iothread->attached_cnt++;
> +    iothread->attached_dev =3D g_list_prepend(iothread->attached_dev,
> +                                           (gpointer)holder);

It's safer to g_strdup(holder) so the caller doesn't need to worry about
the lifetime of the argument. This is not a performance-critical code
path so the cost of the strdup is acceptable.

> +}
> +
> +/*
> + * Decrement iothread's reference count,
> + * and delete holder device path from the list.
> + */
> +void iothread_unref(IOThread *iothread, const char *holder)
> +{
> +    if (iothread->attached_cnt > 0) {
> +        GList *link =3D g_list_find_custom(iothread->attached_dev,
> +                                         holder, (GCompareFunc)g_strcmp0=
);
> +
> +        if (link) {
> +            g_free(link->data);

iothread_ref() originally took a _const_ char * so it must not free the
pointer here. The reason why the compiler didn't complain was because
iothread_ref() cast the pointer to non-const gpointer. In any case, as
mentioned above, it's probably best to use g_strdup() and avoid placing
constraints on the lifetime of the caller's string.

> +            iothread->attached_dev =3D g_list_delete_link(iothread->atta=
ched_dev,
> +                                                        link);
> +            iothread->attached_cnt--;
> +        } else {
> +            error_report("iohtread_unref can't find device. attached_dev=
=3D%s",

"iohtread" typo here and in the line below.

> +                        holder);
> +        }
> +    } else {
> +        error_report("iohtread_unref counter error. attached_dev=3D%s", =
holder);
> +    }
> +}
> +
>  static void *iothread_run(void *opaque)
>  {
>      IOThread *iothread =3D opaque;
> --=20
> 2.49.0
>=20

--uM0gKk5omwSRYePj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmWJsgACgkQnKSrs4Gr
c8gqNggAqJoQ6FaEtdhwXQZLKlVbVs+XT9sUhiWozwtvqqs3F4jLjFWDrJTiEplr
HqYawe0/YoxZ0SwRSDyptOvyGC1poMvO9lqgtC1y6ZMXDgjQge08bXYbIO/ZwPUB
Stzvszpah8L14JVEhmo9s6wMw8N9JhLg8e4DUY5Xq8TXraVMcR6wxZDwXsAMeYW7
qtVnbYf630P8SOoMATcP+KXsK6t6U/LhVogW6UX2BIn0Ttjh89qgoIJwHpuZYKhH
Sz7Fcf4XV7C9+RIzAAWL/CbZZIOHL+6xDPZv6NFi4VsezHSF7urITP97YQH1jUDS
516yHVFFEJ+vW4Fieoqt4LbfEf5O0g==
=wmEm
-----END PGP SIGNATURE-----

--uM0gKk5omwSRYePj--


