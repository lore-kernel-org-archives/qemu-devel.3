Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B73D3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 14:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vScV6-0003Az-HR; Mon, 08 Dec 2025 09:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vScUi-00039m-MM
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 09:45:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vScUf-0004J1-7P
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 09:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765205138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O50U8iM+qcb8sHqdttyE6lkRZWdW7jm/5U28sSqx+08=;
 b=HrCXo6Q3wSY4ITpLyM46eLm1cTfx0gwbVT+mbIk8TO1t7UcmbQ6cZgP3hIoBA4nrNt8UOr
 YgN08loaVnmLRFvZ7sA7ineNzrhmfHPZy2S6xey9y3WVHE835jWfQuK9ptVfL3jqgA2MvC
 I5wRD4GtS5f2JGhG48W+DR5/vhZJblw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-3F4HQ-JONNeSnSA3udRz-g-1; Mon,
 08 Dec 2025 09:45:29 -0500
X-MC-Unique: 3F4HQ-JONNeSnSA3udRz-g-1
X-Mimecast-MFC-AGG-ID: 3F4HQ-JONNeSnSA3udRz-g_1765205128
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BED5A1956064; Mon,  8 Dec 2025 14:45:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1E9E1955F22; Mon,  8 Dec 2025 14:45:26 +0000 (UTC)
Date: Mon, 8 Dec 2025 09:45:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
Message-ID: <20251208144525.GA1341938@fedora>
References: <20251208135101.271417-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PJ0diViTV7/fg9jQ"
Content-Disposition: inline
In-Reply-To: <20251208135101.271417-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--PJ0diViTV7/fg9jQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> When shutting down a guest that is currently in progress of being
> migrated, there is a chance that QEMU might crash during bdrv_delete().
> The backtrace looks like this:
>=20
>  Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
>=20
>  [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
>  0x000002aa00664012 in bdrv_delete (bs=3D0x2aa00f875c0) at ../../devel/qe=
mu/block.c:5560
>  5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
>  (gdb) bt
>  #0  0x000002aa00664012 in bdrv_delete (bs=3D0x2aa00f875c0) at ../../deve=
l/qemu/block.c:5560
>  #1  bdrv_unref (bs=3D0x2aa00f875c0) at ../../devel/qemu/block.c:7170
>  Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
>=20
> The problem is apparently that the migration thread is still active
> (migration_shutdown() only asks it to stop the current migration, but
> does not wait for it to finish), while the main thread continues to
> bdrv_close_all() that will destroy all block drivers. So the two threads
> are racing here for the destruction of the migration-related block driver=
s.
>=20
> I was able to bisect the problem and the race has apparently been introdu=
ced
> by commit c2a189976e211c9ff782 ("migration/block-active: Remove global ac=
tive
> flag"), so reverting it might be an option as well, but waiting for the
> migration thread to finish before continuing with the further clean-ups
> during shutdown seems less intrusive.
>=20
> Note: I used the Claude AI assistant for analyzing the crash, and it
> came up with the idea of waiting for the migration thread to finish
> in migration_shutdown() before proceeding with the further clean-up,
> but the patch itself has been 100% written by myself.

It sounds like the migration thread does not hold block graph refcounts
and assumes the BlockDriverStates it uses have a long enough lifetime.

I don't know the migration code well enough to say whether joining in
migration_shutdown() is okay. Another option would be expicitly holding
the necessary refcounts in the migration thread.

>=20
> Fixes: c2a189976e ("migration/block-active: Remove global active flag")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  migration/migration.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index b316ee01ab2..6f4bb6d8438 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -380,6 +380,16 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opa=
que)
>      qemu_bh_schedule(bh);
>  }
> =20
> +static void migration_thread_join(MigrationState *s)
> +{
> +    if (s && s->migration_thread_running) {
> +        bql_unlock();
> +        qemu_thread_join(&s->thread);
> +        s->migration_thread_running =3D false;
> +        bql_lock();
> +    }
> +}
> +
>  void migration_shutdown(void)
>  {
>      /*
> @@ -393,6 +403,13 @@ void migration_shutdown(void)
>       * stop the migration using this structure
>       */
>      migration_cancel();
> +    /*
> +     * Wait for migration thread to finish to prevent a possible race wh=
ere
> +     * the migration thread is still running and accessing host block dr=
ivers
> +     * while the main cleanup proceeds to remove them in bdrv_close_all()
> +     * later.
> +     */
> +    migration_thread_join(migrate_get_current());
>      object_unref(OBJECT(current_migration));
> =20
>      /*
> @@ -1499,12 +1516,7 @@ static void migration_cleanup(MigrationState *s)
> =20
>      close_return_path_on_source(s);
> =20
> -    if (s->migration_thread_running) {
> -        bql_unlock();
> -        qemu_thread_join(&s->thread);
> -        s->migration_thread_running =3D false;
> -        bql_lock();
> -    }
> +    migration_thread_join(s);
> =20
>      WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>          /*
> --=20
> 2.52.0
>=20

--PJ0diViTV7/fg9jQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmk25IUACgkQnKSrs4Gr
c8i/jgf/WcM/etzwqFyWY40niIUsb/V8bhitXWYw/cMJS7KFYQviku6Q5B2A904L
L4FGhj2L/lXRfkJySVG8m7a21qrUCHeUQNVGggmTs9/ejiquVecZKTKrvc1I9Ajm
ecU0UBKhP4bxg+g0s7v5qiEcQHHHpr7T0NpYS0aNy6dm33EepZzeynbdXNFLcjZW
8UwA6Emc9qaCapgJDbi6HhC2w15ta05ZAsdbK/Kx0UjZ+L78893HV0mo+0dOy8de
JVRadi2sH/Qzy44OE4JAgT4A+YCPiE5ByA8aGv21WJttwnl5rrPJbSUO5xfnpUDu
XB/ley+vGrcwT9YnmhhfUucAClWLWA==
=gwJ3
-----END PGP SIGNATURE-----

--PJ0diViTV7/fg9jQ--


