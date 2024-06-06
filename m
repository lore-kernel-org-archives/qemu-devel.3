Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29B7C27C5E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 01:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFOk7-00069W-GC; Thu, 06 Jun 2024 21:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sFOk5-00069C-RJ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 21:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sFOk3-0008RD-Ss
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 21:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717725006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ic9lQGgoFrYWYtF+u1FC4PF+SFV5H8fSqxQBE8k+O2c=;
 b=iBXqZe2UfTTclNTWPNKbh0BEFL4dPQbAlxaGkN1VWajFyNZg2Jl5bofox+x+zCfmumEGLl
 KIzT56IW78K9f74BMYzUV5BzaNYtssz702LP/37+lpmZQZXqqdMMimAG30KvJcHiKOhNxd
 +WS68g6JY33ZhfiV+gT3XNxSN1sgi2Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-lEgrEkPiPJ-t0XjnENrCyQ-1; Thu,
 06 Jun 2024 21:50:04 -0400
X-MC-Unique: lEgrEkPiPJ-t0XjnENrCyQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB9671979064; Fri,  7 Jun 2024 01:50:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABEBC1955F14; Fri,  7 Jun 2024 01:50:00 +0000 (UTC)
Date: Thu, 6 Jun 2024 14:36:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com
Subject: Re: [RFC PATCH] migration/savevm: do not schedule
 snapshot_save_job_bh in qemu_aio_context
Message-ID: <20240606183638.GC198201@fedora.redhat.com>
References: <20240605120848.358654-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xDmBIJEJkhaDUdiz"
Content-Disposition: inline
In-Reply-To: <20240605120848.358654-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--xDmBIJEJkhaDUdiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 02:08:48PM +0200, Fiona Ebner wrote:
> The fact that the snapshot_save_job_bh() is scheduled in the main
> loop's qemu_aio_context AioContext means that it might get executed
> during a vCPU thread's aio_poll(). But saving of the VM state cannot
> happen while the guest or devices are active and can lead to assertion
> failures. See issue #2111 for two examples. Avoid the problem by
> scheduling the snapshot_save_job_bh() in the iohandler AioContext,
> which is not polled by vCPU threads.
>=20
> Solves Issue #2111.
>=20
> This change also solves the following issue:
>=20
> Since commit effd60c878 ("monitor: only run coroutine commands in
> qemu_aio_context"), the 'snapshot-save' QMP call would not respond
> right after starting the job anymore, but only after the job finished,
> which can take a long time. The reason is, because after commit
> effd60c878, do_qmp_dispatch_bh() runs in the iohandler AioContext.
> When do_qmp_dispatch_bh() wakes the qmp_dispatch() coroutine, the
> coroutine cannot be entered immediately anymore, but needs to be
> scheduled to the main loop's qemu_aio_context AioContext. But
> snapshot_save_job_bh() was scheduled first to the same AioContext and
> thus gets executed first.
>=20
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2111
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> While initial smoke testing seems fine, I'm not familiar enough with
> this to rule out any pitfalls with the approach. Any reason why
> scheduling to the iohandler AioContext could be wrong here?

If something waits for a BlockJob to finish using aio_poll() from
qemu_aio_context then a deadlock is possible since the iohandler_ctx
won't get a chance to execute. The only suspicious code path I found was
job_completed_txn_abort_locked() -> job_finish_sync_locked() but I'm not
sure whether it triggers this scenario. Please check that code path.

> Should the same be done for the snapshot_load_job_bh and
> snapshot_delete_job_bh to keep it consistent?

In the long term it would be cleaner to move away from synchronous APIs
that rely on nested event loops. They have been a source of bugs for
years.

If vm_stop() and perhaps other operations in save_snapshot() were
asynchronous, then it would be safe to run the operation in
qemu_aio_context without using iohandler_ctx. vm_stop() wouldn't invoke
its callback until vCPUs were quiesced and outside device emulation
code.

I think this patch is fine as a one-line bug fix, but we should be
careful about falling back on this trick because it makes the codebase
harder to understand and more fragile.

>=20
>  migration/savevm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c621f2359b..0086b76ab0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3459,7 +3459,7 @@ static int coroutine_fn snapshot_save_job_run(Job *=
job, Error **errp)
>      SnapshotJob *s =3D container_of(job, SnapshotJob, common);
>      s->errp =3D errp;
>      s->co =3D qemu_coroutine_self();
> -    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
>                              snapshot_save_job_bh, job);
>      qemu_coroutine_yield();
>      return s->ret ? 0 : -1;
> --=20
> 2.39.2

--xDmBIJEJkhaDUdiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZiAbYACgkQnKSrs4Gr
c8hljgf9E3lQXx9tCIwhZJaYEzbOXLQ/szQBwhLxALESFqdyerZzrjJehn8CdttA
5GhPSl7PItMGoV55wxBQJutCi/lt3i4R6HZNM5FawzRgse/y4iMEPvQb1JFa+Btk
L6DIWpUDYRMCw+YDlBDmckRbHQ7tmlx9EYfqhiLN34yUm7Fn3QVk3cFa5dYTBGaW
bi0tfiS1GanN+SC050peVfho8ffD5Mxe09x7a+5es5Gd3HD+X+Pl9z4osX25s/fH
agYCV//tn7MjfIqKvCnNH9w/ypYvh66yA+Yn8MUdThQjkBKMt73WAbJxzfHjDX2P
gtp206XzoTaOJ76+ZCBcLNNXLCGF5g==
=29nG
-----END PGP SIGNATURE-----

--xDmBIJEJkhaDUdiz--


