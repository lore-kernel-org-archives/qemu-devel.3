Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2287ACDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPtD-0006O5-L8; Wed, 24 Jun 2026 11:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcPtB-0006HJ-Et
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcPt9-0000Op-RJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782316302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0wQw3F58kKOwdOP9EEyWiVOpFCJrrB10Xbt5ETReVSM=;
 b=XXObMniFu+qAHfLGnUd9MtTk8JEpCIZ/rk2fSrgVSdf020rsgulcnDHFB6+4rSlV1d3RNH
 XFUbRU2WbcYwcguv+fINwQ2l4udAlrLsjU3+IzBJW1ViDyaZBUobyDW5ttiU4yHHZVRiXG
 VpVWsAQnljN0il2atR00J72E2z5aB1E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-YMVdVaXDP-eNFNvOfzyeGg-1; Wed,
 24 Jun 2026 11:51:40 -0400
X-MC-Unique: YMVdVaXDP-eNFNvOfzyeGg-1
X-Mimecast-MFC-AGG-ID: YMVdVaXDP-eNFNvOfzyeGg_1782316299
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC85A1955E74; Wed, 24 Jun 2026 15:51:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94A7B3000B56; Wed, 24 Jun 2026 15:51:37 +0000 (UTC)
Date: Wed, 24 Jun 2026 11:51:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 02/17] iothread: introduce iothread_ref/unref to track
 attached devices
Message-ID: <20260624155133.GA109308@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-3-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uK51Yeq1TJa2SLW3"
Content-Disposition: inline
In-Reply-To: <20260624070851.13342-3-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--uK51Yeq1TJa2SLW3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 03:08:36PM +0800, Zhang Chen wrote:
> Currently, IOThreads do not maintain a record of which devices are
> associated with them. This makes it difficult to monitor the
> workload distribution of IOThreads, especially in complex
> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
>=20
> This patch introduces a reference counting and tracking mechanism
> within the IOThread object:
>=20
> - iothread_ref(): Prepends the device's IOThreadHolder to a list.
> - iothread_unref(): Searches for the IOThreadHolder using a custom
>   string comparison (g_strcmp0), releases the associated memory
>   upon a successful match.
> - holders: A GList storing the IOThreadHolder of attached devices
>   for runtime introspection.
>=20
> A later commit will add QMP commands to let management applications
> query the attachment status of IOThreads.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h |  5 +++
>  iothread.c                | 94 +++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json            | 61 +++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)

Minor comments below. This patch looks good overall:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index a1ef7696cb..b9207ad829 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -50,6 +50,11 @@ struct IOThread {
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> +    /*
> +     * The list elements are of type IOThreadHolder, which can
> +     * represent either a QOM path or a block node name.

This comment duplicates the IOThreadHolder types and will become
outdated easily. It might already be outdated (there are 3 types, not
just the 2 mentioned in the comment). I suggest replacing it with
something like:

  /* List of iothread_ref() holders (elements are of type IOThreadHolder) */

> +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> +{
> +    const IOThreadHolder *holder_a =3D a;
> +    const IOThreadHolder *holder_b =3D b;
> +    const char *name_a, *name_b;
> +
> +    if (holder_a->type !=3D holder_b->type) {
> +        return -1;
> +    }
> +
> +    switch (holder_a->type) {
> +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +        name_a =3D holder_a->u.qom_object.qom_path;
> +        name_b =3D holder_b->u.qom_object.qom_path;
> +        break;
> +    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> +        name_a =3D holder_a->u.block_node.node_name;
> +        name_b =3D holder_b->u.block_node.node_name;
> +        break;
> +    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> +        name_a =3D holder_a->u.monitor_name.monitor_name;
> +        name_b =3D holder_b->u.monitor_name.monitor_name;
> +        break;
> +    default:
> +       /*
> +        * This should not happen. If it does, name_a/b remains
> +        * NULL and g_strcmp0 will handle it safely.
> +        */
> +        name_a =3D NULL;
> +        name_b =3D NULL;

return -1 would be simpler and safer. g_strcmp0(NULL, NULL) returns 0,
so callers will think they have found a match and proceed with their
operation - it will likely result in undefined behavior since memory is
probably corrupted if we got here. It's safer to fail the comparison so
the caller does not proceed.

--uK51Yeq1TJa2SLW3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo7/QUACgkQnKSrs4Gr
c8h48Qf/ZyUpEoKSTiBlj66hvavvcIyhf2gXLAd4QNjlrG3nMaHQPuAJPrGonYY9
mX/jW1tdpCDoLtrIZa8RyTg8utfglfD6fX8sRQrvKHzbG6mOac5Rvrj/72q2GAwv
RaPJj/5wQhxudnCIRxMEyK7Vm8qwqclSZC9eUMaFj5vUYZz1G7WJGLuZnkjmwPcf
8sRiu5SMRxMO47Q/0jfXgddxrX69OyOrnuDOEj2eDjy8WWMEWntQqJLddbljXYep
LCYA78jLRKWa8fj9rCJQPTUbDrjAs3BZz1FikTTWlO+inwfroiE1knCLs3H1rTrN
o7FZxNhTls9XlE+kuhWE8u+QuTzazA==
=cqgf
-----END PGP SIGNATURE-----

--uK51Yeq1TJa2SLW3--


