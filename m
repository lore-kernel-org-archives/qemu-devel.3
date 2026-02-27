Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA7FD7F95
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvwLa-00015J-U6; Fri, 27 Feb 2026 06:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vvwLW-00014i-S2
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:49:27 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vvwLU-0007AY-Ls
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772192953; x=1772797753; i=lukasstraub2@web.de;
 bh=O50O3aP/SdXn3t0noWiON4iX2f0RhlZcU88tJGWreAw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sdTVkCA2SncDqcXFK78K6xElHxS3+3DwcEQTxfspfY5cFe0VQ1GCL9SAwQD1iRN0
 uDwGC2q9Nx9wG5JWH+/J8CghftxAFbNTL2hE+28N9n6ZOwDP1QZTn59HbznxKlRjN
 yAX8eM4d7e86CZBplxfy78v81+jrV7sMeXFmaKfco25LrhMpfTsKkFepQXODtKqWS
 2y57XQ0WSRja6J1AvFwtR5wBIGNg/LzuzSy9RqQNNNywyErpITE2ugavXV2eb6OFl
 PXDsXCJ323q1D8IxHLvnNKluYw2oWAiGJOYYpeUGRNAejDfqfUySF6GCOgJEeT7pK
 cb4bncG2CJhtXkVEDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bYo-1vxaVK3PqY-009juu; Fri, 27
 Feb 2026 12:49:12 +0100
Date: Fri, 27 Feb 2026 12:49:03 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v10 19/19] migration: Always open
 s->rp_state.from_dst_file on the source
Message-ID: <20260227124903.241af498@penguin>
In-Reply-To: <aaBrc4bMxUHhgpH8@x1.local>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
 <20260220-colo_unit_test_multifd-v10-19-bfe67d422ef1@web.de>
 <aaBrc4bMxUHhgpH8@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vVGtmKqDvQOVhCHIBX3Utwd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:d01DCMqd6pZUKCVCOZqjrR0jljMPfWJvL6NB5Fk5qp99GwFcXGE
 /faCXUsCq9jCa9Q1MJYq9IX1PHoZd2W9WJQD96ccF0HhXnnLxYfsUvgNF9SSqJITMkuQXHf
 vRQERHvcs/7PW1vwpz9B8o2JaFEueJJ8fvFYj09d4JUm+eLAU73S/aSzqPYjNCp1bs3ulor
 Mu8fS8A/bklwxLb2NdKrQ==
UI-OutboundReport: notjunk:1;M01:P0:rf3z62h3ruM=;pMnAPLB9nGCWrwJiGrfchUfPgBd
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/vVGtmKqDvQOVhCHIBX3Utwd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Feb 2026 10:49:07 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Feb 20, 2026 at 08:51:41PM +0100, Lukas Straub wrote:
> > qemu_file_get_return_path() can not fail (See also commit 3f9d6e77b)
> > so always open the return path socket on the source. This allows
> > us to reuse the return path in other parts like colo. Also take
> > the proper locks in colo while we're at it.
> >=20
> > This fixes a crash due to a race between migrate_cancel() and
> > the colo thread shutting down.
> >=20
> > Before, the rp socket is opened just before the rp thread is started
> > and closed after it terminates and postcopy fast path is closed.
> > Now it's the same, only the rp socket stays open until migration_cleanu=
p().
> >=20
> > If there is a rp thread, the rp socket is shut down at the end of migra=
tion,
> > but the file is still open. COLO is not compatible with postcopy, so th=
is is
> > safe as no one else uses the rp socket after this point.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  migration/colo.c      | 29 ++++++-------------
> >  migration/migration.c | 77 ++++++++++++++++++++++++-------------------=
--------
> >  2 files changed, 44 insertions(+), 62 deletions(-)
> >=20
> > diff --git a/migration/colo.c b/migration/colo.c
> > index ce02c71d8857d470be434bdf3a9cacad3baab0d5..0dee33f1145b81af276cf31=
8e2984deae9ae0527 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
> >       * The s->rp_state.from_dst_file and s->to_dst_file may use the
> >       * same fd, but we still shutdown the fd for twice, it is harmless.
> >       */
> > -    if (s->to_dst_file) {
> > -        qemu_file_shutdown(s->to_dst_file);
> > -    }
> > -    if (s->rp_state.from_dst_file) {
> > -        qemu_file_shutdown(s->rp_state.from_dst_file);
> > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > +        if (s->to_dst_file) {
> > +            qemu_file_shutdown(s->to_dst_file);
> > +        }
> > +        if (s->rp_state.from_dst_file) {
> > +            qemu_file_shutdown(s->rp_state.from_dst_file);
> > +        } =20
>=20
> Nit: these "start to take mutex for..." changes should belong to a separa=
te
> patch.
>=20

Will do.

> >      }
> > =20
> >      old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,
> > @@ -537,6 +539,7 @@ static void colo_process_checkpoint(MigrationState =
*s)
> >      Error *local_err =3D NULL;
> >      int ret;
> > =20
> > +    assert(s->rp_state.from_dst_file);
> >      if (get_colo_mode() !=3D COLO_MODE_PRIMARY) {
> >          error_report("COLO mode must be COLO_MODE_PRIMARY");
> >          return;
> > @@ -544,12 +547,6 @@ static void colo_process_checkpoint(MigrationState=
 *s)
> > =20
> >      failover_init_state();
> > =20
> > -    s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_dst_=
file);
> > -    if (!s->rp_state.from_dst_file) {
> > -        error_report("Open QEMUFile from_dst_file failed");
> > -        goto out;
> > -    }
> > -
> >      packets_compare_notifier.notify =3D colo_compare_notify_checkpoint;
> >      colo_compare_register_notifier(&packets_compare_notifier);
> > =20
> > @@ -634,16 +631,6 @@ out:
> >      colo_compare_unregister_notifier(&packets_compare_notifier);
> >      timer_free(s->colo_delay_timer);
> >      qemu_event_destroy(&s->colo_checkpoint_event);
> > -
> > -    /*
> > -     * Must be called after failover BH is completed,
> > -     * Or the failover BH may shutdown the wrong fd that
> > -     * re-used by other threads after we release here.
> > -     */
> > -    if (s->rp_state.from_dst_file) {
> > -        qemu_fclose(s->rp_state.from_dst_file);
> > -        s->rp_state.from_dst_file =3D NULL;
> > -    }
> >  }
> > =20
> >  void migrate_start_colo_process(MigrationState *s)
> > diff --git a/migration/migration.c b/migration/migration.c
> > index f36d42ef657bdf26d78ca642d77a9b76e1c0c174..8caa56940beef12de33a799=
695cf486c8fbd471c 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -97,7 +97,7 @@ static GSList *migration_blockers[MIG_MODE__MAX];
> > =20
> >  static bool migration_object_check(MigrationState *ms, Error **errp);
> >  static bool migration_switchover_start(MigrationState *s, Error **errp=
);
> > -static bool close_return_path_on_source(MigrationState *s);
> > +static bool stop_return_path_thread_on_source(MigrationState *s);
> >  static void migration_completion_end(MigrationState *s);
> > =20
> >  static void migration_downtime_start(MigrationState *s)
> > @@ -1278,7 +1278,7 @@ static void migration_cleanup(MigrationState *s)
> >      cpr_state_close();
> >      cpr_transfer_source_destroy(s);
> > =20
> > -    close_return_path_on_source(s);
> > +    stop_return_path_thread_on_source(s);
> > =20
> >      if (s->migration_thread_running) {
> >          bql_unlock();
> > @@ -1307,6 +1307,14 @@ static void migration_cleanup(MigrationState *s)
> >          qemu_fclose(tmp);
> >      }
> > =20
> > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > +        tmp =3D s->rp_state.from_dst_file;
> > +        s->rp_state.from_dst_file =3D NULL;
> > +    }
> > +    if (tmp) {
> > +        qemu_fclose(tmp);
> > +    }
> > +
> >      assert(!migration_is_active());
> > =20
> >      if (s->state =3D=3D MIGRATION_STATUS_CANCELLING) {
> > @@ -2187,38 +2195,6 @@ static bool migrate_handle_rp_resume_ack(Migrati=
onState *s,
> >      return true;
> >  }
> > =20
> > -/*
> > - * Release ms->rp_state.from_dst_file (and postcopy_qemufile_src if
> > - * existed) in a safe way.
> > - */
> > -static void migration_release_dst_files(MigrationState *ms)
> > -{
> > -    QEMUFile *file =3D NULL;
> > -
> > -    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> > -        /*
> > -         * Reset the from_dst_file pointer first before releasing it, =
as we
> > -         * can't block within lock section
> > -         */
> > -        file =3D ms->rp_state.from_dst_file;
> > -        ms->rp_state.from_dst_file =3D NULL;
> > -    }
> > -
> > -    /*
> > -     * Do the same to postcopy fast path socket too if there is.  No
> > -     * locking needed because this qemufile should only be managed by
> > -     * return path thread.
> > -     */
> > -    if (ms->postcopy_qemufile_src) {
> > -        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_=
src);
> > -        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > -        qemu_fclose(ms->postcopy_qemufile_src);
> > -        ms->postcopy_qemufile_src =3D NULL;
> > -    }
> > -
> > -    qemu_fclose(file);
> > -}
> > -
> >  /*
> >   * Handles messages sent on the return path towards the source VM
> >   *
> > @@ -2388,9 +2364,9 @@ out:
> >      return NULL;
> >  }
> > =20
> > -static void open_return_path_on_source(MigrationState *ms)
> > +static void start_return_path_thread_on_source(MigrationState *ms) =20
>=20
> Changing this seems OK, but I'm totally confused why you deleted
> migration_release_dst_files().  That's the helper to properly close the t=
wo
> possible qemufiles that rp thread uses.

Okay, so my reasoning here is:
I think that closing ms->postcopy_qemufile_src is very closely
related to cleaning up the rp thread so I moved that to
stop_return_path_thread_on_source().

Meanwhile I think s->rp_state.from_dst_file is more closely related to
s->to_dst_file and in fact I think we can remove s->rp_state.from_dst_file
entirely in the future and use s->to_dst_file for send *and* receive
just like you would with a normal socket.

So I close s->rp_state.from_dst_file right besides s->to_dst_file in
this patch. And I do the same open-coded file lock dance like
s->to_dst_file already does.

> IIUC you can keep it then use it
> in either postcopy_pause() or migration_cleanup() directly.

I can do that if you wish.
Should I keep closing ms->postcopy_qemufile_src inside
migration_release_dst_files() or stop_return_path_thread_on_source() ?

>=20
> Then you need to remove the chunk [1] below, making the function only do
> "stop" but not close.
>=20
> >  {
> > -    ms->rp_state.from_dst_file =3D qemu_file_get_return_path(ms->to_ds=
t_file);
> > +    assert(ms->rp_state.from_dst_file); =20
>=20
> I don't see why this change is a must, to open from_dst_file earlier.  Can
> we keep it as before, or would you justify it in a separate patch?

Well, the issue is that opening the return path file is behind this if:

 if (migrate_postcopy_ram() || migrate_return_path()) {
-        open_return_path_on_source(s);
+        start_return_path_thread_on_source(s);
 }

And I want to always open the return path file, without also starting
the return path thread.

>=20
> > =20
> >      trace_open_return_path_on_source();
> > =20
> > @@ -2402,7 +2378,7 @@ static void open_return_path_on_source(MigrationS=
tate *ms)
> >  }
> > =20
> >  /* Return true if error detected, or false otherwise */
> > -static bool close_return_path_on_source(MigrationState *ms)
> > +static bool stop_return_path_thread_on_source(MigrationState *ms)
> >  {
> >      if (!ms->rp_state.rp_thread_created) {
> >          return false;
> > @@ -2424,7 +2400,17 @@ static bool close_return_path_on_source(Migratio=
nState *ms)
> > =20
> >      qemu_thread_join(&ms->rp_state.rp_thread);
> >      ms->rp_state.rp_thread_created =3D false;
> > -    migration_release_dst_files(ms);
> > +    /*
> > +     * Close the postcopy fast path socket if there is one.
> > +     * No locking needed because this qemufile should only be managed =
by
> > +     * return path thread which we just stopped.
> > +     */
> > +    if (ms->postcopy_qemufile_src) {
> > +        migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_=
src);
> > +        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > +        qemu_fclose(ms->postcopy_qemufile_src);
> > +        ms->postcopy_qemufile_src =3D NULL;
> > +    } =20
>=20
> [1]
>=20
> >      trace_migration_return_path_end_after();
> > =20
> >      /* Return path will persist the error in MigrationState when quit =
*/
> > @@ -2787,7 +2773,7 @@ static void migration_completion(MigrationState *=
s)
> >          goto fail;
> >      }
> > =20
> > -    if (close_return_path_on_source(s)) {
> > +    if (stop_return_path_thread_on_source(s)) {
> >          goto fail;
> >      }
> > =20
> > @@ -2941,7 +2927,15 @@ static MigThrError postcopy_pause(MigrationState=
 *s)
> >           * path and just wait for the thread to finish. It will be
> >           * re-created when we resume.
> >           */
> > -        close_return_path_on_source(s);
> > +        stop_return_path_thread_on_source(s);
> > +        QEMUFile *rp_file;
> > +        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > +            rp_file =3D s->rp_state.from_dst_file;
> > +            s->rp_state.from_dst_file =3D NULL;
> > +        }
> > +        if (rp_file) {
> > +            qemu_fclose(rp_file);
> > +        } =20
>=20
> Open-code this is going backwards.  Please see if we can reuse
> migration_release_dst_files() at least.
>=20
> Thanks,
>=20
> > =20
> >          /*
> >           * Current channel is possibly broken. Release it.  Note that =
this is
> > @@ -3758,6 +3752,7 @@ void migration_start_outgoing(MigrationState *s)
> >      if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
> >          goto fail;
> >      }
> > +    s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_dst_=
file);
> > =20
> >      /*
> >       * Open the return path. For postcopy, it is used exclusively. For
> > @@ -3765,7 +3760,7 @@ void migration_start_outgoing(MigrationState *s)
> >       * QEMU uses the return path.
> >       */
> >      if (migrate_postcopy_ram() || migrate_return_path()) {
> > -        open_return_path_on_source(s);
> > +        start_return_path_thread_on_source(s);
> >      }
> >
> >
> > =20
> >      /*
> >=20
> > --=20
> > 2.39.5
> >  =20
>=20


--Sig_/vVGtmKqDvQOVhCHIBX3Utwd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmhhK8ACgkQNasLKJxd
sliIpw//YGglmfr6pNdentQvq94NTI+U8Xlxu3wPY/3g6hDB9FoHdXacRhjlXaGo
+/85H5x7E5AKg/DiYfQa37kBma6fz3v+reYrwubtNnT8FkemNw/+iiKbWuVuUJXT
B76I56NcaBD4p4dMtMyRWY6vpXnihtEC4M1wzvOZCzrvkKFg+VpLejzuX5TfQSel
b4fCZKwrN6tzmCLNiqe7OE2w5I6SQF1M+AeiHpHe75uhgfZiZcBwGdgTSiZIIjNP
TH6f2Eq5fqdCdx9XFhTpYKwJGPIodFD3HcWvWFQbjlmZ9cmcBXBuvgwFmO2KTdrV
zpvYvgY+9rurPYWcVepXmu5oGJI+UBU39yoxBMi/nGdH+v0bXk3ifnPVmeHvP9fr
2IdrJQDtqBfFMILMhBHRZxuVIQEIcczWjR3TGHLgu1SVwBCg+v62uInyruSfK+NH
LWtwOgd3kj47Btw+JPUpEy2jSUC1FT5J+1PAbxMFuytBE8+GWsDC3Y25YDjy1Ag0
f7H+Ro3e1riR1vGsHqkSg3iHoFL6XYD098N4oLaLLNf8x/jLkOh28To97pesoza5
jVlfqe9aHwWKly95xirSjj9eUNjE0gTNrwYWBuX8s+gZ0mVRhNJ6wzQOrDU8nnd5
7z6fjUkqlDXIlja+eYvaY97jPTsK5cWIy6+hPyqbNI3aIMeWS+U=
=/VFs
-----END PGP SIGNATURE-----

--Sig_/vVGtmKqDvQOVhCHIBX3Utwd--

